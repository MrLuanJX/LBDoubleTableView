//
//  LBChildTableView.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBChildTableView : UIView

- (void)reload;
@property(nonatomic, copy)void(^freshFinishCallback)(void);

@end

NS_ASSUME_NONNULL_END
