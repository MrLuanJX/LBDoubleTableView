//
//  LBIndexView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/15.
//

#import "LBIndexView.h"

static NSInteger calloutW = 70;

@interface LBIndexItemView()

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated section:(NSInteger)section type:(NSInteger)type;

@property(nonatomic, assign)NSInteger section;
@property(nonatomic, strong)UILabel* titleLabel;
@property(nonatomic, strong)UIColor* schemeColor;

@end

@implementation LBIndexItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.titleLabel.layer.cornerRadius = LBScreenH/3*2/28/2;
    self.titleLabel.clipsToBounds = YES;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated section:(NSInteger)section type:(NSInteger)type {
    if (type == 1) {
        _titleLabel.highlightedTextColor = section!=0&&section!=1?self.schemeColor?LBUIColorWithRGB(0xFFFFFF, 1):LBUIColorWithRGB(0x228B22, 1):LBUIColorWithRGB(0x228B22, 1);
    } else {
        _titleLabel.highlightedTextColor = self.schemeColor?self.schemeColor:LBUIColorWithRGB(0x228B22, 1);
    }
    
    [_titleLabel setHighlighted:highlighted];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.shadowColor = [UIColor whiteColor];
        _titleLabel.shadowOffset = CGSizeMake(0, 1);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}

@end

@interface LBIndexView()

@property(nonatomic, strong)UIView* bgView;
@property(nonatomic, strong)UILabel* calloutView;
@property(nonatomic, strong)NSMutableArray* itemViewList;
@property(nonatomic, assign)CGFloat itemViewHeight;
@property(nonatomic, assign)NSInteger highlightedItemIndex;
@property(nonatomic, assign)NSInteger lastSelectIndex;

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
// 创建数据源
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
// 布局
- (void)layoutItemViews {
    if (self.itemViewList.count) {
        self.itemViewHeight = LBScreenH/3*2/(CGFloat)(self.itemViewList.count);
    }
    __block CGFloat offsetY = 0.f;
    [self.itemViewList enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        LBIndexItemView *itemView = object;
        [itemView setHighlighted:NO animated:NO section:idx type:self.titleBGViewType];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(offsetY);
            make.width.mas_equalTo(idx==0||idx==1?LBFit(30):self.itemViewHeight);
            make.height.mas_equalTo(self.itemViewHeight);
        }];
        offsetY += self.itemViewHeight;
    }];
}

#pragma mark methods of touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.bgView.hidden = NO;
    UITouch *touch = [touches anyObject];
    // 获取到touch的point
    CGPoint touchPoint = [touch locationInView:self];
    // 遍历indexView的数据源，做点击操作和highlight操作
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
    // 取消所有higlight的item
    [self unhighlightAllItems];
    self.highlightedItemIndex = -1;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesCancelled:touches withEvent:event];
}

- (void)selectItemViewForSection:(NSInteger)section {
    [self highlightItemForSection:section];
    // calloutView
    if (self.isShowCallout) {
        [self setupCalloutView:section];
    }
    // titleBGView颜色变换
    if (self.titleBGViewType == TitleViewTypeForBGView) {
        [self setupTitleBGView:section];
    }
   
    if (_delegate && [_delegate respondsToSelector:@selector(sectionIndexView:didSelectSection:)]) {
        [_delegate sectionIndexView:self didSelectSection:section];
    }
}

- (void)highlightItemForSection:(NSInteger)section {
    [self unhighlightAllItems];
    
    LBIndexItemView *itemView = [self.itemViewList objectAtIndex:section];
    [itemView setHighlighted:YES animated:YES section:section type:self.titleBGViewType];
}

- (void)unhighlightAllItems {
    if (self.isShowCallout) {
        [self.calloutView removeFromSuperview];
        if (self.calloutView) {
            self.calloutView = nil;
        }
    }
    
    [self.itemViewList enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        LBIndexItemView *itemView = object;
        [itemView setHighlighted:NO animated:NO section:idx type:self.titleBGViewType];
    }];
}

- (void)setupCalloutView:(NSInteger)section {
    [self addSubview:self.calloutView];
    if (_dataSource && [_dataSource respondsToSelector:@selector(sectionIndexView:titleForSection:)]) {
        self.calloutView.text = [_dataSource sectionIndexView:self titleForSection:section];
        self.calloutView.font = [UIFont boldSystemFontOfSize:[self.calloutView.text includeChinese]?calloutW/3:calloutW/2];
    }
    // calloutView布局
    if (self.calloutViewType == CalloutViewTypeForDefault) {
        [self.calloutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo((LBIndexItemView*)[self.itemViewList objectAtIndex:section]).offset(-calloutW);
            make.width.mas_equalTo(2*calloutW*sin(M_PI_4));
            make.height.mas_equalTo(calloutW);
            make.centerY.mas_equalTo((LBIndexItemView*)[self.itemViewList objectAtIndex:section]);
        }];
    } else {
        [self.calloutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.superview);
            make.width.height.mas_equalTo(calloutW);
            make.centerY.mas_equalTo((LBIndexItemView*)[self.itemViewList objectAtIndex:section]);
        }];
    }
}

- (void)setupTitleBGView:(NSInteger)section {
    LBIndexItemView* itemView = self.itemViewList[section];
    LBIndexItemView* lastItemView = self.itemViewList[self.lastSelectIndex];
    if (self.lastSelectIndex != section) {
        if (section !=0 && section !=1) {
            itemView.titleLabel.backgroundColor = self.schemeColor?self.schemeColor:LBUIColorWithRGB(0x01ab58, 1);
            itemView.titleLabel.textColor = [UIColor whiteColor];
        }
        lastItemView.titleLabel.backgroundColor = [UIColor clearColor];
        lastItemView.titleLabel.textColor = [UIColor darkGrayColor];
        self.lastSelectIndex = section;
    }
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.clipsToBounds = YES;
        _bgView.layer.cornerRadius = 12.f;
        _bgView.hidden = YES;
    }
    return _bgView;
}

- (UILabel *)calloutView {
    if (!_calloutView) {
        _calloutView = [UILabel new];
        NSArray* arr = [UIColor getRGBWithColor:self.schemeColor];
        UIColor* color = [UIColor colorWithRed:[arr.firstObject doubleValue] green:[arr[1] doubleValue] blue:[arr[2] doubleValue]alpha:[arr.lastObject doubleValue]/2.00];
        if (self.calloutViewType == CalloutViewTypeForDefault) {
            _calloutView.layer.backgroundColor = self.schemeColor?color.CGColor:LBUIColorWithRGB(0xDCDCDC, 1).CGColor;
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            maskLayer.path = [UIBezierPath drawIndicatorPath:calloutW].CGPath;
            _calloutView.layer.mask = maskLayer;
        } else {
            _calloutView.backgroundColor = [UIColor clearColor];
            _calloutView.layer.cornerRadius = calloutW/2;
            _calloutView.layer.borderWidth = 3.0f;
            _calloutView.layer.borderColor = self.schemeColor?color.CGColor:[UIColor lightGrayColor].CGColor;
            _calloutView.layer.shadowColor = self.schemeColor?self.schemeColor.CGColor:[UIColor blackColor].CGColor;
            _calloutView.layer.shadowOpacity = .8;
            _calloutView.layer.shadowRadius = 5.0f;
            _calloutView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        }
        _calloutView.textColor = self.schemeColor?self.schemeColor:LBUIColorWithRGB(0xFFFFFF, 1);
        _calloutView.textAlignment = NSTextAlignmentCenter;
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
