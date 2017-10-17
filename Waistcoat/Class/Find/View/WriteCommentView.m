//
//  WriteCommentView.m
//  Match
//
//  Created by zhy on 2017/10/13.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "WriteCommentView.h"

@implementation WriteCommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)cancelAction:(id)sender {
    
    if (_cancelReleaseBack) {
        _cancelReleaseBack();
    }
}
- (IBAction)releaseAction:(id)sender {
    
    if (_ReleaseBack) {
        _ReleaseBack();
    }
}

@end
