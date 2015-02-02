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

#define ID_DEL_COBRADOR 23003
#define SECRET_DEL_COBRADOR @"9fa9cc61f7455f4ba3345bd7719ebe5cc9afc0e5"
#define EMAIL_DEMO @"info@flavour.com"
#define SUBJECT_DEMO @"Compra Cena Flavour"
#define AMOUNT_DEMO 35000

@interface OrderingViewController ()

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation OrderingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    NSString *post = [NSString stringWithFormat:@"chef=%@&date=%@&menu=%@&usermail=%@",_chef,_date,_menu,_userMail];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[globals getPostOrderIP]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(conn) {
        [self goToNextScene];
    } else {
        [self performSegueWithIdentifier:@"orderingFailure" sender:self];
    }

*/

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
    NSString *payer_email = self.userMail;
    NSString *dateId = self.dateId;
    NSString *menuId = self.menuId;
    
    NSString *postString = [NSString stringWithFormat:@"&payer_email=%@",payer_email];
    postString = [NSString stringWithFormat:@"%@&chefId=%@", postString,chefId];
    postString = [NSString stringWithFormat:@"%@&dateId=%@", postString,dateId];
    postString = [NSString stringWithFormat:@"%@&menuId=%@", postString,menuId];
    
    [aNSMutableURLRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[NSURLConnection alloc] initWithRequest:aNSMutableURLRequest delegate:self];
    
}

// Esta funcionalidad debe llamar a tu servidor web para crear el pago. No lo hagas dentro de la aplicación móvil, pues hay información privada
// que debes utilizar para crear el pago.
- (void)createPaymentAndProcessOriginal {
    
    // Para crear Pagos, no olvides revisar la documentación de nuestra API https://khipu.com/api/1.2/docs
    NSMutableURLRequest *aNSMutableURLRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://khipu.com/api/1.2/createPaymentURL"]];
    
    [aNSMutableURLRequest setHTTPMethod:@"POST"];
    
    NSString *receiver_id = [NSString stringWithFormat:@"%d", ID_DEL_COBRADOR];
    NSString *subject = SUBJECT_DEMO;
    NSString *body = @"";
    NSString *amount = [NSString stringWithFormat:@"%ld", (long)AMOUNT_DEMO];
    NSString *notify_url = @"";
    NSString *return_url = @"flavour://success.flavour.com";
    NSString *cancel_url = @"flavour://failure.flavour.com";
    NSString *transaction_id = @"";
    NSString *payer_email = EMAIL_DEMO;
    NSString *picture_url = @"";
    NSString *custom = @"";
    NSString *bank_id = @"";
    
    
    NSString *postString = [NSString stringWithFormat:@"receiver_id=%@", receiver_id];
    postString = [NSString stringWithFormat:@"%@&subject=%@", postString,subject];
    postString = [NSString stringWithFormat:@"%@&body=%@", postString,body];
    postString = [NSString stringWithFormat:@"%@&amount=%@", postString,amount];
    postString = [NSString stringWithFormat:@"%@&payer_email=%@", postString,payer_email];
    postString = [NSString stringWithFormat:@"%@&bank_id=%@", postString,bank_id];
    postString = [NSString stringWithFormat:@"%@&transaction_id=%@", postString,transaction_id];
    postString = [NSString stringWithFormat:@"%@&custom=%@", postString,custom];
    postString = [NSString stringWithFormat:@"%@&notify_url=%@", postString,notify_url];
    postString = [NSString stringWithFormat:@"%@&return_url=%@", postString,return_url];
    postString = [NSString stringWithFormat:@"%@&cancel_url=%@", postString,cancel_url];
    postString = [NSString stringWithFormat:@"%@&picture_url=%@", postString,picture_url];
    
    // EL SECRET_DEL_COBRADOR NUNCA DEBE QUEDAR EN TU APP. Esta es información privada
    NSData *saltData = [SECRET_DEL_COBRADOR dataUsingEncoding:NSUTF8StringEncoding];
    NSData *paramData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH ];
    CCHmac(kCCHmacAlgSHA256, saltData.bytes, saltData.length, paramData.bytes, paramData.length, hash.mutableBytes);
    
    NSString *hashNSString = [[[[hash description]
                                stringByReplacingOccurrencesOfString: @"<" withString: @""]
                               stringByReplacingOccurrencesOfString: @">" withString: @""]
                              stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    postString = [NSString stringWithFormat:@"%@&hash=%@", postString, hashNSString];
    
    [aNSMutableURLRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    NSData *conn = [NSURLConnection sendSynchronousRequest:aNSMutableURLRequest returningResponse:&response error:&error];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:conn options:0 error:nil];
    
    NSURL *myURL = [NSURL URLWithString:[json valueForKey:@"mobile-url"]];
    
    
    [self processPayment:myURL];
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
        NSLog(@"mobieURL:%@",[res valueForKey:@"mobile-url"]);
        NSURL *myURL = [NSURL URLWithString:[res valueForKey:@"mobile-url"]];
        [self processPayment:myURL];
    }
}

@end
