function model = gartune(X, y, ro, sigma, lambda)
%GARTUNE   
%
%
%

min_mse = intmax;
model.sigma = NaN;
model.lambda = NaN;
model.ro = ro;

for s = sigma
    for l = lambda
        [mse, acc] = gartrain(X, y, ro, s, l);
        if mse < min_mse
            min_mse = mse;
            model.sigma = s;
            model.lambda = l;
            model.mse = mse;
        end
    end 
end


end