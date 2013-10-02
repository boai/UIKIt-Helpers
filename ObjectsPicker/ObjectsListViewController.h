//
//  ObjectsListViewController.h
//  mydiet
//
//  Created by Evgeny Rusanov on 11.01.13.
//  Copyright (c) 2013 Evgeny Rusanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObjectsListViewController : UITableViewController

@property (nonatomic,strong) NSArray *list;

@property (nonatomic,copy) UITableViewCell* (^cellMaker)(UITableView *tableView, NSIndexPath *indexPath, id object);

@end
