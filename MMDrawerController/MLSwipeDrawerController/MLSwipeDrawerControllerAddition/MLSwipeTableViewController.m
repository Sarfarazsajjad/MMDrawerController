//
//  MLSwipeTableViewController.m
//  MMDrawerControllerKitchenSink
//
//  Created by molon on 14/10/18.
//  Copyright (c) 2014年 Mutual Mobile. All rights reserved.
//

#import "MLSwipeTableViewController.h"
#import "MLSwipeTableView.h"

@implementation MLSwipeTableViewController

- (void)loadView
{
    self.tableView = [MLSwipeTableView new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

@end
