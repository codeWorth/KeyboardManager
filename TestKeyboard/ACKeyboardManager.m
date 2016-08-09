//
//  ACKeyboardController.m
//  TestKeyboard
//
//  Created by Andrew Cummings on 8/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "ACKeyboardManager.h"

@interface ACKeyboardManager ()

@property (nonatomic) NSInteger kbHeight; //last registered height of keyboard
@property (nonatomic) NSInteger viewOffset; //distance to move (from kb to text field)
@property (nonatomic) BOOL delayKb; //if kbHeight hasn't been set yet, animate from kbWillShow
@property (nonatomic) CGRect textfieldPosition; //position of the textfield that is being used in reference to the keyboard

@property (nonatomic) UIViewController<ACKeyboardDelegate>* delegate;

@end

@implementation ACKeyboardManager

-(instancetype)initWithDelegate:(UIViewController<ACKeyboardDelegate>*) delegate {
    if (self = [super init]) {
        self.delegate = delegate;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        self.delayKb = YES;
        self.kbPadding = 15; //default value
    }
    return self;
}

-(void)kbWillShow:(NSNotification*)notification {
    self.kbHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height + self.kbPadding; //so there is some padding between the textfield and the keyboard
    
    if (self.delayKb){
        self.delayKb = NO;
        self.viewOffset = self.textfieldPosition.origin.y + self.textfieldPosition.size.height - (self.delegate.view.frame.size.height - self.kbHeight); //textfield y + textfield height = y of lower edge of text field, view height - kb height = y of top edge of keyboard
        self.viewOffset = self.viewOffset < 0 ? 0 : self.viewOffset; //if offset is < 0, then the text fields are already above the kb
        [self animateTextField:YES];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField { //this trigger BEFORE kbWillShow
    UITextField* wantedTextfield = [self.delegate referenceTextField:textField];
    
    if (self.delayKb){
        self.textfieldPosition = wantedTextfield.frame;
    } else {
        self.viewOffset = wantedTextfield.frame.origin.y + wantedTextfield.frame.size.height - (self.delegate.view.frame.size.height - self.kbHeight); 
        self.viewOffset = self.viewOffset < 0 ? 0 : self.viewOffset;
        [self animateTextField:YES];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField:NO];
}

-(void)animateTextField:(BOOL)up {
    NSInteger movement = up ? -self.viewOffset : self.viewOffset;
    
    [UIView animateWithDuration:0.3 animations:^(void){
        self.delegate.view.frame = CGRectOffset(self.delegate.view.frame, 0, movement);
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

@end
