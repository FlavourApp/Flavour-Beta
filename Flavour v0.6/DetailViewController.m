//
//  DetailViewController.m
//  chefTestV2
//
//  Created by Demian Schkolnik on 8/31/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "DetailViewController.h"
#import "DateTableViewController.h"
#import "globals.h"

@interface DetailViewController ()

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSArray *dates;

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

    _TitleLabel.text = _chef.fullName;
    _bioText.text = _chef.longBio;
    
    self.dates = [[NSArray alloc] init];
    
    //This is used for images loaded from url.organi
    NSURL *url = [NSURL URLWithString:_chef.pictureUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _CookImage.image = [UIImage imageWithData:data];
    
    self.navigationItem.title = _chef.fullName;
    
    self.responseData = [NSMutableData data];
    
    NSString *chefId = _chef.pk;

    
    NSString *URL = [globals getIPDatesForChef:chefId];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"PREPARING SEGUE");
    
    if ([[segue identifier] isEqualToString:@"goToDateTable"]) {
        NSLog(@"PREPARING SEGUE2");
        DateTableViewController *dateTableViewController = [segue destinationViewController];
        NSLog(@"PREPARING SEGUE3");
        dateTableViewController.dates = [NSMutableArray arrayWithArray:self.dates];
        dateTableViewController.chef = _chef;
    }
    else if([[segue identifier] isEqualToString:@"loadingFailure"]) {
        
    }
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
        self.dates = [NSArray arrayWithArray:res];
    }
}



@end
