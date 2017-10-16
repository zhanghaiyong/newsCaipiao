//
//  SegmentView.h
//  Waistcoat
//
//  Created by zhy on 2017/9/14.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentTitleView : UIView
@property (nonatomic,strong)void (^tapLabBack)(NSInteger index);
@property (nonatomic,assign)BOOL hiddenLine;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)ts;
@end
