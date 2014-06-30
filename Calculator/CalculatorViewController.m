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
@property (nonatomic) float tens;
@property (strong, nonatomic) NSString *operation;
@property BOOL dot;
@end

@implementation CalculatorViewController

- (float)tens {
    if (!_tens) {
        _tens = 1;
    }
    return _tens;
}

- (IBAction)touchDigitButton:(UIButton *)sender {
    
    if ([_operation isEqualToString:@"="]) {
        [self reset];
    }
    
    if (!_operation) {
        _register1 *= _dot ? 1.0 : 10.0;
        _register1 += _dot ? 0.0 : sender.currentTitle.intValue;
        _register3 *= _dot ? 10.0 : 1.0;
        _register3 += _dot ? sender.currentTitle.intValue : 0.0;
        self.tens *= (_dot ? 0.1 : 1);
        _display.text = [NSString stringWithFormat:@"%g", _register1 + self.tens * _register3];
    } else {
        _register2 *= _dot ? 1.0 : 10.0;
        _register2 += _dot ? 0.0 : sender.currentTitle.intValue;
        _register3 *= _dot ? 10.0 : 1.0;
        _register3 += _dot ? sender.currentTitle.intValue : 0.0;
        self.tens *= (_dot ? 0.1 : 1);
        _display.text = [NSString stringWithFormat:@"%g", _register2 + self.tens * _register3];
    }
}

- (IBAction)touchOperationButton:(UIButton *)sender {
    if (_register1) {
        if (_operation) {
            _register2 = _register2 + self.tens * _register3;
            [self eval];
            _register2 = 0;
        } else {
            _register1 = _register1 + self.tens * _register3;
        }
        
        _operation = sender.currentTitle;
    }
    
    _dot = NO;
    _register3 = 0;
    _tens = 1;
}

- (void)eval {
    
//    NSLog(@"%f", _register1);
//    NSLog(@"%f", _register2);
//    NSLog(@"%f", _register3);
//    NSLog(@"%f", _tens);
    
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
    NSLog(@"%f", _register1);
}

- (IBAction)touchClearButton:(UIButton *)sender {
    _display.text = @"0";
    [self reset];
}

- (void)reset {
    _register1 = 0;
    _register2 = 0;
    _register3 = 0;
    _dot = NO;
    _tens = 1;
    _operation = nil;
}

- (IBAction)touchDotButton:(UIButton *)sender {
    _dot = YES;
    _display.text = [_display.text stringByAppendingString:@"."];
}

@end
