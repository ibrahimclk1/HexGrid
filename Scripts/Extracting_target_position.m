clear all; close all; clc;
projectfolder = '/mnt/pns/home/celiki/Documents/Projects/Hexgrid/P005/Session_1';
addpath(genpath('/mnt/pns/home/celiki/Documents/Projects/Hexgrid/P005'));
datapath = '/mnt/pns/home/celiki/Documents/Projects/Hexgrid/P005'; cd(datapath);

%load the session eye data from preprocessing

load('session_1_P005.mat')

% Identify Saccades in each trial and extract their starting position
%stimOn= starting point
%post = end point
%sac(:,9) = saccade angle in degrees
%data(1,post(ind)) = is equal to the position of the target

% First quadrant 0:90
% Second quadrant 90:180
% Third quadrant -180:-90
% Fourt quadrant -90:0
%%
tar_pos = tar_pos(eyes,post);


parameters.VFAC = 10;
parameters.MINDUR = 6;
parameters.srate = 500;
parameters.mergeint = 15;
parameters.slength = 2;

first_angles = [];
for i =1:length(eyes)
    data = eyes{i};
    [sac,v] = msdetect(data,parameters);
    if isempty(sac)
       first_angles(1,end+1) = nan;
    else
       first_angles(1,end+1) = sac(1,9);
    end
end

% Plotting target position to the first saccade
tar_pos(2,:) = first_angles; 

% tar_pos(1,:) = targe_position
%tar_pos(2,:) = saccade angle
tar_pos(1,:) = circshift(tar_pos(1,:),1);
pos = tar_pos';

%%
load('target_pos_and_first_saccade_session1.mat');
load('target_pos_and_first_saccade_session2.mat');

all_pos = [pos;pos2];

figure;
scatter(pos(:,1),pos(:,2))
xlim([0 5])
xlabel('Previos Target Position')
ylabel('First Saccade Angle')

