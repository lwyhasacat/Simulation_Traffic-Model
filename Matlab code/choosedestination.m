% choosedestination.m


% the destination is chosen based on the length of the block
% the longer the block is, the more possible the car's destination lies on
% that block
bd(nc) = 1 + floor(rand * nb);
pd(nc) = rand * Lmax;
while (pd(nc) >= L(bd(nc)))
    bd(nc) = 1 + floor(rand * nb);
    pd(nc) = rand * Lmax;
end
xd(nc) = xi(i1(bd(nc))) + pd(nc) * ux(bd(nc));
yd(nc) = yi(i1(bd(nc))) + pd(nc) * uy(bd(nc));