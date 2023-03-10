%trl.screen_xpix  = 1920;     % SAMSUNG: 1680; LG: 2560; VPixx 1920
%trl.screen_ypix  = 1200;     % SAMSUNG: 1050; LG: 1440; VPixx 1200 
%trl.screen_diag  = 56.60;    % SAMSUNG: 56.1; LG: 80.01 (cm); Vixx 56.60;

%Screen Resolution
%Screen Dimensions
%Eye to Screen Distance
addpath('/mnt/pns/home/celiki/Documents/Projects/Hexgrid/hexImgA/images');
image_folder = '/mnt/pns/home/celiki/Documents/Projects/Hexgrid/hexImgA/images/';
trial_num = 4;


condition = Hex_imag.conditions(trial_num)-16;
if condition < 10
    condition = [' 0' num2str(condition)];
end
condition = strtrim(condition)
uiopen([image_folder ['00', num2str(condition), '.TIF']],1);


%%
%dat = eyes{1,2}(1:2,:);
dat = Hex_imag.trial{1,trial_num}(1:2,:);
x = dat(1,:);
y = dat(2,:);
%[scaled_x scaled_y] =  scale_eye_tracking_values(dat(1,:), dat_y(1,:));
figure;
axis xy
image(556/2,199/2,x0008,'AlphaData',0.5) %1334(width) pixels x 1001(height)# (1900-1334)/2, (1200-1001)/2
title('Scanpath')
%xlim([-1920/2 1920/2])
%ylim([-1200/2 1200/2])
xlim([0 1920])
ylim([0 1200])


hold on;
plot(x,y,'lineWidth',1)

%%
pos_x = dat(1,:); %Extract the horizantal eye movement
pos_y = dat(2,:); %Extract the vertical eye movement 

time = (0:length(pos_x)-1)./500;

vel_x = diff(pos_x)./diff(time); %horizantal velocity
vel_y = diff(pos_y)./diff(time);

vel__mag_x = sqrt(vel_x.^2);
vel_mag = sqrt(vel_x.^2+vel_y.^2);

figure;
plot(time(1:end-1),vel_mag); %peak velocity vs. time
peak_vel = max(vel_mag); %peak velocity
disp(['Peak Velocity ', num2str(peak_vel)]);
xlabel('Time');
ylabel('Velocity(deg/s)');
title('Velocity vs. time, Trial 2');





