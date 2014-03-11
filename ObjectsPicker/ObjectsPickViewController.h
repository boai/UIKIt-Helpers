//
//  ObjectsPickViewController.h
//  mydiet
//
//  Created by Evgeny Rusanov on 11.01.13.
//  Copyright (c) 2013 Evgeny Rusanov. All rights reserved.
//

#import "ObjectsListViewController.h"

@class ObjectsPickViewController;
@protocol ObjectsPickViewControllerDelegate <NSObject>
-(void)objectPickViewControllerDidOk:(ObjectsPickViewController*)controller;
-(void)objectPickViewControllerDidCancel:(ObjectsPickViewController*)controller;
@end

@interface ObjectsPickViewController : ObjectsListViewController

@property (nonatomic,copy) UITableViewCell* (^selectedCellMaker)(UITableView *tableView, NSIndexPath *indexPath, id object);
@property (nonatomic) NSInteger selectedIndex;

@property (nonatomic,assign) id<ObjectsPickViewControllerDelegate> pickDelegate;

@end
