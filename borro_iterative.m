%%this function calculates the Hopf-connectivity components of the matrix,
%%then takes each component and puts it into its own matrix, calculates the
%%Borromean adjacency matrix using adj_mat, and sizes its clusters using
%%adj2cluster

function [linksout, squarelinks]=squarechunker(grod) %returns largest and second largest borromean component
    N=size(grod,1);
    comps=bwconncomp(grod,4);
    sizes=regionprops(comps,'Area');
    links=vertcat(sizes.Area)';
   
    [squarelinks ord]=sort(links);
    ord=ord(squarelinks>2);
    numones=sum(links==1)+2*sum(links==2);
    links=squarelinks(squarelinks>2);
    nmax=length(ord);
    
    spect=ones(1,numones);
    
    for i=nmax:-1:1
        comptemp=comps.PixelIdxList{ord(i)};
        gridtemp=zeros(N,N);
        gridtemp(comptemp)=1;
        borrtemp=adj_mat(gridtemp);
        c=adj2cluster(borrtemp);
        linktemp=cellfun('length', c);
        spect=[spect linktemp];
    end
    
linksout=sort(spect);    

        