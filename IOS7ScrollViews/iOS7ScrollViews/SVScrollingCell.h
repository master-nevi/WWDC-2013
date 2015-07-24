//
//  SVScrollingCell.h
//  iOS7ScrollViews
//
//  Created by Pierre Felgines on 20/06/13.
//  Copyright (c) 2013 Pierre Felgines. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SVScrollingCellDelegate;

@interface SVScrollingCell : UICollectionViewCell <UIScrollViewDelegate>
@property (nonatomic, assign) id<SVScrollingCellDelegate> delegate;
@property (nonatomic, retain) UIColor * color;
@end

@protocol SVScrollingCellDelegate <NSObject>
- (void)scrollingCellDidBeginPulling:(SVScrollingCell *)cell; //gets called when your finger goes past catchpoint and starts pulling outer scrollview with you
- (void)scrollingCell:(SVScrollingCell *)cell didChangePullOffset:(CGFloat)offset; //gets called when content offset is changed
- (void)scrollingCellDidEndPulling:(SVScrollingCell *)cell; //tell delegate when pulling is ended
@end