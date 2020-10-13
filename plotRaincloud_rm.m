% TODO
 
close all
fakeData1=[10+randn(100,1), 13+randn(100,1)];
fakeData2=[11+randn(100,1), 17+randn(100,1)];
fakeData3=[8+randn(100,1), 18+randn(100,1)];
ChangeSet.data.cloud.type = "rash";
ChangeSet.DataSet1.fig.legend = "DataSet1";
ChangeSet.DataSet2.fig.legend = "DataSet2";
ChangeSet.DataSet3.fig.legend = "DataSet3";
plotRaincloud_rm1(fakeData1, fakeData2, fakeData3, ChangeSet)

% PDoff = [roiTablePE{roiTablePE.group=="PD_off" & roiTablePE.Contrast=="GainPE", "beta"}, roiTablePE{roiTablePE.group=="PD_off" & roiTablePE.Contrast=="LossPE", "beta"}];
% PDon = [roiTablePE{roiTablePE.group=="PD_on" & roiTablePE.Contrast=="GainPE", "beta"}, roiTablePE{roiTablePE.group=="PD_on" & roiTablePE.Contrast=="LossPE", "beta"}];
% Control = [roiTablePE{roiTablePE.group=="Control" & roiTablePE.Contrast=="GainPE", "beta"}, roiTablePE{roiTablePE.group=="Control" & roiTablePE.Contrast=="LossPE", "beta"}];
% setChange.data.fig.group1 = "Reward trials";
% setChange.data.fig.group2 = "Punishment trials";
% settings.data1.dots.legend = "PD - off";
% settings.data2.dots.legend = "PD - on";
% settings.data3.dots.legend = "Control";
% close all; figure();
% plotRaincloud_rm1(PDon, PDoff, Control, setChange)


function figHandles = plotRaincloud_rm1(varargin)
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
% nDataSets = size(fieldnames(allData),1);

%Load default settings
DefaultSettings();

%Update defaults with data changes from user
if exist('settingsChanges', 'var')
    if isfield(settingsChanges, 'data')
        for FieldNameParent = fieldnames(settingsChanges.data)'
            cFieldNameParent = string(FieldNameParent);
            for FieldNameChild = fieldnames(settingsChanges.data.(cFieldNameParent))'
                cFieldNameChild = string(FieldNameChild);
                settings.data.(cFieldNameParent).(cFieldNameChild) = settingsChanges.data.(cFieldNameParent).(cFieldNameChild);
            end
        end
    end
end

%Update each dataset, one by one.
for cDataSetCounter = 1:size(fieldnames(allData),1)
    cDataSet = strcat("DataSet", string(cDataSetCounter));
    settings.(cDataSet) = settings.data; %Default settings for all dataset
    
    %Automaticly add space between dataSets
    cTotalWidth = counterDataSet * settings.data.dots.width + ((counterDataSet -1) * settings.data.fig.distanceBetweenDataSets);
    cStartPosX = settings.data.fig.posX - (0.5 * cTotalWidth) + (0.5 * settings.data.dots.width);
    cStartPosX2 = settings.data.fig.posX2 - (0.5 * cTotalWidth) + (0.5 * settings.data.dots.width);
    AddPerDataSet = settings.data.dots.width + settings.data.fig.distanceBetweenDataSets;
    settings.(strcat("DataSet", string(cDataSetCounter))).fig.posX = cStartPosX + ((cDataSetCounter-1) * AddPerDataSet);
    settings.(strcat("DataSet", string(cDataSetCounter))).fig.posX2 = cStartPosX2 + ((cDataSetCounter-1) * AddPerDataSet);
    
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
    
    %Add to legend
    LegendEntries(cDataSetCounter) = settings.(strcat("DataSet", string(cDataSetCounter))).fig.legend;
end

%%%%%%%%%%%%%%%%%%%%%
% PLOT
%%%%%%%%%%%%%%%%%%%%
for cPlot = ["con", "dots", "boxplot", "meanStar", "cloud"] %Plot in this order to avoid lines overlapping
    for cDataSetCounter = 1:size(fieldnames(allData),1)
        %Determine X values
        xValues.cX1 = settings.(strcat("DataSet", string(cDataSetCounter))).fig.posX;
        xValues.cX2 = settings.(strcat("DataSet", string(cDataSetCounter))).fig.posX2;
        
        %Plot
        if settings.(cDataSet).(cPlot).plot
            %Get right settings
            cDataSet = strcat("DataSet", string(cDataSetCounter));
            cData = allData.(cDataSet);
            cSettings =  settings.(cDataSet).(cPlot);
            
            %Plot
            switch cPlot
                case "con"
                    figHandles.(cDataSet).Con = plotConnectionLines(xValues.cX1, xValues.cX2, cData, cSettings);
                case "dots"
                    for cSet = 1:2
                        cX = xValues.(strcat("cX", string(cSet))); %Get correct X
                        figHandles.(cDataSet).Dots.(strcat("DataSet", string(cSet))) = plotDots(cX, cData(:,cSet), cSettings);
                    end
                case "boxplot"
                    for cSet = 1:2
                        cX = xValues.(strcat("cX", string(cSet))); %Get correct X
                        figHandles.(cDataSet).BoxPlot.(strcat("DataSet", string(cSet))) = plotBoxplot(cX, cData(:,cSet), cSettings);
                    end
                case "meanStar"
                    for cSet = 1:2
                        cX = xValues.(strcat("cX", string(cSet))); %Get correct X
                        figHandles.(cDataSet).MeanStar.(strcat("DataSet", string(cSet))) = plotMeanStar(cX, cData(:,cSet), cSettings);
                    end
                case "cloud"
                    for cSet = 1:2
                        cX = xValues.(strcat("cX", string(cSet))); %Get correct X
                        
                        %Flip first dataset
                        if cSet == 1
                            flipCloud = true;
                        else
                            flipCloud = false;
                        end
                        
                        %Check if rainclouds should be at same X
                        if cSettings.allSameX
                            cX = settings.data.cloud.(strcat("X", string(cSet))) - settings.data.cloud.offsetToRight;
                        end
                        figHandles.(cDataSet).Cloud.(strcat("DataSet", string(cSet))) = plotCloud(cX, cData(:,cSet), cSettings, flipCloud);
                    end
            end
        end
    end
end

%Add legend
if settings.data.fig.plotLegend
    ScatterPlotsForLegend = flip(findall(gcf,'Type','Scatter'));
    ScattersToSelect = 1:2:9999;
    figHandles.legend = legend(ScatterPlotsForLegend(ScattersToSelect(1:counterDataSet)), LegendEntries);
end

%Set axis limits
if settings.data.fig.setLim
    ylim([settings.data.fig.ylim]);
    xlim([settings.data.fig.xlim]);
end

%Add title 
title(settings.data.fig.title);

%Add XTicks
if settings.data.fig.useXTicks
    xticks([settings.data.fig.posX,  settings.data.fig.posX2]);
    xticklabels([settings.data.fig.xTick1, settings.data.fig.xTick2]);
end

%Set fontSize
set(findall(0, '-property', 'fontsize'), 'fontsize', settings.data.fig.FontSize)
end