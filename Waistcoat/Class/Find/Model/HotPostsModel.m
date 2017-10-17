//
//  HotPostsModel.m
//  Waistcoat
//
//  Created by zhy on 2017/9/15.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "HotPostsModel.h"

@implementation HotPostsModel

-(CGFloat)cellHeight {
 
    CGFloat H = 92;
    
    if (self.imageList.count > 1) {
        
        H += 100;
    }else if (self.imageList.count == 1){
    
        H += 140;
    }
    return H;
    
}

@end
