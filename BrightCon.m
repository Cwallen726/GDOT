function img = BrightCon(orig, desiredMean, desiredstd)

    img = orig;

    %   converts img to uint8 if it isn't already
    if(class(img) ~= "uint8")
        img = im2uint8(img);
    end

    numPixels = size(img, 1) * size(img, 2);

    %   Begin Brightness/Contrast Remapping
    normalized = (img - mean2(img)) / std2(img);

    img = normalized * desiredstd + desiredMean;

end