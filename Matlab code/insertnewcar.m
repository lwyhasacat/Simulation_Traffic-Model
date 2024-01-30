% insertnewcar.m

c = firstcar(b);

% update the state of the block after creating the car
if (c == 0 || p(nc) > p(c))
    nextcar(nc) = c;
    firstcar(b) = nc;
    if (c == 0)
        lastcar(b) = nc;
    end
elseif p(nc) <= p(lastcar(b))
    nextcar(lastcar(b)) = nc;
    lastcar(b) = nc;
    nextcar(nc) = 0;
else
    ca = c;
    c = nextcar(c);
    while (p(nc) <= p(c))
        ca = c;
        c = nextcar(c);
    end
    nextcar(ca) = nc;
    nextcar(nc) = c;
end

