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
@property (strong, nonatomic) NSString *operation;
@end

@implementation CalculatorViewController

- (IBAction)touchDigitButton:(UIButton *)sender {
    if (!_operation) {
        _register1 *= 10.0;
        _register1 += sender.currentTitle.intValue;
        _display.text = [NSString stringWithFormat:@"%g", _register1];
    } else {
        _register2 *= 10.0;
        _register2 += sender.currentTitle.intValue;
        _display.text = [NSString stringWithFormat:@"%g", _register2];
    }
    
}

- (IBAction)touchOperationButton:(UIButton *)sender {
    if (_register1) {
        [self eval];
        _operation = sender.currentTitle;
    }
}

- (void)eval {
    if ([_operation isEqualToString:@"/"]) {
        _register1 = _register1 / _register2;
        _display.text = [NSString stringWithFormat:@"%g", _register1];
    } else if ([_operation isEqualToString:@"*"]) {
        _register1 = _register1 * _register2;
        _display.text = [NSString stringWithFormat:@"%g", _register1];
    } else if ([_operation isEqualToString:@"-"]) {
        _register1 = _register1 - _register2;
        _display.text = [NSString stringWithFormat:@"%g", _register1];
    } else if ([_operation isEqualToString:@"+"]) {
        _register1 = _register1 + _register2;
        _display.text = [NSString stringWithFormat:@"%g", _register1];
    } else {
        
    }
    
    _register2 = 0;
    _operation = nil;
}

- (IBAction)touchClearButton:(UIButton *)sender {
    _display.text = @"0";
    _register1 = 0;
    _register2 = 0;
    _operation = nil;
}

- (IBAction)touchDotButton:(UIButton *)sender {
}

@end
