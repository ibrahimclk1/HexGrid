%% Extracting Data For All Task Conditions

projectfolder = '/mnt/pns/home/celiki/Documents/Projects/Hexgrid';
addpath(genpath('/mnt/pns/home/celiki/Documents/Projects/Hexgrid/Data Analysis'));
addpath(genpath(fullfile(projectfolder,'/P005')))
load('session_2_P005.mat');
eyes_session2 = eyes;
time_session2 = time;
cond_session2 = conditions;
post_session2 = post;
stimon_session2 = stimOn;
pupilsize_session2 = pupilsize;
load('session_1_P005.mat')
eyes = [eyes_session2 eyes];
time = [time_session2 time];
conditions = [cond_session2 conditions];
post = [post_session2 post];
stimOn = [stimon_session2 stimOn];
pupilsize = [pupilsize_session2 pupilsize];

%% Extracting Conditions
[HexM_cond HexM_noise Hex_imag] = cond_extract(eyes,conditions,time,post,stimOn);

clearvars -except HexM_cond HexM_noise Hex_imag projectfolder 

%% Comparing Velocity Magnitudes Across Different Tasks
% figure;
% subplot 131
% plot(HexM_cond.time{1,3}(1,1:end-1),HexM_cond.mag{1,3}(1,:))
% title('HexM Condition')
% subplot 132
% plot(HexM_noise.time{1,1}(1,1:end-1),HexM_noise.mag{1,1}(1,:))
% title('Hex Noise Condition')
% % subplot 133
% plot(Hex_imag.time{1,1}(1,1:end-1),Hex_imag.mag{1,1}(1,:))
% title('Image Condition')
 
%% Combine Saccades For all conditions


HexM_cond = combine_saccades(HexM_cond);
HexM_noise = combine_saccades(HexM_noise);
Hex_imag = combine_saccades(Hex_imag);



clearvars -except HexM_cond HexM_noise Hex_imag projectfolder data
%% Plot Saccade Main Sequence 
Saccade_main_sequence = saccade_main_sequence(HexM_cond,HexM_noise,Hex_imag);

%saveas(gcf,fullfile(projectfolder, ['/Data Analysis/Plots/', 'Saccade Main Sequence Across Conditions P005.png']));

%% Create a circular plot

polarplot_conditions = circular_plot(HexM_cond,HexM_noise,Hex_imag);
%saveas(gcf,fullfile(projectfolder, ['/Data Analysis/Plots/', 'Polar Histogram Across Conditions P005.png']));

    
    
