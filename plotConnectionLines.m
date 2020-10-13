function cHandle = plotConnectionLines(cX1, cX2, cData, set)
%PLOTCONNECTIONLINES Summary of this function goes here
%   Detailed explanation goes here

%Individual connection lines
if set.plotInd
    cHandle.line = plot([cX1, cX2]', [cData(:,1), cData(:,2)]', ...
        'Color', [set.LineColor set.line_opacity], ...
        'LineWidth', set.line_width);
end

%Mean connection line
if set.plotMean
    plot([cX1, cX2], [mean(cData(:,1)), mean(cData(:,2))], ...
        'Color', [set.LineColor set.mean_line_opacity], ...
        'LineWidth', set.mean_line_width);
end
end
