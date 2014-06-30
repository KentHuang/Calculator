//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Kent Huang on 6/30/14.
//  Copyright (c) 2014 Kent Huang. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *display;
@property float register1;
@property float register2;
@property float register3;
@property (nonatomic)  float tens;
@property (strong, nonatomic) NSString *operation;
@property BOOL dot;
@end

@implementation CalculatorViewController

- (float)tens {
    if (!_tens) {
        _tens = 0.1;
    }
    return _tens;
}

- (IBAction)touchDigitButton:(UIButton *)sender {
    if (!_operation) {
        _register1 *= _dot ? 1.0 : 10.0;
        _register1 += _dot ? 0.0 : sender.currentTitle.intValue;
        _register3 *= _dot ? 10.0 : 1.0;
        _register3 += _dot ? sender.currentTitle.intValue : 0.0;
        _register1 = _register1 + _tens * _register3;
        _tens = 0.1 * _tens;
        NSString *one = [NSString stringWithFormat:@"%g", _register1];
        NSString *three = [NSString stringWithFormat:@"%g", _register3];
        _display.text = _dot ? [NSString stringWithFormat:@"%@%@%@", one, @".", three] : one;
    } else {
        _register2 *= _dot ? 1.0 : 10.0;
        _register2 += _dot ? 0.0 : sender.currentTitle.intValue;
        _register3 *= _dot ? 10.0 : 1.0;
        _register3 += _dot ? sender.currentTitle.intValue : 0.0;
        _register2 = _register2 + _tens * _register3;
        _tens = 0.1 * _tens;
        NSString *two = [NSString stringWithFormat:@"%g", _register2];
        NSString *three = [NSString stringWithFormat:@"%g", _register3];
        _display.text = _dot ? [NSString stringWithFormat:@"%@%@%@", two, @".", three] : two;
    }
}

- (IBAction)touchOperationButton:(UIButton *)sender {
    if (_register1) {
        [self eval];
        _operation = sender.currentTitle;
        _tens = 0.1;
        _dot = NO;
        _register3 = 0;
    }
}

- (void)eval {
    if ([_operation isEqualToString:@"/"]) {
        _register1 = _register1 / _register2;
        _display.text = [NSString stringWithFormat:@"%f", _register1];
    } else if ([_operation isEqualToString:@"*"]) {
        _register1 = _register1 * _register2;
        _display.text = [NSString stringWithFormat:@"%f", _register1];
    } else if ([_operation isEqualToString:@"-"]) {
        _register1 = _register1 - _register2;
        _display.text = [NSString stringWithFormat:@"%f", _register1];
    } else if ([_operation isEqualToString:@"+"]) {
        _register1 = _register1 + _register2;
        _display.text = [NSString stringWithFormat:@"%f", _register1];
    } else {
        
    }
    
    _register2 = 0;
    _operation = nil;
}

- (IBAction)touchClearButton:(UIButton *)sender {
    _display.text = @"0";
    _register1 = 0;
    _register2 = 0;
    _register3 = 0;
    _dot = NO;
    _tens = 0.1;
    _operation = nil;
}

- (IBAction)touchDotButton:(UIButton *)sender {
    _dot = YES;
    _display.text = [_display.text stringByAppendingString:@"."];
}

@end
