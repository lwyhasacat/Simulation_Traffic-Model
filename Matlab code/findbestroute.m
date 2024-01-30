% findbestroute.m

% given all i1, i2, the starting intersection, the ending intersection,
% return the block between the starting intersection and the ending intersection
function [b]=findbestroute(i1,i2,index1,index2)
indexlist1 = find(i1 == index1);
indexlist2 = find(i2 == index2);
b = intersect(indexlist1,indexlist2);
end