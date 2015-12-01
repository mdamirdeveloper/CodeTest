//
//  DetailViewController.m
//  CodeTest
//
//  Created by TAE on 12/1/15.
//  Copyright © 2015 TAE. All rights reserved.
//

#import "DetailViewController.h"
#import "ServicesManager.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *trackLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    //Circular image view
    self.artworkImageView.layer.cornerRadius = self.artworkImageView.frame.size.width/2.0;
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.title = _detailItem.artistName;
        self.trackLabel.text = _detailItem.trackName;
        self.artistLabel.text = _detailItem.artistName;
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.releaseLabel.text = [dateFormatter stringFromDate:_detailItem.releaseDate];
        self.albumLabel.text = _detailItem.albumName;
        //one decimal place formatted price
        self.priceLabel.text = [NSString stringWithFormat:@"$%.1f",_detailItem.trackPrice.floatValue];
        //TODO: Progress HUD
        __weak DetailViewController * weakSelf = self;
        [[ServicesManager sharedServicesManager] downloadImage:_detailItem.artworkUrl100 completion:^(BOOL success, UIImage *image, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.artworkImageView.image = image;
            });
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
