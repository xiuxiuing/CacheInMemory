//
//  ViewController.m
//  CacheMemory
//
//  Created by Mac_PC on 14-9-11.
//  Copyright (c) 2014年 H0meDev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSURLConnection *connection;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Click:(id)sender {
    NSString *paraURLString = @"http://www.baidu.com";
    if ([paraURLString length] == 0) {
        NSLog(@"Nil or empty URL is given");
        return;
    }
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    [urlCache setMemoryCapacity:1 * 1024 *1024];
    NSURL *url = [NSURL URLWithString:paraURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    NSCachedURLResponse *respone = [urlCache cachedResponseForRequest:request];
    if (respone != nil) {
        NSLog(@"如果有缓存输出，从缓存中获取数据");
        [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
    connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"将接收输出");
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response{
    NSLog(@"即将发送请求");
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"接受数据");
    NSLog(@"数据长度为 = %lu", (unsigned long)[data length]);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection

                  willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    
    NSLog(@"将缓存输出");
    
    return(cachedResponse);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@"请求完成");
    
}

- (void)connection:(NSURLConnection *)connection

  didFailWithError:(NSError *)error{
    
    NSLog(@"请求失败");
    
}

@end
