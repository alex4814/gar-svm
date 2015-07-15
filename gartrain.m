function [mse, acc] = gartrain(X, y, ro, sigma, lambda)
%GARTRAIN  
%
%

assert(sigma ~= 0);

% Partition for training data
n = size(X, 1);
p = floor(0.7 * n);
q = n - p;

% Train
X1 = X(1:p, :);
y1 = y(1:p, :);
% Test
X2 = X(p+1 : end, :);
y2 = y(p+1 : end, :);

PM = gen_param_matrix(p, ro);

K = zeros(p);
for i = 1:p
    for j = 1:p
        K(i, j) = exp(-(norm(X1(i,:)-X1(j,:),2))^2/(2*sigma^2));
    end
end

KT = zeros(q, p);
for i = 1:q
    for j = 1:p
        KT(i, j) = exp(-(norm(X2(i,:)-X1(j,:),2))^2/(2*sigma^2));
    end
end

UX = KT * pinv(K * K + lambda * K) * K * PM * y1;
YP = gen_yp(y, p, ro) + UX;

mse = mean((YP - y2).^2);
acc = 1 - mean(abs(UX - YP) ./ max(UX, YP));

end