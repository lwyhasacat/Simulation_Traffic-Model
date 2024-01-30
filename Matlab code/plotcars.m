% plotcars.m

if ((nc > 0) &&  sum(onroad) > 0)
    hcars = plot(x(find(onroad)), y(find(onroad)), 'r.');
    hcars.MarkerSize = 15;
    set(hcars,'xdata', x(find(onroad)), 'ydata', y(find(onroad)))
    hcars = plot(x(find(onroad)), y(find(onroad)), 'r.');
    hcars.MarkerSize = 15;
end