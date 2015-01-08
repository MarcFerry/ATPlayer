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

@end

@implementation ATViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.player = [[ATPlayer alloc] init];
    self.player.view.frame = self.view.frame;
    [self.view addSubview:self.player.view];
}


@end
