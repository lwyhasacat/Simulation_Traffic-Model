% removecar.m

onroad(c) = 0; %remove the car from the traffic system
texit(c) = t; % record the exiting time

% update the state of the block the car is on
if (c == firstcar(b))
    firstcar(b) = nextcar(c);
    if (c == lastcar(b))
        lastcar(b) = 0;
    end
else
    nextcar(ca) = nextcar(c);
    if (c == lastcar(b))
        lastcar(b) = ca;
    end
end

tonroad(end+1) = texit(c) - tenter(c); % calculate the time spent on road for c

% not really needed, but ... 
x(c) = xd(c);
y(c) = yd(c);
nextcar(c) = 0;