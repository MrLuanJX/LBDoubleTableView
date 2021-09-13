//
//  LBSearchBtnView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/10.
//

#import "LBSearchBtnView.h"

@interface LBSearchBtnView()

@property(nonatomic, strong)UIButton* searchBtn;

@end

@implementation LBSearchBtnView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
        make.width.mas_equalTo(LBScreenW - 100);
        make.height.mas_equalTo(35);
    }];
}

- (void)searchAction:(UIButton *)sender {
    if (self.searchAction) {
        self.searchAction();
    }
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton new];
        _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [_searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateHighlighted];
        [_searchBtn setTitle:[NSString stringWithFormat:@"%@",@"输入中文/拼音/首字母"] forState:UIControlStateNormal];
        [_searchBtn setTitleColor:LBUIColorWithRGB(0xC3C3C3, 1) forState:UIControlStateNormal];
        _searchBtn.backgroundColor = LBUIColorWithRGB(0x000000, 0.1);
        _searchBtn.titleLabel.font = LBFontNameSize(Font_Bold, 14);
        _searchBtn.layer.cornerRadius = 15;
        _searchBtn.clipsToBounds = YES;
        _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0,15,0,0);
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0,10,0,0);
        [_searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

@end
