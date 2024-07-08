
%% CFR comparison between old countries and young countries (hypothesis test)  

% According to the UN standards, 
% the proportion of peoper aged 65 or older, is more than 7% -> aging society 
% ~ if that proportion > 14% -> aged society
% if more than 20% -> super-aged society 
young_society = data.old <= 7;
aging_society = (data.old > 7) & (data.old <= 14); 
aged_society = (data.old > 14) & (data.old <= 20);
super_aged_society = data.old > 20;


% Extract CFR for each socities
youngCFR = data.CFR(young_society);
agingCFR = data.CFR(aging_society);
agedCFR = data.CFR(aged_society);
superAgedCFR = data.CFR(super_aged_society);

H0 = 'The population means of CFR from all groups are equal.'; 
HA = 'The population means of CFR from all groups are not all equal, at least one group''s distribution of CFR is different from the others.';
% anova1 test is still comparing mean values from each groups 
% so the mechanism is almost the same 

% Check if youngCFR, agingCFR, super_aged_society and agedCFR are non-empty vectors again 
if ~isempty(youngCFR) && ~isempty(agingCFR) && isvector(youngCFR) && isvector(agingCFR) && ~isempty(super_aged_society) && ~isempty(agedCFR) && isvector(super_aged_society) && isvector(agedCFR)
    cfrValues = [youngCFR; agingCFR; agedCFR; superAgedCFR];
    groups = [repmat({'Young'}, length(youngCFR), 1); repmat({'Aging'}, length(agingCFR), 1); ...
             repmat({'Aged'}, length(agedCFR), 1); repmat({'SuperAged'}, length(superAgedCFR), 1)];

        [p,t,stats] = anova1(cfrValues, groups, 'off');
        % https://uk.mathworks.com/help/stats/anova1.html
        % data plotting 'off', honestly I don't understand the output of
        % anova1 plot part of this 

    % Display the p-value 
    fprintf('p-value: %.2e\n', p);
    % and the p-value is very low for this 
    % very interesting 
else
    disp('One of the groups is empty or not a vector, cannot perform anova1 test.');
end

%% to better know which one is higher than the other one

youngCFRNoNan = youngCFR(~isnan(youngCFR));
agingCFRNoNan = agingCFR(~isnan(agingCFR));
agedCFRNoNan = agedCFR(~isnan(agedCFR));
superAgedCFRNoNan = superAgedCFR(~isnan(superAgedCFR));

medianyoungCFR = median(youngCFRNoNan);
medianagingCFR = median(agingCFRNoNan);
medianagedCFR = median(agedCFRNoNan);
mediansuperAgedCFR = median(superAgedCFRNoNan);

meanyoungCFR = mean(youngCFRNoNan);
meanagingCFR = mean(agingCFRNoNan);
meanagedCFR = mean(agedCFRNoNan);
meansuperAgedCFR = mean(superAgedCFRNoNan);

disp(['median value of CFR for young countries : ', num2str(medianyoungCFR)]);
disp(['median value of CFR for aging countries : ', num2str(medianagingCFR)]);
disp(['median value of CFR for aged countries : ', num2str(medianagedCFR)]);
disp(['median value of CFR for super aged countries : ', num2str(mediansuperAgedCFR)]);

disp(['mean value of CFR for young countries : ', num2str(meanyoungCFR)]);
disp(['mean value of CFR for aging countries : ', num2str(meanagingCFR)]);
disp(['mean value of CFR for aged countries : ', num2str(meanagedCFR)]);
disp(['mean value of CFR for super aged countries : ', num2str(meansuperAgedCFR)]);

% medianyoungCFR < medianagingCFR < medianagedCFR < mediansuperAgedCFR 
% about mean there is not a direct conclusion but it still shows the clear trend


My MATLAB code (this part) aims to compare the Case Fatality Rate (CFR) among countries categorized by their aging population, following UN standards. The classification is based on the proportion of people aged 65 or older: a young society has up to 7% elderly, an aging society has between 7% and 14%, an aged society ranges from 14% to 20%, and a super-aged society exceeds 20%. Using this classification, the code extracts CFR values for each group.

To test the hypothesis that the average CFR is the same across all these groups, the code performs a one-way ANOVA. The null hypothesis (H0) asserts that the population means of CFR from all groups are equal, while the alternative hypothesis (HA) states that at least one group's CFR distribution differs from the others. Before conducting the ANOVA, the code checks if the CFR data for each group are non-empty vectors. If this condition is met, the CFR values are concatenated into a single array, and corresponding group labels are assigned. The `anova1` function is then used to perform the test, with the p-value indicating whether there's a statistically significant difference in CFR among the groups.

The code proceeds to calculate and display the median and mean CFR values for each group to provide a deeper understanding of the central tendencies. By removing any NaN values, the median and mean CFRs for young, aging, aged, and super-aged societies are computed. These values are printed to offer insights into the data trends.

Finally, the code discusses the results, noting that while median values show a clear trend with increasing CFR from young to super-aged societies, the mean values, although not as straightforward, still indicate a similar trend. This comprehensive approach, combining statistical testing and descriptive statistics, shows the differences in CFR among countries with varying proportions of elderly populations.
