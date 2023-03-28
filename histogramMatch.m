function [HSimg] = histogramMatch(img, desiredMode)

%   converts img to uint8 if it isn't already
if(class(img) ~= "uint8")
    img = im2uint8(img);
end

numPixels = size(img, 1) * size(img, 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Part 2 - Histogram
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Begin Histogram Specification

HSimg = img;

%   calculate fdf, rdf, and crdf from original image
fdf = zeros(1, 256);

for i = 1:size(HSimg, 1)
    for j = 1:size(HSimg, 2)
        fdf(HSimg(i,j) + 1) = fdf(HSimg(i,j) + 1) + 1;
    end
end

rdf = fdf / numPixels;
crdf = [];
cumulative = 0;

for i = 1:numel(rdf)
    cumulative = cumulative + rdf(i);
    crdf(i) = cumulative;
end

%   calculate desired rdf with sharktooth distribution
%   based on desired mode
desired_rdf = [];

for i = 1:numel(rdf)

    if(i < desiredMode)
        value = (i + 1) / (128 * (257 - (desiredMode + 1)));
        desired_rdf(i) = value;
    end

    if(i >= desiredMode)
        value = double((256 - i) / (128 * (257 - desiredMode)));
        desired_rdf(i) = value;
    end

end

%   calculate desired crdf from desired rdf
desired_crdf = [];
total = 0;

for i = 1:numel(desired_rdf)
    total = total + desired_rdf(i);
    desired_crdf(i) = total;
end

newVal = 1;
correlMap = [];

%   create the correlation map that connects the
%   original crdf to the desired crdf
for i = 1:numel(crdf)
    newVal = 1;
    while (crdf(i) > desired_crdf(newVal))
        if(newVal == 256)
            break;
        end
        newVal = newVal + 1;
    end
    correlMap(i) = newVal;
end

%   Use the correlation map on the image
for i = 1:size(HSimg, 1)
    for j = 1:size(HSimg, 2)
        value = HSimg(i,j);
        if(value == 0)
            value = 1;
        end
        HSimg(i,j) = correlMap(value);
    end
end

%   get rdf and crdf of output image
HSfdf = zeros(1, 256);
HSrdf = [];
HScrdf = [];

for i = 1:size(HSimg, 1)
    for j = 1:size(HSimg, 2)
        HSfdf(HSimg(i, j)) = HSfdf(HSimg(i, j)) + 1;
    end
end

HSrdf = HSfdf / numel(HSimg);

total = 0;
for i = 1:numel(HSrdf)
    total = total + HSrdf(i);
    HScrdf(i) = total;
end

end