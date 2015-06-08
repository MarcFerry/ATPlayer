//
//  ATPlayerView.h
//  ATPlayer
//
//  Created by Marc on 22/05/15.
//  Copyright (c) 2015 Asperity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  View used for holding video player
 */
@interface ATPlayerView : UIView

+ (Class)layerClass;
- (AVPlayer *)player;
- (void)setPlayer:(AVPlayer *)player;

@end
