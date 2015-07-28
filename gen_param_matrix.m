function ltm = gen_param_matrix(order, params)
%GEN_PARAM_MATRIX  Generate lower triangular matrix using provided
%parameters.
%   B = GEN_PARAM_MATRIX(6, [-0.1, 0.2])
%
%   It's a help function for internal use.

n = length(params);
assert(order >= n + 1);

ltm = eye(order);

for row = 2:order
    for col = 1:(row - 1)
        k = row - col;
        if k <= n
            ltm(row, col) = params(k);
        end
    end
end

end

