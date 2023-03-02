%function out1 = target_position(dat)

projectfolder = '/mnt/pns/home/celiki/Documents/Projects/Hexgrid/P005/Session_1';
addpath(genpath('/mnt/pns/home/celiki/Documents/Projects/Hexgrid/P005'));
datapath = '/mnt/pns/home/celiki/Documents/Projects/Hexgrid/P005'; cd(datapath);

%load the session eye data from preprocessing

load('P005.mat')
id=1;

sprintf("Preprocessing participant %i",id)
%%thisParticipant = strcat(datapath,sprintf('P%s',num2str(id,'%03.f')));

thisParticipant = strcat(datapath,'/','Session_1');

files = dir(fullfile(thisParticipant,'*hexImgA_*')); % find folders that contain the data exluding the training data
target_pos = {};

for k=1:length(files) %session 2
    baseFileName = files(k).name;
    fullFileName = fullfile(thisParticipant, baseFileName);
    block_files = dir(fullfile([fullFileName, '/Behaviour/']))
    load(block_files(end).name);
    for ind = 1:length(userVariables)
        if any(ind == false_trial_number(k,:));continue; 
        else
            if isfield(userVariables{1,ind}{1,1}, 'hex_pos_tar')
                target_pos{k,ind} = userVariables{1,ind}{1,1}.hex_pos_tar;
            else target_pos{k,ind} = userVariables{1,ind}{1,1}.img_tar_position;
            end
        end
    end
end

emptyCells = cellfun(@isempty, target_pos);
all_trials_tar_pos = {};
for i = 1:size(files,1) 
    t1 = target_pos(i,:);
    fal = emptyCells(i,:);
    t1(fal) = [];
    all_trials_tar_pos(i,:) = t1;
end

all_trials_tar_pos= reshape(all_trials_tar_pos.', [1, numel(all_trials_tar_pos)]);

clearvars -except all_trials_tar_pos projectfolder eyes post stimOn time 

%% Scanpath as an example 
ind =2;
figure;
scatter(all_trials_tar_pos{1, ind}(:,1),all_trials_tar_pos{1, ind}(:,2))
xlim([-1920/2 1920/2])
ylim([-1200/2 1200/2])
hold on
plot(eyes{1, ind}(1,:),eyes{1, ind}(2,:))
xlim([-1920/2 1920/2])
ylim([-1200/2 1200/2])
xline(post(2))

%% Identify Saccades in each trial and extract their starting position
%stimOn= starting point
%post = end point
%sac(:,9) = saccade angle in degrees
%data(1,post(ind)) = is equal to the position of the target

% First quadrant 0:90
% Second quadrant 90:180
% Third quadrant -180:-90
% Fourt quadrant -90:0

tar_pos = tar_pos(eyes,post);
%%

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




