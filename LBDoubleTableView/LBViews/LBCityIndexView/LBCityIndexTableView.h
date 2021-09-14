//
//  LBCityIndexTableView.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/9.
//

#import <UIKit/UIKit.h>

@interface LBCollectionCell : UICollectionViewCell

@end

@interface LBHistoryCell : UITableViewCell

@property(nonatomic, copy)void(^collectionCallback)(NSString* selectText,NSInteger collectionSelectIndex,NSIndexPath* index);

@end

@interface LBCityCell : UITableViewCell

@end

@interface LBCityIndexTableView : UIView

@property(nonatomic, copy)void(^selectCallback)(NSString* selectText);

@end

