% -------------------------------------------------------------------------- %
% -------------------------------------------------------------------------- %
% ----- Preprocess the human data for the hexgrid psyhophysics project ----- %
% -------------------------------------------------------------------------- %
% -------------------------------------------------------------------------- %
projectfolder = '/mnt/pns/home/celiki/Documents/Projects/Hexgrid';
restoredefaultpath;
addpath('/mnt/hpc/opt/fieldtrip/'); ft_defaults;
addpath(genpath(fullfile(projectfolder,'/external/matlibf')))
addpath(genpath(fullfile(projectfolder,'/external/tdt_preprocessing')))
addpath(genpath(fullfile(projectfolder,'/src')))
addpath(genpath('/mnt/hpc/projects/MBhexgrid/hexgrid/external/readEDF'))
addpath(genpath('/mnt/pns/home/celiki/Documents/Projects/Hexgrid/hexImgA'));
addpath(genpath('/mnt/pns/home/celiki/Documents/Projects/Hexgrid/P008'));

% run the triggers
addpath(genpath('/mnt/hpc/projects/MBhexgrid/hexgrid/scripts/taskScripts/hexImgA'))
trig     = hexImgA_triggerScheme();

datapath = '/mnt/pns/home/celiki/Documents/Projects/Hexgrid/'; cd(datapath)
%%

% loop over participants
for id = 8%:11
    sprintf("Preprocessing participant %i",id)
    thisParticipant = strcat(datapath,sprintf('P%s',num2str(id,'%03.f')));
    %files       = dir(fullfile(thisParticipant,'freeView')); % find folders that contain the data exluding the training data
    files = dir(fullfile(thisParticipant));
    trialcnt    = 1;
    trials      = {};
    post        = [];
    stimOn      = [];
    stimOnPd    = [];
    conditions  = [];
    if isempty(files); continue; end
    for k = 3%1:length(files)
        baseFileName = files(k).name;
        fullFileName = fullfile(thisParticipant, baseFileName);
        data    = edf(strcat(fullFileName));
        eyedata = data.samples; % dimensions are left x, left y, left pupil, right x, right y, right pupil
        markers = data.messages;
        inputs  = data.inputs;
        
        if iscell(eyedata) & length(eyedata) > 1; eyedata = eyedata{1}; end
        if length(data.timeFirstSample) > 1; firstsamp = data.timeFirstSample(1); else; firstsamp = data.timeFirstSample; end
        
        trials{trialcnt}   = eyedata(:,[1,2,4,5])'; % both eyes were recorded
        trialcnt = trialcnt + 1;
        data.delete; % delete the edf file because its broken
        
    end
    
    % loop over trials and make the maximum 1000 and -1000
    for k = 1:length(trials)
       dat       = trials{k}';
       inds      = dat > 1000;
       dat(inds) = 1000;
       inds      = dat < -1000;
       dat(inds) = -1000;
       trials{k} = dat';
    end
    
    % Make a fieldtrip strucutre out of it and resample eyetraces to 1kHz
    thisPar = [];
    for k = 1:length(trials)
        endtime = (size(trials{k},2)*2)/1000;
        thisPar.time{k} = 0:0.002:(endtime-0.002); % old time axis with 500 Hz Fs
        newtime{k} = 0:0.001:(endtime-0.001); % new time axis with 1kHz Fs
    end
    
    thisPar.label = {'l_x','l_y','r_x','r_y'};
    thisPar.trial = trials;

    cfg             = [];
    cfg.resamplefs  = 1e3;
    cfg.time        = newtime;
    cfg.method      = 'resample';
    cfg.method      = 'pchip';
    thisPar         = ft_resampledata(cfg, thisPar);
    time            = thisPar.time;
    eyes            = thisPar.trial;
   
    % save the data to disk under '/mnt/hpc/projects/MBhexgrid/hexgrid/data/human/preprocessed'
    save(fullfile(thisParticipant,["P"+num2str(id,'%03.f'+"freeView")]));
  
end