%Saccade Detection For every session
projectfolder = '/mnt/pns/home/celiki/Documents/Projects/Hexgrid';
addpath(genpath(fullfile(projectfolder,'/P005/Session_2')))
load('session_2_P005.mat');
eyes_session2 = eyes;
load('session_1_P005.mat')
eyes = [eyes_session2 eyes];
clearvars -except eyes projectfolder


    
 %% Scanpath of 1 trial
%%uiopen('C:\Work\hexgrid\hexImgA\images\0001.TIF',1)
%
%dat = thisPar.trial{1,2}(1:2,:);
%figure;
%image(-1334/2:1334/2,-1001/2:1001/2,x0001,'AlphaData',0.5) %1334(width) pixels x 1001(height)#
%hold on;
%plot(dat(1,:),dat(2,:),'lineWidth',1)
%axis xy
%title('Scanpath')
%xlim([-1920/2 1920/2])
%ylim([-1200/2 1200/2])

%% Saccade Detect
parameters.VFAC = 5;
parameters.MINDUR = 6;
parameters.srate = 500;
parameters.mergeint = 15;
parameters.slength = 2;

% input:
% data   : eyevector with x and y channels as rows and samples as columns
% VFAC   : standard deviations (based on median) that need to be exceeded
% MINDUR : the minimum duration of a saccade
% srate  : sampling rate
% options : structure with information
all_sac_session_1.sac= {};
all_sac_session_1.vel= {};

for i = 1:size(eyes,2)
    dat = eyes{1, i}(1:2,:);
    [sac,v] = msdetect(dat,parameters);
    all_sac_session_1.sac{1,i}(:,:) = sac;
    all_sac_session_1.vel{1,i}(:,:) = v;
end




%% all saccade events for all trials
all_sacca_amplitude = [];
all_sacca_peakvel = [];
all_angle = [];
for i = 1:size(all_sac_session_1.sac,2)
    for ind=1:size(all_sac_session_1.sac{1,i},1)
        all_sacca_amplitude(end+1) = all_sac_session_1.sac{1,i}(ind,8);
        all_sacca_peakvel(end+1) = all_sac_session_1.sac{1,i}(ind,3);
        all_angle(end+1) = all_sac_session_1.sac{1,i}(ind,9);
    end
end
%%
% Artifact rejection of blinks
threshold = 900;

locs_art = find(all_sacca_amplitude >threshold);
all_sacca_amplitude(locs_art) = [];
all_sacca_peakvel(locs_art)=[];


%% Main Sequence
amplitudes = all_sacca_amplitude;
peakvelo = all_sacca_peakvel;
scatter(amplitudes,peakvelo,[4],'filled');
xlabel('log(Amplitude)');
ylabel('log(PeakVelocity');
ylim([0 50])
xlim([0 1000])

title('Saccade Main Sequence')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

saveas(gcf,fullfile(projectfolder, ['/Data Analysis/Plots/', 'Saccade Main Sequence P005.png']));

