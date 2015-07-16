%% Data Training using GAR(p)
% GAR combines a kernel function and AR analysis with _p_-order
% differences to train a model.
%


%% Prepare for featured training data X, y
load('gar_AS');

TestAim = 2;
X = S(:, TestAim);
y = A(:, TestAim);
idx = X > 0 & y > 0;
X = X(idx, :);
y = y(idx, :);
y0 = y;  % original y, no differences


%% (Optional) Difference, prone to improve the accuracy
difforder = 1;
X = diff(X, difforder);
y = diff(y, difforder);

n = size(X, 1);
p = floor(0.7 * n);
X_train = X(1:p, :);
y_train = y(1:p, :);
X_test = X(p+1 : end, :);
y_test = y(p+1 : end, :);



%% Tuning model parameters to train data model using GAR(p)
sigma = 1:5;
lambda = 1:2;

for ro1 = -1 : 0.1 : 0
    for ro2 = -1 : 0.1 : 0
       %% Tune _ro_ parameters
        ro = [ro1, ro2];
       %% Tune model parameter _sigma_ and _lambda_
        model = gartune(X_train, y_train, ro, sigma, lambda);
    end
end


%% Predict the test data
order = 2;
y_history = y(p - order + 1 : end - 1);
y_predict = garpredict(X_test, y_history, model);


%% (Optional) Add differences back to get real predicted value
ay_predict = y_predict + y0(p+1 : end-1);
ay_test = y_test + y0(p+1 : end-1);
acc = 1 - mean(abs(ay_predict - ay_test) ./ max(ay_predict, ay_test));


