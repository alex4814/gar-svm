function best_model = gartune(X, y, ro, sigma, lambda)
%GARTUNE   
%
%
%

min_mse = intmax;
best_model.sigma = NaN;
best_model.lambda = NaN;
best_model.ro = ro;

for s = sigma
    for l = lambda
        model = gartrain(X, y, ro, s, l);
        if model.mse < min_mse
            min_mse = model.mse;
            best_model = model;
            best_model.sigma = s;
            best_model.lambda = l;
            best_model.mse = model.mse;
        end
    end 
end


end