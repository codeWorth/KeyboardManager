HOW TO USE:

1. Copy ACKeyboardManager.h and ACKeyboardManager.m into your project.

2. Initialize ACKeyboardManager

3. For any UITextFields that you want to have managed, set their delegate to the ACKeyboardManager


kbManager = [[ACKeyboardManager alloc] initWithDelegate:self];

textfield1.delegate = kbManager
textfield2.delegate = kbManager
.
.
.
