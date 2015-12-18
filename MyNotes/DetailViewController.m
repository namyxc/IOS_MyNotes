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
        self.title = self.activeNote.subject;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *toolsButton = [[UIBarButtonItem alloc] initWithTitle:@"Tools" style:UIBarButtonItemStylePlain target:self action:@selector(toolsButtonTapped)];
    self.navigationItem.rightBarButtonItem = toolsButton;
    [self configureView];
}
-(void)toolsButtonTapped{
    
    __weak DetailViewController *welf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tools" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Rename" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [welf renameTapped];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //todo
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];

    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) renameTapped{
    
    __weak DetailViewController *welf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Rename" message:@"rename" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = welf.activeNote.subject;
    }];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //todo
    }]];
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];

    
    [self presentViewController:alertController animated:YES completion:nil];}

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
