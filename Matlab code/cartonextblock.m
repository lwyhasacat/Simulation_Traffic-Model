% cartonextblock.m

firstcar(b) = nextcar(c);
if (c == lastcar(b))
    lastcar(b) = 0;
end
if (lastcar(nextb(c)) == 0)
    firstcar(nextb(c)) = c;
else
    nextcar(lastcar(nextb(c))) = c;
end
lastcar(nextb(c)) = c;
nextcar(c) = 0;

x(c) = xi(i1(nextb(c))) + p(c) * ux(nextb(c));
y(c) = yi(i1(nextb(c))) + p(c) * uy(nextb(c));