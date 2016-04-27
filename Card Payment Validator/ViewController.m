//
//  ViewController.m
//  Card Payment Validator
//
//  Created by Taiyaba Sultana on 4/24/16.
//  Copyright © 2016 Abdul Kareem. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cardProvider;
@property (weak, nonatomic) IBOutlet UILabel *validationResult;
@property (weak, nonatomic) IBOutlet UITextField *editField;

- (void) numberValidationAlgorithm: (NSString *) number;
- (void) identifyServiceProvider: (NSString *) number;
- (unsigned short) convertFromAsciiToNumber: (unsigned short) toBeConvertedFromAscii;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (unsigned short) convertFromAsciiToNumber: (unsigned short) toBeConvertedFromAscii {
    //NSLog(@"Number being carried is %hu", toBeConvertedFromAscii);
    switch (toBeConvertedFromAscii) {
        case 49:
            return 1;
        case 50:
            return 2;
        case 51:
            return 3;
        case 52:
            return 4;
        case 53:
            return 5;
        case 54:
            return 6;
        case 55:
            return 7;
        case 56:
            return 8;
        case 57:
            return 9;
        default:
            return 0;
    }
}

- (void) numberValidationAlgorithm: (NSString*) number{
    
    //variable sum collects the sum of all digits but check digit
    NSInteger sum1;
    NSInteger sum2;
    NSInteger sum;
    
    
    //loop for digits excluding check digit and alternate since then
    for (int index1 = 14; 0 <= index1; index1 -= 2) {
        
        //varibale temp used to check whether the product of a digit is greater than 9
        unsigned short temp1 = [self convertFromAsciiToNumber: [number characterAtIndex:index1]];
        if ( temp1 * 2 > 9) {
            sum1 += ((temp1 *2) - 9);
        }
        else {
            sum1 += temp1 * 2;
        }
        NSLog(@"number went for conversion is %hu and came is %hu",[number characterAtIndex:index1], temp1);
        NSLog(@"sum at excluding check alernate is %ld\n\n", (long)sum1);
    }
    //loop for digits including check digit and alternate since then
    for (int index2 = 15; 1 <= index2; index2 -= 2) {
        
        //varibale temp used to check whether the product of a digit is greater than 9
        unsigned short temp2 = [self convertFromAsciiToNumber: [number characterAtIndex:index2]];
        sum2 += temp2;
        NSLog(@"number went for conversion is %hu and came is %hu",[number characterAtIndex:index2], temp2);
        NSLog(@"sum at excluding check alernate is %ld\n\n", (long)sum2);

    }
    sum = sum1 + sum2;
    NSLog(@"Sum is %ld", (long)sum);
    if (sum % 10 == 0) {
        self.validationResult.text = @"Yup valid card";
    } else {
        self.validationResult.text = @"Sorry invalid card";
    }
    [self identifyServiceProvider:number];
    
}

-(void) identifyServiceProvider: (NSString *) number {
    
}


- (IBAction)validateCardNumber:(id)sender {
    NSLog(@"your card number length %lu", self.editField.text.length);
    //NSLog(@"Number at index 1 is %hu", [self.editField.text characterAtIndex:1]);
    if (self.editField.text.length == 16) {
        NSString * cardNumber = self.editField.text;
        [self numberValidationAlgorithm: cardNumber];
    }
    else
        self.editField.text = [NSString stringWithFormat:@"Enter 16 digit number     %@", self.editField.text ];
    
}

- (IBAction)clearEditingField:(id)sender {
    self.validationResult.text = @"";
    self.cardProvider.text = @"";
}

@end
