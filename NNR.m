%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Chase Wallendorff
%   Noah Toeben
%
%   01/30/2023
%
%   We have adhered to the course policy on academic 
%   integrity and understand the consequences for violations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   s - image name
%   M - desired rows when compressed
%   N - desired columns when compressed
%   L - desired greylevel range when compressed
function p = pa1(s, M, N, L)

%   Input image
p = s;

%   Num of rows/columns in the input
Mp = double(size(p, 1)); 
Np = double(size(p, 2));

%   Graylevel values in original scene
Ls = double(max(max(p)) - min(min(p)));

%   Desired greylevel values
Lp = L;

%   Num of rows/columns in the output
Ms = double(M);
Ns = double(N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Reducing spatial and gray resolution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Reduce spatial resolution
ms = floor(double((0:Ms-1) + 0.5) * double(Mp/Ms)) + 1;
ns = floor(double((0:Ns-1) + 0.5) * double(Np/Ns)) + 1;
r = p(ms, ns);

%   Reduce graylevel range
r = floor((r+0.5) * (Lp/Ls));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Now increasing spatial/grey resolution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Increase spatial resolution
ms = floor(double((0:Mp-1) + 0.5) * double(Ms/Mp)) + 1;
ns = floor(double((0:Np-1) + 0.5) * double(Ns/Np)) + 1;
p = r(ms, ns);

%   Increase greylevel range
p = floor((p+0.5) * (Ls/Lp));

%   Convert to uint8
if (class(p) == "uint16")
    range = 65535;
    p = p * (256/range);
    p = uint8(p);
end

if (class(p) == "uint32")
    range = 4294967295;
    p = p * (256/range);
    p = uint8(p);
end

if (class(p) == "uint64")
    range = 18446744073709551615;
    p = p * (256/range);
    p = uint8(p);
end

end


