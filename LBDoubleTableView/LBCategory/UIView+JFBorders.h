//
//  UIView+Borders.h
//
//  Created by Aaron Ng on 12/28/13.
//  Copyright (c) 2013 Delve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JFBorders)

/* Create your borders and assign them to a property on a view when you can via the create methods when possible. Otherwise you might end up with multiple borders being created.
 */

///------------
/// Top Border
///------------
-(CALayer*)jf_createTopBorderWithHeight: (CGFloat)height andColor:(UIColor*)color;
-(UIView*)jf_createViewBackedTopBorderWithHeight: (CGFloat)height andColor:(UIColor*)color;
-(void)jf_addTopBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;
-(void)jf_addViewBackedTopBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;


///------------
/// Top Border + Offsets
///------------

-(CALayer*)jf_createTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset;
-(UIView*)jf_createViewBackedTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset;
-(void)jf_addTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset;
-(void)jf_addViewBackedTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset;

///------------
/// Right Border
///------------

-(CALayer*)jf_createRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;
-(UIView*)jf_createViewBackedRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;
-(void)jf_addRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;
-(void)jf_addViewBackedRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;

///------------
/// Right Border + Offsets
///------------

-(CALayer*)jf_createRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
-(UIView*)jf_createViewBackedRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
-(void)jf_addRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
-(void)jf_addViewBackedRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;

///------------
/// Bottom Border
///------------

-(CALayer*)jf_createBottomBorderWithHeight: (CGFloat)height andColor:(UIColor*)color;
-(UIView*)jf_createViewBackedBottomBorderWithHeight: (CGFloat)height andColor:(UIColor*)color;
-(void)jf_addBottomBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;
-(void)jf_addViewBackedBottomBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;

///------------
/// Bottom Border + Offsets
///------------

-(CALayer*)jf_createBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset;
-(UIView*)jf_createViewBackedBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset;
-(void)jf_addBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset;
-(void)jf_addViewBackedBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset;

///------------
/// Left Border
///------------

-(CALayer*)jf_createLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;
-(UIView*)jf_createViewBackedLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;
-(void)jf_addLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;
-(void)jf_addViewBackedLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;

///------------
/// Left Border + Offsets
///------------

-(CALayer*)jf_createLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
-(UIView*)jf_createViewBackedLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
-(void)jf_addLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
-(void)jf_addViewBackedLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;

@end
