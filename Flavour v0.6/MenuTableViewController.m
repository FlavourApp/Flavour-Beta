//
//  MenuTableViewController.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/10/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "MenuTableViewController.h"
#import "MenuTableViewCell.h"
#import "ConfirmationViewController.h"
#import "globals.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _Menus.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MenuDateTableViewCell";
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    int row = [indexPath row];
    
    NSDictionary *fields = [_Menus[row] objectForKey:@"fields"];
    
    cell.nameLabel.text = [fields objectForKey:@"name"];
    cell.descriptionLabel.text = [fields objectForKey:@"description"];
    cell.priceLabel.text = [NSString stringWithFormat:@"$%@",[fields objectForKey:@"precio"]];
   
    NSString *localUrl = [fields objectForKey:@"picture"];
    NSString * localUrlFixed = [localUrl substringFromIndex:1];
    NSString *ImgUrl = [globals getIPImagesForUrl:localUrlFixed];
    NSURL *url = [NSURL URLWithString:ImgUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.picture.image = [UIImage imageWithData:data];
    NSLog(@"returning cell..");
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"Entering segue..!");
    if ([[segue identifier] isEqualToString:@"goToConfirmation"]) {
        NSLog(@"Entered if gotoConf!!");
        ConfirmationViewController *confirmationViewController = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        int row = [myIndexPath row];
        
        NSDictionary *fields = [_Menus[row] objectForKey:@"fields"];
        
        
        confirmationViewController.chef = _chef.fullName;
        confirmationViewController.chefPk = _chef.pk;
        confirmationViewController.date = _date;
        confirmationViewController.menu = [fields objectForKey:@"name"];
        confirmationViewController.menuPk = [_Menus[row] objectForKey:@"pk"];
        confirmationViewController.descriptionString = [fields objectForKey:@"description"];
        confirmationViewController.price = [fields objectForKey:@"precio"];
      
        confirmationViewController.chefImageUrl = _chef.pictureUrl;
        //food image:
        NSString *localUrl = [fields objectForKey:@"picture"];
        NSString * localUrlFixed = [localUrl substringFromIndex:1];
        confirmationViewController.foodImageUrl = [globals getIPImagesForUrl:localUrlFixed];
        
        
        
        //menuTableViewController.date = [self.Title objectAtIndex:row];
        
    }
    else if([[segue identifier] isEqualToString:@"loadingFailure"]) {
        
    }
}


@end