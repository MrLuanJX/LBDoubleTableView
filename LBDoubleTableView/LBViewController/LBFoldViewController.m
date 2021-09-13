//
//  LBFoldViewController.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import "LBFoldViewController.h"
#import "LBFoldView.h"

@interface LBFoldViewController ()

@property(nonatomic, strong)LBFoldView* foldView;
@property(nonatomic, strong)NSMutableArray* dataArray;

@end

@implementation LBFoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.title = @"FlodView";
}

- (void)createUI {
    [self.view addSubview:self.foldView];
    
    [self.foldView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.foldView setValue:dataArray forKey:@"dataSource"];
}

- (LBFoldView *)foldView {
    if (!_foldView) {
        _foldView = [LBFoldView new];
    }
    return _foldView;
}

@end
