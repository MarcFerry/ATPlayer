//
//  ViewController.m
//  ATPlayer
//
//  Created by Marc on 08/01/15.
//  Copyright (c) 2015 Asperity. All rights reserved.
//

#import "ATViewController.h"

#import "ATPlayer.h"

@interface ATViewController ()

@property (nonatomic, strong) ATPlayer *player;
@property (nonatomic, strong) ATPlayer *player2;
@property (nonatomic, strong) ATPlayer *player3;
@property (nonatomic, strong) ATPlayer *player4;
@property (nonatomic, strong) ATPlayer *player5;
@property (nonatomic, strong) ATPlayer *player6;
@property (nonatomic, strong) ATPlayer *player7;
@property (nonatomic, strong) ATPlayer *player8;
@property (nonatomic, strong) ATPlayer *player9;
@property (nonatomic, strong) ATPlayer *player10;
@property (nonatomic, strong) ATPlayer *player11;
@property (nonatomic, strong) ATPlayer *player12;

@end

@implementation ATViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.frame = [UIScreen mainScreen].bounds;

    self.player = [[ATPlayer alloc] initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"TEST"
                                                                                                              ofType:@"mp4"]]];
    self.player.view.frame = CGRectMake(0, 0, 512, 384);
    [self.view addSubview:self.player.view];


//    self.player2 = [[ATPlayer alloc] initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"TEST"
//                                                                                                               ofType:@"mp4"]]];
//    self.player2.view.frame = CGRectMake(512, 0, 512, 384);
//    [self.view addSubview:self.player2.view];
//
//
//    self.player3 = [[ATPlayer alloc] initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"TEST"
//                                                                                                               ofType:@"mp4"]]];
//    self.player3.view.frame = CGRectMake(0, 384, 512, 384);
//    [self.view addSubview:self.player3.view];
//    
//    
//    self.player4 = [[ATPlayer alloc] initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"TEST"
//                                                                                                               ofType:@"mp4"]]];
//    self.player4.view.frame = CGRectMake(512, 384, 512, 384);
//    [self.view addSubview:self.player4.view];
}


@end
