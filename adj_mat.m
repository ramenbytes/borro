%%this function calculates a borromean adjacency matrix by checking for
%%twelve occupied triangles around a given occupied square, following the
%%procedure in the manuscript
function adjout=adj_mat(grod)
    
    grarray=grod(:);
    N=size(grod,1);
    filled=find(grarray>0);
    n=length(filled);
    adjmat=(zeros(n,n));
    inder=1:n;
    
    for i=1:n
        smind=filled(i);
        
        
        x=ceil(smind/N);
        y=mod(smind,N);
        if y==0
            y=N;
        end
        

            if x>1 && y>1   %1
            x1=x-1;y1=y-1; i1=N*(x1-1)+y1;
            x2=x;y2=y-1;  i2=N*(x2-1)+y2;
            if grod(y1,x1)>0 && grod(y2,x2)>0 
                temp=filled==i1; n1=inder(temp);
                temp=filled==i2; n2=inder(temp);
                
                
                adjmat(i,n1)=1;adjmat(i,n2)=1;adjmat(n1,n2)=1 ;adjmat(n1,i)=1;adjmat(n2,i)=1;adjmat(n2,n1)=1;
                 
             end
         
            
            x1=x-1;y1=y-1; i1=N*(x1-1)+y1; %2
            x2=x-1;y2=y;  i2=N*(x2-1)+y2;
            if grod(y1,x1)>0 && grod(y2,x2)>0 
                                temp=filled==i1; n1=inder(temp);
                temp=filled==i2; n2=inder(temp);
                adjmat(i,n1)=1;adjmat(i,n2)=1;adjmat(n1,n2)=1 ;adjmat(n1,i)=1;adjmat(n2,i)=1;adjmat(n2,n1)=1;


            
            end
            
            
            
            x1=x-1;y1=y; i1=N*(x1-1)+y1; %3
            x2=x;y2=y-1;  i2=N*(x2-1)+y2;
            if grod(y1,x1)>0 && grod(y2,x2)>0 
                              temp=filled==i1; n1=inder(temp);
                temp=filled==i2; n2=inder(temp);
                adjmat(i,n1)=1;adjmat(i,n2)=1;adjmat(n1,n2)=1 ;adjmat(n1,i)=1;adjmat(n2,i)=1;adjmat(n2,n1)=1;


            end
            
            end
            
            if x>1 && y<N
                x1=x-1;y1=y+1; i1=N*(x1-1)+y1; %4
                x2=x-1;y2=y;  i2=N*(x2-1)+y2;

              if grod(y1,x1)>0 && grod(y2,x2)>0 
                             temp=filled==i1; n1=inder(temp);
                temp=filled==i2; n2=inder(temp);
                adjmat(i,n1)=1;adjmat(i,n2)=1;adjmat(n1,n2)=1 ;adjmat(n1,i)=1;adjmat(n2,i)=1;adjmat(n2,n1)=1;

              end
      
               x1=x-1;y1=y+1; i1=N*(x1-1)+y1; %5
                x2=x;y2=y+1;  i2=N*(x2-1)+y2;

              if grod(y1,x1)>0 && grod(y2,x2)>0 
                                  temp=filled==i1; n1=inder(temp);
                temp=filled==i2; n2=inder(temp);
                adjmat(i,n1)=1;adjmat(i,n2)=1;adjmat(n1,n2)=1 ;adjmat(n1,i)=1;adjmat(n2,i)=1;adjmat(n2,n1)=1;
     
              end
              
              
              x1=x-1;y1=y; i1=N*(x1-1)+y1; %6
              x2=x;y2=y+1;  i2=N*(x2-1)+y2;

              if grod(y1,x1)>0 && grod(y2,x2)>0 
                                   temp=filled==i1; n1=inder(temp);
                temp=filled==i2; n2=inder(temp);
                adjmat(i,n1)=1;adjmat(i,n2)=1;adjmat(n1,n2)=1 ;adjmat(n1,i)=1;adjmat(n2,i)=1;adjmat(n2,n1)=1;
           
              end                
              
            end


   
            if y>1 && x<N
                
                      
              x1=x;y1=y-1; i1=N*(x1-1)+y1; %7
              x2=x+1;y2=y-1;  i2=N*(x2-1)+y2;

              if grod(y1,x1)>0 && grod(y2,x2)>0 
                               temp=filled==i1; n1=inder(temp);
                temp=filled==i2; n2=inder(temp);
                adjmat(i,n1)=1;adjmat(i,n2)=1;adjmat(n1,n2)=1 ;adjmat(n1,i)=1;adjmat(n2,i)=1;adjmat(n2,n1)=1;
                
              end                
               
              x1=x+1;y1=y; i1=N*(x1-1)+y1; %8
              x2=x+1;y2=y-1;  i2=N*(x2-1)+y2;

              if grod(y1,x1)>0 && grod(y2,x2)>0 
                                  temp=filled==i1; n1=inder(temp);
                temp=filled==i2; n2=inder(temp);
                adjmat(i,n1)=1;adjmat(i,n2)=1;adjmat(n1,n2)=1 ;adjmat(n1,i)=1;adjmat(n2,i)=1;adjmat(n2,n1)=1;
       
              end
              
              
              x1=x+1;y1=y; i1=N*(x1-1)+y1; %9
              x2=x;y2=y-1;  i2=N*(x2-1)+y2;

              if grod(y1,x1)>0 && grod(y2,x2)>0 
                                  temp=filled==i1; n1=inder(temp);
                temp=filled==i2; n2=inder(temp);
                adjmat(i,n1)=1;adjmat(i,n2)=1;adjmat(n1,n2)=1 ;adjmat(n1,i)=1;adjmat(n2,i)=1;adjmat(n2,n1)=1;
                
              end                 
            end
            
            if x<N && y<N
              x1=x+1;y1=y; i1=N*(x1-1)+y1; %10
              x2=x+1;y2=y+1;  i2=N*(x2-1)+y2;

              if grod(y1,x1)>0 && grod(y2,x2)>0 
                              temp=filled==i1; n1=inder(temp);
                temp=filled==i2; n2=inder(temp);
                adjmat(i,n1)=1;adjmat(i,n2)=1;adjmat(n1,n2)=1 ;adjmat(n1,i)=1;adjmat(n2,i)=1;adjmat(n2,n1)=1;
            
              end
              
              x1=x+1;y1=y; vi1=N*(x1-1)+y1; %11
              x2=x;y2=y+1;  i2=N*(x2-1)+y2;

              if grod(y1,x1)>0 && grod(y2,x2)>0 
                                  temp=filled==i1; n1=inder(temp);
                temp=filled==i2; n2=inder(temp);
                adjmat(i,n1)=1;adjmat(i,n2)=1;adjmat(n1,n2)=1 ;adjmat(n1,i)=1;adjmat(n2,i)=1;adjmat(n2,n1)=1;
                
              end                
      
              x1=x+1;y1=y+1; i1=N*(x1-1)+y1; %12
              x2=x;y2=y+1;  i2=N*(x2-1)+y2;

              if grod(y1,x1)>0 && grod(y2,x2)>0 
                                   temp=filled==i1; n1=inder(temp);
                temp=filled==i2; n2=inder(temp);
                adjmat(i,n1)=1;adjmat(i,n2)=1;adjmat(n1,n2)=1 ;adjmat(n1,i)=1;adjmat(n2,i)=1;adjmat(n2,n1)=1;
             
              end                          
              
            end
            
            
            
    end
   
        
    adjout=adjmat;%+adjmat';      
        