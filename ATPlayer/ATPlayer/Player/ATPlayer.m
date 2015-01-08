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

    [self.view setClipsToBounds:YES];

    AVAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:@"http://techslides.com/demos/sample-videos/small.mp4"] options:nil];
//    AVAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"TEST" ofType:@"mp4"]] options:nil];
    AVPlayerItem *currentItem = [AVPlayerItem playerItemWithAsset:asset];

    self.mainPlayer = [AVPlayer playerWithPlayerItem:currentItem];

    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(tappedVideo:)];
    [self.view addGestureRecognizer:tap];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.mainPlayer currentItem]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
        
    AVPlayerLayer *avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.mainPlayer];

    avPlayerLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:avPlayerLayer];

    [self.mainPlayer play];
}

- (void)tappedVideo:(UITapGestureRecognizer *)gesture {
    if (self.mainPlayer.rate > 0 && !self.mainPlayer.error) {
        [self.mainPlayer pause];
    } else {
        [self.mainPlayer play];
    }
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];

    [self.mainPlayer play];
}

@end
