//
//  HomeViewController.m
//  Lime
//
//  Created by ArtikusHG on 4/30/19.
//  Copyright © 2019 Daniel. All rights reserved.
//

#import "HomeViewController.h"
#import "InstallationController.h"
#import <QuartzCore/QuartzCore.h>
#import <WebKit/WebKit.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"HTML/index" ofType:@"html"];
    NSString *htmlFileDark = [[NSBundle mainBundle] pathForResource:@"HTML/indexdark" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    NSString *htmlStringDark = [NSString stringWithContentsOfFile:htmlFileDark encoding:NSUTF8StringEncoding error:nil];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"darkMode"]) {
        [_webView loadHTMLString:htmlStringDark baseURL:[[NSBundle mainBundle] bundleURL]];
    } else {
        [_webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    }
    _webView.navigationDelegate = self;
    
    WKWebViewConfiguration *theConfiguration =
    [[WKWebViewConfiguration alloc] init];
    [theConfiguration.userContentController
     addScriptMessageHandler:self name:@"myApp"];
    [_webView.configuration.userContentController addScriptMessageHandler:self name:@"lime"];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"darkMode"]) {
        webView.frame = CGRectMake(0, self.view.frame.size.height - self.view.safeAreaLayoutGuide.layoutFrame.size.height - self.tabBarController.tabBar.frame.size.height, self.view.frame.size.width, self.view.safeAreaLayoutGuide.layoutFrame.size.height + self.tabBarController.tabBar.frame.size.height);
    } else {
        webView.frame = self.view.frame;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBar.barStyle = 1;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"darkMode"]) {
        self.tabBarController.tabBar.barStyle = 1;
        self.webView.backgroundColor = [UIColor blackColor];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.view.backgroundColor = [UIColor blackColor];
    }
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [super dismissViewControllerAnimated:flag completion:completion];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Gay" message:@"Hmm now to refresh" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    [self performSegueWithIdentifier:@"openSettings" sender:self];
}

-(void)drawQueueView {
    UIView* queueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 44)];
    [queueView.layer setCornerRadius:10];
    queueView.layer.masksToBounds = YES;
    
    UIView* shadowView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 140 / 2, [UIScreen mainScreen].bounds.size.height - 110, 140, 44)];
    shadowView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2] CGColor];
    shadowView.layer.shadowRadius = 10;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    shadowView.layer.shadowOpacity = 1;
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView* queueSView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    queueSView.frame = CGRectMake(0, 0, 140, 44);
    
    UIButton *queueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [queueButton setTitle:@"Queue" forState:UIControlStateNormal];
    [queueButton setTitleColor:self.tabBarController.view.tintColor forState:UIControlStateNormal];
    queueButton.frame = CGRectMake(0, 0, 140, 44);
    
    [queueView addSubview:queueSView];
    [queueView addSubview:queueButton];
    [shadowView addSubview:queueView];
    //if (self.queueArray != nil) {
    [self.tabBarController.view addSubview:shadowView];
    //}
}

@end
