//
//  OrderingViewController.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/11/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "OrderingViewController.h"

@interface OrderingViewController ()

@end

@implementation OrderingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(goToNextScene) withObject:nil afterDelay:5.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goToNextScene{
    NSLog(@"GoToNextScene Called..!");
    [self performSegueWithIdentifier:@"orderingSuccess" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
