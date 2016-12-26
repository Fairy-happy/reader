//
//  ModelViewController.m
//  reader
//
//  Created by fairy on 16/12/26.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import "ModelViewController.h"
#import "GlobalModel.h"
@implementation ModelViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        // Create the data model.
    }
    return self;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index {
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController = [[DataViewController alloc] init];
    dataViewController.dataObject = [self.text substringWithRange:NSRangeFromString(self.pageData[index])];
    dataViewController.attributes = self.attributes;
    dataViewController.currentPage = index;
    dataViewController.totalPage = [self.pageData count];
    [GlobalModel shareModel].currentPage = index;
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:NSStringFromRange([self.text rangeOfString:viewController.dataObject])];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    [GlobalModel shareModel].currentRange = NSRangeFromString(self.pageData[index]);
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    [GlobalModel shareModel].currentRange = NSRangeFromString(self.pageData[index]);
    return [self viewControllerAtIndex:index];
}


@end
