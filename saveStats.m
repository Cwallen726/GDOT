function printStats(img, imgName)

    %   grab image's stats in struct 'p'
    p.pix       = img;                      
    p.minimum   = min(img, [], 'all');
    p.maximum   = max(p.pix, [], 'all');
    p.range     = p.maximum - p.minimum;
    p.std       = std2(p.pix);
    p.var       = var(double(p.pix(:)));
    p.msqr      = mean(p.pix(:).^2);
    p.rms       = sqrt(p.msqr);
    p.skewness  = skewness(p.pix(:));
    p.kurtosis  = kurtosis(p.pix(:));
    %p.rdf       = rdf;
    %p.crdf      = crdf;
    p.entropy   = entropy(p.pix);

    
    imgName = which(imgName) + "_stats.mat";

    save(imgName, "p");

end