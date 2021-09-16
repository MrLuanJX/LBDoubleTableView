//
//  LBIndexView.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/15.
//

#import <UIKit/UIKit.h>
@class LBIndexView;

@protocol LBIndexViewDataSource <NSObject>
// 返回一共多少个section
- (NSInteger)numberOfItemViewForSectionIndexView:(LBIndexView *)sectionIndexView;
// 返回每个section的title
- (NSString *)sectionIndexView:(LBIndexView *)sectionIndexView
               titleForSection:(NSInteger)section;
@end

@protocol LBIndexViewDelegate <NSObject>
// 点击IndexItemView事件
- (void)sectionIndexView:(LBIndexView *)sectionIndexView
        didSelectSection:(NSInteger)section;

@end

typedef enum {
    CalloutViewTypeForDefault,
    CalloutViewTypeForSuspen
}LBCalloutViewType;

@interface LBIndexItemView : UIView

@end

@interface LBIndexView : UIView

@property(nonatomic, weak)id<LBIndexViewDataSource>dataSource;
@property(nonatomic, weak)id<LBIndexViewDelegate>delegate;

// 是否显示选中提示图，默认是YES
@property(nonatomic, assign)BOOL isShowCallout;
// 选中提示图的样式
@property(nonatomic, assign)NSInteger calloutViewType;
// 提示图的主题色
@property(nonatomic, strong)UIColor* schemeColor;

- (void)reloadIndexView;


@end

