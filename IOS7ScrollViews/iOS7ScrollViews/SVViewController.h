//
//  SVViewController.h
//  iOS7ScrollViews
//
//  Created by Pierre Felgines on 20/06/13.
//  Copyright (c) 2013 Pierre Felgines. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVViewController : UIViewController <UICollectionViewDataSource>

@property (retain, nonatomic) IBOutlet UIScrollView * scrollView;
@property (retain, nonatomic) IBOutlet UIView * otherView;
@property (retain, nonatomic) IBOutlet UICollectionView * collectionView;
@property (retain, nonatomic) IBOutlet UICollectionViewFlowLayout * flowLayout;

@end
