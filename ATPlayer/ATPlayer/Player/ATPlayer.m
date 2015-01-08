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

@property (nonatomic, strong) AVPlayer          *player;
@property (nonatomic, strong) AVPlayerLayer     *playerLayer;
@property (nonatomic, strong) NSURL             *videoURL;

@end

@implementation ATPlayer

/**************************************************************************************************/
#pragma mark - Init methods

- (instancetype)initWithContentURL:(NSURL *)contentURL {
    self.videoURL = contentURL;

    AVAsset *asset = [AVURLAsset URLAssetWithURL:self.videoURL
                                         options:nil];
    AVPlayerItem *currentItem = [AVPlayerItem playerItemWithAsset:asset];

    self.player = [AVPlayer playerWithPlayerItem:currentItem];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.player currentItem]];

    return self;
}

/**************************************************************************************************/
#pragma mark - UIViewController override

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setClipsToBounds:YES];

    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(tappedVideo:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];

    self.playerLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.playerLayer];

    [self.player play];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**************************************************************************************************/
#pragma mark - Gesture Recognizer

- (void)tappedVideo:(UITapGestureRecognizer *)gesture {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];

    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;

    if (self.player.rate > 0 && !self.player.error) {
        [self.player pause];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat:self.view.bounds.size.height / 2];
    } else {
        [self.player play];
        animation.fromValue = [NSNumber numberWithFloat:self.view.bounds.size.height / 2];
        animation.toValue = [NSNumber numberWithFloat:0.0f];
    }

    animation.duration = 0.5;

    [self.view.layer addAnimation:animation forKey:@"cornerRadius"];
}

/**************************************************************************************************/
#pragma mark - AVPlayer notification delegate

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];

    [self.player play];
}

@end
