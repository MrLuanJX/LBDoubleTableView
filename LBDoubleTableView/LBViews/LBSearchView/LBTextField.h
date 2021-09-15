//
//  LBTextField.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/10.
//

#import <UIKit/UIKit.h>

@interface LBTextField : UIView

@property(nonatomic, copy)void(^textFieldCallback)(NSString* textInput);

- (void)tfResignFirstResponder;

@end

