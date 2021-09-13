//
//  LBSearchTableView.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/13.
//

#import <UIKit/UIKit.h>

@interface LBSearchTableView : UIView

@property(nonatomic, copy)void(^selectCallback)(NSString* selectText);

@end

