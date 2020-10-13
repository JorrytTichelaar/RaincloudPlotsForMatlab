function cHandle = plotConnectionLines(cX1, cX2, cY1, cY2, set)
%PLOTCONNECTIONLINES Summary of this function goes here
%   Detailed explanation goes here

%Individual connection lines
if set.plotInd
    cHandle.line = plot([cX1, cX2]', [cY1, cY2]', ...
        'Color', [set.LineColor set.line_opacity], ...
        'LineWidth', set.line_width);
end

%Mean connection line
if set.plotMean
    plot([cX1, cX2], [mean(cY1), mean(cY2)], ...
        'Color', [set.LineColor set.mean_line_opacity], ...
        'LineWidth', set.mean_line_width);
end
end
