%%This is a simple wrapper for our Borromean percolation algorithm, it will
%%generate a binary matrix with a fraction q of the sites nonzero, and
%%calculate a list of cluster sizes.

%%To generate statistics, we recommend iterating through this with a for
%%loop.

%%Written by Alexander Klotz and Donald Ferschweiler, California State
%%University, Long Beach. 2022-2023. The "adj_mat" script was written by Raphael Candelier 

L=100; %width of the grid
alg=3; %use 1 for iterative algorithm (better for sub-percolating and smaller grids, 2 for iterative algorithm (better for bigger grids), 3 for just the Hopf connectivity
q=0.5927; %fraction of occupied sites;

%%generating the binary matrix

premat=zeros(1,L^2); 
premat(1:round(L^2*q))=1; %initial ordered array filled to the desired fraction
preorder=premat(randperm(L^2)); %randomizing the order
mat=zeros(L,L);
mat(1:L^2)=preorder; %converting to 2D
%imagesc(mat); % uncomment if you want to see it
if alg==3
    comps=bwconncomp(mat,4);
    sizes=regionprops(comps,'Area');
    links=vertcat(sizes.Area)';
    hopflinks=sort(links);
    borrlinks=[];
elseif alg==1
    [borrlinks, hopflinks]=borro_iterative(mat);
elseif alg==2
        comps=bwconncomp(mat,4);
        sizes=regionprops(comps,'Area');
        links=vertcat(sizes.Area)';
        hopflinks=sort(links);
        borrtemp=borro_recursive(mat)';
        borrsizes=cellfun('length', borrtemp);
        borrlinks=sort(borrsizes);
        borrlinks(borrlinks==2)=1; %workaround for a MATLAB quirk where "length" gives the number of columns instead of the number of rows for 1x2 arrays 
end

%%example output
if alg<3
    'Largest Borromean component'
    borrlinks(end)
    'Second Largest Borromean component'
    borrlinks(end-1)
    'Number of Borromean clusters of size 1 through 5'
    [length(find(borrlinks==1)) length(find(borrlinks==2)) length(find(borrlinks==3)) length(find(borrlinks==4)) length(find(borrlinks==5))] %not the best way to do this, probably

end
'Largest Hopf component'
hopflinks(end)
'Second Largest Hopf component'
hopflinks(end-1)
'Number of Hopf clusters of size 1 through 5'
[length(find(hopflinks==1)) length(find(hopflinks==2)) length(find(hopflinks==3)) length(find(hopflinks==4)) length(find(hopflinks==5))]




