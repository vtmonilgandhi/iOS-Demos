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

#import "MDCTextInputControllerFullWidth.h"

#import "MDCTextField.h"
#import "MDCTextInput.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputUnderlineView.h"

#import "MaterialAnimationTiming.h"
#import "MaterialMath.h"
#import "MaterialPalettes.h"
#import "MaterialRTL.h"
#import "MaterialTypography.h"

static const CGFloat MDCTextInputFullWidthHintTextOpacity = 0.54f;
static const CGFloat MDCTextInputFullWidthHorizontalInnerPadding = 8.f;
static const CGFloat MDCTextInputFullWidthHorizontalPadding = 16.f;
static const CGFloat MDCTextInputFullWidthVerticalPadding = 20.f;

static NSString *const MDCTextInputControllerFullWidthCharacterCounterKey =
    @"MDCTextInputControllerFullWidthCharacterCounterKey";
static NSString *const MDCTextInputControllerFullWidthCharacterCountViewModeKey =
    @"MDCTextInputControllerFullWidthCharacterCountViewModeKey";
static NSString *const MDCTextInputControllerFullWidthCharacterCountMaxKey =
    @"MDCTextInputControllerFullWidthCharacterCountMaxKey";
static NSString *const MDCTextInputControllerFullWidthErrorAccessibilityValueKey =
    @"MDCTextInputControllerFullWidthErrorAccessibilityValueKey";
static NSString *const MDCTextInputControllerFullWidthErrorColorKey =
    @"MDCTextInputControllerFullWidthErrorColorKey";
static NSString *const MDCTextInputControllerFullWidthErrorTextKey =
    @"MDCTextInputControllerFullWidthErrorTextKey";
static NSString *const MDCTextInputControllerFullWidthHelperTextKey =
    @"MDCTextInputControllerFullWidthHelperTextKey";
static NSString *const MDCTextInputControllerFullWidthInlinePlaceholderColorKey =
    @"MDCTextInputControllerFullWidthInlinePlaceholderColorKey";
static NSString *const MDCTextInputControllerFullWidthPresentationStyleKey =
    @"MDCTextInputControllerFullWidthPresentationStyleKey";
static NSString *const MDCTextInputControllerFullWidthTextInputKey =
    @"MDCTextInputControllerFullWidthTextInputKey";
static NSString *const MDCTextInputControllerFullWidthUnderlineColorActiveKey =
    @"MDCTextInputControllerFullWidthUnderlineColorActiveKey";
static NSString *const MDCTextInputControllerFullWidthUnderlineColorNormalKey =
    @"MDCTextInputControllerFullWidthUnderlineColorNormalKey";
static NSString *const MDCTextInputControllerFullWidthUnderlineViewModeKey =
    @"MDCTextInputControllerFullWidthUnderlineViewModeKey";

static NSString *const MDCTextInputControllerFullWidthKVOKeyFont = @"font";

static inline UIColor *MDCTextInputInlinePlaceholderTextColorDefault() {
  return [UIColor colorWithWhite:0 alpha:MDCTextInputFullWidthHintTextOpacity];
}

static inline UIColor *MDCTextInputTextErrorColorDefault() {
  return [MDCPalette redPalette].accent400;
}

#pragma mark - Class Properties

static BOOL _mdc_adjustsFontForContentSizeCategoryDefault = YES;
static UIColor *_errorColorDefault;
static UIColor *_inlinePlaceholderColorDefault;

@interface MDCTextInputControllerFullWidth () {
  BOOL _mdc_adjustsFontForContentSizeCategory;

  UIColor *_inlinePlaceholderColor;
}

@property(nonatomic, assign, readonly) BOOL isDisplayingCharacterCountError;
@property(nonatomic, assign) BOOL isRegisteredForKVO;

@property(nonatomic, strong) MDCTextInputAllCharactersCounter *internalCharacterCounter;

@property(nonatomic, strong) NSLayoutConstraint *characterCountY;
@property(nonatomic, strong) NSLayoutConstraint *characterCountTrailing;
@property(nonatomic, strong) NSLayoutConstraint *clearButtonY;
@property(nonatomic, strong) NSLayoutConstraint *clearButtonTrailingCharacterCountLeading;
@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTop;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailingCharacterCountLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailingSuperviewTrailing;

@property(nonatomic, copy) NSString *errorAccessibilityValue;
@property(nonatomic, copy, readwrite) NSString *errorText;
@property(nonatomic, copy) NSString *previousLeadingText;

@property(nonatomic, strong) UIColor *previousPlaceholderColor;

@property(nonatomic, strong) UIFont *customPlaceholderFont;
@property(nonatomic, strong) UIFont *customTrailingFont;
@end

@implementation MDCTextInputControllerFullWidth

@synthesize characterCounter = _characterCounter;
@synthesize characterCountMax = _characterCountMax;
@synthesize characterCountViewMode = _characterCountViewMode;
@synthesize errorColor = _errorColor;
@synthesize textInput = _textInput;

// TODO: (larche): Support in-line auto complete.

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCTextInputControllerFullWidthInitialization];
  }

  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    [self commonMDCTextInputControllerFullWidthInitialization];

    _characterCounter =
        [aDecoder decodeObjectForKey:MDCTextInputControllerFullWidthCharacterCounterKey];
    _characterCountMax =
        [aDecoder decodeIntegerForKey:MDCTextInputControllerFullWidthCharacterCountMaxKey];
    _characterCountViewMode =
        [aDecoder decodeIntegerForKey:MDCTextInputControllerFullWidthCharacterCountViewModeKey];
    _errorColor = [aDecoder decodeObjectForKey:MDCTextInputControllerFullWidthErrorColorKey];
    _inlinePlaceholderColor =
        [aDecoder decodeObjectForKey:MDCTextInputControllerFullWidthInlinePlaceholderColorKey];
    _textInput = [aDecoder decodeObjectForKey:MDCTextInputControllerFullWidthTextInputKey];
  }
  return self;
}

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)textInput {
  self = [self init];
  if (self) {
    _textInput = textInput;

    [self setupInput];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  if ([self.characterCounter conformsToProtocol:@protocol(NSCoding)]) {
    [aCoder encodeObject:self.characterCounter
                  forKey:MDCTextInputControllerFullWidthCharacterCounterKey];
  }
  [aCoder encodeInteger:self.characterCountMax
                 forKey:MDCTextInputControllerFullWidthCharacterCountMaxKey];
  [aCoder encodeInteger:self.characterCountViewMode
                 forKey:MDCTextInputControllerFullWidthCharacterCountViewModeKey];
  [aCoder encodeObject:self.errorAccessibilityValue
                forKey:MDCTextInputControllerFullWidthErrorAccessibilityValueKey];
  [aCoder encodeObject:self.errorColor forKey:MDCTextInputControllerFullWidthErrorColorKey];
  [aCoder encodeObject:self.errorText forKey:MDCTextInputControllerFullWidthErrorTextKey];
  [aCoder encodeObject:self.helperText forKey:MDCTextInputControllerFullWidthHelperTextKey];
  [aCoder encodeObject:self.inlinePlaceholderColor
                forKey:MDCTextInputControllerFullWidthInlinePlaceholderColorKey];
  [aCoder encodeConditionalObject:self.textInput
                           forKey:MDCTextInputControllerFullWidthTextInputKey];
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCTextInputControllerFullWidth *copy = [[[self class] alloc] init];

  copy.characterCounter = self.characterCounter;  // Just a pointer value copy
  copy.characterCountViewMode = self.characterCountViewMode;
  copy.characterCountMax = self.characterCountMax;
  copy.errorAccessibilityValue = [self.errorAccessibilityValue copy];
  copy.errorColor = self.errorColor;
  copy.errorText = [self.errorText copy];
  copy.helperText = [self.helperText copy];
  copy.inlinePlaceholderColor = self.inlinePlaceholderColor;
  copy.previousLeadingText = [self.previousLeadingText copy];
  copy.previousPlaceholderColor = self.previousPlaceholderColor;
  copy.textInput = self.textInput;  // Just a pointer value copy
  copy.underlineColorActive = self.underlineColorActive;
  copy.underlineColorNormal = self.underlineColorNormal;

  return copy;
}

- (void)dealloc {
  [self unsubscribeFromNotifications];
  [self unsubscribeFromKVO];
}

- (void)commonMDCTextInputControllerFullWidthInitialization {
  _characterCountViewMode = UITextFieldViewModeAlways;
  _internalCharacterCounter = [MDCTextInputAllCharactersCounter new];
}

- (void)setupInput {
  if (!_textInput) {
    return;
  }

  // This controller will handle Dynamic Type and all fonts for the text input
  _mdc_adjustsFontForContentSizeCategory =
      _textInput.mdc_adjustsFontForContentSizeCategory ||
      [[self class] mdc_adjustsFontForContentSizeCategoryDefault];
  _textInput.mdc_adjustsFontForContentSizeCategory = NO;
  _textInput.positioningDelegate = self;

  [self subscribeForNotifications];
  [self subscribeForKVO];
  _textInput.underline.color = [UIColor clearColor];
  [self updateLayout];
}

- (void)subscribeForNotifications {
  if (!_textInput) {
    return;
  }
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];

  if ([_textInput isKindOfClass:[UITextField class]]) {
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidBeginEditing:)
                          name:UITextFieldTextDidBeginEditingNotification
                        object:_textInput];
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidChange:)
                          name:UITextFieldTextDidChangeNotification
                        object:_textInput];
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidEndEditing:)
                          name:UITextFieldTextDidEndEditingNotification
                        object:_textInput];
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidChange:)
                          name:MDCTextFieldTextDidSetTextNotification
                        object:_textInput];
  }

  if ([_textInput isKindOfClass:[UITextView class]]) {
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidBeginEditing:)
                          name:UITextViewTextDidBeginEditingNotification
                        object:_textInput];
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidChange:)
                          name:UITextViewTextDidChangeNotification
                        object:_textInput];
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidEndEditing:)
                          name:UITextViewTextDidEndEditingNotification
                        object:_textInput];
  }
}

- (void)unsubscribeFromNotifications {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self];
}

- (void)subscribeForKVO {
  if (!_textInput) {
    return;
  }
  [_textInput.placeholderLabel addObserver:self
                                forKeyPath:MDCTextInputControllerFullWidthKVOKeyFont
                                   options:0
                                   context:nil];
  [_textInput.trailingUnderlineLabel addObserver:self
                                      forKeyPath:MDCTextInputControllerFullWidthKVOKeyFont
                                         options:0
                                         context:nil];
  _isRegisteredForKVO = YES;
}

- (void)unsubscribeFromKVO {
  if (!self.textInput || !self.isRegisteredForKVO) {
    return;
  }
  @try {
    [self.textInput.placeholderLabel removeObserver:self
                                         forKeyPath:MDCTextInputControllerFullWidthKVOKeyFont];
    [self.textInput.trailingUnderlineLabel
        removeObserver:self
            forKeyPath:MDCTextInputControllerFullWidthKVOKeyFont];
  } @catch (NSException *exception) {
  }
  _isRegisteredForKVO = NO;
}

#pragma mark - Character Max Implementation

- (NSUInteger)characterCount {
  return [self.characterCounter characterCountForTextInput:self.textInput];
}

- (id<MDCTextInputCharacterCounter>)characterCounter {
  if (!_characterCounter) {
    _characterCounter = self.internalCharacterCounter;
  }
  return _characterCounter;
}

- (void)setCharacterCounter:(id<MDCTextInputCharacterCounter>)characterCounter {
  if (_characterCounter != characterCounter) {
    _characterCounter = characterCounter;
    [self updateLayout];
  }
}

- (void)setCharacterCountMax:(NSUInteger)characterCountMax {
  if (_characterCountMax != characterCountMax) {
    _characterCountMax = characterCountMax;
    [self updateLayout];
  }
}

#pragma mark - Leading Label Customization

- (void)updateLeadingUnderlineLabel {
  self.textInput.leadingUnderlineLabel.text = nil;
}

#pragma mark - Placeholder Customization

- (void)updatePlaceholder {
  if (!self.customPlaceholderFont) {
    self.textInput.placeholderLabel.font = [[self class] placeholderFont];
  }

  self.textInput.placeholderLabel.textColor = self.inlinePlaceholderColor;
}

#pragma mark - Trailing Label Customization

- (void)updateTrailingUnderlineLabel {
  if (!self.characterCountMax) {
    self.textInput.trailingUnderlineLabel.text = nil;
  } else {
    self.textInput.trailingUnderlineLabel.text = [self characterCountText];
    if (!self.customTrailingFont) {
      self.textInput.trailingUnderlineLabel.font = [[self class] underlineLabelsFont];
    }
  }

  UIColor *textColor = [[self class] inlinePlaceholderColorDefault];

  if (self.isDisplayingCharacterCountError || self.isDisplayingErrorText) {
    textColor = self.errorColor;
  }

  switch (self.characterCountViewMode) {
    case UITextFieldViewModeAlways:
      break;
    case UITextFieldViewModeWhileEditing:
      textColor = !self.textInput.isEditing ? [UIColor clearColor] : textColor;
      break;
    case UITextFieldViewModeUnlessEditing:
      textColor = self.textInput.isEditing ? [UIColor clearColor] : textColor;
      break;
    case UITextFieldViewModeNever:
      textColor = [UIColor clearColor];
      break;
  }

  self.textInput.trailingUnderlineLabel.textColor = textColor;
}

- (NSString *)characterCountText {
  // TODO: (larche) Localize
  return [NSString stringWithFormat:@"%lu / %lu", (unsigned long)[self characterCount],
                                    (unsigned long)self.characterCountMax];
}

#pragma mark - Underline Customization

- (void)updateUnderline {
  // Hide the underline.
  self.textInput.underline.color = [UIColor clearColor];
}

#pragma mark - Underline Labels Fonts

+ (UIFont *)placeholderFont {
  return [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
}

+ (UIFont *)underlineLabelsFont {
  return [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleCaption];
}

#pragma mark - Properties Implementation

- (void)setCharacterCountViewMode:(UITextFieldViewMode)characterCountViewMode {
  if (_characterCountViewMode != characterCountViewMode) {
    _characterCountViewMode = characterCountViewMode;

    [self updateLayout];
  }
}

- (void)setErrorAccessibilityValue:(NSString *)errorAccessibilityValue {
  _errorAccessibilityValue = [errorAccessibilityValue copy];
}

- (UIColor *)errorColor {
  if (!_errorColor) {
    _errorColor = [[self class] errorColorDefault];
  }
  return _errorColor;
}

- (void)setErrorColor:(UIColor *)errorColor {
  if (![_errorColor isEqual:errorColor]) {
    _errorColor = errorColor ? errorColor : [[self class] errorColorDefault];
    if (self.isDisplayingCharacterCountError || self.isDisplayingErrorText) {
      [self updateLeadingUnderlineLabel];
      [self updatePlaceholder];
      [self updateTrailingUnderlineLabel];
      [self updateUnderline];
    }
  }
}

+ (UIColor *)errorColorDefault {
  if (!_errorColorDefault) {
    _errorColorDefault = MDCTextInputTextErrorColorDefault();
  }
  return _errorColorDefault;
}

+ (void)setErrorColorDefault:(UIColor *)errorColorDefault {
  _errorColorDefault = errorColorDefault ? errorColorDefault : MDCTextInputTextErrorColorDefault();
}

- (void)setErrorText:(NSString *)errorText {
  _errorText = [errorText copy];
}

- (void)setHelperText:(NSString *)helperText {
  if (self.isDisplayingErrorText) {
    self.previousLeadingText = helperText;
  } else {
    if (![self.textInput.leadingUnderlineLabel.text isEqualToString:helperText]) {
      self.textInput.leadingUnderlineLabel.text = helperText;
      [self updateLayout];
    }
  }
}

- (NSString *)helperText {
  if (self.isDisplayingErrorText) {
    return self.previousLeadingText;
  } else {
    return self.textInput.leadingUnderlineLabel.text;
  }
}

- (void)setInlinePlaceholderColor:(UIColor *)inlinePlaceholderColor {
  if (![_inlinePlaceholderColor isEqual:inlinePlaceholderColor]) {
    _inlinePlaceholderColor = inlinePlaceholderColor;
    [self updatePlaceholder];
  }
}

- (UIColor *)inlinePlaceholderColor {
  return _inlinePlaceholderColor ? _inlinePlaceholderColor
                                 : [[self class] inlinePlaceholderColorDefault];
}

+ (UIColor *)inlinePlaceholderColorDefault {
  if (!_inlinePlaceholderColorDefault) {
    _inlinePlaceholderColorDefault = MDCTextInputInlinePlaceholderTextColorDefault();
  }
  return _inlinePlaceholderColorDefault;
}

+ (void)setInlinePlaceholderColorDefault:(UIColor *)inlinePlaceholderColorDefault {
  _inlinePlaceholderColorDefault = inlinePlaceholderColorDefault
                                       ? inlinePlaceholderColorDefault
                                       : MDCTextInputInlinePlaceholderTextColorDefault();
}

- (BOOL)isDisplayingCharacterCountError {
  return self.characterCountMax && [self characterCount] > self.characterCountMax;
}

- (BOOL)isDisplayingErrorText {
  return self.errorText != nil;
}

- (void)setPreviousLeadingText:(NSString *)previousLeadingText {
  _previousLeadingText = [previousLeadingText copy];
}

- (void)setPreviousPlaceholderColor:(UIColor *)previousPlaceholderColor {
  _previousPlaceholderColor = previousPlaceholderColor;
}

- (void)setTextInput:(UIView<MDCTextInput> *)textInput {
  if (_textInput != textInput) {
    [self unsubscribeFromNotifications];
    [self unsubscribeFromKVO];

    _textInput = textInput;
    [self setupInput];
  }
}

- (void)setUnderlineColorActive:(UIColor *)underlineColorActive {
  [self updateUnderline];
}

- (UIColor *)underlineColorActive {
  return [UIColor clearColor];
}

+ (UIColor *)underlineColorActiveDefault {
  return [UIColor clearColor];
}

+ (void)setUnderlineColorActiveDefault:(UIColor *)underlineColorActiveDefault {
  // Not implemented. Underline is always clear.
}

- (void)setUnderlineColorNormal:(UIColor *)underlineColorNormal {
  [self updateUnderline];
}

- (UIColor *)underlineColorNormal {
  return [UIColor clearColor];
}

+ (void)setUnderlineColorNormalDefault:(UIColor *)underlineColorNormalDefault {
  // Not implemented. Underline is always clear.
}

+ (UIColor *)underlineColorNormalDefault {
  return [UIColor clearColor];
}

- (void)setUnderlineViewMode:(UITextFieldViewMode)underlineViewMode {
  [self updateLayout];
}

- (UITextFieldViewMode)underlineViewMode {
  return UITextFieldViewModeNever;
}

+ (UITextFieldViewMode)underlineViewModeDefault {
  return UITextFieldViewModeNever;
}

+ (void)setUnderlineViewModeDefault:(UITextFieldViewMode)underlineViewModeDefault {
  // Not implemented. Underline is never shown.
}

#pragma mark - Layout

- (void)updateLayout {
  if (!_textInput) {
    return;
  }

  [self updatePlaceholder];
  [self updateLeadingUnderlineLabel];
  [self updateTrailingUnderlineLabel];
  [self updateUnderline];
  [self updateConstraints];
}

- (void)updateConstraints {
  if (!self.heightConstraint) {
    self.heightConstraint = [NSLayoutConstraint constraintWithItem:self.textInput
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1
                                                          constant:0];
  }

  if (!self.characterCountTrailing) {
    self.characterCountTrailing =
        [NSLayoutConstraint constraintWithItem:self.textInput.trailingUnderlineLabel
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:-1 * MDCTextInputFullWidthHorizontalPadding];
  }
  if (!self.clearButtonTrailingCharacterCountLeading) {
    self.clearButtonTrailingCharacterCountLeading =
        [NSLayoutConstraint constraintWithItem:self.textInput.clearButton
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput.trailingUnderlineLabel
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:0];
  }
  if (!self.clearButtonY) {
    self.clearButtonY = [NSLayoutConstraint constraintWithItem:self.textInput.clearButton
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.textInput
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0];
  }
  if (!self.placeholderLeading) {
    self.placeholderLeading =
        [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:MDCTextInputFullWidthHorizontalPadding];
  }
  if (!self.placeholderTrailingCharacterCountLeading) {
    self.placeholderTrailingCharacterCountLeading =
        [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                        toItem:self.textInput.trailingUnderlineLabel
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:-1 * MDCTextInputFullWidthHorizontalInnerPadding];
  }
  if (!self.placeholderTrailingSuperviewTrailing) {
    self.placeholderTrailingSuperviewTrailing =
        [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                        toItem:self.textInput
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:-1 * MDCTextInputFullWidthHorizontalPadding];
  }

  // Multi Line Only
  // .fullWidth
  if ([self.textInput isKindOfClass:[UITextView class]]) {
    [self.textInput.leadingUnderlineLabel setContentHuggingPriority:UILayoutPriorityRequired
                                                            forAxis:UILayoutConstraintAxisVertical];
    [self.textInput.leadingUnderlineLabel
        setContentCompressionResistancePriority:UILayoutPriorityRequired
                                        forAxis:UILayoutConstraintAxisVertical];

    [self.textInput.trailingUnderlineLabel
        setContentCompressionResistancePriority:UILayoutPriorityRequired
                                        forAxis:UILayoutConstraintAxisVertical];
    if (!self.characterCountY) {
      self.characterCountY =
          [NSLayoutConstraint constraintWithItem:self.textInput.trailingUnderlineLabel
                                       attribute:NSLayoutAttributeBottom
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.textInput
                                       attribute:NSLayoutAttributeBottom
                                      multiplier:1
                                        constant:0];
    }

  } else {
    // Single Line Only
    // .fullWidth
    self.heightConstraint.constant =
        2 * MDCTextInputFullWidthVerticalPadding + MDCRint(self.textInput.font.lineHeight);

    if (!self.characterCountY) {
      self.characterCountY =
          [NSLayoutConstraint constraintWithItem:self.textInput.trailingUnderlineLabel
                                       attribute:NSLayoutAttributeCenterY
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.textInput
                                       attribute:NSLayoutAttributeCenterY
                                      multiplier:1
                                        constant:0];
    }
  }
  [NSLayoutConstraint activateConstraints:@[
    self.characterCountY, self.characterCountTrailing,
    self.clearButtonTrailingCharacterCountLeading, self.clearButtonY, self.placeholderLeading,
    self.placeholderTrailingCharacterCountLeading, self.placeholderTrailingSuperviewTrailing
  ]];

  [self.textInput.trailingUnderlineLabel setContentHuggingPriority:UILayoutPriorityRequired
                                                           forAxis:UILayoutConstraintAxisVertical];
  self.heightConstraint.active = !self.textInput.translatesAutoresizingMaskIntoConstraints;
}

- (void)updateFontsForDynamicType {
  if (self.mdc_adjustsFontForContentSizeCategory) {
    UIFont *textFont = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
    self.textInput.font = textFont;

    [self updateLayout];
  }
}

#pragma mark - MDCTextFieldPositioningDelegate

// clang-format off
/**
 textContainerInset: is the source of truth for vertical layout. It's used to figure out the proper
 height and also where to place the placeholder / text field.

 NOTE: It's applied before the textRect is flipped for RTL. So all calculations are done here ?? la
 LTR.

 The vertical layout is, at most complex, this form:
 MDCTextInputVerticalPadding +                                        // Top padding
 MDCRint(self.textInput.placeholderLabel.font.lineHeight * scale) +   // Placeholder when up
 MDCTextInputVerticalHalfPadding +                                    // Small padding
 MDCRint(MAX(self.textInput.font.lineHeight,                          // Text field or placeholder
 self.textInput.placeholderLabel.font.lineHeight)) +
 MDCTextInputVerticalHalfPadding +                                    // Small padding
 --Underline-- (height not counted)                                   // Underline (height ignored)
 MAX(underlineLabelsOffset,MDCTextInputVerticalHalfPadding)           // Padding and/or labels
 */
// clang-format on
- (UIEdgeInsets)textContainerInset:(UIEdgeInsets)defaultInsets {
  // NOTE: UITextFields have a centerY based layout. But you can change EITHER the height or the Y.
  // Not both. Don't know why. So, we have to leave the text rect as big as the bounds and move it
  // to a Y that works. In other words, no bottom inset will make a difference here for UITextFields
  UIEdgeInsets textContainerInset = UIEdgeInsetsZero;

  textContainerInset.top = MDCTextInputFullWidthVerticalPadding;
  textContainerInset.bottom = MDCTextInputFullWidthVerticalPadding;
  textContainerInset.left = MDCTextInputFullWidthHorizontalPadding;
  textContainerInset.right = MDCTextInputFullWidthHorizontalPadding;

  // The trailing label gets in the way. If it has a frame, it's used. But if not, an
  // estimate is made of the size the text will be.
  if (CGRectGetWidth(self.textInput.trailingUnderlineLabel.frame) > 1.f) {
    textContainerInset.right +=
        MDCCeil(CGRectGetWidth(self.textInput.trailingUnderlineLabel.frame));
  } else if (self.characterCountMax) {
    CGRect charCountRect = [[self characterCountText]
        boundingRectWithSize:self.textInput.bounds.size
                     options:NSStringDrawingUsesLineFragmentOrigin
                  attributes:@{
                    NSFontAttributeName : self.textInput.trailingUnderlineLabel.font
                  }
                     context:nil];
    textContainerInset.right += MDCCeil(CGRectGetWidth(charCountRect));
  }

  return textContainerInset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds defaultRect:(CGRect)defaultRect {
  if (![self.textInput isKindOfClass:[UITextField class]]) {
    return CGRectZero;
  }

  MDCTextField *textField = (MDCTextField *)self.textInput;
  CGRect editingRect = defaultRect;

  // Full width text fields have their clear button in the horizontal margin, but because the
  // internal implementation of textRect calls [super clearButtonRectForBounds:] in its
  // implementation, our modifications are not picked up. Adjust accordingly.
  // Full width text boxes have their character count on the text input line
  if (self.textInput.text.length > 0) {
    switch (textField.clearButtonMode) {
      case UITextFieldViewModeWhileEditing:
        editingRect.size.width -= CGRectGetWidth(self.textInput.clearButton.bounds);
      case UITextFieldViewModeUnlessEditing:
        // The 'defaultRect' is based on the textContainerInsets so we need to compensate for
        // the button NOT being there.
        editingRect.size.width += CGRectGetWidth(self.textInput.clearButton.bounds);
        editingRect.size.width -= MDCTextInputFullWidthHorizontalInnerPadding;
        break;
      default:
        break;
    }
  }

  return editingRect;
}

- (CGSize)sizeThatFits:(CGSize)size defaultSize:(CGSize)defaultSize {
  CGSize newSize = defaultSize;
  newSize.height = self.heightConstraint.constant;

  return newSize;
}

#pragma mark - UITextField & UITextView Notification Observation

- (void)textInputDidBeginEditing:(NSNotification *)note {
  [self updateLayout];

  if (self.characterCountMax > 0) {
    NSString *announcementString;
    if (!announcementString.length) {
      announcementString = [NSString
          stringWithFormat:@"%lu character limit.", (unsigned long)self.characterCountMax];
    }

    // Simply sending a layout change notification does not seem to
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, announcementString);
  }
}

- (void)textInputDidChange:(NSNotification *)note {
  [self updateLayout];

  // Accessibility
  if (self.textInput.isEditing && self.characterCountMax > 0) {
    NSString *announcementString;
    if (!announcementString.length) {
      announcementString = [NSString
          stringWithFormat:@"%lu characters remaining",
                           (unsigned long)(self.characterCountMax -
                                           [self.characterCounter
                                               characterCountForTextInput:self.textInput])];
    }

    // Simply sending a layout change notification does not seem to
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, announcementString);
  }
}

- (void)textInputDidEndEditing:(NSNotification *)note {
  [self updateLayout];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
  // Listening to outside setting of custom fonts.
  if (![keyPath isEqualToString:MDCTextInputControllerFullWidthKVOKeyFont]) {
    return;
  }

  if (object == _textInput.placeholderLabel &&
      ![_textInput.placeholderLabel.font isEqual:[[self class] placeholderFont]]) {
    _customPlaceholderFont = _textInput.placeholderLabel.font;
  } else if (object == _textInput.trailingUnderlineLabel &&
             ![_textInput.trailingUnderlineLabel.font isEqual:[[self class] underlineLabelsFont]]) {
    _customTrailingFont = _textInput.trailingUnderlineLabel.font;
  } else {
    return;
  }
  [self updateLayout];
}

#pragma mark - Public API

- (void)setErrorText:(NSString *)errorText
    errorAccessibilityValue:(NSString *)errorAccessibilityValue {
  // Turn on error:
  //
  // Here the 'magic' logic happens for error text.
  // When the user sets error text, we save the current state of their underline, leading text,
  // trailing text, and placeholder text for both content and color.
  if (errorText && !self.isDisplayingErrorText) {
    // If we are not in error, but will be, we need to save the existing state.
    self.previousLeadingText = self.textInput.leadingUnderlineLabel.text
                                   ? self.textInput.leadingUnderlineLabel.text.copy
                                   : @"";

    self.textInput.leadingUnderlineLabel.text = errorText;

    [self updatePlaceholder];
  }

  // Change error:
  if (errorText && self.isDisplayingErrorText) {
    self.textInput.leadingUnderlineLabel.text = errorText;
  }

  // Turn off error:
  //
  // If error text is unset (nil) we reset to previous values.
  if (!errorText) {
    // If there is a saved state, use it.
    if (self.previousLeadingText) {
      self.textInput.leadingUnderlineLabel.text = self.previousLeadingText;
    }

    // Clear out saved state.
    self.previousLeadingText = nil;
  }

  self.errorText = errorText;
  self.errorAccessibilityValue = errorAccessibilityValue;

  [self updateLayout];

  // Accessibility
  // TODO: (larche) Localize
  if (errorText) {
    NSString *announcementString = errorAccessibilityValue;
    if (!announcementString.length) {
      announcementString =
          errorText.length > 0 ? [NSString stringWithFormat:@"Error: %@", errorText] : @"Error.";
    }

    // Simply sending a layout change notification does not seem to
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, announcementString);

    NSString *valueString = @"";

    if (self.textInput.text.length > 0) {
      valueString = [self.textInput.text copy];
    }
    if (self.textInput.placeholder.length > 0) {
      valueString = [NSString stringWithFormat:@"%@. %@", valueString, self.textInput.placeholder];
    }
    valueString = [valueString stringByAppendingString:@"."];

    self.textInput.accessibilityValue = valueString;
    NSString *leadingUnderlineLabelText = self.textInput.leadingUnderlineLabel.text;
    self.textInput.leadingUnderlineLabel.accessibilityLabel = [NSString
        stringWithFormat:@"Error: %@.", leadingUnderlineLabelText ?
                                                               leadingUnderlineLabelText : @""];
  } else {
    self.textInput.accessibilityValue = nil;
    self.textInput.leadingUnderlineLabel.accessibilityLabel = nil;
  }
}

#pragma mark - Accessibility

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  if (_mdc_adjustsFontForContentSizeCategory) {
    [self updateFontsForDynamicType];
  }

  if (_mdc_adjustsFontForContentSizeCategory) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
  } else {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
  }
}

+ (BOOL)mdc_adjustsFontForContentSizeCategoryDefault {
  return _mdc_adjustsFontForContentSizeCategoryDefault;
}

+ (void)setMdc_adjustsFontForContentSizeCategoryDefault:
        (BOOL)mdc_adjustsFontForContentSizeCategoryDefault {
  _mdc_adjustsFontForContentSizeCategoryDefault = mdc_adjustsFontForContentSizeCategoryDefault;
}

- (void)contentSizeCategoryDidChange:(NSNotification *)notification {
  [self updateFontsForDynamicType];
}

@end
