function cHandle = plotCloud(cX, cData, set, flipCloud)
%plotCloud makes the distribution function
%   cX = X position of the cloud
%   cData = data used to calculate cloud distribution
%   set = settings for the cloud
%   flipCloud = Reverse direction of the cloud

%Calculate distribution based on kernel
switch set.type
    case "ks"
        [f, Xi, ~] = ksdensity(cData, 'Bandwidth', set.band_width);
    case "rash"
        [Xi, f] = rst_RASH(cData);
        
        %Adjust first and last entry of the height, to make the fill function go
        %over the bottom
        f = [0 f 0];
        Xi = [Xi(1), Xi, Xi(end)];
    otherwise
        error(strcat("Cloud type not supported: ", set.type));
end

%Draw the distribution,
if flipCloud
    cHandle = fill(cX+set.offsetToRight+(-f*set.multi), Xi, set.Color, 'facealpha', set.opacity, 'LineWidth', set.line_width);
else
    cHandle = fill(cX+set.offsetToRight+(f*set.multi), Xi, set.Color, 'facealpha', set.opacity, 'LineWidth', set.line_width);
end
end