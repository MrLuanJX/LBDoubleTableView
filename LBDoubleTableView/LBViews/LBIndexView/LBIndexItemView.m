//
//  LBIndexItemView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/15.
//

#import "LBIndexItemView.h"

@interface LBIndexItemView()

@property(nonatomic, strong)UIView* backgroundView;
@property(nonatomic, strong)UIImageView* backgroundImageView;

@end

@implementation LBIndexItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
    }];
    
//    [self addSubview:self.backgroundView];
//    [self.backgroundView addSubview:self.backgroundImageView];
//    [self.titleLabel addSubview:self.backgroundImageView];
//    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.right.offset(0);
//    }];
//    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.backgroundView);
//    }];
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.backgroundView);
//    }];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    _titleLabel.highlightedTextColor = self.schemeColor?self.schemeColor:LBUIColorWithRGB(0x228B22, 1);
    [_titleLabel setHighlighted:highlighted];
    [_backgroundImageView setHighlighted:highlighted];
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = [UIColor clearColor];
        _backgroundView.clipsToBounds = YES;
        _backgroundView.layer.cornerRadius = 12.f;
    }
    return _backgroundView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.shadowColor = [UIColor whiteColor];
        _titleLabel.shadowOffset = CGSizeMake(0, 1);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
