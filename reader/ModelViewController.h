//
//  ModelViewController.h
//  reader
//
//  Created by fairy on 16/12/26.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataViewController.h"
#import "ReaderViewController.h"

#define kAdjustFontNotification     @"kAdjustFontNotification"


@interface ModelViewController : NSObject<UIPageViewControllerDataSource>

@property (weak, nonatomic) ReaderViewController *readerController;
@property (strong, nonatomic) NSArray *pageData;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDictionary *attributes;

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index;

- (NSUInteger)indexOfViewController:(DataViewController *)viewController;


@end
