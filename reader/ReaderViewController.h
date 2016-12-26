//
//  ReaderViewController.h
//  reader
//
//  Created by fairy on 16/12/15.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReaderViewController : UIViewController<UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) UICollectionView *collectionView;

- (void)loadText:(NSString *)text;

@end

@protocol FontAdjustViewDelegate <NSObject>

- (void)adjustRangeArrayForText;

@end

@interface FontAdjustView : UIView
@property (nonatomic, weak) id<FontAdjustViewDelegate>delegate;

@property (nonatomic, strong) UIButton *plusButton;
@property (nonatomic, strong) UIButton *minusButton;


@end
