%% CFR comparison between high-income and low-income (hypothesis test) 
% the path of data excel – maybe you can find in the kaggle
excelFilePath = "C:\Users\jarid\OneDrive\바탕 화면\penguin\covid_data.xlsx"; 

% Read the data from the data excel file
data = readtable(excelFilePath, 'Sheet', 'Tab 1'); 

% Allocate the 'Confirmed' and 'Deaths' columns directly
confirmed = data.Confirmed;
deaths = data.Deaths;

% Calculate the Case Fatality Rate (CFR) 
% this is for the result 
data.CFR = (deaths ./ confirmed) * 100;

% checking for reading the data 
head(data, 10) 

% Create logical areas for high income (5) and low income (2) countries
% for comparison 
highIncomeIndex = data.Income == 5;
lowIncomeIndex = data.Income == 2;

% Extract CFR for high income and low income countries
highIncomeCFR = data.CFR(highIncomeIndex);
lowIncomeCFR = data.CFR(lowIncomeIndex);

H0='mu1=mu2, the average CFR of high income countries is equal to the CFR of low income countries';
HA='mu1<mu2, the average CFR of high income countries is lower than the CFR of low income countries';

% Check if highIncomeCFR and lowIncomeCFR are non-empty vectors 
if ~isempty(highIncomeCFR) && ~isempty(lowIncomeCFR) && isvector(highIncomeCFR) && isvector(lowIncomeCFR)

    [h, p, ~, stats] = ttest2(highIncomeCFR, lowIncomeCFR, 'tail', 'left', 'alpha', 0.05, 'vartype', 'unequal');

    % Display the p-value 
    disp(['h: ',num2str(h)])
    disp(['p: ',num2str(p)])
    disp('Statistics: ')
    disp(stats)

    fprintf('p-value: %f\n', p);
else
    disp('One of the groups is empty or not a vector, cannot perform ttest2.');
end

%% To better know which one is higher than the other one
% cause only p value we can't confirm that 
highIncomeCFRNoNan = highIncomeCFR(~isnan(highIncomeCFR)); % remove NaN values from highIncomeCFR
lowIncomeCFRNoNan = lowIncomeCFR(~isnan(lowIncomeCFR)); % remove NaN values from lowIncomeCFR

medianHighIncomeCFR = median(highIncomeCFRNoNan);
medianLowIncomeCFR = median(lowIncomeCFRNoNan);
disp(['median value of CFR for high income countries : ', num2str(medianHighIncomeCFR)]);
disp(['median value of CFR for low income countries : ', num2str(medianLowIncomeCFR)]);

meanHighIncomeCFR = mean(highIncomeCFRNoNan);
meanLowIncomeCFR = mean(lowIncomeCFRNoNan);
disp(['mean value of CFR for high income countries : ', num2str(meanHighIncomeCFR)]);
disp(['mean value of CFR for low income countries : ', num2str(meanLowIncomeCFR)]);

% meanHighIncomeCFR < meanLowIncomeCFR
%% plot and visualize for CFR comparison between high-income and low-income (hypothesis test) using boxplot 

% For the start 
figure;

% Combine highIncomeCFR and lowIncomeCFR into one array for box plotting
groupedCFR = [highIncomeCFR; lowIncomeCFR];

% Grouping things 
group = [repmat({'High Income'}, length(highIncomeCFR), 1); repmat({'Low Income'}, length(lowIncomeCFR), 1)];

% Create a boxplot
boxplot(groupedCFR, group);

% Title and labels 
title('CFR Comparison Between High-Income and Low-Income Countries');
ylabel('Case Fatality Rate (%)');
xlabel('Income Level');

hold on; 
means = [meanHighIncomeCFR, meanLowIncomeCFR];
plot([1, 2], means, 'g*', 'MarkerSize', 10); 
% then now this boxplot makes sense 

ylim([0 max(groupedCFR)*1.1]); 

hold off; 

My MATLAB code focuses on comparing the Case Fatality Rate (CFR) between high-income and low-income countries using a hypothesis test. The first step involves reading data from an Excel file located at "C:\Users\jarid\OneDrive\바탕 화면\penguin\covid_data.xlsx", specifically from the sheet named 'Tab 1'. After loading the data, the code calculates the CFR for each entry by dividing the number of deaths by the number of confirmed cases and multiplying the result by 100 to express it as a percentage. This new CFR value is then added as a column to the data table.
To distinguish between high-income and low-income countries, the code creates logical indices based on the income level, where high-income countries are marked with an income level of 5 and low-income countries with an income level of 2. Using these indices, the code extracts the CFR values for both high-income and low-income groups. The hypothesis test is then set up with the null hypothesis stating that the average CFR of high-income countries is equal to that of low-income countries, while the alternative hypothesis posits that the average CFR of high-income countries is lower.
A two-sample t-test is conducted to compare the CFR values between the two groups, using a one-tailed test to check if the CFR in high-income countries is significantly lower than in low-income countries. The test results include the decision (whether to reject the null hypothesis), the p-value, and other relevant statistics. To further understand the data, the code calculates and displays the median and mean CFR values for both high-income and low-income countries, providing a clearer picture of the central tendencies within each group.
Further more, the code generates a boxplot to visualize the distribution of CFR values for high-income and low-income countries. This plot includes markers for the mean CFR values of each group and sets the y-axis limits to ensure a clear view of the data distribution. Through this comprehensive approach, the code not only performs a statistical comparison but also provides a visual representation of the differences in CFR between countries of different income levels, enhancing the overall understanding of the data.
