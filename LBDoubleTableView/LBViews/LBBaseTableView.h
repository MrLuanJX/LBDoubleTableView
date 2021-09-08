//
//  LBBaseTableView.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/7.
//

#import <UIKit/UIKit.h>

@interface LBBaseTableView : UIView

@property(nonatomic, copy)void(^didSelectCellCallback)(NSIndexPath* indexPath ,UITableViewCell* currentBaseCell);
@property(nonatomic, strong)UITableView* baseTableView;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)reload;

@end

