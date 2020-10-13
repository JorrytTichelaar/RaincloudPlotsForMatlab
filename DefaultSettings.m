%Default settings used to plot - these are also the settings you can adjust

%TODO 
%Make consistent naming scheme between _rm and normal 
%Add possibility for more rm (As in 3 or more - adjust connections) 
%Add color switching possibilities 
%Add the data output to a struct to return 
%Add functionality to switching the cloud 
%Improve legend lay out 
%Improve control over font-size

%DOTS
settings.data.dots.plot = true;
settings.data.dots.offsetToRight = 0; 
settings.data.dots.width = 2;
settings.data.dots.line_width = 1;
settings.data.dots.size = 20;
settings.data.dots.LineColor = [1 1 0];
settings.data.dots.EdgeColor = [1 0 0];
settings.data.dots.MarkerFaceColor = [1 0 0];
settings.data.dots.MarkerFaceAlpha = 0.5;
settings.data.dots.MarkerEdgeAlpha = 1;
settings.data.dots.line_opacity = 0.2;

%CONNECTIONS
settings.data.con.plot = true;
settings.data.con.LineColor = [1 1 0];
settings.data.con.plotInd = true; 
settings.data.con.line_width = 1;
settings.data.con.line_opacity = 0.2;
settings.data.con.plotMean = true; 
settings.data.con.mean_line_width = 3; 
settings.data.con.mean_line_opacity = 0.8; 

%BOXPLOT
settings.data.boxplot.plot = true;
settings.data.boxplot.offsetToRight = 0; 
settings.data.boxplot.width = 2;
settings.data.boxplot.line_width = 1;
settings.data.boxplot.RectangleColor = [1 1 1];
settings.data.boxplot.RectangleOpacity = 0; 
settings.data.boxplot.LineColor = [0 0 0];
settings.data.boxplot.MMmultiplication = 0.5; %Make the min and max boxplotlines smaller
settings.data.boxplot.whiskerSize = 1.5; % Draws points as outliers if they are greater than q3 + w ? (q3 ? q1) or less than q1 ? w ? (q3 ? q1), where w is the whiskerSize, and q1 and q3 are the 25th and 75th percentiles of the data, respectively. The default value for 'whiskerSize = 1.5' corresponds to approximately +/?2.7? and 99.3 percent coverage if the data are normally distributed.

%Mean STAR
settings.data.meanStar.plot = true;
settings.data.meanStar.offsetToRight = 0; 
settings.data.meanStar.size = 25;
settings.data.meanStar.line_width = 2.5;
settings.data.meanStar.EdgeColor = [0 0 0];
settings.data.meanStar.MarkerFaceColor = [1 1 0];
settings.data.meanStar.MarkerFaceAlpha = 1;
settings.data.meanStar.MarkerEdgeAlpha = 1;
settings.data.meanStar.line_opacity = 1;

%CLOUD
settings.data.cloud.plot = true;
settings.data.cloud.offsetToRight = 1.1; 
settings.data.cloud.Color = [1 0 0];
settings.data.cloud.band_width = 1;
settings.data.cloud.opacity = 0.5;
settings.data.cloud.line_width = 0.1;
settings.data.cloud.type = "rash";
settings.data.cloud.multi = 3;
settings.data.cloud.allSameX = true; 
settings.data.cloud.X1 = 7; 
settings.data.cloud.X2 = 15;

%FIGURE
settings.data.fig.setLim = true; 
settings.data.fig.ylim = [-10 10];
settings.data.fig.xlim = [0 10];
settings.data.fig.title = "Title";
settings.data.fig.plotLegend = true; 
settings.data.fig.legend = "DataSet1";
settings.data.fig.useXTicks = false; 
settings.data.fig.xTick1 = "XTick1";
settings.data.fig.xTick2 = "XTick2";
settings.data.fig.FontSize = 20; 
settings.data.fig.posX = 0; 
settings.data.fig.posX2 = 10; 
settings.data.fig.distanceBetweenDataSets = 0.2; 