//
//  LBAllSectionBaseTableView.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import <UIKit/UIKit.h>

@interface LBAllSectionBaseTableView : UIView

@property(nonatomic, copy)void(^didSelectCellCallback)(NSIndexPath* indexPath ,UITableViewCell* currentBaseCell);
@property(nonatomic, strong)UITableView* baseTableView;
- (void)scrollwithIndex:(NSIndexPath *)index;
- (void)reload;

@end


