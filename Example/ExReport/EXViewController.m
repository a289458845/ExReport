//
//  EXViewController.m
//  ExReport
//
//  Created by a289458845 on 02/04/2021.
//  Copyright (c) 2021 a289458845. All rights reserved.
//

#import "EXViewController.h"
#import <ExService.h>
@interface EXViewController ()

@end

@implementation EXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[ExService manager]print];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
