//
//  LBTextHUD.m
//  LearnBorrow
//
//  Created by 栾金鑫 on 2020/4/1.
//  Copyright © 2020 LearnBorrow. All rights reserved.
//

#import "LBTextHUD.h"
#import "LBBorderLabel.h"
#import <Masonry/Masonry.h>

@interface LBTextHUD()

@property(nonatomic, strong)LBBorderLabel* textLabel;
@property(nonatomic, strong)UIView* bgView;

@end

@implementation LBTextHUD

//显示
+ (LBTextHUD*)showIn:(UIView*)view text:(NSString*)text {
    [self hideIn:view];
    LBTextHUD *hud = [[LBTextHUD alloc] initWithFrame:view.bounds];
    hud.userInteractionEnabled = NO;
    hud.textLabel.text = LBNULLString(text)?@"":text;
    [hud shakeToShow:hud];
    [view addSubview:hud];
    return hud;
}

//显示
+ (LBTextHUD*)showIn:(UIView*)view Duration:(NSInteger)duration Text:(NSString*)text {
    [self hideIn:view];
    LBTextHUD *hud = [[LBTextHUD alloc] initWithFrame:view.bounds];
    hud.userInteractionEnabled = NO;
    hud.textLabel.text = LBNULLString(text)?@"":text;
    [hud shakeToShow:hud];
    [view addSubview:hud];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration<=0?2:duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideIn:view];
    });
    
    return hud;
}

+ (LBTextHUD*)showInWindowWithDuration:(NSInteger)duration Text:(NSString*)text {
    [self hideIn:LBkWindow];
    LBTextHUD *hud = [[LBTextHUD alloc] initWithFrame:LBkWindow.bounds];
    hud.userInteractionEnabled = NO;
    hud.textLabel.text = LBNULLString(text)?@"":text;
    [hud shakeToShow:hud];
    [LBkWindow addSubview:hud];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration<=0?2:duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideIn:LBkWindow];
    });
    
    return hud;
}

+ (LBTextHUD*)dismiss {
    LBTextHUD *hud = nil;
    for (LBTextHUD *subView in LBkWindow.subviews) {
        if ([subView isKindOfClass:[LBTextHUD class]]) {
            [UIView animateWithDuration:0.20 animations:^{
                subView.alpha = 0;
                subView.bgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                [subView removeFromSuperview];
            }];
           hud = subView;
        }
    }
    return hud;
}

//隐藏
+ (LBTextHUD *)hideIn:(UIView *)view {
    LBTextHUD *hud = nil;
    for (LBTextHUD *subView in view.subviews) {
        if ([subView isKindOfClass:[LBTextHUD class]]) {
            [UIView animateWithDuration:0.20 animations:^{
                subView.alpha = 0;
                subView.bgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                [subView removeFromSuperview];
            }];
           hud = subView;
        }
    }
    return hud;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.textLabel];
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo (self);
    }];
    
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.textLabel.superview);
        make.bottom.right.mas_equalTo(self.textLabel.superview);
    }];
}

- (LBBorderLabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [LBBorderLabel new];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.font = LBFontNameSize(Font_Regular, 13);
        _textLabel.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _textLabel.numberOfLines = 0;
        _textLabel.preferredMaxLayoutWidth = LBScreenW - LBFit(150);
        _textLabel.text = @"这是一个纯文本的HUD";
        [_textLabel sizeToFit];
    }
    return _textLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.75f];
        _bgView.layer.cornerRadius = 8;
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

/* 显示提示框的动画 */
- (void)shakeToShow:(UIView*)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.05;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7,1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0,1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

- (void)dealloc {
    NSLog(@"dealloc__%@",self.class);
}

@end
