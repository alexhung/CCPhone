//
//  ProjectDetailsTableViewCell.m
//  CCPhone
//
//  Created by Alex Hung on 6/28/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import "OptionsServerUrlTableViewCell.h"


@implementation OptionsServerUrlTableViewCell

@synthesize title;
@synthesize ccServer;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {

		self.selectionStyle = UITableViewCellSelectionStyleNone;

		titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		
		titleLabel.textAlignment = UITextAlignmentLeft;
		titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
		titleLabel.textColor = [UIColor blackColor];
		titleLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:titleLabel];
		
		contentTextField = [[[UITextField alloc] initWithFrame:CGRectZero] autorelease];
		contentTextField.borderStyle = UITextBorderStyleNone;
		contentTextField.font =[UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
		contentTextField.textColor = [UIColor colorWithRed:0.384 green:0.459 blue:0.612 alpha:1.0];
		contentTextField.backgroundColor = [UIColor clearColor];
		contentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		contentTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		contentTextField.enablesReturnKeyAutomatically = YES;
		contentTextField.keyboardType = UIKeyboardTypeURL;
		contentTextField.returnKeyType = UIReturnKeyDefault;
		contentTextField.delegate = self;
		
		[self addSubview:contentTextField];
	}
	return self;
}

- (void)layoutSubviews {
	
    [super layoutSubviews];
	
	CGRect contentRect = self.contentView.bounds;

    if (!self.editing) {
		
		titleLabel.frame = CGRectMake(contentRect.origin.x + 20, contentRect.origin.y + 1,
									  50, contentRect.size.height);
		contentTextField.frame = CGRectMake(titleLabel.frame.size.width + 30, contentRect.origin.y + 14,
										(contentRect.size.width - titleLabel.frame.size.width) - 20, contentRect.size.height - 26);
	}
}

- (void)setTitle:(NSString *)newTitle {
	
	titleLabel.text = newTitle;
}

- (void)setCcServer:(CCServer *)newCCServer {
	
	ccServer = newCCServer;
	contentTextField.text = newCCServer.url.absoluteString;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	
	ccServer.url = [NSURL URLWithString:contentTextField.text];
	[ccServer save];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}


- (void)dealloc {
	[ccServer release];
	[super dealloc];
}


@end
