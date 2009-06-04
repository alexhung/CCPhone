//
//  OptionsServerTypeTableViewCell.m
//  CCPhone
//
//  Created by Alex Hung on 12/7/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import "OptionsServerTypeTableViewCell.h"


@implementation OptionsServerTypeTableViewCell

@synthesize title;
@synthesize content;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		
		titleLabel.textAlignment = UITextAlignmentLeft;
		titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
		titleLabel.textColor = [UIColor blackColor];
		titleLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:titleLabel];
		
		contentLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		contentLabel.font =[UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
		contentLabel.textColor = [UIColor colorWithRed:0.384 green:0.459 blue:0.612 alpha:1.0];
		contentLabel.backgroundColor = [UIColor clearColor];
		contentLabel.highlightedTextColor = [UIColor whiteColor];
		[self addSubview:contentLabel];
    }
    return self;
}

- (void)layoutSubviews {
	
    [super layoutSubviews];
	
	CGRect contentRect = self.contentView.bounds;
	
    if (!self.editing) {
		
		titleLabel.frame = CGRectMake(contentRect.origin.x + 20, contentRect.origin.y + 1,
									  50, contentRect.size.height);
		contentLabel.frame = CGRectMake(titleLabel.frame.size.width + 30, contentRect.origin.y + 14,
											(contentRect.size.width - titleLabel.frame.size.width) - 20, contentRect.size.height - 26);
	}
}

- (void)setTitle:(NSString *)newTitle {
	
	titleLabel.text = newTitle;
}

- (void)setContent:(NSString *)newContent {
	
	contentLabel.text = newContent;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
