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

    self.player = [[ATPlayer alloc] init];
    self.player.view.frame = CGRectMake(20, 60, 224, 168);
    [self.view addSubview:self.player.view];

    
    self.player2 = [[ATPlayer alloc] init];
    self.player2.view.frame = CGRectMake(274, 60, 224, 168);
    [self.view addSubview:self.player2.view];

    
    self.player3 = [[ATPlayer alloc] init];
    self.player3.view.frame = CGRectMake(528, 60, 224, 168);
    [self.view addSubview:self.player3.view];

    
    self.player4 = [[ATPlayer alloc] init];
    self.player4.view.frame = CGRectMake(782, 60, 224, 168);
    [self.view addSubview:self.player4.view];

    self.player5 = [[ATPlayer alloc] init];
    self.player5.view.frame = CGRectMake(20, 228, 224, 168);
    [self.view addSubview:self.player5.view];
//
//    
    self.player6 = [[ATPlayer alloc] init];
    self.player6.view.frame = CGRectMake(274, 228, 224, 168);
    [self.view addSubview:self.player6.view];
//
//    
    self.player7 = [[ATPlayer alloc] init];
    self.player7.view.frame = CGRectMake(528, 228, 224, 168);
    [self.view addSubview:self.player7.view];
//
//    
    self.player8 = [[ATPlayer alloc] init];
    self.player8.view.frame = CGRectMake(782, 228, 224, 168);
    [self.view addSubview:self.player8.view];

//
//    self.player9 = [[ATPlayer alloc] init];
//    self.player9.view.frame = CGRectMake(20, 366, 224, 168);
//    [self.view addSubview:self.player9.view];
//
//    
//    self.player10 = [[ATPlayer alloc] init];
//    self.player10.view.frame = CGRectMake(274, 564, 224, 168);
//    [self.view addSubview:self.player10.view];
//
//    
//    self.player11 = [[ATPlayer alloc] init];
//    self.player11.view.frame = CGRectMake(528, 564, 224, 168);
//    [self.view addSubview:self.player11.view];
//
//    
//    self.player12 = [[ATPlayer alloc] init];
//    self.player12.view.frame = CGRectMake(782, 564, 224, 168);
//    [self.view addSubview:self.player12.view];
}


@end
