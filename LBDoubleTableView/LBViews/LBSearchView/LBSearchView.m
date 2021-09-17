//
//  LBSearchView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/9.
//

#import "LBSearchView.h"
#import "LBTextField.h"
#import "LBSearchTableView.h"

@interface LBSearchView() <UIGestureRecognizerDelegate>

@property(nonatomic, strong)UIView* navView;
@property(nonatomic, strong)UIButton* cancelBtn;
@property(nonatomic, strong)LBTextField* textFieldView;
@property(nonatomic, strong)LBSearchTableView* searchTableView;
@property(nonatomic, copy)void(^searchCallback)(NSString* searchText);
@property(nonatomic, strong)NSMutableArray* dataSource;
@property(nonatomic, strong)NSMutableArray* searchArray;

@end

@implementation LBSearchView

+ (LBSearchView*)showWithDataSource:(NSMutableArray*)dataSource SearchCallback:(void(^)(NSString* searchText))searchCallback {
    [self dismiss];
    LBSearchView *hud = [[LBSearchView alloc] initWithFrame:LBkWindow.bounds];
    hud.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.65f];
    hud.userInteractionEnabled = YES;
    hud.searchCallback = searchCallback;
    hud.dataSource = dataSource;
    UITapGestureRecognizer*pan = [[UITapGestureRecognizer alloc] initWithTarget:hud action:@selector(touchUpbgView)];
    pan.delegate = hud;
    [hud addGestureRecognizer:pan];
    
    [LBkWindow addSubview:hud];
    
    return hud;
}

+ (LBSearchView*)dismiss {
    LBSearchView *hud = nil;
    for (LBSearchView *subView in LBkWindow.subviews) {
        if ([subView isKindOfClass:[LBSearchView class]]) {
            [UIView animateWithDuration:0.20 animations:^{
                subView.alpha = 0;
            } completion:^(BOOL finished) {
                [subView removeFromSuperview];
            }];
           hud = subView;
        }
    }
    return hud;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self createUI];
        [self textFieldCallback];
        [self tableViewDidSelectCallback];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.navView];
    [self addSubview:self.searchTableView];
    [self.navView addSubview:self.textFieldView];
    [self.navView addSubview:self.cancelBtn];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.offset(0);
        make.height.mas_equalTo(LBkWindow.safeAreaInsets.top>0?88:64);
    }];
    [self.searchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.offset(0);
        make.top.mas_equalTo(self.navView.mas_bottom);
    }];
    [self.textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-5);
        make.left.offset(10);
        make.right.offset(-60);
        make.height.mas_equalTo(35);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.textFieldView);
        make.right.offset(-10);
        make.left.mas_equalTo(self.textFieldView.mas_right).offset(10);
        make.height.mas_equalTo(35);
    }];
}

#pragma mark-手势代理，解决和tableview点击发生的冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了 return NO;//关闭手势 }//否则手势存在 return YES;
        // 收键盘
        [self.textFieldView tfResignFirstResponder];
        
        return NO;
    }
    return YES;
}

- (void)textFieldCallback {
    LBWeakSelf(self);
    self.textFieldView.textFieldCallback = ^(NSString *textInput) {
        LBStrongSelf(self);
        [self setSearchWithInputText:textInput];
    };
}

- (void)tableViewDidSelectCallback {
    LBWeakSelf(self);
    self.searchTableView.selectCallback = ^(NSString *selectText) {
        LBStrongSelf(self);
        [self.textFieldView setValue:selectText forKey:@"lastText"];
        [self setSearchWithInputText:selectText];
        if (self.searchCallback) {
            self.searchCallback(selectText);
        }
    };
}
// 搜索input实时搜索
- (void)setSearchWithInputText:(NSString *)inputText {
    if (inputText.length > 0) {     // 这里判断length要大于0，是因为汉字转拼音的方法不能传空值
        [self.searchArray removeAllObjects];
        // length大于1，进行数据对比
        if ([NSString transform:inputText].length > 1) {
            // 循环所有数据
            [self.dataSource enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
                NSDictionary* dict = object;
                // firstText A~Z字母
                NSString* firstText = dict[@"cityId"];
                // 输入的（汉字转拼音）首字母是否属于A～Z之间 并拼接数据存入搜索数组searchArray中
                if ([[NSString FirstCharactor:inputText] isEqualToString:firstText]) {
                    NSMutableDictionary* tempDict = @{}.mutableCopy;
                    NSMutableArray* tempArr = @[].mutableCopy;
                    tempDict[@"cityId"] = firstText;
                    // 遍历所有城市的数组
                    [dict[@"cityName"] enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
                        NSString* cityName = object;
                        // 所有城市的拼音包含输入的拼音，就是符合的数据，存入搜索的数组中
                        if ([[NSString transform:cityName] containsString:[NSString transform:inputText]]) {
                            [tempArr addObject:cityName];
                        }
                    }];
                    tempDict[@"cityName"] = tempArr;
                    [self.searchArray addObject:tempDict];
                }
            }];
        }
        self.searchTableView.alpha = [NSString transform:inputText].length>1?1:0;
        [self.searchTableView setValue:self.searchArray forKey:@"dataSource"];
    } else {
        self.searchTableView.alpha = 0;
    }
}

- (void)touchUpbgView {
    [self cancelAction];
}

- (void)cancelAction {
    [LBSearchView dismiss];
}

- (UIView *)navView {
    if (!_navView) {
        _navView = [UIView new];
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (NSMutableArray *)searchArray {
    if (!_searchArray) {
        _searchArray = @[].mutableCopy;
    }
    return _searchArray;
}

- (LBTextField *)textFieldView {
    if (!_textFieldView) {
        _textFieldView = [LBTextField new];
        _textFieldView.layer.cornerRadius = 35/2;
        _textFieldView.clipsToBounds = YES;
        _textFieldView.backgroundColor = LBUIColorWithRGB(0x000000, 0.1);
    }
    return _textFieldView;
}

- (LBSearchTableView *)searchTableView {
    if (!_searchTableView) {
        _searchTableView = [LBSearchTableView new];
        _searchTableView.backgroundColor = [UIColor clearColor];
        _searchTableView.alpha = 0;
    }
    return _searchTableView;
}

- (UIButton *)cancelBtn {
    if(!_cancelBtn) {
        _cancelBtn = [UIButton new];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:LBUIColorWithRGB(0x4169E1, 1) forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:LBUIColorWithRGB(0x4169E1, .3) forState:UIControlStateHighlighted];
        _cancelBtn.titleLabel.font = LBFontNameSize(Font_Regular, 16);
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end
