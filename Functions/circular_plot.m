function out1 = circular_plot(HexM_cond,HexM_noise, Hex_imag)

addpath(genpath('/mnt/pns/home/celiki/Documents/MATLAB/CircStats'));

mean_angle_noise = circ_mean(HexM_noise.saccade_angle.');


out1 = figure;
subplot 131
h = polarhistogram(HexM_noise.saccade_angle, 16, 'linewidth', 2, 'facecolor', 'b');
rticklabels({});
ax = gca;
ax.ThetaAxisUnits = 'radians';
ax.ThetaZeroLocation = 'right';

hold on
polarplot([0 mean_angle_noise], [0 max(h.Values)], 'r', 'linewidth', 2);
hold off

r = circ_r(HexM_noise.saccade_angle.');
title(sprintf('Saccade angles Noise Condition (r = %.2f)', r));



% Hex Condition

mean_angle_hexm = circ_mean(HexM_cond.saccade_angle.');

subplot 132
h = polarhistogram(HexM_cond.saccade_angle, 16, 'linewidth', 2, 'facecolor', 'b');
rticklabels({});
ax = gca;
ax.ThetaAxisUnits = 'radians';
ax.ThetaZeroLocation = 'right';

hold on
polarplot([0 mean_angle_hexm], [0 max(h.Values)], 'r', 'linewidth', 2);
hold off

r = circ_r(HexM_cond.saccade_angle.');
title(sprintf('Saccade angles Hex Condition(r = %.2f)', r));


mean_angle_imag = circ_mean(Hex_imag.saccade_angle.');
subplot 133

h = polarhistogram(Hex_imag.saccade_angle, 16, 'linewidth', 2, 'facecolor', 'b');

rticklabels({});
ax = gca;
ax.ThetaAxisUnits = 'radians';
ax.ThetaZeroLocation = 'right';

hold on
polarplot([0 mean_angle_imag], [0 max(h.Values)], 'r', 'linewidth', 2);
hold off

r = circ_r(Hex_imag.saccade_angle.');
title(sprintf('Saccade angles Image Condition (r = %.2f)', r));



