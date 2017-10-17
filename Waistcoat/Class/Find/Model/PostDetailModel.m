//
//  PostDetailModel.m
//  Waistcoat
//
//  Created by zhy on 2017/9/15.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "PostDetailModel.h"

@implementation PostDetailModel

-(CGFloat)headHeight {

    CGFloat H = 150;
    
    if (self.imageList.count > 2) {
        
        H += 250*3;
    }else if (self.imageList.count == 2) {
    
        H += 250*2;
        
    }else if (self.imageList.count == 1){
    
        H += 250*1;
    }
    return H;
}

@end
