function best_model = gartune(X, y, rho, sigma, lambda)
%GARTUNE  Tuning model parameters for rho, sigma, and lambda.
%   model = GARTUNE(X, y, [-0.7, -0.5], 1:5, 1:3)
%   
%   rho: an array of parameters for autoregressive model of order p
%   sigma: an array of free parameters tuned in RBF kernel
%   lambda: an array of paramaters tuned dealing with overfitting
%
%   See also GARTRAIN, GARPREDICT

min_mse = intmax;
best_model.sigma = NaN;
best_model.lambda = NaN;
best_model.rho = rho;

for s = sigma
    for l = lambda
        model = gartrain(X, y, rho, s, l);
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