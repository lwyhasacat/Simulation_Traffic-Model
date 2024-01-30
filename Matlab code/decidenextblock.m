% decidenextblock.m

% only do this if decision is not already made

if nextb(c) == b
    [m,n]=size(bestpath{c});
    if counter(c)+1 <= n
        nexti(c) = bestpath{c}(counter(c));
        nextnexti(c) = bestpath{c}(counter(c)+1);
        nextblock = findbestroute(i1,i2,nexti(c),nextnexti(c));
        if isempty(nextblock) % there is only one intersection between 
                                % the departure block and the destination block
            nextb(c) = bd(c);
        else
            nextb(c) = nextblock;
        end
        counter(c) = counter(c)+1;
    
    else % the next block is the destination block
        nextb(c) = bd(c);
    end
end