function [cHandle, cData] = plotBoxplot(cX, cData, set)
%plotBoxplot makes the boxplot
%   cData = data used to calculate boxplot properties
%   set = settings for boxplot

%Calculate 1st, 2nd and 3rd quartile 
cQ3     = quantile(cData, 0.75);
cMedian = quantile(cData, 0.5);
cQ1     = quantile(cData, 0.25);

%Min max
iqr     = cQ3 - cQ1; 
maxBound= cQ3 + (set.whiskerSize * iqr); 
minBound= cQ1 - (set.whiskerSize * iqr); 
cMin    = min(cData(cData>=minBound));
cMax    = max(cData(cData<=maxBound));

%Calculate widths
cWidth = set.width*0.5; %To make sure the Xpos is valid, you need half of the width to be added and half of the width to be subtracted
cWidthMM = set.width*0.5*set.MMmultiplication; %The Min and Max ones are often a bit smaller

%Rectangel for Q1 and Q3
cHandle.rectangle = rectangle('Position',[cX+set.offsetToRight-cWidth, cQ1, 2*cWidth, (cQ3-cQ1)], 'FaceColor', [set.RectangleColor, set.RectangleOpacity], 'EdgeColor', set.LineColor, 'LineWidth', set.line_width); %Q1 and Q3

%Set median and min max 
cHandle.max = line([cX+set.offsetToRight-cWidthMM cX+set.offsetToRight+cWidthMM], [cMax cMax],        'Color', set.LineColor, 'LineWidth', set.line_width); %Max
cHandle.median = line([cX+set.offsetToRight-cWidth cX+set.offsetToRight+cWidth],  [cMedian cMedian],  'Color', set.LineColor, 'LineWidth', set.line_width); %Median
cHandle.min = line([cX+set.offsetToRight-cWidthMM cX+set.offsetToRight+cWidthMM], [cMin cMin],        'Color', set.LineColor, 'LineWidth', set.line_width); %Min

%Connect rectangle to min and max
cHandle.q3TOmax = line([cX+set.offsetToRight cX+set.offsetToRight],  [cQ3, cMax],    'LineStyle', '--', 'Color', set.LineColor, 'LineWidth', set.line_width); %Q3 to max
cHandle.q1TOmin = line([cX+set.offsetToRight cX+set.offsetToRight],  [cMin, cQ1],    'LineStyle', '--', 'Color', set.LineColor, 'LineWidth', set.line_width); %Q1 to min
cData = struct('Min', cMin, 'minBound', minBound, 'Max', cMax, 'maxBound', maxBound, 'Q1', cQ1, 'Median', cMedian, 'Q3', cQ3); %Save boxplot data
end