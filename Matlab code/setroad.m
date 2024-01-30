% setroad.m

for b = 1: size(i1, 2)
    X = [xi(i1(b)) xi(i2(b))];
    Y = [yi(i1(b)) yi(i2(b))];
    line(X, Y)
    plot(X, Y, '*')
    
    hold on
end

X = [2.9 2];
Y = [1 2.1];
line(X, Y)