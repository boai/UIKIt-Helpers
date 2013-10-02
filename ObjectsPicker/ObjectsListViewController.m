//
//  ObjectsListViewController.m
//  mydiet
//
//  Created by Evgeny Rusanov on 11.01.13.
//  Copyright (c) 2013 Evgeny Rusanov. All rights reserved.
//

#import "ObjectsListViewController.h"

@interface ObjectsListViewController ()

@end

@implementation ObjectsListViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setList:(NSArray *)list
{
    _list = list;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(self.cellMaker, @"ObjectListViewContrller: cellMaker is nil");
    return self.cellMaker(tableView,indexPath,self.list[indexPath.row]);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
