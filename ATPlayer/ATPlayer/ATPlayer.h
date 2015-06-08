//
//  ATPlayer.h
//  ATPlayer
//
//  Created by Marc on 08/01/15.
//  Copyright (c) 2015 Asperity. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "ATPlayerView.h"

@import AVKit;

//#import "ATSeekPlayerDelegate.h"
//#import "ATSeekControlsDelegate.h"
//#import "EPCastView.h"

@protocol EPPlayerActionsDelegate <NSObject>

/**
 *  Tells the delegate that the player has been tapped by the user
 *
 *  @param gesture Gesture recognized
 */
- (void)tappedVideo:(UIGestureRecognizer *)gesture;
/**
 *  Tells the delegate that the player has been swiped by the user
 *
 *  @param gesture Gesture recognized
 */
- (void)swipedVideo:(UIGestureRecognizer *)gesture;
/**
 *  Tells the delegate that the application connected to an AirPlay device
 */
- (void)connectedAirPlay;
/**
 *  Tells the delegate that the application was disconnected from an AirPlay device
 */
- (void)disconnectedAirPlay;

@end

@interface ATPlayer : UIViewController<AVPictureInPictureControllerDelegate>//<ATSeekPlayerDelegate>

/** View holding the video player */
@property (weak, nonatomic) IBOutlet ATPlayerView           *containerView;
/** View holding the loading view */
@property (weak, nonatomic) IBOutlet UIView                 *loadingContainerView;

/** Indicates whether the video time should be displayed */
@property (assign) BOOL                                     displayCurrentTime;
/** Indicates whether the seekbar should be visible */
@property (assign) BOOL                                     displaySeekBar;
/** Delegate handling events (gesture, external screen connection) */
@property (strong, nonatomic) id<EPPlayerActionsDelegate>   delegate;
/** Delegate displaying player controls (seekbar, time, play/pause etc.) */
//@property (strong, nonatomic) id<ATSeekControlsDelegate>    seekDelegate;

/** View to display when using Chromecast/Airplay */
//@property (nonatomic, strong) EPCastView                    *castView;
/** Boolean indicating wether the video should fill the screen (while maintaining ratio) */
@property (assign) BOOL                                     isFillScreen;

@property (assign) BOOL                                     chromecastIsConnected;

/**
 *  Instantiate an ATPlayer with a video URL
 *
 *  @param contentURL Initial URL to load
 *  @return Instance player
 */
- (instancetype)initWithContentURL:(NSURL *)contentURL;
/**
 *  Update current video URL
 *
 *  @param contentURL Video URL to load
 */
- (void)setPlayerWithURL:(NSURL *)contentURL;
/**
 *  Seek the current video to designated time
 *
 *  @param time Time to seek (in seconds)
 */
- (void)seekToTime:(NSInteger)time;
/**
 *  Pauses the video content if it is currently playing
 */
- (void)pause;
/**
 *  Resumes the video content if it is currently not playing
 */
- (void)resume;
/**
 *  Inverts current state of video content : Resumes play if content is stopped, stops if it is playing
 */
- (void)togglePlay;
/**
 *  Resets internal player settings and destroy it
 */
- (void)cleanPlayer;
/**
 *  Sets video layer bounds based on current screen so that the video fills the entire screen with a 16:9 ratio
 */
- (void)fillScreen;
/**
 *  Sets video layer bounds based on current ATPlayer frame
 */
- (void)setDefaultVideoFrame;
/**
 *  Indicates whether the player is playing content on another display via Airplay
 *
 *  @return Boolean indicating Airplay status : YES if Airplay is active, NO otherwise
 */
- (BOOL)isAirplayActive;
/**
 *  Turns ON or OFF AVPlayer's volume
 *
 *  @param muted YES for volume = 0, NO for volume = 1
 */
- (void)setMuted:(BOOL)muted;

- (CMTime)getCurrentTime;

@end