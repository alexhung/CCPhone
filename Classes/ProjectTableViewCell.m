#import "ProjectTableViewCell.h"
#import "CCPhoneAppDelegate.h"

@implementation ProjectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		buildStatusImageView = [[UIImageView alloc] init];
		[self.contentView addSubview:buildStatusImageView];
		[buildStatusImageView release];
		
		projectNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		projectNameLabel.font = [UIFont boldSystemFontOfSize:18];
		projectNameLabel.textAlignment = UITextAlignmentLeft;
		projectNameLabel.textColor = [UIColor whiteColor];
		projectNameLabel.backgroundColor = [UIColor clearColor];
		projectNameLabel.opaque = YES;
		[self.contentView addSubview:projectNameLabel];
		[projectNameLabel release];
		
		lastBuildTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		lastBuildTimeLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
		lastBuildTimeLabel.textAlignment = UITextAlignmentLeft;
		lastBuildTimeLabel.textColor = [UIColor lightGrayColor];
		lastBuildTimeLabel.backgroundColor = [UIColor clearColor];
		lastBuildTimeLabel.opaque = YES;
		[self.contentView addSubview:lastBuildTimeLabel];
		[lastBuildTimeLabel release];
	}
	return self;
}

- (void)layoutSubviews {
	
#define LEFT_COLUMN_OFFSET 10
#define LEFT_COLUMN_WIDTH 40

#define RIGHT_COLUMN_OFFSET 60
#define RIGHT_COLUMN_WIDTH 200
	
#define UPPER_ROW_TOP 11
#define LOWER_ROW_TOP 36
	
	[super layoutSubviews];
	CGRect contentRect = self.contentView.bounds;

// In this example we will never be editing, but this illustrates the appropriate pattern
	if (!self.editing) {
		
		CGFloat boundsX = contentRect.origin.x;
		CGRect frame;

		frame = CGRectMake(boundsX + LEFT_COLUMN_OFFSET, UPPER_ROW_TOP, LEFT_COLUMN_WIDTH, 40);
		buildStatusImageView.frame = frame;

		frame = CGRectMake(boundsX + RIGHT_COLUMN_OFFSET, UPPER_ROW_TOP, RIGHT_COLUMN_WIDTH, 20);
		projectNameLabel.frame = frame;
		
		frame = CGRectMake(boundsX + RIGHT_COLUMN_OFFSET, LOWER_ROW_TOP, RIGHT_COLUMN_WIDTH, 14);
		lastBuildTimeLabel.frame = frame;
	}
}

- (void)setProject:(CCProject *)newProject {
	buildStatusImageView.image = [self getBuildStatusImage:newProject.activity lastBuildStatus:newProject.lastBuildStatus];
	projectNameLabel.text = newProject.name;
	lastBuildTimeLabel.text = [CCProject convertDateToString:newProject.lastBuildTime];
}

- (UIImage *)getBuildStatusImage:(NSString *)activity lastBuildStatus:(NSString *)lastBuildStatus {
	if (lastBuildStatus == nil) {
		return [UIImage imageNamed:@"icon-inactive.png"];
	}
	
	if ([activity isEqualToString:@"Sleeping"]) {
		if ([lastBuildStatus isEqualToString:@"Success"]) {
			return [UIImage imageNamed:@"icon-success.png"];
		}
		if ([lastBuildStatus isEqualToString:@"Failure"] || [lastBuildStatus isEqualToString:@"Exception"]) {
			return [UIImage imageNamed:@"icon-failure.png"];
		}
	}

	if ([activity isEqualToString:@"Building"]) {
		if ([lastBuildStatus isEqualToString:@"Success"]) {
			return [UIImage imageNamed:@"icon-success-building.png"];
		}
		if ([lastBuildStatus isEqualToString:@"Failure"] || [lastBuildStatus isEqualToString:@"Exception"]) {
			return [UIImage imageNamed:@"icon-failure-building.png"];
		}
	}
	
	if ([activity isEqualToString:@"Pause"]) {
		return [UIImage imageNamed:@"icon-pause.png"];
	}
	else {
		return nil;
	}
}

- (CCProject *)project {
	return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	// Configure the view for the selected state
}

- (void)dealloc {
	[super dealloc];
}


@end
