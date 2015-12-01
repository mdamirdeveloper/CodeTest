//
//  MasterViewController.m
//  CodeTest
//
//  Created by TAE on 12/1/15.
//  Copyright © 2015 TAE. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Item.h"
#import "ServicesManager.h"
@interface MasterViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Item *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak UITableView * weakTable = tableView;
    __block NSIndexPath * blockIndexPath = indexPath;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Item *object = self.objects[indexPath.row];
    cell.textLabel.text = object.artistName;
    cell.detailTextLabel.text = object.trackName;
    if(object.artwork){
        cell.imageView.image = object.artwork;
    }else{
        cell.imageView.image = nil;
        //TODO: Progress HUD
        [[ServicesManager sharedServicesManager] downloadImage:object.artworkUrl30 completion:^(BOOL success, UIImage *image, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                object.artwork = image;
                [weakTable reloadRowsAtIndexPaths:@[blockIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
            
        }];
    }

    return cell;
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    __weak MasterViewController * weakSelf = self;
    //Perform search
    [[ServicesManager sharedServicesManager] searchArtist:searchBar.text completion:^(BOOL success, NSArray *songs, NSError *error) {
        _objects = songs;
        //Reload table with new results
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
    }];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //Cancel all ongoing operations
    [[ServicesManager sharedServicesManager] cancelArtistSearch];
}
@end
