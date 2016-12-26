//
//  ViewController.m
//  GoogleSkd
//
//  Created by pc on 11/18/16.
//  Copyright © 2016 Bhadresh Patoliya. All rights reserved.
//

#import "ViewController.h"
#import <Google/SignIn.h>

@interface ViewController ()<GIDSignInUIDelegate,GIDSignInDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
     [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    NSLog(@"Error Google Login:%@",error);
    
    // Perform any operations when the user disconnects from app here.
    // ...
}


- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    // Perform any operations on signed in user here.
    
    if (user == nil)
    {
        return;
    }
    NSObject *userObje = user.profile;
    NSLog(@"Customer details: %@", userObje);
    
    NSString *useraID =user.userID;
    NSString *useraFullName =user.profile.name;
    NSString *userFirstName = user.profile.givenName;
    NSString *userLastName = user.profile.familyName;
    NSString *UserEmailId = user.profile.email;
    NSURL *UrlUserProPictureUrl = [user.profile imageURLWithDimension:1];
    
    
    NSDictionary *userinfo = @{@"userGoogleUserID":useraID,
                               @"userFullName":useraFullName,
                               @"userFirstName":userFirstName,
                               @"userLastName":userLastName,
                               @"userProPicture":UrlUserProPictureUrl,
                               @"UserEmailId":UserEmailId
                               };
    NSLog(@"user Info via Google Sdk:%@",userinfo);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginBtn:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
    [[GIDSignIn sharedInstance] signIn];
}
@end
