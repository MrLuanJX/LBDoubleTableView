//
//  LBIndexItemView.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/15.
//

#import <UIKit/UIKit.h>

@interface LBIndexItemView : UIView

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

@property(nonatomic, assign)NSInteger section;
@property(nonatomic, strong)UILabel* titleLabel;
@property(nonatomic, strong)UIColor* schemeColor;

@end
