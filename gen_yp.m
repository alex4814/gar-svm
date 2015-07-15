function yp = gen_yp(y, order, ro)

n = length(ro);

yp = zeros(length(y) - order, 1);
for i = 1:n
    yp = yp + ro(i) * y(order - i + 1 : end - i);
end

end