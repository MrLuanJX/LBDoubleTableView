//
//  LBCityIndexView.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/9.
//

#import <UIKit/UIKit.h>

@interface LBCityIndexView : UIView

@property(nonatomic, copy)void(^selectCallback)(NSString* selectText);

@end

