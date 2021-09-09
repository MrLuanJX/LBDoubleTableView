//
//  LBFoldView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import "LBFoldView.h"
#import "LBFoldBaseTableView.h"

@interface LBFoldView()

@property(nonatomic, strong)NSMutableArray* dataSource;
@property(nonatomic, strong)LBFoldBaseTableView* sectionView;

@end

@implementation LBFoldView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.sectionView];
    [self.sectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.offset(0);
        make.top.mas_equalTo(LBkWindow.safeAreaInsets.top>0 ?88:64);
    }];
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    
    [self.sectionView setValue:dataSource forKey:@"dataSource"];
}

- (LBFoldBaseTableView *)sectionView {
    if (!_sectionView) {
        _sectionView = [LBFoldBaseTableView new];
    }
    return _sectionView;
}


@end
