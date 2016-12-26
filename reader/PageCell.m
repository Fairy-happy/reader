//
//  PageCellCollectionViewCell.m
//  reader
//
//  Created by fairy on 16/12/26.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import "PageCell.h"

@implementation PageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.pageView];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_pageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageView)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_pageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageView)]];
    }
    return self;
}

#pragma mark - lazy loading

- (PageView *)pageView
{
    if (!_pageView) {
        _pageView = [[PageView alloc] init];
        _pageView.translatesAutoresizingMaskIntoConstraints = NO;
        _pageView.backgroundColor = [UIColor whiteColor];
    }
    return _pageView;
}


@end
