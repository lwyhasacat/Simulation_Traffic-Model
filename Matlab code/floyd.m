% function [p]=floyd(D,des,dep)
%
% Input arguments: 
% D: the matrix storing the distance information between each nodes
% dep: the departure coordinate for a car
% des: the destination for a car
% 
% Output:
% p: the intersection indices the car should pass by on the shortest path
 
% written with help from @9heyunanquan
function [path1]=floyd(a,start,terminal)
% get matrix D size
D=a;
n=size(D,1);
% initialize the path matrix based on size of matrix D
path=zeros(n);

% traverse through the matrix
% store the information of all the intersection indices that can be 
% connected directly into the path matrix. 
for i=1:n
    for j=1:n
        if D(i,j)~=inf
            path(i,j)=j;
        end  
    end
end

% using this nested for loop to see if there is a shorter path
% if so, update matrix D and the path matrix
for k=1:n
    for i=1:n
        for j=1:n
            % check if there is an intersection that can shorten the path
            if D(i,k)+D(k,j)<D(i,j)
                D(i,j)=D(i,k)+D(k,j);
                path(i,j)=path(i,k);
            end 
        end
    end
end

% check if there are 3 output parameters
if nargin==3
    min1=D(start,terminal);
    m(1)=start;
    i=1;
    path1=[ ]; 
    % go back to path1
    while   path(m(i),terminal)~=terminal
        k=i+1;                                
        m(k)=path(m(i),terminal);
        i=i+1;
    end
    m(i+1)=terminal;
    path1=m;% gives the shortest path intersection indices
end
end