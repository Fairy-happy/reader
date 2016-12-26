//
//  ViewController.m
//  reader
//
//  Created by fairy on 16/12/15.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import "ViewController.h"
#import "ReaderViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *pushButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 100, 100, 50)];
    [pushButton addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    [pushButton setTitle:@"push" forState:UIControlStateNormal];
    pushButton.backgroundColor = [UIColor redColor];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)push
{
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"test" withExtension:@"txt"];
    ReaderViewController *reader = [[ReaderViewController alloc] init];
    [reader loadText:[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil]];
//    [self.navigationController pushViewController:reader animated:YES];
    [self presentViewController:reader animated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
