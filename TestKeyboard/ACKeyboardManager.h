//
//  ACKeyboardController.h
//  TestKeyboard
//
//  Created by Andrew Cummings on 8/8/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ACKeyboardDelegate <NSObject>

-(UITextField*)referenceTextField:(UITextField*)textfield; //pass in the selected text field, returns the text field which the keyboard should be positioned relative to

@property (nonatomic, weak) UIView* view; //the view that the delegate controls

@end

@interface ACKeyboardManager : NSObject <UITextFieldDelegate>

-(instancetype)initWithDelegate:(UIViewController<ACKeyboardDelegate>*)delegate;

@property (nonatomic) NSInteger kbPadding; //padding between top of keyboard and bottom of text field

@end
