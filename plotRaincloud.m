function [figHandles, outputData] = plotRaincloud(varargin)
%plotRaincloud plots a boxplot, scatterplot, distribution and mean of
%dataset
%plotRaincloud accepts repeated measures data. Data should be presented as
%a matrix, with rows corresponding to different measurements and columns to
%repeated measurements. To change settings, you can adjust the
%defaultsettings, or give a struct with the settings you want to change.
%See tutorialRaincloudplots.m for clear instructions. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load input and adjust default settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on

%Check input for settings changes and datasets
counterDataSet = 0;
for cVar = 1:size(varargin,2)
    if isstruct(varargin{cVar}) %Struct must be setting changes
        settingsChanges = varargin{cVar};
    else %If not a struct, add it do the allData
        counterDataSet = counterDataSet + 1;
        allData.(strcat("DataSet", string(counterDataSet))) = varargin{cVar};
    end
end

%Load default settings
DefaultSettings();

%Update defaults with data changes from user
if exist('settingsChanges', 'var')
    if isfield(settingsChanges, 'DataSet')
        for FieldNameParent = fieldnames(settingsChanges.DataSet)'
            cFieldNameParent = string(FieldNameParent);
            for FieldNameChild = fieldnames(settingsChanges.DataSet.(cFieldNameParent))'
                cFieldNameChild = string(FieldNameChild);
                settings.DataSet.(cFieldNameParent).(cFieldNameChild) = settingsChanges.DataSet.(cFieldNameParent).(cFieldNameChild);
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adjust dataset specific settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for cDataSetCounter = 1:size(fieldnames(allData),1)
    cDataSet = strcat("DataSet", string(cDataSetCounter));
    settings.(cDataSet) = settings.DataSet; %Default settings for all dataset
    
    %Automaticly add space between dataSets
    cTotalWidth = counterDataSet * settings.DataSet.dots.width + ((counterDataSet -1) * settings.DataSet.fig.distanceBetweenDataSets);
    AddPerDataSet = settings.DataSet.dots.width + settings.DataSet.fig.distanceBetweenDataSets;
    for cMeasure = 1:size(allData.(cDataSet),2)
        cStartPosX = settings.DataSet.fig.(strcat("posX", string(cMeasure))) - (0.5 * cTotalWidth) + (0.5 * settings.DataSet.dots.width);
        cPosX = cStartPosX + ((cDataSetCounter-1) * AddPerDataSet);
        settings.(strcat("DataSet", string(cDataSetCounter))).fig.(strcat("posX", string(cMeasure))) = cPosX; %Mean
        settings.(strcat("DataSet", string(cDataSetCounter))).fig.(strcat("ScatterX", string(cMeasure))) = cPosX -0.5 * settings.DataSet.dots.width + settings.DataSet.dots.width * rand(size(allData.(cDataSet),1),1); %Scatter
        
        %Add XTicks
        XTickEntries(cMeasure) = settings.DataSet.fig.(strcat("xTick", string(cMeasure)));
        XTickPos(cMeasure) = settings.DataSet.fig.(strcat("posX", string(cMeasure))); 
    end
    
    %Automaticly change color per dataset:
    if cDataSetCounter == 1; cColor = [255/255 174/255 112/255]; %Nice and orange
    elseif cDataSetCounter == 2; cColor = [112/255 174/255 255/255]; %Nice and blue
    elseif cDataSetCounter == 3; cColor = [35/255 156/255 105/255]; %Nice and green
    else; cColor = [rand rand rand]; %Random
    end
    settings.(cDataSet).cloud.Color = cColor;
    settings.(cDataSet).dots.MarkerFaceColor = cColor;
    settings.(cDataSet).dots.EdgeColor = cColor;
    settings.(cDataSet).dots.LineColor = cColor;
    settings.(cDataSet).meanStar.LineColor = cColor;
    settings.(cDataSet).con.LineColor = cColor;
    
    %Change settings based on user input
    if exist('settingsChanges', 'var')
        if isfield(settingsChanges, cDataSet)
            for FieldNameParent = fieldnames(settingsChanges.(cDataSet))'
                cFieldNameParent = string(FieldNameParent);
                for FieldNameChild = fieldnames(settingsChanges.(cDataSet).(cFieldNameParent))'
                    cFieldNameChild = string(FieldNameChild);
                    settings.(cDataSet).(cFieldNameParent).(cFieldNameChild) = settingsChanges.(cDataSet).(cFieldNameParent).(cFieldNameChild);
                end
            end
        end
    end
    
    %Add to legend and xTick 
    LegendEntries(cDataSetCounter) = settings.(strcat("DataSet", string(cDataSetCounter))).legend.entry;
    MaxEntries(cDataSetCounter) = max(max(allData.(cDataSet)));
    MinEntries(cDataSetCounter) = min(min(allData.(cDataSet)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for cPlot = ["con", "dots", "boxplot", "meanStar", "cloud"] %Plot in this order to avoid lines overlapping --> This is the reason for some of the inneficient coding
    %Loop over datasets
    for cDataSetCounter = 1:size(fieldnames(allData),1)
        %Retrieve data and settings
        cDataSet = strcat("DataSet", string(cDataSetCounter));
        cData = allData.(cDataSet);
        cSettings =  settings.(cDataSet).(cPlot);
        
        %Number of rm
        totalMeasures = size(cData,2);
        
        %Loop over number of measurement per dataset
        for cMeasure = 1:totalMeasures
            %Plot
            if settings.(cDataSet).(cPlot).plot
                %Retrieve X value and store data&settings
                cX = settings.(strcat("DataSet", string(cDataSetCounter))).fig.(strcat("posX", string(cMeasure))); %Get correct X
                cScat = settings.(strcat("DataSet", string(cDataSetCounter))).fig.(strcat("ScatterX", string(cMeasure))); %Get correct Scatter
                outputData.(cDataSet).Data.(strcat("Measurement", string(cMeasure))) = cData(:,cMeasure);
                
                %Call plotting functions
                switch cPlot
                    case "con"
                        if totalMeasures~=1 && cMeasure~=totalMeasures(end)
                            cScat2 = settings.(strcat("DataSet", string(cDataSetCounter))).fig.(strcat("ScatterX", string(cMeasure+1))); %Get correct Scatter
                            figHandles.(cDataSet).Con.(strcat("Measurement", string(cMeasure))) = ...
                                plotConnectionLines(cScat, cScat2, cData(:,cMeasure), cData(:,cMeasure+1), cSettings);
                        end
                    case "dots"
                        figHandles.(cDataSet).Dots.(strcat("Measurement", string(cMeasure))) = ...
                            plotDots(cScat, cData(:,cMeasure), cSettings);
                    case "boxplot"
                        [figHandles.(cDataSet).BoxPlot.(strcat("Measurement", string(cMeasure))), ...
                            outputData.(cDataSet).BoxPlot.(strcat("Measurement", string(cMeasure)))] = ...
                            plotBoxplot(cX, cData(:,cMeasure), cSettings);
                    case "meanStar"
                        [figHandles.(cDataSet).MeanStar.(strcat("Measurement", string(cMeasure))), ...
                            outputData.(cDataSet).Mean.(strcat("Measurement", string(cMeasure)))] = ...
                            plotMeanStar(cX, cData(:,cMeasure), cSettings);
                    case "cloud"
                        %Check if rainclouds should be at same X
                        if cSettings.allSameX
                            cX = cSettings.(strcat("X", string(cMeasure))) - cSettings.offsetToRight;
                        end
                        
                        %Flip first measurement rainclouds
                        if cMeasure == 1; cSettings.switch = true; else; cSettings.switch = false; end
                        
                        %Plot cloud
                        [figHandles.(cDataSet).Cloud.(strcat("Measurement", string(cMeasure))), ...
                            outputData.(cDataSet).Cloud.(strcat("Measurement", string(cMeasure)))] = ...
                            plotCloud(cX, cData(:,cMeasure), cSettings, cSettings.switch);
                end
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set figure settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Set fontSize
set(findall(gca, '-property', 'fontsize'), 'fontsize', settings.DataSet.fig.FontSize)

%Add legend
if settings.DataSet.legend.plot
    ScatterPlotsForLegend = flip(findall(gca,'Type','Scatter', 'Marker', 'o'));
    ScattersToSelect = 1:totalMeasures:9999; %REMOVE THIS HERE AND IN THE NEXT LINE
    figHandles.legend = legend(ScatterPlotsForLegend(ScattersToSelect(1:counterDataSet)), LegendEntries, ...
        'FontSize', settings.DataSet.legend.FontSize, ...
        'Box', settings.DataSet.legend.Box, ...
        'NumColumns' , settings.DataSet.legend.NumColumns, ...
        'Location', settings.DataSet.legend.Location);
end

%Set axis limits
if settings.DataSet.fig.setLim
    ylim([settings.DataSet.fig.ylim]);
    xlim([settings.DataSet.fig.xlim]);
else
    cMin = min(MinEntries); 
    cMax = max(MaxEntries); 
    cDif = cMax - cMin; 
    ylim([cMin - (0.3*cDif), cMax + (0.2*cDif)])
end

%Add title
title(settings.DataSet.fig.title, 'FontSize', settings.DataSet.fig.TitelFontSize);

%Add XTicks
if settings.DataSet.fig.useXTicks
    xticks(XTickPos);
    xticklabels(XTickEntries);
end

%Add settings to outputData
outputData.settings = settings;
end