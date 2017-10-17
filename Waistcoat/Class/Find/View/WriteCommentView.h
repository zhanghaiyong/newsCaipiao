//
//  WriteCommentView.h
//  Match
//
//  Created by zhy on 2017/10/13.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteCommentView : UIView
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (nonatomic,copy)void (^cancelReleaseBack)(void);
@property (nonatomic,copy)void (^ReleaseBack)(void);
@end
