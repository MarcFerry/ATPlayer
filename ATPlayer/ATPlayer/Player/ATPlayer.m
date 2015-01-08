//
//  ATPlayer.m
//  ATPlayer
//
//  Created by Marc on 08/01/15.
//  Copyright (c) 2015 Asperity. All rights reserved.
//

#import "ATPlayer.h"

#import <AVFoundation/AVFoundation.h>

@interface ATPlayer ()

@property (nonatomic, strong) AVPlayer *mainPlayer;

@end

@implementation ATPlayer

- (void)viewDidLoad {
    [super viewDidLoad];

    AVAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"TEST" ofType:@"mp4"]] options:nil];
    AVPlayerItem *currentItem = [AVPlayerItem playerItemWithAsset:asset];

    self.mainPlayer = [AVPlayer playerWithPlayerItem:currentItem];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.mainPlayer currentItem]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
        
    AVPlayerLayer *avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.mainPlayer];

    avPlayerLayer.frame = CGRectMake(0, 0, 1024, 748);
    [self.view.layer addSublayer:avPlayerLayer];

    [self.mainPlayer play];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];

    [self.mainPlayer play];
}

@end
