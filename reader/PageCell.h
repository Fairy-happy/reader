//
//  PageCell.h
//  reader
//
//  Created by fairy on 16/12/26.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageView.h"

static NSString *PageCellIdentifier = @"PageCellIdentifier";

@interface PageCell : UICollectionViewCell

@property (nonatomic, strong) PageView *pageView;

@end
