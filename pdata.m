

load('gar_AS');

for i = 1:13
X = S(:, i);
y = A(:, i);
idx = X > 0 & y > 0;
X = X(idx, :);
y = y(idx, :);

assignin('base', ['X' int2str(i)], X);
assignin('base', ['y' int2str(i)], y);
save(['td' int2str(i) '.mat'], ['X' int2str(i)], ['y' int2str(i)]);
end

