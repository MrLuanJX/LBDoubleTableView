//
//  LBAllSectionViewController.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import "LBAllSectionViewController.h"
#import "LBAllSectionView.h"

@interface LBAllSectionViewController ()

@property(nonatomic, strong)NSMutableArray* dataArray;
@property(nonatomic, strong)LBAllSectionView* allSectionBaseView;

@end

@implementation LBAllSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    self.title = @"AllSectionView";
}

- (void)createUI {
    [self.view addSubview:self.allSectionBaseView];

    [self.allSectionBaseView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
    
    [self.allSectionBaseView setValue:self.dataArray forKey:@"dataSource"];
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
}

- (LBAllSectionView *)allSectionBaseView {
    if (!_allSectionBaseView) {
        _allSectionBaseView = [LBAllSectionView new];
    }
    return _allSectionBaseView;
}




@end
