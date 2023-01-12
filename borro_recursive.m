%% Given a binary matrix, this function returns all the Borromean connected components in it 
function connected_components = new_method(grod)
    % This functions passes off most of the work to visit, just ensuring
    % all indices are visited and collecting all the results.

    [m, n] = size(grod);
    assert (m==n), "Your array isn't square";

    % element i,j of this array is a boolean indicating whether element
    % arr(i,j) has been visited.
    visited = zeros(n);

    connected_components = cell(n^2,1);
    % "pointer" to next "empty" spot in our array
    ccs_next_empty_slot = 1;

    for i = 1:n
        for j = 1:n
 
            [component, visited] = borro_visit(i, j, n, grod, visited);
            if ~isempty(component)
                % add the component to the end of the "list"
                connected_components{ccs_next_empty_slot} = component;
                % advance "pointer", again without any sanity checks? Maybe
                % this should be changed to be saner, from a debugging
                % point of view.
                ccs_next_empty_slot = ccs_next_empty_slot + 1;
            end
        end
    end

    % chop off our unused elements
    connected_components = connected_components(1:(ccs_next_empty_slot-1));
end