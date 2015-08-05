function best_model = gartune(X, y, rho_lower, rho_upper, rho_step, sigma, lambda)
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
% best_model.rho = rho;

assert(length(rho_lower) == length(rho_upper));
assert(length(rho_upper) == length(rho_step));

n = length(rho_step);
rho = rho_lower;

for s = sigma
    for l = lambda
        
        for i = 1:n
            
            rhos = rho_lower(i):rho_step(i):rho_upper(i);
            left = 1;
            right = length(rhos);
            
            while left < right - 1
               mid = fix((left + right) / 2);
               mmid = fix((mid + right) / 2);
               
               rho(i) = rhos(mid);
               model1 = gartrain(X, y, rho, s, l);
               rho(i) = rhos(mmid);
               model2 = gartrain(X, y, rho, s, l);
               
               if model1.mse > model2.mse
                   left = mid;
               else
                   right = mmid;
               end
            end
            
            rho(i) = rhos(left);
            model = gartrain(X, y, rho, s, l);
            rho(i) = rhos(right);
            modelr = gartrain(X, y, rho, s, l);
            
            if model.mse > modelr.mse
                model = modelr;
            end

            if model.mse < min_mse
                min_mse = model.mse;
                best_model = model;
            end

        end
        
    end 
end


end