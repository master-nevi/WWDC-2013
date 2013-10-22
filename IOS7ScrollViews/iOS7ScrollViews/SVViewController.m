//
//  SVViewController.m
//  iOS7ScrollViews
//
//  Created by Pierre Felgines on 20/06/13.
//  Copyright (c) 2013 Pierre Felgines. All rights reserved.
//

#import "SVViewController.h"
#import "SVScrollingCell.h"

static NSString * cellIdentifier = @"CellIdentifier";

@interface SVViewController () <SVScrollingCellDelegate>
@end

CGFloat _random() { return (float)rand() / (float)RAND_MAX;}

@implementation SVViewController

- (void)dealloc {
    [_collectionView release];
    [_flowLayout release];
    [_scrollView release];
    [_otherView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[SVScrollingCell class] forCellWithReuseIdentifier:cellIdentifier];
    self.scrollView.contentSize = CGSizeMake(2 * self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - SVScrollingCellDelegate

- (void)scrollingCellDidBeginPulling:(SVScrollingCell *)cell {
    [self.scrollView setScrollEnabled:NO];
    
    self.otherView.backgroundColor = cell.color;
}

- (void)scrollingCell:(SVScrollingCell *)cell didChangePullOffset:(CGFloat)offset {
    [self.scrollView setContentOffset:CGPointMake(offset, 0)];
}

- (void)scrollingCellDidEndPulling:(SVScrollingCell *)cell {
    [self.scrollView setScrollEnabled:YES];
}


#pragma mark - UICollectionViewDatasource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SVScrollingCell * cell = (SVScrollingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self; 
    
    CGFloat red = _random();
    CGFloat green = _random();
    CGFloat blue = _random();
    cell.color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    return cell;
}

@end
