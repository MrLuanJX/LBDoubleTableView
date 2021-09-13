//
//  LBCityIndexView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/9.
//

#import "LBCityIndexView.h"
#import "LBCityIndexTableView.h"

@interface LBCityIndexView()

@property(nonatomic, strong)LBCityIndexTableView* cityTableView;
@property(nonatomic, strong)NSMutableArray* dataSource;

@end

@implementation LBCityIndexView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.cityTableView];

    [self.cityTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.offset(0);
        make.top.mas_equalTo(LBkWindow.safeAreaInsets.top>0 ?88:64);
    }];
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    [self.cityTableView setValue:dataSource forKey:@"dataSource"];
}

- (LBCityIndexTableView *)cityTableView {
    if (!_cityTableView) {
        _cityTableView = [LBCityIndexTableView new];
    }
    return _cityTableView;
}

@end
