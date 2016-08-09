//
//  ViewController.m
//  TestKeyboard
//
//  Created by Andrew Cummings on 8/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *topUsername;
@property (weak, nonatomic) IBOutlet UITextField *topPassword;

@property (nonatomic, strong) ACKeyboardManager* keyboardManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.keyboardManager = [[ACKeyboardManager alloc] initWithDelegate:self];
    
    self.username.delegate = self.keyboardManager;
    self.password.delegate = self.keyboardManager;
    self.topUsername.delegate = self.keyboardManager;
    self.topPassword.delegate = self.keyboardManager;
}

-(UITextField*)referenceTextField:(UITextField *)textfield {
    if (textfield == self.username || textfield == self.password) {
        return self.password;
    } else if (textfield == self.topUsername || textfield == self.topPassword) {
        return self.topPassword;
    }
    
    return nil;
}

@end
