//
//  UILabel+X.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/24.
//

#import <UIKit/UIKit.h>

typedef UILabel* (^lb_Block)(id);

@interface UILabel (X)

@property(nonatomic, copy, readonly)lb_Block lb_text;
@property(nonatomic, copy, readonly)lb_Block lb_textColor;
@property(nonatomic, copy, readonly)lb_Block lb_font;
@property(nonatomic, copy, readonly)lb_Block lb_shadowOffset;
@property(nonatomic, copy, readonly)lb_Block lb_shadowColor;
@property(nonatomic, copy, readonly)lb_Block lb_highlightColor;
@property(nonatomic, copy, readonly)lb_Block lb_align;
@property(nonatomic, copy, readonly)lb_Block lb_numOfLines;
@property(nonatomic, copy, readonly)lb_Block lb_attributedText;
@property(nonatomic, copy, readonly)lb_Block lb_lineBreakMode;




@end
