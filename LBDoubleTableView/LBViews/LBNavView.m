//
//  LBNavView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/7.
//

#import "LBNavView.h"

@interface LBNavView ()

@property(nonatomic, strong)UIImageView* bgView;
@property(nonatomic, strong)UIButton* iconBtn;
@property(nonatomic, strong)UILabel* name;
@property (nonatomic ,copy) NSString* titleName;

@end

@implementation LBNavView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDark:) name:@"changeDark" object:nil];
    }
    return self;
}

- (void)changeDark:(NSNotification *)notification {
    NSString *isDarkStr = notification.userInfo[@"isDark"];
    NSArray * colors = [NSArray array];
    colors = [isDarkStr integerValue] == 1 ? @[LBUIColorWithRGB(0x696969, 1.0),LBUIColorWithRGB(0x363636, 1.0)]: @[LBUIColorWithRGB(0xEEC900, 1.0),LBUIColorWithRGB(0xFFA500, 1.0)];
    self.bgView.image = [UIImage lb_createImageWithSize:CGSizeMake(self.width, self.height) gradientColors:colors percentage:@[@0.5,@1.0] gradientType:LBImageGradientFromLeftToRight];
}

- (void)accountImgAction {
    if (self.iconCallback) {
        self.iconCallback();
    }
}

- (void)createUI {
    [self addSubview: self.bgView];
    [self.bgView addSubview: self.iconBtn];
    [self.bgView addSubview: self.name];
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
    
    [self.iconBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(LBFit(20));
        make.top.offset(LBkWindow.safeAreaInsets.top>0 ?44:20);
        make.height.width.mas_equalTo(40);
    }];
    
    [self.name mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo (self.iconBtn.mas_top);
        make.width.mas_equalTo (LBFit(200));
        make.bottom.offset(0);
    }];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.bgView.image = [UIImage lb_createImageWithSize:CGSizeMake(self.width, self.height) gradientColors:@[LBUIColorWithRGB(0x66cc99, 1.0),LBUIColorWithRGB(0x4CB371, 1.0)] percentage:@[@.3,@.7] gradientType:LBImageGradientFromTopToBottom];
}

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [UIImageView new];
    }
    return _bgView;
}

- (UIButton *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [UIButton new];
        [_iconBtn setBackgroundImage:[UIImage imageNamed:@"default_head_icon"] forState:UIControlStateNormal];
        [_iconBtn addTarget:self action:@selector(accountImgAction) forControlEvents:UIControlEventTouchUpInside];
        _iconBtn.alpha = 0;
    }
    return _iconBtn;
}

- (UILabel *)name {
    if (!_name) {
        _name = [UILabel new];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = LBFontNameSize(Font_Regular, 18);
        _name.textColor = LBUIColorWithRGB(0x130101,1.0);
    }
    return _name;
}

- (void)setTitleName:(NSString *)titleName {
    _titleName = titleName;
    self.name.text = titleName;
}

- (void)dealloc {
    NSLog(@"%@_dealloc",self.class);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
