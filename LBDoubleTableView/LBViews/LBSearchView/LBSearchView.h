//
//  LBSearchView.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/9.
//

#import <UIKit/UIKit.h>

@interface LBSearchView : UIView

+ (LBSearchView*)showWithDataSource:(NSMutableArray*)dataSource SearchCallback:(void(^)(NSString* searchText))searchCallback;
+ (LBSearchView*)dismiss;

@end

