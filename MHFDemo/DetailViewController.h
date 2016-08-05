//
//  DetailViewController.h
//  MHFDemo
//
//  Created by Malcolm Hall on 05/08/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

