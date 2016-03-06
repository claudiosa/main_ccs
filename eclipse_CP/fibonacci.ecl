:-lib(ic).

fibo:- 

 	N is 50,  %%% N primeiros Fibonacci em um ARRAY
    writeln(N),
	dim(Array,[N]),
    %%% Tem que aumentar muito o dominio para N grandes
	Array #:: 0..50000000000,   %% dominio
    write('ARRAY 0:'), writeln(Array), 

   /* POSTANDO AS RESTRICOES */
	Array[1] #= 0, %%% Array tem index em 1
    Array[2] #= 1,
	(for(I,3,N),
		param( Array )
    	do
		Array[I] #= (Array[I-1] + Array[I-2])
	),
  
    /* Convertendo um Array -> List ... para o search ou labeling */
	 flatten_array( Array,L_Array),

%%	write('ARRAY 1:'), writeln(Array), 
	labeling(L_Array),%%% APOS o labeling
	write('ARRAY 2:'), writeln(Array), 
	write('LISTA:'), writeln(L_Array).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
SAIDA

50
ARRAY 0:[](_829{0 .. 50000000000}, _843{0 .. 50000000000}, _857{0 .. 50000000000}, _871{0 .. 50000000000}, _885{0 .. 50000000000}, _899{0 .. 50000000000}, _913{0 .. 50000000000}, _927{0 .. 50000000000}, _941{0 .. 50000000000}, _955{0 .. 50000000000}, _969{0 .. 50000000000}, _983{0 .. 50000000000}, _997{0 .. 50000000000}, _1011{0 .. 50000000000}, _1025{0 .. 50000000000}, _1039{0 .. 50000000000}, _1053{0 .. 50000000000}, _1067{0 .. 50000000000}, _1081{0 .. 50000000000}, _1095{0 .. 50000000000}, _1109{0 .. 50000000000}, _1123{0 .. 50000000000}, _1137{0 .. 50000000000}, _1151{0 .. 50000000000}, _1165{0 .. 50000000000}, _1179{0 .. 50000000000}, _1193{0 .. 50000000000}, _1207{0 .. 50000000000}, _1221{0 .. 50000000000}, _1235{0 .. 50000000000}, _1249{0 .. 50000000000}, _1263{0 .. 50000000000}, _1277{0 .. 50000000000}, _1291{0 .. 50000000000}, _1305{0 .. 50000000000}, _1319{0 .. 50000000000}, _1333{0 .. 50000000000}, _1347{0 .. 50000000000}, _1361{0 .. 50000000000}, _1375{0 .. 50000000000}, _1389{0 .. 50000000000}, _1403{0 .. 50000000000}, _1417{0 .. 50000000000}, _1431{0 .. 50000000000}, _1445{0 .. 50000000000}, _1459{0 .. 50000000000}, _1473{0 .. 50000000000}, _1487{0 .. 50000000000}, _1501{0 .. 50000000000}, _1515{0 .. 50000000000})
ARRAY 2:[](0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229, 832040, 1346269, 2178309, 3524578, 5702887, 9227465, 14930352, 24157817, 39088169, 63245986, 102334155, 165580141, 267914296, 433494437, 701408733, 1134903170, 1836311903, 2971215073, 4807526976, 7778742049)
LISTA:[0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, ...]

*/

