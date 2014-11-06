//
//  DetailViewController.m
//  chefTestV2
//
//  Created by Demian Schkolnik on 8/31/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *fullName = [[[_chef objectForKey:@"name"] stringByAppendingString:@" "] stringByAppendingString:[_chef objectForKey:@"lastname"]];
    _TitleLabel.text = fullName;
    
    _DescriptionLabel.text = [_chef objectForKey:@"description"];
    
    //This is used for images loaded from url.organi
    NSURL *url = [NSURL URLWithString:[_chef objectForKey:@"pictureUrl"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _CookImage.image = [UIImage imageWithData:data];
    
//    NSURL *url2 = [NSURL URLWithString:_DetailModal[3]];
//    NSData *data2 = [NSData dataWithContentsOfURL:url2];
    _FoodImage.image = [UIImage imageWithData:data];
    
    //_CookImage.image = [UIImage imageNamed:_DetailModal[2]];
    //_FoodImage.image = [UIImage imageNamed:_DetailModal[3]];
    
    self.navigationItem.title = fullName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
