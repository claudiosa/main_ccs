//
// Breadth-First Search (BFS) allows you to ﬁnd the shortest distance between two nodes in the graph.
// Partially inspired from
// https://github.com/vlang/v/blob/master/examples/bfs.v

// I  follow literally code in C, done many years ago

fn breadth_first_search_path(graph map[string][]string, start string, target string) []string 
 {
	mut path := []string{} // ONE PATH with SUCCESS = map
	mut queue := []string{} // a queue ... many paths
	//all_nodes := graph.keys() // get a key of this map
	n_nodes := graph.len // numbers of nodes
	mut visited := a_map_nodes_bool (n_nodes) // a map fully
	//false ... not visited yet: {'A': false, 'B': false, 'C': false, 'D': false, 'E': false}
	queue << [start] // first arrival

   for (queue.len != 0) // or queue.len > 0
	{
        mut node := departure( mut queue ) // get the front node, but it not deleted
	    if  visited[ node ] == false
		{
          // check if this already visited
		  // if no ... test if is it a final node?
		  visited[node] = true
		  if node == target {
			//path << node
            path = build_path_reverse(graph, start, node, visited)
			return path
		}
	// MISSING >>>> whereis the valid path????
    // expansion of node removed from  queue
	print("\n Expansion of node ${node} (true/false): ${graph[node]}")
		for vertex in graph[node]  // take  all nodes from the node
		{
		  //println("\n ...${vertex}")	
          if visited[vertex] == false // not explored yet
		  {
           queue << vertex
		  }
      
		}
		print("\n QUEUE: ${queue} (only not visited) \n Visited: ${visited}")
		}
		
	} 
	//[]string{init: vertex}
    path = ['Path not found, problem in the Graph, start or end nodes! ']
	return path
}

fn main() {
// Adjacency matrix as a map	
	graph := {
		'A': ['B', 'C']
		'B': ['A', 'D', 'E']
		'C': ['A', 'F']
		'D': ['B']
		'E': ['B', 'F']
		'F': ['C', 'E']
	}
	println('Graph: $graph')
	path := breadth_first_search_path(graph, 'A', 'F')
	println('\n The shortest path from node A to node F is: ${path.reverse()}')
}

//////////// AUX FUNCTIONS //////////////////
// Creating a map for VISITED nodes ... 
// starting by false ===> means this node 
// was not visited yet
fn a_map_nodes_bool (size int)  map [string]  bool {
	mut my_map := map [string] bool {} 
	base := 65
    mut	key := byte(base).ascii_str()
	for i in 0 .. size {
		key = byte(base+i).ascii_str()
		my_map[key] = false  
	}
   	return my_map
 }

// classical a departure node  from QUEUE
fn departure (mut queue [] string) string {
	mut x := queue[0]
    queue.delete(0)
	//print("\n a queue in the function ${queue}")
    return x

}
// Based in current node that is final,
// search for his father, already visited, up to the root
fn build_path_reverse(graph map[string][]string, start string, final string, visited map [string] bool) []string {
array_of_nodes := graph.keys()   
mut current := final
mut path := []string {}
path << current

for ( current != start)
{
  	for i in array_of_nodes 
	{
	 if (current in graph[i]) && (visited[i]==true)
	   { current = i
		 break // the first ocurrence is enough
	   }
	}
 path << current //update the path tracked
}
return path
}

/*
SOME TESTS
>>> mut queue := []int{}
>>> queue << [2]
>>> queue << [21,45,67]
>>> print(queue)
[2, 21, 45, 67]
>>> mut x := queue[0]
>>> print(x)
21
>>> queue << [77]
>>> print(queue)
[21, 45, 67, 77]

>>> println(graph['F'])
['C', 'E']
 */