//
//  MJRefresh+learnBorrow.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/7.
//

#import "MJRefresh+learnBorrow.h"

@interface LBRefresh()

@property(nonatomic, strong) UILabel* topLabel;

@end

@implementation LBRefresh

#pragma mark - 重写父类的方法
- (void)prepare {
    [super prepare];
        
    [self addSubview:self.topLabel];
}

- (void)placeSubviews{
    [super placeSubviews];
    
    self.arrowView.tintColor = [UIColor clearColor];
    self.stateLabel.hidden = YES;
    self.loadingView.hidden = YES;
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (void)setState:(MJRefreshState)state{
    MJRefreshCheckState
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            [self statewithTitle:@"上拉,至下一个分类"];
        } else {
            [self statewithTitle:@"上拉,至下一个分类"];
        }
    } else if (state == MJRefreshStatePulling) {
        [self statewithTitle:@"释放,至下一个分类"];
    } else if (state == MJRefreshStateRefreshing) {
        [self statewithTitle:@"让理想更进一步"];
    } else if (state == MJRefreshStateNoMoreData) {
        [self statewithTitle:@"让理想更进一步"];
    }
}

- (UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textColor = LBUIColorWithRGB(0xA9A9A9, 1.0);
        _topLabel.font = LBFontNameSize(Font_Regular, 15);
    }
    return _topLabel;
}

- (void)statewithTitle:(NSString *)title {
    self.topLabel.text = title;
}
    
@end
