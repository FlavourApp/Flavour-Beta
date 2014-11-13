//
//  DateTableViewController.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/5/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "DateTableViewController.h"
#import "DateTableViewCell.h"
#import "MenuTableViewController.h"
#import "globals.h"

@interface DateTableViewController ()

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSArray *menus;

@end

@implementation DateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Date table loaded");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.menus = [[NSMutableArray alloc] init];
   
    self.responseData = [NSMutableData data];
    
    NSString *chefId = _chef.pk;
    
    
    //TODO: REMOVE THIS FIX!
    //chefId = 1;
    
    
    NSString *URL = [globals getIPMenusForChef:chefId];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:URL]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"goToMenuTable"]) {

        MenuTableViewController *menuTableViewController = [segue destinationViewController];
        NSLog(@"PREPARING SEGUE3 : asigning menus to menus");
        menuTableViewController.Menus = _menus;
        NSLog(@"PREPARING SEGUE3: assigning chef to chef");
        menuTableViewController.chef = _chef;
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        int row = [myIndexPath row];
        
        menuTableViewController.date = [self.Title objectAtIndex:row];
        
    }
    else if([[segue identifier] isEqualToString:@"loadingFailure"]) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _Title.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DateTableViewCell";
    DateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    int row = [indexPath row];
    
    cell.TitleLabel.text = _Title[row];
    
    return cell;
}

//Conection methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    [self performSegueWithIdentifier:@"loadingFailure" sender:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert from JSON
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    if(res != nil)
    {
        self.menus = [NSArray arrayWithArray:res];
    }
}


@end
