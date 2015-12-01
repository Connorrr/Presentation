#Function: 		PC.sce
#Description:	Contains the subroutines used in the experiment
#Programmer:	Connor Reid (Psy Technician)
#Created@:		08/08/2013
#LastMod@:		01/12/2015
#ModifiedBy:	Connor Reid
#Copyright@: 	School Of Psychology, Griffith University
#-------------------------------------------------------------------
pcl_file = "PC.pcl";
scenario = "PC";
response_matching = simple_matching;

default_font_size = 20;
default_text_color=255,255,255;
default_background_color = 0,0,0;
active_buttons = 15;
button_codes = 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15;		#1=SPACE,v,b,n,a,s,d,f,g,h,j,k,l,;,'

#write_codes = true;		#write codes to port
#pulse_width = 20; 		#if port is parallel
#----------------Instruction and blank bitmaps -----------
# 
begin;

picture {} default;

text{ caption = "You will be presented with a series of shapes on the computer screen. 
					\n\nFrom time to time you will also hear a tone following the shapes.
					\n\nPress SPACE bar to continue."; }text_1;
text{ caption = "Please pay attention to the shapes on the screen and the tone via 
						\n\nyour headphones throughout the experiment.
						\n\nPress SPACE bar to continue."; }text_2;
text{ caption = "When you see a shape on the screen, you will see the word \"Rate Now\" appear above the shape.
						\n\nWhen you see those words, press the button which corresponds to your level of certainty that the tone will follow."; }text_3;
text{ caption = "Please rate the degree of pleasantness of the shape you just saw"; }reaction_text;
text{caption="Rate Now";}rate_now_text;
text{caption="Please take a break ...Press SPACE bar to continue";}break_text;
text{caption="Now you will do a practice trial before you starting
					\n\nPress SPACE bar to continue.";}practice_text;

#cross fixation
line_graphic {
   coordinates = -7, 0, 7, 0;
   coordinates = 0, -7, 0, 7;
   line_width = 3;
   line_color = 255,255,255;
}fixation_line;

picture {		
		text {caption = "+"; font_size = 30; font_color = 255,255,255;}fixation_cross_txt;
		x = 0; y = 0;
}fixation_pic;

ellipse_graphic {
   ellipse_width = 19;
   ellipse_height = 19;
   color = 255, 255, 255;
}probe_dot;

bitmap{ filename = "triangle.bmp"; preload = true; } triangle;  #Triangle
bitmap{ filename = "poly.bmp"; preload = true; } polygon;  #polygon
bitmap{ filename = "scale-instruction.bmp"; preload = true; } scale_instruction_bmp;  #instruction for the evaluation
bitmap{ filename = "scale-rate.bmp"; preload = true; } scale_bmp;  #pleasant scale show for each shape
bitmap{ filename = "expect-rate.bmp"; preload = true; } expect_bmp;  #expectation scale show for each shape
wavefile { filename = "tone.wav"; } tone;

picture {
		bitmap polygon;
		x = 0; y = 0;
		text rate_now_text;
		x = 0; y = 250;
		bitmap expect_bmp;
		x = 0; y = -300;
}poly_rate_pic;

picture {
		bitmap triangle;
		x = 0; y = 0;
		text rate_now_text;
		x = 0; y = 250;
		bitmap expect_bmp;
		x = 0; y = -300;
}tri_rate_pic;

picture{
		text reaction_text;
		x = 0; y = 50;
		bitmap scale_bmp;
		x = 0; y = -50;
	}response_pic_tri;
	
picture{
		text reaction_text;
		x = 0; y = 50;
		bitmap scale_bmp;
		x = 0; y = -50;
	}response_pic_poly;
##########################################################
############  Pavlovian Trials Start Here ################
##########################################################

trial {
	trial_duration = forever;
	trial_type = specific_response;
	terminator_button = 1;
	picture {
		text text_1;
		x = 0; y = 0;
	};
}welcome_1; 

trial {
	trial_duration = forever;
	trial_type = specific_response;
	terminator_button = 1;
	picture {
		text text_2;
		x = 0; y = 0;
	};
}welcome_2;

trial {
	trial_duration = forever;
	trial_type = specific_response;
	terminator_button = 1;
	picture {
		text text_3;
		x = 0; y = 0;
		bitmap expect_bmp;
		x = 0; y = -250;
	};
}welcome_3;
#
trial {
	trial_duration = forever;
	trial_type = specific_response;
	terminator_button = 1;
	picture {
		bitmap scale_instruction_bmp;
		x = 0; y = 0;
	};
}scale_instruction_trial;
#

trial {
	trial_duration = forever;
	trial_type = specific_response;
	terminator_button = 1;
	picture {
		text practice_text;
		x = 0; y = 0;
	};
}practice_trial;
#
trial {      
	trial_duration = 5000;
	#trial_type = first_response;
	picture fixation_pic;
}fixation_trial;

trial {
	trial_duration = 10000;
	#trial_type = fixed;
	trial_type = specific_response;
	terminator_button = 5,6,7,8,9,10,11,12,13,14,15;
	stimulus_event {
	picture {
		bitmap triangle;
		x = 0; y = 0;
	} tri_pic;
	response_active = true;
	}event1;
	
	picture tri_rate_pic;
	time = 4000;	#show the prompt in 4 seconds
	
} triangle_trial;

picture {
		bitmap polygon;
		x = 0; y = 0;
} poly_pic;

trial {
	trial_duration = 8000;
	#trial_type = fixed;
	trial_type = specific_response;
	terminator_button = 5,6,7,8,9,10,11,12,13,14,15;
	stimulus_event {
	picture poly_pic;
	response_active = true;
	}event2;
	picture poly_rate_pic;
	time = 4000;	#show the prompt in 4 seconds
} poly_trial;

trial {
	trial_duration = 2000;
	trial_type = fixed;
	picture poly_pic;
	sound {wavefile tone; }poly_sound;
	response_active = true;
} poly_trial2;

trial {
	trial_duration = 5000;
	picture {};
}blank_trial;

trial {
	trial_duration = 5000;
	#trial_type = fixed;
	trial_type = specific_response;
	terminator_button = 5,6,7,8,9,10,11,12,13,14,15;
	stimulus_event{
	picture response_pic_poly;
	response_active = true;
	}event3;
}poly_rating_trial;

trial {
	trial_duration = 5000;
	#trial_type = fixed;
	trial_type = specific_response;
	terminator_button = 5,6,7,8,9,10,11,12,13,14,15;
	stimulus_event{
	picture response_pic_tri;
	response_active = true;
	}event4;
}triangle_rating_trial;

trial {
	trial_duration = 2000;
	picture{};
	sound {wavefile tone; }poly_sound_2;
}tone_reinstatement_trial;

trial {
	trial_duration = 2000;
	picture{};
}blank_reinstatement_trial;

trial {
	trial_duration = 3000;
	picture{
		text { caption = "Thank you for your participation, all trials are now complete."; };
		x = 0; y = 0;
	};
}Goodbye_trial;
#
trial {
	trial_duration = forever;
	trial_type = specific_response;
	terminator_button = 1;
	picture {
		text break_text;
		x = 0; y = 0;
	};
}break_trial;

##########################################################
############  Pavlovian Trials End Here ##################
##########################################################
