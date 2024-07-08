
%% CFR comparison between good report system and bad report system (hypothesis test)

%this is to know the mean value
all_numbers_report = data.Report;
all_numbers_reportNoNan = all_numbers_report(~isnan(all_numbers_report));
mean(all_numbers_reportNoNan) % 0.0736
% I need to multiply 100 
% because I got those numbers Report = (total test) / (total population); 
% this is just the ratio not population 
% so the mean of the report system population is 7.3639 
% higher than mean will be good report system countries (sample)
% lower than mean will be bad report system countries (sample) 
% and I found that I don't need to do that
% cause this will be used as the standard, that's all 

goodReportIndex = data.Report >= 0.0736;
badReportIndex = data.Report < 0.0736; 

% Extract CFR for high income and low income countries
goodReportCFR = data.CFR(goodReportIndex);
badReportCFR = data.CFR(badReportIndex );

H0='mu1=mu2, the average CFR of good report countries is equal to the CFR of bad report countries';
HA='mu1<mu2, the average CFR of good report countries is lower than the CFR of bad report countries';

% Check if highIncomeCFR and lowIncomeCFR are non-empty vectors 
if ~isempty(goodReportCFR) && ~isempty(badReportCFR) && isvector(goodReportCFR) && isvector(badReportCFR)
    % Perform a statistical test

    [h, p, ~, stats] = ttest2(goodReportCFR, badReportCFR, 'tail', 'left', 'alpha', 0.05, 'vartype', 'unequal');

    % Display the p-value 
    disp(['h: ',num2str(h)])
    disp(['p: ',num2str(p)])
    disp('Statistics: ')
    disp(stats)

    fprintf('p-value: %f\n', p);
else
    disp('One of the groups is empty or not a vector, cannot perform ttest2.');
end

%% to better know which one is higher than the other one

% Extract CFR for high income and low income countries
goodReportCFR = data.CFR(goodReportIndex);
badReportCFR = data.CFR(badReportIndex);

goodReportCFRNoNan = goodReportCFR(~isnan(goodReportCFR)); % Remove NaN values from goodReportCFR
badReportCFRNoNan = badReportCFR(~isnan(badReportCFR)); % Remove NaN values from badReportCFR

mediangoodReportCFR = median(goodReportCFRNoNan);
medianbadReportCFR = median(badReportCFRNoNan);
disp(['median value of CFR for good report countries : ', num2str(mediangoodReportCFR)]);
disp(['median value of CFR for bad report countries : ', num2str(medianbadReportCFR)]);

meangoodReportCFR = mean(goodReportCFRNoNan);
meanbadReportCFR = mean(badReportCFRNoNan);
disp(['mean value of CFR for good report countries : ', num2str(meangoodReportCFR)]);
disp(['mean value of CFR for bad report countries : ', num2str(meanbadReportCFR)]);

%% plot and visualize for CFR comparison between Good Report and bad Report (hypothesis test) using boxplot 

% For the start 
figure;

% Combine goodReportCFR and badReportCFR into one array for box plotting
groupedCFR = [goodReportCFR; badReportCFR];

% Grouping things 
group = [repmat({'Good Report'}, length(goodReportCFR), 1); repmat({'Bad Report'}, length(badReportCFR), 1)];

% Create a boxplot
boxplot(groupedCFR, group);

% Title and labels 
title('CFR Comparison Between Good Report system countries and Bad Report system countries');
ylabel('Case Fatality Rate (%)');
xlabel('Report System');

hold on; 
means = [meangoodReportCFR, meanbadReportCFR];
plot([1, 2], means, 'g*', 'MarkerSize', 10); 

ylim([0 max(groupedCFR)*1.1]); 

hold off; 

%% Understand the glimpse of replationship between variables 

y = data.CFR;

X = [data.Income, data.old, data.Report];

X = [ones(height(data), 1), X];

[b, bint, r, rint, stats] = regress(y, X);

disp('Regression Coefficients:');
disp(b);

disp('Statistics:');
disp(stats);

% but the r-squared 0.0297 is very low so 
% this only shows very low relationships 
% only 2.97 % can be explained to it 
% so this is not a good model to describe it as a multiple variables linear regression 

figure;
scatter(data.Income, data.old, 'filled');
title('Relationship Between Income Levels and Age Demographics');
xlabel('Income Level');
ylabel('Percentage of Population Aged 65 or Older');
grid on;

figure;
scatter(data.Income, data.Report, 'filled');
title('Relationship Between Income Levels and Reporting System Quality');
xlabel('Income Level');
ylabel('Report Ratio (Total Tests / Total Population)');
grid on;

% Correlation between Income and Age Demographics
[r_age, p_age] = corr(data.Income, data.old);
fprintf('Correlation between Income and Age Demographics: r = %.2f, p-value = %.3f\n', r_age, p_age);

% Correlation between Income and Reporting System
[r_report, p_report] = corr(data.Income, data.Report);
fprintf('Correlation between Income and Reporting System: r = %.2f, p-value = %.3f\n', r_report, p_report);


My MATLAB code this part is designed to compare the Case Fatality Rate (CFR) between countries with good and bad reporting systems using a hypothesis test. Initially, it calculates the mean of the reporting system metric from the dataset, excluding any NaN values. The mean value found is approximately 0.0736, representing the ratio of total tests to the total population. Countries with a reporting system value above this mean are classified as having good reporting systems, while those below are classified as having bad reporting systems.

Once the classification is complete, the code extracts the CFR values for both groups. The null hypothesis (H0) asserts that the average CFR of countries with good reporting systems is equal to that of countries with bad reporting systems. Conversely, the alternative hypothesis (HA) suggests that the average CFR of countries with good reporting systems is lower. A two-sample t-test is conducted to compare the CFRs, using a one-tailed test to check if the good reporting system countries have a significantly lower CFR. The test results, including the p-value, are displayed to determine statistical significance.

To gain deeper insights, the code calculates and displays the median and mean CFR values for both good and bad reporting system groups, excluding any NaN values. This step helps to understand the central tendencies within each group, offering a clearer view of the data trends. The results indicate whether one group has a consistently lower CFR compared to the other.

The code also includes a visualization component, generating a boxplot to compare the CFR distributions between countries with good and bad reporting systems. The plot includes markers for the mean CFR values of each group and sets appropriate y-axis limits to ensure clarity. This visual representation helps to easily compare the distributions and identify any notable differences.

Additionally, the code explores the relationship between various variables, such as income levels, age demographics, and reporting system quality. It performs multiple linear regression to understand how these factors collectively influence the CFR. The regression results, including coefficients and statistics, are displayed, although the low R-squared value suggests that the model does not explain a significant portion of the variance in CFR.

Scatter plots are created to visualize the relationships between income levels and age demographics, as well as between income levels and reporting system quality. These plots help to identify any correlations visually. Further, the code calculates and displays the correlation coefficients and p-values for these relationships, providing a statistical measure of their strength and significance.

My MATLAB code (overall) encompasses a detailed statistical analysis of the Case Fatality Rate (CFR) across different categories of countries, focusing on income levels, aging demographics, and the quality of reporting systems. Initially, the code calculates and compares CFR between high-income and low-income countries using a two-sample t-test, and then similarly analyzes CFR across young, aging, aged, and super-aged societies through ANOVA. It further compares CFR between countries with good and bad reporting systems using another two-sample t-test. For each analysis, the code computes median and mean CFR values, visualizes the results through boxplots, and performs hypothesis testing to determine statistical significance. Additionally, it investigates the relationships between variables such as income levels, age demographics, and reporting quality using multiple linear regression and correlation analyses, providing comprehensive insights into how these factors interrelate and affect CFR. The visualizations and statistical outputs collectively offer a robust understanding of the variations in CFR and the impact of socioeconomic factors.
