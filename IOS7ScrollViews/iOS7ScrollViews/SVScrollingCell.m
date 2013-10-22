//
//  SVScrollingCell.m
//  iOS7ScrollViews
//
//  Created by Pierre Felgines on 20/06/13.
//  Copyright (c) 2013 Pierre Felgines. All rights reserved.
//

#import "SVScrollingCell.h"

#define PULL_THRESHOLD 120

@interface SVScrollingCell () {
    UIScrollView * _scrollView;
    UIView * _colorView;
    
    BOOL _pulling;
    BOOL _deceleratingBackToZero;
    CGFloat _decelerationDistanceRatio;
}

@end

@implementation SVScrollingCell

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    
    if (offset > PULL_THRESHOLD && !_pulling) {
        [self.delegate scrollingCellDidBeginPulling:self];
        _pulling = YES;
    }
    
    if (_pulling) {
        CGFloat pullOffset;
        
        if (_deceleratingBackToZero) {
            pullOffset = offset * _decelerationDistanceRatio;
        } else {
            pullOffset = MAX(0, offset - PULL_THRESHOLD);
        }
        
        [self.delegate scrollingCell:self didChangePullOffset:pullOffset];
        _scrollView.transform = CGAffineTransformMakeTranslation(pullOffset, 0);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollingEnded];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollingEnded];
}

- (void)scrollingEnded {
    [self.delegate scrollingCellDidEndPulling:self];
    _pulling = NO;
    _deceleratingBackToZero = NO;
    
    _scrollView.contentOffset = CGPointZero;
    _scrollView.transform = CGAffineTransformIdentity;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    // Not working on iOS6
    // This method is not called when the value of the scroll view’s pagingEnabled property is YES.
    CGFloat offset = _scrollView.contentOffset.x;
    
    if ((*targetContentOffset).x == 0 && offset > 0) {
        _deceleratingBackToZero = YES;
        
        CGFloat pullOffset = MAX(0, offset - PULL_THRESHOLD);
        _decelerationDistanceRatio = pullOffset / offset;
    }
}

#pragma mark - Setup & Layout

- (void)dealloc {
    [_color release];
    [_scrollView release];
    [_colorView retain];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _colorView = [[UIView alloc] init];
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [self.contentView addSubview:_scrollView];
        [_scrollView release];
        
        [_scrollView addSubview:_colorView];
        [_colorView release];
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    if (color != _color) {
        [_color release];
        _color = [color retain];
    }
    _colorView.backgroundColor = color;
}

- (void)layoutSubviews {
    UIView * contentView = self.contentView;
    CGRect bounds = contentView.bounds;
    
    CGFloat pageWidth = bounds.size.width + PULL_THRESHOLD;
    _scrollView.frame = CGRectMake(0, 0, pageWidth, bounds.size.height);
    _scrollView.contentSize = CGSizeMake(pageWidth * 2, bounds.size.height);
    
    _colorView.frame = [_scrollView convertRect:bounds fromView:contentView];
}

@end
