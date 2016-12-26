//
//  CollectViewModel.h
//  reader
//
//  Created by fairy on 16/12/26.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectViewModel : NSObject<UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSDictionary *attributes;


@end
