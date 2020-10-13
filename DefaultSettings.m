%Default settings used to plot - these are also the settings you can adjust

%TODO 
%Expend X-ticks to work with multiple rm 

%DOTS
settings.DataSet.dots.plot = true;
settings.DataSet.dots.offsetToRight = 0; 
settings.DataSet.dots.width = 2;
settings.DataSet.dots.line_width = 1;
settings.DataSet.dots.size = 20;
settings.DataSet.dots.LineColor = [1 1 0];
settings.DataSet.dots.EdgeColor = [1 0 0];
settings.DataSet.dots.MarkerFaceColor = [1 0 0];
settings.DataSet.dots.MarkerFaceAlpha = 0.5;
settings.DataSet.dots.MarkerEdgeAlpha = 1;
settings.DataSet.dots.line_opacity = 0.2;

%CONNECTIONS
settings.DataSet.con.plot = true;
settings.DataSet.con.LineColor = [1 1 0];
settings.DataSet.con.plotInd = true; 
settings.DataSet.con.line_width = 1;
settings.DataSet.con.line_opacity = 0.2;
settings.DataSet.con.plotMean = false; 
settings.DataSet.con.mean_line_width = 3; 
settings.DataSet.con.mean_line_opacity = 0.8; 

%BOXPLOT
settings.DataSet.boxplot.plot = true;
settings.DataSet.boxplot.offsetToRight = 0; 
settings.DataSet.boxplot.width = 2;
settings.DataSet.boxplot.line_width = 1;
settings.DataSet.boxplot.RectangleColor = [1 1 1];
settings.DataSet.boxplot.RectangleOpacity = 0; 
settings.DataSet.boxplot.LineColor = [0 0 0];
settings.DataSet.boxplot.MMmultiplication = 0.5; %Make the min and max boxplotlines smaller
settings.DataSet.boxplot.whiskerSize = 1.5; % Draws points as outliers if they are greater than q3 + w ? (q3 ? q1) or less than q1 ? w ? (q3 ? q1), where w is the whiskerSize, and q1 and q3 are the 25th and 75th percentiles of the DataSet, respectively. The default value for 'whiskerSize = 1.5' corresponds to approximately +/?2.7? and 99.3 percent coverage if the DataSet are normally distributed.

%Mean STAR
settings.DataSet.meanStar.plot = true;
settings.DataSet.meanStar.offsetToRight = 0; 
settings.DataSet.meanStar.size = 25;
settings.DataSet.meanStar.line_width = 2.5;
settings.DataSet.meanStar.EdgeColor = [0 0 0];
settings.DataSet.meanStar.MarkerFaceColor = [1 1 0];
settings.DataSet.meanStar.MarkerFaceAlpha = 1;
settings.DataSet.meanStar.MarkerEdgeAlpha = 1;
settings.DataSet.meanStar.line_opacity = 1;

%CLOUD
settings.DataSet.cloud.plot = false;
settings.DataSet.cloud.offsetToRight = 1.1; 
settings.DataSet.cloud.Color = [1 0 0];
settings.DataSet.cloud.band_width = 1;
settings.DataSet.cloud.opacity = 0.5;
settings.DataSet.cloud.line_width = 0.1;
settings.DataSet.cloud.type = "rash";
settings.DataSet.cloud.multi = 3;
settings.DataSet.cloud.switch = false; 
settings.DataSet.cloud.allSameX = true; 
settings.DataSet.cloud.X1 = 5; 

%FIGURE
settings.DataSet.fig.setLim = false; 
settings.DataSet.fig.ylim = [-10 10];
settings.DataSet.fig.xlim = [0 10];
settings.DataSet.fig.title = "Title";
settings.DataSet.fig.TitelFontSize = 20;
settings.DataSet.fig.plotLegend = true; 
settings.DataSet.fig.legend = "DataSet1";
settings.DataSet.fig.LegendFontSize = 12;
settings.DataSet.fig.useXTicks = true; 
settings.DataSet.fig.xTick1 = "XTick1";
settings.DataSet.fig.FontSize = 15; 
settings.DataSet.fig.posX1 = 0; 
settings.DataSet.fig.distanceBetweenDataSets = 0.5; 

%Position arguments for rm (you can add more if you have more then 10
%measurements)
settings.DataSet.fig.posX2 = 10;   settings.DataSet.cloud.X2 = 15;   settings.DataSet.fig.xTick2 = "XTick2";
settings.DataSet.fig.posX3 = 20;   settings.DataSet.cloud.X3 = 25;   settings.DataSet.fig.xTick3 = "XTick3";  
settings.DataSet.fig.posX4 = 30;   settings.DataSet.cloud.X4 = 35;   settings.DataSet.fig.xTick4 = "XTick4";
settings.DataSet.fig.posX5 = 40;   settings.DataSet.cloud.X5 = 45;   settings.DataSet.fig.xTick5 = "XTick5";  
settings.DataSet.fig.posX6 = 50;   settings.DataSet.cloud.X6 = 55;   settings.DataSet.fig.xTick6 = "XTick6";  
settings.DataSet.fig.posX7 = 60;   settings.DataSet.cloud.X7 = 65;   settings.DataSet.fig.xTick7 = "XTick7"; 
settings.DataSet.fig.posX8 = 70;   settings.DataSet.cloud.X8 = 75;   settings.DataSet.fig.xTick8 = "XTick8";
settings.DataSet.fig.posX9 = 80;   settings.DataSet.cloud.X9 = 85;   settings.DataSet.fig.xTick9 = "XTick9";
settings.DataSet.fig.posX10= 90;   settings.DataSet.cloud.X10= 95;   settings.DataSet.fig.xTick10= "XTick10";