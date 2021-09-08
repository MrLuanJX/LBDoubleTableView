//
//  LBDoubleTableViewController.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import "LBDoubleTableViewController.h"
#import "LBDoubleBaseView.h"

@interface LBDoubleTableViewController ()

@property(nonatomic, strong)NSMutableArray* dataArray;
@property(nonatomic, strong)LBDoubleBaseView* doubleBaseView;

@end

@implementation LBDoubleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    self.title = @"DoubleView";
}

- (void)createUI {
    [self.view addSubview:self.doubleBaseView];

    [self.doubleBaseView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
    
    [self.doubleBaseView setValue:self.dataArray forKey:@"dataSource"];
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
}

- (LBDoubleBaseView *)doubleBaseView {
    if (!_doubleBaseView) {
        _doubleBaseView = [LBDoubleBaseView new];
    }
    return _doubleBaseView;
}


@end
