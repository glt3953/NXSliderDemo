//
//  NXWebViewController.m
//  room107
//
//  Created by ningxia on 15/9/9.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "NXWebViewController.h"
//#import "NSString+Encoded.h"
#import "NXURLHandler.h"

@interface NXWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) NSString *webTitle;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation NXWebViewController

- (void)setUrl:(NSURL *)url {
    _url = url;
    if (_webView != nil) {
        [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithURL:(NSURL *)url {
    self = [super init];
    if (self != nil) {
        _url = url;
    }
    return self;
}

/*
 URLParams:{
 title = "\U7b7e\U7ea6\U8bf4\U660e";
 url = "http%3A%2F%2F107room.com%2Fapp%2Fhtml%2Fexplanation%2Fcontract";
 }
 */
- (void)setURLParams:(NSDictionary *)URLParams {
//    _webTitle = [URLParams[@"title"] URLDecodedString];
//    _url = [NSURL URLWithString:[URLParams[@"url"] URLDecodedString]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.view.bounds;
//    frame.origin.y += statusBarHeight + [self heightOfNavigationBar];
    frame.size.height -= frame.origin.y;
    
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.delegate = self;
    _webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    [self.view addSubview:_webView];
//    _webView.scalesPageToFit = YES;
//    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    if (_url != nil) {
        [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
    }
    [self setTitle:_webTitle];
}

- (void)viewDidAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return [[NXURLHandler sharedInstance] handleOpenURL:request.URL params:nil context:self];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showLoadingView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideLoadingView];
    
    if (!_webTitle || _webTitle.length == 0) {
        [self setTitle:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hideLoadingView];
    
//    [PopupView showMessage:error.userInfo[@"NSLocalizedDescription"]];
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
