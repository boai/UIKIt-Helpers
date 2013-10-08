//
//  ObjectsPickViewController.m
//  mydiet
//
//  Created by Evgeny Rusanov on 11.01.13.
//  Copyright (c) 2013 Evgeny Rusanov. All rights reserved.
//

#import "ObjectsPickViewController.h"

@implementation ObjectsPickViewController

-(void)initialize
{
    _selectedIndex = -1;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialize];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancelClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(doneClick)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSelectedIndex:(int)selectedIndex
{
    int prevIndex = self.selectedIndex;
    _selectedIndex = selectedIndex;
    
    if (prevIndex != self.selectedIndex)
    {
        NSMutableArray *reloadIndices = [NSMutableArray array];
        [reloadIndices addObject:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
        if (prevIndex!=-1)
            [reloadIndices addObject:[NSIndexPath indexPathForRow:prevIndex inSection:0]];
        
        [self.tableView reloadRowsAtIndexPaths:reloadIndices withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Actions

-(void)cancelClick
{
    [self.pickDelegate objectPickViewControllerDidCancel:self];
}

-(void)doneClick
{
    [self.pickDelegate objectPickViewControllerDidOk:self];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.selectedIndex)
    {
        NSAssert(self.selectedCellMaker, @"ObjectPickViewContrller: selectedCellMaker is nil");
        return self.selectedCellMaker(tableView,indexPath,self.list[indexPath.row]);
    }
        
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    self.selectedIndex = indexPath.row;
}

@end
