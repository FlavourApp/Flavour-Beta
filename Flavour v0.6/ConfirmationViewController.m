//
//  ConfirmationViewController.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/11/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "ConfirmationViewController.h"
#import "OrderingViewController.h"

@interface ConfirmationViewController ()

@end

@implementation ConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _chefLabel.text = _chef;
    _dateLabel.text = _date;
    _menuLabel.text = _menu;
    _descriptionLabel.text = _descriptionString;
    _priceLabel.text = [NSString stringWithFormat:@"$ %@",_price];
    
    NSURL *url = [NSURL URLWithString:_chefImageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _chefImage.image = [UIImage imageWithData:data];
    
    NSURL *url2 = [NSURL URLWithString:_foodImageUrl];
    NSData *data2 = [NSData dataWithContentsOfURL:url2];
    _foodImage.image = [UIImage imageWithData:data2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"goToOrdering"]) {
        
        OrderingViewController *orderingViewController = [segue destinationViewController];
        
        orderingViewController.chef = _chefPk;
        orderingViewController.menu = _menuPk;
        orderingViewController.date = _date;
        orderingViewController.userMail = _emailTextField.text;
    }
}


@end
