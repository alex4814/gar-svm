function model = gartrain(X, y, rho, sigma, lambda)
%GARTRAIN  Train data to get a training model.
%   model = GARTRAIN(X, y, [-0.7, -0.5], 2, 3)
%   
%   rho: an array of parameters for autoregressive model of order p
%   sigma: a free parameter used in RBF kernel
%   lambda: a paramater which deals with overfitting
%
%   See also GARTUNE, GARPREDICT

% Make sure parameters are properly set
assert(sigma ~= 0);

n = size(X, 1);
p = length(rho);  % p-order AR

X2 = X(p+1 : end, :);
y2 = y(p+1 : end);  
y_history = y(1 : end-1);  % to predict using history

PM = gen_param_matrix(n, -rho);

K = zeros(n);
for i = 1:n
    for j = 1:n
        K(i, j) = exp(-(norm(X(i,:)-X(j,:),2))^2/(2*sigma^2));
    end
end

KT = zeros(n - p, n);
for i = 1 : n-p
    for j = 1 : n
        KT(i, j) = exp(-(norm(X2(i,:)-X(j,:),2))^2/(2*sigma^2));
    end
end

UX = KT * pinv(K * K + lambda * K) * K * PM * y;
YP = gen_yp(y_history, rho) + UX;


model.rho = rho;
model.sigma = sigma;
model.lambda = lambda;

model.X = X;
model.y = y;
model.true = y2;
model.predict = YP;

model.mse = mean((YP - y2).^2);
model.acc = 1 - mean(abs(y2 - YP) ./ max(y2, YP));

end