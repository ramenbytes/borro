%% Constructs a list of indices in the "connected component" of the binary graph, returns that and the updated visitation matrix
function [conncomp, visited] = borro_visit(i, j, n, grod, visited)

queue_memory = zeros((n^2)*(12*3-12),2);
% "pointer" to the head of our queue
queue_head = 1;
% "pointer to the next empty slot in our queue
queue_tail = 1;

    function pair = push(pair)
        % This function adds an ordered pair to our queue, taking care to
        % advance the tail pointer

        % Insert pair at the next empty location
        queue_memory(queue_tail,:) = pair;
        % Move our "pointer" on to the new next empty location. Currently
        % lacking any bounds checking, which could make things interesting
        % later...
        queue_tail = queue_tail + 1;
        % after all this, pair will be returned by this function. I was
        % thinking of returning the whole queue, but since matlab copies
        % arrays that seems like a bad idea performance-wise...
    end

    function pair = pop()
        % This function removes an ordered pair from the left of our queue,
        % taking care to advance the head pointer

        % pair at our current "head pointer"
        pair = queue_memory(queue_head,:);

        queue_head = queue_head + 1;
    end

% initialize our queue with our selected indices
push([i j]);

conncomp = zeros(n^2,2);
cc_next_empty_row = 1;

component_map = zeros(n);

    % this function handles adding an ordered pair to our component's list
    % of indices and making sure we don't duplicate entries.
    function register_member(ordered_pair)
        % first we need to make sure the location is not already known to
        % be a member.
        if ~component_map(ordered_pair(1), ordered_pair(2))
            % ok, so mark it as a member
            component_map(ordered_pair(1), ordered_pair(2)) = 1; 
            % finally, add it to our component's list of indices
            conncomp(cc_next_empty_row,:) = ordered_pair;
            % and move our "pointer" forward
            cc_next_empty_row = cc_next_empty_row + 1;
        end
    end

    % this function is responsible for all the bookkeeping that happens
    % when we find a triangle formed with our current cell.
    function notice_triangle(cell1,cell2)
        % ensure our cell is logged as being a member. register_member will
        % take care of avoiding duplication.
        register_member([i, j])
        % add the two cells making a triangle with our current cell to the
        % crawl list
        push(cell1); 
        push(cell2);
        % add the two cells to the list of indices in the connected
        % component.
        register_member(cell1); 
        register_member(cell2);
    end

    % this function takes an array of indices and indicates
    % whether they are all within our array's bounds
    function [valid_indices] = in_bounds(array)
        % only positive indices or ones less than or equal to our array
        % dimensions are allowed
        valid_indices = sum(array<0 | array==0 | array>n)==0;
    end

% while the queue is non empty, search for connections
while queue_head < queue_tail
    pair = pop();
    i = pair(1);
    j = pair(2);

    if visited(i,j)
        continue
    end

    % mark our current cell as being visited.
    visited(i,j) = true;

    % First thing to do is is check for membership. Look at all triangles...

    % if our current cell is empty, it is not part of the component. move
    % along. Everything after this statement can assume that the cell is
    % occupied.
    if grod(i,j)==0
        continue
    else
        register_member([i j]);
    end
    
    % Now we check for the existence of each possible triangle. Diagrams
    % are provided to illustrate the patterns of occupied cells we're
    % looking for.

    %1
    % 1     1     0
    % 0     1     0
    % 0     0     0
    x1=j-1;
    y1=i-1;
    x2=j;
    y2=i-1;
    if in_bounds([x1 y1 x2 y2]) && grod(y1,x1)>0 && grod(y2,x2)>0
        notice_triangle([y1,x1], [y2,x2]);
    end

    %2
    % 1     0     0
    % 1     1     0
    % 0     0     0
    x1=j-1; 
    y1=i-1;
    x2=j-1;
    y2=i;
    if in_bounds([x1 y1 x2 y2]) && grod(y1,x1)>0 && grod(y2,x2)>0
      notice_triangle([y1,x1], [y2,x2]);
    end

    %3
    % 0     1     0
    % 1     1     0
    % 0     0     0
    x1=j-1;
    y1=i;
    x2=j;
    y2=i-1;
    if in_bounds([x1 y1 x2 y2]) && grod(y1,x1)>0 && grod(y2,x2)>0
       notice_triangle([y1,x1], [y2,x2]);
    end

    %4
    % 0     0     0
    % 1     1     0
    % 1     0     0 
    x1=j-1;
    y1=i+1;
    x2=j-1;
    y2=i;
    if in_bounds([x1 y1 x2 y2]) && grod(y1,x1)>0 && grod(y2,x2)>0
        notice_triangle([y1,x1], [y2,x2]);
    end

    %5
    % 0     0     0
    % 0     1     0
    % 1     1     0
    x1=j-1;
    y1=i+1;
    x2=j;
    y2=i+1;
    if in_bounds([x1 y1 x2 y2]) && grod(y1,x1)>0 && grod(y2,x2)>0
      notice_triangle([y1,x1], [y2,x2]);
    end

    %6
    % 0     0     0
    % 1     1     0
    % 0     1     0
    x1=j-1;
    y1=i;
    x2=j;
    y2=i+1;
    if in_bounds([x1 y1 x2 y2]) && grod(y1,x1)>0 && grod(y2,x2)>0
      notice_triangle([y1,x1], [y2,x2]);
    end

    %7
    % 0     1     1
    % 0     1     0
    % 0     0     0
    x1=j;
    y1=i-1;
    x2=j+1;
    y2=i-1;
    if in_bounds([x1 y1 x2 y2]) && grod(y1,x1)>0 && grod(y2,x2)>0
        notice_triangle([y1,x1], [y2,x2]);
    end

    %8
    % 0     0     1
    % 0     1     1
    % 0     0     0
    x1=j+1;
    y1=i;
    x2=j+1;
    y2=i-1;
    if in_bounds([x1 y1 x2 y2]) && grod(y1,x1)>0 && grod(y2,x2)>0
      notice_triangle([y1,x1], [y2,x2]);
    end

    %9
    % 0     1     0
    % 0     1     1
    % 0     0     0
    x1=j+1;
    y1=i;
    x2=j;
    y2=i-1;
    if in_bounds([x1 y1 x2 y2]) && grod(y1,x1)>0 && grod(y2,x2)>0
       notice_triangle([y1,x1], [y2,x2]);
    end

    %10
    % 0     0     0
    % 0     1     1
    % 0     0     1
    x1=j+1;
    y1=i;
    x2=j+1;
    y2=i+1;
    if in_bounds([x1 y1 x2 y2]) && grod(y1,x1)>0 && grod(y2,x2)>0
        notice_triangle([y1,x1], [y2,x2]);
    end

    %11
    % 0     0     0
    % 0     1     1
    % 0     1     0
    x1=j+1;
    y1=i;
    x2=j;
    y2=i+1;
    if in_bounds([x1 y1 x2 y2]) && grod(y1,x1)>0 && grod(y2,x2)>0
        notice_triangle([y1,x1], [y2,x2]);
    end

    %12
    % 0     0     0
    % 0     1     0
    % 0     1     1
    x1=j+1;
    y1=i+1;
    x2=j;
    y2=i+1;
    if in_bounds([x1 y1 x2 y2]) && grod(y1,x1)>0 && grod(y2,x2)>0
        notice_triangle([y1,x1], [y2,x2]);
    end

end

% Chop off all of conncomp that is unused
conncomp = conncomp(1:(cc_next_empty_row - 1), :);
end