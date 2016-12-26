//
//  DataViewController.h
//  reader
//
//  Created by fairy on 16/12/26.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageView.h"
@interface DataViewController : UIViewController

@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) NSDictionary *attributes;
@property (strong, nonatomic) PageView *pageView;
@property (strong, nonatomic) UILabel *progressLabel;
@property (strong, nonatomic) UILabel *timeLabel;

@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger totalPage;

@end
