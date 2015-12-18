//
//  DetailViewController.h
//  MyNotes
//
//  Created by rentit on 2015. 12. 18..
//  Copyright © 2015. rentit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

