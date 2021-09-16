//
//  LBIndexView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/15.
//

#import "LBIndexView.h"
#import "LBIndexItemView.h"

static NSInteger calloutW = 88;

@interface LBIndexView()

@property(nonatomic, strong)UIView* bgView;
@property(nonatomic, strong)UILabel* calloutView;

@property(nonatomic, strong)NSMutableArray* itemViewList;
@property(nonatomic, assign)CGFloat itemViewHeight;
@property(nonatomic, assign)NSInteger highlightedItemIndex;
@end

@implementation LBIndexView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.isShowCallout = YES;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
}

- (void)reloadIndexView {
    NSInteger numberOfItems = 0;
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfItemViewForSectionIndexView:)]) {
        numberOfItems = [_dataSource numberOfItemViewForSectionIndexView:self];
    }
    for (int i = 0; i < numberOfItems; i++) {
        if (_dataSource && [_dataSource respondsToSelector:@selector(sectionIndexView:titleForSection:)]) {
            LBIndexItemView* itemView = [LBIndexItemView new];
            itemView.section = i;
            itemView.titleLabel.text = [_dataSource sectionIndexView:self titleForSection:i];
            itemView.schemeColor = self.schemeColor?self.schemeColor:LBUIColorWithRGB(0x228B22, 1);
            [self.itemViewList addObject:itemView];
            [self addSubview:itemView];
        }
    }
    [self layoutItemViews];
}

- (void)layoutItemViews {
    if (self.itemViewList.count) {
      self.itemViewHeight = LBScreenH/3*2/(CGFloat)(self.itemViewList.count);
    }
    CGFloat offsetY = 0.f;
    for (UIView *itemView in self.itemViewList) {
        itemView.frame = CGRectMake(0, offsetY, LBFit(30), self.itemViewHeight);
        offsetY += self.itemViewHeight;
    }
}

#pragma mark methods of touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.bgView.hidden = NO;
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    for (LBIndexItemView *itemView in self.itemViewList) {
        if (CGRectContainsPoint(itemView.frame, touchPoint)) {
            [self selectItemViewForSection:itemView.section];
            self.highlightedItemIndex = itemView.section;
            return;
        }
    }
    self.highlightedItemIndex = -1;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    self.bgView.hidden = NO;
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    for (LBIndexItemView *itemView in self.itemViewList) {
        if (CGRectContainsPoint(itemView.frame, touchPoint)) {
            if (itemView.section != self.highlightedItemIndex) {
                [self selectItemViewForSection:itemView.section];
                self.highlightedItemIndex = itemView.section;
                return;
            }
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.bgView.hidden = YES;
    [self unhighlightAllItems];
    self.highlightedItemIndex = -1;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesCancelled:touches withEvent:event];
}

- (void)selectItemViewForSection:(NSInteger)section {
    [self highlightItemForSection:section];
    if (self.isShowCallout) {
        if (_dataSource && [_dataSource respondsToSelector:@selector(sectionIndexView:titleForSection:)]) {
            self.calloutView.text = [_dataSource sectionIndexView:self titleForSection:section];
            self.calloutView.font = [self.calloutView.text includeChinese]?[UIFont boldSystemFontOfSize:26]:[UIFont boldSystemFontOfSize:36];
        }
        [self.superview addSubview:self.calloutView];
        [self.calloutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0); // mas_equalTo((LBIndexItemView*)[self.itemViewList objectAtIndex:section]).offset(-70);//
            make.width.height.mas_equalTo(calloutW);
            make.centerY.mas_equalTo((LBIndexItemView*)[self.itemViewList objectAtIndex:section]);
        }];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(sectionIndexView:didSelectSection:)]) {
        [_delegate sectionIndexView:self didSelectSection:section];
    }
}

- (void)highlightItemForSection:(NSInteger)section {
    [self unhighlightAllItems];
    
    LBIndexItemView *itemView = [self.itemViewList objectAtIndex:section];
    [itemView setHighlighted:YES animated:YES];
}

- (void)unhighlightAllItems {
    if (self.isShowCallout) {
        [self.calloutView removeFromSuperview];
        if (self.calloutView) {
            self.calloutView = nil;
        }
    }
    for (LBIndexItemView *itemView in self.itemViewList) {
        [itemView setHighlighted:NO animated:NO];
    }
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.clipsToBounds = YES;
        _bgView.layer.cornerRadius = 12.f;
        _bgView.backgroundColor = [UIColor clearColor];
        [_bgView setHidden:YES];
    }
    return _bgView;
}

- (UILabel *)calloutView {
    if (!_calloutView) {
        _calloutView = [UILabel new];
        _calloutView.backgroundColor = [UIColor clearColor];
        _calloutView.textColor = self.schemeColor?self.schemeColor:LBUIColorWithRGB(0x228B22, 1);
        _calloutView.textAlignment = NSTextAlignmentCenter;
        [_calloutView.layer setCornerRadius:calloutW/2];
        [_calloutView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [_calloutView.layer setBorderWidth:3.0f];
        [_calloutView.layer setShadowColor:[UIColor blackColor].CGColor];
        [_calloutView.layer setShadowOpacity:0.8];
        [_calloutView.layer setShadowRadius:5.0];
        [_calloutView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    }
    return _calloutView;
}

- (NSMutableArray *)itemViewList {
    if (!_itemViewList) {
        _itemViewList = @[].mutableCopy;
    }
    return _itemViewList;
}

@end
