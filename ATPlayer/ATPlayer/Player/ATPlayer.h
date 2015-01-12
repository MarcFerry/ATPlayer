//
//  ATPlayer.h
//  ATPlayer
//
//  Created by Marc on 08/01/15.
//  Copyright (c) 2015 Asperity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATPlayer : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *seekSlider;

@property (assign) BOOL displayCurrentTime;

- (IBAction)seekTo:(id)sender;
- (IBAction)beginSeeking:(id)sender;
- (IBAction)endSeeking:(id)sender;

- (instancetype)initWithContentURL:(NSURL *)contentURL;
- (void)seekToTime:(NSInteger)time;

@end
