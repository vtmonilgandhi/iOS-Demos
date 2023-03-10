/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

#import "MDCTextFieldPositioningDelegate.h"

@protocol MDCTextInput;
@protocol MDCTextInputCharacterCounter;

/** Controllers that manipulate styling and animation of text inputs. */
@protocol MDCTextInputController <NSObject, NSCoding, NSCopying, MDCTextInputPositioningDelegate>

/**
 The character counter. Override to use a custom character counter.

 Default is an internal instance MDCTextInputAllCharactersCounter. Setting this property to null
 will reset it to return that instance.
 */
@property(nonatomic, null_resettable, weak) IBInspectable id<MDCTextInputCharacterCounter>
    characterCounter;

/**
 The character count maximum for the text input. A label under the input counts characters entered
 and presents the count / the max.

 If character count / max has been hidden by the characterCountViewMode
 (ie: UITextFieldViewModeNever) changing the value of characterLimit has no effect.

 If the character count goes above its max, the underline, the character count / max label and
 any floating placeholder label all turn to the error color; the text input will be in error state.
 Note: setErrorText:errorAccessibilityValue: also sets these MDCTextInput properties.

 There is no support for a minimum character count.

 Default is 0.
 */
@property(nonatomic, assign) IBInspectable NSUInteger characterCountMax;

/**
 Controls when the character count will be shown and therefore whether character counting determines
 error state.

 Default is UITextFieldViewModeNever.
 */
@property(nonatomic, assign) UITextFieldViewMode characterCountViewMode;

/**
 The color used to denote error state in the underline, the errorText's label, the placeholder and
 the character count label.

 Default is errorColorDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *errorColor;

/**
 Default value for errorColor.

 Default is red.
 */
@property(class, nonatomic, null_resettable, strong) UIColor *errorColorDefault;

/**
 The text being displayed in the leading underline label when in an error state.

 NOTE: To set this value, you must use setErrorText:errorAccessibilityValue:.
 */
@property(nonatomic, nullable, copy, readonly) NSString *errorText;

/**
 Text displayed in the leading underline label.

 This text should give context or instruction to the user. If error text is set, it is
 not shown.
 */
@property(nonatomic, nullable, copy) IBInspectable NSString *helperText;

/**
 The color applied to the placeholder when inline (not floating).

 Default is inlinePlaceholderColorDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *inlinePlaceholderColor;

/**
 Default value for inlinePlaceholderColor.

 Default is black with Material Design hint text opacity.
 */
@property(class, nonatomic, null_resettable, strong) UIColor *inlinePlaceholderColorDefault;

/*
 Indicates whether the alert contents should automatically update their font when the device???s
 UIContentSizeCategory changes.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIConnectSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 Default is mdc_adjustsFontForContentSizeCategoryDefault.
 */
@property(nonatomic, assign, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory;

/**
 Default value for mdc_adjustsFontForContentSizeCategory.

 Default is NO.
 */
@property(class, nonatomic, assign) BOOL mdc_adjustsFontForContentSizeCategoryDefault;

/** The text input the controller is affecting. */
@property(nonatomic, nullable, strong) UIView<MDCTextInput> *textInput;

/**
 Controls when the underline will be shown.

 The underline is an overlay that can be hidden depending on the editing state of the input text.

 Default is underlineViewModeDefault.
 */
@property(nonatomic, assign) UITextFieldViewMode underlineViewMode;

/**
 Default value for underlineViewMode.

 Default is UITextFieldViewModeAlways.
 */
@property(class, nonatomic, assign) UITextFieldViewMode underlineViewModeDefault;

/**
 Color the underline changes to when the input is editing.

 Default is underlineColorActiveDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *underlineColorActive;

/**
 Default value for underlineColorActive.

 Default is blue.
 */
@property(class, nonatomic, null_resettable, strong) UIColor *underlineColorActiveDefault;

/**
 Color of the underline when the input is not editing but still enabled.

 Default is underlineColorNormalDefault.
 */
@property(nonatomic, null_resettable, strong) UIColor *underlineColorNormal;

/**
 Default value for underlineColorNormal.

 Default is black with Material Design hint text opacity which is the same as
 inlinePlaceholderColorDefault.
 */
@property(class, nonatomic, null_resettable, strong) UIColor *underlineColorNormalDefault;

/**
 Convenience init. Never fails.

 @param input An MDCTextInput this controller will manage.
 */
- (nonnull instancetype)initWithTextInput:(nullable UIView<MDCTextInput> *)input;

/**
 Sets the state of the controller by setting the values of properties errorText and
 errorAccessibilityValue.

 The value of errorText controls the state of the text input.

 @param errorText               The error text to be shown as underline text. (Copied.)
 @param errorAccessibilityValue Optional override of default underline text accessibility value.
                                (Copied.)

 This method is usually called from whatever object is the UITextFieldDelegate for the MDCTextField.
 That object is responsible for validation of the text and calling this method if the error state
 needs to change.

 When errorText != nil, the text input is in an error state:
 - The error text appears in the underline text with the errorColor as text color.
 - The input rectangle's underline, placeholder and character are colored to the errorColor.

 When errorText == nil, the text input is not in error state:
 - The underline text is restored to the color and value it was.
 - The underline color and height is restored.
 - The placeholder text is restored to the color it was.
 - The character count text is restored to the color it was.

 Setting errorText to an empty string (@"") will put the input in error state but the underline text
 will be empty. It will color (if visible) the underline, the placeholder, and the character
 count in the errorColor.

 Setting errorAccessibilityValue when errorText == nil has no effect.

 Note: The characterCountMax property also affects these same MDCTextInput properties.
 */
- (void)setErrorText:(nullable NSString *)errorText
    errorAccessibilityValue:(nullable NSString *)errorAccessibilityValue;

@end
