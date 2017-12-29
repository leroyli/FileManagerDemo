//
//  ViewController.m
//  FileManagerDemo
//
//  Created by artios on 2017/12/19.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "ViewController.h"
#import "LYZFileManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self lyz_config];
    
}

- (void)lyz_config {
    
    NSString *path = [LYZFileManager documentPath];
    
    NSDictionary *dic = [LYZFileManager fileAttributeAtPath:path];
    
    CGFloat fileSize = [LYZFileManager folderSizeAtPath:path];
    
    NSLog(@">>>>>>>>>> the dic is : %@, the file Size is : %.2f",dic,fileSize);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
