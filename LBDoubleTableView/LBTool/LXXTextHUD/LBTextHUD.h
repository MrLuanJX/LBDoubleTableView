//
//  LBTextHUD.h
//  LearnBorrow
//
//  Created by 栾金鑫 on 2020/4/1.
//  Copyright © 2020 LearnBorrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBTextHUD : UIView

+ (LBTextHUD*)showInWindowWithDuration:(NSInteger)duration Text:(NSString*)text;
+ (LBTextHUD*)showIn:(UIView*)view text:(NSString*)text;
+ (LBTextHUD*)showIn:(UIView*)view Duration:(NSInteger)duration Text:(NSString*)text;
+ (LBTextHUD *)hideIn:(UIView *)view;
+ (LBTextHUD*)dismiss;
@end


