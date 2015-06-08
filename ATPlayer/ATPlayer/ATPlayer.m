//
//  ATPlayer.m
//  ATPlayer
//
//  Created by Marc on 08/01/15.
//  Copyright (c) 2015 Asperity. All rights reserved.
//

#import "ATPlayer.h"

@interface ATPlayer ()

/** Main AVPlayer */
@property (nonatomic, strong) AVPlayer                          *player;
/** Timer used for updating controls delegate, given video status */
@property (nonatomic, strong) NSTimer                           *myTimer;
/** Loading view */
//@property (nonatomic, strong) EPLoadingView             *loadingView;
/** Boolean for muted status */
@property (nonatomic, assign) BOOL                              isMuted;

@property (nonatomic, strong) AVPictureInPictureController      *pipVC;

@end

@implementation ATPlayer

/**************************************************************************************************/
#pragma mark - Init methods

- (instancetype)initWithContentURL:(NSURL *)contentURL {
    [self setPlayerWithURL:contentURL];
    self.displayCurrentTime = YES;
    self.displaySeekBar = YES;

    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                    target:self
                                                  selector:@selector(displayMyCurrentTime:)
                                                  userInfo:nil
                                                   repeats:YES];

    return self;
}

- (void)setPlayerWithURL:(NSURL *)contentURL {
    [self cleanPlayer];
//    [self.loadingView animateLoader];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:contentURL
                                         options:nil];
    AVPlayerItem *currentItem = [AVPlayerItem playerItemWithAsset:asset];
    self.player = [AVPlayer playerWithPlayerItem:currentItem];
//    [self.player addObserver:self forKeyPath:@"status" options:0 context:nil];
//    [self.player addObserver:self forKeyPath:@"externalPlaybackActive" options:0 context:nil];

    [self.containerView setPlayer:self.player];
//    [self.containerView.layer removeAllAnimations];

    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(playerItemDidReachEnd:)
//                                                 name:AVPlayerItemDidPlayToEndTimeNotification
//                                               object:[self.player currentItem]];

    //[self.view bringSubviewToFront:self.loadingContainerView];

    [self.player setMuted:self.isMuted];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
//                        change:(NSDictionary *)change context:(void *)context {
//    if (object == self.player && [keyPath isEqualToString:@"status"]) {
//        if (self.player.status == AVPlayerStatusReadyToPlay) {
////            [self.loadingView stopLoader];
//            [self.view bringSubviewToFront:self.containerView];
//            [self.view sendSubviewToBack:self.loadingContainerView];
//        } else if (self.player.currentItem.status == AVPlayerStatusFailed) {
//            // Show picto ?
//        }
//    // Airplay
//    } else if (object == self.player && [keyPath isEqualToString:@"externalPlaybackActive"]) {
//        if (self.player.isExternalPlaybackActive) {
//            [self.delegate connectedAirPlay];
//        } else {
//            [self.delegate disconnectedAirPlay];
//        }
//    }
//}

/**************************************************************************************************/
#pragma mark - UIViewController override

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.containerView setClipsToBounds:YES];

//    self.loadingView = (EPLoadingView *)[EPLoadingView viewFromNib];    
//    [self.loadingContainerView addSubview:self.loadingView];

//    self.castView = (EPCastView *)[EPCastView viewFromNib];
//    [self.view addSubview:self.castView];
//    self.castView.hidden = YES;

    self.chromecastIsConnected = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.containerView setPlayer:self.player];
    [self.containerView.layer removeAllAnimations];
    
    self.pipVC = [[AVPictureInPictureController alloc] initWithPlayerLayer:(AVPlayerLayer *)self.containerView.layer];
    [self.pipVC setDelegate:self];

    [self.player play];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

//    self.castView.displaySeekbar = self.displaySeekBar;
//   self.loadingView.frame = self.loadingContainerView.bounds;
//    self.castView.frame = self.view.bounds;

//    if (self.isFillScreen) {
//        CGFloat height = [UIApplication isPortrait] ? [UIApplication getLandscapeFrame].size.width : [UIApplication getLandscapeFrame].size.height;
//        CGFloat width = height * (16. / 9.);
//
//        ((AVPlayerLayer *)[self.containerView layer]).bounds = CGRectMake(0.,
//                                                                          0.,
//                                                                          width,
//                                                                          height);
//    } else if (IS_IPHONE4 && ![UIApplication isPortrait]) {
//            CGFloat width = [UIApplication getLandscapeFrame].size.width;
//            CGFloat height = width * (9. / 16.);;
//            ((AVPlayerLayer *)[self.containerView layer]).bounds = CGRectMake(0.,
//                                                                              0.,
//                                                                              width,
//                                                                              height);
//    } else
    {
        ((AVPlayerLayer *)[self.containerView layer]).bounds = self.view.bounds;
    }
//    if (self.chromecastIsConnected) {
//        [self.view bringSubviewToFront:self.castView];
//    }
}

- (void)dealloc {
    [self cleanPlayer];
}

- (void)cleanPlayer {
    if (self.player) {
        [self.player pause];
        [self.player removeObserver:self
                         forKeyPath:@"status"];
        [self.player removeObserver:self
                         forKeyPath:@"externalPlaybackActive"];

        [[NSNotificationCenter defaultCenter] removeObserver:self];
        self.player = nil;
    }
}

- (void)fillScreen {
    if (!self.chromecastIsConnected) {
        self.isFillScreen = YES;
        [self viewDidLayoutSubviews];
    }
}

- (void)setDefaultVideoFrame {
    self.isFillScreen = NO;
    [self viewDidLayoutSubviews];
}

/**************************************************************************************************/
#pragma mark - Status getters

- (BOOL)isAirplayActive {
    return self.player.isExternalPlaybackActive;
}

/**************************************************************************************************/
#pragma mark - Timer delegate

- (void)displayMyCurrentTime:(NSTimer *)timer {
    if (self.player.currentItem) {
//        [self.seekDelegate displayMyCurrentTime:self.player.currentItem];
    }
}

/**************************************************************************************************/
#pragma mark - Player actions

- (void)seekToTime:(NSInteger)time {
    [self.player seekToTime:CMTimeMake(time, 1)];
}

- (void)seekToPercent:(float)percent {
    [self seekToTime:percent * CMTimeGetSeconds([self.player.currentItem duration])];
}

- (void)seekToTime:(NSInteger)time withTolerance:(CMTime)timeTolerance {
    [self.player seekToTime:CMTimeMake(time, 1)
            toleranceBefore:timeTolerance
             toleranceAfter:timeTolerance];
}

- (void)togglePlay {
    if (self.player.rate > 0.) {
        [self.player pause];
    } else {
        [self.player play];
    }
}

- (void)pause {
    [self.player pause];
}

- (void)resume {
    [self.player play];
}

- (void)setMuted:(BOOL)muted {
    self.isMuted = muted;
    [self.player setMuted:muted];
}

- (CMTime)getCurrentTime {
    return self.player.currentItem.currentTime;
}

- (IBAction)clickPIP:(id)sender {

    if ([AVPictureInPictureController isPictureInPictureSupported] && self.pipVC.isPictureInPicturePossible) {
        [self.pipVC startPictureInPicture];
        [self.pipVC stopPictureInPicture];
    }
}

- (void)pictureInPictureControllerWillStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"PONG");
}

- (void)pictureInPictureControllerDidStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"PONG");
}

- (void)pictureInPictureControllerFailedToStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController withError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)pictureInPictureControllerDidStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"PONG");
}

- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL restored))completionHandler {
    NSLog(@"PONG");
}

/**************************************************************************************************/
#pragma mark - AVPlayer notification delegate

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    int durationSeconds = (int)CMTimeGetSeconds([self.player.currentItem duration]) % 60;
    int currentSeconds = (int)CMTimeGetSeconds([self.player.currentItem currentTime]) % 60;

    if (currentSeconds >= durationSeconds - 1) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EPVideoFinished"
                                                            object:self];
    }
}

@end
