//
//  LBAllSectionChildTableView.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import <UIKit/UIKit.h>

@interface LBAllSectionChildTableView : UIView

- (void)reload;
@property(nonatomic, copy)void(^scrollFinishCallback)(NSInteger scrollIndex);

@end


