% Preprocessing On This Computer
projectfolder = 'C:\Work\hexgrid';
%addpath(genpath(projectfolder));

addpath(genpath(fullfile(projectfolder,'/external/matlibf')))
addpath(genpath(fullfile(projectfolder,'/external/tdt_preprocessing')))
addpath(genpath(fullfile(projectfolder,'/src')))
addpath(genpath(fullfile(projectfolder,'/readEDF')))
addpath(genpath(fullfile(projectfolder,'/hexImgA')))

trig     = hexImgA_triggerScheme();

datapath = 'C:\Work\hexgrid\P005'; cd(datapath);


%Try only 1 participant 1 session
id=1;

sprintf("Preprocessing participant %i",id)
%%thisParticipant = strcat(datapath,sprintf('P%s',num2str(id,'%03.f')));

thisParticipant = strcat(datapath,'\','Session_2');

files = dir(fullfile(thisParticipant,'*hexImgA_*')); % find folders that contain the data exluding the training data

trialcnt = 1;
trials = {};
post = [];
stimOn = [];
conditions = [];

k=1; %session 1
baseFileName = files(k).name;
fullFileName = fullfile(thisParticipant, baseFileName);
data    = edf(strcat(fullFileName,'/Behaviour/',files(k).name,'.edf'));


eyedata = data.samples; % dimensions are left x, left y, left pupil, right x, right y, right pupil
markers = data.messages;

if iscell(eyedata) & length(eyedata) > 1; eyedata = eyedata{1}; end
if length(data.timeFirstSample) > 1; firstsamp = data.timeFirstSample(1); else; firstsamp = data.timeFirstSample; end


% find trial onsets and offsets
trial_start_indicies = find(ismember(markers.text,num2str(trig.trial_info_start)));
trial_end_indicies   = find(contains(markers.text,num2str(trig.trial_end)));
%%

       for itrial = 1:length(trial_start_indicies)
            markersTrial      = markers.text(trial_start_indicies(itrial):trial_end_indicies(itrial));
            markersTrial_time = markers.timestamp(trial_start_indicies(itrial):trial_end_indicies(itrial));
            
            % get the condition number
            conditions(trialcnt) = str2num(markersTrial{4})-trig.condition_number;
  
            % find the array on marker
            holdFix_time     = markersTrial_time(find(ismember(markersTrial,num2str(trig.holdFix))));
            if length(holdFix_time) > 1; holdFix_time = holdFix_time(end); end % if there are multiple acqFix triggers, take the last one

            % reward sample is the last point in the trial
            reward_sample = markersTrial_time(find(ismember(markersTrial,num2str(trig.reward))));
            if length(reward_sample) == 0; continue; end

            start_trial_sample = (holdFix_time-firstsamp)/2;
            if length(start_trial_sample) > 1; start_trial_sample = start_trial_sample(1); end
            
            end_trial_sample   = (reward_sample-firstsamp)/2;
            
            
            stim_on_sample = ((markersTrial_time(find(ismember(markersTrial,num2str(trig.imgOn))))-firstsamp)/2)-start_trial_sample;
            if isempty(stim_on_sample)
                stim_on_sample = ((markersTrial_time(find(ismember(markersTrial,num2str(trig.arrayOn))))-firstsamp)/2)-start_trial_sample; end
           
            tar_on_sample = ((markersTrial_time(find(ismember(markersTrial,num2str(trig.tarOn))))-firstsamp)/2)-start_trial_sample;
            % check if there is a holdTar2
            if isempty( markersTrial_time(find(ismember(markersTrial,num2str(trig.holdTar2)))) );
                enterTar =  markersTrial_time(find(ismember(markersTrial,num2str(trig.holdTar))));
            else
                enterTar = markersTrial_time(find(ismember(markersTrial,num2str(trig.holdTar2))));
                if length(enterTar) > 1; enterTar = enterTar(end); end % if there are multiple acqFix triggers, take the last one
            end
            enterTar = ((enterTar -firstsamp)/2)-start_trial_sample;
            
            % cut the eye data into a cell array
            trials{trialcnt}   = eyedata(start_trial_sample:end_trial_sample,[1,2,4,5])';
            post(trialcnt)     = enterTar*2;
            stimOn(trialcnt)   = stim_on_sample*2;
            trialcnt           = trialcnt + 1; % count up
            
       end
       
     
       
         % loop over trials and make the maximum 1000 and -1000
    for k = 1:length(trials)
       dat = trials{k}';
       inds = dat>1000;
       dat(inds) = 1000;
       inds = dat<-1000;
       dat(inds) = -1000;
       trials{k} = dat';   
    end
    
    
    thisPar = [];
    for k = 1:length(trials)
        endtime = (size(trials{k},2)*2)/1000;
        thisPar.time{k} = 0:0.002:(endtime-0.002); % old time axis with 500 Hz Fs
        newtime{k} = 0:0.001:(endtime-0.001); % new time axis with 1kHz Fs
    end  
    thisPar.label = {'l_x','l_y','r_x','r_y'};
    thisPar.trial = trials;
    %%
    subplot(211)
    plot(thisPar.trial{300}'); ylim([-1000 1000])

    
    cfg             = [];
    cfg.resamplefs  = 1e3;
    cfg.time        = newtime;
    cfg.method      = 'resample'
    cfg.method =     'pchip';
    thisPar         = ft_resampledata(cfg, thisPar);

    time = thisPar.time;
    eyes = thisPar.trial;
    subplot(212)
    plot(thisPar.trial{300}'); ylim([-1000 1000])

