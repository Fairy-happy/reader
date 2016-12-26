//
//  PageView.h
//  reader
//
//  Created by fairy on 16/12/23.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageView : UIView
@property (nonatomic, copy) NSAttributedString *attributedText;

- (void)setText:(NSAttributedString *)attributedText;
@end
