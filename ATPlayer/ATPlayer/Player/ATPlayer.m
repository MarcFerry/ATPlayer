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

@property (weak, nonatomic) IBOutlet UIView     *containerView;
@property (weak, nonatomic) IBOutlet UILabel    *centerLabel;

@property (nonatomic, strong) AVPlayer          *player;
@property (nonatomic, strong) AVPlayerLayer     *playerLayer;
@property (nonatomic, strong) NSURL             *videoURL;
@property (nonatomic, strong) NSTimer           *myTimer;

- (IBAction)seekTo:(id)sender;
- (IBAction)beginSeeking:(id)sender;
- (IBAction)endSeeking:(id)sender;

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
    self.displayCurrentTime = YES;
    self.displaySeekBar = YES;

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

    [self.containerView setClipsToBounds:YES];

    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(tappedVideo:)];
    [self.containerView addGestureRecognizer:tap];

    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                    target:self
                                                  selector:@selector(displayMyCurrentTime:)
                                                  userInfo:nil
                                                   repeats:YES];

    [self.seekSlider setThumbImage:[UIImage imageNamed:@"test"] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.seekSlider.hidden = !self.displaySeekBar;

    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    self.playerLayer.zPosition = -1;
    self.containerView.layer.sublayers = nil;
    [self.containerView.layer addSublayer:self.playerLayer];

    [self.player play];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.playerLayer.frame = self.view.bounds;
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
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.view.backgroundColor = [UIColor blackColor];
                         }];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat:self.view.bounds.size.height / 2];
    } else {
        [self.player play];
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.view.backgroundColor = [UIColor lightGrayColor];
                         }];
        animation.fromValue = [NSNumber numberWithFloat:self.view.bounds.size.height / 2];
        animation.toValue = [NSNumber numberWithFloat:0.0f];
    }

    animation.duration = 0.5;

    [self.containerView.layer addAnimation:animation forKey:@"cornerRadius"];
}

/**************************************************************************************************/
#pragma mark - Timer delegate

- (void)displayMyCurrentTime:(NSTimer *)timer {
    if (self.displayCurrentTime) {
        self.centerLabel.text = [NSString stringWithFormat:@"%02d:%02d / %02d:%02d",
                             (int)CMTimeGetSeconds([self.player.currentItem currentTime]) / 60,
                             (int)CMTimeGetSeconds([self.player.currentItem currentTime]) % 60,
                             (int)CMTimeGetSeconds([self.player.currentItem duration]) / 60,
                             (int)CMTimeGetSeconds([self.player.currentItem duration]) % 60];
    }

    if (!self.seekSlider.highlighted) {
        [self.seekSlider setValue:(float)[self.player.currentItem currentTime].value / (float)[self.player.currentItem currentTime].timescale / CMTimeGetSeconds([self.player.currentItem duration])];
    }
}

/**************************************************************************************************/
#pragma mark - Player actions

- (IBAction)seekTo:(id)sender {
    [self seekToTime:[(UISlider *)sender value] * CMTimeGetSeconds([self.player.currentItem duration]) withTolerance:kCMTimeZero];
}

- (IBAction)beginSeeking:(id)sender {
    [self.player pause];
}

- (IBAction)endSeeking:(id)sender {
    [self.player play];
}

- (void)seekToTime:(NSInteger)time {
    [self.player seekToTime:CMTimeMake(time, 1)];
}

- (void)seekToTime:(NSInteger)time withTolerance:(CMTime)timeTolerance {
    [self.player seekToTime:CMTimeMake(time, 1) toleranceBefore:timeTolerance toleranceAfter:timeTolerance];
}

/**************************************************************************************************/
#pragma mark - AVPlayer notification delegate

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];

    [self.player play];
}

@end
