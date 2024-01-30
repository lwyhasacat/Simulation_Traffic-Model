% createcars.m

for b = 1:nb
    if (rand < dt * R * L(b)/(nb))
        nc = nc + 1;
        p(nc) = rand * L(b);
        x(nc) = xi(i1(b)) + p(nc) * ux(b);
        y(nc) = yi(i1(b)) + p(nc) * uy(b);
        onroad(nc) = 1;
        insertnewcar;
        choosedestination;
        findbestpath;
        nextb(nc) = b;
        tenter(nc) = t;
        benter(nc) = b;
        penter(nc) = p(nc);
    end
end


