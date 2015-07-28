function py = garpredict(X_current, y_history, model, X, y)
%GARPREDICT  Predict for specific dataset using trained model, and only
%produce one predict value.
%
%   X_current: the feature matrix for test data, same processing as the
%   training data
%   y_history: the values for continuous days before the day to predict;
%   the length of y_history equals the order of rho parameters
%   model: the trained model produced by GARTRAIN or GARTUNE
%   (Optional) X: another feature matrix helpful for predicting; if ommit,
%   using the training X
%   (Optional) y: another true values vector attached with (Optional) X; 
%   if ommit, using the training y
%
%   See also GARTRAIN, GARTUNE

minargs = 3;
maxargs = 5;
narginchk(minargs, maxargs);

if nargin <= 3
    X = model.X;
    y = model.y;
end

p = size(X, 1);
q = size(X_current, 1);
n = length(model.rho);   % n-order AR

% Make sure parameters are properly set
assert(q == length(y_history) - n + 1);

PM = gen_param_matrix(p, model.rho);

K = zeros(p);
for i = 1:p
    for j = 1:p
        K(i, j) = exp(-(norm(X(i,:)-X(j,:),2))^2/(2*model.sigma^2));
    end
end

KT = zeros(q, p);
for i = 1:q
    for j = 1:p
        KT(i, j) = exp(-(norm(X_current(i,:)-X(j,:),2))^2/(2*model.sigma^2));
    end
end

UX = KT * pinv(K * K + model.lambda * K) * K * PM * y;
py = gen_yp(y_history, model.rho) + UX;

end