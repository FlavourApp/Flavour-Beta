//
//  OrderingViewController.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/11/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "OrderingViewController.h"
#import "globals.h"
#import <CommonCrypto/CommonHMAC.h>
#import "SuccessViewController.h"
#import "globals.h"
#import "StartViewController.h"

@interface OrderingViewController ()

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation OrderingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    timerBool = NO;
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    self.responseData = [NSMutableData data];
    [self createPaymentAndProcess];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goToNextScene{
    [self performSegueWithIdentifier:@"goToSuccess" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)processPayment:(NSURL *)myURL {
    if (![[UIApplication sharedApplication] canOpenURL:myURL]) {
        // No está instalado khipu.
        //[self.overlayUIView setHidden:YES];
        // Guardamos la URL con la información del pago.
        // Esta información se utiliza cuando nuestra aplicación es invocada por khipu luego de su instalación.
        [[NSUserDefaults standardUserDefaults] setURL:myURL forKey:@"pendingURL"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // Le avisamos al usuario que es necesario instalar khipu.
        [[[UIAlertView alloc] initWithTitle:nil message:@"Debes instalar khipu" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    [[UIApplication sharedApplication] openURL:myURL];
}
-(void)createPaymentAndProcess{
    NSMutableURLRequest *aNSMutableURLRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[globals getPostOrderIP]]];
    
    [aNSMutableURLRequest setHTTPMethod:@"POST"];
    
    NSString *chefId = self.chefId;
    NSString *payer_email = self.email;
    NSString *dateId = self.dateId;
    NSString *menuId = self.menuId;
    
    NSString *userName = self.name;
    NSString *userAdress = self.adress;
    NSString *userPhone = self.phone;
    
    NSString *postString = [NSString stringWithFormat:@"&payerEmail=%@",payer_email];
    postString = [NSString stringWithFormat:@"%@&chefId=%@", postString,chefId];
    postString = [NSString stringWithFormat:@"%@&dateId=%@", postString,dateId];
    postString = [NSString stringWithFormat:@"%@&menuId=%@", postString,menuId];
    
    postString = [NSString stringWithFormat:@"%@&userName=%@", postString,userName];
    postString = [NSString stringWithFormat:@"%@&userAddress=%@", postString,userAdress];
    postString = [NSString stringWithFormat:@"%@&userPhone=%@", postString,userPhone];
    postString = [NSString stringWithFormat:@"%@&cantidad=%@", postString,self.cantidad];
   
    
    NSLog(@"postString:%@",postString);
    
    [aNSMutableURLRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[NSURLConnection alloc] initWithRequest:aNSMutableURLRequest delegate:self];
    
    timerBool = YES;
    [NSTimer scheduledTimerWithTimeInterval: 20.0
                                     target: self
                                   selector: @selector(timerEnd)
                                   userInfo: nil
                                    repeats: NO];
    
}

- (void) timerEnd
{
    if(timerBool)
    {
        NSString *message = @"Hubo un error al contactar al pago sus datos. Lo lamentamos.";
        [[[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK"   otherButtonTitles:nil] show];
        [self performSegueWithIdentifier:@"loadingFailure" sender:self];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Invocamos la AppStore con la URL de khipu.
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/khipu-terminal-de-pagos/id590942451?mt=8"]];
    
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

}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    NSString *strData = [[NSString alloc]initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSLog(@"RESPONSE:%@",strData);
    
    // convert from JSON
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
   
    if(res != nil)
    {
        timerBool = NO;
        NSLog(@"mobieURL:%@",[res valueForKey:@"mobile-url"]);
        NSURL *myURL = [NSURL URLWithString:[res valueForKey:@"mobile-url"]];
        [self processPayment:myURL];
    }
}


@end
