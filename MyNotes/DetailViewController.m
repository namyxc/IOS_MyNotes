//
//  DetailViewController.m
//  MyNotes
//
//  Created by rentit on 2015. 12. 18..
//  Copyright © 2015. rentit. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong) NSString *editedSubject;

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
    
    UIBarButtonItem *toolsButton = [[UIBarButtonItem alloc] initWithTitle:@"Tools" style:UIBarButtonItemStylePlain target:self action:@selector(toolsButtonTapped:)];
    self.navigationItem.rightBarButtonItem = toolsButton;
    [self configureView];
}
-(void)toolsButtonTapped:(UIBarButtonItem *) sender{
    
    __weak DetailViewController *welf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tools" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    alertController.popoverPresentationController.barButtonItem = sender;
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Rename" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [welf renameTapped];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteObject:welf.activeNote];
        [realm commitWriteTransaction];
        
        [welf sendNoteChangedNotification];
        welf.activeNote = nil;
        
        welf.contentTextView.text = @"";
        welf.title = nil;
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];

    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) sendNoteChangedNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNoteChangedNotification object:self.activeNote];
}

-(void) renameTapped{
    
    __weak DetailViewController *welf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Rename" message:@"rename" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = welf.activeNote.subject;
        textField.delegate = welf;
    }];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        welf.activeNote.subject = welf.editedSubject;
        [realm commitWriteTransaction];
        [welf configureView];
        [welf sendNoteChangedNotification];
        

    }]];
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];

    
    [self presentViewController:alertController animated:YES completion:nil];}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    self.editedSubject = textField.text;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.activeNote) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        self.activeNote.contentText = self.contentTextView.text;
        [realm commitWriteTransaction];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
