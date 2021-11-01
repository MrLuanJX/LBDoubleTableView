//
//  UILabel+X.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/24.
//

#import "UILabel+X.h"

@implementation UILabel (X)

- (lb_Block)lb_text {
    lb_Block textBlock = ^UILabel*(NSString* text) {
        self.text = text;
        return self;
    };
    return textBlock;
}

- (lb_Block)lb_textColor {
    lb_Block colorBlock = ^UILabel* (UIColor* textColor) {
        self.textColor = textColor;
        return self;
    };
    return colorBlock;
}

- (lb_Block)lb_highlightColor {
    lb_Block highlightColorBlock = ^UILabel* (UIColor* highlightColor) {
        self.highlightedTextColor = highlightColor;
        return self;
    };
    return highlightColorBlock;
}

- (lb_Block)lb_font {
    lb_Block fontBlock = ^UILabel* (UIFont* font) {
        self.font = font;
        return self;
    };
    return fontBlock;
}

- (lb_Block)lb_shadowOffset {
    lb_Block offsetBlock = ^UILabel* (NSValue *value) {
        self.shadowOffset = value.CGSizeValue;
        return self;
    };
    return offsetBlock;
}

- (lb_Block)lb_shadowColor {
    lb_Block shadowColorBlock = ^UILabel* (UIColor* shadowColor) {
        self.shadowColor = shadowColor;
        return self;
    };
    return shadowColorBlock;
}

- (lb_Block)lb_align {
    lb_Block alignBlock = ^UILabel* (NSNumber* num) {
        self.textAlignment = num.integerValue;
        return self;
    };
    return alignBlock;
}

- (lb_Block)lb_numOfLines {
    lb_Block numOfLinesblock = ^UILabel* (NSNumber *num) {
        self.numberOfLines = num.integerValue;
        return self;
    };
    return numOfLinesblock;
}

- (lb_Block)lb_attributedText {
    lb_Block block = ^UILabel *(NSAttributedString *attr) {
        self.attributedText = attr;
        return self;
    };
    return block;
}

- (lb_Block)lb_lineBreakMode {
    lb_Block block = ^UILabel *(NSNumber *mode) {
        self.lineBreakMode = mode.integerValue;
        return self;
    };
    return block;
}

@end
