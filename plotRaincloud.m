close all
ChangeSet.DataSet1.fig.legend = "DataSet1"; 
ChangeSet.DataSet2.fig.legend = "DataSet2";
figHandles = plotRaincloud1([randn(100,1); 4], [randn(50,1); 5], ChangeSet);

function figHandles = plotRaincloud1(varargin)
hold on

%Check input for changes in the dataset
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

for counter = 1:size(fieldnames(allData),1)
    cData = allData.(strcat("DataSet", string(counter)));
    settings.(strcat("data", string(counter))) = settings.data;
    
    %Add distance between datasets
    AddPerDataSet = settings.data.fig.distanceBetweenDataSets + settings.data.dots.width; 
    settings.(strcat("data", string(counter))).fig.posX = settings.data.fig.posX+(counter*AddPerDataSet);
    
    %Automaticly change color per dataset:
    if counter == 1; cColor = [255/255 174/255 112/255]; %Nice and orange
    elseif counter == 2; cColor = [112/255 174/255 255/255]; %Nice and blue
    elseif counter == 3; cColor = [35/255 156/255 105/255];
    else; cColor = [rand rand rand]; %Random
    end
    settings.(strcat("data", string(counter))).cloud.Color = cColor;
    settings.(strcat("data", string(counter))).dots.MarkerFaceColor = cColor;
    settings.(strcat("data", string(counter))).dots.EdgeColor = cColor;
    
    %Change settings based on user input
    if exist('settingsChanges', 'var')
        if isfield(settingsChanges, strcat("data", string(counter)))
            for FieldNameParent = fieldnames(settingsChanges.(strcat("data", string(counter))))'
                cFieldNameParent = string(FieldNameParent);
                for FieldNameChild = fieldnames(settingsChanges.(strcat("data", string(counter))).(cFieldNameParent))'
                    cFieldNameChild = string(FieldNameChild);
                    settings.(strcat("data", string(counter))).(cFieldNameParent).(cFieldNameChild) = settingsChanges.(strcat("data", string(counter))).(cFieldNameParent).(cFieldNameChild);
                end
            end
        end
    end
    
    %Add to legend
    LegendEntries(counter) = settings.(strcat("data", string(counter))).fig.legend;
    
    %Plot
    cX = settings.(strcat("data", string(counter))).fig.posX;
    for cPlot = ["dots", "boxplot", "meanStar", "cloud"]
        cSettings =  settings.(strcat("data", string(counter))).(cPlot);
        if cSettings.plot
            switch cPlot
                case "dots"
                    figHandles.(strcat("data", string(counter))).Dots = plotDots(cX, cData, cSettings);
                case "boxplot"
                    [figHandles.(strcat("data", string(counter))).Boxplot, ~]  = plotBoxplot(cX, cData, cSettings);
                case "meanStar"
                    figHandles.(strcat("data", string(counter))).MeanStar = plotMeanStar(cX, cData, cSettings);
                case "cloud"
                    if settings.data.cloud.allSameX
                        cX = settings.data.cloud.X1 - settings.data.cloud.offsetToRight;
                    end
                    figHandles.(strcat("data", string(counter))).Cloud = plotCloud(cX, cData, cSettings, false);
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