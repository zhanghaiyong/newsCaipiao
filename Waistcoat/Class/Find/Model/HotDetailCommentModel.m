//
//  HotDetailCommentModel.m
//  Match
//
//  Created by 张海勇 on 2017/9/30.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "HotDetailCommentModel.h"

@implementation HotDetailCommentModel

-(CGFloat)cellH {
    
    CGFloat H = 60;
    
    CGRect frame = [self.content boundingRectWithSize:CGSizeMake(kDeviceWidth-70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSForegroundColorAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    H += frame.size.height+10;
 
    if (H < 60) {
        H = 60;
    }
    return H;
}

@end
