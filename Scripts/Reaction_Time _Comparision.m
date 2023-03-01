%Reaction Time Comparision

figure;
histogram(HexM_cond.reactiontime, 'Normalization', 'probability');
hold on;
histogram(HexM_noise.reactiontime, 'Normalization', 'probability');
hold on;
histogram(Hex_imag.reactiontime, 'Normalization', 'probability', 'DisplayStyle', 'stairs');
xlabel('Reaction Time');
ylabel('Probability Density');
legend('Hex Condition', 'Noise', 'Image');
title('Distribution of Reaction Times');
hold off



mean_HexM_cond = mean(HexM_cond.reactiontime);
std_rt_HexM_cond = std(HexM_cond.reactiontime);

mean_HexM_noise = mean(HexM_noise.reactiontime);
std_rt_HexM_noise = std(HexM_noise.reactiontime);

mean_Hex_imag = mean(Hex_imag.reactiontime);
std_rt_Hex_imag = std(Hex_imag.reactiontime);



% Perform statistical tests to compare the conditions
% One-way ANOVA
[p_anova, tbl_anova, stats_anova] = anova1([HexM_cond.reactiontime', HexM_noise.reactiontime', Hex_imag.reactiontime']);
% Post-hoc tests with Tukey's HSD

[c, m, h] = multcompare(stats_anova);

