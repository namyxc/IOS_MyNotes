//
//  DetailViewController.m
//  MyNotes
//
//  Created by rentit on 2015. 12. 18..
//  Copyright © 2015. rentit. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

-(void)setActiveNote:(Note *)activeNote{
    _activeNote = activeNote;
    [self configureView];
}
- (void)configureView {
    // Update the user interface for the detail item.
    if (self.activeNote) {
        self.contentTextView.text = self.activeNote.contentText;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    self.activeNote.contentText = self.contentTextView.text;
    [realm commitWriteTransaction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
