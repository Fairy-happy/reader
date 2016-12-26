//
//  CollectViewModel.m
//  reader
//
//  Created by fairy on 16/12/26.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import "CollectViewModel.h"
#import "PageCell.h"
#import "GlobalModel.h"
@implementation CollectViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PageCellIdentifier forIndexPath:indexPath];
    NSString *subText = [self.text substringWithRange:NSRangeFromString(self.dataArray[indexPath.row])];
    [cell.pageView setText:[[NSAttributedString alloc] initWithString:subText attributes:self.attributes]];
    
    return cell;
}


@end
