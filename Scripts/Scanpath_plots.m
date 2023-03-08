%% scanpath for the trials Hex

path = '/mnt/pns/home/celiki/Documents/Projects/Hexgrid/P005/Session_1/P005_20230211_hexImgA_1/Backup/';
load('P005.mat');
load('P005_20230211_hexImgA_1.mat');

false_trials = find(false_trial_number(1,:) ~= 0);
false_trials = false_trial_number(1,false_trials);
 userVariables(false_trials) = [];
%%
n=9;


figure;
if isfield(userVariables{1, n}{1, 1}, 'hex_pos')
    scatter(userVariables{1, n}{1, 1}.hex_pos(:,1),userVariables{1, n}{1, 1}.hex_pos(:,2));
    xlim([-1920/2 1920/2])
    ylim([-1200/2 1200/2])
    hold on;
    scatter(userVariables{1, n}{1, 1}.hex_pos_tar(:,1),userVariables{1, n}{1, 1}.hex_pos_tar(:,2),'filled','r')
    hold on
    plot(eyes{1, n}(1,:),eyes{1, n}(2,:))
    hold off
else
    if userVariables{1, 4}{1, 1}.img_ind >= 10
        image_num = [sprintf('%04d', userVariables{1, n}{1, 1}.img_ind) '.TIF'];
    else
        image_num = [sprintf('%05d', userVariables{1, n}{1, 1}.img_ind) '.TIF'];
    end
    img = imread(image_num);
    image(((1920-1334)/2) - 950, ((1200-1001)/2) - 600,img,'AlphaData',0.5) %
    xlim([-1920/2 1920/2])
    ylim([-1200/2 1200/2])
    hold on
    plot(eyes{1, n}(1,:),eyes{1, n}(2,:))
    hold off
       
end



