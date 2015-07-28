function yp = gen_yp(y, rho)
%GEN_YP  A helper function to generate predict y value using rho.
%
%   See also demo.m

n = length(y);
p = length(rho);

% Make sure that prediction has enough history
assert(n >= p);

yp = zeros(n - p + 1, 1);
for i = 1:p
    yp = yp + rho(i) .* y( (p - i + 1):(end - i + 1) );
end

end