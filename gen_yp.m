function yp = gen_yp(y, ro)
%GEN_YP  
%

n = length(y);
p = length(ro);

% Make sure that prediction has enough history
assert(n >= p);

yp = zeros(n - p + 1, 1);
for i = 1:p
    yp = yp + ro(i) .* y( (p - i + 1):(end - i + 1) );
end

end