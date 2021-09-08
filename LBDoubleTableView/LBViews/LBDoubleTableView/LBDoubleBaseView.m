//
//  LBDoubleBaseView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import "LBDoubleBaseView.h"
#import "LBDoubleTableView.h"

@interface LBDoubleBaseView() 

@property(nonatomic, strong)NSMutableArray* dataSource;
@property(nonatomic, strong)LBDoubleTableView* doubleTableView;

@end

@implementation LBDoubleBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview: self.doubleTableView];
    
    [self.doubleTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.top.mas_equalTo(LBkWindow.safeAreaInsets.top>0 ?88:64);
    }];
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    [self.doubleTableView setValue:dataSource forKey:@"dataSource"];
}

- (LBDoubleTableView *)doubleTableView {
    if (!_doubleTableView) {
        _doubleTableView = [LBDoubleTableView new];
    }
    return _doubleTableView;
}
@end
