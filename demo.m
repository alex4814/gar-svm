%% Data Training using RBF-AR(p)
% RBF-AR(p) combines a kernel function and AR analysis with _p_-order
% differences to train a model.
%


%% Prepare for featured training data X, y
load('dataset/td1');
X = X1;
y = y1;
y0 = y;  % original y, no differences


%% (Optional) Difference, prone to improve the accuracy
difforder = 1;
X = diff(X, difforder);
y = diff(y, difforder);

n = size(X, 1);
q = floor(0.7 * n);
X_train = X(1:q, :);
y_train = y(1:q, :);
X_test = X(q+1 : end, :);
y_test = y(q+1 : end, :);


%% Tuning model parameters to train data model using RBF-AR(p)
sigma = 1:10;
lambda = 1:2;

p = 2;  % the length of _ro_ parameters, the order for AR analysis
rho = zeros(p, 1);

rho_lower = [-1, -1];
rho_upper = [0, 0];
rho_step = [0.1, 0.1];

%% Tune model parameter _sigma_ and _lambda
bestmodel = gartune(X_train, y_train, rho_lower, rho_upper, rho_step, sigma, lambda);


%% Predict the test data
y_history = y(q - p + 1 : end - 1);
y_predict = garpredict(X_test, y_history, bestmodel);


%% (Optional) Add differences back to get real predicted value
ay_predict = y_predict + y0(q+1 : end-1);
ay_test = y_test + y0(q+1 : end-1);
acc = 1 - mean(abs(ay_predict - ay_test) ./ max(ay_predict, ay_test));


