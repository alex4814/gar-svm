function py = garpredict(X_current, y_history, model, X, y)
%GARPREDICT  
%
%

minargs = 3;
maxargs = 5;
narginchk(minargs, maxargs);

if nargin <= 3
    X = model.X;
    y = model.y;
end

p = size(X, 1);
q = size(X_current, 1);
n = length(model.ro);   % n-order AR

% Make sure parameters are properly set
assert(q == length(y_history) - n + 1);

PM = gen_param_matrix(p, model.ro);

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
py = gen_yp(y_history, model.ro) + UX;

end