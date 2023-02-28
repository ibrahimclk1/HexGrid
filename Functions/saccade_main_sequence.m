function out1 = saccade_main_sequence(HexM_cond,HexM_noise,Hex_imag)

out1 = figure;
subplot 311
scatter(HexM_cond.allsacc_amp,HexM_cond.allsacc_peakvel,[4],'filled');
xlabel('log(Amplitude)');
ylabel('log(PeakVelocity');
ylim([0 50])
xlim([0 1000])
title('Saccade Main Sequence HexM Condition')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

subplot 312
scatter(HexM_noise.allsacc_amp,HexM_noise.allsacc_peakvel,[4],'filled');
xlabel('log(Amplitude)');
ylabel('log(PeakVelocity');
ylim([0 50])
xlim([0 1000])
title('Saccade Main Sequence Hex Noise Condition')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

subplot 313
scatter(Hex_imag.allsacc_amp,Hex_imag.allsacc_peakvel,[4],'filled');
xlabel('log(Amplitude)');
ylabel('log(PeakVelocity');
ylim([0 50])
xlim([0 1000])
title('Saccade Main Sequence Image Condition')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
