% initialize.m

% all blocks are one-way

%% 
% c = car index
% nc = # of cars
% i = intersection index
% ni = # of intersections
% b = block index
% nb = # of blocks

% i1(b), i2(b) = indices of intersections connected by block b, ordered by
%   the direction of traffic flow
% nbin(i) = # of blocks entering intersection i
% bin(i,j) = index of j-th block entering intersection i; j=1,...,nbin(i)
% nbout(i) = # of blocks leaving intersection i
% bout(i,j) = index of j-th block leaving intersection i; j=1,...,nbout(i)

%% Traffic lights
% jgreen(i) = an integer designating which block has the green light; 
%   1<=jgreen(i)<=nbin(i)
% s(b) = the state of the light at the end of block b; s=0 means red and
%   s=1 means green

%% Geometric information about the network of roads
% xi(i), yi(i) = coordinates of intersection i
% L(b) = length of block b
% (ux(b), uy(b)) = unit vector along block b in direction of traffic flow

%% Cars on blocks
% p(c) = the position of car c on whatever block it happens to be on,
%   measured as distance from the start of the block; if c is on block b,
%   then 0<=p(c)<=L(b)
% x(c), y(c) = coordinates of car c
% firstcar(b) = index of first car on block b
% nextcar(c) = index of car immediately behind car c on the same block
% lastcar(c) = index of last car on block b

%% Entry of cars and choice of their destinations
% R = rate at which cars enter the roadway at random times and locations
% dt = time step such that R*Lmax*dt<<1
% Lmax = the largest length of any block
% bd(c) = the block on which the destination lies
% pd(c) = the position on the block on which the destination lies

%% Steering a car to its destination
% xd(c), yd(c) = coordinates of destination of car c
% xdvec = xd(c) - xi(i)
% ydvec = yd(c) - yi(i)
% dp = ux(bout(i,1:nbout(i))) * xdvec + uy(bout(i,1:nbout(i))) * ydvec
% [dpmax,jnext] = max(dp)
% jnext = the index of the element of dp that has the maximum value
% bout(i,jb) = the block that we will choose to enter
% prchoice = probability of random choice
% Remember to avoid going through a cycle of blocks repeatedly!!! 

%%
% bestpath{c} = the intersections on the best path of car c
%% 
%% Code
%% 

nc = 0;
ni = 57;
nb = 94;

i1 = [57 1	2	3	4	7	8	9	11	12	13	14	15	23  ...
    24	18	19	20	21	25	26	27	28	29	31	32	33	35	...
    37	38	39	40	41	42	43	44	45	46	47	48	49	51	...
    52	53	55	56	10	1	6	3	8	5	12	13	7	15	...
    9	10	11	17	24	25	14	19	20	27	16	21	22	30	...
    31	26	33	28	29	36	37	32	39	34	35	43	45	38	...
    47	48	42	50	51	46	53	54	55	41];
i2 = [1	2	3	4	5	6	7	8	10	11	14	15	16	22	...
    23	17	18	19	20	24	25	26	27	30	32	33	34	36	...
    36	37	38	39	40	43	44	45	46	47	48	41	50	50	...
    51	52	54	55	57	11	2	7	4	9	6	12	14	8	...
    16	22	23	13	17	18	19	26	15	20	21	28	29	24	...
    25	32	27	34	35	30	31	38	33	41	42	36	37	46	...
    39	40	49	43	44	52	47	53	48	56];

for i=1:ni
    nbin(i) = sum(i2 == i);
    nbout(i) = sum(i1 == i);
end

nbinmax = max(nbin);
nboutmax = max(nbout);
bin = zeros(ni,nbinmax);
bout = zeros(ni,nboutmax);
for i = 1:ni
    bin(i,1:nbin(i)) = find(i2 == i);
    bout(i,1:nbout(i)) = find(i1 == i);
end

xi = [2	2	2	2	2	3.2	3.2	3.2	3.2	4	4	4	...
    4.5	4.5	4.5	4.5	5.9	5.9	5.9	5.9	5.9	7	7	7	...
    7	7	7	7	8.1	8.1	8.3	8.3	8.3	8.3	9.6	9.6	...
    9.6	9.6	9.6	9.6	9.6	10.8	10.8	10.8	10.8	...
    10.8	10.8	10.3	12	12	11.8	11.3	11.1	...
    12	11.5	11.1 2.9];
yi = [2.1	3.9	6	8	10.9	3.8	6	8	...
    10.9	1	2.2	3.4	3.3	6	8	10.9	3	...
    4	6	8	10.9	1	2.2	2.9	4	6	8	...
    10.9	1.1	2.6	4	6	8	10.9	1.2	2.2	4	...
    6	8	9.2	10.9	1.2	2	3.5	4	6	8	9.3	...
    1.3	1.9	3.7	6	8	8.2	9.5	10.9 1];

ux = xi(i2) - xi(i1);
uy = yi(i2) - yi(i1);
L = sqrt(ux.^2 + uy.^2);
ux = ux./L;
uy = uy./L;
Lmax = max(L);
dmax = 2 * Lmax;
vmax = 6;

R = 9;
dt = 0.05;
clockmax = 200/dt;

jgreen = ones(1,ni);
tlcstep = 0.1;
tlc = tlcstep;

firstcar = zeros(1,nb);
lastcar = zeros(1,nb);

prchoice = 0.3;

tonroad = [];

% Method that uses Floyd algo to compute the shortest path
% input is the departure position and destination position
% Output is a series of intersection index i

% construct matrix D, which records the distance between each intersection
D = Inf(ni);
for z = 1:size(D)
    D(z, z) = 0; % the diagonal is all 0
end

% if the interstection i, j are connected with the right direction,
% initialize Dji [!Notice it is ji here!] with the distance between i, j
for index = 1:nb
    xdiff = xi(i1(index))-xi(i2(index));
    ydiff = yi(i1(index))-yi(i2(index));
    dist = sqrt(xdiff^2 + ydiff^2);
    D(i1(index), i2(index)) = dist;
end

bestpath = {};