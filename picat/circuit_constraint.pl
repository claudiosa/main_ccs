
import cp, util.

main => 
        circ_ex(X) ,
        write(X).
%%% explica circuit
circ_ex(L) =>
    L = [X1,X2,X3,X4], 
    L :: 1..4, %% NUM de indices da lista
    meu_circuit(L),
    solve(L).

%solve(L).    


meu_circuito(L) =>
    
    Tam = L.length,
    V = to_array(L),
    V :: 1..Tam	,
    printf("\n Array: %w", V),
    
    X :: 1..Tam,
    foreach(I in 1..Tam)
     %%%  V[I] #= X ,
       	%I #!= X,
	V[I] #= X 	
       %bind_vars(V[I],X)		 
    end,

    % all_different(V),
    %solve([V,X]),
    printf("\n Array diff: %w", V)
    . 

 % #/\ (I #!= X),
 %     bind_vars(V[I],X) 
  