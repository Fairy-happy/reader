//
//  NSString+Paging.h
//  reader
//
//  Created by fairy on 16/12/22.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Paging)

-(NSArray *)paginationWithAttributes:(NSDictionary *)attributes constrainedToSize:(CGSize)size;

-(NSString *)halfWidthToFullWidth;

@end
