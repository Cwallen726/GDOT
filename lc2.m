% Noah Toeben
% 03/08/2023


%First the program reads both of the images.
%p = imread("cow.jpg");
%q = imread("pattern.jpg");

function new = lc2(p, q)

%The program then gets the size of the images
Mp = size(p, 1);
Np = size(p, 2);

%Then it gets the smallest graylevel value
lp = min(p(:));
lq = min(q(:));

%It creates a new matrix
new = zeros(256:256);

%Then it finaly fills the new matrix with the correct values and displays
%it
for x = 1:Mp
    for y = 1:Np
        mp = p(x,y) - lp + 1;
        mq = q(x,y) - lq + 1;
        new(mp,mq) = new(mp,mq) + 1;
    end
end
%imshow(new);

end