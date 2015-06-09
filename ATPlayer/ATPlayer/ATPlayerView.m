//
//  ATPlayerView.m
//  ATPlayer
//
//  Created by Marc on 22/05/15.
//  Copyright (c) 2015 Asperity. All rights reserved.
//

#import "ATPlayerView.h"

@interface ATPlayerView ()

/**
 *  Main player
 */
@property (nonatomic, strong) AVPlayer *player;

@end
 
@implementation ATPlayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
    [(AVPlayerLayer *)[self layer] setVideoGravity:AVLayerVideoGravityResizeAspect];
    // Force audio in mute mode
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
                                           error:&error];
}

@end
