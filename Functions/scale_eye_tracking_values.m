function dat = scale_eye_tracking_values(dat)
%[scaled_x_left, scaled_y_left,scaled_x_right, scaled_y_right] = scale_eye_tracking_values(dat)
% This function takes in vectors of eye tracking x and y values in the
% range of -1000 to +1000, and returns the scaled x and y values
% corresponding to a screen resolution of 1920x1200.

% Define constants
SCREEN_WIDTH = 1920;
SCREEN_HEIGHT = 1200;
VALUE_RANGE = 2000;

x_left = dat(1,:);
y_left= dat(2,:);
x_right = dat(3,:);
y_right= dat(4,:);

% Shift values to the range of 0 to VALUE_RANGE
shifted_x_left = x_left + 1000;
shifted_y_left = y_left + 1000;
shifted_x_right = x_right + 1000;
shifted_y_right = y_right + 1000;


% Scale values to the screen resolution
%scaled_x_left = (shifted_x_left / VALUE_RANGE) * SCREEN_WIDTH;
%scaled_y_left = (shifted_y_left / VALUE_RANGE) * SCREEN_HEIGHT;

%scaled_x_right = (shifted_x_right / VALUE_RANGE) * SCREEN_WIDTH;
%scaled_y_right = (shifted_y_right / VALUE_RANGE) * SCREEN_HEIGHT;
dat(1,:) = (shifted_x_left / VALUE_RANGE) * SCREEN_WIDTH;
dat(2,:) = (shifted_y_left / VALUE_RANGE) * SCREEN_HEIGHT;
dat(3,:) = (shifted_x_right / VALUE_RANGE) * SCREEN_WIDTH;
dat(4,:) = (shifted_y_right / VALUE_RANGE) * SCREEN_HEIGHT;
end
