% movecars.m

% d is the distance between the car and the neariest barrier
for b = 1:nb
    c = firstcar(b);
    while (c > 0)
        if (c == firstcar(b))
            if (bd(c) == b) && (pd(c) > p(c)) 
                d = dmax;
            elseif (s(b) == 0)  
                d = L(b) - p(c);
            else
                decidenextblock
                if (lastcar(nextb(c)) > 0)
                    d = (L(b) - p(c)) + p(lastcar(nextb(c)));
                else
                    d = dmax;
                end
            end
        else
            d = p(ca) - p(c);
        end
        pz = p(c);
        nextc = nextcar(c);
        p(c) = p(c) + dt * vmax * d/dmax;  % v(d) = vmax*d/dmax
        if (b == bd(c)) && (pz < pd(c)) && (pd(c) <= p(c)) % car does not cross the intersection 
                                                            % car arrives destination
            removecar
        elseif (L(b) <= p(c)) % car crosses the intersection 
            p(c) = p(c) - L(b);
            if (nextb(c) == bd(c)) && (pd(c) <= p(c))  % car arrives destination
                removecar
            else % car does not arrive destination, so move to the next block
                cartonextblock  
            end
        else % car does not cross the intersection and car does not arrive destination
            x(c) = xi(i1(b)) + p(c) * ux(b);
            y(c) = yi(i1(b)) + p(c) * uy(b); % update the coordinates of c
            ca = c;
        end
        c = nextc;
    end  % while loop over cars on block
end  % for loop over blocks


