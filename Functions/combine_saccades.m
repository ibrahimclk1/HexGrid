function out1 = combine_saccades(data)

parameters.VFAC = 10;
parameters.MINDUR = 6;
parameters.srate = 500;
parameters.mergeint = 15;
parameters.slength = 2;

data.sac = {};
data.v={};
data.allsacc_amp = [];
data.allsacc_peakvel = [];
data.saccade_angle = [];

for i = 1:size(data.trial,2)
    dat = data.trial{1, i}(1:2,:);
    [sac,v] = msdetect(dat,parameters);
    data.sac{1,i}(:,:) = sac;
    data.v{1,i}(:,:)= v;
end

for i = 1:size(data.sac,2)
    for ind = 1:size(data.sac{1,i},1)
        data.allsacc_amp(end+1) = data.sac{1,i}(ind,8);
        data.allsacc_peakvel(end+1) = data.sac{1,i}(ind,3);
        data.saccade_angle(end+1) = data.sac{1,i}(ind,10);
    end
end

out1 = data;
