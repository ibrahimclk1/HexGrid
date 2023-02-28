function [HexM HexM_noise Hex_imag] = cond_extract(eyes,conditions, time,post,stimOn)

HexM = find(conditions <=8 );
HexNoise = find(conditions > 8 & conditions < 17);
ima = find(conditions >= 17);


HexM_cond = struct;
HexM_cond.trial = {};
HexM_cond.time = {};
HexM_cond.post=[];
HexM_cond.stimOn=[];
HexM_cond.reactiontime = [];

HexM_noise = struct;
HexM_noise.trial = {};
HexM_noise.time={};
HexM_noise.post=[];
HexM_noise.stimOn=[];
HexM_noise.reactiontime = [];


Hex_imag = struct;
Hex_imag.trial={};
Hex_imag.time={};
Hex_imag.post=[];
Hex_imag.stimOn=[];
Hex_imag.reactiontime = [];

for i = 1:length(HexM) % Scaling as well
    HexM_cond.trial(1,end+1) = eyes(HexM(i));
    HexM_cond.trial{1,end} = scale_eye_tracking_values(HexM_cond.trial{1,end});
    HexM_cond.time(1,end+1) = time(HexM(i));
    HexM_cond.post(1,end+1) = post(HexM(i));
    HexM_cond.stimOn(1,end+1) = stimOn(HexM(i));
    HexM_cond.reactiontime(1,end+1) = post(HexM(i)) - stimOn(HexM(i));
    
    
    HexM_noise.trial(1,end+1) = eyes(HexNoise(i));
    HexM_noise.trial{1,end} = scale_eye_tracking_values(HexM_noise.trial{1,end});
    HexM_noise.time(1,end+1) = time(HexNoise(i));
    HexM_noise.post(1,end+1) = post(HexNoise(i));
    HexM_noise.stimOn(1,end+1) = stimOn(HexNoise(i));
    HexM_noise.reactiontime(1,end+1) = post(HexNoise(i)) - stimOn(HexNoise(i));
    
    Hex_imag.trial(1,end+1) = eyes(ima(i));
    Hex_imag.trial{1,end} = scale_eye_tracking_values(Hex_imag.trial{1,end});
    Hex_imag.time(1,end+1) = time(ima(i));
    Hex_imag.post(1,end+1) = post(ima(i));
    Hex_imag.stimOn(1,end+1) = stimOn(ima(i));
    Hex_imag.reactiontime(1,end+1) = post(ima(i)) - stimOn(ima(i));
    
    
    %scale the trials
    
end

HexM_cond.mag = {};
HexM_noise.mag={};
Hex_imag.mag={};


for i = 1:size(HexM_cond.trial,2)
    pos_x = HexM_cond.trial{1,i}(1,:); %Extract the horizantal eye movement
    pos_y = HexM_cond.trial{1,i}(2,:); %Extract the vertical eye movement
    
    time = HexM_cond.time{1,i}(1,:);
    
    vel_x = diff(pos_x)./diff(time); %horizantal velocity
    vel_y = diff(pos_y)./diff(time);
    
    vel_mag = sqrt(vel_x.^2+vel_y.^2);
    HexM_cond.mag{1,end+1} = vel_mag;
end

%Noise Condition
for i = 1:size(HexM_noise.trial,2)
    pos_x = HexM_noise.trial{1,i}(1,:); %Extract the horizantal eye movement
    pos_y = HexM_noise.trial{1,i}(2,:); %Extract the vertical eye movement
    
    time = HexM_noise.time{1,i}(1,:);
    
    vel_x = diff(pos_x)./diff(time); %horizantal velocity
    vel_y = diff(pos_y)./diff(time);
    
    vel_mag = sqrt(vel_x.^2+vel_y.^2);
    HexM_noise.mag{1,end+1} = vel_mag;
end


%Image Condition
for i = 1:size(Hex_imag.trial,2)
    pos_x = Hex_imag.trial{1,i}(1,:); %Extract the horizantal eye movement
    pos_y = Hex_imag.trial{1,i}(2,:); %Extract the vertical eye movement
    
    time = Hex_imag.time{1,i}(1,:);
    
    vel_x = diff(pos_x)./diff(time); %horizantal velocity
    vel_y = diff(pos_y)./diff(time);
    
    vel_mag = sqrt(vel_x.^2+vel_y.^2);
    Hex_imag.mag{1,end+1} = vel_mag;
end

HexM = HexM_cond;
HexM_noise = HexM_noise;
Hex_imag = Hex_imag;
%clearvars -except HexM_cond HexM_noise Hex_imag projectfolder data
