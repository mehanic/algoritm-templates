
function algoP.AllPairsShortestPathLengthWithDijkstra897
    set output_file "main.py"

    set template_content "
import sys

class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = sys.maxint
        # Mark all nodes unvisited        
        self.visited = False  
        # Predecessor
        self.previous = None

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=0):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
        self.vertDictionary[to].addNeighbor(self.vertDictionary[frm], cost)

    def getVertices(self):
        return self.vertDictionary.keys()

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous

def shortest(v, path):
    ''' make shortest path from v.previous'''
    if v.previous:
        path.append(v.previous.getVertexID())
        shortest(v.previous, path)
    return

import heapq

def dijkstra(G, source):
    # Set the distance for the source node to zero 
    source.setDistance(0)

    # Put tuple pair into the priority queue
    unvisitedQueue = [(v.getDistance(), v) for v in G]
    heapq.heapify(unvisitedQueue)

    while len(unvisitedQueue):
        # Pops a vertex with the smallest distance 
        uv = heapq.heappop(unvisitedQueue)
        current = uv[1]
        current.setVisited()

        # for next in v.adjacent:
        for next in current.adjacent:
            # if visited, skip
            if next.visited:
                continue
            newDist = current.getDistance() + current.getWeight(next)
            
            if newDist < next.getDistance():
                next.setDistance(newDist)
                next.setPrevious(current)
                print 'Updated : current = %s next = %s newDist = %s' \
                        % (current.getVertexID(), next.getVertexID(), next.getDistance())
            else:
                print 'Not updated : current = %s next = %s newDist = %s' \
                        % (current.getVertexID(), next.getVertexID(), next.getDistance())

        # Rebuild heap
        # 1. Pop every item
        while len(unvisitedQueue):
            heapq.heappop(unvisitedQueue)
        # 2. Put all vertices not visited into the queue
        unvisitedQueue = [(v.getDistance(), v) for v in G if not v.visited]
	heapq.heapify(unvisitedQueue)

def allPairsShortestPathLength(G, cutoff=None):
    paths = {}
    for n in G:
        paths[n] = dijkstra(G, n, cutoff=cutoff)
    return paths 	
	
if __name__ == '__main__':

    G = Graph()
    G.addVertex('a')
    G.addVertex('b')
    G.addVertex('c')
    G.addVertex('d')
    G.addVertex('e')
    G.addEdge('a', 'b', 4)  
    G.addEdge('a', 'c', 1)
    G.addEdge('c', 'b', 2)
    G.addEdge('b', 'e', 4)
    G.addEdge('c', 'd', 4)
    G.addEdge('d', 'e', 4)

    print 'Graph data:'
    for v in G:
        for w in v.getConnections():
            vid = v.getVertexID()
            wid = w.getVertexID()
            print '( %s , %s, %3d)' % (vid, wid, v.getWeight(w))
	    
    source = G.getVertex('a')
    destination = G.getVertex('e')    
    dijkstra(G, source) 
    
    for v in G.vertDictionary.values():
	print source.getVertexID(), " to ", v.getVertexID(), "-->", v.getDistance()
	
    path = [destination.getVertexID()]
    shortest(destination, path)
    print 'The shortest path from a to e is: %s' % (path[::-1])
    print allPairsShortestPathLength(G)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.BFS898
    set output_file "main.py"

    set template_content "
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
	
import sys
class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = sys.maxint
        # Mark all nodes unvisited        
        self.visited = False
        # Mark all nodes color with white        
        self.color = 'white'  	
        # Predecessor
        self.previous = None

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance
	
    def setColor(self, color):
        self.color = color

    def getColor(self):
        return self.color	

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=0):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
	# For directed graph do not add this
        self.vertDictionary[to].addNeighbor(self.vertDictionary[frm], cost)

    def getVertices(self):
        return self.vertDictionary.keys()

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous
	
    def getEdges(self):
        edges = []
	for v in G:
		for w in v.getConnections():
		    vid = v.getVertexID()
		    wid = w.getVertexID()
		    edges.append((vid, wid, v.getWeight(w)))
	return edges
 
def BFSTraversal(G, s):  
	start = G.getVertex(s)
	start.setDistance(0)
	start.setPrevious(None)
	vertQueue = Queue()
	vertQueue.enQueue(start)

	while (vertQueue.size > 0):
		currentVert = vertQueue.deQueue()
		print currentVert.getVertexID()
		for nbr in currentVert.getConnections():
			if (nbr.getColor() == 'white'):
				nbr.setColor('gray')
				nbr.setDistance(currentVert.getDistance() + 1)
				nbr.setPrevious(currentVert)
				vertQueue.enQueue(nbr)
			currentVert.setColor('black')

def BFS(G):
	for v in G:
		if (v.getColor() == 'white'):
			BFSTraversal(G, v.getVertexID())

if __name__ == '__main__':

    G = Graph()
    G.addVertex('a')
    G.addVertex('b')
    G.addVertex('c')
    G.addVertex('d')
    G.addVertex('e')
    G.addVertex('f')
    G.addEdge('a', 'b', 1)  
    G.addEdge('a', 'c', 1)
    G.addEdge('b', 'd', 1)
    G.addEdge('b', 'e', 1)
    G.addEdge('c', 'd', 1)
    G.addEdge('c', 'e', 1)
    G.addEdge('d', 'e', 1)
    G.addEdge('e', 'a', 1)
    print 'Graph data:'
    print G.getEdges()
 
    BFS(G)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BellManFord899
    set output_file "main.py"

    set template_content '
import sys
def BellmanFord(G, source):
    destination = {} 
    predecessor = {} 
    for node in G:
        destination[node] = sys.maxint  # We start admiting that the rest of nodes are very very far
        predecessor[node] = None
    destination[source] = 0  # For the source we know how to reach
    for i in range(len(G) - 1): 
        for u in G:
            for v in G[u]:  # For each neighbour of u
		# If the distance between the node and the neighbour is lower than the one I have now
		if destination[v] > destination[u] + G[u][v]:
			# Record this lower distance
			destination[v] = destination[u] + G[u][v]
			predecessor[v] = u		
 
    # Step 3: check for negative-weight cycles
    for u in G:
        for v in G[u]:
            assert destination[v] <= destination[u] + G[u][v]
 
    return destination, predecessor	
    
if __name__ == '__main__':
	G = {
		'A': {'B':-1, 'C':  4},
		'B': {'C':  3, 'D':  2, 'E':  2},
		'C': {},
		'D': {'B':  1, 'C':  5},
		'E': {'D':-3}
	}
	print BellmanFord(G, 'A')
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.BridgesInGraphs900
    set output_file "main.py"

    set template_content '
import math
adjMatrix = [[0 for x in G.numVertices] for x in G.numVertices]
dfsnum = [0] * G.numVertices
num = 0
low = [0] * G.numVertices
def Bridges(G, u) :
	low[u] = num
	dfsnum[u] = num
	num = num + 1
	for v in range(0, G.numVertices):
		if(G.adjMatrix[u][v] and dfsnum[v] == -1):
			cutVertices(v)
			if(low[v] > dfsnum[u]):
				print (u, v)  # as a bridge
			low[u] = min (low[u] , low[v])
		else:  # (u,v) is a back edge
			low[u ] = min(low[u] , dfsnum[v])

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BucketSort901
    set output_file "main.py"

    set template_content '
def insertionSort(A):
  for i in range(1, len(A)):
    temp = A[i]
    k = i
    while k > 0 and temp < A[k - 1]:
        A[k] = A[k - 1]
        k -= 1
    A[k] = temp    
    
def BucketSort(A):
  code = Hashing(A)
  buckets = [list() for _ in range(code[1])]
  for i in A:
    x = ReHashing(i, code)
    buck = buckets[x]
    buck.append(i)
    
  for bucket in buckets:
    insertionSort(bucket)
 
  ndx = 0
  for b in range(len(buckets)):
    for v in buckets[b]:
      A[ndx] = v
      ndx += 1
      
  return A
 
import math
 
def Hashing(A):
  m = A[0]
  for i in range(1, len(A)):
    if (m < A[i]):
      m = A[i]
  result = [m, int(math.sqrt(len(A)))]
  return result
  
def ReHashing(i, code):
  return int(i / code[0] * (code[1] - 1))
  
A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
print(BucketSort(A))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CheckSimplePathInGraph902
    set output_file "main.py"

    set template_content '
class Graph(object):
    def __init__(self, graph_dict={}):
        """ initializes a graph object """
        self.graphDictionary = graph_dict

    def vertices(self):
        """ returns the vertices of a graph """
        return list(self.graphDictionary.keys())

    def edges(self):
        """ returns the edges of a graph """
        return self.generateEdges()

    def addVertex(self, vertex):
     
        if vertex not in self.graphDictionary:
            self.graphDictionary[vertex] = []

    def addEdge(self, edge):
        edge = set(edge)
        (vertex1, vertex2) = tuple(edge)
        if vertex1 in self.graphDictionary:
            self.graphDictionary[vertex1].append(vertex2)
        else:
            self.graphDictionary[vertex1] = [vertex2]

    def generateEdges(self):
        """ A static method generating the edges of the 
            graph "graph". Edges are represented as sets 
            with one (a loop back to the vertex) or two 
            vertices 
        """
        edges = []
        for vertex in self.graphDictionary:
            for neighbour in self.graphDictionary[vertex]:
                if {neighbour, vertex} not in edges:
                    edges.append({vertex, neighbour})
        return edges

    def __str__(self):
        res = "vertices: "
        for k in self.graphDictionary:
            res += str(k) + " "
        res += "\nedges: "
        for edge in self.generateEdges():
            res += str(edge) + " "
        return res
	
    def checkForPath(self, source, destination, path=[]):
	""" find a path from source to destination in graph """
	graph = self.graphDictionary
	path = path + [source]
	if source == destination:
	    return path
	if source not in graph:
	    return None
	for vertex in graph[source]:
	    if vertex not in path:
		extendedPath = self.checkForPath(vertex, destination, path)
		if extendedPath: 
		    return extendedPath
	return None

if __name__ == "__main__":

    g = { "a" : ["b", "c"],
          "b" : ["d", "e"],
          "c" : ["d", "e"],
          "d" : ["e"],
          "e" : ["a"],
          "f" : []
        }
    graph = Graph(g)

    print("Vertices of graph:")
    print(graph.vertices())

    print("Edges of graph:")
    print(graph.edges())
    
    pathResult = graph.checkForPath("a", "e") 
    if(pathResult == None):
	    print "No path between source and destination"
    else:
	    print pathResult
	    
    pathResult = graph.checkForPath("a", "f") 
    if(pathResult == None):
	    print "No path between source and destination"
    else:
	    print pathResult
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CountConnectedComponentsWithBFS903
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
	
import sys
class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = sys.maxint
        # Mark all nodes unvisited        
        self.visited = False
        # Mark all nodes color with white        
        self.color = 'white'  	
        # Predecessor
        self.previous = None

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance
	
    def setColor(self, color):
        self.color = color

    def getColor(self):
        return self.color	

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=0):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
	# For directed graph do not add this
        self.vertDictionary[to].addNeighbor(self.vertDictionary[frm], cost)

    def getVertices(self):
        return self.vertDictionary.keys()

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous
	
    def getEdges(self):
        edges = []
	for v in G:
		for w in v.getConnections():
		    vid = v.getVertexID()
		    wid = w.getVertexID()
		    edges.append((vid, wid, v.getWeight(w)))
	return edges

def bfs(G, s):  
	start = G.getVertex(s)
	start.setDistance(0)
	start.setPrevious(None)
	vertQueue = Queue()
	vertQueue.enQueue(start)

	while (vertQueue.size > 0):
		currentVert = vertQueue.deQueue()
		print currentVert.getVertexID()
		for nbr in currentVert.getConnections():
			if (nbr.getColor() == 'white'):
				nbr.setColor('gray')
				nbr.setDistance(currentVert.getDistance() + 1)
				nbr.setPrevious(currentVert)
				vertQueue.enQueue(nbr)
			currentVert.setColor('black')
	
def countConnectedComponentsWithBFS(G):
	edges = []
	count = 0
	for v in G:
		if (v.getColor() == 'white'):
			count += 1
			bfs(G, v.getVertexID())
	print count
	
if __name__ == '__main__':

    G = Graph()
    G.addVertex('a')
    G.addVertex('b')
    G.addVertex('c')
    G.addVertex('d')
    G.addVertex('e')
    G.addVertex('f')
    G.addVertex('g')
    G.addVertex('h')
    G.addEdge('a', 'b', 1)  
    G.addEdge('a', 'c', 1)
    G.addEdge('b', 'd', 1)
    G.addEdge('b', 'e', 1)
    G.addEdge('c', 'd', 1)
    G.addEdge('c', 'e', 1)
    G.addEdge('d', 'e', 1)
    G.addEdge('e', 'a', 1)
    print 'Graph data:'
    print G.getEdges()    
    print countConnectedComponentsWithBFS(G)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CountConnectedComponentsWithDFS904
    set output_file "main.py"

    set template_content '
import sys
class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = sys.maxint
        # Mark all nodes unvisited        
        self.visited = False  
        # Predecessor
        self.previous = None

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=0):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
	# For directed graph do not add this
        self.vertDictionary[to].addNeighbor(self.vertDictionary[frm], cost)

    def getVertices(self):
        return self.vertDictionary.keys()

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous
	
    def getEdges(self):
        edges = []
	for currentVert in G:
		for nbr in currentVert.getConnections():
		    currentVertID = currentVert.getVertexID()
		    nbrID = nbr.getVertexID()
		    edges.append((currentVertID, nbrID, currentVert.getWeight(nbr)))
	return edges

def dfs(G, currentVert, visited):
	visited[currentVert] = True  # mark the visited node 
	print "traversal: " + currentVert.getVertexID()
	for nbr in currentVert.getConnections():  # take a neighbouring node 
		if nbr not in visited:  # condition to check whether the neighbour node is already visited
			dfs(G, nbr, visited)  # recursively traverse the neighbouring node 
 
def countConnectedComponentsWithDFS(G):
	visited = {}  # Dictionary to mark the visited nodes 
	count = 0
	for currentVert in G:  # G contains vertex objects
		if currentVert not in visited:  # Start traversing from the root node only if its not visited 
			count += 1
			dfs(G, currentVert, visited)  # For a connected graph this is called only once 
	return count
	
if __name__ == '__main__':

    G = Graph()
    G.addVertex('a')
    G.addVertex('b')
    G.addVertex('c')
    G.addVertex('d')
    G.addVertex('e')
    G.addVertex('f')
    G.addVertex('g')
    G.addVertex('h')   
    G.addEdge('a', 'b', 1)  
    G.addEdge('a', 'c', 1)
    G.addEdge('b', 'd', 1)
    G.addEdge('b', 'e', 1)
    G.addEdge('c', 'd', 1)
    G.addEdge('c', 'e', 1)
    G.addEdge('d', 'e', 1)
    G.addEdge('e', 'a', 1)
    print 'Graph data:'
    print G.getEdges()
 
    print countConnectedComponentsWithDFS(G)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountSimplePathsFromSourceToDestination905
    set output_file "main.py"

    set template_content '
class Graph(object):
    def __init__(self, graph_dict={}):
        self.graphDictionary = graph_dict

    def vertices(self):
        return list(self.graphDictionary.keys())

    def edges(self):
        return self.generateEdges()

    def addVertex(self, vertex):
        if vertex not in self.graphDictionary:
            self.graphDictionary[vertex] = []

    def addEdge(self, edge):
        edge = set(edge)
        (vertex1, vertex2) = tuple(edge)
        if vertex1 in self.graphDictionary:
            self.graphDictionary[vertex1].append(vertex2)
        else:
            self.graphDictionary[vertex1] = [vertex2]

    def generateEdges(self):
        edges = []
        for vertex in self.graphDictionary:
            for neighbour in self.graphDictionary[vertex]:
                if {neighbour, vertex} not in edges:
                    edges.append({vertex, neighbour})
        return edges

    def __str__(self):
        res = "vertices: "
        for k in self.graphDictionary:
            res += str(k) + " "
        res += "\nedges: "
        for edge in self.generateEdges():
            res += str(edge) + " "
        return res
	
    def countSimplePathsFromSourceToDestination(self, source, destination, path=[]):
        graph = self.graphDictionary 
        path = path + [source]
        if source == destination:
            return [path]
        if source not in graph:
            return []
        paths = []
        for vertex in graph[source]:
            if vertex not in path:
                extended_paths = self.countSimplePathsFromSourceToDestination(vertex, destination, path)
                for p in extended_paths: 
                    paths.append(p)
        return paths

if __name__ == "__main__":

    g = { "a" : ["b", "c"],
          "b" : ["d", "e"],
          "c" : ["d", "e"],
          "d" : ["e"],
          "e" : ["a"],
          "f" : []
        }
    graph = Graph(g)

    print("Vertices of graph:")
    print(graph.vertices())

    print("Edges of graph:")
    print(graph.edges())
    
    pathResult = graph.countSimplePathsFromSourceToDestination("a", "e") 
    if(len(pathResult) == 0):
	    print "No path between source and destination"
    else:
	    print pathResult
	    
    pathResult = graph.countSimplePathsFromSourceToDestination("a", "f") 
    if(len(pathResult) == 0):
	    print "No path between source and destination"
    else:
	    print pathResult
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CutVertices906
    set output_file "main.py"

    set template_content '
mport math
adjMatrix = [[0 for x in G.numVertices] for x in G.numVertices]
dfsnum = [0] * G.numVertices
num = 0
low = [0] * G.numVertices
def CutVertices(G, u) :
	low[u] = num
	dfsnum[u] = num
	num = num + 1
	for v in range(0, G.numVertices):
		if(G.adjMatrix[u][v] and dfsnum[v] == -1):
			CutVertices(v) 
			if(low[v] > dfsnum[u]):
				print "Cut Vetex:", u
			low[u] = min (low[u] , low[v]) 
		 
		else:  # (u,v) is a back edge
			low[u ] = min(low[u] , dfsnum[v])
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DFS907
    set output_file "main.py"

    set template_content '
import sys
class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = sys.maxint
        # Mark all nodes unvisited        
        self.visited = False  
        # Predecessor
        self.previous = None

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=0):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
	# For directed graph do not add this
        self.vertDictionary[to].addNeighbor(self.vertDictionary[frm], cost)

    def getVertices(self):
        return self.vertDictionary.keys()

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous
	
    def getEdges(self):
        edges = []
	for currentVert in G:
		for nbr in currentVert.getConnections():
		    currentVertID = currentVert.getVertexID()
		    nbrID = nbr.getVertexID()
		    edges.append((currentVertID, nbrID, currentVert.getWeight(nbr)))
	return edges

def dfs(G, currentVert, visited):
    visited[currentVert] = True  # mark the visited node 
    print "traversal: " + currentVert.getVertexID()
    for nbr in currentVert.getConnections():  # take a neighbouring node 
        if nbr not in visited:  # condition to check whether the neighbour node is already visited
            dfs(G, nbr, visited)  # recursively traverse the neighbouring node 
 
def DFSTraversal(G):
    visited = {}  # Dictionary to mark the visited nodes 
    for currentVert in G:  # G contains vertex objects
        if currentVert not in visited:  # Start traversing from the root node only if its not visited 
            dfs(G, currentVert, visited)  # For a connected graph this is called only once 

if __name__ == '__main__':

    G = Graph()
    G.addVertex('a')
    G.addVertex('b')
    G.addVertex('c')
    G.addVertex('d')
    G.addVertex('e')
    G.addVertex('f')
    G.addEdge('a', 'b', 1)  
    G.addEdge('a', 'c', 1)
    G.addEdge('b', 'd', 1)
    G.addEdge('b', 'e', 1)
    G.addEdge('c', 'd', 1)
    G.addEdge('c', 'e', 1)
    G.addEdge('d', 'e', 1)
    G.addEdge('e', 'a', 1)
    print 'Graph data:'
    print G.getEdges()
 
    DFSTraversal(G)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DetectCycleInGraph908
    set output_file "main.py"

    set template_content '
def DetectCycle(G) :
	for i in range(0, G.numVertices):
		Visited[s] = 0
		Predecessor[i] = 0
	
	for i in range(0, G.numVertices):
		if(not Visited[i] and HasCycle(G, i)):
			return 1
	return False

def HasCycle(G, u) :
	Visited[u] = 1
	for i in range(0, G.numVertices):
		if(G.adjMatrix[s][i]) :
			if(Predecessor[i] != u and Visited[i]):
				return 1
			else:
				Predecessor[i] = u
				return  HasCycle(G, i)
	return 0

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Dijkstra909
    set output_file "main.py"

    set template_content '
import sys

class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = sys.maxint
        # Mark all nodes unvisited        
        self.visited = False  
        # Predecessor
        self.previous = None

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=0):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
        self.vertDictionary[to].addNeighbor(self.vertDictionary[frm], cost)

    def getVertices(self):
        return self.vertDictionary.keys()

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous

def shortest(v, path):
    if v.previous:
        path.append(v.previous.getVertexID())
        shortest(v.previous, path)
    return

import heapq

def dijkstra(G, source, destination):
    # Set the distance for the source node to zero 
    source.setDistance(0)

    # Put tuple pair into the priority queue
    unvisitedQueue = [(v.getDistance(), v) for v in G]
    heapq.heapify(unvisitedQueue)

    while len(unvisitedQueue):
        # Pops a vertex with the smallest distance 
        uv = heapq.heappop(unvisitedQueue)
        current = uv[1]
        current.setVisited()

        # for next in v.adjacent:
        for next in current.adjacent:
            # if visited, skip
            if next.visited:
                continue
            newDist = current.getDistance() + current.getWeight(next)
            
            if newDist < next.getDistance():
                next.setDistance(newDist)
                next.setPrevious(current)
                print 'Updated : current = %s next = %s newDist = %s' \
                        % (current.getVertexID(), next.getVertexID(), next.getDistance())
            else:
                print 'Not updated : current = %s next = %s newDist = %s' \
                        % (current.getVertexID(), next.getVertexID(), next.getDistance())


        while len(unvisitedQueue):
            heapq.heappop(unvisitedQueue)
        # 2. Put all vertices not visited into the queue
        unvisitedQueue = [(v.getDistance(), v) for v in G if not v.visited]
	heapq.heapify(unvisitedQueue)
    
if __name__ == '__main__':

    G = Graph()
    G.addVertex('a')
    G.addVertex('b')
    G.addVertex('c')
    G.addVertex('d')
    G.addVertex('e')
    G.addEdge('a', 'b', 4)  
    G.addEdge('a', 'c', 1)
    G.addEdge('c', 'b', 2)
    G.addEdge('b', 'e', 4)
    G.addEdge('c', 'd', 4)
    G.addEdge('d', 'e', 4)

    print 'Graph data:'
    for v in G:
        for w in v.getConnections():
            vid = v.getVertexID()
            wid = w.getVertexID()
            print '( %s , %s, %3d)' % (vid, wid, v.getWeight(w))
	    
    source = G.getVertex('a')
    destination = G.getVertex('e')    
    dijkstra(G, source, destination) 
    
    for v in G.vertDictionary.values():
	print source.getVertexID(), " to ", v.getVertexID(), "-->", v.getDistance()
	
    path = [destination.getVertexID()]
    shortest(destination, path)
    print 'The shortest path from a to e is: %s' % (path[::-1])
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.GraphAdjacencyMatrix910
    set output_file "main.py"

    set template_content '
class Vertex:
    def __init__(self, node):
        self.id = node
        # Mark all nodes unvisited        
        self.visited = False  

    def addNeighbor(self, neighbor, G):
	G.addEdge(self.id, neighbor)

    def getConnections(self, G):
        return G.adjMatrix[self.id]

    def getVertexID(self):
        return self.id

    def setVertexID(self, id):
        self.id = id

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id)

class Graph:
    def __init__(self, numVertices, cost=0):
        self.adjMatrix = [[-1] * numVertices for _ in range(numVertices)]
        self.numVertices = numVertices
	self.vertices = []
	for i in range(0, numVertices):
		newVertex = Vertex(i)
		self.vertices.append(newVertex)

    def setVertex(self, vtx, id):
	if 0 <= vtx < self.numVertices:
		self.vertices[vtx].setVertexID(id)

    def getVertex(self, n):
        for vertxin in range(0, self.numVertices):
		if n == self.vertices[vertxin].getVertexID():
			return vertxin
        else:
            return -1

    def addEdge(self, frm, to, cost=0): 
        if self.getVertex(frm) != -1 and self.getVertex(to) != -1:
		self.adjMatrix[self.getVertex(frm)][self.getVertex(to)] = cost
		# For directed graph do not add this
		self.adjMatrix[self.getVertex(to)][self.getVertex(frm)] = cost  
		
    def getVertices(self):
	vertices = []
        for vertxin in range(0, self.numVertices):
		vertices.append(self.vertices[vertxin].getVertexID())
        return vertices
	
    def printMatrix(self):
	for u in range(0, self.numVertices):
		row = []
		for v in range(0, self.numVertices):
			row.append(self.adjMatrix[u][v])
		print row	
	
    def getEdges(self):
        edges = []
	for v in range(0, self.numVertices):
		for u in range(0, self.numVertices):
			if self.adjMatrix[u][v] != -1:
				vid = self.vertices[v].getVertexID()
				wid = self.vertices[u].getVertexID()
				edges.append((vid, wid, self.adjMatrix[u][v]))
	return edges
    
if __name__ == '__main__':
    G = Graph(5)
    G.setVertex(0, 'a')
    G.setVertex(1, 'b')
    G.setVertex(2, 'c')
    G.setVertex(3, 'd')
    G.setVertex(4, 'e')
    print 'Graph data:'  
    G.addEdge('a', 'e', 10)  
    G.addEdge('a', 'c', 20)
    G.addEdge('c', 'b', 30)
    G.addEdge('b', 'e', 40)
    G.addEdge('e', 'd', 50)
    G.addEdge('f', 'e', 60)
    print G.printMatrix()      
    print G.getEdges()    
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.GraphsAdjacenyList911
    set output_file "main.py"

    set template_content '

import sys
class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = sys.maxint
        # Mark all nodes unvisited        
        self.visited = False  
        # Predecessor
        self.previous = None

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=0):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
	# For directed graph do not add this
        self.vertDictionary[to].addNeighbor(self.vertDictionary[frm], cost)

    def getVertices(self):
        return self.vertDictionary.keys()

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous
	
    def getEdges(self):
        edges = []
	for v in G:
		for w in v.getConnections():
		    vid = v.getVertexID()
		    wid = w.getVertexID()
		    edges.append((vid, wid, v.getWeight(w)))
	return edges
    
if __name__ == '__main__':

    G = Graph()
    G.addVertex('a')
    G.addVertex('b')
    G.addVertex('c')
    G.addVertex('d')
    G.addVertex('e')
    G.addEdge('a', 'b', 4)  
    G.addEdge('a', 'c', 1)
    G.addEdge('c', 'b', 2)
    G.addEdge('b', 'e', 4)
    G.addEdge('c', 'd', 4)
    G.addEdge('d', 'e', 4)

    print 'Graph data:'
    print G.getEdges()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.HamilTonianPath912
    set output_file "main.py"

    set template_content '
class Vertex(object):
    def __init__(self, node, *nodeList):
        self.i = node
        self.nodeList = list(nodeList)
 
    def __hash__(self):
        return self.i
 
    def reaches(self, vertex):
        if isinstance(vertex, int):
            return vertex in self.nodeList
        return self.reaches(vertex.i)
 
    def __str__(self):
        return '< ' + str(self.i) + '>'
 
    def __repr__(self):
        return self.__str__()
 
 
class Graph(object):
    def __init__(self):
        self.vList = {}
 
    def add(self, node, *nodeList):
        vertex = Vertex(node, *nodeList)
        self.vList[node] = vertex
 
    def hamiltonian(self, current=None, pending=None, destiny=None):
        if pending is None:
            pending = self.vList.values()
 
        result = None
 
        if current is None:
            for current in pending:
                result = self.hamiltonian(current, [x for x in pending if x is not current], current)
                if result is not None:
                    break
        else:
            if pending == []: 
                if current.reaches(destiny):
                    return [current]
                else:
                    return None
 
            for x in [self.vList[v] for v in current.nodeList]:
                if x in pending:
                    result = self.hamiltonian(x, [y for y in pending if y is not x], destiny)
                    if result is not None:
                        result = [current] + result
                        break    
 
        return result
 
if __name__ == '__main__':
    G = Graph() 
    G.add(1, 2, 8, 11)
    G.add(2, 1, 6, 9)
    G.add(3, 6, 7, 9, 10)
    G.add(4, 5, 7, 10)
    G.add(5, 4, 8, 11)
    G.add(6, 2, 3, 8)
    G.add(7, 3, 4, 8)
    G.add(8, 1, 6, 7, 5)
    G.add(9, 2, 3, 11)
    G.add(10, 3, 4, 11)
    G.add(11, 1, 9, 10, 5)
    print G.hamiltonian()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.IsDirectedAcyclicGraph_DAG913
    set output_file "main.py"

    set template_content '
import sys
class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = sys.maxint
        # Mark all nodes unvisited        
        self.visited = False  
        # Predecessor
        self.previous = None
        # InDegree Count
        self.inDegree = 0	
        # OutDegree Count
        self.outDegree = 0	

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  
	
    def setInDegree(self, inDegree):
        self.inDegree = inDegree
    def getInDegree(self):
        return self.inDegree

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=1):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
	self.vertDictionary[to].inDegree += 1

    def getVertices(self):
        return self.vertDictionary

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous
	
    def getEdges(self):
        edges = []
	for v in G:
		for w in v.getConnections():
		    vid = v.getVertexID()
		    wid = w.getVertexID()
		    edges.append((vid, wid, v.getWeight(w)))
	return edges

def topologicalSort(G):
	"""Perform a topological sort of the nodes. If the graph has a cycle,
	throw a GraphTopologicalException with the list of successfully
	ordered nodes."""
	# topologically sorted list of the nodes (result)
	topologicalList = []
	# queue (fifo list) of the nodes with inDegree 0
	topologicalQueue = []
	# {node: inDegree} for the remaining nodes (those with inDegree>0)
	remainingInDegree = {}
	
	nodes = G.getVertices()
	for v in G:
		indegree = v.getInDegree()
		if indegree == 0:
			topologicalQueue.append(v)
		else:
			remainingInDegree[v] = indegree

	# remove nodes with inDegree 0 and decrease the inDegree of their sons
	while len(topologicalQueue):
	    # remove the first node with degree 0
	    node = topologicalQueue.pop(0)
	    topologicalList.append(node)
	    # decrease the inDegree of the sons
	    for son in node.getConnections():
		son.setInDegree(son.getInDegree() - 1)
		if son.getInDegree() == 0:
		    topologicalQueue.append(son)

	# if not all nodes were covered, the graph must have a cycle
	# raise a GraphTopographicalException
	if len(topologicalList) != len(nodes):
	    return False
	    
	# Printing the topological order    
	while len(topologicalList):
		 node = topologicalList.pop(0)
		 print node.getVertexID()
	return True

def isDirectedAcyclicGraph(G):
    if topologicalSort(G) :
        return True
    else:
        return False	
	
if __name__ == '__main__':
    G = Graph()
    G.addVertex('A')
    G.addVertex('B')
    G.addVertex('C')
    G.addVertex('D')
    G.addVertex('E')
    G.addVertex('F')
    G.addVertex('G')
    G.addVertex('H')
    G.addVertex('I')
    G.addEdge('A', 'B')   
    G.addEdge('A', 'C')   
    G.addEdge('A', 'G')  
    G.addEdge('A', 'E')  
    G.addEdge('B', 'C')       
    G.addEdge('C', 'G')   
    G.addEdge('D', 'E')  
    G.addEdge('D', 'F')  
    G.addEdge('F', 'H')       
    G.addEdge('E', 'H')    
    G.addEdge('H', 'I')      	    
    print isDirectedAcyclicGraph(G)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Kruskals914
    set output_file "main.py"

    set template_content "
import sys
class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = sys.maxint - 10
        # Mark all nodes unvisited        
        self.visited = False  
        # Predecessor
        self.previous = None

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=0):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
        self.vertDictionary[to].addNeighbor(self.vertDictionary[frm], cost)

    def getVertices(self):
        return self.vertDictionary.keys()

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous

def shortest(v, path):
    if v.previous:
        path.append(v.previous.getVertexID())
        shortest(v.previous, path)
    return

parent = dict()
rank = dict()

def makeSet(vertice):
    parent[vertice] = vertice
    rank[vertice] = 0

def find(vertice):
    if parent[vertice] != vertice:
        parent[vertice] = find(parent[vertice])
    return parent[vertice]

def union(vertice1, vertice2):
    root1 = find(vertice1)
    root2 = find(vertice2)
    if root1 != root2:
        if rank[root1] > rank[root2]:
            parent[root2] = root1
        else:
            parent[root1] = root2
            if rank[root1] == rank[root2]: rank[root2] += 1
		    
parent = dict()
rank = dict()

def make_set(vertice):
    parent[vertice] = vertice
    rank[vertice] = 0

def find(vertice):
    if parent[vertice] != vertice:
        parent[vertice] = find(parent[vertice])
    return parent[vertice]

def union(vertice1, vertice2):
    root1 = find(vertice1)
    root2 = find(vertice2)
    if root1 != root2:
        if rank[root1] > rank[root2]:
            parent[root2] = root1
        else:
            parent[root1] = root2
            if rank[root1] == rank[root2]: rank[root2] += 1

def kruskal(G):
	edges = []
	for v in G:
		makeSet(v.getVertexID())
		for w in v.getConnections():
			vid = v.getVertexID()
			wid = w.getVertexID()
			edges.append((v.getWeight(w), vid, wid))
	edges.sort()
	minimumSpanningTree = set()	
	for edge in edges:
		weight, vertice1, vertice2 = edge
		if find(vertice1) != find(vertice2):
		    union(vertice1, vertice2)
		    minimumSpanningTree.add(edge)
	return minimumSpanningTree
	
if __name__ == '__main__':
    G = Graph()
    G.addVertex('A')
    G.addVertex('B')
    G.addVertex('C')
    G.addVertex('D')
    G.addVertex('E')
    G.addVertex('F')
    G.addEdge('A', 'B', 1)
    G.addEdge('A', 'C', 5)
    G.addEdge('A', 'D', 3)
    G.addEdge('B', 'C', 4)
    G.addEdge('B', 'D', 2)
    G.addEdge('C', 'D', 1)
    
    print 'Graph data:'
    for v in G:
        for w in v.getConnections():
            vid = v.getVertexID()
            wid = w.getVertexID()
            print '( %s , %s, %3d)' % (vid, wid, v.getWeight(w))

    print kruskal(G)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestPathInDAG915
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
	
import sys
class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = sys.maxint
        # Mark all nodes unvisited        
        self.visited = False
        # Mark all nodes color with white        
        self.color = 'white'  	
        # Predecessor
        self.previous = None

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance
	
    def setColor(self, color):
        self.color = color

    def getColor(self):
        return self.color	

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=0):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
	# For directed graph do not add this
        self.vertDictionary[to].addNeighbor(self.vertDictionary[frm], cost)

    def getVertices(self):
        return self.vertDictionary.keys()

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous
	
    def getEdges(self):
        edges = []
	for v in G:
		for w in v.getConnections():
		    vid = v.getVertexID()
		    wid = w.getVertexID()
		    edges.append((vid, wid, v.getWeight(w)))
	return edges

def dfs(G, u, visited):
    visited[u] = True  # mark the visited node 
    print "traversal: " + u.getVertexID()
    for neighbourNodes in u.getConnections():  # take a neighbouring node 
        if neighbourNodes not in visited:  # condition to check whether the neighbour node is already visited
            dfs(G, neighbourNodes, visited)  # recursively traverse the neighbouring node 
 
def BFSTraversal(G, s):
	global maxPathLength
	pathLength = 0
	start = G.getVertex(s)
	start.setDistance(0)
	start.setPrevious(None)
	vertQueue = Queue()
	vertQueue.enQueue(start)
	vertQueue.enQueue(None)
	while (vertQueue.size > 0):
		currentVert = vertQueue.deQueue()
		if(currentVert == None):
			pathLength += 1
			if vertQueue.size > 0:
				vertQueue.enQueue(None)
			continue
		print currentVert.getVertexID()
		for nbr in currentVert.getConnections():
			if (nbr.getColor() == 'white'):
				nbr.setColor('gray')
				nbr.setDistance(currentVert.getDistance() + 1)
				nbr.setPrevious(currentVert)
				vertQueue.enQueue(nbr)
			currentVert.setColor('black')
	if pathLength > maxPathLength:
		maxPathLength = pathLength
		
maxPathLength = 0	
def LongestPathInDAG(G):

	for v in G:
		if (v.getColor() == 'white'):
			BFSTraversal(G, v.getVertexID())
	return maxPathLength

if __name__ == '__main__':
    G = Graph()
    G.addVertex('a')
    G.addVertex('b')
    G.addVertex('c')
    G.addVertex('d')
    G.addVertex('e')
    G.addVertex('f')
    G.addEdge('a', 'b', 1)  
    G.addEdge('a', 'c', 1)
    G.addEdge('b', 'd', 1)
    G.addEdge('b', 'e', 1)
    G.addEdge('c', 'd', 1)
    G.addEdge('c', 'e', 1)
    G.addEdge('d', 'e', 1)
    G.addEdge('e', 'a', 1)
    print 'Graph data:'
    print G.getEdges()

    print LongestPathInDAG(G)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Prims916
    set output_file "main.py"

    set template_content "
import sys
class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = sys.maxint - 10
        # Mark all nodes unvisited        
        self.visited = False  
        # Predecessor
        self.previous = None

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=0):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
        self.vertDictionary[to].addNeighbor(self.vertDictionary[frm], cost)

    def getVertices(self):
        return self.vertDictionary.keys()

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous

def shortest(v, path):
    ''' make shortest path from v.previous'''
    if v.previous:
        path.append(v.previous.getVertexID())
        shortest(v.previous, path)
    return

import heapq

def dijkstraModifiedForPrims(G, source):
    print '''Dijkstra Modified for Prim'''
    # Set the distance for the source node to zero 
    source.setDistance(0)

    # Put tuple pair into the priority queue
    unvisitedQueue = [(v.getDistance(), v) for v in G]
    heapq.heapify(unvisitedQueue)

    while len(unvisitedQueue):
        # Pops a vertex with the smallest distance 
        uv = heapq.heappop(unvisitedQueue)
        current = uv[1]
        current.setVisited()
        # for next in v.adjacent:
        for next in current.adjacent:
            # if visited, skip
            if next.visited:
                continue
            newCost = current.getWeight(next)
            
            if newCost < next.getDistance():
                next.setDistance(current.getWeight(next))
                next.setPrevious(current)
                print 'Updated : current = %s next = %s newCost = %s' \
                        % (current.getVertexID(), next.getVertexID(), next.getDistance())
            else:
                print 'Not updated : current = %s next = %s newCost = %s' \
                        % (current.getVertexID(), next.getVertexID(), next.getDistance())

        # Rebuild heap
        # 1. Pop every item
        while len(unvisitedQueue):
            heapq.heappop(unvisitedQueue)
        # 2. Put all vertices not visited into the queue
        unvisitedQueue = [(v.getDistance(), v) for v in G if not v.visited]
	heapq.heapify(unvisitedQueue)
    
if __name__ == '__main__':

    G = Graph()
    G.addVertex('A')
    G.addVertex('B')
    G.addVertex('C')
    G.addVertex('D')
    G.addVertex('E')
    G.addEdge("A", "B", 7)
    G.addEdge("A", "D", 5)
    G.addEdge("B", "C", 8)
    G.addEdge("B", "D", 9)
    G.addEdge("B", "E", 7)
    G.addEdge("C", "E", 5)
    G.addEdge("D", "E", 15)
    G.addEdge("D", "F", 6)
    G.addEdge("E", "F", 8)
    G.addEdge("E", "G", 9)
    G.addEdge("F", "G", 11)
    
    print 'Graph data:'
    for v in G:
        for w in v.getConnections():
            vid = v.getVertexID()
            wid = w.getVertexID()
            print '( %s , %s, %3d)' % (vid, wid, v.getWeight(w))
	    
    source = G.getVertex('A')
    dijkstraModifiedForPrims(G, source) 
    
    for v in G.vertDictionary.values():
	if v.previous:
		print v.getVertexID(), " to ", v.previous.getVertexID(), "-->", v.getDistance()
	else:
		print v.getVertexID(), " to None -->", v.getDistance()
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.StronglyConnectedComponents917
    set output_file "main.py"

    set template_content '
def stronglyConnectedComponents(G):
    indexCounter = [0]
    stack = []
    lowLinks = {}
    index = {}
    result = []   
    def strongConnect(node):
        # set the depth index for this node to the smallest unused index
        index[node] = indexCounter[0]
        lowLinks[node] = indexCounter[0]
        indexCounter[0] += 1
        stack.append(node)
    
        # Consider successors of `node`
        try:
            successors = G[node]
        except:
            successors = []
        for successor in successors:
            if successor not in lowLinks:
                # Successor has not yet been visited; recurse on it
                strongConnect(successor)
                lowLinks[node] = min(lowLinks[node], lowLinks[successor])
            elif successor in stack:
                # the successor is in the stack and hence in the current strongly connected component (SCC)
                lowLinks[node] = min(lowLinks[node], index[successor])
        
        # If `node` is a root node, pop the stack and generate an SCC
        if lowLinks[node] == index[node]:
            connectedComponent = []
            
            while True:
                successor = stack.pop()
                connectedComponent.append(successor)
                if successor == node: break
            component = tuple(connectedComponent)
            # storing the result
            result.append(component)
    
    for node in G:
        if node not in lowLinks:
            strongConnect(node)
    
    return result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.TopologicalSort918
    set output_file "main.py"

    set template_content '
import sys
class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = sys.maxint
        # Mark all nodes unvisited        
        self.visited = False  
        # Predecessor
        self.previous = None
        # InDegree Count
        self.inDegree = 0	
        # OutDegree Count
        self.outDegree = 0	

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  
	
    def setInDegree(self, inDegree):
        self.inDegree = inDegree
    def getInDegree(self):
        return self.inDegree

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=1):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
	self.vertDictionary[to].inDegree += 1

    def getVertices(self):
        return self.vertDictionary

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous
	
    def getEdges(self):
        edges = []
	for v in G:
		for w in v.getConnections():
		    vid = v.getVertexID()
		    wid = w.getVertexID()
		    edges.append((vid, wid, v.getWeight(w)))
	return edges

def topologicalSort(G):
	"""Perform a topological sort of the nodes. If the graph has a cycle,
	throw a GraphTopologicalException with the list of successfully
	ordered nodes."""
	# topologically sorted list of the nodes (result)
	topologicalList = []
	# queue (fifo list) of the nodes with inDegree 0
	topologicalQueue = []
	# {node: inDegree} for the remaining nodes (those with inDegree>0)
	remainingInDegree = {}
	
	nodes = G.getVertices()
	for v in G:
		indegree = v.getInDegree()
		if indegree == 0:
			topologicalQueue.append(v)
		else:
			remainingInDegree[v] = indegree

	# remove nodes with inDegree 0 and decrease the inDegree of their sons
	while len(topologicalQueue):
	    # remove the first node with degree 0
	    node = topologicalQueue.pop(0)
	    topologicalList.append(node)
	    # decrease the inDegree of the sons
	    for son in node.getConnections():
		son.setInDegree(son.getInDegree() - 1)
		if son.getInDegree() == 0:
		    topologicalQueue.append(son)

	# if not all nodes were covered, the graph must have a cycle
	# raise a GraphTopographicalException
	if len(topologicalList) != len(nodes):
	    raise GraphTopologicalException(topologicalList)
	    
	# Printing the topological order    
	while len(topologicalList):
		 node = topologicalList.pop(0)
		 print node.getVertexID()
		 
if __name__ == '__main__':
    G = Graph()
    G.addVertex('A')
    G.addVertex('B')
    G.addVertex('C')
    G.addVertex('D')
    G.addVertex('E')
    G.addVertex('F')
    G.addVertex('G')
    G.addVertex('H')
    G.addVertex('I')
    G.addEdge('A', 'B')   
    G.addEdge('A', 'C')   
    G.addEdge('A', 'G')  
    G.addEdge('A', 'E')  
    G.addEdge('B', 'C')       
    G.addEdge('C', 'G')   
    G.addEdge('D', 'E')  
    G.addEdge('D', 'F')  
    G.addEdge('F', 'H')       
    G.addEdge('E', 'H')    
    G.addEdge('H', 'I')      
    print 'Graph data:'
    print G.getEdges()	    
    topologicalSort(G)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.UnweightedShortestPathWithBFS919
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
	
import sys
class Vertex:
    def __init__(self, node):
        self.id = node
        self.adjacent = {}
        # Set distance to infinity for all nodes
        self.distance = -1
        # Mark all nodes unvisited        
        self.visited = False  
        # Predecessor
        self.previous = None

    def addNeighbor(self, neighbor, weight=0):
        self.adjacent[neighbor] = weight

    def getConnections(self):
        return self.adjacent.keys()  

    def getVertexID(self):
        return self.id

    def getWeight(self, neighbor):
        return self.adjacent[neighbor]

    def setDistance(self, dist):
        self.distance = dist

    def getDistance(self):
        return self.distance

    def setPrevious(self, prev):
        self.previous = prev

    def setVisited(self):
        self.visited = True

    def __str__(self):
        return str(self.id) + ' adjacent: ' + str([x.id for x in self.adjacent])

class Graph:
    def __init__(self):
        self.vertDictionary = {}
        self.numVertices = 0

    def __iter__(self):
        return iter(self.vertDictionary.values())

    def addVertex(self, node):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(node)
        self.vertDictionary[node] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertDictionary:
            return self.vertDictionary[n]
        else:
            return None

    def addEdge(self, frm, to, cost=0):
        if frm not in self.vertDictionary:
            self.addVertex(frm)
        if to not in self.vertDictionary:
            self.addVertex(to)

        self.vertDictionary[frm].addNeighbor(self.vertDictionary[to], cost)
	# For directed graph do not add this
        self.vertDictionary[to].addNeighbor(self.vertDictionary[frm], cost)

    def getVertices(self):
        return self.vertDictionary.keys()

    def setPrevious(self, current):
        self.previous = current

    def getPrevious(self, current):
        return self.previous
	
    def getEdges(self):
        edges = []
	for v in G:
		for w in v.getConnections():
		    vid = v.getVertexID()
		    wid = w.getVertexID()
		    edges.append((vid, wid, v.getWeight(w)))
	return edges
    
def UnweightedShortestPath(G, s):  
	source = G.getVertex(s)
	source.setDistance(0)
	source.setPrevious(None)
	vertQueue = Queue()
	vertQueue.enQueue(source)
	while (vertQueue.size > 0):
		currentVert = vertQueue.deQueue()
		for nbr in currentVert.getConnections():
			if nbr.getDistance() == -1:
				nbr.setDistance(currentVert.getDistance() + 1)
				nbr.setPrevious(currentVert)
				vertQueue.enQueue(nbr)
	for v in G.vertDictionary.values():
		print source.getVertexID(), " to ", v.getVertexID(), "-->", v.getDistance()

if __name__ == '__main__':
    G = Graph()
    G.addVertex('A')
    G.addVertex('B')
    G.addVertex('C')
    G.addVertex('D')
    G.addVertex('E')
    G.addVertex('F')
    G.addVertex('G')
    G.addVertex('H')
    G.addVertex('I')
    G.addEdge('A', 'B')   
    G.addEdge('A', 'C')   
    G.addEdge('A', 'G')  
    G.addEdge('A', 'E')  
    G.addEdge('B', 'C')       
    G.addEdge('C', 'G')   
    G.addEdge('D', 'E')  
    G.addEdge('D', 'F')  
    G.addEdge('F', 'H')       
    G.addEdge('E', 'H')    
    G.addEdge('H', 'I')      
    print 'Graph data:'
    print G.getEdges()	    
    UnweightedShortestPath(G, 'A')
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Hamming-num920
    set output_file "main.py"

    set template_content '
def get(k):
    q = [1]
    while k > 0:
        x = q.pop(0)
        q = uniq_insert(q, x*2)
        q = uniq_insert(q, x*3)
        q = uniq_insert(q, x*5)
        k = k - 1
    return x

def uniq_insert(q, x):
    i = 0
    while i < len(q) and q[i] < x:
        i = i+1
    if i < len(q) and x == q[i]:
        return q
    q.insert(i, x)
    return q
        
def get1(k):
    if k == 1:
        return 1
    (q2, q3, q5) = ([2], [3], [5])
    while k > 1:
        x = min(q2[0], q3[0], q5[0])
        if x == q2[0]:
            q2.pop(0)
            q2.append(x*2)
            q3.append(x*3)
            q5.append(x*5)
        elif x == q3[0]:
            q3.pop(0)
            q3.append(x*3)
            q5.append(x*5)
        else:
            q5.pop(0)
            q5.append(x*5)
        k = k - 1
    return x

if __name__ == "__main__":
    print get(1500)
    print get1(1500)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
function algoP.Hash-city921
    set output_file "main.py"

    set template_content '
import random
import hashlib # for bloom filer

C = ["Beijing", "Shanghai", "Hong Kong", "Tianjin", "Wuhan", "Guangzhou",
     "Shenzhen", "Shenyang", "Chongqing", "Taipei", "Xian", "Chengdu",
     "Changchun", "Hangzhou", "Jinan", "Dalian", "Taiyuan", "Zhengzhou",
     "Qingdao", "Shijiazhuang", "Kunming", "Lanzhou", "Gaoxiong", "Zibo"]

WORD = 4

def init(lst):
    idx = {}
    for i in range(len(C)):
        idx[C[i]] = i
    return idx

#def bitmap(idx, lst):
#    bits = [0]*len(C)
#    for k in lst:
#        bits[idx[k]] = 1
#    return bits

# compressed bitmap
def bitmap(idx, lst):
    bits = [0] * (len(C)/WORD)
    for k in lst:
        setbit(bits, idx[k])
    return bits

def setbit(bits, i):
    bits[i/WORD] |= 1<<(i % WORD)

def testbit(bits, i):
    return bits[i/WORD] & (1<<(i % WORD)) != 0

#def elem(idx, bits, x):
#    return bits[idx[x]]==1

def elem(idx, bits, x):
    return testbit(bits, idx[x])

# method 2: using bloom filter

def init_hash():
    hashes = []
    hashes.append(hashlib.md5())
    hashes.append(hashlib.sha1())
    hashes.append(hashlib.sha224())
    return hashes

def apply_hash(hashes, x):
    r = 0
    for h in hashes:
        h.update(x)
        r |= int(h.hexdigest(), 16)
    return r

def create_filter(hashes, lst):
    bfilter = 0
    for k in lst: 
        bfilter |= apply_hash(hashes, k)
    return bfilter

def elem_bloom_filter(hashes, bfilter, x):
    r = apply_hash(hashes, x)
    return (r & bfilter) == r 

def test():
    idx = init(C)
    for i in range(100):
        k = random.randint(0, len(C))
        lst = random.sample(C, k)
        bits = bitmap(idx, lst)
        for i in range(100):
            x = random.choice(C)
            assert(elem(idx, bits, x) == (x in lst))
    print "OK"

def test_bloom_filter():
    hashes = init_hash()
    (failed, n) = (0, 0)
    for i in range(100):
        k = random.randint(0, len(C))
        lst = random.sample(C, k)
        bfilter = create_filter(hashes, lst)
        for i in range(100):
            x = random.choice(C)
            n = n + 1
            if elem_bloom_filter(hashes, bfilter, x) != (x in lst):
                failed = failed + 1
        if elem_bloom_filter(hashes, bfilter, "New York"):
            failed = failed + 1
        n = n + 1
    print "Bloom Filter failed rate", float(failed)/float(n)*100, "%"

if __name__ == "__main__":
    test()
    test_bloom_filter()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Queue922
    set output_file "main.py"

    set template_content '
class Queue:
    def __init__(self):
        self.front = []
        self.rear = []

    def is_empty(self):
        return not self.front

    def push(self, x):
        self.front.append(x)

    def pop(self):
        if not self.rear:
            self.rear = list(reversed(self.front))
            self.front = []
        return self.rear.pop()

    def to_list(self):
        return list(reversed(self.rear)) + self.front

def test():
    n = 100
    q = Queue()
    xs = []
    for x in sample(range(n), n):
        if x % 2 == 0:
            q.push(x)
            xs.append(x)
        elif not q.is_empty():
            a = xs.pop(0)
            b = q.pop()
            assert a == b, f"pop fail: list pop: {a}, queue pop: {b}"
        ys = q.to_list()
        assert xs == ys, f"error: list = {xs}, queue = {ys}"
    print(f"Batched Queue {n} test cases passed.")

if __name__ == "__main__":
    test()

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.RtQueue923
    set output_file "main.py"

    set template_content '
from random import sample  # for verification


class State:
    def __init__(self, f=[], r=[]):
        self.acc = []
        self.front = f
        self.rear = r
        self.idx = 0
        self.step()

    # compute reverse(f) ++ r step by step
    def step(self):
        if self.front:  # reversing
            self.acc.append(self.front.pop())
        if (not self.front) and self.idx < len(self.rear):  # concatenating
            self.acc.append(self.rear[self.idx])
            self.idx = self.idx + 1
        return self

    def done(self):
        return (not self.front) and len(self.rear) <= self.idx

    def to_list(self):
        return self.front + (list(reversed(self.acc))[self.idx :])

    def __str__(self):
        return f"acc:{self.acc}, f:{self.front}, r:{self.rear}, idx:{self.idx}"


class RealtimeQueue:
    def __init__(self):
        self.front = []
        self.rear = []
        self.state = None

    def is_empty(self):
        return (not self.front) and (not self.rear)

    def push(self, x):
        self.front.append(x)
        self.balance()

    def pop(self):
        x = self.rear.pop()
        self.balance()
        return x

    def balance(self):
        if not self.state and len(self.rear) < len(self.front):
            self.state = State(self.front, self.rear)
            self.front = []
        if self.state and self.state.step().done():
            self.rear = self.state.acc
            self.state = None

    def to_list(self):
        return (
            list(reversed(self.rear))
            + (self.state.to_list() if self.state else [])
            + self.front
        )

    def __str__(self):
        return f"f: {self.front}, r: {self.rear}, st: {self.state}"


def test():
    n = 100
    q = RealtimeQueue()
    xs = []
    for x in sample(range(n), n):
        if x % 2 == 0:
            q.push(x)
            xs.append(x)
        else:
            assert q.is_empty() == (xs == []), f"empty test fail: xs: {xs}, q: {q}"
            if not q.is_empty():
                a = xs.pop(0)
                b = q.pop()
                assert a == b, f"pop fail: list pop: {a}, queue pop: {b}"
        ys = q.to_list()
        assert xs == ys, f"error: list = {xs}, queue = {ys}, ({q})"
    print(f"Batched Queue {n} test cases passed.")


if __name__ == "__main__":
    test()

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SelectSort924
    set output_file "main.py"

    set template_content '
import random

def naive_ssort(xs):
    ys = []
    while xs != []:
        m = min(xs)
        xs.remove(m)
        ys.append(m)
    return ys

def in_place_ssort(xs):
    n = len(xs)
    for i in range(n):
        m = min_at(xs, i, n)
        (xs[i], xs[m]) = (xs[m], xs[i])
    return xs

def min_at(xs, i, n):
    m = i;
    for j in range(i+1, n):
        if xs[j] < xs[m]:
            m = j
    return m

def cocktail_sort(xs):
    n = len(xs)
    for i in range(n / 2):
        (mi, ma) = (i, n - 1 -i)
        if xs[ma] < xs[mi]:
            (xs[mi], xs[ma]) = (xs[ma], xs[mi])
        for j in range(i+1, n - 1 - i):
            if xs[j] < xs[mi]:
                mi = j
            if xs[ma] < xs[j]:
                ma = j
        (xs[i], xs[mi]) = (xs[mi], xs[i])
        (xs[n - 1 - i], xs[ma]) = (xs[ma], xs[n - 1 - i])
    return xs

def cocktail_sort1(xs):
    n = len(xs)
    for i in range(n / 2):
        (mi, ma) = (i, i)
        for j in range(i+1, n - i):
            if xs[j] < xs[mi]:
                mi = j
            if xs[ma] < xs[j]:
                ma = j
        if (ma < mi):
            (xs[mi], xs[ma]) = (xs[ma], xs[mi])
            (mi, ma) = (ma, mi)
        (xs[i], xs[mi]) = (xs[mi], xs[i])
        (xs[n - 1 - i], xs[ma]) = (xs[ma], xs[n - 1 - i])
    return xs


def test_sort(f, xs):
    #assert sorted(xs) == f([y for y in xs])
    ys = [y for y in xs]
    if sorted(xs) != f(ys):
        print "xs        =", xs
        print "ys        =", ys
        print "sorted(xs)=", sorted(xs)
        exit()

def test():
    for _ in xrange(100):
        n = random.randint(0, 100)
        xs = random.sample(range(100), n)
        test_sort(naive_ssort, xs)
        test_sort(in_place_ssort, xs)
        test_sort(cocktail_sort, xs)
        test_sort(cocktail_sort1, xs)

if __name__ == "__main__":
    #print cocktail_sort1([55, 52, 53, 99, 78, 16, 2, 41, 9, 39, 28, 37, 24, 19, 47, 83, 66, 92])
    test()

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SelectionSort925
    set output_file "main.py"

    set template_content '
from itertools import izip

N_INF = -10000

class Node:

    def __init__(self, x = None, l = None, r = None):
        self.key = x
        self.left = l 
        self.right = r
        self.parent = None
        if l is not None:
            l.parent = self
        if r is not None:
            r.parent = self

def leaf(t):
    return t is not None and t.left is None and t.right is None

# limitation: |xs| = 2 ^ m for some m in N
def build(xs):
    ts = [ Node(x) for x in xs]
    while len(ts) > 1:
        ts1 = []
        for x, y in zip(*[iter(ts)]*2):
            ts1.append(Node(max(x.key, y.key), x, y))
        ts = ts1
    return ts[0]

# limitation: for all x, x > -inf
def pop(t):
    x = t.key
    t.key = N_INF
    while not leaf(t):
        t = t.left if t.left.key == x else t.right
        t.key = N_INF
    while t.parent is not None:
        t = t.parent
        t.key = max(t.left.key, t.right.key)
    return (x, t)

def empty(t):
    return t.key == N_INF

# testing

# same limitation as build function.
def tsort(xs):
    ys = []
    t = build(xs)
    while not empty(t):
        (x, t) = pop(t)
        ys.append(x)
    return reversed(ys)

def to_str(t):
    return "." if t is None else "(" + to_str(t.left) + " " + str(t.key) + " " + to_str(t.right) + ")"

if __name__ == "__main__":
    xs = [7, 6, 15, 16, 8, 4, 13, 3, 5, 10, 9, 1, 12, 2, 11, 14]
    print to_str(build(xs))
    print "sort:", tsort(xs)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.SelectionSort926
    set output_file "main.py"

    set template_content '
import random

def csort(xs):
    n = len(xs)
    cnt = [0]*n
    for i in range(n-1, 0, -1):
        for j in range(i-1, -1, -1):
            if xs[i] < xs[j]:
                cnt[j] = cnt[j] + 1
            else:
                cnt[i] = cnt[i] + 1
    for i in range(n):
        while cnt[i] != i:
            j = cnt[i]
            (xs[i], xs[j]) = (xs[j], xs[i])
            (cnt[i], cnt[j]) = (cnt[j], cnt[i])
    return xs

def test():
    for i in range(100):
        xs=[]
        n = random.randint(0, 1000)
        for j in range(n):
            xs.append(random.randint(-1000, 1000))
        assert(sorted(xs) == csort(xs))

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Bwt927
    set output_file "main.py"

    set template_content '
EOF = "\0"


def bwt(s):
    s += EOF
    table = sorted(s[i:] + s[:i] for i in range(len(s)))
    last_colum = [row[-1] for row in table]
    return "".join(last_colum)

def ibwt(r):
    table = [""] * len(r)
    for i in range(len(r)):
        table = sorted(r[i] + table[i] for i in range(len(r)))
    s = [row for row in table if row.endswith(EOF)][0]
    return s.rstrip(EOF)

# Algorithm 2, 
# Instead of sorting on rotation, we can sort on suffixes by 
# adding a special EOF char. [2].

# example: s = apple, EOF = $ (== -inf)
#
# suffixes       rotations
#  apple$        apple$
#   pple$        pple$a
#    ple$        ple$ap
#     le$        le$app
#      e$        e$appl
#       $        $apple
#
#         sorting
#
#     let i = len(s) - len(suffix)
#            i s[i-1]
#  $         5   e  $apple
#  apple$    0   $  apple$
#  e$        4   l  e$appl
#  le$       3   p  le$app
#  ple$      2   p  ple$ap
#  pple$     1   a  pple$a
#
#  result: e$lppa

def bwt1(s):
    s += EOF
    l = len(s)
    table = sorted(s[i:] for i in range(l))
    last_colum = [s[l-len(row)-1] for row in table]
    return "".join(last_colum)



def bwt2(s):
    ids = sorted(range(len(s)+1), lambda x, y: scmp(s, x, y))
    last_colum = [s[i-1] for i in ids]
    ifst = ids.index(1) # the position of s[0] in last_colum
    ieof = ids.index(0) # EOF, which is s[-1] virtually
    return ("".join(last_colum), ifst, ieof)

# suffixes comparison function, which can handle virtual EOF
#   and we treat EOF as -inf
def scmp(s, i, j):
    x = s[i:]
    y = s[j:]
    if x == []: # x is EOF
        return -1
    if y == []: # y is EOF
        return 1
    return cmp(x, y)

def ibwt2(t):
    (r, ifst, ieof) = t
    fst_colum = [r[ieof]]+sorted(r[:ieof]+r[ieof+1:]) # first element is EOF
    ids = [False]+[True]*(len(r)-1)
    trans=[0]*len(r)  # transform vector
    for i in range(len(r)):
        if i != ieof:
            x = [j for j in range(len(r)) if ids[j] and fst_colum[j] == r[i]][0]
            trans[x] = i
            ids[x] = False
    s = ""
    i = ifst
    for j in range(len(r)-1):
        s = s+r[i]
        i = trans[i]
    return s

# Algorithm 4,
#   Same as algorithm 3, but we sort on rots index
#   The main improvement is in inverse BWT, the transform
#   vector can be calculated as the following
#
#   T = snd $ sort (zip(r, [1..])
#
def bwt3(s):
    n = len(s)
    ids = sorted(range(n), lambda x, y: rcmp(s, x, y))
    last_colum = [s[(i-1)%n] for i in ids]
    return ("".join(last_colum), ids.index(0))

def rcmp(s, i, j):
    x = s[i:]+s[:i]
    y = s[j:]+s[:j]
    return cmp(x, y)

def ibwt3(p):
    (r, i) = p
    n = len(r)
    trans = [ x for (c, x) in sorted(zip(r, range(n)))]
    s = ""
    for _ in range(n):
        i = trans[i]
        s = s + r[i]
    return s

def test():
    s = "this is the demo program of bwt transform in the real programming code"
    r = bwt(s)
    print "s=", s
    print "bwt(s) ==>", r
    print "ibwt(r) ==>", ibwt(r)
    print "bwt1(s) ==>", bwt1(s)
    print "ibwt(bwt1(s)) ==>", ibwt(bwt1(s))
    t = bwt2(s)
    print "bwt2(s) ==>", t
    print "ibwt2(r) ==>", ibwt2(t)
    p = bwt3(s)
    print "bwt3(s) ==>", p
    print "ibwt3(r) ==>", ibwt3(p)

if __name__ == "__main__":
    test()

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MTF928
    set output_file "main.py"

    set template_content '
M = 256

# method 1, naive solution
def mtf(xs):
    ys = range(M)
    rs = []
    for x in xs:
        i = ys.index(ord(x))
        ys.pop(i)
        ys.insert(0, ord(x))
        rs.append(i)
    return rs

def imtf(xs):
    ys = range(M)
    rs = []
    for x in xs:
        y = ys[x]
        rs.append(chr(y))
        ys.pop(x)
        ys.insert(0, y)
    return rs

# method 1.1, naive method with manually element moving.
def mtf1(xs):
    ys = range(M)
    rs = []
    for x in xs:
        i = 0
        prev = ord(x)
        while ys[i] != ord(x):
            (prev, ys[i]) = (ys[i], prev) # swap
            i = i + 1
        ys[i] = prev
        rs.append(i)
    return rs

def imtf1(xs):
    ys = range(M)
    rs = []
    for x in xs:
        rs.append(chr(ys[x]))
        prev = ys[x]
        for i in range(x):
            (prev, ys[i]) = (ys[i], prev)
        ys[x] = prev
    return rs

def test_mtf(encode, decode, xs, msg):
    print "\ntesting MTF with", msg, "method"
    rs = encode(xs)
    print "mtf(", xs, ")=", rs
    ys = "".join(decode(rs))
    print "imtf(", rs, ")=", ys
    assert(xs == ys)

def test():
    xss = ["banana", "mississippi", "cocoa"];
    codec = [(mtf, imtf, "naive"), (mtf1, imtf1, "naive1")];
    for xs in xss:
        for (encode, decode, msg) in codec:
            test_mtf(encode, decode, xs, msg)

if __name__ == "__main__":
    test()

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
function algoP.Merge_sort929
    set output_file "main.py"

    set template_content '
import random

N = 10000

# 1. basic version as described in CLRS (Introduction to algorithm)
def msort(xs):
    n = len(xs)
    if n > 1:
        ys = [x for x in xs[:n/2]]
        zs = [x for x in xs[n/2:]]
        ys = msort(ys)
        zs = msort(zs)
        xs = merge(xs, ys, zs)
    return xs

# verbose version without using sentinel
# xs = ys `merge` zs
def merge(xs, ys, zs):
    i = 0
    while ys != [] and zs != []:
        xs[i] = ys.pop(0) if ys[0] < zs[0] else zs.pop(0)
        i = i + 1
    xs[i:] = ys if ys !=[] else zs
    return xs

# Bottom-up merge sort version.
def mergesort(xs):
    ys = [[x] for x in xs]
    while len(ys) > 1:
        ys.append(merge2(ys.pop(0), ys.pop(0)))
    return [] if ys == [] else ys.pop(0)

def merge2(xs, ys):
    zs = []
    while xs != [] and ys !=[]:
        zs.append(xs.pop(0) if xs[0] < ys[0] else ys.pop(0))
    return zs + (xs if xs !=[] else ys)

def test_sort(fsort):
    for _ in range(100):
        xs = random.sample(range(N) * 10, random.randint(0, N))
        assert sorted(xs) == fsort(xs)

def test():
    test_sort(msort)
    test_sort(mergesort)

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
function algoP.Merge_sort930
    set output_file "main.py"

    set template_content '
import random


def sort(xs):
    if len(xs) < 2:
        return xs
    ordered = False
    while not ordered:
        (ordered, xs) = proc(xs)
    return xs

# take one pass
def proc(xs):
    n = len(xs)
    ys = [xs[0]]*n
    (a, b) = (0, 0)
    (c, d) = (n, n)
    (f, r) = (0, n-1)
    t = True # put result from left if true, else put result from right
    while b < c:
        # span [a, b) as much as possible
        while b < c:
            b = b + 1
            if b < n and xs[b] < xs[b-1]:
                break
        # span [c, d) as much as possible
        while b < c:
            c = c - 1
            if c < n and xs[c-1] < xs[c]:
                break
        if b - a == n:
            return (True, xs)
        if t:
            f = merge(xs, a, b, c, d, ys, f, 1)
        else:
            r = merge(xs, a, b, c, d, ys, r, -1)
        (a, d) = (b, c)
        t = not t
    return (False, ys)

def merge(xs, a, b, c, d, ys, k, delta):
    while a < b and c < d:
        if xs[a] < xs[d-1]:
            ys[k] = xs[a]
            a = a + 1
        else:
            ys[k] = xs[d-1]
            d = d - 1
        k = k + delta
    while a < b:
        ys[k] = xs[a]
        k = k + delta
        a = a + 1
    while c < d:
        ys[k] = xs[d-1]
        k = k + delta
        d = d - 1
    return k

def test():
    for i in range(100):
        xs = random.sample(range(100), random.randint(0, 100))
        __assert_sort(xs)

def __assert_sort(xs):
    zs = [x for x in xs]
    ys = sorted(xs)
    xs = sort(xs)
    if ys != xs:
        print "before sort: ", zs
        print "expected: ", ys
        print "got     : ", xs
        exit()

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.InsertSort931
    set output_file "main.py"

    set template_content '
import random #for verification purpose only

# Insertion sort

# standard version.
def isort(xs):
    n = len(xs)
    for i in range(1, n):
        # insert xs[i] to xs[0..i-1]
        x = xs[i]
        j = i - 1
        while j >= 0 and x < xs[j]:
            xs[j+1] = xs[j]
            j = j - 1
        xs[j+1] = x
    return xs

# explicit insert function
def isort1(xs):
    ys = []
    for x in xs:
        insert(ys, x)
    return ys

def insert(xs, x):
    xs.append(x)
    i = len(xs) - 1
    while i > 0 and xs[i] < xs[i-1]:
        xs[i], xs[i-1] = xs[i-1], xs[i] #swap
        i = i - 1

def isort4(xs):
    ys = []
    for x in xs:
        insertl(ys, x)
    return ys

# insert from left
def insertl(xs, x):
    n = len(xs)
    xs.append(x)
    i = 0
    while i < n and xs[i] < x:
        i = i + 1
    while i < n:
        xs[n] = xs[n - 1]
        n = n - 1
    xs[i] = x

# improvement 1
#  Using binary search for insertion,
#    Compare O(N * lg N)
#    Move O(N^2)

def isort2(xs):
    n = len(xs)
    for i in range(1, n):
        # insert xs[i] to xs[0..i-1]
        x = xs[i]
        p = binary_search(xs[:i], x)
        for j in range(i, p, -1):
            xs[j] = xs[j-1]
        xs[p] = x
    return xs

# modified binary search, x may not exist in xs
def binary_search(xs, x):
    l = 0
    u = len(xs)
    while l < u:
        m = (l + u) // 2
        if xs[m] == x:
            return m # find a duplicated element
        elif xs[m] < x:
            l = m + 1
        else:
            u = m
    return l

# improvement 2,
#   Using linked-list to gain constant time, O(1), insert operation.
#   Instead of using pointer based linked-list, we can use
#   index based linked-list

def isort3(xs):
    n = len(xs)
    next = [-1]*(n+1)
    for i in range(n):
        insert1(xs, next, i)
    return reorder(xs, next)

def insert1(xs, next, i):
    j = -1
    while next[j] != -1 and xs[next[j]] < xs[i]:
        j = next[j]
    next[j], next[i] = i, next[j]

def reorder(xs, next):
    i = -1
    ys = []
    while next[i] != -1:
        ys.append(xs[next[i]])
        i = next[i]
    return ys

def test():
    for _ in range(100):
        n = random.randint(0, 100)
        xs = [random.randint(0, n) for _ in range(n)]
        ys = sorted(xs)
        assert(isort(list(xs)) == ys)
        assert(isort1(list(xs)) == ys)
        assert(isort2(list(xs)) == ys)
        assert(isort3(list(xs)) == ys)
        assert(isort4(list(xs)) == ys)
    print("done")

# internal use only, need remove
def assertEqual(xs, ys):
    if not xs == ys:
        print("xs", xs)
        print("ys", ys)
        exit(1)

if __name__ == "__main__":
    #print isort3([5,1,2,4,3,3])
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.StringBm932
    set output_file "main.py"

    set template_content '
import random # for verification purpose only
import string # for verification purpose only

def bmh_match(w, p):
    n = len(w)
    m = len(p)
    tab = bad_char(p)
    res = []
    offset = 0
    while offset + m <= n:
        i = m - 1
        while i >= 0 and p[i] == w[offset+i]:
            i = i - 1
        if i < 0:
            res.append(offset)
            offset = offset + 1
        else:
            offset = offset + tab[ord(w[offset + m - 1])]
    return res

# The bad-character rulea
#  Note that, the calculation for the last character in the pattern is skipped,
#  This is becasue we want to avoid 0 shifting, which will lead to endless loop.
def bad_char(p):
    m = len(p)
    tab = [m for _ in range(256)]  # table to hold the bad character rule.
    for i in range(m-1):
        tab[ord(p[i])] = m - 1 - i
    return tab

# Boyer-Moore original algorithm
#   Use both the bad-character rule, and the good-suffix rule

def bm_match(w, p):
    n = len(w)
    m = len(p)
    tab1 = bad_char(p)
    tab2 = good_suffix(p)
    res = []
    offset = 0
    while offset + m <= n:
        i = m - 1
        while i >= 0 and p[i] == w[offset + i]:
            i = i - 1
        if i < 0:
            res.append(offset)
            offset = offset + 1
        else:
            offset = offset + max(tab1[ord(w[offset + m - 1])], tab2[i])
    return res

# The good-suffix rule
#   case 1. Only a part of the matching suffix occurs as a prefix of the pattern
#   case 2. The matching suffix occurs somewhere else in the pattern
#  Note that, in case 1, we skip the empty suffix case.

def good_suffix(p):
    m = len(p)
    tab = [0 for _ in range(m)]
    last = 0
    # first loop for case 1
    for i in range(m-1, 0, -1): # m-1, m-2, ..., 1
        if is_prefix(p, i):
            last = i
        tab[i - 1] = last
    # second loop for case 2
    for i in range(m):
        slen = suffix_len(p, i)
        if slen != 0 and p[i - slen] != p[m - 1 - slen]:
            tab[m - 1 - slen] = m - 1 - i
    return tab

# test if p[i..m-1] `is prefix of` p
def is_prefix(p, i):
    for j in range(len(p) - i):
        if p[j] != p [i+j]:
            return False
    return True

# length of the longest suffix of p[..i], which is also a suffix of p
def suffix_len(p, i):
    m = len(p)
    j = 0
    while p[m - 1 - j] == p[i - j] and j < i:
        j = j + 1
    return j

# naive search for verification
#   O(m*n) algorithm
def naive_match(w, p):
    n = len(w)
    m = len(p)
    res = []
    for i in range(n):
        if w[i:(i+m)] == p:
            res.append(i)
    return res

def test(match):
    for k in xrange(100):
        n = random.randint(10, 10000)
        w = [random.choice(string.ascii_lowercase) for i in xrange(n)]
        i = random.randint(0, n-2)
        j = random.randint(i+1, n)
        p = w[i:j]
        __assert(match(w, p), naive_match(w, p))
    print "100 test cases run OK"

def __assert(x, y):
    if x!=y:
        print "left:", x, "right:", y

if __name__ == "__main__":
    print "boyer-moore-horspool"
    #print bmh_match("bba", "a")
    #print bmh_match("bbaabab", "ab")
    test(bmh_match)
    print "boyer-moore"
    #print bm_match("bba", "a")
    #print bm_match("bbaabab", "ab")
    #print bm_match("bbbababbababbabababb", "abbabab")
    test(bm_match)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.stringKmp933
    set output_file "main.py"

    set template_content '
import random #only for verification
import string #only for verification

# Match pattern p in text w
#   return all candidate position
def kmp_match(w, p):
    n = len(w)
    m = len(p)
    fallback = fprefix(p)
    k = 0 # how many elements have been matched so far.
    res = []
    for i in range(n):
        while k > 0 and p[k] != w[i]:
            k = fallback[k] #fall back
        if p[k] == w[i]:
            k = k + 1
        if k == m:
            res.append(i+1-m)
            k = fallback[k-1] # look for next
    return res

# Prepare the prefix-function
#   t(i) = max {k: k<i and p[1, ..., k] `is suffix of` p[1, ..., i-1]}
def fprefix(p):
    m = len(p)
    t = [0]*m  # fallback table
    k = 0
    for i in range(2, m):
        while k>0 and p[i-1] != p[k]:
            k = t[k-1] #fallback
        if p[i-1] == p[k]:
            k = k + 1
        t[i] = k
    #print "ptn=", ", ".join(p)
    #print "tab=", t
    return t

# naive search for verification
#   O(m*n) algorithm
def naive_match(w, p):
    n = len(w)
    m = len(p)
    res = []
    for i in range(n):
        if w[i:(i+m)] == p:
            res.append(i)
    return res

def test():
    for k in xrange(100):
        n = random.randint(10, 10000)
        w = [random.choice(string.ascii_lowercase) for i in xrange(n)]
        i = random.randint(0, n-2)
        j = random.randint(i+1, n)
        p = w[i:j]
        __assert(kmp_match(w, p), naive_match(w, p))
    print "100 test cases run OK"

def __assert(x, y):
    if x!=y:
        print "left:", x, "right:", y

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Palindrome934
    set output_file "main.py"

    set template_content '
DELIMITER = "#"

# The brute force solution. O(n^2)
def brute_force_palindrome(s):
    s = DELIMITER + DELIMITER.join(s) + DELIMITER
    n = len(s)
    p = [0] * n
    for i in xrange(n):
        while 0 <= i-p[i] and i+p[i] < n and s[i-p[i]] == s[i+p[i]]:
            p[i] = p[i] + 1
    return max(p) - 1

# Manachers algorithm, linear O(n) time.
def manacher_palindrome(s):
    s = DELIMITER + DELIMITER.join(s) + DELIMITER
    n = len(s)
    p = [0] * n
    j = 0
    m = (-1, 0)  # (max length so far, position)
    for i in xrange(n):
        p[i] = min(p[2*j-i], j + p[j] - i) if i < j + p[j] else 1
        while 0 <= i - p[i] and i + p[i] < n and s[i-p[i]] == s[i+p[i]]:
            p[i] = p[i] + 1
        if j + p[j] < i + p[i]:
            j = i
        m = max(m, (p[i] - 1, i))
    return m

def test():
    ss = ["Mississippi", "level", "cacab", "cocoa", "aaa", "abc"]
    for s in ss:
        (n, i) = manacher_palindrome(s)
        assert(n == brute_force_palindrome(s))
        print s[(i-n+1)/2 : (i+ n-1)/2+1]

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
function algoP.MaxSum935
    set output_file "main.py"

    set template_content '
import random

# invariant
# .... max so far .... max end here
def maxsum(xs):
    s = 0 # max so far
    m = 0 # max end here
    for x in xs:
        m = max(m + x, 0)
        s = max(m, s)
    return s

# divide and conquer solution
def dc_maxsum(xs):
    n = len(xs)
    if n == 0:
        return 0
    if n == 1:
        return max(0, xs[0])
    m = n //2
    a = max_from(reversed(xs[:m]))
    b = max_from(xs[m:])
    return max(dc_maxsum(xs[:m]), dc_maxsum(xs[m:]), a + b)

def max_from(xs):
    s = 0
    m = 0
    for x in xs:
        s = s + x
        m = max(m, s)
    return m

def naive_maxsum(xs):
    n = len(xs)
    m = 0
    r = (0, 0)
    for i in range(n):
        s = 0
        for j in range(i, n):
            s = s + xs[j]
            if m < s:
                m = s
                r = (i, j)
    return (m, r)

def test_maxsum(f):
    for _ in range(100):
        xs = random.sample(range(-100, 100), 100)
        (m, _) = naive_maxsum(xs)
        assert m == f(xs)

def test():
    test_maxsum(maxsum)
    test_maxsum(dc_maxsum)

def example():
    xs = [3, -13, 19, -12, 1, 9, 18, -16, 15, -15]
    print naive_maxsum(xs)

if __name__ == "__main__":
    example()
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaxSum936
    set output_file "main.py"

    set template_content '
from random import *

# 1d sub-routine
def maxsum1(xs):
    s = 0 # max so far
    m = 0 # max end here
    for x in xs:
        m = max(m + x, 0)
        s = max(m, s)
    return s

# 2D solution
def maxsum2(m):
    n, k = len(m), len(m[0]) # number of row, col
    maxs = 0 # max so far
    for i in range(n):
        xs = [0] * k
        for j in range(i, n):
            xs = [x + y for (x, y) in zip(xs, m[j])]
            maxs = max(maxs, maxsum1(xs))
    return maxs

# naive 2D version
def naivemax(m):
    r, c = len(m), len(m[0])
    maxs = 0
    for left in range(c):
        for right in range(left, c):
            for up in range(r):
                for down in range(up, r):
                    maxs = max(maxs, sum([sum(row[left:right+1]) for row in m[up:down+1]]))
    return maxs

def test():
    M = 20
    for _ in range(10):
        row, col = randint(2, M), randint(2, M)
        m = [[randint(-M, M) for _ in range(col)] for _ in range(row)]
        assert maxsum2(m) == naivemax(m)

def example():
    m = [[1, 2, -1, -4, -20],
         [-8, -3, 4, 2, 1],
         [3, 8, 10, 1, 3],
         [-4, -1, 1, 7, -6]]
    print m
    print maxsum2(m) # should be sum2([[-3, 4, 2], [8, 10, 1], [-1, 1, 7]]) = 29
    print "naive"
    print naivemax(m)

if __name__ == "__main__":
    example()
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.NthElement937
    set output_file "main.py"

    set template_content '
import random

def partition_with(xs, l, u, x):
    left = l
    for right in range(l, u+1):
        if xs[right] <= x:
            (xs[left], xs[right]) = (xs[right], xs[left])
            left = left + 1
    return left

# Randomized partition with
def partition(xs, l, u):
    return partition_with(xs, l, u, xs[random.randint(l, u)])

# method 1, randomized partition
def partition_at(xs, k):
    (l, u)=(0, len(xs) - 1)
    while True:
        m = partition(xs, l, u)
        if m < k:
            l = m
        elif m > k:
            u = m - 1
        else:
            return

# method 2, min-max
def partition_at2(xs, k):
    (l, u) = (0, len(xs) - 1)
    while True:
        a = max_at(xs, l, k)
        b = min_at(xs, k, u)
        if xs[a] > xs[b]:
            (xs[a], xs[b]) = (xs[b], xs[a])
            (l, u) = (partition_with(xs, l, k-1, xs[a]), partition_with(xs, k, u, xs[b]) - 1)
        else:
            return

def max_at(xs, l, u):
    i = l
    for j in xrange(l, u+1):
        if xs[j] > xs[i]:
            i = j
    return i

def min_at(xs, l, u):
    i = l
    for j in xrange(l, u+1):
        if xs[j] < xs[i]:
            i = j
    return i

def verify(xs, k):
    assert(sorted(xs[:k]) == sorted(xs)[:k])

def gen_xs(n):
    xs = random.sample(range(n), random.randint(2, n))
    k = random.randint(1, len(xs)-1)
    return (xs, k)

def test():
    n = 10000
    for i in range(100):
        (xs, k)=gen_xs(n)
        partition_at(xs, k)
        verify(xs, k)
        (xs, k)=gen_xs(n)
        partition_at2(xs, k)
        verify(xs, k)

if __name__ == "__main__":
    test()
    
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Greedy938
    set output_file "main.py"

    set template_content '
def change(x, coins):
    cs = {}
    while x != 0:
        m = max([c for c in coins if c <= x])
        cs[m] = 1 + cs.setdefault(m, 0)
        x = x - m
    return cs

USA = [1, 5, 25, 50, 100]

def test():
    print(change(142, USA))

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DP939
    set output_file "main.py"

    set template_content '
tab = [[] for _ in range(1000)]

def change(x, cs):
    if x > 0 and tab[x] == []:
        for s in [[c] + change(x - c, cs) for c in cs if c <= x]:
            if tab[x] == [] or len(s) < len(tab[x]):
                tab[x] = s
    return tab[x]

# method 2, bottom-up DP solution

def changemk(x, cs):
    s = [[] for _ in range(x+1)]
    for i in range(1, x+1):
        for c in cs:
            if c <= i and (s[i] == [] or 1 + len(s[i-c]) < len(s[i])):
                s[i] = [c] + s[i-c]
    return s[x]

#method 3, bottom-up DP solution, with fewer space based on [1]

def chgmk(x, cs):
    cnt = [0] + [x+1] * x
    s = [0]
    for i in range(1, x+1):
        coin = 0
        for c in cs:
            if c <= i and 1 + cnt[i-c] < cnt[i]:
                cnt[i] = 1 + cnt[i-c]
                coin = c
        s.append(coin)
    r = []
    while x > 0:
        r.append(s[x])
        x = x - s[x]
    return r

# Examples

USA = [1, 5, 25, 50, 100]

def test():
    print(change(142, USA))
    for i in range(1000):
        tab[i] = []
    print(change(6, [1, 2, 4]))

def test1():
    print(changemk(142, USA))
    print(changemk(6, [1, 2, 4]))

def test2():
    print(chgmk(142, USA))
    print(chgmk(6, [1, 2, 4]))

if __name__ == "__main__":
    test()
    test1()
    test2()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
function algoP.DP940
    set output_file "main.py"

    set template_content '
TAB = [1, 1]

# top-bottom recursive solution
def fibo(n):
    global TAB
    if n > len(TAB):
        TAB = TAB + [1] * n # expand the table
    if n > 2 and TAB[n] == 1:
        TAB[n] = fibo(n-1) + fibo(n-2)
    return TAB[n]

# bottom-up solution
def fibonacci(n):
    tab = [1]*n
    for i in range(2, n):
        tab[i] = tab[i-1] + tab[i-2]
    return tab[n-1]

if __name__ == "__main__":
    print fibo(100)
    print fibonacci(100)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DP941
    set output_file "main.py"

    set template_content '
def lev(s, t):
    m, n = len(s)+1, len(t)+1
    d = [[0]*n for _ in range(m)] #d[i][j]: Levenshtein distance between s[:i] and t[:j]
    for i in range(m): #source prefix can be transfered to empty by dropping all chars
        d[i][0] = i
    for j in range(n): #target prefix can be reached from empty by inserting all chars
        d[0][j] = j
    for j in range(1, n):
        for i in range(1, m):
            c = 0 if s[i-1] == t[j-1] else 1
            d[i][j] = min([d[i-1][j] + 1, #deletion
                           d[i][j-1] + 1, #insertion
                           d[i-1][j-1]+c]) #substitution
    #print "d=", d
    return d[m-1][n-1]

if __name__ == "__main__":
    print "lev(kitten, sitting)=", lev("kitten", "sitting")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BinarySearchSaddl942
    set output_file "main.py"

    set template_content '

import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

# instruction: change i from 0 to 2 to select plotting different function
i = 2

def brute_solve(f, z):
    return [(x, y) for x in range(z+1) for y in reversed(range (z+1)) if f(x, y) == z]

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

fs = [lambda x, y: x + y, lambda x, y: pow(2, x) + y, lambda x, y: x*x + y*y]
labels = ['x + y = 100', '2^x + y = 100', 'x^2 + y^2 = 100']

ps = brute_solve(fs[i], 100)
xs = [ x for x, _ in ps]
ys = [ y for _, y in ps]
zs = [ 100 for _ in ps]
ax.plot(xs, ys, zs)
ax.scatter(xs, ys, zs, label=labels[i])

ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
ax.legend()

plt.show()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
function algoP.BinarySearchSaddle943
    set output_file "main.py"

    set template_content '
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

# instruction: change i from 0 to 2 to select plotting different function
i = 2

def wireframe(ax, f, m):
    xs = range(m)
    ys = range(m)
    xs, ys = np.meshgrid(xs, ys)
    zs = f(xs, ys)
    ax.plot_wireframe(xs, ys, zs)

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

fs = [lambda x, y: x + y, lambda x, y: pow(2, x) + y, lambda x, y: x*x + y*y]

wireframe(ax, fs[i], 50)

ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
#ax.legend()

plt.show()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BinarySearchSaddle944
    set output_file "main.py"

    set template_content '
def brute_solve(f, z):
    return [(x, y) for x in range(z+1) for y in reversed(range (z+1)) if f(x, y) == z]

# Saddleback basic version based on [2]
# [2] Edsger W. Dijkstra. ``The saddleback search''. EWD-934. 1985. http://www.cs.utexas.edu/users/EWD/index09xx.html.

def saddleback(f, z):
    (p, q) = (0, z)
    res = []
    while p <= z and q >= 0:
        z1 = f(p, q)
        if z1 < z:
            p = p + 1
        elif z1 > z:
            q = q - 1
        else:
            res.append((p, q))
            (p, q) = (p + 1, q - 1)
    return res

def bsearch(f, z, l, u):
    while u > l:
        m = (l + u) // 2
        if f(m) <= z:
            if z < f(m+1):
                return m
            l = m + 1
        else:
            u = m
    return l

def saddleback1(f, z):
    m = bsearch(lambda y: f(0, y), z, 0, z)
    n = bsearch(lambda x: f(x, 0), z, 0, z)
    res = []
    (p, q) = (0, m)
    while p <= n and q >= 0:
        z1 = f(p, q)
        if z1 < z:
            p = p + 1
        elif z1 > z:
            q = q - 1
        else:
            res.append((p, q))
            (p, q) = (p + 1, q - 1)
    return res

def solve(f, z):
    m = bsearch(lambda y: f(0, y), z, 0, z)
    n = bsearch(lambda x: f(x, 0), z, 0, z)
    res = []
    def search(a, b, c, d):
        def csearch(p, q):
            z1 = f(p, q)
            if z < z1:
                search(p, q-1, c, d)
            elif z == z1:
                search(a, b, p-1, q+1)
                res.append((p, q))
                search(p+1, q-1, c, d)
            else:
                search(a, b, p, q+1)
                search(p+1, q-1, c, d)
        def rsearch(p, q):
            z1 = f(p, q)
            if z < z1:
                search(a, b, p-1, q)
            elif z == z1:
                search(a, b, p-1, q+1)
                res.append((p, q))
                search(p+1, q-1, c, d)
            else:
                search(a, b, p-1, q+1)
                search(p+1, q, c, d)
        if a <=c and d <=b:
            if c - a < b - d:
                q = (b + d) // 2
                p = bsearch(lambda x: f(x, q), z, a, c)
                csearch(p, q)
            else:
                p = (a + c) // 2
                q = bsearch(lambda y: f(p, y), z, d, b)
                rsearch(p, q)
    search(0, m, n, 0)
    return res

def test_search(search1, search2):
    fs = [lambda x, y: x + y, lambda x, y: pow(2, x) + pow(3, y), lambda x, y: x*x + y*y]
    for z in range(100+1):
        for f in fs:
            assert search1(f, z) == search2(f, z)

def test():
    test_search(brute_solve, saddleback)
    test_search(saddleback, saddleback1)
    test_search(saddleback1, solve)

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BinarySearchMedian945
    set output_file "main.py"

    set template_content '

from random import sample, randint


def median(a, b):
    if not a:
        return b[len(b) // 2]
    if not b:
        return a[len(a) // 2]
    idx = medof(a, b)
    return median(b, a) if idx is None else a[idx]


def medof(a, b):
    l = 0
    u = len(a)
    while l < u:
        i = (l + u) // 2
        j = (len(a) + len(b)) // 2 - i
        if j < 1 or j >= len(b):
            if (j == 0 and a[i] <= b[0]) or (j == len(b) and b[j - 1] <= a[i]):
                return i  # found
            if j >= len(b):
                l = i + 1  # too small
            else:
                u = i  # too big
        else:
            if b[j - 1] <= a[i] and a[i] <= b[j]:
                return i  # found
            if a[i] < b[j - 1]:
                l = i + 1  # too small
            else:
                u = i  # too big
    return None


# method 2: use k-th element in a and b.
#
# Suppose m = len(a) >= n = len(b), otherwise, exchange a, b.
# If B == [], return the k-th element of A, if k = 0, return min(a[0], B[0])
# Otherwise, guess j = min(k/2, n), and i = k - j, then compare a[i] and b[j]
# If a[i] < b[j], drop all elements before a[i] and after b[j], then
# recursively find the (k - i)-th element in the rest.
# Othewise, drop all elements before b[j] and after a[i], then recursively
# find the (k-j)-th element in the rest.


def median1(xs, ys):
    n, m = len(xs), len(ys)
    return kth(xs, 0, n, ys, 0, m, (m + n) // 2 + 1)


# find the k-th element from xs[x0, x1) and ys[y0, y1), k starts from 1
def kth(xs, x0, x1, ys, y0, y1, k):
    if x1 - x0 < y1 - y0:
        return kth(ys, y0, y1, xs, x0, x1, k)
    if x1 <= x0:
        return ys[y0 + k - 1]
    if y1 <= y0:
        return xs[x0 + k - 1]
    if k == 1:
        return min(xs[x0], ys[y0])
    j = min(k // 2, y1 - y0)
    i = k - j
    i, j = x0 + i, y0 + j
    if xs[i - 1] < ys[j - 1]:
        return kth(xs, i, x1, ys, y0, j, k - i + x0)
    else:
        return kth(xs, x0, i, ys, j, y1, k - j + y0)


def test(f, n=100):
    for _ in range(n):
        xs = [randint(0, n // 2) for _ in range(randint(2, n))]
        m = randint(0, len(xs))
        a, b = sorted(xs[:m]), sorted(xs[m:])
        c = sorted(xs)
        med1 = f(a, b)
        med2 = c[len(c) // 2]
        assert med1 == med2, f"err: median({a}, {b}): {med1}, median({c}): {med2}"
    print(f"{n} tests OK")


if __name__ == "__main__":
    test(median)
    test(median1)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
function algoP.BinarySearchBsearch946
    set output_file "main.py"

    set template_content '
from random import *

def bsearch(xs, x):
    l = 0
    u = len(xs)
    while(l < u):
        m = (l+u)/2 #error if integer are in limited words, l + (u-l)/2
        if xs[m] == x:
            return m
        elif xs[m] < x:
            l = m + 1
        else:
            u = m
    return -1

def test():
    assert(bsearch([], 1) == -1)
    assert(bsearch([2], 1) == -1)
    assert(bsearch([1], 1) == 0)
    #assert(bsearch([1,1,1], 1) == 0)
    assert(bsearch([1,2,3], -1) == -1)
    assert(bsearch([1,2,3], 5) == -1)
    assert(bsearch([3,4,7,9,11], 4) == 1)
    assert(bsearch([3,4,7,9,11], 9) == 3)
    assert(bsearch([3,4,7,9,11], 3) == 0)
    assert(bsearch([3,4,7,9,11], 11) == 4)

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.bfsKlotski947
    set output_file "main.py"

    set template_content '
from collections import deque
from copy import deepcopy

START = [frozenset({0, 4}), frozenset({3, 7}), frozenset({8, 12}),
         frozenset({9, 10}), frozenset({11, 15}), frozenset({16}),
         frozenset({13}), frozenset({14}), frozenset({19}),
         frozenset({1, 2, 5, 6})]

END = frozenset({13, 14, 17, 18})

def posof(c):
    return (c // 4, c % 4)

def matrix(layout):
    m = [[0]*4 for _ in range(5)]
    for i, p in enumerate(layout):
        for c in p:
            y, x = posof(c)
            m[y][x] = i + 1
    return m

class Node:
    def __init__(self, l, p = None):
        self.layout = l
        self.parent = p

def solve(start, end):
    visit = {frozenset(start)}
    queue = deque([Node(start)])
    while queue:
        cur = queue.popleft()
        if cur.layout[-1] == end:
            return cur
        else:
            lys = expand(cur.layout, visit)
            for ly in lys:
                queue.append(Node(ly, cur))
                visit.add(frozenset(ly))
    return None # no solution

def expand(layout, visit):
    def bound(piece, d):
        for c in piece:
            if c + d < 0 or c + d >= 20:
                return False
            if d == 1 and c % 4 == 3:
                return False
            if d == -1 and c % 4 == 0:
                return False
        return True

    m = matrix(layout)
    def valid(piece, d, i):
        for c in piece:
            y, x = posof(c + d)
            if m[y][x] not in [0, i + 1]:
                return False
        return True

    def unique(ly):
        mirror = lambda c : 4 * (c // 4) + 3 - (c % 4)
        n = frozenset(ly)
        m = frozenset(frozenset(mirror(c) for c in p) for p in ly)
        return (n not in visit) and (m not in visit)

    s = []
    for i, p in enumerate(layout):
        for d in [-1, 1, -4, 4]:
            if bound(p, d) and valid(p, d, i):
                ly = move(layout, i, d)
                if unique(ly):
                    s.append(ly)
    return s

def move(layout, i, d):
    ly = [deepcopy(p) for p in layout]
    ly[i] = frozenset(c + d for c in layout[i])
    return ly

def print_layout(ly):
    for r in matrix(ly):
        print(["%X" % x for x in r])
    print("\n")

def output(node):
    seq = []
    while node is not None:
        seq = [node.layout] + seq
        node = node.parent
    for layout in seq:
        print_layout(layout)
    print("total", len(seq) - 1, "steps")

if __name__ == "__main__":
    output(solve(START, END))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.bfsLeap948
    set output_file "main.py"

    set template_content '
from collections import deque

def solve(i, j, start, end):
    visit = set([normalize(start)])
    queue = deque([[((i, j), start)]])
    while queue:
        c = queue.popleft()
        if snd(c[0]) == end:
            return [snd(_) for _ in c][::-1] # stop after finding the 1st solution
        else:
            for m in moves(c[0]):
                layout = normalize(snd(m))
                if layout not in visit:
                    queue.append([m] + c)
                    visit.add(layout)
    return None

DELTA = [(0, 1), (1, 0), (0, -1), (-1, 0)]
def moves(s):
    ((i, j), m) = s
    return [((i+di, j+dj), swap(m, i, j, di, dj))
            for (di, dj) in (DELTA + [(dx*2, dy*2) for (dx, dy) in DELTA])
            if 0 <= i + di and i + di < 5 and 0 <= j + dj and j + dj < 5 and
               m[i+di][j+dj] == - (di+dj) / abs(di + dj)]

def swap(m, i, j, di, dj):
    a = [_[:] for _ in m]
    (a[i+di][j+dj], a[i][j]) = (a[i][j], a[i+di][j+dj])
    return a

def snd(p):
    (_, b) = p
    return b

def normalize(m):
    return tuple([tuple(r) for r in m])

CMAP = {0:"*", 2:" ", 1:"B", -1:"W"}
def test():
    start = [[1,  1,  1,  2,  2],
             [1,  1,  1,  2,  2],
             [1,  1,  0, -1, -1],
             [2,  2, -1, -1, -1],
             [2,  2, -1, -1, -1]]
    end = [[-x if abs(x) < 2 else x for x in r] for r in start]
    s = solve(2, 2, start, end)
    for m in s:
        print "\n".join([" ".join([CMAP[x] for x in r]) for r in m]), "\n"
    print "total", len(s) - 1, "steps" # best solution: 46 steps


if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
function algoP.bfsXdriver949
    set output_file "main.py"

    set template_content '
def solve():
    s = []
    queue = [[(0xf, 0)]]
    while queue != []:
        cur = queue.pop(0)
        if cur[0] == (0, 0xf):
            s.append(reverse(cur))
        else:
            for m in moves(cur):
                queue.append([m]+cur)
    return s

def moves(s):
    (a, b) = s[0]
    return valid(s, trans(a, b) if b < 8 else swaps(trans(b, a)))

def valid(s, mv):
    return [(a, b) for (a, b) in mv if a not in [3, 6] and b not in [3, 6] and (a, b) not in s]

def trans(a, b):
    masks = [ 8 | (1<<i) for i in range(4)]
    return [(a ^ mask, b | mask) for mask in masks if a & mask == mask]

def swaps(s):
    return [(b, a) for (a, b) in s]

def reverse(x):
    return x[::-1]

def pretty_print(s):
    for ms in s:
        for (a, b) in ms:
            print wgc(a), "====", wgc(b)
        print "total", len(ms) - 1, "steps"
    print "total", len(s), "solutions"

def wgc(x):
    return [n for (i, n) in [(1, "wolf"), (2, "goat"), (3, "cabbage"), (4, "farmer")] 
              if (x & i) != 0]

pretty_print(solve())
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
function algoP.SubsetSum950
    set output_file "main.py"

    set template_content '
import random # for verification purpose only

# A brute-force solution only answers the existence of subset for a given sum.
def brute_force(xs, s):
    if xs == []:
        return s == 0
    if len(xs) == 1:
        return xs[0] == s
    else:
        return brute_force(xs[1:], s) or xs[0]==s or brute_force(xs[1:], s-xs[0])

# Method 1, DP solution based on [1].
def solve(xs, s):
    low = sum([x for x in xs if x < 0])
    up  = sum([x for x in xs if x > 0])
    def col(j):
        return j - low
    n = len(xs)
    tab = [[False]*(up - low + 1) for _ in range(n + 1)]
    tab[0][col(0)] = True
    for i, x in enumerate(xs, start = 1):
        tab[i][col(x)] = True
        for j in range(low, up + 1):
            tab[i][col(j)] = tab[i][col(j)] or tab[i-1][col(j)]
            j1 = j - x
            if low <= j1 and j1 <= up:
                tab[i][col(j)] = tab[i][col(j)] or tab[i-1][col(j1)]
    def fetch(s, i):
        r = []
        if xs[i - 1] == s:
            r.append([xs[i - 1]])
        if i > 0:
            if tab[i - 1][col(s)]:
                r = r + fetch(s, i - 1)
            s = s - xs[i - 1]
            if low <= s and s <= up and tab[i-1][col(s)]:
                r = r + [[xs[i - 1]] + ys for ys in fetch(s, i-1)]
        return r
    return fetch(s, n)

# Method 2: Use a vector instead of a 2D table.
def subsetsum(xs, s):
    low = sum([x for x in xs if x < 0])
    up  = sum([x for x in xs if x > 0])
    tab = [set([]) for _ in range(low, up+1)]
    for x in xs:
        tab1 = tab[:]
        for j in range(low, up+1):
            if x == j:
                tab1[j] = tab1[j] | {frozenset([x])}
            j1 = j - x
            if low <= j1 and j1 <= up and tab[j1]:
                tab1[j] = tab1[j] | frozenset(ys | frozenset([x]) for ys in tab[j1])
        tab = tab1
    return list(tab[s])

# Verification
def test():
    num = 100
    for i in range(num):
        n = random.randint(1, 10)
        xs = random.sample(range(-100, 100), n)
        l = sum([x for x in xs if x<0])
        u = sum([x for x in xs if x>0])
        s = random.randint(l, u)
        exist = brute_force(xs, s)
        s1 = solve(xs, s)
        s2 = subsetsum(xs, s)
        #print(s1, s2, s, xs)
        if exist:
            assert(s1 and all(sum(st) == s for st in (s1 + s2)) and len(s1) == len(s2))
        else:
            assert(s1 == [] and s2 == [])
    print(num, "test passed")

if __name__ == "__main__":
    test()
    #[-87, -38, -14] -101 ==> [] 0
    #print(solve([-3, -2, -1], -4))
    #print(subsetsum([-3, -2, -1], -4))

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.StackMin951
    set output_file "main.py"

    set template_content '
def push1(s, x):
    if s:
        (_, m) = s[-1]
        s.append((x, min(m, x)))
    else:
        s.append((x, x))
    return s

def pop1(s):
    (x, _) = s.pop()
    return x, s

def min1(s):
    (_, m) = s[-1]
    return m

def top1(s):
    (x, _) = s[-1]
    return x

def is_empty1(s):
    return not s

# method 2, linked-list based, each node record a pointer to the min
class Node:
    def __init__(self, x, next=None):
        self.key = x
        self.next = next
        self.min = None

def push2(s, x):
    h = Node(x, s)
    h.min = h if s is None or x < s.min.key else s.min
    return h

def pop2(s):
    h = s.next
    s.next = None
    return s.key, h

def min2(s):
    return s.min.key

def top2(s):
    return s.key

def is_empty2(s):
    return not s

# method 3, double stacks. One stack for elements, another stack for the minimum elements.
def empty():
    return ([], [])

def push3(s, x):
    (s1, s2) = s
    s1.append(x)
    if not s2 or x <= s2[-1]:
        s2.append(x)
    return (s1, s2)

def pop3(s):
    (s1, s2) = s
    x = s1.pop()
    if s2 and s2[-1] == x:
        s2.pop()
    return x, (s1, s2)

def min3(s):
    (_, s2) = s
    return s2[-1]

def top3(s):
    (s1, _) = s
    return s1[-1]

def is_empty3(s):
    return s == ([], [])

def test():
    s1 = []
    s2 = None
    s3 = empty()
    for _ in xrange(100):
        if random.randint(0, 1) == 0:
            x = random.randint(1, 100)
            s1 = push1(s1, x)
            s2 = push2(s2, x)
            s3 = push3(s3, x)
            assert(top1(s1) == top2(s2) and top1(s1) == top3(s3))
            assert(min1(s1) == min2(s2) and min1(s1) == min3(s3))
        else:
            if is_empty1(s1):
                assert(is_empty2(s2) and is_empty3(s3))
            else:
                assert(min1(s1) == min2(s2) and min1(s1) == min3(s3))
                x1, s1 = pop1(s1)
                x2, s2 = pop2(s2)
                x3, s3 = pop3(s3)
                assert(x1 == x2 and x1 == x3)
    print "100 cases passed"

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.sorts952
    set output_file "main.py"

    set template_content '
import string

class Item:
    def __init__(self):
        self.key = ""
        self.pre = []

def create_item(s):
    (c, pres) = s.split(':')
    x = Item()
    x.key = c
    x.pre = pres.split()
    return x

def schedule(ss):
    items = []
    for s in ss:
        items.append(create_item(s))
    res = []
    while items != []:
        try:
            c = items.pop(0)
            insert(res, c, items)
        except LookupError:
            (res, items) = ([], [])
    return map(lambda x: x.key, res)

# returns the position where c is inserted.
def insert(res, c, cs):
    from_pos = -1
    for x in c.pre:
        pos = lookup(res, x)
        if pos is None:
            (c1, cs) = extract(cs, x)
            pos = insert(res, c1, cs)
        from_pos = max(from_pos, pos)
    return insert_from(res, from_pos, c)
        
def lookup(lst, x):
    for i in range(len(lst)):
        if lst[i].key == x:
            return i
    return None

def extract(lst, x):
    pos = lookup(lst, x)
    if pos is None:
        raise LookupError
    else:
        i = lst.pop(pos)
        return (i, lst)

def insert_from(lst, pos, x):
    i = pos + 1
    while i < len(lst):
        if less_than(x, lst[i]):
            break
        i = i+1
    lst.insert(i, x)
    return i

def less_than(x, y):
    (s1, n1) = parse_class(x)
    (s2, n2) = parse_class(y)
    return (n1 < n2) or (n1 == n2 and s1 < s2)

def parse_class(s):
    name = ""
    num  = 0
    for c in s.key:
        if c in string.digits:
            num = num * 10 + int(c)
        else:
            name = name + c
    return (name, num)

def test():
    cs1 = ["CSE121: CSE110", "CSE110:", "MATH122:"]
    r1 = ["CSE110","CSE121","MATH122"]
    cs2 = ["ENGL111: ENGL110", "ENGL110: ENGL111"]
    r2 = []
    cs3 = ["ENGL111: ENGL110"]
    r3 = []
    cs4 = ["CSE258: CSE244 CSE243 INTR100", 
           "CSE221: CSE254 INTR100",
           "CSE254: CSE111 MATH210 INTR100",
           "CSE244: CSE243 MATH210 INTR100",
           "MATH210: INTR100",
           "CSE101: INTR100",
           "CSE111: INTR100",
           "ECE201: CSE111 INTR100",
           "ECE111: INTR100",
           "CSE243: CSE254",
           "INTR100:"]
    r4 = ["INTR100","CSE101","CSE111","ECE111",
          "ECE201","MATH210","CSE254","CSE221","CSE243",
          "CSE244","CSE258"]
    __assert(schedule(cs1), r1)
    __assert(schedule(cs2), r2)
    __assert(schedule(cs3), r3)
    __assert(schedule(cs4), r4)

def __assert(x, y):
    if x == y:
        print "OK"
    else:
        print "Fail:", x, "!=", y

if __name__ == "__main__":
    test()

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.divideConquer953
    set output_file "main.py"

    set template_content '
import random

def median(xs, ys):
    n, m = len(xs), len(ys)
    med = kth(xs, 0, n, ys, 0, m, (m + n) / 2 + 1)
    if (n + m) % 2 == 0:
        return (med + kth(xs, 0, n, ys, 0, m, (m + n) / 2)) / 2.0
    return med

# find the k-th element from xs[x0, x1) and ys[y0, y1), k starts from 1
def kth(xs, x0, x1, ys, y0, y1, k):
    if x1 - x0 < y1 - y0:
        return kth(ys, y0, y1, xs, x0, x1, k)
    if x1 <= x0:
        return ys[y0 + k - 1]
    if y1 <= y0:
        return xs[x0 + k - 1]
    if k == 1:
        return min(xs[x0], ys[y0])
    j = min(k/2, y1 - y0)
    i = k - j
    i, j = x0 + i, y0 + j
    if xs[i-1] < ys[j-1]:
        return kth(xs, i, x1, ys, y0, j, k - i + x0)
    else:
        return kth(xs, x0, i, ys, j, y1, k - j + y0)

N = 100

def test():
    for _ in range(N):
        xs = range(random.randint(1, N))
        m = (len(xs) - 1) / 2.0
        random.shuffle(xs)
        n = random.randint(0, len(xs))
        (xs, ys) = (sorted(xs[:n]), sorted(xs[n:]))
        m1 = median(xs, ys)
        if abs(m - m1) > 0.005:
            print "FAIL: median expected:", m, "actual:", m1
            print xs, "len=", len(xs)
            print ys, "len=", len(ys)
            exit()

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LCS954
    set output_file "main.py"

    set template_content '
from enum import Flag, auto

import random

def lcs(xs, ys):
    m, n = len(xs), len(ys)
    c = [[0]*(n + 1) for _ in range(m + 1)]
    for i in range(1, m+1):
        for j in range(1, n+1):
            if xs[i-1] == ys[j-1]:
                c[i][j] = c[i-1][j-1] + 1
            else:
                c[i][j] = max(c[i-1][j], c[i][j-1])
    return rebuild(c, xs, ys)

def rebuild(c, xs, ys):
    r = []
    m, n = len(xs), len(ys)
    while m > 0 and n > 0:
        if xs[m - 1] == ys[n - 1]:
            r.append(xs[m - 1])
            m = m - 1
            n = n - 1
        elif c[m - 1][n] > c[m][n - 1]:
            m = m - 1
        else:
            n = n - 1
    r.reverse()
    return r

# Record both length and direction.
class Dir(Flag):
    N = auto()
    W = auto()
    NW = auto()

def lcs_dir(xs, ys):
    fst = lambda p : p[0]
    m, n = len(xs), len(ys)
    c = [[(0, None)]*(n + 1) for _ in range(m + 1)]
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if xs[i-1] == ys[j-1]:
                c[i][j] = (c[i-1][j-1][0] + 1, Dir.NW)
            else:
                c[i][j] = (max(c[i-1][j], c[i][j-1], key=fst)[0], \
                           Dir.N if fst(c[i-1][j]) > fst(c[i][j-1]) else Dir.W)
    return rebuild_dir(c, xs, ys)

def rebuild_dir(c, xs, ys):
    snd = lambda p : p[1]
    r = []
    m, n = len(xs), len(ys)
    while m > 0 and n > 0:
        d = snd(c[m][n])
        if d == Dir.NW:
            r.append(xs[m - 1]) # or ys[n - 1]
            m = m - 1
            n = n - 1
        elif d == Dir.N:
            m = m - 1
        elif d == Dir.W:
            n = n - 1
        else:
            assert False, f"should not be here {d}"
    r.reverse()
    return r

# the naive one is very slow, dont test it with big lists.
def naive_lcs(xs, ys):
    if xs == [] or ys == []:
        return []
    if xs[0] == ys[0]:
        return [xs[0]] + naive_lcs(xs[1:], ys[1:])
    else:
        a = naive_lcs(xs, ys[1:])
        b = naive_lcs(xs[1:], ys)
        if len(a) < len(b):
            return b
        else:
            return a

# Caution! dont use big num for the naive method.
def test(lcs_func, num = 10):
    for i in range(100):
        m = random.randint(1, num)
        n = random.randint(1, num)
        xs = random.sample(range(num), m)
        ys = random.sample(range(num), n)
        #Note that two lcs algorithms may return different results with the same length.
        assert len(naive_lcs(xs, ys)) == len(lcs_func(xs, ys)),  "fail"
    print("test", lcs_func, "with 100 cases OK.")

if __name__ == "__main__":
    test(lcs)
    test(lcs_dir)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DFS955
    set output_file "main.py"

    set template_content '
import sys

def valid(a, b, n):
    if n == 1:
        return a == 1 and b != 1
    else:
        if b % n == 0 and not valid(a, b/n, n-1):
            return False
        elif a % n == 0 and valid(a/n, b, n-1):
            return True
        else:
            return valid(a, b, n-1)
            
# Solution 2: (This can pass ZOJ)
#   If there exists a decomposition for both a and b ==> a
#   else if there exists a decomposition for b ==> b
#   otherwise ==> a

def valid2(a, b, n):
    return Judge().result(a, b, n)

class Judge:
    def __init__(self):
        self.both_OK = False
        self.b_OK = False

    def exist(self, a, b, n):
        if self.both_OK:
            return True

        if a == 1 and b==1:
            (self.both_OK, self.b_OK) = (True, True)
            return True

        if b == 1:
            self.b_OK = True

        for x in xrange(n, 1, -1):
            if b % x == 0 and self.exist(a, b/x, x-1):
                return True
            if a % x == 0 and self.exist(a/x, b, x-1):
                return True

        return self.both_OK

    def result(self, a, b, n):
        self.exist(a, b, n)
        return not ( self.b_OK and not self.both_OK)

def main():
    for line in sys.stdin:
        [s1, s2] = line.split()
        (a, b) = (int(s1), int(s2))
        if a < b:
            (a, b) = (b, a)
        if valid2(a, b, 100):
            print a
        else:
            print b

if __name__ == "__main__":
    main()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BFSConvoy956
    set output_file "main.py"

    set template_content '
def solve():
    s0 = range(8)
    q = deque([(s0, None)])
    visit = {tuple(s0)}
    while q:
        (n, _) = s = q.pop()
        if n == [0, 7, 6, 5, 4, 3, 2, 1]:
            return backtrack(s)
        else:
            q.extendleft(slide(s, visit))
    return None # no solution

def backtrack(s):
    r = []
    (n, p) = s
    while p is not None:
        r.append(n)
        (n, p) = p
    return [n] + r[::-1]

# Slide possible tiles to the free cell
#   input the current state n, and the visited state history.
#   Try all movements and filter the duplicated ones by looking up the history set.
#   output a list of candates in (state, parent) form.

def slide(s, visit):
    (n, _) = s
    cs = []
    for i in [left(n), right(n), up(n), down(n)]:
        if i != [] and (tuple(i) not in visit):
            visit.add(tuple(i))
            cs.append((i, s))
    return cs

# xxxa0xxx -> xxx0axxx
def right(n):
    m = n[:]
    i = m.index(0)
    (m[i], m[i-1]) = (m[i-1], m[i])
    return m

# xxx0axxx -> xxxa0xxx
def left(n):
    m = n[:]
    i = m.index(0)
    (m[i], m[i-7]) = (m[i-7], m[i])
    return m

# axxx0xxx -> 0xxxaxxx
def up(n):
    return ([0] + n[1:4] + [n[0]] + n[5:]) if n[4] == 0 else []

# 0xxxaxxx -> axxx0xxx
def down(n):
    return ([n[4]] + n[1:4] + [0] + n[5:]) if n[0] == 0 else []

if __name__ == "__main__":
    print(solve())
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BFSLinksibling957
    set output_file "main.py"

    set template_content '
class Node:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
        self.next = None

def node(k, l = None, r = None):
    tr = Node(k)
    tr.left = l
    tr.right = r
    return tr

def output(tr):
    if tr:
        print tr.val, "->", (tr.next.val if tr.next else "NIL")
        output(tr.left)
        output(tr.right)

class Solution:
    # @param root, a tree node
    # @return nothing
    def connect(self, root):
        link(root)

# BFS like traverse
def link(tr):
    if tr is None or tr.left is None:
        return
    (root, tr.next) = (tr, tr.left)
    (head, tail) = (tr, tr)
    while head.next:
        tr, head = deq(head)
        tail = enq(tail, tr.left)
        tail = enq(tail, tr.right)
    # break at 1, 2, 4, ...
    (i, m) = (0, 1)
    prev = tr = root
    while tr:
        (prev, tr) = (tr, tr.next)
        i = i + 1
        if i == m:
            prev.next = None
            (i, m) = (0, 2 * m)

def deq(head):
    return head, head.next

def enq(tail, x):
    if x:
        tail.next = x
        return x
    else:
        return tail

def test():
    #tr = None
    #tr = node(1)
    #tr = node(1, node(2), node(3))
    tr = node(1, node(2, node(4), node(5)), node(3, node(6), node(7)))
    link(tr)
    output(tr)

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.linktreeNode958
    set output_file "main.py"

    set template_content '
def link(tr):
    if tr is None or tr.left is None:
        return
    (root, tr.next) = (tr, tr.left)
    (head, tail) = (tr, tr)
    while head.next:
        tr, head = deq(head)
        tail = enq(tail, tr.left)
        tail = enq(tail, tr.right)
    # break at 1, 2, 4, ...
    (i, m) = (0, 1)
    prev = tr = root
    while tr:
        (prev, tr) = (tr, tr.next)
        i = i + 1
        if i == m:
            prev.next = None
            (i, m) = (0, 2 * m)

def deq(head):
    return head, head.next

def enq(tail, x):
    if x:
        tail.next = x
        return x
    else:
        return tail
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.sumnoadj959
    set output_file "main.py"

    set template_content '
import random # for verification

def maxsum(xs):
    i, e = 0, 0
    for x in xs:
        i, e = x + e, max(i, e)
    return max(i, e)

# variant of soluiton 1: folding
def maxsum1(xs):
    return max(reduce(lambda (i, e), n: (n + e, max(i, e)), xs, (0, 0)))

# solution 2: sub-set sum like DP solution
def maxsum2(xs):
    n = len(xs)
    m = 0 if not xs else max(xs)
    if m == 0 or n <= 2:
        return m;
    s = sum(xs)
    tab = [set() for _ in xrange(s)] #record the indices for the subset
    for i in xrange(n):
        tab[xs[i]].add(tuple([i]))
    for i in xrange(n):
        for v in xrange(s):
            v1 = v - xs[i]
            if 0 <= v1 and tab[v1]:
                tab[v] = tab[v] | fromlist([tuple(sorted([i] + list(t))) for t in tab[v1] if not adjacent(i, t)])
    for v in reversed(xrange(s)):
        if tab[v]:
            #print tab[v]
            return v
    return 0

def fromlist(xs):
    return set(tuple(sorted(xs)))

def adjacent(i, t):
    return i in t or (i-1) in t or (i+1) in t

N = 20  # as solution 2 is very slow, dont set N too big.

def test():
    for _ in xrange(N):
        n = random.randint(0, N)
        xs = [random.randint(0, N) for _ in xrange(n)]
        check(xs)

def check(xs):
    s, s1 = maxsum(xs), maxsum2(xs)
    if s1 != s:
        print "FAIL: expected:", s, "actual:", s1
        print xs
        exit()

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.purchase960
    set output_file "main.py"

    set template_content '
INPUT1 = {"plan1" : ("AB", 100),
          "plan2" : ("BCD", 150),
          "plan3" : ("AD", 125),
          "plan4" : ("CD", 135)}


INPUT2 = {"plan0" : ("816309", 11),
          "plan1" : ("7824", 28),
          "plan2" : ("487i620", 47),
          "plan3" : ("649", 57),
          "plan4" : ("407396812", 57),
          "plan5" : ("986750123", 64),
          "plan6" : ("9642", 86),
          "plan7" : ("16480579", 107),
          "plan8" : ("9648350", 111),
          "plan9" : ("8937514", 128)}


def dp(plans):
    tab = { 0 : (set([]), set(""))}  # DP table { cost : ([plan], [products]) }
    for plan, (prods, price) in plans.items():
        for cost, (plan_set, prod_set) in tab.items():
            _cost = price + cost
            _prod_set = set(prods)
            if _cost not in tab or not _prod_set.issubset(prod_set):
                tab[_cost] = (plan_set.union([plan]), _prod_set.union(prod_set))
    return tab

def lowest(prods, tab):
    _prod_set = set(prods)
    for cost in sorted(tab.keys()):
        plan_set, prod_set = tab[cost]
        if _prod_set.issubset(prod_set):
            return (plan_set, cost)
    return None

# Brute force solution for verification purpose:

fst = lambda (a, b) : a
snd = lambda (a, b) : b

def brute_force(prods, offers):
    def cost_of(plans):
        return sum([snd(offers[p]) for p in plans])
    def to_set(plans):
        return set(plans.split(","))
    def from_set(plan_set):
        return ",".join(plan_set)
    def expand(ps, plans):
        res = set([])
        for plan_set in ps:
            lst = [from_set(p.union(plan_set)) for p in plans]
            res = res.union(set(lst))
        return map(to_set, res)
    prods = "".join(set(prods))
    ps = [set([])]
    for s in prods:
        ps = expand(ps, [set([p]) for p, (ss, _) in offers.items() if s in ss])
    costs = [(plan_set, cost_of(plan_set)) for plan_set in ps]
    # print costs
    return min(costs, key = snd)

# Verification:

def verify(prods, dp_tab, offers):
    print "dp for", prods, "==>", lowest(prods, dp_tab)
    print "brute force for", prods, "==>", brute_force(prods, offers)

def test():
    offers = INPUT1
    tab = dp(INPUT1)
    verify("BAD", tab, offers)   # plan1, plan3  ==> 225
    verify("BAC", tab, offers)  # plan1, plan4  ==> 235
    verify("BCD", tab, offers)  # plan2 ==> 150
    offers = INPUT2
    tab = dp(INPUT2)
    verify("704938521", tab, offers)

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.minFree961
    set output_file "main.py"

    set template_content '
def min_free(lst):
    n = len(lst)
    a = [0]*(n+1)
    for x in lst:
        if x < n:
            a[x] = 1
    return a.index(0)

def brute_force(lst):
    i = 0
    while True:
        if i not in lst:
            return i
        i = i + 1

def dc_min_free(lst):
    return binary_search(lst, 0, len(lst)-1)

def binary_search(lst, l, u):
    if lst == []:
        return l
    m = (l + u ) / 2
    xs = [x for x in lst if x <= m]
    ys = [x for x in lst if x > m]
    if len(xs) == m - l + 1:
        return binary_search(ys, m+1, u)
    else:
        return binary_search(xs, l, m)

def test():
    lst = [8, 23, 9, 0, 12, 11, 1, 10, 13, 7, 41, 4, 14, 21, 5, 17, 3, 19, 2, 6]
    assert(min_free(lst), brute_force(lst))
    assert(dc_min_free(lst), brute_force(lst))
    assert(min_free(range(5)), brute_force(range(5)))

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
function algoP.measures962
    set output_file "main.py"

    set template_content '
def measure(f, x):
    start = time.time()
    f(x)
    end = time.time()
    return end - start

def test_min_free(f):
    lst = range(100000) #0.1 million
    tm = 0
    for i in range(100):
        random.shuffle(lst)
        x = lst.pop()
        tm = tm + measure(f, lst)
        print tm, "[s] elapsed."
        lst.append(x)
    print "average time", tm/100, "[s]"

def test():
    #test_min_free(minfree.brute_force)
    #test_min_free(minfree.min_free) 
    test_min_free(minfree.dc_min_free) 

# ============================
# Some performance data
#
# N = 10,000,000      10 million
# Brute force:
# Flags method: 4 [sec]
# Divide and Conquer: 10 [sec]
#
# N = 100,000
# Brute Froce:
# Flags method: 0.0199500107765 [s]
# Divide and Conquer: 0.0445399999619 [s]
#
# ============================

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.list_comb963
    set output_file "main.py"

    set template_content '
def comb(xs, r):
    n = len(xs)
    acc = []
    def dfs(i, ys):
        if len(ys) == r:
            acc.append(ys)
        else:
            for j in range(i, n):
                dfs(j + 1, ys + [xs[j]])
    dfs(0, [])
    return acc

# Another recursive solution
def combination(xs, r):
   if r <= 0 or r > len(xs):
       return []
   if (r == 1):
       return [[x] for x in xs]
   res = []
   for i in range(len(xs)):
       yss = combination(xs[i + 1 : ], r - 1)
       res = res + [[xs[i]] + ys for ys in yss]
   return res

def test():
    xs = ['a', 'b', 'c', 'd']
    for r in range(6):
        print len(xs), "choose", r, ":", comb(xs, r)
        print len(xs), "choose", r, ":", combination(xs, r)

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.list_listex964
    set output_file "main.py"

    set template_content '
import random

class List:
    def __init__(self, x = None, xs = None):
        self.key = x
        self.next = xs

def cons(x, xs):
    return List(x, xs)

def length(xs):
    n = 0
    while xs is not None:
        n = n + 1
        xs = xs.next
    return n

def append(xs, x):
    xs = cons(None, xs)
    r = xs
    while xs.next is not None:
        xs = xs.next
    xs.next = List(x)
    return r.next

def takeM(n, xs):
    d = len(xs) - n
    while d > 0 and xs:
        xs.pop()
        d = d - 1
    return xs

def dropM(n, xs):
    if n <= 0:
        return xs
    for i in range(n, len(xs)):  # shift all elements ahead n
        xs[i - n] = xs[i]
    while n > 0 and xs:
        xs.pop()
        n = n - 1
    return xs

def mapL(f, xs):
    ys = prev = List()
    while xs is not None:
        prev.next = List(f(xs.key))
        prev = prev.next
        xs = xs.next
    return ys.next

def span(p, xs):
    ys = xs
    last = None
    while xs is not None and p(xs.key):
        last = xs
        xs = xs.next
    if last is None:
        return (None, xs)
    last.next = None
    return (ys, xs)

def group1(p, xs):
    if xs is None:
        return List(None)
    (x, xs) = (xs.key, xs.next)
    g = List(x)
    G = List(g)
    while xs is not None:
        y = xs.key
        if p(x, y):
            g = append(g, y)
        else:
            g = List(y)
            G = append(G, g)
        x = y
        xs = xs.next
    return G

def find(p, xs):
    while xs is not None:
        if p(xs.key):
            return xs
        xs = xs.next
    return None

def filterL(p, xs):
    ys = None
    while xs:
        if p(xs.key):
            ys = cons(xs.key, ys)
        xs = xs.next
    return reverse(ys)

def reverse(xs):
    ys = None
    while xs:
        ys = cons(xs.key, ys)
        xs = xs.next
    return ys

def lookupAssoc(x, assoc):
    for k, v in assoc:
        if x == k:
            return v
    return None

def zipL(xs, ys):
    zs = None
    while xs and ys:
        zs = cons((xs.key, ys.key), zs)
        xs = xs.next
        ys = ys.next
    return reverse(zs)

def fromList(xs):
    ys = None
    for x in reversed(xs):
        ys = cons(x, ys)
    return ys

def toList(xs):
    ys = []
    while xs is not None:
        ys.append(xs.key)
        xs = xs.next
    return ys

def dedup(xs):
    n = len(xs)
    i = 0
    while i < n:
        j = i + 1
        while j < n:
            if xs[i] == xs[j]:
                (xs[j], xs[n - 1]) = (xs[n - 1], xs[j])
                n = n - 1
            else:
                j = j + 1
        i = i + 1
    for _ in range(len(xs) - n):
        xs.pop()
    return xs

# testing
def randlist(n):
    return random.sample(range(n), random.randint(0, n))

def test_dedup():
    for _ in range(100):
        xs = randlist(100)
        assert sorted(set(xs)) == sorted(dedup(xs))
    print("tested dedup")

def test_zip():
    for _ in range(100):
        xs = randlist(100)
        ys = randlist(100)
        assert toList(zipL(fromList(xs), fromList(ys))) == list(zip(xs, ys))
    print("tested zip")

def test_filter():
    even = lambda x: x % 2 == 0
    for _ in range(100):
        lst = randlist(100)
        assert toList(filterL(even, fromList(lst))) == list(filter(even, lst))
    print("tested filter")

def test_map():
    negate = lambda x: -x
    inc = lambda x: 1 + x
    for _ in range(100):
        lst = randlist(100)
        assert all([toList(mapL(f, fromList(lst))) == list(map(f, lst)) for f in [negate, inc, abs]])
    print("tested map")

def test_span():
    for _ in range(100):
        lst = list(range(100))
        random.shuffle(lst)
        (xs, ys) = span(lambda x: x < 50, fromList(lst))
        if xs is not None:
            assert any(toList(mapL(lambda x: x < 50, xs)))
        if ys is not None:
            assert not ys.key < 50
        assert length(xs) + length(ys) == len(lst)
    print("tested span")

def test_find():
    for _ in range(100):
        lst = randlist(100)
        x = random.randint(0, 100)
        if x in lst:
            assert x == find(lambda a : x == a, fromList(lst)).key
        else:
            assert None == find(lambda a : x == a, fromList(lst))
    print("tested find")

def test_group1():
    gs = group1(lambda x, y: x == y, fromList("mississipi"))
    while gs is not None:
        print(toList(gs.key), end = '')
        gs = gs.next
    print("tested groupping")

def test_sublist():
    for _ in range(100):
        xs = randlist(100)
        n = random.randint(-10, 110)
        assert takeM(n, xs) == xs[:n]
        assert dropM(n, xs) == xs[n:]
    print("tested sublist")

if __name__ == "__main__":
    test_map()
    test_span()
    test_group1()
    test_find()
    test_sublist()
    test_filter()
    test_zip()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.list_pow965
    set output_file "main.py"

    set template_content '
def pow(b, n):
    a = 1
    while n != 0:
        if n & 1 == 1:
            a = a * b
        b = b * b
        n = n >> 1
    return a

def test():
    for i in range(16):
        print("2^", i, "=", pow(2, i))

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.list_adddigits966
    set output_file "main.py"

    set template_content '
from random import * # for verification purpose

class Node:
    def __init__(self, digit, next= None):
        self.d = digit
        self.next = next

def from_list(xs):
    return reduce(lambda h, x: Node(x, h), reversed(xs), None)

def to_list(h):
    xs = []
    while h is not None:
        xs.append(h.d)
        h = h.next
    return xs

def print_list(xs):
    print "->".join(to_list(xs))

# solution 1: in-place add, the result is stored in xs
def add(xs, ys):
    c = 0
    zs = xs
    prev = None
    while xs is not None and ys is not None:
        d = (xs.d + ys.d + c) % 10
        c = (xs.d + ys.d + c) // 10
        xs.d = d
        prev = xs
        xs = xs.next
        ys = ys.next
    if ys is not None:
        xs = ys
    while xs is not None and c != 0:
        d = (xs.d + c) % 10
        c = (xs.d + c) // 10
        prev.next = xs
        prev = xs
        xs.d = d
        xs = xs.next
    prev.next = Node(c) if c != 0 else xs
    return zs

# solution 2: create a new list of result.
def add1(xs, ys):
    c = 0
    zs = p = Node(-1) #sentinel
    while xs is not None and ys is not None:
        d = xs.d + ys.d + c
        c = 1 if d > 9 else 0
        p.next = Node(d % 10)
        (p, xs, ys) = (p.next, xs.next, ys.next)
    xs = xs if ys is None else ys
    while xs is not None:
        d = xs.d + c
        c = 1 if d > 9 else 0
        p.next = Node(d % 10)
        (p, xs) = (p.next, xs.next)
    if c != 0:
        p.next = Node(c)
    return zs.next

def from_int(n):
    return None if n == 0 else Node(n % 10, from_int(n // 10))

def exmaple():
    print_list(add(from_list([]), from_list([])))
    print_list(add(from_list([3, 1, 5]), from_list([5, 9, 2])))
    print_list(add(from_list([2]), from_list([9, 9, 9])))

def assert_eq(msg, expect, actual, x, y):
    a = to_list(expect)
    b = to_list(actual)
    if a != b:
        print msg, "Expect: ", a, "actual: ", b, "xs=", x, "ys=", y
        exit()

def test():
    N = 100000
    for _ in xrange(100):
        x = randint(0, N)
        y = randint(0, N)
        assert_eq("add", from_int(x+y), add(from_int(x), from_int(y)), x, y)
        assert_eq("add1", from_int(x+y), add1(from_int(x), from_int(y)), x, y)
    print "Passed 100 cases."

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.list_detect967
    set output_file "main.py"

    set template_content '
import random # for verification purpose only

class Node:
    def __init__(self, key, next = None):
        self.key = key
        self.next = next

def fnext(x):
    return x.next if x is not None else x

def prt(str, x):
    print str, None if x is None else x.key

# Robert W. Floyd method.
def find_cycle(x0, f):
    # p = q = x0, repeat p = f(p), q = f((q)) until p == q
    p = f(x0)     # the slow (tortoise)
    q = f(f(x0))  # the fast (hare)
    while p != q: # loop until converge
        p = f(p)
        q = f(f(q))

    k = 0
    q = x0        # reset the fast
    while p != q: # loop to the connection point
        p = f(p)
        q = f(q)
        k = k + 1

    n = 1
    q = f(p)
    while p != q: # traverse the circle
        q = f(q)
        n = n + 1

    return k, n

# Richard P. Brent method
def detect_cycle(x0, f):
    n = power = 1
    p = x0
    q = f(x0)
    while p != q: # loop until converge
        if power == n:
            p = q # reset the start point
            n = 0
            power = power * 2
        q = f(q)
        n = n + 1

    p = q = x0          # reset
    for _ in xrange(n): # make distance |qp| = n
        q = f(q)

    k = 0
    while p != q: # loop to the connection point
        p = f(p)
        q = f(q)
        k = k + 1

    return k, n

# verification

# create a linked-list of length n, if circular is true,
# make it loop starting from the k-th node.
def create(n, k, circular):
    t = p = None
    xs = range(n)
    random.shuffle(xs)
    for x in xs:
        p = Node(x, p)
        if t is None:
            t = p
    if circular:
        q = p
        for _ in xrange(k):
            q = q.next
        t.next = q
    return p

# get the k-th node of the linked-list p
def get_at(p, k):
    for _ in xrange(k):
        p = fnext(p)
    return p

def test():
    def __assert(str, p1, p2, circular):
        if p1 != p2:
            print "assert fail:", str, p1, p2, circular
            quit()
    for _ in xrange(1000):
        n = random.randint(1, 100)
        k = random.randint(0, n-1)
        circular = (random.randint(0, 1) == 0)
        p = create(n, k, circular)
        __assert("Floyd", find_cycle(p, fnext), (k, n-k) if circular else (n, 1), circular)
        __assert("Brent", detect_cycle(p, fnext),  (k, n-k) if circular else (n, 1), circular)
    print "1000 cases passed"

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.inttree968
    set output_file "main.py"

    set template_content '
import random

class IntTree:
    def __init__(self, key = 0, value = None):
        self.key = key
        self.value = value
        self.prefix = key
        self.mask = 1
        self.left = self.right = None

    def isleaf(self):
        return self.left is None and self.right is None

    def replace(self, x, y):
        if self.left == x:
            self.left = y
        else:
            self.right = y

    def match(self, k):
        return maskbit(k, self.mask) == self.prefix

def maskbit(x, mask):
    return x & (~(mask - 1))

def zero(x, mask):
    return x & (mask >> 1) == 0

# The longest common prefix

def lcp(p1, p2):
    diff = p1 ^ p2
    mask = 1
    while diff != 0:
        diff >>= 1
        mask <<= 1
    return (maskbit(p1, mask), mask)

def branch(t1, t2):
    t = IntTree()
    (t.prefix, t.mask) = lcp(t1.prefix, t2.prefix)
    if zero(t1.prefix, t.mask):
        t.left, t.right = t1, t2
    else:
        t.left, t.right = t2, t1
    return t

def insert(t, key, value):
    if t is None:
        return IntTree(key, value)
    node = t
    parent = None
    while (not node.isleaf()) and node.match(key):
        parent = node
        if zero(key, node.mask):
            node = node.left
        else:
            node = node.right
    if node.isleaf() and key == node.key:
        node.value = value
    else:
        p = branch(node, IntTree(key, value))
        if parent is None:
            return p
        parent.replace(node, p)
    return t

def lookup(t, key):
    while t is not None and (not t.isleaf()) and t.match(key):
        if zero(key, t.mask):
            t = t.left
        else:
            t = t.right
    if t is not None and t.isleaf() and t.key == key:
        return t.value
    return None

def from_map(m):
    t = None
    for k, v in m.items():
        t = insert(t, k, v)
    return t

def test():
    def generate_map(size):
        m = {}
        xs = range(size);
        random.shuffle(xs)
        for i in xrange(size):
            m[i] = xs[i]
        return m
    sz = 100
    for i in xrange(sz):
        m = generate_map(random.randint(0, sz-1))
        t = from_map(m)
        for k, v in m.items():
            val = lookup(t, k)
            if v != val:
                print "lookup", k, "got", val, "!=", v, "t=\n", to_str(t)
                exit()
        for k in xrange(sz):
            if k not in m and lookup(t, k) is not None:
                print "lookup", i, "expected None, but get", lookup(t, i) ,to_str(t)
                exit()
    print "passed", sz, "cases"

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.intrie969
    set output_file "main.py"

    set template_content '
import random

class IntTrie:
    def __init__(self):
        self.value = None
        self.left = self.right = None

def insert(t, key, value = None):
    if t is None:
        t = IntTrie()
    p = t
    while key != 0:
        if key & 1 == 0:
            if p.left is None:
                p.left = IntTrie()
            p = p.left
        else:
            if p.right is None:
                p.right = IntTrie()
            p = p.right
        key = key >> 1  # key / 2
    p.value = value
    return t

def lookup(t, key):
    while t is not None and key != 0:
        if key & 1 == 0:
            t = t.left
        else:
            t = t.right
        key = key >> 1
    return None if t is None else t.value

def from_list(kvs):
    t = None
    for k, v in kvs:
        t = insert(t, k, v)
    return t

def from_map(m):
    return from_list(m.items())

def test():
    def generate_map(size):
        m = {}
        xs = range(size);
        random.shuffle(xs)
        for i in xrange(size):
            m[i] = xs[i]
        return m
    sz = 100
    for i in xrange(sz):
        m = generate_map(random.randint(0, sz-1))
        t = from_map(m)
        for k, v in m.items():
            val = lookup(t, k)
            if v != val:
                print "lookup", k, "got", val, "!=", v, "t=\n", to_str(t)
                exit()
        for k in xrange(sz):
            if k not in m and lookup(t, k) is not None:
                print "lookup", i, "expected None, but get", lookup(t, i) ,to_str(t)
                exit()
    print "passed", sz, "cases"

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.prefixtree970
    set output_file "main.py"

    set template_content '
from itertools import count

# Prefix tree definition
class PrefixTree:
    def __init__(self, value = None):
        self.value = value
        self.subtrees = {}

# longest common prefix
# returns (p, s1', s2'), where p is lcp, s1'=s1-p, s2'=s2-p
def lcp(s1, s2):
    j = 0
    while j < len(s1) and j < len(s2) and s1[j] == s2[j]:
        j += 1
    return (s1[0:j], s1[j:], s2[j:])

def branch(key1, tree1, key2, tree2):
    if key1 == []:
        tree1.subtrees[key2] = tree2
        return tree1
    t = PrefixTree()
    t.subtrees[key1] = tree1
    t.subtrees[key2] = tree2
    return t

def insert(t, key, value):
    if t is None:
        t = PrefixTree()
    node = t
    while True:
        match = False
        for k, tr in node.subtrees.items():
            if key == k: # overwrite
                tr.value = value
                return t
            prefix, k1, k2 = lcp(key, k)
            if prefix != "":
                match = True
                if k2 == "":  # go on traversing
                    node = tr
                    key = k1
                    break
                else: #branch out a new leaf
                    node.subtrees[prefix] = branch(k1, PrefixTree(value), k2, tr)
                    del node.subtrees[k]
                    return t
        if not match: # add a new leaf
            node.subtrees[key] = PrefixTree(value)
            break
    return t

def lookup(t, key):
    if t is None:
        return None
    while True:
        match = False
        for k, tr in t.subtrees.items():
            if k == key:
                return tr.value
            prefix, k1, k2 = lcp(key, k)
            if prefix != "" and k2 == "":
                match = True
                key = k1
                t = tr
                break
        if not match:
            break
    return None

def keys(t, prefix = ""):
    ks = []
    if t.value is not None:
        ks.append(prefix)
    for k, tr in sorted(t.subtrees.items()):
        ks += keys(tr, prefix + k)
    return ks

def from_list(kvs):
    t = None
    for k, v in kvs:
        t = insert(t, k, v)
    return t

def from_map(m):
    return from_list(m.items())

def from_text(txt):
    return from_list(zip(txt.split(), count()))

def test():
    n = 100
    txts = ["a another an boy bool zoo",
            "zoo bool boy another an a",
            "zoo is a place where animals are for public to see",
            "an zoo example with duplicated zoo words"]
    for txt in txts:
        kvs = list(zip(txt.split(), count()))
        m = dict(kvs)
        print("kvs", kvs, "\nmap", m)
        t = from_list(kvs)
        for k in m:
            v = lookup(t, k)
            assert(v is not None)
            assert(v == m[k])
        assert(sorted(keys(t)) == sorted(m.keys()))
    print(len(txts), "tests passed.")

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.treedot971
    set output_file "main.py"

    set template_content '
import sys
import string
import getopt
import trie
import patricia

def define_connection(n1, n2, edge):
    return "\t"+n1+"->"+n2+"[label=\""+edge+"\"]\n"

def define_node(node, prefix=""):
    res="\t"
    node_name = lambda x: "t"+x
    to_str = lambda x: "%s" %x
    node_attrib = "[label=\"\"];\n"
    if node.value is not None:
        node_attrib = "[label=\""+prefix + ":" + node.value + "\", shape=ellipse];\n"
    res += node_name(prefix)+node_attrib
    for k, v in sorted(node.children.items()):
        res += define_node(v, prefix+to_str(k))
        res += define_connection(node_name(prefix), node_name(prefix+to_str(k)), to_str(k))
    return res

def trie_to_dot(t, filename):
    res="digraph G{\n" "\tnode[shape=circle]\n"
    res=res+define_node(t)
    res=res+"}"
    print res
    f=open(filename,'w')
    f.write(res)
    f.close()
    print "write to file ", filename, "OK."

def get_args(argv):
    try:
        type="trie"
        opts, args = getopt.getopt(argv, "o:t:")
        for opt, arg in opts:
            if opt == "-o":
                filename=arg
            elif opt == "-t":
                type=arg
            else:
                usage()
        return (filename, type, args[0])
    except getopt.GetoptError:
        usage()

def usage():
    print __doc__
    sys.exit()

def is_map(s):
    return not s.find(":") == -1

def to_map(s):
    m={}
    for elem in s.split(", "):
        (k, v) = elem.split(":")
        m[k]=v
    return m

def main(argv):
    (filename, type, ts)=get_args(argv)
    if type == "trie":
        if is_map(ts):
            t=trie.map_to_trie(to_map(ts))
        else:
            t=trie.list_to_trie(ts.split(", "))
        print trie.trie_to_str(t)
        trie_to_dot(t, filename)
    if type == "patricia":
        if is_map(ts):
            t=patricia.map_to_patricia(to_map(ts))
        else:
            t=patricia.list_to_patricia(ts.split(", "))
        print patricia.to_string(t)
        trie_to_dot(t, filename)

if __name__ == "__main__":
    main(sys.argv[1:])

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.trieutil972
    set output_file "main.py"

    set template_content '
def trie_to_str(t, prefix = ""):
    s = "(" + prefix
    if t.value is not None:
        s += ":" + t.value
    for k, v in sorted(t.children.items()):
        s += ", " + trie_to_str(v, prefix + k)
    return s + ")"

def from_list(l, insert_func):
    t = None
    for x in l:
        t = insert_func(t, x)
    return t

def from_map(m, insert_func):
    t = None
    for k, v in m.items():
        t = insert_func(t, k, v)
    return t
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.treesuffix973
    set output_file "main.py"

    set template_content '
import sys
import string
import getopt
import strie
import stree

def define_connection(n1, n2, edge):
    return "\t"+n1+"->"+n2+"[label=\""+edge+"\"]\n"

node_name = lambda x: "t"+x
node_attrib = "[label=\"\"];\n"

def define_trie_node(node, prefix=""):
    res="\t"
    to_str = lambda x: "%s" %x
    res += node_name(prefix)+node_attrib
    for k, v in sorted(node.children.items()):
        res += define_trie_node(v, prefix+to_str(k))
        res += define_connection(node_name(prefix), node_name(prefix+to_str(k)), to_str(k))
    return res

def define_tree_node(t, node, prefix=""):
    res="\t"
    to_str = lambda x: stree.substr(t.str, x)
    res += node_name(prefix)+node_attrib
    for c, (sref, tr) in sorted(node.children.items()):
        res += define_tree_node(t, tr, prefix+to_str(sref))
        res += define_connection(node_name(prefix), node_name(prefix+to_str(sref)), to_str(sref))
    return res

def to_dot(t, filename, type):
    res="digraph G{\n" "\tnode[shape=circle]\n"
    if type == "trie":
        res+=define_trie_node(t)
    else:
        res+=define_tree_node(t, t.root)
    res=res+"}"
    print res
    f=open(filename,'w')
    f.write(res)
    f.close()
    print "write to file ", filename, "OK."

def get_args(argv):
    try:
        type="tree"
        suffix_link=False
        opts, args = getopt.getopt(argv, "o:t:l") #o, t needs argument, while l does not
        for opt, arg in opts:
            if opt == "-o":
                filename=arg
            elif opt == "-t":
                type=arg
            elif opt == "-l":
                suffix_link = True
            else:
                usage()
        return (filename, type, suffix_link, args[0])
    except getopt.GetoptError:
        usage()

def usage():
    print __doc__
    sys.exit()

def main(argv):
    (filename, type, suffix_link, s)=get_args(argv)
    if type == "trie":
        t=strie.suffix_trie(s)
        print strie.to_str(t)
        to_dot(t, filename, type)
    if type == "tree":
        t=stree.suffix_tree(s)
        print stree.to_str(t)
        to_dot(t, filename, type)

if __name__ == "__main__":
    main(sys.argv[1:])

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.suffixtree974
    set output_file "main.py"

    set template_content '
import string

class Node:
    def __init__(self, suffix=None):
        self.children = {} # 'c':(word, Node), where word = (l, r)
        self.suffix = suffix

class STree:
    def __init__(self, s):
        self.str = s
        self.infinity = len(s)+1000
        self.root = Node()

    def substr(self, sref):
        return substr(self.str, sref)

#
# In order to improve the efficiency by operation on-line
# There is only one copy of the string. All sub strings are
# represented as reference pair: 
#   w = (k, p)
# where: w = str[k:p+1], +1 is because of Pythons specific
# problem
#
def substr(str, str_ref):
    (l, r)=str_ref
    return str[l:r+1]

def length(str_ref):
    (l, r)=str_ref
    return r-l+1


def suffix_tree(str):
    t = STree(str)
    node = t.root # init active point is (root, Empty)
    l = 0
    for i in range(len(str)):
        (node, l) = update(t, node, (l, i))
        (node, l) = canonize(t, node, (l, i))
    return t


def update(t, node, str_ref):
    (l, i) = str_ref 
    c = t.str[i] # current char
    prev = Node() # dummy init 
    while True:
        (finish, p) = branch(t, node, (l, i-1), c)
        if finish:
            break
        p.children[c]=((i, t.infinity), Node())
        prev.suffix = p
        prev = p
        # go up along suffix link
        (node, l) = canonize(t, node.suffix, (l, i-1))
    prev.suffix = node
    return (node, l)


def branch(t, node, str_ref, c):
    (l, r) = str_ref
    if length(str_ref)<=0: # (node, empty)
        if node is None: #_|_
            return (True, t.root)
        else:
            return ((c in node.children), node)
    else:
        ((l1, r1), node1) = node.children[t.str[l]]
        pos = l1+length(str_ref)
        if t.str[pos]==c:
            return (True, node)
        else:             # node--->branch_node--->node1
            branch_node = Node()
            node.children[t.str[l1]]=((l1, pos-1), branch_node)
            branch_node.children[t.str[pos]] = ((pos, r1), node1)
            return (False, branch_node)


def canonize(t, node, str_ref):
    (l, r) = str_ref 
    if node is None:
        if length(str_ref)<=0:
            return (None, l)
        else:
            return canonize(t, t.root, (l+1, r))
    while l<=r: # str_ref is not empty
        ((l1, r1), child) = node.children[t.str[l]] # node--(l', r')-->child
        if r-l >= r1-l1: #node--(l',r')-->child--->...
            l += r1-l1+1 # remove |(l',r')| chars from (l, r)
            node = child 
        else:
            break
    return (node, l)

def to_lines(t, node):
    if len(node.children)==0:
        return [""]
    res = []
    for c, (str_ref, tr) in sorted(node.children.items()):
        lines = to_lines(t, tr)
        edge_str = substr(t.str, str_ref)
        lines[0] = "|--"+edge_str+"-->"+lines[0]
        if len(node.children)>1:
            lines[1:] = map(lambda l: "|"+" "*(len(edge_str)+5)+l, lines[1:])
        else:
            lines[1:] = map(lambda l: " "+" "*(len(edge_str)+6)+l, lines[1:])
        if res !=[]:
            res.append("|")
        res += lines
    return res

def to_str(t):
    return "\n".join(to_lines(t, t.root))

class SuffixTreeTest:
    def __init__(self):
        print "start suffix tree test"

    def run(self):
        strs = ["cacao", "mississippi", "banana$"]
        for s in strs:
            self.test_build(s)

    def test_build(self, str):
        for i in range(len(str)):
            self.__test_build(str[:i+1])


    def __test_build(self, str):
        print "Suffix Tree ("+str+"):\n", to_str(suffix_tree(str)),"\n"

if __name__ == "__main__":
    SuffixTreeTest().run()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.redblacktree975
    set output_file "main.py"

    set template_content '
import string

RED = 0
BLACK = 1
DOUBLY_BLACK = 2

class Node:
    def __init__(self, key, color = RED):
        self.key = key;
        self.color = color;
        self.left = self.right = self.parent = None

    def set_left(self, x):
        self.left = x
        if x != None:
            x.parent = self

    def set_right(self, x):
        self.right = x
        if x != None:
            x.parent = self

    def set_children(self, x, y):
        self.set_left(x)
        self.set_right(y)

    def replace_by(self, y):
        replace(self.parent, self, y)

    def sibling(self):
        if self.parent.left == self:
            return self.parent.right
        else:
            return self.parent.left

    def uncle(self):
        return self.parent.sibling()

    def grandparent(self):
        return self.parent.parent

# common helpfer operations
def set_color(nodes, colors):
    for (n, c) in zip(nodes, colors):
        n.color = c

# change from: parent --> x to: parent --> y
def replace(parent, x, y):
    if parent is None:
        if y is not None:
            y.parent = None
    elif parent.left == x:
        parent.set_left(y)
    else:
        parent.set_right(y)
    if x is not None:
        x.parent = None
    return y

# rotations

# (a x (b y c)) ==> ((a x b) y c)
def left_rotate(t, x):
    (parent, y) = (x.parent, x.right)
    (a, b, c)   = (x.left, y.left, y.right)
    x.replace_by(y)
    x.set_children(a, b)
    y.set_children(x, c)
    if parent is None:
        t=y
    return t

# (a x (b y c)) <== ((a x b) y c)
def right_rotate(t, y):
    (parent, x) = (y.parent, y.left)
    (a, b, c)   = (x.left, x.right, y.right)
    y.replace_by(x)
    y.set_children(b, c)
    x.set_children(a, y)
    if parent is None:
        t = x
    return t

# insertion and deletion

def rb_insert(t, key): #returns the new root
    root = t
    x = Node(key)
    parent = None
    while(t):
        parent = t
        if(key < t.key):
            t = t.left
        else:
            t = t.right
    if parent is None: #tree is empty
        root = x
    elif key < parent.key:
        parent.set_left(x)
    else:
        parent.set_right(x)
    return rb_insert_fix(root, x)

# Fix the red->red violation
def rb_insert_fix(t, x):
    while(x.parent and x.parent.color==RED):
        if x.uncle().color == RED:
            #case 1: ((a:R x:R b) y:B c:R) ==> ((a:R x:B b) y:R c:B)
            set_color([x.parent, x.grandparent(), x.uncle()],
                      [BLACK, RED, BLACK])
            x = x.grandparent()
        else:
            if x.parent == x.grandparent().left:
                if x == x.parent.right:
                    #case 2: ((a x:R b:R) y:B c) ==> case 3
                    x = x.parent
                    t=left_rotate(t, x)
                # case 3: ((a:R x:R b) y:B c) ==> (a:R x:B (b y:R c))
                set_color([x.parent, x.grandparent()], [BLACK, RED])
                t=right_rotate(t, x.grandparent())
            else:
                if x == x.parent.left:
                    #case 2': (a x:B (b:R y:R c)) ==> case 3'
                    x = x.parent
                    t = right_rotate(t, x)
                # case 3: (a x:B (b y:R c:R)) ==> ((a x:R b) y:B c:R)
                set_color([x.parent, x.grandparent()], [BLACK, RED])
                t=left_rotate(t, x.grandparent())
    t.color = BLACK
    return t

# Querying function for deletion, we can reuse those in binary search tree (bstree.py)

def tree_search(t, x):
    while(t!=None and t.key != x):
        if(x < t.key): t = t.left
        else: t = t.right
    return t

def tree_min(t):
    while(t!=None and t.left != None):
        t = t.left
    return t

def remove_node(x):
    if (x is None): return
    x.parent = x.left = x.right = None

def is_leaf(x):
    if x is None: return False
    return (x.left is None) and (x.right is None)

def make_black(parent, x):
    if parent is None and x is None:
        return None
    if x is None:
        return replace(parent, x, Node(0, DOUBLY_BLACK))
    x.color = x.color + 1
    return x

def rb_delete(t, x):
    if x is None: return t
    (parent, db) = (x.parent, None)
    if x.left is None:
        x.replace_by(x.right)
        db = x.right
    elif x.right is None:
        x.replace_by(x.left)
        db = x.left
    else:
        y = tree_min(x.right)
        (parent, db)=(y.parent, y.right)
        x.key = y.key
        y.replace_by(y.right)
        x = y
    if x.color == BLACK:
        t = rb_delete_fix(t, make_black(parent, db), db is None)
    remove_node(x)
    return t

def is_red(x):
    if x is None: return False
    return x.color == RED

def is_black(x):
    return x is None or x.color == BLACK

def rb_delete_fix(t, db, is_db_empty):
    db_empty = db if is_db_empty else None
    if db is None: return None # remove the root from a leaf tree
    while(db!=t and db.color==DOUBLY_BLACK):
        if db.sibling() != None:
            # case 1:  the sibling is red, (transform to make the sibling black)
            if is_red(db.sibling()):
                set_color([db.parent, db.sibling()],[RED, BLACK])
                if(db == db.parent.left):
                    t=left_rotate(t, db.parent)
                else:
                    t=right_rotate(t, db.parent)
            # case 3, 4: the sibling is black, and one nephew is red
            elif is_black(db.sibling()) and is_red(db.sibling().left):
                if db == db.parent.left:
                    colors=[BLACK, BLACK, db.parent.color]
                    set_color([db, db.parent, db.sibling().left], colors)
                    t=right_rotate(t, db.sibling())
                    t=left_rotate(t, db.parent)
                else:
                    colors=[BLACK, BLACK, db.parent.color, BLACK]
                    set_color([db, db.parent, db.sibling(), db.sibling().left], colors)
                    t=right_rotate(t, db.parent)
            elif is_black(db.sibling()) and is_red(db.sibling().right):
                if db == db.parent.left:
                    colors=[BLACK, BLACK, db.parent.color, BLACK]
                    set_color([db, db.parent, db.sibling(), db.sibling().right], colors)
                    t=left_rotate(t, db.parent)
                else:
                    colors=[BLACK, BLACK, db.parent.color]
                    set_color([db, db.parent, db.sibling().right], colors)
                    t=left_rotate(t, db.sibling())
                    t=right_rotate(t, db.parent)
            # case 2: the sibling and both nephews are black. (move the blackness up)
            elif is_black(db.sibling()) and (not is_red(db.sibling().left)) and (not is_red(db.sibling().right)):
               set_color([db, db.sibling()], [BLACK, RED])
               db.parent.color=db.parent.color+1
               db = db.parent
            # a sibling without child is invalid case, because it violate property 5
        else: # no sibling, we can move blackness up
            db.color = BLACK
            db.parent.color = db.parent.color+1
            db = db.parent
    t.color=BLACK
    if db_empty is not None:
        db_empty.replace_by(None)
    return t

# Helper functions for test

def rbtree_clone(t):
    n = None
    if t != None:
        n = Node(t.key, t.color)
        n.set_children(rbtree_clone(t.left), rbtree_clone(t.right))
    return n

def rbtree_to_str(t):
    if t is None:
        return "."
    else:
        color = {RED:"R", BLACK:"B"}
        return "("+rbtree_to_str(t.left)+ " " + str(t.key) +":"+color[t.color]+" " + rbtree_to_str(t.right)+")"

def list_to_tree(l):
    tree = None
    for x in l:
        tree = rb_insert(tree, x)
    return tree

CLR = {'R':RED, 'B':BLACK}

def node(x, c):
    return Node(x, CLR[c] if c in CLR else DOUBLY_BLACK)

def tr(l, x, c, r):
    t = node(x, c)
    t.set_children(l, r)
    return t

def is_rbt(t):
    if t is None:
        return True
    if not is_black(t):
        print "root is not black"
        return False
    if has_adjacent_red(t):
        print "has adjacent red nodes"
        return False
    if num_of_blacks(t) < 0:
        print "different number of black nodes"
        return False
    return True

def has_adjacent_red(t):
    if t is None:
        return False
    if is_red(t) and (is_red(t.left) or is_red(t.right)):
        print "adjacent red at", t.key
        return True
    return has_adjacent_red(t.left) or has_adjacent_red(t.right)

def num_of_blacks(t):
    if t is None:
        return 1
    a, b = num_of_blacks(t.left), num_of_blacks(t.right)
    if a != b:
        print "Node", t.key, "has different black desendants: l=", a, ", r=", b
        return -1000
    return a + (1 if is_black(t) else 0)

def assert_rbt(t):
    if not is_rbt(t):
        exit(-1)

class Test:
    def __init__(self):
        #t1 = ((1B 2R (4B 3R .)) 5B (6B 7R (8R 9B .)))
        self.t1 = tr(tr(node(1, 'B'), 2, 'R', tr(node(3, 'R'), 4, 'B', None)),
                     5, 'B',
                     tr(node(6, 'B'), 7, 'R', tr(node(8, 'R'), 9, 'B', None)));
        print "t1 1..9:\n", rbtree_to_str(self.t1)
        self.t2 = tr(tr(node(1, 'B'), 2, 'R', tr(node(5, 'R'), 7, 'B', node(8, 'R'))),
                     11, 'B',
                     tr(None, 14, 'B', node(15, 'R')));
        print "t2, CLRS fig 13.4:\n", rbtree_to_str(self.t2)


    def assert_eq(self, a, b):
        s1, s2 = rbtree_to_str(a), rbtree_to_str(b)
        self.__assert("different trees", s1, s2)

    def __assert(self, msg, x, y):
        if(x == y): msg = msg + "OK."
        else: msg = msg + str(x) + "!=" + str(y) + "Fail."
        print msg

    def run(self):
        self.test_rotate()
        self.test_insert()
        self.test_delete()

    def test_rotate(self):
        t = rbtree_clone(self.t1)
        x = t.right #7R
        t = left_rotate(t, x) #(6 7 (8 9 .) ==> ((6 7 8) 9 .)
        print "left rotate at 7:R\n", rbtree_to_str(t)
        t = right_rotate(t, t.right) #rotate back
        print "right rotate back:\n", rbtree_to_str(t)
        self.assert_eq(t, self.t1)

        t = left_rotate(t, t) #(2 5 (6 7 9) ==> ((2 5 6) 7 9)
        print "left rotate at root:\n", rbtree_to_str(t)
        t = right_rotate(t, t) #rotate back
        print "right rotate back:\n", rbtree_to_str(t)
        self.assert_eq(t, self.t1)

    def test_insert(self):
        t = rbtree_clone(self.t2)
        t = rb_insert(t, 4)
        print "t2: after insert 4\n", rbtree_to_str(t)
        assert_rbt(t)

        t = list_to_tree([5, 2, 7, 1, 4, 6, 9, 3, 8])
        print "list->tree, create t1 by insert\n", rbtree_to_str(t)
        self.assert_eq(t, self.t1)
        assert_rbt(t)

    def __test_del_n(self, tree, n):
        t = rbtree_clone(tree)
        t = rb_delete(t, tree_search(t, n))
        print "del ", n, ": ", rbtree_to_str(t)
        self.__assert("search after del: ", tree_search(t, n), None)
        assert_rbt(t)

    def test_delete(self):
        for i in range(1, 10):
            self.__test_del_n(self.t1, i)
        self.__test_del_n(self.t1, 11) #del a non-exist value
        t = Node(1, BLACK) #leaf case
        self.__test_del_n(t, 1)

if __name__ == "__main__":
    Test().run()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.binarysearchtree976
    set output_file "main.py"

    set template_content '
import sys
import string

# Definition

class Node:
    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None
        self.parent = None #optional, its helpful for succ/pred

def in_order_walk(t, f):
    if(t!=None):
        in_order_walk(t.left, f)
        f(t.key)
        in_order_walk(t.right, f)

# Querying

def tree_search(t, x):
    while(t!=None and t.key != x):
        if(x < t.key): t = t.left
        else: t = t.right
    return t

def tree_min(t):
    while(t!=None and t.left != None):
        t = t.left
    return t

def tree_max(t):
    while(t!=None and t.right != None):
        t = t.right
    return t

def succ(x):
    if x is None: return None
    if x.right is not None: return tree_min(x.right)
    p = x.parent
    while p is not None and p.left != x:
        x = p
        p = p.parent
    return p

def pred(x):
    if x is None: return None
    if x.left is not None: return tree_max(x.left)
    p = x.parent
    while p is not None and p.right != x:
        x = p
        p = p.parent
    return p

# Insertion and deletion

def tree_insert(t, key):
    root = t
    x = Node(key)
    parent = None
    while(t):
        parent = t
        if(key < t.key):
            t = t.left
        else:
            t = t.right
    x.parent = parent
    if(parent == None): #tree is empty
        return x
    elif(key < parent.key):
        parent.left = x
    else:
        parent.right = x
    return root

def remove_node(x):
    if (x is None): return
    x.parent = x.left = x.right = None

def tree_delete(t, x):
    if x is None:
        return t
    [root, old_x, parent] = [t, x, x.parent]
    if x.left is None:
        x = x.right
    elif x.right is None:
        x = x.left
    else:
        y = tree_min(x.right)
        x.key = y.key
        if y.parent != x:
            y.parent.left = y.right
        else:
            x.right = y.right
        if y.right is not None:
            y.right.parent = y.parent
        remove_node(y)
        return root
    if x is not None:
        x.parent = parent
    if parent is None:
        root = x
    else:
        if parent.left == old_x:
            parent.left = x
        else:
            parent.right = x
    remove_node(old_x)
    return root

# Helper functions

def list_to_tree(l):
    tree = None
    for x in l:
        tree = tree_insert(tree, x)
    return tree

def clone_tree(t, parent = None):
    n = None
    if(t != None):
        n = Node(t.key)
        n.left = clone_tree(t.left, n)
        n.right = clone_tree(t.right, n)
        n.parent = parent
    return n

def tree_to_str(t):
    if(t!=None):
        return "("+tree_to_str(t.left)+"), " + str(t.key) + ", (" + tree_to_str(t.right)+")"
    else:
        return "empty"

def my_print(x):
    print x

class Test:
    def __init__(self):
        self.tree = list_to_tree([15, 6, 18, 3, 7, 17, 20, 2, 4, 13, 9])
        print tree_to_str(self.tree)

    def __assert(self, msg, x, y):
        if(x == y): msg = msg + "OK."
        else: msg = msg + str(x) + "!=" + str(y) + "Fail."
        print msg

    def run(self):
        self.test_in_order_walk()
        self.test_search()
        self.test_min_max()
        self.test_succ_pred()
        self.test_del()

    def test_in_order_walk(self):
        print "test in order walk with my_print: "
        in_order_walk(self.tree, my_print)

    def test_search(self):
        self.__assert("search empty: ", tree_search(None, 3), None)
        print tree_to_str(tree_search(self.tree, 18))
        self.__assert("search non-exist: ", tree_search(self.tree, 5), None)

    def test_min_max(self):
        self.__assert("min(empty): ", tree_min(None), None)
        self.__assert("min(tree): ", tree_min(self.tree).key, 2)
        self.__assert("max(empty): ", tree_max(None), None)
        self.__assert("max(tree): ", tree_max(self.tree).key, 20)

    def test_succ_pred(self):
        self.__assert("succ of 7: ", succ(tree_search(self.tree, 7)).key, 9)
        self.__assert("succ of 13: ", succ(tree_search(self.tree, 13)).key, 15)
        self.__assert("succ of 20: ", succ(tree_search(self.tree, 20)), None)
        self.__assert("pred of 6: ", pred(tree_search(self.tree, 6)).key, 4)
        self.__assert("pred of 7: ", pred(tree_search(self.tree, 7)).key, 6)
        self.__assert("pred of 2: ", pred(tree_search(self.tree, 2)), None)

    def __test_del_n(self, n):
        t = clone_tree(self.tree)
        t = tree_delete(t, tree_search(t, n))
        print "del ", n, ": ", tree_to_str(t)
        self.__assert("search after del: ", tree_search(t, n), None)

    def test_del(self):
        self.__test_del_n(17)
        self.__test_del_n(7)
        self.__test_del_n(6)
        self.__test_del_n(15)
        self.__test_del_n(1) #del a non-exist value

if __name__ == "__main__":
    Test().run()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.btree977
    set output_file "main.py"

    set template_content '
from random import sample, randint

TREE_2_3_4 = 2

class BTree:
    def __init__(self):
        self.keys = []
        self.subtrees = []

    def __str__(self):
        res = "("
        if is_leaf(self):
            res += ", ".join(str(k) for k in self.keys)
        else:
            for i in range(len(self.keys)):
                res += str(self.subtrees[i]) + ", " + str(self.keys[i]) + ", "
            res += str(self.subtrees[-1])
        return res + ")"

# d - 1 <= |t.keys| <= 2 * d - 1
#
# To avoid violating B-tree after insert/delete, when keys reach to either boundary
# (= hold), trigger split/merge

def is_leaf(t):
    return t.subtrees == []

def full(d, t):
    return len(t.keys) >= 2 * d - 1

def low(d, t):
    return len(t.keys) <= d - 1

def split(d, z, i):
    """split z.subtrees[i] at degree d"""
    x = z.subtrees[i]
    y = BTree()
    z.keys.insert(i, x.keys[d - 1])
    z.subtrees.insert(i + 1, y)
    y.keys = x.keys[d : ]
    x.keys = x.keys[ : d - 1]
    if not is_leaf(x):
        y.subtrees = x.subtrees[d : ]
        x.subtrees = x.subtrees[ : d]

def ordered_insert(lst, x):
    i = len(lst)
    lst.append(x)
    while i > 0 and lst[i] < lst[i - 1]:
        (lst[i - 1], lst[i]) = (lst[i], lst[i - 1])
        i = i - 1

def insert_nonfull(d, t, x):
    if is_leaf(t):
        ordered_insert(t.keys, x)
    else:
        i = len(t.keys)
        while i > 0 and x < t.keys[i-1]:
            i = i - 1
        if full(d, t.subtrees[i]):
            split(d, t, i)
            if x > t.keys[i]:
                i = i + 1
        insert_nonfull(d, t.subtrees[i], x)
    return t

def insert(d, t, x, insert_nonfull_func = insert_nonfull):
    """insert key x to tree t, where the degree is d"""
    root = t
    if full(d, root):
        s = BTree()
        s.subtrees = [root]
        split(d, s, 0)
        root = s
    return insert_nonfull_func(d, root, x)

def loop_insert_nonfull(d, t, x):
    root = t
    while not is_leaf(t):
        i = len(t.keys)
        while i > 0 and x < t.keys[i-1]:
            i = i - 1
        if full(d, t.subtrees[i]):
            split(d, t, i)
            if x > t.keys[i]:
                i = i + 1
        t = t.subtrees[i]
    ordered_insert(t.keys, x)
    return root

def insert1(d, t, x):
    return insert(d, t, x, loop_insert_nonfull)

def delete(d, t, x):
    if t.keys == []:
        return t
    for i in range(len(t.keys)):
        if x <= t.keys[i]:
            break
    if x == t.keys[i]:
        if is_leaf(t):         # case 1
            t.keys.pop(i)
        else:
            tl = t.subtrees[i]
            tr = t.subtrees[i + 1]
            if not low(d, tl):    # case 2a
                t.keys[i] = max_of(tl)
                delete(d, tl, t.keys[i])
            elif not low(d, tr):  # case 2b
                t.keys[i] = min_of(tr)
                delete(d, tr, t.keys[i])
            else:              # case 2c
                merge_subtrees(t, i)
                delete(d, tl, x)
                if t.keys == []:  # shrink height
                    t = tl
        return t
    if not is_leaf(t):
        if x > t.keys[-1]:
            i = i + 1
        if low(d, t.subtrees[i]):
            n = len(t.subtrees)
            tl = None if i == 0 else t.subtrees[i - 1]
            tr = None if i == n - 1 else t.subtrees[i + 1]
            if tl and (not low(d, tl)):   # case 3a, borrow from left
                t.subtrees[i].keys.insert(0, t.keys[i - 1])
                t.keys[i - 1] = tl.keys.pop()
                if not is_leaf(tl):
                    t.subtrees[i].subtrees.insert(0, tl.subtrees.pop())
            elif tr and (not low(d, tr)):  # case 3a, borrow from right
                t.subtrees[i].keys.append(t.keys[i])
                t.keys[i] = tr.keys.pop(0)
                if not is_leaf(tr):
                    t.subtrees[i].subtrees.append(tr.subtrees.pop(0))
            else:       # case 3b
                merge_subtrees(t, i if i + 1 < n else i - 1)
                if i + 1 == n:
                    i = i - 1
        delete(d, t.subtrees[i], x)
        if t.keys == []:    # shrink height
            t = t.subtrees[0]
    return t

def merge_subtrees(t, i):
    """merge t.subtrees[i], keys[i], t.subtrees[i+1]"""
    t.subtrees[i].keys += [t.keys[i]] + t.subtrees[i + 1].keys
    t.subtrees[i].subtrees += t.subtrees[i + 1].subtrees
    t.keys.pop(i)
    t.subtrees.pop(i + 1)

def max_of(t):
    while t.subtrees != []:
        t = t.subtrees[-1]
    return t.keys[-1]

def min_of(t):
    while t.subtrees != []:
        t = t.subtrees[0]
    return t.keys[0]

def lookup(t, k):
    if t.keys == []:
        return None
    for i in range(len(t.keys)):
        if k <= t.keys[i]:
            break
    if k == t.keys[i]:
        return (t, i)
    elif is_leaf(t):
        return None
    else:
        if k > t.keys[-1]:
            i = i + 1
        return lookup(t.subtrees[i], k)

def binary_lookup(t, k):
    if t.keys == []:
        return None
    l = 0
    u = len(t.keys)
    while l < u:
        m = (l + u) // 2
        if k == t.keys[m]:
            return (t, m)
        elif t.keys[m] < k:
            l = m + 1
        else:
            u = m
    if is_leaf(t):
        return None
    else:
        return binary_lookup(t.subtrees[l], k)

def fromlist(d, xs):
    t = BTree()
    for x in xs:
        t = insert(d, t, x)
    return t

def tolist(t):
    xs = []
    if t is None:
        return xs
    if is_leaf(t):
        xs = [k for k in t.keys]
    else:
        for i in range(len(t.keys)):
            xs += tolist(t.subtrees[i])
            xs.append(t.keys[i])
        xs += tolist(t.subtrees[-1])
    return xs

# verification

def deg(xs):
    return (xs[0] % 5) + 2 if xs else 2

def is_btree(d, t, depth):
    if t is None:
        return True
    n = len(t.keys)
    if n > 2 * d - 1:
        return False
    if depth > 0 and n < d - 1:
        return False
    for tr in t.subtrees:
        if not is_btree(d, tr, depth + 1):
            return False
    return True

def prop_order(xs):
    t = fromlist(deg(xs), xs)
    ys = tolist(t)
    zs = sorted(xs)
    assert ys == zs, f"ys = {ys}, zs = {zs}, t = {t}"

def prop_insert(xs):
    d = deg(xs)
    t = fromlist(d, xs)
    assert is_btree(d, t, 0), f"violate B-tree: d = {d}, t = {t}"

def prop_insert1(xs):
    d = deg(xs)
    t = BTree()
    for x in xs:
        t = insert1(d, t, x)
    assert is_btree(d, t, 0), f"violate B-tree: d = {d}, t = {t}"

def prop_lookup_with(xs, lookup_func):
    d = deg(xs)
    t = fromlist(d, xs)
    ys = sample(xs, min(5, len(xs))) + sample(range(100), 5)
    for y in ys:
        r = lookup_func(t, y)
        if y in xs:
            assert r, f"not found {y} in t = {t}"
            (tr, i) = r
            assert tr.keys[i] == y, f"y = {y}, tr = {tr}, i = {i}"
        else:
            assert (r is None), f"y = {y}, r = {r}"

def prop_lookup(xs):
    prop_lookup_with(xs, lookup)

def prop_binary_lookup(xs):
    prop_lookup_with(xs, binary_lookup)

def prop_delete(xs):
    d = deg(xs)
    ys = sample(xs, min(5, len(xs))) + sample(range(100), 5)
    for y in ys:
        t = fromlist(d, xs)
        r = delete(d, t, y)
        zs = tolist(r)
        assert is_btree(d, r, 0), f"violate B-tree: d = {d}, t={r}"
        if y in xs:
            assert y not in zs, f"found {y} after delete:\nt = {r}\nbefore delete\nt = {t}"
        else:
            assert sorted(xs) == zs, f"y = {y}, t = {r}, \nxs = {sorted(xs)}\nzs = {zs}"

def test(f):
    for _ in range(100):
        xs = sample(range(100), randint(0, 100))
        f(xs)
    print(f"100 tests for {f} passed.")

if __name__ == "__main__":
    test(prop_order)
    test(prop_insert)
    test(prop_insert1)
    test(prop_lookup)
    test(prop_binary_lookup)
    test(prop_delete)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.heapfirstksums978
    set output_file "main.py"

    set template_content '
import random
import heapq

# method 1:
#   use binary heap (heapq in python lib)

# method 2:
#   use young tableau

class lazy_yong_tableau:
    def __init__(self, xs, ys):
        self.young = {}
        self.c = lambda i, j: xs[i]+ys[j]
        self.size = (len(xs), len(ys))
        self.infinity = xs[-1]+ys[-1]+1000

    def get(self, i, j):
        if (i,j) not in self.young:
            self.young[(i, j)]=self.c(i, j)
        return self.young[(i,j)]

    def set(self, i, j, x):
        self.young[(i, j)]=x
    
    def swap(self, i1, j1, i2, j2):
        x = self.get(i1, j1)
        y = self.get(i2, j2)
        self.set(i1, j1, y)
        self.set(i2, j2, x)

def young_pop(young):
    x = young.get(0, 0)
    young.set(0, 0, young.infinity)
    youngify(young, 0, 0)
    return x

def youngify(young, i, j):
    (m, n) = young.size
    while True:
        (min_i, min_j)=(i, j)
        if i+1 < m and young.get(i, j) > young.get(i+1, j):
            (min_i, min_j) = (i+1, j)
        if j+1 < n and young.get(min_i, min_j) > young.get(i, j+1):
            (min_i, min_j) = (i, j+1)
        if (min_i, min_j) != (i, j):
            young.swap(i, j, min_i, min_j)
            (i, j) = (min_i, min_j)
        else:
            break

def ksum_ytab(k, xs, ys):
    young = lazy_yong_tableau(xs, ys)
    res=[]
    for i in range(k):
        res.append(young_pop(young))
    return res

def ksum_heapq(k, xs, ys):
    res = []
    heap = [(x+ys[0], 0) for x in xs]
    heapq.heapify(heap)
    for _ in xrange(len(ys)):
        v, i = heapq.heappop(heap)
        res.append(v)
        if i+1<len(ys):
            heapq.heappush(heap, (v-ys[i]+ys[i+1], i+1))
    return res[:k]

def orderred_insert_by(f, lst, p):
    for i in range(len(lst)):
        if p == lst[i]:
            return
        if f(lst[i])>f(p):
            lst.insert(i, p)
            return
    lst.append(p)

def ksum_foo(k, xs, ys):
    c=lambda (i, j): xs[i]+ys[j]
    res = []
    q = [(0, 0)]
    while len(res)<k and q!=[]:
        (i, j)=q.pop(0)
        res.append(c((i, j)))
        if i+1<len(xs):
            orderred_insert_by(c, q, (i+1, j))
        if j+1<len(ys):
            orderred_insert_by(c, q, (i, j+1))
    return res[:k] 

# testing for verification

def brute_force(k, xs, ys):
    res= [x+y for x in xs for y in ys]
    res.sort()
    return res[:k]

def test():
    for i in range(10):
        n= random.randint(1, 1000)
        k = random.randint(1, n)
        a = random.sample(range(10000), n)
        a.sort()
        b = random.sample(range(10000), n)
        b.sort()
        if ksum_heapq(k, a, b) != brute_force(k, a, b):
            print "fail!" 
            print "a=", a
            print "b=", b
            print "k=", k
            print "brute-force:", brute_force(k, a, b)
            print "ksum:", ksum_heapq(k, a, b)
            return
    print "OK"

if __name__ == "__main__":
    test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.binomialheap979
    set output_file "main.py"

    set template_content '
import random # for testing only

# Assume the heap is min-heap

# Use left child, right sibling approach
class BinomialTree:
    def __init__(self, x = None):
        self.rank = 0
        self.key = x
        self.parent = None
        self.subtrees = None
        self.sibling = None

def remove_first(h):
    next = h.sibling
    h.sibling = None
    return next

def link(t1, t2):
    assert(t1.rank == t2.rank)
    if t2.key < t1.key:
        (t1, t2) = (t2, t1)
    t2.sibling = t1.subtrees
    t1.subtrees = t2
    t2.parent = t1
    t1.rank = t1.rank + 1
    return t1

def insert_tree(h, t):
    h1 = prev = BinomialTree()
    while h and h.rank <= t.rank:
        t1 = h
        h = h.sibling
        if t.rank == t1.rank:
            t = link(t, t1)
        else:
            prev.sibling = t1
            prev = t1
    prev.sibling = t
    t.sibling = h
    return remove_first(h1)

def insert(h, x):
    return insert_tree(h, BinomialTree(x))

def merge(h1, h2):
    h = prev = BinomialTree()
    while h1 and h2:
        if h1.rank < h2.rank:
            prev.sibling = h1
            prev = prev.sibling
            h1 = h1.sibling
        elif h2.rank < h1.rank:
            prev.sibling = h2
            prev = prev.sibling
            h2 = h2.sibling
        else:
            (t1, t2) = (h1, h2)
            (h1, h2) = (h1.sibling, h2.sibling)
            h1 = insert_tree(h1, link(t1, t2))
    if h1:
        prev.sibling = h1
    if h2:
        prev.sibling = h2
    return remove_first(h)

def reverse(h):
    prev = None
    while h:
        x = h
        h = h.sibling
        x.sibling = prev
        prev = x
    return prev

# Extract the minimum binomial tree from the heap
# returns (min tree, rest trees)
def extract_min(h):
    head = h
    (prev_min, min_t) = (None, None)
    prev = None
    while h:
        if min_t is None or h.key < min_t.key:
            min_t = h
            prev_min = prev
        prev = h
        h = h.sibling
    if prev_min:
        prev_min.sibling = min_t.sibling
    else:
        head = min_t.sibling
    min_t.sibling = None
    return (min_t, head)

def top(h):
    m = None
    while h:
        m = min(m, h.key) if m else h.key
        h = h.sibling
    return m

# Extract the min element, returns the (min, h)
def pop(h):
    (min_t, h) = extract_min(h)
    h = merge(h, reverse(min_t.subtrees))
    min_t.subtrees = None
    return (min_t.key, h)

def decrease_key(x, k):
    assert(k < x.key)
    x.key = k
    p = x.parent
    while p and x.key < p.key:
        (x.key, p.key) = (p.key, x.key)
        x = p
        p = p.parent

# A reference implementation for delete node:
# function delete_node(h, x)
#   decrease_key(x, -infinity)
#   (_, h) = pop(h)
#   return

def from_list(xs):
    t = None
    for x in xs:
        t = insert(t, x)
    return t

def heap_sort(lst):
    h = from_list(lst)
    res = []
    while h:
        (x, h) = pop(h)
        res.append(x)
    return res

def to_string(h):
    s = ""
    while h:
        s = s+ "(" + str(h.key)+", "+to_string(h.subtrees)+"), "
        h = h.sibling
    return s

# Auxiliary function to find a node contains specified
# key in the heap. This is an inefficent function only
# for verification purpose
def find_key(h, k):
    while h:
        if h.key == k:
            return h
        else:
            n = find_key(h.subtrees, k)
            if n:
                return n
        h = h.sibling
    return None

def decrease_key_from(h, k1, k2):
    decrease_key(find_key(h, k1), k2)

class TestHeap:
    def __init__(self):
        print("Binomial heap testing")

    def run(self):
        self.test_insert()
        self.test_extract_min()
        self.test_heap_sort()
        self.test_random_sort()
        self.test_heap_decrease_key()

    def __assert(self, p):
        if p:
            print("OK")
        else:
            print("Fail!")

    def test_insert(self):
        l = [16, 14, 10, 8, 7, 9, 3, 2, 4, 1]
        print("insert", l, "=", to_string(from_list(l)))

    def test_extract_min(self):
        print("text extract min")
        l = [16, 14, 10, 8, 7, 9, 3, 2, 4, 1]
        h = from_list(l)
        (t, h) = pop(h)
        print("t=", t)
        print("h=", to_string(h))

    def test_heap_sort(self):
        l = [16, 14, 10, 8, 7, 9, 3, 2, 4, 1]
        res = heap_sort(l)
        print("test heap sort:", res)
        assert(res == [1, 2, 3, 4, 7, 8, 9, 10, 14, 16])

    def test_random_sort(self):
        print("test random sort")
        n = 1000
        for i in range(100):
            lst = random.sample(range(n), random.randint(1, n))
            assert(heap_sort(lst) == sorted(lst))
        print("OK")

    def test_heap_decrease_key(self):
        print("test decrease key")
        n = 1000
        for i in range(100):
            lst = random.sample(range(n), random.randint(1, n))
            h = from_list(lst)
            x = random.choice(lst)
            y = x - random.randint(0, x) - 1
            decrease_key_from(h, x, y)
            res = []
            while h:
                (e, h) = pop(h)
                res.append(e)
            lst[lst.index(x)] = y
            assert(res == sorted(lst))
        print("OK")

if __name__ == "__main__":
    TestHeap().run()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.binomialheap980
    set output_file "main.py"

    set template_content '
import random # for testing only

class BinomialTree:
    def __init__(self, x = None):
        self.rank = 0
        self.key = x
        self.parent = None
        self.children = []
     
def link(t1, t2):
    if t2.key < t1.key:
        (t1, t2) = (t2, t1)
    t2.parent = t1
    t1.children.insert(0, t2)
    t1.rank = t1.rank + 1
    return t1


def insert_tree(ts, t):
    while ts !=[] and t.rank == ts[0].rank:
        t = link(t, ts.pop(0))
    ts.insert(0, t)
    return ts


def insert(h, x):
    return insert_tree(h, BinomialTree(x))


def append_tree(ts, t):
    if ts != [] and ts[-1].rank == t.rank:
        ts[-1] = link(ts[-1], t)
    else:
        ts.append(t)
    return ts


def append_trees(ts1, ts2):
    return reduce(append_tree, ts2, ts1)

# Merge 2 heaps together. Use a merge sort like approach
def merge(ts1, ts2):
    if ts1 == []:
        return ts2
    if ts2 == []:
        return ts1
    ts = []
    while ts1 != [] and ts2 != []:
        t = None
        if ts1[0].rank < ts2[0].rank:
            t = ts1.pop(0)
        elif ts2[0].rank < ts1[0].rank:
            t = ts2.pop(0)
        else:
            t = link(ts1.pop(0), ts2.pop(0))
        ts = append_tree(ts, t)
    ts = append_trees(ts, ts1)
    ts = append_trees(ts, ts2)
    return ts


def remove_min_tree(ts):
    min_t = min(ts, key=lambda t: t.key)
    ts.remove(min_t)
    return (min_t, ts)    

# Assume ts is not empty
def find_min(ts):
    min_t = min(ts, key=lambda t: t.key)
    return min_t.key

# Extract the min element, returns the (min, heap)
def extract_min(ts):
    (min_t, ts) = remove_min_tree(ts)
    min_t.children.reverse()
    ts = merge(ts, min_t.children)
    min_t.children = []
    return (min_t.key, ts)


def decrease_key(x, k):
    assert(k < x.key)
    x.key = k
    p = x.parent
    while p is not None and x.key < p.key:
        (x.key, p.key) = (p.key, x.key)
        x = p
        p = p.parent

# Delete node is trivial so I skip it in this program
# A reference implementation:
# function delete_node(h, x)
#   decrease_key(x, -infinity)
#   (_, h) = extract_min(h)
#   return h

# helper function
def from_list(lst):
    return reduce(insert, lst, [])

def heap_sort(lst):
    h = from_list(lst)
    res = []
    while h != []:
        (x, h) = extract_min(h)
        res.append(x)
    return res

def to_string(ts):
    s = ""
    for t in ts:
        s = s+ "(" + str(t.key)
        if t.children != []:
            s = s + ", " + to_string(t.children)
        s = s+ ")"
    return s


def find_key(ts, k):
    for t in ts:
        if t.key == k:
            return t
        else:
            n = find_key(t.children, k)
            if n is not None:
                return n
    return None

def decrease_key_from(ts, k1, k2):
    decrease_key(find_key(ts, k1), k2)

class TestHeap:
    def __init__(self):
        print "Binomial heap testing"

    def run(self):
        self.test_insert()
        self.test_heap_sort()
        self.test_random_sort()
        self.test_heap_decrease_key()
        self.test_heap_decrease_key_random()

    def test_insert(self):
        l = [16, 14, 10, 8, 7, 9, 3, 2, 4, 1]
        print to_string(from_list(l))

    def test_heap_sort(self):
        # CLRS Figure 6.4
        l = [16, 14, 10, 8, 7, 9, 3, 2, 4, 1]
        res = heap_sort(l)
        print res
        assert(res == [1, 2, 3, 4, 7, 8, 9, 10, 14, 16])

    def test_random_sort(self):
        n = 1000
        for i in range(100):
            lst = random.sample(range(n), random.randint(1, n))
            assert(heap_sort(lst) == sorted(lst))
        print "OK"
        
    def test_heap_decrease_key(self):
        l = [16, 14, 10, 8, 7, 9, 3, 2, 4, 1]
        h = from_list(l)
        decrease_key_from(h, 8, 6)
        res = []
        while h!=[]:
            (x, h) = extract_min(h)
            res.append(x)
        assert(res == [1, 2, 3, 4, 6, 7, 9, 10, 14, 16])

    def test_heap_decrease_key_random(self):
        n = 1000
        for i in range(100):
            lst = random.sample(range(n), random.randint(1, n))
            h = from_list(lst)
            x = random.choice(lst)
            y = x - random.randint(0, x) - 1
            decrease_key_from(h, x, y)
            res = []
            while h != []:
                (e, h) = extract_min(h)
                res.append(e)
            lst[lst.index(x)] = y
            assert(res == sorted(lst))
        print "OK"

if __name__ == "__main__":
    TestHeap().run()

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.bheap981
    set output_file "main.py"

    set template_content '
MIN_HEAP = lambda a, b: a < b
MAX_HEAP = lambda a, b: a > b

# auxiliary functions

def parent(i):
    return (i+1)//2-1

def left(i):
    return  2*i+1

def right(i):
    return 2*(i+1)

# min-heapify by default
def heapify(x, i, less_p = MIN_HEAP):
    n = len(x)
    while True:
        l = left(i)
        r = right(i)
        smallest = i
        if l < n and less_p(x[l], x[i]):
            smallest = l
        if r < n and less_p(x[r], x[smallest]):
            smallest = r
        if smallest != i:
            (x[i], x[smallest])=(x[smallest], x[i])
            i  = smallest
        else:
            break

# build min heap by default
def build_heap(x, less_p = MIN_HEAP):
    n = len(x)
    for i in reversed(range(n//2)):
        heapify(x, i, less_p)

def heap_top(x):
    return x[0] #ignore empty case

# default apply to min-heap
def heap_pop(x, less_p = MIN_HEAP):
    top = heap_top(x)
    x[0] = x[-1] # this is faster than top = x.pop(0)
    x.pop()
    if x!=[]:
        heapify(x, 0, less_p)
    return top

# default heap sort less to greater
def heap_sort(x, less_p = MIN_HEAP):
    res = []
    build_heap(x, less_p)
    while x!=[]:
        res.append(heap_pop(x, less_p))
    return res

# decrease key in min-heap by default
def heap_decrease_key(x, i, key, less_p = MIN_HEAP):
    if less_p(key, x[i]):
        x[i] = key
        heap_fix(x, i, less_p)

# insert a key to min-heap by default
def heap_insert(x, key, less_p = MIN_HEAP):
    i = len(x)
    x.append(key)
    heap_fix(x, i, less_p)

def heap_fix(x, i, less_p = MIN_HEAP):
    while i>0 and less_p(x[i],x[parent(i)]):
        (x[parent(i)], x[i]) = (x[i], x[parent(i)])
        i = parent(i)

def top_k(x, k, less_p = MIN_HEAP):
    build_heap(x, less_p)
    return [heap_pop(x, less_p) for _ in range(min(k, len(x)))]

class TestHeap:
    def __init__(self):
        print "Implicit binary heap by array testing"

    def run(self):
        self.test_heapify()
        self.test_build_heap()
        self.test_heap_sort()
        self.test_heap_decrease_key()
        self.test_heap_insert()
        self.test_top_k()

    def __assert(self, p):
        if p:
            print "OK"
        else:
            print "Fail!"

    def test_heapify(self):
        # CLRS Figure 6.2
        l = [16, 4, 10, 14, 7, 9, 3, 2, 8, 1]
        heapify(l, 1, MAX_HEAP)
        print l
        self.__assert(l == [16, 14, 10, 8, 7, 9, 3, 2, 4, 1])

    def test_build_heap(self):
        # CLRS Figure 6.3
        l = [4, 1, 3, 2, 16, 9, 10, 14, 8, 7]
        build_heap(l, MAX_HEAP)
        print l
        self.__assert(l == [16, 14, 10, 8, 7, 9, 3, 2, 4, 1])

    def test_heap_sort(self):
        # CLRS Figure 6.4
        l = [16, 14, 10, 8, 7, 9, 3, 2, 4, 1]
        res = heap_sort(l)
        print res
        self.__assert(res == [1, 2, 3, 4, 7, 8, 9, 10, 14, 16])

    def test_heap_decrease_key(self):
        # CLRS Figure 6.5
        l = [16, 14, 10, 8, 7, 9, 3, 2, 4, 1]
        heap_decrease_key(l, 8, 15, MAX_HEAP)
        print l
        self.__assert(l == [16, 15, 10, 14, 7, 9, 3, 2, 8, 1])

    def test_heap_insert(self):
        l = [16, 14, 10, 8, 7, 9, 3, 2, 4, 1]
        heap_insert(l, 17, MAX_HEAP)
        print l
        self.__assert(l == [17, 16, 10, 8, 14, 9, 3, 2, 4, 1, 7])

    def test_top_k(self):
        l = [4, 1, 3, 2, 16, 9, 10, 14, 8, 7]
        res = top_k(l, 3, MAX_HEAP)
        print res
        self.__assert(res == [16, 14, 10])

if __name__ == "__main__":
    TestHeap().run()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.leftsheap982
    set output_file "main.py"

    set template_content '
from random import sample, randint

class Node:
    def __init__(self, value, rank = 1, left = None, right = None, parent = None):
        self.value = value
        self.rank = rank
        self.left = left
        self.right = right
        self.parent = parent

def rank(x):
    return x.rank if x else 0

def merge(a, b):
    h = Node(None)  # the sentinel node
    while a and b:
        if b.value < a.value:
            a, b = b, a
        c = Node(a.value, parent = h, left = a.left)
        h.right = c
        h = c
        a = a.right
    h.right = a if a else b
    while h.parent:
        if rank(h.left) < rank(h.right):
            h.left, h.right = h.right, h.left
        h.rank = 1 + rank(h.right)
        h = h.parent
    h = h.right
    if h:
        h.parent = None
    return h

def insert(h, x):
    return merge(Node(x), h)

def top(h):
    return h.value

def pop(h):
    return h.value, merge(h.left, h.right)

def fromlist(xs):
    h = None
    for x in xs:
        h = insert(h, x)
    return h

def hsort(xs):
    h = fromlist(xs)
    ys = []
    while h:
        y, h = pop(h)
        ys.append(y)
    return ys

def test(f):
    for _ in range(100):
        xs = sample(range(100), randint(0, 100))
        f(xs)
    print(f"100 tests for {f} passed.")

def prop_heap(xs):
    h = fromlist(xs)
    if xs:
        a = top(h)
        b = min(xs)
        assert a == b, f"violate heap: top = {a}, min = {b}"

def prop_heapsort(xs):
    ys = hsort(xs)
    zs = sorted(xs)
    assert ys == sorted(xs), f"violate heap sort, xs = {xs}, ys = {ys}, zs = {zs}"

if __name__ == "__main__":
    test(prop_heap)
    test(prop_heapsort)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.skewheap983
    set output_file "main.py"

    set template_content '
from random import sample, randint

class Node:
    def __init__(self, value, left = None, right = None):
        self.value = value
        self.left = left
        self.right = right

def merge(a, b):
    h = Node(None)  # the sentinel node
    root = h
    while a and b:
        if b.value < a.value:
            a, b = b, a
        c = Node(a.value, left = None, right = a.left)
        h.left = c
        h = c
        a = a.right
    h.left = a if a else b
    root = root.left
    return root

def insert(h, x):
    return merge(Node(x), h)

def top(h):
    return h.value

def pop(h):
    return merge(h.left, h.right)

def fromlist(xs):
    h = None
    for x in xs:
        h = insert(h, x)
    return h

def hsort(xs):
    h = fromlist(xs)
    ys = []
    while h:
        ys.append(top(h))
        h = pop(h)
    return ys

def test(f):
    for _ in range(100):
        xs = sample(range(100), randint(0, 100))
        f(xs)
    print(f"100 tests for {f} passed.")

def prop_heap(xs):
    h = fromlist(xs)
    if xs:
        a = top(h)
        b = min(xs)
        assert a == b, f"violate heap: top = {a}, min = {b}"

def prop_heapsort(xs):
    ys = hsort(xs)
    zs = sorted(xs)
    assert ys == sorted(xs), f"violate heap sort, xs = {xs}, ys = {ys}, zs = {zs}"

if __name__ == "__main__":
    test(prop_heap)
    test(prop_heapsort)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.fingertree984
    set output_file "main.py"

    set template_content '

import random

# As there is no fold-right in python
def foldR(f, xs, z):
    for x in reversed(xs):
        z = f(x, z)
    return z

# definition
class Node:
    def __init__(self, s, xs, lf = False):
        self.size = s
        self.children = xs
        self.leaf = lf

    def str(self):
        if self.leaf:
            return ", ".join([str(x) for x in self.children])
        else:
            return "(" + ", ".join([x.str() for x in self.children]) + ")"

class Tree:
    def __init__(self, s = 0, f = [], m = None, r = [], p = None):
        self.size = s
        self.front = f
        self.mid = m
        self.rear = r
        self.parent = p
        if m is not None:
            m.parent = self

    def set_mid(self, t):
        self.mid = t
        if t is not None:
            t.parent = self

    def empty(self):
        return self.size == 0

    # for debugging purpose only
    def str(self):
        if self.empty():
            return "."
        else:
            return "{" + ns2str(self.front) + " " +  tr2str(self.mid) + " "+ ns2str(self.rear) + "}"

# Auxiliary functions for debugging

def ns2str(ns):
    return "[" + ", ".join([n.str() for n in ns]) + "]"

def tr2str(t):
    return "." if t is None else t.str()

# Helper functions

# calculate the size for a list of nodes
def sizeNs(xs):
    return sum(map(lambda x: x.size, xs))

# calculate the size for a tree
def sizeT(t):
    if t is None:
        return 0 
    else: 
        return t.size

# wrap an element to a node
def wrap(x):
    return Node(1, [x], True)

# return the singleton element in a node
def elem(n):
    assert n.leaf
    return n.children[0]

# wraps a list of nodes (<= 3) to a big node
def wraps(xs):
    return Node(sizeNs(xs), xs)

# create a leaf contains only one node
def leaf(x):
    return Tree(x.size, [x], None, [])

# wrap a list of nodes (>3) to a list of big nodes
def nodes(xs):
    res = []
    while len(xs) > 4:
        res.append(wraps(xs[:3]))
        xs = xs[3:]
    if len(xs) == 4:
        res.append(wraps(xs[:2]))
        res.append(wraps(xs[2:]))
    elif xs != []:
        res.append(wraps(xs))
    return res

# test if the front finger is full, which cant afford any more nodes
def frontFull(t):
    return t is not None and len(t.front) >= 3

# test if the rear finger is full, which cant afford any more modes
def rearFull(t):
    return t is not None and len(t.rear) >= 3

def isBranch(t):
    return t is not None and t.front !=  [] and t.rear != []

# remove unused senitels if there are
def flat(t):
    while t is not None and t.empty():
        t = t.mid
    if t is not None:
        t.parent = None
    return t

def insert(x, t):
    return prepend_node(wrap(x), t)

# inserting a node in single-pass manner
def prepend_node(n, t):
    root = prev = Tree()
    prev.set_mid(t)
    while frontFull(t):
        f = t.front
        t.front = [n] + f[:1]
        t.size = t.size + n.size
        n = wraps(f[1:])
        prev = t
        t = t.mid
    if t is None:
        t = leaf(n)
    elif len(t.front)==1 and t.rear == []:
        t = Tree(n.size + t.size, [n], None, t.front)
    else:
        t = Tree(n.size + t.size, [n]+t.front, t.mid, t.rear)
    prev.set_mid(t)
    return flat(root)

# extract the first element from tree
# assume t is not empty
# capable to handle illed form (due to deletion or splitting)
def extract_head(t):
    root = Tree()
    root.set_mid(t)
    while t.front == [] and t.mid is not None:
        t = t.mid
    if t.front == [] and t.rear != []:
        (t.front, t.rear) = (t.rear, t.front)
    n = wraps(t.front)
    while True: # a repeat-until loop
        ns = n.children
        n = ns[0]
        t.front = ns[1:]
        t.size = t.size - n.size
        t = t.parent
        if t.mid.empty():
            t.mid.parent = None
            t.mid = None
        if n.leaf:
            break
    return (elem(n), flat(root))

# return the first element without removing it
def first(t):
    return elem(first_leaf(t))

def first_leaf(t):
    while t.front == [] and t.mid is not None:
        t = t.mid
    if t.front == [] and t.rear != []:
        n = t.rear[0]
    else:
        n = t.front[0]
    while not n.leaf:
        n = n.children[0]
    return n

# Note this will mutate t.
def tail(t):
    (_, t) = extract_head(t)
    return t

def append(t, x):
    return append_node(t, wrap(x))

def append_node(t, n):
    root = prev = Tree()
    prev.set_mid(t)
    while rearFull(t):
        r = t.rear
        t.rear = r[-1:] + [n]
        t.size = t.size + n.size
        n = wraps(r[:-1])
        prev = t
        t = t.mid
    if t is None:
        t = leaf(n)
    elif len(t.rear) == 1 and t.front == []:
        t = Tree(n.size + t.size, t.rear, None, [n])
    else:
        t = Tree(n.size + t.size, t.front, t.mid, t.rear + [n])
    prev.set_mid(t)
    return flat(root)

# extract the last element from tree
# assume t is not empty
# capable to handle illed-form (due to deletion or splitting)
def extract_tail(t):
    root = Tree()
    root.set_mid(t)
    while t.rear == [] and t.mid is not None:
        t = t.mid
    if t.rear == [] and t.front != []:
        (t.front, t.rear) = (t.rear, t.front)
    n = wraps(t.rear)
    while True: # a repeat-until loop
        ns = n.children
        n = ns[-1]
        t.rear = ns[:-1]
        t.size = t.size - n.size
        t = t.parent
        if t.mid.empty():
            t.mid.parent = None
            t.mid = None
        if n.leaf:
            break
    return (elem(n), flat(root))

# return the last element without removing it.
def last(t):
    while t.rear == [] and t.mid is not None:
        t = t.mid
    if t.rear ==[] and t.front != []:
        n = t.front[-1]
    else:
        n = t.rear[-1]
    while not n.leaf:
        n = n.children[-1]
    return elem(n)

# Note this will mutate the tree
def init(t):
    (_, t) = extract_tail(t)
    return t

# Note this will mutate t1 and t2
def concat(t1, t2):
    return merge(t1, [], t2)

def merge(t1, ns, t2):
    root = prev = Tree() #sentinel dummy tree
    while t1 is not None and t2 is not None:
        t = Tree(t1.size + t2.size + sizeNs(ns), t1.front, None, t2.rear)
        prev.set_mid(t)
        prev = t
        ns = nodes(t1.rear + ns + t2.front)
        t1 = t1.mid
        t2 = t2.mid
    if t1 is None:
        prev.set_mid(foldR(prepend_node, ns, t2))
    elif t2 is None:
        prev.set_mid(reduce(append_node, ns, t1))
    return flat(root)

def getAt(t, i):
    return applyAt(t, i, lambda x : x) # applying id function

def setAt(t, i, x):
    return applyAt(t, i, lambda y : x)

# apply function f to the element at i position
# return the original element before applying f
def applyAt(t, i, f):
    while t.size > 1:
        szf = sizeNs(t.front)
        szm = sizeT(t.mid)
        if i < szf:
            return lookupNs(t.front, i, f)
        elif i < szf + szm:
            t = t.mid
            i = i - szf
        else:
            return lookupNs(t.rear, i - szf - szm, f)
    n = first_leaf(t)
    x = elem(n)
    n.children[0] = f(x)
    return x

# lookup in a list of node for position i, and 
# apply function f to the element
# return the original element before applying f
def lookupNs(ns, i, f):
    while True:
        for n in ns:
            if n.leaf and i == 0:
                x = elem(n)
                n.children[0] = f(x)
                return x
            if i < n.size:
                ns = n.children
                break
            i = i - n.size

def szf(t):
    return sizeNs(t.front)

def szm(t):
    return sizeT(t.mid)

# split(t, i) ==> (t1, x, t2)
def splitAt(t, i):
    # top-down pass
    (t1, t2) = (Tree(), Tree())
    while szf(t) <= i and i < szf(t) + szm(t):
        fst = Tree(0, t.front, None, [])
        snd = Tree(0, [], None, t.rear)
        t1.set_mid(fst)
        t2.set_mid(snd)
        (t1, t2) = (fst, snd)
        i = i - szf(t)
        t = t.mid

    if i < szf(t):
        (xs, n, ys) = splitNs(t.front, i)
        sz = t.size - sizeNs(xs) - n.size
        (fst, snd) = (fromNodes(xs), Tree(sz, ys, t.mid, t.rear))
    elif szf(t) + szm(t) <= i:
        (xs, n, ys) = splitNs(t.rear, i - szf(t) - szm(t))
        sz = t.size - sizeNs(ys) - n.size
        (fst, snd) = (Tree(sz, t.front, t.mid, xs), fromNodes(ys))
    t1.set_mid(fst)
    t2.set_mid(snd)

    # bottom-up pass
    i = i - sizeT(fst)
    while not n.leaf:
        (xs, n, ys) = splitNs(n.children, i)
        i = i - sizeNs(xs)
        (t1.rear, t2.front) = (xs, ys)
        t1.size = sizeNs(t1.front) + sizeT(t1.mid) + sizeNs(t1.rear)
        t2.size = sizeNs(t2.front) + sizeT(t2.mid) + sizeNs(t2.rear)
        (t1, t2) = (t1.parent, t2.parent)

    return (flat(t1), elem(n), flat(t2))

def splitNs(ns, i):
    for j in range(len(ns)):
        if i < ns[j].size:
            return (ns[:j], ns[j], ns[j+1:])
        i = i - ns[j].size

def removeAt(t, i):
    (t1, x, t2) = splitAt(t, i)
    return (x, concat(t1, t2))

# Auxiliary functions for verification

def fromListR(xs):
    return foldR(insert, xs, None)

def toListR(t):
    xs = []
    while t is not None:
        (x, t) = extract_head(t)
        xs.append(x)
    return xs

def fromListL(xs):
    return reduce(append, xs, None)

def toListL(t):
    xs = []
    while t is not None:
        (x, t) = extract_tail(t)
        xs.insert(0, x)
    return xs

def fromNodes(ns):
    return foldR(prepend_node, ns, None)

def __assert(xs, ys):
    if xs != ys:
        print "assertion failed!"
        print xs
        print ys
        quit()

def test_rebuild():
    for i in range(100):
        xs = range(i)
        assert toListR(fromListR(xs)) == xs
        assert toListR(fromListL(xs)) == xs
        assert toListL(fromListR(xs)) ==xs
        assert toListL(fromListL(xs)) == xs
    print "rebuild tested"

def test_concat():
    m = 100
    for i in range(m):
        xs = random.sample(range(m), random.randint(0, m))
        ys = random.sample(range(m), random.randint(0, m))
        assert toListR(concat(fromListR(xs), fromListR(ys))) == (xs + ys)
    print "concat tested"

def test_random_access():
    xs = range(100)
    t = fromListR(xs)
    ys = [getAt(t, i) for i in xs]
    assert xs == ys
    [setAt(t, i, 99 - xs[i]) for i in xs]
    ys = [getAt(t, i) for i in xs]
    xs.reverse()
    __assert(xs, ys)
    print "random access tested"

def test_split():
    for i in range(100):
        lst = range(100)
        (xs, y, ys) = (lst[:i], lst[i], lst[i+1:])
        t = fromListR(lst)
        (t1, x, t2) = splitAt(t, i)
        __assert(xs, toListR(t1))
        __assert(ys, toListR(t2))
        assert(x == y)
    print "split tested"

def test_remove():
    m = 100
    for _ in range(100):
        xs = random.sample(range(m), random.randint(1, m))
        i = random.randint(0, len(xs)-1)
        (y, t) = removeAt(fromListR(xs), i)
        (x, ys) = (xs[i], xs[:i] + xs[i+1:])
        __assert(ys, toListR(t))
        assert y == x

if __name__ == "__main__":
    test_rebuild()
    test_concat()
    test_random_access()
    test_split()
    test_remove()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.AVLRingePrinter985
    set output_file "main.py"

    set template_content '
import math
count = 0
class AVLNode:
     def __init__(self, data, balanceFactor, left, right):
         self.data = data
         self.balanceFactor = 0
         self.left = left
         self.right = right

class AVLTree:
     def __init__(self):
         self.root = None

     def inOrderPrint(self):
         self.recInOrderPrint(self.root)

     def recInOrderPrint(self, root):
         if root != None:
              self.recInOrderPrint(root.left)
              print root.data
              self.recInOrderPrint(root.right)

     def insert(self, data):
         newNode = AVLNode(data, 0, None, None)
         [self.root, taller] = self.recInsertAVL(self.root, newNode)

     def recInsertAVL(self, root, newNode):
         if root == None:
            root = newNode
            root.balanceFactor = 0
            taller = True
         elif newNode.data < root.data:
                [root.left, taller] = self.recInsertAVL(root.left, newNode)
                if taller:
                    if root.balanceFactor == 0 :   
                        root.balanceFactor = -1
                    elif root.balanceFactor == 1:  
                        root.balanceFactor = 0
                        taller = False
                    else:
                        root = self.rightLeftRotate(root)
                        taller = False
         else :
               [root.right, taller] = self.recInsertAVL(root.right, newNode)
               if taller:
                    if root.balanceFactor == -1:
                        root.balanceFactor = 0
                        taller = False
                    elif root.balanceFactor == 0 :   
                        root.balanceFactor = 1
                    else:   
                        root = self.rightLeftRotate(root) 
                        taller = False
         return [root, taller]


     def rightLeftRotate(self, root):
           X = root.right
           if X.balanceFactor == 1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleRightRoate(r)
           else:
               Y = X.left
               if Y.balanceFactor == -1:
                   root.balanceFactor = 0 
                   X.balanceFactor = 1
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0
               else:
                   root.balanceFactor = -1
                   X.balanceFactor = 0
               Y.balanceFactor = 0
               root.right = self.singleLeftRotate(X)
               root = self.singleRightRoate(root)
           return root

     def rightLeftRotate(self, root):
           X = root.left
           if X.balanceFactor == -1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleLeftRotate(root)
           else:
               Y = X.right
               if Y.balanceFactor == -1:
                   root.balanceFactor = 1
                   X.balanceFactor = 0
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0 
               else:    
                   root.balanceFactor = 0
                   X.balanceFactor = -1
               Y.balanceFactor = 0
               root.left = self.singleRightRoate(X)
               root = self.singleLeftRotate(root)
           return root


     def singleRightRoate(self, r):
         X = root.right
         root.right = X.left
         X.left = r
         return X

     def singleLeftRotate(self, root):
         W = root.left
         root.left = W.right
         W.right = root
         return W

     def height(self):
         return self.recHeight(self.root)
          
     def recHeight(self, root):
         if root == None:
             return 0
         else:
              leftH = self.recHeight(root.left)
              rightH = self.recHeight(root.right)
              if leftH > rightH:
                   return 1 + leftH
              else:
                   return 1 + rightH

def generateAVLTree(h):
	global count
	if(h <= 0): 
	    return None
	avlNode = AVLTree()   
	avlNode.root = avlNode
	avlNode.left = generateAVLTree(h - 1)
	avlNode.right = generateAVLTree(h - 1)
	avlNode.data = count
	count += 1
	return avlNode

def rangeCount(root, a, b):
	if root == None:
		return 0
	elif root.data > b:
		return rangeCount(root.left, a, b)
	elif root.data < a:
		return rangeCount(root.right, a, b)	
	elif root.data >= a and root.data <= b:
		return rangeCount(root.left, a, b) + rangeCount(root.right, a, b) + 1

def tester():
	avlNode = generateAVLTree(4)
	print rangeCount(avlNode, 2, 7)

if __name__ == '__main__':
	tester()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.AVLTree986
    set output_file "main.py"

    set template_content '
class AVLNode:
     def __init__(self, data, balanceFactor, left, right):
         self.data = data
         self.balanceFactor = 0
         self.left = left
         self.right = right

class AVLTree:
     def __init__(self):
         self.root = None

     def inOrderPrint(self):
         self.recInOrderPrint(self.root)

     def recInOrderPrint(self, root):
         if root != None:
              self.recInOrderPrint(root.left)
              print root.data
              self.recInOrderPrint(root.right)

     def insert(self, data):
         newNode = AVLNode(data, 0, None, None)
         [self.root, taller] = self.recInsertAVL(self.root, newNode)

     def recInsertAVL(self, root, newNode):
         if root == None:
            root = newNode
            root.balanceFactor = 0
            taller = True
         elif newNode.data < root.data:
                [root.left, taller] = self.recInsertAVL(root.left, newNode)
                if taller:
                    if root.balanceFactor == 0 :   
                        root.balanceFactor = -1
                    elif root.balanceFactor == 1:  
                        root.balanceFactor = 0
                        taller = False
                    else:
                        root = self.rightLeftRotate(root)
                        taller = False
         else :
               [root.right, taller] = self.recInsertAVL(root.right, newNode)
               if taller:
                    if root.balanceFactor == -1:
                        root.balanceFactor = 0
                        taller = False
                    elif root.balanceFactor == 0 :   
                        root.balanceFactor = 1
                    else:   
                        root = self.rightLeftRotate(root) 
                        taller = False
         return [root, taller]


     def rightLeftRotate(self, root):
           X = root.right
           if X.balanceFactor == 1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleRightRoate(r)
           else:
               Y = X.left
               if Y.balanceFactor == -1:
                   root.balanceFactor = 0 
                   X.balanceFactor = 1
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0
               else:
                   root.balanceFactor = -1
                   X.balanceFactor = 0
               Y.balanceFactor = 0
               root.right = self.singleLeftRotate(X)
               root = self.singleRightRoate(root)
           return root

     def rightLeftRotate(self, root):
           X = root.left
           if X.balanceFactor == -1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleLeftRotate(root)
           else:
               Y = X.right
               if Y.balanceFactor == -1:
                   root.balanceFactor = 1
                   X.balanceFactor = 0
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0 
               else:    
                   root.balanceFactor = 0
                   X.balanceFactor = -1
               Y.balanceFactor = 0
               root.left = self.singleRightRoate(X)
               root = self.singleLeftRotate(root)
           return root


     def singleRightRoate(self, r):
         X = root.right
         root.right = X.left
         X.left = r
         return X

     def singleLeftRotate(self, root):
         W = root.left
         root.left = W.right
         W.right = root
         return W

     def height(self):
         return self.recHeight(self.root)
          
     def recHeight(self, root):
         if root == None:
             return 0
         else:
              leftH = self.recHeight(root.left)
              rightH = self.recHeight(root.right)
              if leftH > rightH:
                   return 1 + leftH
              else:
                   return 1 + rightH

def tester():
    avl = AVLTree()
    
    data = [3, 1, 9, 6, 0, 11, 2, 5, 4]
    
    for i in range(len(data)):      
       avl.insert(data[i])
    avl.inOrderPrint()
    print "height = ", avl.height()

if __name__ == '__main__':
    tester()

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.AVLWithMinNodes987
    set output_file "main.py"

    set template_content '
import math
count = 0
class AVLNode:
     def __init__(self, data, balanceFactor, left, right):
         self.data = data
         self.balanceFactor = 0
         self.left = left
         self.right = right

class AVLTree:
     def __init__(self):
         self.root = None

     def inOrderPrint(self):
         self.recInOrderPrint(self.root)

     def recInOrderPrint(self, root):
         if root != None:
              self.recInOrderPrint(root.left)
              print root.data
              self.recInOrderPrint(root.right)

     def insert(self, data):
         newNode = AVLNode(data, 0, None, None)
         [self.root, taller] = self.recInsertAVL(self.root, newNode)

     def recInsertAVL(self, root, newNode):
         if root == None:
            root = newNode
            root.balanceFactor = 0
            taller = True
         elif newNode.data < root.data:
                [root.left, taller] = self.recInsertAVL(root.left, newNode)
                if taller:
                    if root.balanceFactor == 0 :   
                        root.balanceFactor = -1
                    elif root.balanceFactor == 1:  
                        root.balanceFactor = 0
                        taller = False
                    else:
                        root = self.rightLeftRotate(root)
                        taller = False
         else :
               [root.right, taller] = self.recInsertAVL(root.right, newNode)
               if taller:
                    if root.balanceFactor == -1:
                        root.balanceFactor = 0
                        taller = False
                    elif root.balanceFactor == 0 :   
                        root.balanceFactor = 1
                    else:   
                        root = self.rightLeftRotate(root) 
                        taller = False
         return [root, taller]


     def rightLeftRotate(self, root):
           X = root.right
           if X.balanceFactor == 1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleRightRoate(r)
           else:
               Y = X.left
               if Y.balanceFactor == -1:
                   root.balanceFactor = 0 
                   X.balanceFactor = 1
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0
               else:
                   root.balanceFactor = -1
                   X.balanceFactor = 0
               Y.balanceFactor = 0
               root.right = self.singleLeftRotate(X)
               root = self.singleRightRoate(root)
           return root

     def rightLeftRotate(self, root):
           X = root.left
           if X.balanceFactor == -1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleLeftRotate(root)
           else:
               Y = X.right
               if Y.balanceFactor == -1:
                   root.balanceFactor = 1
                   X.balanceFactor = 0
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0 
               else:    
                   root.balanceFactor = 0
                   X.balanceFactor = -1
               Y.balanceFactor = 0
               root.left = self.singleRightRoate(X)
               root = self.singleLeftRotate(root)
           return root


     def singleRightRoate(self, r):
         X = root.right
         root.right = X.left
         X.left = r
         return X

     def singleLeftRotate(self, root):
         W = root.left
         root.left = W.right
         W.right = root
         return W

     def height(self):
         return self.recHeight(self.root)
          
     def recHeight(self, root):
         if root == None:
             return 0
         else:
              leftH = self.recHeight(root.left)
              rightH = self.recHeight(root.right)
              if leftH > rightH:
                   return 1 + leftH
              else:
                   return 1 + rightH

def generateAVLTree(h):
	global count
	if(h <= 0): 
	    return None
	avlNode = AVLTree()   
	avlNode.root = avlNode
	avlNode.left = generateAVLTree(h - 2)
	avlNode.right = generateAVLTree(h - 1)
	avlNode.data = count
	count += 1
	return avlNode

def isAVL(root):
	if root == None:
		return 0
	else:
		left = isAVL(root.left)
		if left == -1:
			return left
		right = isAVL(root.right)
		if(right == -1): 
			return right	
		if(abs(left - right) > 1) :
			return -1	
		return max(left, right) + 1

def tester():
	avlNode = generateAVLTree(4)
	avlNode.inOrderPrint()
	print "height = ", avlNode.height()	

if __name__ == '__main__':
	tester()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.AreMirrors988
    set output_file "main.py"

    set template_content '
def AreMirrors(root1, root2):
	if(root1 == None and root2 == None): 	
		return 1
	if(root1 == None or root2 == None): 
		return 0
	if(root1.data != root2.data): 	
		return 0
	else:
		return AreMirrors(root1.left, root2.right) and AreMirrors(root1.right, root2.left)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.AreStructurullySameTrees989
    set output_file "main.py"

    set template_content '
def areStructurullySameTrees(root1, root2):
	if (not root1.left) and not (root1.right) and (not root2.left) and \
		not (root2.right) and root1.data == root2.data:
		return True

	if (root1.data != root2.data) or (root1.left and not root2.left) or \
		(not root1.left and root2.left) or (root1.right and not root2.right) \
		or (not root1.right and root2.right): 
		return False

	left = areStructurullySameTrees(root1.left, root2.left) if root1.left and root2.left else True
	right = areStructurullySameTrees(root1.right, root2.right) if root1.right and root2.right else True
	return left and right
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.AugmentedTreesKthSmallest990
    set output_file "main.py"

    set template_content '
def KthSmallest (X, K):
     r = X.left.size + 1  # Assume size property is added to node
     if(K == r): 
          return X	
     if(K < r): 
          return KthSmallest (X.left, K)
     if(K > r): 
          return KthSmallest (X.right, K - r)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Bst991
    set output_file "main.py"

    set template_content '
class BSTNode:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    

root = BSTNode(3)
insertNode(root, BSTNode(7))
insertNode(root, BSTNode(1))
insertNode(root, BSTNode(5))
insertNode(root, BSTNode(2))
insertNode(root, BSTNode(9))
inOrderTraversal(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BSTDeletion992
    set output_file "main.py"

    set template_content '
class Node:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	""" return the minimum node in the current tree and its parent """
	# we use an ugly trick: the parent node is passed in as an argument
	# so that eventually when the leftmost child is reached, the 
	# call can return both the parent to the successor and the successor
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    

r = Node(3)
insertNode(r, Node(7))
insertNode(r, Node(1))
insertNode(r, Node(5))
insertNode(r, Node(2))
insertNode(r, Node(9))
print "in order:"
inOrderTraversal(r)
r = deleteNode(r, 9)
print "pre order"
preOrderTraversal(r)
r = deleteNode(r, 3)
print "pre order"
preOrderTraversal(r)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BSTFind993
    set output_file "main.py"

    set template_content '
def Find(self, root, data):
	currentNode = root
	while currentNode:
	    if data == currentNode.get_data():
		return currentNode
	    if key < currentNode.get_data():
		currentNode = currentNode.getLeft()
	    else:
		currentNode = currentNode.getRight()
	return None
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BSTFromSortedArray994
    set output_file "main.py"

    set template_content '
class Node:
 ''' class to represent a Node of BST/ linked list'''
 def __init__(self, data=None):
     self.data = data
     self.left = None
     self.right = None

def printBST(root):
	'''prints the BST in an inorder sequence'''
	if not root:
		return
	else:
		printBST(root.left)
		print root.data, " ",
		printBST(root.right)

def printList(head):
 '''prints the linked list in both directions
  to test whether both the 'next' and 'previous' pointers are fine'''
 # print forward direction
 h = head
 print '[%d]' % (h.data),
 h = h.right
 while h != head:
     print '[%d]' % (h.data),
     h = h.right

 print ""
 # print in reverse direction
 h = head.left
 print '[%d]' % (h.data),
 h = h.left
 while h != head.left:
     print '[%d]' % (h.data),
     h = h.left

def  BuildBST(A, left, right) :
	if(left > right): 
		return None
	newNode = Node()
	if(not newNode) :
		print("Memory Error") 
		return

	if(left == right):
		newNode.data = A[left]
		newNode.left = None
		newNode.right = None	
	else :	
		mid = left + (right - left) / 2
		newNode.data = A[mid] 
		newNode.left = BuildBST(A, left, mid - 1)
		newNode.right = BuildBST(A, mid + 1, right)	
	return newNode

if __name__ == "__main__":
	# create the sample BST
	A = [2, 3, 4, 5, 6, 7]
	root = BuildBST(A, 0, len(A) - 1)
	print "\ncreating BST"
	printBST(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.BSTInsertion995
    set output_file "main.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.left = None
        self.right = None
        self.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    

r = Node(3)
insertNode(r, Node(7))
insertNode(r, Node(1))
insertNode(r, Node(5))

print "in order:"
inOrderTraversal(r)

print "pre order"
preOrderTraversal(r)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BSTLeastCommonAncestors996
    set output_file "main.py"

    set template_content '
class Node:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    
    
def FindLCA(root, a, b):
	while(root):
		if((a <= root.data and b > root.data) or (a > root.data and b <= root.data)): 
			return root
		if(a < root.data):	
			root = root.left
		else: root = root.right


root = Node(3)
insertNode(root, Node(7))
insertNode(root, Node(1))
insertNode(root, Node(5))
insertNode(root, Node(2))
insertNode(root, Node(9))
print FindLCA(root, 2, 9).data
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BSTToDLL997
    set output_file "main.py"

    set template_content '
class Node:
 ''' class to represent a Node of BST/ linked list'''
 def __init__(self, data):
     self.data = data
     self.left = None
     self.right = None

def printBST(root):
 '''prints the BST in an inorder sequence'''
 if not root:
     return
 else:
     printBST(root.left)
     print root.data, " ",
     printBST(root.right)

def printList(head):
 if not head:
     return  
 if head: print head.data    
 # print forward direction
 h = head
 print '[%d]' % (h.data),
 h = h.right
 while h != head:
     print '[%d]' % (h.data),
     h = h.right

 print ""
 # print in reverse direction
 h = head.left
 print '[%d]' % (h.data),
 h = h.left
 while h != head.left:
     print '[%d]' % (h.data),
     h = h.left


def BSTToDLL(root):
	''' main function to take the root of the BST and return the head of the doubly linked list  '''
	prev = None
	head = None
	BSTToDoublyList(root, prev, head)
	return head

def BSTToDoublyList(root, prev, head):
	if (not root): return 

	BSTToDoublyList(root.left, prev, head)

	# current nodes left points to previous node
	root.left = prev
	if (prev):
		prev.right = root  # Previous nodes right points to current node
	else:
		head = root  # If previous is NULL that current node is head

	right = root.right  # Saving right node

	# Now we need to make list created till now as circular
	head.left = root
	root.right = head

	# For right-subtree/parent, current node is in-order predecessor
	prev = root
	BSTToDoublyList(right, prev, head)
   

if __name__ == "__main__":
 # create the sample BST
 root = a = Node(5)
 b = Node(3)
 c = Node(6)
 d = Node(2)
 e = Node(4)
 f = Node(7)

 a.left, a.right = b, c
 b.left, b.right = d, e
 c.right = f

 printBST(root)

 print "\ncreating to double linked list"
 head = BSTToDLL(root)
 printList(head)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BSTToDLLWithDivideAndConquer998
    set output_file "main.py"

    set template_content '
class Node:
 ''' class to represent a Node of BST/ linked list'''
 def __init__(self, data):
     self.data = data
     self.left = self
     self.right = self

def printBST(root):
 '''prints the BST in an inorder sequence'''
 if root.left == root or root.right == root:
     print root.data, " ",
 else:
     printBST(root.left)
     print root.data, " ",
     printBST(root.right)

def printList(head):
 '''prints the linked list in both directions
  to test whether both the 'next' and 'previous' pointers are fine'''
 # print forward direction
 h = head
 print '[%d]' % (h.data),
 h = h.right
 while h != head:
     print '[%d]' % (h.data),
     h = h.right

 print ""
 # print in reverse direction
 h = head.left
 print '[%d]' % (h.data),
 h = h.left
 while h != head.left:
     print '[%d]' % (h.data),
     h = h.left


def BSTToDLL(root):
 ''' main function to take the root of the BST and return the head of the doubly linked list  '''

 # for leaf Node return itself
 if root.left == root and root.right == root:
     return root

 elif root.left == root:  # no left subtree exist
     h2 = BSTToDLL(root.right)
     root.right = h2
     h2.left.right = root
     root.left = h2.left
     h2.left = root
     return root

 elif root.right == root:  # no right subtree exist
     h1 = BSTToDLL(root.left)
     root.left = h1.left
     h1.left.right = root
     root.right = h1
     h1.left = root
     return h1

 else:  # both left and right subtrees exist
     h1 = BSTToDLL(root.left)
     h2 = BSTToDLL(root.right)

     l1 = h1.left  # find last nodes of the lists
     l2 = h2.left

     h1.left = l2
     l2.right = h1

     l1.right = root
     root.left = l1

     root.right = h2
     h2.left = root
     return h1




if __name__ == "__main__":

 # create the sample BST
 root = a = Node(5)
 b = Node(3)
 c = Node(6)
 d = Node(2)
 e = Node(4)
 f = Node(7)

 a.left, a.right = b, c
 b.left, b.right = d, e
 c.right = f

 printBST(root)
 print "\ncreating to double linked list"
 head = BSTToDLL(root);
 printList(head)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinaryTree999
    set output_file "main.py"

    set template_content '
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	# get left child of a node
	def setLeft(self, left):
		self.left = left
	# get right child of a node
	def setRight(self, right):
		self.right = right
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	    
# Pre-order recursive traversal. The nodes values are appended to the result list in traversal order
def preorderRecursive(root, result):
    if not root:
        return
    
    result.append(root.data)
    preorderRecursive(root.left, result)
    preorderRecursive(root.right, result)

# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root, result):
	if not root:
		return

	inorderRecursive(root.left, result)
	result.append(root.data)
	inorderRecursive(root.right, result)

# Post-order recursive traversal. The nodes values are appended to the result list in traversal order
def postorderRecursive(root, result):
    if not root:
        return
    
    postorderRecursive(root.left, result)
    postorderRecursive(root.right, result)
    result.append(root.data)

# Pre-order iterative traversal. The nodes values are appended to the result list in traversal order
def preorderIterative(root, result):
    if not root:
        return

    stack = []
    stack.append(root)
    while stack:
        node = stack.pop()
        result.append(node.data)
        if node.right: stack.append(node.right)
        if node.left: stack.append(node.left)    

# In-order iterative traversal. The nodes values are appended to the result list in traversal order
def inorderIterative(root, result):
	if not root:
		return

	stack = []
	node = root
	while stack or node:
		if node:
			stack.append(node)
			node = node.left
		else:
			node = stack.pop()
			result.append(node.data)
			node = node.right

# Post-order iterative traversal. The nodes values are appended to the result list in traversal order
def postorderIterative(root, result):
    if not root:
        return

    visited = set()
    stack = []
    node = root
    while stack or node:
        if node:
            stack.append(node)
            node = node.left
        else:
            node = stack.pop()
            if node.right and not node.right in visited:
                stack.append(node)
                node = node.right
            else:
                visited.add(node)
                result.append(node.data)
                node = None
		
def levelOrder(root, result):
    if root is None:
      return
 
    q = Queue.Queue()
    q.put(self.root)
    n = None
 
    while not q.empty():
      n = q.get()  # dequeue FIFO
      result.append(node.get_data())
      if n.left is not None:
        q.put(n.left)
 
      if n.right is not None:
        q.put(n.right)	
	
root = BinaryTree(11)
print(root.get_data())

root.insertLeft(1)
root.insertLeft(10)
root.insertLeft(1100)
print(root.getLeft().get_data())
root.insertRight(5)
print(root.getRight().get_data())
root.getRight().set_data(2)
print(root.getRight().get_data())	
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BinaryTreeTraversals1000
    set output_file "main.py"

    set template_content '
class BinaryTree:
    def __init__(self, data):
        self.data = data  # root node
        self.left = None  # left child
        self.right = None  # right child
    # set data
    def set_data(self, data):
        self.data = data
    # get data   
    def get_data(self):
        return self.data	
    # get left child of a node
    def getLeft(self):
        return self.left
    # get right child of a node
    def getRight(self):
        return self.right

# Pre-order recursive traversal. The nodes values are appended to the result list in traversal order
def preorderRecursive(root, result):
    if not root:
        return
    
    result.append(root.data)
    preorderRecursive(root.left, result)
    preorderRecursive(root.right, result)

# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root, result):
	if not root:
		return

	inorderRecursive(root.left, result)
	result.append(root.data)
	inorderRecursive(root.right, result)

# Post-order recursive traversal. The nodes values are appended to the result list in traversal order
def postorderRecursive(root, result):
    if not root:
        return
    
    postorderRecursive(root.left, result)
    postorderRecursive(root.right, result)
    result.append(root.data)

# Pre-order iterative traversal. The nodes values are appended to the result list in traversal order
def preorderIterative(root, result):
    if not root:
        return
    stack = []
    stack.append(root)
    while stack:
        node = stack.pop()
        result.append(node.data)
        if node.right: stack.append(node.right)
        if node.left: stack.append(node.left)    

# In-order iterative traversal. The nodes values are appended to the result list in traversal order
def inorderIterative(root, result):
    if not root:
        return
    stack = []
    node = root
    while stack or node:
        if node:
            stack.append(node)
            node = node.left
        else:
            node = stack.pop()
            result.append(node.data)
            node = node.right

# Post-order iterative traversal. The nodes values are appended to the result list in traversal order
def postorderTraversal(root, result):
    result = []
    visited = set()
    stack = []
    if root != None:
        stack.append(root)
    while len(stack)>0:
        node = stack.pop()
        if node in used:
            result.append(node.val)
        else:
            visited.add(node)
            stack.append(node)
            if node.right != None:
                stack.append(node.right)
            if node.left != None:
                stack.append(node.left)

def levelOrder (root):
	Q = Queue()
	if(root == None): 
		return None

	Q.enQueue(root)
	while(not Q.isEmpty()):
		temp = Q.deQueue()
		print temp.data
		if(temp.left):
			Q.enQueue(temp.left)
		if(temp.right): 
			Q.enQueue(temp.right)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BuildAVLHB01001
    set output_file "main.py"

    set template_content '
count = 0
class AVLNode:
     def __init__(self, data, balanceFactor, left, right):
         self.data = data
         self.balanceFactor = 0
         self.left = left
         self.right = right

class AVLTree:
     def __init__(self):
         self.root = None

     def inOrderPrint(self):
         self.recInOrderPrint(self.root)

     def recInOrderPrint(self, root):
         if root != None:
              self.recInOrderPrint(root.left)
              print root.data
              self.recInOrderPrint(root.right)

     def insert(self, data):
         newNode = AVLNode(data, 0, None, None)
         [self.root, taller] = self.recInsertAVL(self.root, newNode)

     def recInsertAVL(self, root, newNode):
         if root == None:
            root = newNode
            root.balanceFactor = 0
            taller = True
         elif newNode.data < root.data:
                [root.left, taller] = self.recInsertAVL(root.left, newNode)
                if taller:
                    if root.balanceFactor == 0 :   
                        root.balanceFactor = -1
                    elif root.balanceFactor == 1:  
                        root.balanceFactor = 0
                        taller = False
                    else:
                        root = self.rightLeftRotate(root)
                        taller = False
         else :
               [root.right, taller] = self.recInsertAVL(root.right, newNode)
               if taller:
                    if root.balanceFactor == -1:
                        root.balanceFactor = 0
                        taller = False
                    elif root.balanceFactor == 0 :   
                        root.balanceFactor = 1
                    else:   
                        root = self.rightLeftRotate(root) 
                        taller = False
         return [root, taller]


     def rightLeftRotate(self, root):
           X = root.right
           if X.balanceFactor == 1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleRightRoate(r)
           else:
               Y = X.left
               if Y.balanceFactor == -1:
                   root.balanceFactor = 0 
                   X.balanceFactor = 1
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0
               else:
                   root.balanceFactor = -1
                   X.balanceFactor = 0
               Y.balanceFactor = 0
               root.right = self.singleLeftRotate(X)
               root = self.singleRightRoate(root)
           return root

     def rightLeftRotate(self, root):
           X = root.left
           if X.balanceFactor == -1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleLeftRotate(root)
           else:
               Y = X.right
               if Y.balanceFactor == -1:
                   root.balanceFactor = 1
                   X.balanceFactor = 0
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0 
               else:    
                   root.balanceFactor = 0
                   X.balanceFactor = -1
               Y.balanceFactor = 0
               root.left = self.singleRightRoate(X)
               root = self.singleLeftRotate(root)
           return root


     def singleRightRoate(self, r):
         X = root.right
         root.right = X.left
         X.left = r
         return X

     def singleLeftRotate(self, root):
         W = root.left
         root.left = W.right
         W.right = root
         return W

     def height(self):
         return self.recHeight(self.root)
          
     def recHeight(self, root):
         if root == None:
             return 0
         else:
              leftH = self.recHeight(root.left)
              rightH = self.recHeight(root.right)
              if leftH > rightH:
                   return 1 + leftH
              else:
                   return 1 + rightH

def BuildHB0(h):
	global count
	if(h <= 0): 
	    return None
	avlNode = AVLTree()   
	avlNode.root = avlNode
	avlNode.left = BuildHB0(h - 1)
	avlNode.right = BuildHB0(h - 1)
	avlNode.data = count
	count += 1
	return avlNode
	
def tester():
	avlNode = BuildHB0(4)
	avlNode.inOrderPrint()
	print "height = ", avlNode.height()

if __name__ == '__main__':
	tester()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BuildAVLHB1002
    set output_file "main.py"

    set template_content '
count = 0
class AVLNode:
     def __init__(self, data, balanceFactor, left, right):
         self.data = data
         self.balanceFactor = 0
         self.left = left
         self.right = right

class AVLTree:
     def __init__(self):
         self.root = None

     def inOrderPrint(self):
         self.recInOrderPrint(self.root)

     def recInOrderPrint(self, root):
         if root != None:
              self.recInOrderPrint(root.left)
              print root.data
              self.recInOrderPrint(root.right)

     def insert(self, data):
         newNode = AVLNode(data, 0, None, None)
         [self.root, taller] = self.recInsertAVL(self.root, newNode)

     def recInsertAVL(self, root, newNode):
         if root == None:
            root = newNode
            root.balanceFactor = 0
            taller = True
         elif newNode.data < root.data:
                [root.left, taller] = self.recInsertAVL(root.left, newNode)
                if taller:
                    if root.balanceFactor == 0 :   
                        root.balanceFactor = -1
                    elif root.balanceFactor == 1:  
                        root.balanceFactor = 0
                        taller = False
                    else:
                        root = self.rightLeftRotate(root)
                        taller = False
         else :
               [root.right, taller] = self.recInsertAVL(root.right, newNode)
               if taller:
                    if root.balanceFactor == -1:
                        root.balanceFactor = 0
                        taller = False
                    elif root.balanceFactor == 0 :   
                        root.balanceFactor = 1
                    else:   
                        root = self.rightLeftRotate(root) 
                        taller = False
         return [root, taller]


     def rightLeftRotate(self, root):
           X = root.right
           if X.balanceFactor == 1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleRightRoate(r)
           else:
               Y = X.left
               if Y.balanceFactor == -1:
                   root.balanceFactor = 0 
                   X.balanceFactor = 1
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0
               else:
                   root.balanceFactor = -1
                   X.balanceFactor = 0
               Y.balanceFactor = 0
               root.right = self.singleLeftRotate(X)
               root = self.singleRightRoate(root)
           return root

     def rightLeftRotate(self, root):
           X = root.left
           if X.balanceFactor == -1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleLeftRotate(root)
           else:
               Y = X.right
               if Y.balanceFactor == -1:
                   root.balanceFactor = 1
                   X.balanceFactor = 0
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0 
               else:    
                   root.balanceFactor = 0
                   X.balanceFactor = -1
               Y.balanceFactor = 0
               root.left = self.singleRightRoate(X)
               root = self.singleLeftRotate(root)
           return root


     def singleRightRoate(self, r):
         X = root.right
         root.right = X.left
         X.left = r
         return X

     def singleLeftRotate(self, root):
         W = root.left
         root.left = W.right
         W.right = root
         return W

     def height(self):
         return self.recHeight(self.root)
          
     def recHeight(self, root):
         if root == None:
             return 0
         else:
              leftH = self.recHeight(root.left)
              rightH = self.recHeight(root.right)
              if leftH > rightH:
                   return 1 + leftH
              else:
                   return 1 + rightH

def BuildHB0(h):
	global count
	if(h <= 0): 
	    return None
	avlNode = AVLTree()   
	avlNode.root = avlNode
	avlNode.left = BuildHB0(h - 1)
	avlNode.right = BuildHB0(h - 1)
	avlNode.data = count
	count += 1
	return avlNode
	
def tester():
	avlNode = BuildHB0(4)
	avlNode.inOrderPrint()
	print "height = ", avlNode.height()

if __name__ == '__main__':
	tester()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BuildHB01003
    set output_file "main.py"

    set template_content '
count = 0
class AVLNode:
     def __init__(self, data, balanceFactor, left, right):
         self.data = data
         self.balanceFactor = 0
         self.left = left
         self.right = right

class AVLTree:
     def __init__(self):
         self.root = None

     def inOrderPrint(self):
         self.recInOrderPrint(self.root)

     def recInOrderPrint(self, root):
         if root != None:
              self.recInOrderPrint(root.left)
              print root.data
              self.recInOrderPrint(root.right)

     def insert(self, data):
         newNode = AVLNode(data, 0, None, None)
         [self.root, taller] = self.recInsertAVL(self.root, newNode)

     def recInsertAVL(self, root, newNode):
         if root == None:
            root = newNode
            root.balanceFactor = 0
            taller = True
         elif newNode.data < root.data:
                [root.left, taller] = self.recInsertAVL(root.left, newNode)
                if taller:
                    if root.balanceFactor == 0 :   
                        root.balanceFactor = -1
                    elif root.balanceFactor == 1:  
                        root.balanceFactor = 0
                        taller = False
                    else:
                        root = self.rightLeftRotate(root)
                        taller = False
         else :
               [root.right, taller] = self.recInsertAVL(root.right, newNode)
               if taller:
                    if root.balanceFactor == -1:
                        root.balanceFactor = 0
                        taller = False
                    elif root.balanceFactor == 0 :   
                        root.balanceFactor = 1
                    else:   
                        root = self.rightLeftRotate(root) 
                        taller = False
         return [root, taller]


     def rightLeftRotate(self, root):
           X = root.right
           if X.balanceFactor == 1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleRightRoate(r)
           else:
               Y = X.left
               if Y.balanceFactor == -1:
                   root.balanceFactor = 0 
                   X.balanceFactor = 1
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0
               else:
                   root.balanceFactor = -1
                   X.balanceFactor = 0
               Y.balanceFactor = 0
               root.right = self.singleLeftRotate(X)
               root = self.singleRightRoate(root)
           return root

     def rightLeftRotate(self, root):
           X = root.left
           if X.balanceFactor == -1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleLeftRotate(root)
           else:
               Y = X.right
               if Y.balanceFactor == -1:
                   root.balanceFactor = 1
                   X.balanceFactor = 0
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0 
               else:    
                   root.balanceFactor = 0
                   X.balanceFactor = -1
               Y.balanceFactor = 0
               root.left = self.singleRightRoate(X)
               root = self.singleLeftRotate(root)
           return root


     def singleRightRoate(self, r):
         X = root.right
         root.right = X.left
         X.left = r
         return X

     def singleLeftRotate(self, root):
         W = root.left
         root.left = W.right
         W.right = root
         return W

     def height(self):
         return self.recHeight(self.root)
          
     def recHeight(self, root):
         if root == None:
             return 0
         else:
              leftH = self.recHeight(root.left)
              rightH = self.recHeight(root.right)
              if leftH > rightH:
                   return 1 + leftH
              else:
                   return 1 + rightH

def BuildHB0_2(l, r):
	mid = l + (r - l) // 2
	if(l > r): 
	    return None
	avlNode = AVLTree()   
	avlNode.root = avlNode
	avlNode.left = BuildHB0_2(l, mid - 1)
	avlNode.right = BuildHB0_2(mid + 1, r)
	avlNode.data = mid
	return avlNode

def tester():
	avlNode = BuildHB0_2(0, 15)
	avlNode.inOrderPrint()
	print "height = ", avlNode.height()

if __name__ == '__main__':
	tester()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BuildTreeFromPreOrder1004
    set output_file "main.py"

    set template_content '
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	    

# Post-order recursive traversal. The nodes values are appended to the result list in traversal order
def postorderRecursive(root):
	if not root:
		return

	postorderRecursive(root.left)
	postorderRecursive(root.right)
	print root.data
    
# Pre-order recursive traversal. The nodes values are appended to the result list in traversal order
def preorderRecursive(root):
    if not root:
        return
    
    print root.data
    preorderRecursive(root.left)
    preorderRecursive(root.right)

i = 0      
def buildTreeFromPreOrder(A):
	global i
     	if(A == None or i >= len(A)):  # Boundary Condition
		return None
	newNode = BinaryTree(A[i])
	newNode.data = A[i]
	newNode.left = newNode.right = None


	if(A[i] == "L"):  # On reaching leaf node, return
		return newNode

	i += 1  # Populate left sub tree
	newNode.left = buildTreeFromPreOrder(A)

	i += 1  # Populate right sub tree
	newNode.right = buildTreeFromPreOrder(A)

	return newNode

root = buildTreeFromPreOrder(["I", "I", "L", "I", "L", "L", "I", "L", "L"])
postorderRecursive(root)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BuildTreeWithInorderPreorder1005
    set output_file "main.py"

    set template_content '
class TreeNode:
     def __init__(self, data):
         self.val = data
         self.left = None
         self.right = None
class Solution:
	def buildTree(self, preorder, inorder):
		if not inorder: 
			return None  # inorder is empty
			root = TreeNode(preorder[0])
			rootPos = inorder.index(preorder[0])
			root.left = self.buildTree(preorder[1 : 1 + rootPos], inorder[ : rootPos])
			root.right = self.buildTree(preorder[rootPos + 1 : ], inorder[rootPos + 1 : ])
		return root
		
class Solution2:
    def buildTree(self, preorder, inorder):
        return self.buildTreeRec(preorder, inorder, 0, 0, len(preorder))
        
    def buildTreeRec(self, preorder, inorder, indPre, indIn, element):
        if element == 0:
            return None
        solution = TreeNode(preorder[indPre])
        numElementsLeftSubtree = 0;
        for i in range(indIn, indIn + element):
            if inorder[i] == preorder[indPre]:
                break
            numElementsLeftSubtree += 1
        solution.left = self.buildTreeRec(preorder, inorder, indPre + 1, indIn, numElementsLeftSubtree)
        solution.right = self.buildTreeRec(preorder, inorder, indPre + numElementsLeftSubtree + 1, indIn + numElementsLeftSubtree + 1, element - 1 - numElementsLeftSubtree)
        return solution		
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CeilInBST1006
    set output_file "main.py"

    set template_content '
import sys
class BSTNode:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    

prev = None
def FloorInBST(root, data):
	global prev
	return FloorInBSTUtil(root, data)

def FloorInBSTUtil(root, data):
	global prev
	if(not root): 
		return None

	if(not FloorInBSTUtil(root.left, data)):
		return 0
	if(root.data == data) :
		return root

	if(root.data > data): 	
		return prev

	prev = root
	return FloorInBSTUtil(root.right, data)

def CeilInBST(root, data):
	# Base case
	if(root == None):
		return -sys.maxint
	# We found equal data
	if(root.data == data):
		return root.data

	# If roots data is smaller, ceil must be in right subtree
	if(root.data < data):
		return CeilInBST(root.right, data)
	# Else, either left subtree or root has the ceil data
	ceil = CeilInBST(root.left, data)
	if ceil >= data:
		return ceil
	else: return root.data
	
root = BSTNode(3)
insertNode(root, BSTNode(57))
insertNode(root, BSTNode(14))
insertNode(root, BSTNode(35))
insertNode(root, BSTNode(2))
insertNode(root, BSTNode(98))
# inOrderTraversal(root)
for i  in range(10):
	print i, "ceil is ", CeilInBST(root, i)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CheckPathWithSum1007
    set output_file "main.py"

    set template_content '
def pathFinder(root, val, path, paths):
    if not root:
        return False
    
    if not root.left and not root.right:
        if root.data == val:
            path.append(root.data)
            paths.append(path)
            return True
        else:
            return False
    
    left = pathFinder(root.left, val - root.data, path + [root.data], paths)
    right = pathFinder(root.right, val - root.data, path + [root.data], paths)  # make sure it can be executed!
    return left or right


def hasPathWithSum(root, val):
    paths = []
    pathFinder(root, val, [], paths)
    print 'sum:', val
    print 'paths:', paths
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ClosestInBSTWithLevelOrder1008
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
import sys
class BSTNode:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    

prev = None
def FloorInBST(root, data):
	global prev
	return FloorInBSTUtil(root, data)

def FloorInBSTUtil(root, data):
	if(not root): 
		return sys.maxint

	if(root.data == data) :
		return root.data

	if(data < root.data): 	
		return FloorInBSTUtil(root.left, data)

	floor = FloorInBSTUtil(root.right, data)
	if floor <= data:
		return floor
	else: return root.data 

import sys
import math
def ClosestInBST(root, key):
	difference = sys.maxint 
	if(not root): 
		return 0

	Q = Queue()
	Q.enQueue(root)
	while(not Q.isEmpty()) :
		temp = Q.deQueue()
		if(difference > abs(temp.data - key)):
			difference = abs(temp.data - key)
			element = temp

		if(temp.left): 
			Q.enQueue (temp.left)
		if(temp.right): 
			Q.enQueue (temp.right)

	return element.data


root = BSTNode(3)
insertNode(root, BSTNode(17))
insertNode(root, BSTNode(11))
insertNode(root, BSTNode(55))
insertNode(root, BSTNode(23))
insertNode(root, BSTNode(99))
print ClosestInBST(root, 90)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ClosestInBSTWithRecursive1009
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
import sys
class BSTNode:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    

prev = None
def FloorInBST(root, data):
	global prev
	return FloorInBSTUtil(root, data)

def FloorInBSTUtil(root, data):
	if(not root): 
		return sys.maxint

	if(root.data == data) :
		return root.data

	if(data < root.data): 	
		return FloorInBSTUtil(root.left, data)

	floor = FloorInBSTUtil(root.right, data)
	if floor <= data:
		return floor
	else: return root.data 

import sys
import math
def ClosestInBST(root, key):
	difference = sys.maxint 
	if(not root): 
		return 0

	Q = Queue()
	Q.enQueue(root)
	while(not Q.isEmpty()) :
		temp = Q.deQueue()
		if(difference > abs(temp.data - key)):
			difference = abs(temp.data - key)
			element = temp

		if(temp.left): 
			Q.enQueue (temp.left)
		if(temp.right): 
			Q.enQueue (temp.right)

	return element.data


root = BSTNode(3)
insertNode(root, BSTNode(17))
insertNode(root, BSTNode(11))
insertNode(root, BSTNode(55))
insertNode(root, BSTNode(23))
insertNode(root, BSTNode(99))
print ClosestInBST(root, 90)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CountBST1010
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
import sys
class BSTNode:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    

prev = None
def FloorInBST(root, data):
	global prev
	return FloorInBSTUtil(root, data)

def FloorInBSTUtil(root, data):
	if(not root): 
		return sys.maxint

	if(root.data == data) :
		return root.data

	if(data < root.data): 	
		return FloorInBSTUtil(root.left, data)

	floor = FloorInBSTUtil(root.right, data)
	if floor <= data:
		return floor
	else: return root.data 

import sys
import math
def ClosestInBST(root, key):
	difference = sys.maxint 
	if(not root): 
		return 0

	Q = Queue()
	Q.enQueue(root)
	while(not Q.isEmpty()) :
		temp = Q.deQueue()
		if(difference > abs(temp.data - key)):
			difference = abs(temp.data - key)
			element = temp

		if(temp.left): 
			Q.enQueue (temp.left)
		if(temp.right): 
			Q.enQueue (temp.right)

	return element.data


root = BSTNode(3)
insertNode(root, BSTNode(17))
insertNode(root, BSTNode(11))
insertNode(root, BSTNode(55))
insertNode(root, BSTNode(23))
insertNode(root, BSTNode(99))
print ClosestInBST(root, 90)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountChildrenGenericBinaryTree1011
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
import sys
class BSTNode:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	""" return the minimum node in the current tree and its parent """
	# we use an ugly trick: the parent node is passed in as an argument
	# so that eventually when the leftmost child is reached, the 
	# call can return both the parent to the successor and the successor
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    

prev = None
def FloorInBST(root, data):
	global prev
	return FloorInBSTUtil(root, data)

def FloorInBSTUtil(root, data):
	if(not root): 
		return sys.maxint

	if(root.data == data) :
		return root.data

	if(data < root.data): 	
		return FloorInBSTUtil(root.left, data)

	floor = FloorInBSTUtil(root.right, data)
	if floor <= data:
		return floor
	else: return root.data 

import sys
import math
def ClosestInBST(root, key):
	difference = sys.maxint 
	if(not root): 
		return 0

	Q = Queue()
	Q.enQueue(root)
	while(not Q.isEmpty()) :
		temp = Q.deQueue()
		if(difference > abs(temp.data - key)):
			difference = abs(temp.data - key)
			element = temp

		if(temp.left): 
			Q.enQueue (temp.left)
		if(temp.right): 
			Q.enQueue (temp.right)

	return element.data


root = BSTNode(3)
insertNode(root, BSTNode(17))
insertNode(root, BSTNode(11))
insertNode(root, BSTNode(55))
insertNode(root, BSTNode(23))
insertNode(root, BSTNode(99))
print ClosestInBST(root, 90)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CountChildrenGenericTreeRepresentation1012
    set output_file "main.py"

    set template_content '
import string
class GenericTree:
    def __init__ (self, parent, value=None):
        self.parent = parent
        self.value = value
        self.childList = []
        if  parent is None:
            self.birthOrder = 0
        else:
            self.birthOrder = len(parent.childList)
            parent.childList.append (self)
    def nChildren (self):
        return len(self.childList)

    def nthChild (self, n):
        return self.childList[n]

    def fullPath (self):
        result = []
        parent = self.parent
        kid = self
        while  parent:
            result.insert (0, kid.birthOrder)
            parent, kid = parent.parent, parent
        return result

    def nodeId (self):
        fullPath = self.fullPath()
        return NodeId (fullPath)

    def siblingCount (self):
        if  parent is None:
            return 1
	else:
            self.parent.nChildren

class NodeId:
    def __init__ (self, path):
        self.path = path

    def __str__ (self):
        L = map (str, self.path)
        return string.join (L, "/")

    def find (self, node):
        return self.__reFind (node, 0)

    def __reFind (self, node, i):
        if  i >= len(self.path):
            return node.value
        else:
            childNo = self.path[i]
        try:
            child = node.nthChild (childNo)
        except IndexError:
            return None
        return self.__reFind (child, i + 1)

    def isOnPath (self, node):
        if  len(nodePath) > len(self.path):
            return 0  # Node is deeper than self.path

        for  i in range(len(nodePath)):
            if  nodePath[i] != self.path[i]:
                return 0  # Node is a different route than self.path
        return 1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountSiblingsGenericBinaryTree1013
    set output_file "main.py"

    set template_content '
class GenericTreeNode:
	def __init__(self, data):
		self.data = data  # root node
		self.firstChild = None  # left child
		self.nextSibling = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get firstChild child of a node
	def getFirstChild(self):
		return self.firstChild
	# get nextSibling child of a node
	def getNextSibling(self):
		return self.nextSibling
	# get firstChild child of a node
	def setFirstChild(self, firstChild):
		self.firstChild = firstChild
	# get nextSibling child of a node
	def setNextSibling(self, nextSibling):
		self.nextSibling = nextSibling
	def insertLeft(self, newNode):
		if self.firstChild == None:
			self.firstChild = GenericTreeNode(newNode)
		else:
			temp = GenericTreeNode(newNode)
			temp.firstChild = self.firstChild
			self.firstChild = temp

	def insertRight(self, newNode):
		if self.nextSibling == None:
			self.nextSibling = GenericTreeNode(newNode)
		else:
			temp = GenericTreeNode(newNode)
			temp.nextSibling = self.nextSibling
			self.nextSibling = temp
	    
# Pre-order recursive traversal. The nodes values are appended to the result list in traversal order
def preorderRecursive(root, result):
    if not root:
        return
    
    result.append(root.data)
    preorderRecursive(root.firstChild, result)
    preorderRecursive(root.nextSibling, result)

# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root, result):
	if not root:
		return

	inorderRecursive(root.firstChild, result)
	result.append(root.data)
	inorderRecursive(root.nextSibling, result)

# Post-order recursive traversal. The nodes values are appended to the result list in traversal order
def postorderRecursive(root, result):
    if not root:
        return
    
    postorderRecursive(root.firstChild, result)
    postorderRecursive(root.nextSibling, result)
    result.append(root.data)

# Pre-order iterative traversal. The nodes values are appended to the result list in traversal order
def preorderIterative(root, result):
    if not root:
        return

    stack = []
    stack.append(root)
    while stack:
        node = stack.pop()
        result.append(node.data)
        if node.nextSibling: stack.append(node.nextSibling)
        if node.firstChild: stack.append(node.firstChild)    

# In-order iterative traversal. The nodes values are appended to the result list in traversal order
def inorderIterative(root, result):
	if not root:
		return

	stack = []
	node = root
	while stack or node:
		if node:
			stack.append(node)
			node = node.firstChild
		else:
			node = stack.pop()
			result.append(node.data)
			node = node.nextSibling

# Post-order iterative traversal. The nodes values are appended to the result list in traversal order
def postorderIterative(root, result):
    if not root:
        return

    visited = set()
    stack = []
    node = root
    while stack or node:
        if node:
            stack.append(node)
            node = node.firstChild
        else:
            node = stack.pop()
            if node.nextSibling and not node.nextSibling in visited:
                stack.append(node)
                node = node.nextSibling
            else:
                visited.add(node)
                result.append(node.data)
                node = None

# Node of a Singly Linked List
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0

def levelOrder(root, result):
    if root is None:
      return
 
    q = Queue()
    q.enQueue(root)
    n = None
 
    while not q.isEmpty():
      n = q.deQueue()  # dequeue FIFO
      result.append(n.get_data())
      if n.firstChild is not None:
        q.enQueue(n.firstChild)
 
      if n.nextSibling is not None:
        q.enQueue(n.nextSibling)	


def siblingsCount(current):
	count = 0
	while(current):
	       count += 1
	       current = current.nextSibling
	return count

root = GenericTreeNode(11)
print(root.get_data())

root.insertLeft(1)
root.insertLeft(10)
root.insertLeft(1100)
root.insertRight(5)
root.getNextSibling().set_data(2)
result = []
levelOrder(root, result)
print result
print siblingsCount(root)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountSiblingsGenericTreeRepresentation1014
    set output_file "main.py"

    set template_content '
import string
class GenericTree:
    def __init__ (self, parent, value=None):
        self.parent = parent
        self.value = value
        self.childList = []
        if  parent is None:
            self.birthOrder = 0
        else:
            self.birthOrder = len(parent.childList)
            parent.childList.append (self)
    def nChildren (self):
        return len(self.childList)

    def nthChild (self, n):
        return self.childList[n]

    def fullPath (self):
        result = []
        parent = self.parent
        kid = self
        while  parent:
            result.insert (0, kid.birthOrder)
            parent, kid = parent.parent, parent
        return result

    def nodeId (self):
        fullPath = self.fullPath()
        return NodeId (fullPath)

    def siblingCount (self):
        if  parent is None:
            return 1
	else:
            self.parent.nChildren

class NodeId:
    def __init__ (self, path):
        self.path = path

    def __str__ (self):
        L = map (str, self.path)
        return string.join (L, "/")

    def find (self, node):
        return self.__reFind (node, 0)

    def __reFind (self, node, i):
        if  i >= len(self.path):
            return node.value
        else:
            childNo = self.path[i]
        try:
            child = node.nthChild (childNo)
        except IndexError:
            return None
        return self.__reFind (child, i + 1)

    def isOnPath (self, node):
        if  len(nodePath) > len(self.path):
            return 0  # Node is deeper than self.path

        for  i in range(len(nodePath)):
            if  nodePath[i] != self.path[i]:
                return 0  # Node is a different route than self.path
        return 1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DLLToBST1015
    set output_file "main.py"

    set template_content '
def DLLtoBalancedBST(head):
	if(not head or not head.next): 
		return head
	temp = FindMiddleNode(head)  # Refer Linked Lists chapter for this function. We can use two-pointer logic to find the middle node
	p = head
	while(p.next != temp):
		p = p.next
	p.next = None
	q = temp.next
	temp.next = None
	temp.prev = DLLtoBalancedBST(head)
	temp.next = DLLtoBalancedBST(q)
	return temp
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DeepestNodeBT1016
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
'''Binary Tree Class and its methods'''
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def deepestNode(root):
	if root is None:
		return 0
	q = Queue()
	q.enQueue(root)
	node = None
	count = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)
	return node.get_data()
	
		
# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)

def deleteBinaryTree(root):
	if(root == None) :
	       return
	deleteBinaryTree(root.left);
	deleteBinaryTree(root.right);
	del root



root = BinaryTree(11)
print(root.get_data())
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
inorderRecursive(root)
print deepestNode(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DeletebinaryTree1017
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
'''Binary Tree Class and its methods'''
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def levelOrderTraversalInReverse(root):
	if root is None:
		return 0

	q = Queue()
	s = Stack()
	q.enQueue(root)
	node = None
	count = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)
		s.push(node)
		
	while(not s.isEmpty()):
		print s.pop().get_data()
	
		
# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)

def deleteBinaryTree(root):
	if(root == None) :
	       return
	deleteBinaryTree(root.left);
	deleteBinaryTree(root.right);
	del root



root = BinaryTree(11)
print(root.get_data())
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
deleteBinaryTree(root)
inorderRecursive(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DepthOfGenericTreeFromArray1018
    set output_file "main.py"

    set template_content '
def findDepthInGenericTree(P):
	maxDepth = -1
	currentDepth = -1
	for i in range (0, len(P)):
		currentDepth = 0
		j = i
		while(P[j] != -1):
		       currentDepth += 1
		       j = P[j]
		if(currentDepth > maxDepth):
			maxDepth = currentDepth
	
	return maxDepth

P = [-1, 0, 1, 6, 6, 0, 0, 2, 7]
print "Depth of given Generic Tree is:", findDepthInGenericTree(P)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FillNextSiblings1019
    set output_file "main.py"

    set template_content '
def fillNextSiblings(root):
	if (root == None): 
		return

	if root.left: 
		root.left.nextSibling = root.right

	if roo.tright:
		if root.nextSibling:
			root.right.nextSibling = root.nextSibling.left 
		else:
			root.right.nextSibling = None

	fillNextSiblings(root.left)
	fillNextSiblings(root.right)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FillNextSiblingsWithLevelOrderTraversal1020
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
'''Binary Tree Class and its methods'''
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
		self.nextSibling = None
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def fillNextSiblingsWithLevelOrderTraversal(root):
	if root is None:
		return 0

	q = Queue()
	q.enQueue(root)
	node = None
	count = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		node.nextSibling = q.queueFront()
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)
	
		
# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)


root = BinaryTree(11)
print(root.get_data())
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
inorderRecursive(root)
fillNextSiblingsWithLevelOrderTraversal(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.FindInBinaryTreeRecursive1021
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	
def findMaxUsingLevelOrder(root):
	if root is None:
		return

	q = Queue()
	q.enQueue(root)
	node = None
	maxElement = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if maxElement < node.get_data():
			maxElement = node.get_data()
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)

	print maxElement

def findRecursive(root, data): 
	if not root:
		return 0

	if root.get_data() == data:
		return 1
	else:
		temp = findRecursive(root.left, data)
		if temp == 1:	
			return temp
		else:
			return findRecursive(root.right, data)


root = BinaryTree(11)
print(root.get_data())

root.insertLeft(1)
root.insertLeft(10)
root.insertLeft(100)
print(root.getLeft().get_data())
root.insertRight(5)
print(root.getRight().get_data())
root.insertRight(25)
root.getRight().set_data(25)
print(root.getRight().get_data())	
print findRecursive(root, 25)

'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindInBinaryTreeUsingLevelOrder1022
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	
def findUsingLevelOrder(root, data):
	if root is None:
		return -1

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return 1
		if node.left is not None:
			q.enQueue(node.left)
		if node.right is not None:
			q.enQueue(node.right)

	return 0

def findRecursive(root, data): 
	if not root:
		return 0

	if root.get_data() == data:
		return 1
	else:
		temp = findRecursive(root.left, data)
		if temp == 1:	
			return temp
		else:
			return findRecursive(root.right, data)


root = BinaryTree(11)
print(root.get_data())

root.insertLeft(1)
root.insertLeft(10)
root.insertLeft(100)
print(root.getLeft().get_data())
root.insertRight(5)
print(root.getRight().get_data())
root.insertRight(25)
root.getRight().set_data(25)
print(root.getRight().get_data())	
print findUsingLevelOrder(root, 25)

'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindLevelwithMaxSum1023
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def findLevelwithMaxSum(root):
	if root is None:
		return 0
	q = Queue()
	q.enQueue(root)
	q.enQueue(None)
	node = None
	level = maxLevel = currentSum = maxSum = 0 
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		# If the current level is completed then compare sums
		if(node == None): 
			if(currentSum > maxSum):
				maxSum = currentSum
				maxLevel = level

			currentSum = 0
			# place the indicator for end of next level at the end of queue
			if not q.isEmpty():  
				q.enQueue(None)
				level += 1		
		else:
			currentSum += node.get_data()
			if node.left is not None:
				q.enQueue(node.left)

			if node.right is not None:
				q.enQueue(node.right)
	return maxLevel
	
		
# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)

def deleteBinaryTree(root):
	if(root == None) :
	       return
	deleteBinaryTree(root.left);
	deleteBinaryTree(root.right);
	del root



root = BinaryTree(11)
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
# inorderRecursive(root)
print findLevelwithMaxSum(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindMaxBSTIterative1024
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
'''Binary Tree Class and its methods'''
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def findLevelwithMaxSum(root):
	if root is None:
		return 0
	q = Queue()
	q.enQueue(root)
	q.enQueue(None)
	node = None
	level = maxLevel = currentSum = maxSum = 0 
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		# If the current level is completed then compare sums
		if(node == None): 
			if(currentSum > maxSum):
				maxSum = currentSum
				maxLevel = level

			currentSum = 0
			# place the indicator for end of next level at the end of queue
			if not q.isEmpty():  
				q.enQueue(None)
				level += 1		
		else:
			currentSum += node.get_data()
			if node.left is not None:
				q.enQueue(node.left)

			if node.right is not None:
				q.enQueue(node.right)
	return maxLevel
	
		
# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)

def deleteBinaryTree(root):
	if(root == None) :
	       return
	deleteBinaryTree(root.left);
	deleteBinaryTree(root.right);
	del root



root = BinaryTree(11)
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
# inorderRecursive(root)
print findLevelwithMaxSum(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindMaxInBSTRecursive1025
    set output_file "main.py"

    set template_content '
class BSTNode(object):
 
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None
        self.parent = None
	
    # set data
    def set_data(self, data):
        self.data = data
    # get data   
    def get_data(self):
        return self.data	
    # get left child of a node
    def getLeft(self):
        return self.left
    # get right child of a node
    def getRight(self):
        return self.right
    # get left child of a node
    def setLeft(self, left):
        self.left = left
    # get right child of a node
    def setRight(self, right):
        self.right = right
	
    def search(self, data):
        if self.data == data:
            return self

        if self.left is not None and self.data > data:
            return self.left.search(data)
        elif self.right is not None:
            return self.right.search(data)

        return None
    
    def insert(self, data):
        self.insertNode(BSTNode(data))

    def insertNode(self, node):
        # Base case: empty root node
        if self.data is None:
            self.data = node.data
            return

        if node.data < self.data:
            if not self.left:
                self.left = node
                self.left.parent = self
            else:
                self.left.insertNode(node)
        elif node.data > self.data:
            if not self.right:
                self.right = node
                self.right.parent = self
            else:
                self.right.insertNode(node)
        else:
            pass  # Duplicate values are ignored

    def delete(self, data):
        # Base case: root node
        if self.data == data:
            self.deleteNode()
        elif data < self.data and self.left is not None:
            self.left.delete(data)
        elif self.right is not None:
            self.right.delete(data)

    def deleteNode(self):
        if self.right and self.left:
            # Node has two children Replace data with successor s and delete s
            if self.right:
                s = self.successor()
                self.data = s.data
                s.deleteNode()
        elif self.right or self.left:
            # Node has single child. Replace it with only child
            child = self.right is not None and self.right or self.left

            self.data = child.data

            self.left = child.left
            self.right = child.right

            if self.left : self.left.parent = self
            if self.right : self.right.parent = self
        else:
            # None has no children, erase data and update parent
            self.data = None

            if self.parent:
                if self is self.parent.left:
                    self.parent.left = None
                else:
                    self.parent.right = None

    def successor(self):
        s = None

        if self.right:
            s = self.right
            while s.left:
                s = s.left

        return s

    def predecessor(self):
        s = None

        if self.left:
            s = self.left
            while s.right:
                s = s.right

        return s

    def rotateRight(self):
        
        # terms of "P will be future Q"
        Q, P = self, self.left
 
        if not P: return
      
        Q.left = P.left
        P.left = P.right
        P.right = Q.right
        Q.right = P
        
        if P.right: P.right.parent = P
        if Q.left: Q.left.parent = Q

        P.data, Q.data = Q.data, P.data

    def rotateLeft(self):
        Q, P = self, self.right
 
        if not P: return
      
        Q.right = P.right
        P.right = P.left
        P.left = Q.left
        Q.left = P
        
        if P.left: P.left.parent = P
        if Q.right: Q.right.parent = Q

        P.data, Q.data = Q.data, P.data

    def __str__(self):
        return "(%s, l: %s, r: %s)" % (self.data, self.left is not None and self.left.data or 'N', self.right is not None and self.right.data or 'N')

def inorderRecursive(root):
	if not root:
		return
	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.getRight())


# Search the key from node, iteratively
def findMaxIterative(root):
	currentNode = root
	if currentNode == None:  
		return None
	while currentNode.getRight() != None:
		currentNode = currentNode.getRight()
	return currentNode.get_data()

# Search the key from node, iteratively
def findMaxRecursive(root):
	currentNode = root
	if currentNode.getRight() == None:
		return currentNode.get_data()
	else:
		return findMaxRecursive(currentNode.getRight())

	
root = BSTNode(11)
root.insert(1)
root.insert(10)
root.insert(1100)
root.insert(5)
# inorderRecursive(root)
root.insert(2)
# inorderRecursive(root)
print findMaxRecursive(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindMaxRecursiveInBinraryTree1026
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
'''Binary Tree Class and its methods'''
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	
def findMaxUsingLevelOrder(root):
	if root is None:
		return

	q = Queue()
	q.enQueue(root)
	node = None
	maxElement = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if maxElement < node.get_data():
			maxElement = node.get_data()
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)

	print maxElement

maxData = float("-infinity")
def findMaxRecursive(root):  # maxData is the initially the value of root
	global maxData
	if not root:
	    return maxData

	if root.get_data() > maxData:
	    maxData = root.get_data()

	findMaxRecursive(root.getLeft())
	findMaxRecursive(root.getRight())

	return maxData 


root = BinaryTree(11)
print(root.get_data())

root.insertLeft(1)
root.insertLeft(10)
root.insertLeft(100)
print(root.getLeft().get_data())
root.insertRight(5)

print(root.getRight().get_data())
root.getRight().set_data(2)
print(root.getRight().get_data())	
print findMaxRecursive(root)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.FindMaxUsingLevelOrder1027
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	
def findMaxUsingLevelOrder(root):
	if root is None:
		return

	q = Queue()
	q.enQueue(root)
	node = None
	maxElement = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if maxElement < node.get_data():
			maxElement = node.get_data()
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)

	print maxElement
	
root = BinaryTree(11)
print(root.get_data())

root.insertLeft(1)
root.insertLeft(10)
root.insertLeft(100)
print(root.getLeft().get_data())
root.insertRight(5)

print(root.getRight().get_data())
root.getRight().set_data(2)
print(root.getRight().get_data())	
findMaxUsingLevelOrder(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindMinBSTIterative1028
    set output_file "main.py"

    set template_content '
class BSTNode(object):
   

    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None
        self.parent = None
	
    # set data
    def set_data(self, data):
        self.data = data
    # get data   
    def get_data(self):
        return self.data	
    # get left child of a node
    def getLeft(self):
        return self.left
    # get right child of a node
    def getRight(self):
        return self.right
    # get left child of a node
    def setLeft(self, left):
        self.left = left
    # get right child of a node
    def setRight(self, right):
        self.right = right
	
    def search(self, data):
        if self.data == data:
            return self

        if self.left is not None and self.data > data:
            return self.left.search(data)
        elif self.right is not None:
            return self.right.search(data)

        return None
    
    def insert(self, data):
        self.insertNode(BSTNode(data))

    def insertNode(self, node):
        
        # Base case: empty root node
        if self.data is None:
            self.data = node.data
            return

        if node.data < self.data:
            if not self.left:
                self.left = node
                self.left.parent = self
            else:
                self.left.insertNode(node)
        elif node.data > self.data:
            if not self.right:
                self.right = node
                self.right.parent = self
            else:
                self.right.insertNode(node)
        else:
            pass  # Duplicate values are ignored

    def delete(self, data):
        # Base case: root node
        if self.data == data:
            self.deleteNode()
        elif data < self.data and self.left is not None:
            self.left.delete(data)
        elif self.right is not None:
            self.right.delete(data)

    def deleteNode(self):
        if self.right and self.left:
            # Node has two children Replace data with successor s and delete s
            if self.right:
                s = self.successor()
                self.data = s.data
                s.deleteNode()
        elif self.right or self.left:
            # Node has single child. Replace it with only child
            child = self.right is not None and self.right or self.left
            self.data = child.data
            self.left = child.left
            self.right = child.right
            if self.left : self.left.parent = self
            if self.right : self.right.parent = self
        else:
            # None has no children, erase data and update parent
            self.data = None

            if self.parent:
                if self is self.parent.left:
                    self.parent.left = None
                else:
                    self.parent.right = None

    def successor(self):
        s = None
        if self.right:
            s = self.right
            while s.left:
                s = s.left
        return s

    def predecessor(self):
        s = None
        if self.left:
            s = self.left
            while s.right:
                s = s.right
        return s

    def rotateRight(self):
        Q, P = self, self.left

        if not P: return
      
        Q.left = P.left
        P.left = P.right
        P.right = Q.right
        Q.right = P
        
        if P.right: P.right.parent = P
        if Q.left: Q.left.parent = Q

        P.data, Q.data = Q.data, P.data

    def rotateLeft(self):
        Q, P = self, self.right
 
        if not P: return
      
        Q.right = P.right
        P.right = P.left
        P.left = Q.left
        Q.left = P
        
        if P.left: P.left.parent = P
        if Q.right: Q.right.parent = Q

        P.data, Q.data = Q.data, P.data

    def __str__(self):
        return "(%s, l: %s, r: %s)" % (self.data, self.left is not None and self.left.data or 'N', self.right is not None and self.right.data or 'N')

def inorderRecursive(root):
	if not root:
		return
	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.getRight())

def findMinIterative(root):
	currentNode = root
	if currentNode == None:  
		return None
	while currentNode.getLeft() != None:
		currentNode = currentNode.getLeft()
	return currentNode.get_data()


root = BSTNode(11)
root.insert(1)
root.insert(10)
root.insert(1100)
root.insert(5)
# inorderRecursive(root)
root.insert(2)
# inorderRecursive(root)
print findMinIterative(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindMinBSTRecursive1029
    set output_file "main.py"

    set template_content '
class BSTNode(object):
    

    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None
        self.parent = None
	
    # set data
    def set_data(self, data):
        self.data = data
    # get data   
    def get_data(self):
        return self.data	
    # get left child of a node
    def getLeft(self):
        return self.left
    # get right child of a node
    def getRight(self):
        return self.right
    # get left child of a node
    def setLeft(self, left):
        self.left = left
    # get right child of a node
    def setRight(self, right):
        self.right = right
	
    def search(self, data):
        if self.data == data:
            return self

        if self.left is not None and self.data > data:
            return self.left.search(data)
        elif self.right is not None:
            return self.right.search(data)

        return None
    
    def insert(self, data):
        self.insertNode(BSTNode(data))

    def insertNode(self, node):
        # Base case: empty root node
        if self.data is None:
            self.data = node.data
            return

        if node.data < self.data:
            if not self.left:
                self.left = node
                self.left.parent = self
            else:
                self.left.insertNode(node)
        elif node.data > self.data:
            if not self.right:
                self.right = node
                self.right.parent = self
            else:
                self.right.insertNode(node)
        else:
            pass  # Duplicate values are ignored

    def delete(self, data):
        # Base case: root node
        if self.data == data:
            self.deleteNode()
        elif data < self.data and self.left is not None:
            self.left.delete(data)
        elif self.right is not None:
            self.right.delete(data)

    def deleteNode(self):
        if self.right and self.left:
            # Node has two children Replace data with successor s and delete s
            if self.right:
                s = self.successor()
                self.data = s.data
                s.deleteNode()
        elif self.right or self.left:
            # Node has single child. Replace it with only child
            child = self.right is not None and self.right or self.left

            self.data = child.data

            self.left = child.left
            self.right = child.right

            if self.left : self.left.parent = self
            if self.right : self.right.parent = self
        else:
            # None has no children, erase data and update parent
            self.data = None

            if self.parent:
                if self is self.parent.left:
                    self.parent.left = None
                else:
                    self.parent.right = None

    def successor(self):
        s = None
        if self.right:
            s = self.right
            while s.left:
                s = s.left
        return s

    def predecessor(self):
        s = None
        if self.left:
            s = self.left
            while s.right:
                s = s.right
        return s

    def rotateRight(self):
        Q, P = self, self.left
 
        if not P: return
      
        Q.left = P.left
        P.left = P.right
        P.right = Q.right
        Q.right = P
        
        if P.right: P.right.parent = P
        if Q.left: Q.left.parent = Q

        P.data, Q.data = Q.data, P.data

    def rotateLeft(self):
        Q, P = self, self.right
 
        if not P: return
      
        Q.right = P.right
        P.right = P.left
        P.left = Q.left
        Q.left = P
        
        if P.left: P.left.parent = P
        if Q.right: Q.right.parent = Q

        P.data, Q.data = Q.data, P.data

    def __str__(self):
        return "(%s, l: %s, r: %s)" % (self.data, self.left is not None and self.left.data or 'N', self.right is not None and self.right.data or 'N')

def inorderRecursive(root):
	if not root:
		return
	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.getRight())

def findMinRecursive(root):
	currentNode = root
	if currentNode.getLeft() == None:
		return currentNode.get_data()
	else:
		return findMinRecursive(currentNode.getLeft())


root = BSTNode(11)
root.insert(1)
root.insert(10)
root.insert(1100)
root.insert(5)
# inorderRecursive(root)
root.insert(2)
# inorderRecursive(root)
print findMinRecursive(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindSizeusingLevelOrder1030
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
'''Binary Tree Class and its methods'''
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def findSizeusingLevelOrder(root):
	if root is None:
		return 0

	q = Queue()
	q.enQueue(root)
	node = None
	count = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		count += 1
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)

	return count
		
# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)


root = BinaryTree(11)
print(root.get_data())
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
inorderRecursive(root)
print findSizeusingLevelOrder(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.FloorInBST1031
    set output_file "main.py"

    set template_content '
import sys
class BSTNode:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    

prev = None
def FloorInBST(root, data):
	global prev
	return FloorInBSTUtil(root, data)

def FloorInBSTUtil(root, data):
	if(not root): 
		return sys.maxint

	if(root.data == data) :
		return root.data

	if(data < root.data): 	
		return FloorInBSTUtil(root.left, data)

	floor = FloorInBSTUtil(root.right, data)
	if floor <= data:
		return floor
	else: return root.data 
		
root = BSTNode(3)
insertNode(root, BSTNode(17))
insertNode(root, BSTNode(11))
insertNode(root, BSTNode(55))
insertNode(root, BSTNode(23))
insertNode(root, BSTNode(99))
# inOrderTraversal(root)
for i  in range(100):
	print i, "ceil is ", FloorInBSTUtil(root, i)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FullK-AryTrees1032
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size

	def isEmpty(self):
		return self.size == 0
		
'''Binary Tree Class and its methods'''
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def levelOrder (root):
	Q = Queue()
	if(root == None): 
		return None

	Q.enQueue(root)
	while(not Q.isEmpty()):
		temp = Q.deQueue()
		print temp.data
		if(temp.left):
			Q.enQueue(temp.left)
		if(temp.right): 
			Q.enQueue(temp.right)

class KaryTreeNode:
    def __init__ (self, k, data=None):
        self.data = data
        self.childList = []

def BuildKaryTree(A, k):
	n = len(A)
	if n <= 0:
		return None
	index = 0		
	root = KaryTreeNode(None, A[0])
	if(not root):
		print("Memory Error")
		return
	Q = Queue()
	if(Q == None): 
		return None
	Q.enQueue(root)
	while(not Q.isEmpty()):
		temp = Q.deQueue()
		for i in range(0, k):
			index += 1
			if index < n:
				temp.childList.insert(i, KaryTreeNode(None, A[index]))
				Q.enQueue(temp.childList[i])
	return root
	
def preorderRecursive(kroot):
	if not kroot:
		return
	print kroot.data	
	for node in kroot.childList:
		preorderRecursive(node)		
A = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
kroot = BuildKaryTree(A, 3)	
preorderRecursive(kroot)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.GenericTrees1033
    set output_file "main.py"

    set template_content '
import string
class GenericTree:
    def __init__ (self, parent, value=None):
        self.parent = parent
        self.value = value
        self.childList = []
        if  parent is None:
            self.birthOrder = 0
        else:
            self.birthOrder = len(parent.childList)
            parent.childList.append (self)
    def nChildren (self):
        return len(self.childList)

    def nthChild (self, n):
        return self.childList[n]

    def fullPath (self):
        result = []
        parent = self.parent
        kid = self
        while  parent:
            result.insert (0, kid.birthOrder)
            parent, kid = parent.parent, parent
        return result

    def nodeId (self):
        fullPath = self.fullPath()
        return NodeId (fullPath)

class NodeId:
    def __init__ (self, path):
        self.path = path

    def __str__ (self):
        L = map (str, self.path)
        return string.join (L, "/")

    def find (self, node):
        return self.__reFind (node, 0)

    def __reFind (self, node, i):
        if  i >= len(self.path):
            return node.value  
        else:
            childNo = self.path[i]
        try:
            child = node.nthChild (childNo)
        except IndexError:
            return None
        return self.__reFind (child, i + 1)

    def isOnPath (self, node):
        if  len(nodePath) > len(self.path):
            return 0  # Node is deeper than self.path

        for  i in range(len(nodePath)):
            if  nodePath[i] != self.path[i]:
                return 0  # Node is a different route than self.path
        return 1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.InsertInBinaryTree1034
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	
def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def findRecursive(root, data): 
	if not root:
		return 0

	if root.get_data() == data:
		return 1
	else:
		temp = findRecursive(root.left, data)
		if temp == 1:	
			return temp
		else:
			return findRecursive(root.right, data)

# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)


root = BinaryTree(11)
print(root.get_data())
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
inorderRecursive(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.IsAVL1035
    set output_file "main.py"

    set template_content '
import math
count = 0
class AVLNode:
     def __init__(self, data, balanceFactor, left, right):
         self.data = data
         self.balanceFactor = 0
         self.left = left
         self.right = right

class AVLTree:
     def __init__(self):
         self.root = None

     def inOrderPrint(self):
         self.recInOrderPrint(self.root)

     def recInOrderPrint(self, root):
         if root != None:
              self.recInOrderPrint(root.left)
              print root.data
              self.recInOrderPrint(root.right)

     def insert(self, data):
         newNode = AVLNode(data, 0, None, None)
         [self.root, taller] = self.recInsertAVL(self.root, newNode)

     def recInsertAVL(self, root, newNode):
         if root == None:
            root = newNode
            root.balanceFactor = 0
            taller = True
         elif newNode.data < root.data:
                [root.left, taller] = self.recInsertAVL(root.left, newNode)
                if taller:
                    if root.balanceFactor == 0 :   
                        root.balanceFactor = -1
                    elif root.balanceFactor == 1:  
                        root.balanceFactor = 0
                        taller = False
                    else:
                        root = self.rightLeftRotate(root)
                        taller = False
         else :
               [root.right, taller] = self.recInsertAVL(root.right, newNode)
               if taller:
                    if root.balanceFactor == -1:
                        root.balanceFactor = 0
                        taller = False
                    elif root.balanceFactor == 0 :   
                        root.balanceFactor = 1
                    else:   
                        root = self.rightLeftRotate(root) 
                        taller = False
         return [root, taller]


     def rightLeftRotate(self, root):
           X = root.right
           if X.balanceFactor == 1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleRightRoate(r)
           else:
               Y = X.left
               if Y.balanceFactor == -1:
                   root.balanceFactor = 0 
                   X.balanceFactor = 1
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0
               else:
                   root.balanceFactor = -1
                   X.balanceFactor = 0
               Y.balanceFactor = 0
               root.right = self.singleLeftRotate(X)
               root = self.singleRightRoate(root)
           return root

     def rightLeftRotate(self, root):
           X = root.left
           if X.balanceFactor == -1:
               root.balanceFactor = 0
               X.balanceFactor = 0
               root = self.singleLeftRotate(root)
           else:
               Y = X.right
               if Y.balanceFactor == -1:
                   root.balanceFactor = 1
                   X.balanceFactor = 0
               elif Y.balanceFactor == 0:
                   root.balanceFactor = 0
                   X.balanceFactor = 0 
               else:    
                   root.balanceFactor = 0
                   X.balanceFactor = -1
               Y.balanceFactor = 0
               root.left = self.singleRightRoate(X)
               root = self.singleLeftRotate(root)
           return root


     def singleRightRoate(self, r):
         X = root.right
         root.right = X.left
         X.left = r
         return X

     def singleLeftRotate(self, root):
         W = root.left
         root.left = W.right
         W.right = root
         return W

     def height(self):
         return self.recHeight(self.root)
          
     def recHeight(self, root):
         if root == None:
             return 0
         else:
              leftH = self.recHeight(root.left)
              rightH = self.recHeight(root.right)
              if leftH > rightH:
                   return 1 + leftH
              else:
                   return 1 + rightH

def BuildHB0(h):
	global count
	if(h <= 0): 
	    return None
	avlNode = AVLTree()   
	avlNode.root = avlNode
	avlNode.left = BuildHB0(h - 1)
	avlNode.right = BuildHB0(h - 1)
	avlNode.data = count
	count += 1
	return avlNode

def isAVL(root):
	if root == None:
		return 0
	else:
		left = isAVL(root.left)
		if left == -1:
			return left
		right = isAVL(root.right)
		if(right == -1): 
			return right	
		if(abs(left - right) > 1) :
			return -1	
		return max(left, right) + 1

def tester():
	avlNode = BuildHB0(4)
	avlNode.inOrderPrint()
	print "height = ", avlNode.height()
	print isAVL(avlNode)
	

if __name__ == '__main__':
	tester()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.IsBST1036
    set output_file "main.py"

    set template_content '
class BinaryTree:
    def __init__(self, data):
        self.data = data  # root node
        self.left = None  # left child
        self.right = None  # right child
    # set data
    def set_data(self, data):
        self.data = data
    # get data   
    def get_data(self):
        return self.data	
    # get left child of a node
    def getLeft(self):
        return self.left
    # get right child of a node
    def getRight(self):
        return self.right

def IsBST(root):
	if root == None:
                  return 1
	# false if left is > than root 
	if root.getLeft() != None and root.getLeft().get_data() > root.get_data():
                  return 0

	# false if right is < than root 
	if root.getRight() != None and root.getRight().get_data() < root.get_data():
                  return 0

	# false if, recursively, the left or right is not a BST 
	if not IsBST(root.getLeft()) or not IsBST(root.getRight()):
                  return 0

	# passing all that, its a BST 
	return 1

def IsBST2(root, min, max):
	if root == None:
	    return 1
	if root.get_data() <= min or root.get_data() >= max:
	    return 0
	result = IsBST2(root.getLeft(), min, root.get_data())
	result = result and IsBST2(root.getRight(), root.get_data(), max)
	return result

# Returns true if a binary tree is a binary search tree 
def IsBST3(root):
	if root == None:
                  return 1

	# false if the max of the left is > than root 
	if(root.getLeft() != None and FindMax(root.getLeft()) > root.get_data())
                  return 0

	# false if the min of the right is <= than root 
	if(root.getRight() != None and FindMin(root.getRight()) < root.get_data())
                  return 0

	# false if, recursively, the left or right is not a BST 
	if(not IsBST3(root.getLeft()) or not IsBST3(root.getRight())) 
                  return 0

	# passing all that, its a BST 
	return 1
	
def isBST4(root, previousValue=[NEG_INFINITY]): 
	if root is None: 
		return 1   
	if not isBST4(root.getLeft(), previousValue): 
		return False   
	if root.get_data() < lastNode[0]: 
		return 0   
	previousValue = root.get_data()   
	return isBST4(root.getRight(), previousValue)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.IsomorphicTreesCheck1037
    set output_file "main.py"

    set template_content '
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	# get left child of a node
	def setLeft(self, left):
		self.left = left
	# get right child of a node
	def setRight(self, right):
		self.right = right
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	    
# Pre-order recursive traversal. The nodes values are appended to the result list in traversal order
def preorderRecursive(root, result):
    if not root:
        return
    
    result.append(root.data)
    preorderRecursive(root.left, result)
    preorderRecursive(root.right, result)

# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root, result):
	if not root:
		return

	inorderRecursive(root.left, result)
	result.append(root.data)
	inorderRecursive(root.right, result)

# Post-order recursive traversal. The nodes values are appended to the result list in traversal order
def postorderRecursive(root, result):
    if not root:
        return
    
    postorderRecursive(root.left, result)
    postorderRecursive(root.right, result)
    result.append(root.data)

# Pre-order iterative traversal. The nodes values are appended to the result list in traversal order
def preorderIterative(root, result):
    if not root:
        return

    stack = []
    stack.append(root)
    while stack:
        node = stack.pop()
        result.append(node.data)
        if node.right: stack.append(node.right)
        if node.left: stack.append(node.left)    

# In-order iterative traversal. The nodes values are appended to the result list in traversal order
def inorderIterative(root):
	if not root:
		return

	stack = []
	node = root
	while stack or node:
		if node:
			stack.append(node)
			node = node.left
		else:
			node = stack.pop()
			print node.data
			node = node.right

# Post-order iterative traversal. The nodes values are appended to the result list in traversal order
def postorderIterative(root):
    if not root:
        return

    visited = set()
    stack = []
    node = root
    while stack or node:
        if node:
            stack.append(node)
            node = node.left
        else:
            node = stack.pop()
            if node.right and not node.right in visited:
                stack.append(node)
                node = node.right
            else:
                visited.add(node)
                print node.data
                node = None
		
def isIsomorphic(root1, root2):
	if(not root1 and not root2): 
		return 1
	if((not root1 and root2) or (root1 and not root2)):
	        return 0
	return (isIsomorphic(root1.left, root2.left) and isIsomorphic(root1.right, root2.right))
		

root1 = BinaryTree(11)
root1.insertLeft(1)
root1.insertLeft(10)
root1.insertLeft(1100)
root1.insertRight(5)
root1.getRight().set_data(2)
postorderIterative(root1)

root2 = BinaryTree(99)
root2.insertLeft(9)
root2.insertLeft(910)
root2.insertLeft(9900)
root2.insertRight(8)
root2.getRight().set_data(2)
postorderIterative(root2)
print "Isomorphic:", isIsomorphic(root1, root2)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KthSmallestBST1038
    set output_file "main.py"

    set template_content '
class BSTNode:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	""" return the minimum node in the current tree and its parent """
	# we use an ugly trick: the parent node is passed in as an argument
	# so that eventually when the leftmost child is reached, the 
	# call can return both the parent to the successor and the successor
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    

count = 0
def kthSmallestInBST(root, k):
	global count
	if(not root): 
		return None;
	left = kthSmallestInBST(root.left, k)
	if(left): 
		return left
	count += 1
	if(count == k): 
		return root
	return kthSmallestInBST(root.right, k)
	
root = BSTNode(3)
insertNode(root, BSTNode(7))
insertNode(root, BSTNode(1))
insertNode(root, BSTNode(5))
insertNode(root, BSTNode(2))
insertNode(root, BSTNode(9))
# inOrderTraversal(root)
print kthSmallestInBST(root, 3).data
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.LCAInBinaryTree1039
    set output_file "main.py"

    set template_content '
def lca(root, alpha, beta):
    if not root: return None
    if root.value == alpha or root.value == beta: return root
    left = lca(root.left, alpha, beta)
    right = lca(root.right, alpha, beta)
    if left and right: 
        # alpha & beta are on both sides
        return root
    else: 
        # EITHER alpha/beta is on one side 
        # OR alpha/beta is not in L&R subtrees
        return left if left else right
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LevelOrderTraversalInReverse1040
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def levelOrderTraversalInReverse(root):
	if root is None:
		return 0

	q = Queue()
	s = Stack()
	q.enQueue(root)
	node = None
	count = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)
		s.push(node)
		
	while(not s.isEmpty()):
		print s.pop().get_data()
	
		
# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)


root = BinaryTree(11)
print(root.get_data())
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
inorderRecursive(root)
levelOrderTraversalInReverse(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.LinkingNodesOfSameLevelBSTRecursive1041
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0

import sys
class BSTNode:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data
	root.next = None

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    


def PruneBST(root, A, B):
	if(not root):  
		return None
	root.left = PruneBST(root.left, A, B)
	root.right = PruneBST(root.right, A, B)
	if(A <= root.data and root.data <= B):
		return root
	if(root.data < A):
		return root.right
	if(root.data > B):
		return root.left

def linkingNodesOfSameLevel(root):
	if(not root):
		return
	rightMostNode = None
	nextHead = None
	temp = root
	# connect next level of current root node level
	while(temp != None):
		if(temp.left != None):
			if(rightMostNode == None):
				rightMostNode = temp.left
				nextHead = temp.left
			else:
				rightMostNode.next = temp.left
				rightMostNode = rightMostNode.next
		
		if(temp.right != None):
			if(rightMostNode == None):
				rightMostNode = temp.right
				nextHead = temp.right		
			else:
				rightMostNode.next = temp.right
				rightMostNode = rightMostNode.next		
		temp = temp.next
	linkingNodesOfSameLevel(nextHead)

root = BSTNode(3)
insertNode(root, BSTNode(17))
insertNode(root, BSTNode(11))
insertNode(root, BSTNode(55))
insertNode(root, BSTNode(23))
insertNode(root, BSTNode(99))
root = PruneBST(root, 10, 99)
inOrderTraversal(root)
linkingNodesOfSameLevel(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LinkingNodesOfSameLevelBSTWithLevelOrder1042
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0

import sys
class BSTNode:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data
	root.next = None

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    


def PruneBST(root, A, B):
	if(not root):  
		return None
	root.left = PruneBST(root.left, A, B)
	root.right = PruneBST(root.right, A, B)
	if(A <= root.data and root.data <= B):
		return root
	if(root.data < A):
		return root.right
	if(root.data > B):
		return root.left


def linkingNodesOfSameLevel(root):
	Q = Queue()
	if(not root):
		return
	Q.enQueue(root)
	currentLevelNodeCount = 1
	nextLevelNodeCount = 0
	prev = None
	while (not Q.isEmpty()) :
		temp = Q.deQueue()
		if (temp.left):
			Q.enQueue(temp.left)
			nextLevelNodeCount += 1

		if (temp.right):
			Q.enQueue(temp.right)
			nextLevelNodeCount += 1

		# Link the previous node of the current level to this node
		if (prev):
			prev.next = temp
		# Set the previous node to the current 
		prev = temp
		currentLevelNodeCount -= 1
		if (currentLevelNodeCount == 0) :  # if this is the last node of the current level
			currentLevelNodeCount = nextLevelNodeCount
			nextLevelNodeCount = 0
			prev = None    

root = BSTNode(3)
insertNode(root, BSTNode(17))
insertNode(root, BSTNode(11))
insertNode(root, BSTNode(55))
insertNode(root, BSTNode(23))
insertNode(root, BSTNode(99))
root = PruneBST(root, 10, 99)
inOrderTraversal(root)
linkingNodesOfSameLevel(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaxPathSumInBinaryTree1043
    set output_file "main.py"

    set template_content '
class Answer:
    def maxPathSum(self, root):
        self.maxValue = float("-inf")
        self.maxPathSumRec(root)
        return self.maxValue
    
    def maxPathSumRec(self, root):
        if root == None:
             return 0
        leftSum = self.maxPathSumRec(root.left)
        rightSum = self.maxPathSumRec(root.right)
        if leftSum < 0 and rightSum < 0:
            self.maxValue = max(self.maxValue, root.val)
            return root.val
        if leftSum > 0 and rightSum > 0:
            self.maxValue = max(self.maxValue, root.val + leftSum + rightSum)
        maxValueUp = max(leftSum, rightSum) + root.val
        self.maxValue = max(self.maxValue, maxValueUp)
        return maxValueUp
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MirrorOfBinaryTree1044
    set output_file "main.py"

    set template_content '
ef MirrorOfBinaryTree(root):
	if(root != None):
		MirrorOfBinaryTree(root.left)
		MirrorOfBinaryTree(root.right)

		# swap the pointers in this node
		temp = root.left
		root.left = root.right
		root.right = temp
	
	return root
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.NumberOfFullNodesInBTusingLevelOrder1045
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def numberOfFullNodesInBTusingLevelOrder(root):
	if root is None:
		return 0
	q = Queue()
	q.enQueue(root)
	node = None
	count = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		if node.left is not None and node.right is not None:
			count += 1
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)
	return count
	
		
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)

def deleteBinaryTree(root):
	if(root == None) :
	       return
	deleteBinaryTree(root.left);
	deleteBinaryTree(root.right);
	del root



root = BinaryTree(11)
print(root.get_data())
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
inorderRecursive(root)
print numberOfFullNodesInBTusingLevelOrder(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NumberOfHalfNodesInBTusingLevelOrder1046
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
'''Binary Tree Class and its methods'''
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def numberOfHalfNodesInBTusingLevelOrder(root):
	if root is None:
		return 0
	q = Queue()
	q.enQueue(root)
	node = None
	count = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		if (node.left is None and node.right is not None) or \
			(node.left is not None and node.right is None):
			count += 1
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)
	return count
	
		
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)

def deleteBinaryTree(root):
	if(root == None) :
	       return
	deleteBinaryTree(root.left);
	deleteBinaryTree(root.right);
	del root



root = BinaryTree(11)
print(root.get_data())
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
inorderRecursive(root)
print numberOfHalfNodesInBTusingLevelOrder(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.NumberOfLeavesInBTusingLevelOrder1047
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def numberOfLeavesInBTusingLevelOrder(root):
	if root is None:
		return 0
	q = Queue()
	q.enQueue(root)
	node = None
	count = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		if node.left is None and node.right is None:
			count += 1
		else:
			if node.left is not None:
				q.enQueue(node.left)

			if node.right is not None:
				q.enQueue(node.right)
	return count
	
		
# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)

def deleteBinaryTree(root):
	if(root == None) :
	       return
	deleteBinaryTree(root.left);
	deleteBinaryTree(root.right);
	del root



root = BinaryTree(11)
print(root.get_data())
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
inorderRecursive(root)
print numberOfLeavesInBTusingLevelOrder(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PathsFinder1048
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
'''Binary Tree Class and its methods'''
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def numberOfHalfNodesInBTusingLevelOrder(root):
	if root is None:
		return 0
	q = Queue()
	q.enQueue(root)
	node = None
	count = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		if (node.left is None and node.right is not None) or \
			(node.left is not None and node.right is None):
			count += 1
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)
	return count
	
		
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)

def deleteBinaryTree(root):
	if(root == None) :
	       return
	deleteBinaryTree(root.left);
	deleteBinaryTree(root.right);
	del root


def pathsAppender(root, path, paths):
	if not root:
		return 0
		
	path.append(root.data)
	paths.append(path)
	pathsAppender(root.left, path + [root.data], paths)
	pathsAppender(root.right, path + [root.data], paths)  # make sure it can be executed!


def pathsFinder(root):
    paths = []
    pathsAppender(root, [], paths)
    print 'paths:', paths

root = BinaryTree(11)
print(root.get_data())
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
inorderRecursive(root)
print numberOfHalfNodesInBTusingLevelOrder(root)
pathsFinder(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.PrintAllAncestors1049
    set output_file "main.py"

    set template_content '
def PrintAllAncestors(root, node):
	if(root == NULL):
		return 0
	if(root.left == node or root.right == node or  PrintAllAncestors(root.left, node) or PrintAllAncestors(root.right, node)):
		print(root.data)
		return 1
	return 0
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PrintPathsRecur1050
    set output_file "main.py"

    set template_content '
def sumNumbers(self, root):
	if not root:
		return 0
	current = 0
	sum = [0]
	self.printPathsRecur(root, current, sum)
	return sum[0]
	
def printPathsRecur(self, root, current, sum):
	if not root:
		return
	current = current * 10 + root.data
	if not root.left and not root.right:
		sum[0] += current
		return

	self.printPathsRecur(root.left, current, sum)
	self.printPathsRecur(root.right, current, sum)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.PruneBST1051
    set output_file "main.py"

    set template_content '
import sys
class BSTNode:
    def __init__(root, data):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	""" return the minimum node in the current tree and its parent """
	# we use an ugly trick: the parent node is passed in as an argument
	# so that eventually when the leftmost child is reached, the 
	# call can return both the parent to the successor and the successor
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)    


def PruneBST(root, A, B):
	if(not root):  
		return None
	root.left = PruneBST(root.left, A, B)
	root.right = PruneBST(root.right, A, B)
	if(A <= root.data and root.data <= B):
		return root
	if(root.data < A):
		return root.right
	if(root.data > B):
		return root.left



root = BSTNode(3)
insertNode(root, BSTNode(17))
insertNode(root, BSTNode(11))
insertNode(root, BSTNode(55))
insertNode(root, BSTNode(23))
insertNode(root, BSTNode(99))
root = PruneBST(root, 10, 99)
inOrderTraversal(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.QuasiIsomorphicCheck1052
    set output_file "main.py"

    set template_content '
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	# get left child of a node
	def setLeft(self, left):
		self.left = left
	# get right child of a node
	def setRight(self, right):
		self.right = right
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	    
# Pre-order recursive traversal. The nodes values are appended to the result list in traversal order
def preorderRecursive(root, result):
    if not root:
        return
    
    result.append(root.data)
    preorderRecursive(root.left, result)
    preorderRecursive(root.right, result)

# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root, result):
	if not root:
		return

	inorderRecursive(root.left, result)
	result.append(root.data)
	inorderRecursive(root.right, result)

# Post-order recursive traversal. The nodes values are appended to the result list in traversal order
def postorderRecursive(root, result):
    if not root:
        return
    
    postorderRecursive(root.left, result)
    postorderRecursive(root.right, result)
    result.append(root.data)

# Pre-order iterative traversal. The nodes values are appended to the result list in traversal order
def preorderIterative(root, result):
    if not root:
        return

    stack = []
    stack.append(root)
    while stack:
        node = stack.pop()
        result.append(node.data)
        if node.right: stack.append(node.right)
        if node.left: stack.append(node.left)    

# In-order iterative traversal. The nodes values are appended to the result list in traversal order
def inorderIterative(root):
	if not root:
		return

	stack = []
	node = root
	while stack or node:
		if node:
			stack.append(node)
			node = node.left
		else:
			node = stack.pop()
			print node.data
			node = node.right

# Post-order iterative traversal. The nodes values are appended to the result list in traversal order
def postorderIterative(root):
    if not root:
        return

    visited = set()
    stack = []
    node = root
    while stack or node:
        if node:
            stack.append(node)
            node = node.left
        else:
            node = stack.pop()
            if node.right and not node.right in visited:
                stack.append(node)
                node = node.right
            else:
                visited.add(node)
                print node.data
                node = None

def quasiIsomorphic(root1, root2):
	if(not root1 and not root2): 
		return 1
	if((not root1 and root2) or (root1 and not root2)):
	        return 0
	return (quasiIsomorphic(root1.left, root2.left) and quasiIsomorphic(root1.right, root2.right)
	         or quasiIsomorphic(root1.right, root2.left) and quasiIsomorphic(root1.left, root2.right))
	

root1 = BinaryTree(11)
root1.insertLeft(1)
root1.insertLeft(10)
root1.insertLeft(1100)
root1.insertRight(5)
root1.getRight().set_data(2)
postorderIterative(root1)

root2 = BinaryTree(99)
root2.insertLeft(9)
root2.insertLeft(910)
root2.insertLeft(9900)
root2.insertRight(8)
root2.getRight().set_data(2)
postorderIterative(root2)
print "QuasiIsomorphic:", quasiIsomorphic(root1, root2)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.RangePrinterBST1053
    set output_file "main.py"

    set template_content '

def rangePrinter(root, K1, K2): 
	if not root: 
		return 
	if K1 <= root.get_data() <= K2: 
		print(root.get_data())
	if root.get_data() < K1: 
		return rangePrinter(root.getRight(), K1, K2) 
	if root.get_data() > K2: 
		return rangePrinter(root.getLeft(), K1, K2)


import Queue
def rangePrinter(root):
	if root is None:
		return

	q = Queue.Queue()
	q.put(root)
	temp = None

	while not q.empty():
		temp = q.get()  # dequeue FIFO
		if K1 <= root.get_data() <= K2: 
			print(root.get_data())
		if temp.getLeft() is not None and temp.get_data() >= K1:
			q.put(temp.getLeft())
		if temp.getRight() is not None and temp.get_data() <= K2:
			q.put(temp.getRight())	


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RemoveHalfNodesFromBinaryTree1054
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
'''Binary Tree Class and its methods'''
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	    
# Pre-order recursive traversal. The nodes values are appended to the result list in traversal order
def preorderRecursive(root, result):
    if not root:
        return
    
    result.append(root.data)
    preorderRecursive(root.left, result)
    preorderRecursive(root.right, result)

# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root, result):
	if not root:
		return

	inorderRecursive(root.left, result)
	result.append(root.data)
	inorderRecursive(root.right, result)

# Post-order recursive traversal. The nodes values are appended to the result list in traversal order
def postorderRecursive(root, result):
    if not root:
        return
    
    postorderRecursive(root.left, result)
    postorderRecursive(root.right, result)
    result.append(root.data)

# Pre-order iterative traversal. The nodes values are appended to the result list in traversal order
def preorderIterative(root, result):
    if not root:
        return

    stack = []
    stack.append(root)
    while stack:
        node = stack.pop()
        result.append(node.data)
        if node.right: stack.append(node.right)
        if node.left: stack.append(node.left)    

# In-order iterative traversal. The nodes values are appended to the result list in traversal order
def inorderIterative(root, result):
	if not root:
		return

	stack = []
	node = root
	while stack or node:
		if node:
			stack.append(node)
			node = node.left
		else:
			node = stack.pop()
			result.append(node.data)
			node = node.right

# Post-order iterative traversal. The nodes values are appended to the result list in traversal order
def postorderIterative(root, result=[]):
    if not root:
        return

    visited = set()
    stack = []
    node = root
    while stack or node:
        if node:
            stack.append(node)
            node = node.left
        else:
            node = stack.pop()
            if node.right and not node.right in visited:
                stack.append(node)
                node = node.right
            else:
                visited.add(node)
                result.append(node.data)
                node = None
			
def removeHalfNodes(root):
	if root is None:
		return	
	root.left = removeHalfNodes(root.left)
	root.right = removeHalfNodes(root.right)		
	if (root.left == None and root.right == None):
		return root
	if (root.left == None):
		return root.right
	if (root.right == None):
		return root.left
	return root


root = BinaryTree(11)
root.insertLeft(1)
root.insertLeft(10)
root.insertLeft(1100)
root.insertRight(5)
root.getRight().set_data(2)
result = []
postorderIterative(root, result)
print result
removeHalfNodes(root)
result = []
postorderIterative(root, result)
print result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.RemoveLeavesOfBinaryTree1055
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	    
# Pre-order recursive traversal. The nodes values are appended to the result list in traversal order
def preorderRecursive(root, result):
    if not root:
        return
    
    result.append(root.data)
    preorderRecursive(root.left, result)
    preorderRecursive(root.right, result)

# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root, result):
	if not root:
		return

	inorderRecursive(root.left, result)
	result.append(root.data)
	inorderRecursive(root.right, result)

# Post-order recursive traversal. The nodes values are appended to the result list in traversal order
def postorderRecursive(root, result):
    if not root:
        return
    
    postorderRecursive(root.left, result)
    postorderRecursive(root.right, result)
    result.append(root.data)

# Pre-order iterative traversal. The nodes values are appended to the result list in traversal order
def preorderIterative(root, result):
    if not root:
        return

    stack = []
    stack.append(root)
    while stack:
        node = stack.pop()
        result.append(node.data)
        if node.right: stack.append(node.right)
        if node.left: stack.append(node.left)    

# In-order iterative traversal. The nodes values are appended to the result list in traversal order
def inorderIterative(root, result):
	if not root:
		return

	stack = []
	node = root
	while stack or node:
		if node:
			stack.append(node)
			node = node.left
		else:
			node = stack.pop()
			result.append(node.data)
			node = node.right

# Post-order iterative traversal. The nodes values are appended to the result list in traversal order
def postorderIterative(root, result=[]):
    if not root:
        return

    visited = set()
    stack = []
    node = root
    while stack or node:
        if node:
            stack.append(node)
            node = node.left
        else:
            node = stack.pop()
            if node.right and not node.right in visited:
                stack.append(node)
                node = node.right
            else:
                visited.add(node)
                result.append(node.data)
                node = None
			
def removeLeaves(root):
	if root is None:
		return	
	if (root.left == None and root.right == None):
		return None
	else:
		root.left = removeLeaves(root.left)
		root.right = removeLeaves(root.right)
	return root

root = BinaryTree(11)
root.insertLeft(1)
root.insertLeft(10)
root.insertLeft(1100)
root.insertRight(5)
root.getRight().set_data(2)
result = []
postorderIterative(root, result)
print result
removeLeaves(root)
result = []
postorderIterative(root, result)
print result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RootToLeavesTotalSum1056
    set output_file "main.py"

    set template_content '
def sumNumbers(self, root):
	if not root:
		return 0
	current = 0
	sum = [0]
	self.calSum(root, current, sum)
	return sum[0]
	
def calSum(self, root, current, sum):
	if not root:
		return
	current = current * 10 + root.data
	if not root.left and not root.right:
		sum[0] += current
		return

	self.calSum(root.left, current, sum)
	self.calSum(root.right, current, sum)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SizeofBinaryTreeRecursive1057
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
'''Binary Tree Class and its methods'''
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	
def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def findSizeRecursive(root): 
	if not root:
		return 0
	return findSizeRecursive(root.left) + findSizeRecursive(root.right) + 1

# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)


root = BinaryTree(11)
print(root.get_data())
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
inorderRecursive(root)
print findSizeRecursive(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SortedArrayToBST1058
    set output_file "main.py"

    set template_content '
def sortedArrayToBST(root, array):
	length = len(array)
	if length == 0: 
		return None
	if length == 1: 
		return TreeNode(array[0])
	root = BSTNode(array[length / 2])
	root.left = sortedArrayToBST(array[:length / 2])
	root.right = sortedArrayToBST(array[length / 2 + 1:])
	return root
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SortedLinikedListToBST1059
    set output_file "main.py"

    set template_content '
class Node:
    # constructor
    def __init__(self, data):
        self.data = data
        self.next = None
         # method for setting the data field of the node    
    def set_data(self, data):
        self.data = data
    # method for getting the data field of the node   
    def get_data(self):
        return self.data
      # method for setting the next field of the node
    def set_next(self, next):
        self.next = next
       # method for getting the next field of the node    
    def get_next(self):
        return self.next
    # returns true if the node points to another node
    def has_next(self):
            return self.next != None

# class for defining a linked list   
class LinkedList(object):
     
    # initializing a list
    def __init__(self):
        self.length = 0
        self.head = None
         
    # method to add a node in the linked list
    def addNode(self, node):
        if self.length == 0:
            self.addBeg(node)
        else:
            self.addLast(node)
             
         
    # method to add a node at the beginning of the list with a data   
    def addBeg(self, node):
        newNode = node
        newNode.next = self.head
        self.head = newNode
        self.length += 1
         
    # method to add a node after the node having the data=data. The data of the new node is value2
    def addAfterValue(self, data, node):
        newNode = node
        currentnode = self.head
         
        while currentnode.next != None or currentnode.data != data:
            if currentnode.data == data:
                newNode.next = currentnode.next
                currentnode.next = newNode
                self.length = self.length + 1
                return
            else:
                currentnode = currentnode.next
                 
        print "The data provided is not present"
                 
    def addAtPos(self, pos, node):
        count = 0
        currentnode = self.head
        previousnode = self.head
         
        if pos > self.length or pos < 0:
            print "The position does not exist. Please enter a valid position"
        else:
            while currentnode.next != None or count < pos:
                count = count + 1
                if count == pos:
                    previousnode.next = node
                    node.next = currentnode
                    self.length += 1
                    return
                     
                else:
                    previousnode = currentnode
                    currentnode = currentnode.next
         
         
                 
    def addLast(self, node):
        currentnode = self.head
         
        while currentnode.next != None:
            currentnode = currentnode.next
 
        newNode = node
        newNode.next = None
        currentnode.next = newNode
        self.length = self.length + 1
     
     
    def deleteBeg(self):
        if self.length == 0:
            print "The list is empty"
        else:
            self.head = self.head.next
            self.length -= 1
     
    def deleteLast(self):
         
        if self.length == 0:
            print "The list is empty"
        else:
            currentnode = self.head
            previousnode = self.head
             
            while currentnode.next != None:
                previousnode = currentnode
                currentnode = currentnode.next
                 
            previousnode.next = None
             
            self.length -= 1
             
         
    def deleteValue(self, data):
        currentnode = self.head
        previousnode = self.head
         
        while currentnode.next != None or currentnode.data != data:
            if currentnode.data == data:
                previousnode.next = currentnode.next
                self.length -= 1
                return
                    
            else:
                previousnode = currentnode
                currentnode = currentnode.next
                 
        print "The data provided is not present"
                 
         
         
    def deleteAtPos(self, pos):
        count = 0
        currentnode = self.head
        previousnode = self.head
 
        if pos > self.length or pos < 0:
            print "The position does not exist. Please enter a valid position"
        else:        
            while currentnode.next != None or count < pos:
                count = count + 1
                if count == pos:
                    previousnode.next = currentnode.next
                    self.length -= 1
                    return
                else:
                    previousnode = currentnode
                    currentnode = currentnode.next
                     
             
 
     
    # returns the length of the list        
    def getLength(self):
        return self.length
     
    # returns the first element of the list
    def getFirst(self):
        if self.length == 0:
            print "The list is empty"
        else:
            return self.head.data
     
    # returns the last element of the list
    def getLast(self):
         
        if self.length == 0:
            print "The list is empty"
        else:
            currentnode = self.head
             
            while currentnode.next != None:
                currentnode = currentnode.next
                 
            return currentnode.data
     
    # returns node at any position
    def getAtPos(self, pos):
        count = 0
        currentnode = self.head
         
        if pos > self.length or pos < 0:
            print "The position does not exist. Please enter a valid position"
        else:
            while currentnode.next != None or count < pos:
                count = count + 1
                if count == pos:
                    return currentnode.data
                else:
                    currentnode = currentnode.next
 
                     
    # method to print the whole list
    def printList(self):
        nodeList = []
        currentnode = self.head
        while currentnode != None:
            nodeList.append(currentnode.data)
            currentnode = currentnode.next 
             
        print nodeList  

class BSTNode:
    def __init__(root, data=None):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)  

def SortedListToBST(ll, start, end):
	if(start > end): 
		return None
	# same as (start+end)/2, avoids overflow
	mid = start + (end - start) // 2
	left = SortedListToBST(ll, start, mid - 1)
	root = BSTNode(ll.head.data)
	ll.deleteBeg()
	root.left = left
	root.right = SortedListToBST(ll, mid + 1, end)
	return root

def convertSortedListToBST(ll, n) :
	return SortedListToBST(ll, 0, n - 1)

node1 = Node(1)
node2 = Node(2)
node3 = Node(3)
node4 = Node(4)
node5 = Node(5)
node6 = Node(6)
node7 = Node(7)
node8 = Node(8)
node9 = Node(9)
ll = LinkedList()
ll.addNode(node1)
ll.addNode(node2)
ll.addNode(node3)
ll.addNode(node4)
ll.addNode(node5)
ll.addNode(node6)
ll.addNode(node7)
ll.addNode(node8)
ll.addNode(node9)
ll.printList()
root = convertSortedListToBST(ll, ll.length)                    
inOrderTraversal(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SuccessorPredessor1060
    set output_file "main.py"

    set template_content '
def successorBST(root):
	temp = None
	if root.getRight():
	    temp = root.getRight()
	    while temp.getLeft():
		temp = s.getLeft()
	return temp

# Predecessor of a node in BST
def predecessorBST(root):
	temp = None
	if root.getLeft():
	    temp = root.getLeft()
	    while temp.getRight():
		temp = temp.getRight()
	return temp
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SumofAllElementsInTree1061
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def sumInBinaryTreeLevelOrder(root):
	if root is None:
		return 0
	q = Queue()
	q.enQueue(root)
	node = None
	sum = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		sum += node.get_data()
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)
	return sum
	
		
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)

def sumInBinaryTreeRecursive(root):
	if(root == None) :
	       return 0
	return root.data + sumInBinaryTreeRecursive(root.left) + sumInBinaryTreeRecursive(root.right)



root = BinaryTree(11)
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
# inorderRecursive(root)
print sumInBinaryTreeLevelOrder(root)
print sumInBinaryTreeRecursive(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ThreadedBinaryTree1062
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def sumInBinaryTreeLevelOrder(root):
	if root is None:
		return 0
	q = Queue()
	q.enQueue(root)
	node = None
	sum = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		sum += node.get_data()
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)
	return sum
	
		
# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)

def sumInBinaryTreeRecursive(root):
	if(root == None) :
	       return 0
	return root.data + sumInBinaryTreeRecursive(root.left) + sumInBinaryTreeRecursive(root.right)



root = BinaryTree(11)
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
# inorderRecursive(root)
print sumInBinaryTreeLevelOrder(root)
print sumInBinaryTreeRecursive(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.TreeCompressionBST1063
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

    
class Stack(object):
    def __init__(self, data=None):
        self.head = None
        if data:
            for data in data:
                self.push(data)

    def push(self, data):
        temp = Node()
        temp.set_data(data)
        temp.set_next(self.head)
        self.head = temp

    def pop(self):
        if self.head is None:
            raise IndexError
        temp = self.head.get_data()
        self.head = self.head.get_next()
        return temp
	
    def peek(self):
        if self.head is None:
            raise IndexError
        return self.head.get_data()

    def isEmpty(self):
        return self.head == None
	
class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0
		
		
'''Binary Tree Class and its methods'''
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp

def insertInBinaryTreeUsingLevelOrder(root, data):
	newNode = BinaryTree(data)
	if root is None:
		root = newNode
		return root

	q = Queue()
	q.enQueue(root)
	node = None
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO

		if data == node.get_data():
			return root
		if node.left is not None:
			q.enQueue(node.left)
		else:
			node.left = newNode
			return root	
		if node.right is not None:
			q.enQueue(node.right)
		else:
			node.right = newNode
			return root

def sumInBinaryTreeLevelOrder(root):
	if root is None:
		return 0
	q = Queue()
	q.enQueue(root)
	node = None
	sum = 0
	while not q.isEmpty():
		node = q.deQueue()  # dequeue FIFO
		sum += node.get_data()
		if node.left is not None:
			q.enQueue(node.left)

		if node.right is not None:
			q.enQueue(node.right)
	return sum
	
		
# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root):
	if not root:
		return

	inorderRecursive(root.left)
	print root.data
	inorderRecursive(root.right)

def sumInBinaryTreeRecursive(root):
	if(root == None) :
	       return 0
	return root.data + sumInBinaryTreeRecursive(root.left) + sumInBinaryTreeRecursive(root.right)



root = BinaryTree(11)
root = insertInBinaryTreeUsingLevelOrder(root, 1)
root = insertInBinaryTreeUsingLevelOrder(root, 2)
root = insertInBinaryTreeUsingLevelOrder(root, 3)
root = insertInBinaryTreeUsingLevelOrder(root, 4)
root = insertInBinaryTreeUsingLevelOrder(root, 125)
root = insertInBinaryTreeUsingLevelOrder(root, 225)
# inorderRecursive(root)
print sumInBinaryTreeLevelOrder(root)
print sumInBinaryTreeRecursive(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TreeCompressionWithLevelOrder1064
    set output_file "main.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None

class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0

class BSTNode(object):
    def __init__(self, data, data2):
        self.data = data
	self.data2 = data2	
        self.left = None
        self.right = None
	
    # set data
    def set_data(self, data):
        self.data = data
    # get data   
    def get_data(self):
        return self.data	
    # get left child of a node
    def getLeft(self):
        return self.left
    # get right child of a node
    def getRight(self):
        return self.right
    # get left child of a node
    def setLeft(self, left):
        self.left = left
    # get right child of a node
    def setRight(self, right):
        self.right = right
	
    def search(self, data):
        if self.data == data:
            return self

        if self.left is not None and self.data > data:
            return self.left.search(data)
        elif self.right is not None:
            return self.right.search(data)

        return None
    
    def insert(self, data, data2):
        self.insertNode(BSTNode(data, data2))

    def insertNode(self, node):
        # Base case: empty root node
        if self.data is None:
            self.data = node.data
	    self.data2 = node.data2
            return

        if node.data < self.data:
            if not self.left:
                self.left = node
            else:
                self.left.insertNode(node)
        elif node.data > self.data:
            if not self.right:
                self.right = node
            else:
                self.right.insertNode(node)
        else:
            pass  # Duplicate values are ignored

    def delete(self, data):
        # Base case: root node
        if self.data == data:
            self.deleteNode()
        elif data < self.data and self.left is not None:
            self.left.delete(data)
        elif self.right is not None:
            self.right.delete(data)

    def deleteNode(self):
        if self.right and self.left:
            # Node has two children Replace data with successor s and delete s
            if self.right:
                s = self.successor()
                self.data = s.data
                s.deleteNode()
        elif self.right or self.left:
            # Node has single child. Replace it with only child
            child = self.right is not None and self.right or self.left

            self.data = child.data
            self.left = child.left
            self.right = child.right
        else:
            # None has no children, erase data and update parent
            self.data = None

    def successor(self):
        s = None
        if self.right:
            s = self.right
            while s.left:
                s = s.left
        return s

    def predecessor(self):
        s = None
        if self.left:
            s = self.left
            while s.right:
                s = s.right
        return s

    def __str__(self):
        return "(%s, l: %s, r: %s)" % (self.data, self.left is not None and self.left.data or 'N', self.right is not None and self.right.data or 'N')

def inorderRecursive(root):
	if not root:
		return
	inorderRecursive(root.left)
	print root.data, "--->", root.data2 
	inorderRecursive(root.getRight())

def findMin(root):
	currentNode = root
	if currentNode == None:  
		return None
	while currentNode.getLeft() != None:
		currentNode = currentNode.getLeft()
	return currentNode

# Search the key from node, iteratively
def findMax(root):
	currentNode = root
	if currentNode == None:  
		return None
	while currentNode.right != None:
		currentNode = currentNode.right
	return currentNode

def treeCompression (root):
	Q = Queue()
	if(root == None): 
		return None

	Q.enQueue(root)
	while(not Q.isEmpty()):
		temp = Q.deQueue()
		if(temp.left and temp.right and (temp.left.data2 > temp.right.data2)):
			temp2 = findMax(temp.left)
		else: temp2 = findMin(temp.right)

		temp.data2 = temp2.data2  # Process current node
		root.delete(temp.data)
		if(temp.left):
			Q.enQueue(temp.left)
		if(temp.right): 
			Q.enQueue(temp.right)
			
root = BSTNode(6, 5)
root.insert(4, 2)
root.insert(9, 2)
root.insert(2, 0)
root.insert(5, 0)
root.insert(7, 1)
root.insert(8, 0)
inorderRecursive(root)
print treeCompression(root)
inorderRecursive(root)
inorderRecursive(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.TreeDiameter1065
    set output_file "main.py"

    set template_content '
def findMaxLen(root):
	nMaxLen = 0
	if (root == None):
		return 0
	if (root.left == None):
		root.nMaxLeft = 0
	if (root.right == None):
		root.nMaxRight = 0
	if (root.left != None):
		findMaxLen(root.left)
	if (root.right != None):
		findMaxLen(root.right)
	if (root.left != None):
		nTempMaxLen = 0
		nTempMaxLen = max(root.left.nMaxLeft, root.left.nMaxRight)
		root.nMaxLeft = nTempMaxLen + 1

	if (root.right != None):
		nTempMaxLen = 0
		nTempMaxLen = max(root.right.nMaxLeft, root.right.nMaxRight)
		root.nMaxRight = nTempMaxLen + 1
	
	if (root.nMaxLeft + root.nMaxRight > nMaxLen):
		nMaxLen = root.nMaxLeft + root.nMaxRight
	return nMaxLen

ptr = 0
def diameterOfTree(root):
	global ptr
	if(not root) :
		return 0
	left = diameterOfTree(root.left);
	right = diameterOfTree(root.right);

	if(left + right > ptr):
	      ptr = left + right
	return max(left, right) + 1
 

# Alternative Coding
def diameter(root):
	if (root == None): 
		return 0

	lHeight = height(root.eft)
	rHeight = height(root.right)
	lDiameter = diameter(root.left)
	rDiameter = diameter(root.right)
	return max(lHeight + rHeight + 1, max(lDiameter, rDiameter))

def height(root):
	if (root == None) :
		return 0
	return 1 + max(height(root.left), height(root.right))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TreeMaximumSumPath1066
    set output_file "main.py"

    set template_content '
def treeMaximumSumPath(node, is_left=True, Lpath={}, Rpath={}):
    if is_left:
        # left sub-tree
        if not node.left:
            Lpath[node.id] = 0
            return 0
        else:
            Lpath[node.id] = node.data + max(
                treeMaximumSumPath(node.left, True, Lpath, Rpath),
                treeMaximumSumPath(node.left, False, Lpath, Rpath)
            )
            return Lpath[node.id]
    else:
        # right sub-tree
        if not node.right:
            Rpath[node.id] = 0
            return 0
        else:
            Rpath[node.id] = node.data + max(
                treeMaximumSumPath(node.right, True, Lpath, Rpath),
                treeMaximumSumPath(node.right, False, Lpath, Rpath)
            )
            return Rpath[node.id]


def maxsum_path(root):
    Lpath = {}
    Rpath = {}
    treeMaximumSumPath(root, True, Lpath, Rpath)
    treeMaximumSumPath(root, False, Lpath, Rpath)
    print 'Left-path:', Lpath
    print 'Right-path:', Rpath
    path2sum = dict((i, Lpath[i] + Rpath[i]) for i in Lpath.keys())
    i = max(path2sum, key=path2sum.get)
    print 'The path going through node', i, 'with max sum', path2sum[i]
    return path2sum[i]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TreemaxDepth1067
    set output_file "main.py"

    set template_content '
def maxDepth(root):
	if root == None:
	    return 0
	return max(maxDepth(root.getLeft()), maxDepth(root.getRight())) + 1

def maxDepth(self, root):
	if root == None:
	    return 0
	q = []
	q.append([root, 1])
	temp = 0
	while len(q) != 0:
	    node, depth = q.pop()
	    depth = max(temp, dep)
	    if node.getLeft() != None:
		q.append([node.getLeft(), depth + 1])
	    if node.getRight() != None:
		q.append([node.getRight(), depth + 1])
	return temp

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TrimBST1068
    set output_file "main.py"

    set template_content '
def trimBST(root, minVal, maxVal): 
	if not root: 
		return 
	root.setLeft(trimBST(root.getLeft(), minVal, maxVal)) 
	root.setRight(trimBST(root.getRight(), minVal, maxVal)) 
	if minVal <= root.get_data() <= maxVal: 
		return root 
	if root.get_data() < minVal: 
		return root.getRight() 
	if root.get_data() > maxVal: 
		return root.getLeft()

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.VerticalSumInBinaryTree1069
    set output_file "main.py"

    set template_content '
class BinaryTree:
	def __init__(self, data):
		self.data = data  # root node
		self.left = None  # left child
		self.right = None  # right child
	# set data
	def set_data(self, data):
		self.data = data
	# get data   
	def get_data(self):
		return self.data	
	# get left child of a node
	def getLeft(self):
		return self.left
	# get right child of a node
	def getRight(self):
		return self.right
	
	def insertLeft(self, newNode):
		if self.left == None:
			self.left = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.left = self.left
			self.left = temp

	def insertRight(self, newNode):
		if self.right == None:
			self.right = BinaryTree(newNode)
		else:
			temp = BinaryTree(newNode)
			temp.right = self.right
			self.right = temp
	    
# Pre-order recursive traversal. The nodes values are appended to the result list in traversal order
def preorderRecursive(root, result):
    if not root:
        return
    
    result.append(root.data)
    preorderRecursive(root.left, result)
    preorderRecursive(root.right, result)

# In-order recursive traversal. The nodes values are appended to the result list in traversal order
def inorderRecursive(root, result):
	if not root:
		return

	inorderRecursive(root.left, result)
	result.append(root.data)
	inorderRecursive(root.right, result)

# Post-order recursive traversal. The nodes values are appended to the result list in traversal order
def postorderRecursive(root, result):
    if not root:
        return
    
    postorderRecursive(root.left, result)
    postorderRecursive(root.right, result)
    result.append(root.data)

# Pre-order iterative traversal. The nodes values are appended to the result list in traversal order
def preorderIterative(root, result):
    if not root:
        return

    stack = []
    stack.append(root)
    while stack:
        node = stack.pop()
        result.append(node.data)
        if node.right: stack.append(node.right)
        if node.left: stack.append(node.left)    

# In-order iterative traversal. The nodes values are appended to the result list in traversal order
def inorderIterative(root, result):
	if not root:
		return

	stack = []
	node = root
	while stack or node:
		if node:
			stack.append(node)
			node = node.left
		else:
			node = stack.pop()
			result.append(node.data)
			node = node.right

# Post-order iterative traversal. The nodes values are appended to the result list in traversal order
def postorderIterative(root, result):
    if not root:
        return

    visited = set()
    stack = []
    node = root
    while stack or node:
        if node:
            stack.append(node)
            node = node.left
        else:
            node = stack.pop()
            if node.right and not node.right in visited:
                stack.append(node)
                node = node.right
            else:
                visited.add(node)
                result.append(node.data)
                node = None
		
def levelOrder(root, result):
    if root is None:
      return
 
    q = Queue.Queue()
    q.put(self.root)
    n = None
 
    while not q.empty():
      n = q.get()  # dequeue FIFO
      result.append(node.get_data())
      if n.left is not None:
        q.put(n.left)
 
      if n.right is not None:
        q.put(n.right)	
	
root = BinaryTree(11)
print(root.get_data())

root.insertLeft(1)
root.insertLeft(10)
root.insertLeft(1100)
print(root.getLeft().get_data())
root.insertRight(5)
print(root.getRight().get_data())
root.getRight().set_data(2)
print(root.getRight().get_data())	

hashTable = {}
def VerticalSumInBinaryTree(root, column):
	if not root:
		return
	if not column in hashTable:
		hashTable[column] = 0
	hashTable[column] = hashTable[column] + root.data
	VerticalSumInBinaryTree(root.left, column - 1)
	VerticalSumInBinaryTree(root.right, column + 1)
	
VerticalSumInBinaryTree(root, 0)
print hashTable

'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ZigzagLevelOrder1070
    set output_file "main.py"

    set template_content '
def zigzagLevelOrder(self, root):
	result = []
	currentLevel = []
	if root != None:
	    currentLevel.append(root)
	leftToRight = True
	while len(currentLevel) > 0:
	    levelresult = []
	    nextLevel = []
	    while len(currentLevel) > 0:
		node = currentLevel.pop()
		levelresult.append(node.val)
		if leftToRight:
		    if node.left != None:
			nextLevel.append(node.left)
		    if node.right != None:
			nextLevel.append(node.right)
		else:
		    if node.right != None:
			nextLevel.append(node.right)
		    if node.left != None:
			nextLevel.append(node.left)
	    currentLevel = nextLevel
	    result.append(levelresult)
	    leftToRight = not leftToRight
	return result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.symmetric_tree1071
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def isSymmetric(self, root: Optional[TreeNode]) -> bool:
        def recur(L, R):
            if not L and not R: return True
            if not L or not R or L.val != R.val: return False
            return recur(L.left, R.right) and recur(L.right, R.left)
        return not root or recur(root.left, root.right)


root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.isSymmetric(root)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.binary_tree_level_order_traversal1072
    set output_file "main.py"

    set template_content '
ffrom include import *

class Solution:
    def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        if not root: return []
        res, queue = [], collections.deque()
        queue.append(root)
        while queue:
            tmp = []
            for _ in range(len(queue)):
                node = queue.popleft()
                tmp.append(node.val)
                if node.left: queue.append(node.left)
                if node.right: queue.append(node.right)
            res.append(tmp)
        return res


root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.levelOrder(root)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.binary_tree_zigzag_level_order_traversal1073
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        if not root: return []
        res, queue = [], collections.deque()
        queue.append(root)
        while queue:
            tmp = []
            for _ in range(len(queue)):
                node = queue.popleft()
                tmp.append(node.val)
                if node.left: queue.append(node.left)
                if node.right: queue.append(node.right)
            res.append(tmp)
        return res


root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.levelOrder(root)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.binary_tree_zigzag_level_order_traversal1074
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def zigzagLevelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        if not root: return []
        res, deque = [], collections.deque()
        deque.append(root)
        while deque:
            tmp = []
            # 打印奇数层
            for _ in range(len(deque)):
                # 从左向右打印
                node = deque.popleft()
                tmp.append(node.val)
                # 先左后右加入下层节点
                if node.left: deque.append(node.left)
                if node.right: deque.append(node.right)
            res.append(tmp)
            if not deque: break # 若为空则提前跳出
            # 打印偶数层
            tmp = []
            for _ in range(len(deque)):
                # 从右向左打印
                node = deque.pop()
                tmp.append(node.val)
                # 先右后左加入下层节点
                if node.right: deque.appendleft(node.right)
                if node.left: deque.appendleft(node.left)
            res.append(tmp)
        return res


root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.zigzagLevelOrder(root)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.binary_tree_zigzag_level_order_traversal1074
    set output_file "main.py"

    set template_content '
ffrom include import *

class Solution:
    def zigzagLevelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        if not root: return []
        res, queue = [], collections.deque()
        queue.append(root)
        while queue:
            tmp = []
            for _ in range(len(queue)):
                node = queue.popleft()
                tmp.append(node.val)
                if node.left: queue.append(node.left)
                if node.right: queue.append(node.right)
            res.append(tmp[::-1] if len(res) % 2 else tmp)
        return res

root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.zigzagLevelOrder(root)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.maximum_depth_of_binary_tree1075
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if not root: return 0
        return max(self.maxDepth(root.left), self.maxDepth(root.right)) + 1

# Test case 1: Basic binary tree
root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.maxDepth(root)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.maximum_depth_of_binary_tree1076
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def maxDepth(self, root: TreeNode) -> int:
        if not root: return 0
        queue, res = [root], 0
        while queue:
            tmp = []
            for node in queue:
                if node.left: tmp.append(node.left)
                if node.right: tmp.append(node.right)
            queue = tmp
            res += 1
        return res

# Test case 1: Basic binary tree
root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.maxDepth(root)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.construct_binary_tree_from_preorder1077
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def buildTree(self, preorder: List[int], inorder: List[int]) -> TreeNode:
        def recur(root, left, right):
            if left > right: return                               # 递归终止
            node = TreeNode(preorder[root])                       # 建立根节点
            i = dic[preorder[root]]                               # 划分根节点、左子树、右子树
            node.left = recur(root + 1, left, i - 1)              # 开启左子树递归
            node.right = recur(i - left + root + 1, i + 1, right) # 开启右子树递归
            return node                                           # 回溯返回根节点
        dic, preorder = {}, preorder
        for i in range(len(inorder)):
            dic[inorder[i]] = i
        return recur(0, 0, len(inorder) - 1)

test_input_preorder = [3, 9, 20, 15, 7]
test_input_inorder = [9, 3, 15, 20, 7]
slt = Solution()
result = slt.buildTree(test_input_preorder, test_input_inorder)
print_tree(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.regular_expression_matching1078
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        m, n = len(s) + 1, len(p) + 1
        dp = [[False] * n for _ in range(m)]
        dp[0][0] = True
        for j in range(2, n, 2):
            dp[0][j] = dp[0][j - 2] and p[j - 1] == '*'
        for i in range(1, m):
            for j in range(1, n):
                dp[i][j] = dp[i][j - 2] or dp[i - 1][j] and (s[i - 1] == p[j - 2] or p[j - 2] == '.') \
                           if p[j - 1] == '*' else \
                           dp[i - 1][j - 1] and (p[j - 1] == '.' or s[i - 1] == p[j - 1])
        return dp[-1][-1]


test_input_s = "aa"
test_input_p = "a"
expected_output = False
slt = Solution()
result = slt.isMatch(test_input_s, test_input_p)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.regular_expression_matching1079
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        m, n = len(s) + 1, len(p) + 1
        dp = [[False] * n for _ in range(m)]
        dp[0][0] = True
        for j in range(2, n, 2):
            dp[0][j] = dp[0][j - 2] and p[j - 1] == '*'
        for i in range(1, m):
            for j in range(1, n):
                dp[i][j] = dp[i][j - 2] or dp[i - 1][j] and (s[i - 1] == p[j - 2] or p[j - 2] == '.') \
                           if p[j - 1] == '*' else \
                           dp[i - 1][j - 1] and (p[j - 1] == '.' or s[i - 1] == p[j - 1])
        return dp[-1][-1]


test_input_s = "aa"
test_input_p = "a"
expected_output = False
slt = Solution()
result = slt.isMatch(test_input_s, test_input_p)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.balanced_binary_tree1080
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def isBalanced(self, root: Optional[TreeNode]) -> bool:
        def recur(root):
            if not root: return 0
            left = recur(root.left)
            if left == -1: return -1
            right = recur(root.right)
            if right == -1: return -1
            return max(left, right) + 1 if abs(left - right) <= 1 else -1
        return recur(root) != -1

root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.isBalanced(root)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.balanced_binary_tree1081
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def isBalanced(self, root: Optional[TreeNode]) -> bool:
        if not root: return True
        return abs(self.depth(root.left) - self.depth(root.right)) <= 1 and \
            self.isBalanced(root.left) and self.isBalanced(root.right)
    def depth(self, root):
        if not root: return 0
        return max(self.depth(root.left), self.depth(root.right)) + 1

root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.isBalanced(root)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.path_sum1083
    set output_file "main.py"

    set template_content '
from typing import Optional

class Solution:
    def pathSum(self, root: Optional[TreeNode], targetSum: int) -> List[List[int]]:
        res, path = [], []
        def recur(root, tar):
            if not root: return
            path.append(root.val)
            tar -= root.val
            if tar == 0 and not root.left and not root.right:
                res.append(list(path))
            recur(root.left, tar)
            recur(root.right, tar)
            path.pop()
        recur(root, targetSum)
        return res

root = list_to_tree([5, 4, 8, 11, None, 13, 4, 7, 2, None, None, 5, 1])
targetSum = 22
slt = Solution()
result = slt.pathSum(root, targetSum)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.container_with_most_water1084
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def maxArea(self, height: List[int]) -> int:
        i, j, res = 0, len(height) - 1, 0
        while i < j:
            if height[i] < height[j]:
                res = max(res, height[i] * (j - i))
                i += 1
            else:
                res = max(res, height[j] * (j - i))
                j -= 1
        return res

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.maxArea(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.best_time_to_buy_and_sell_stock1085
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        cost, profit = float('+inf'), 0
        for price in prices:
            cost = min(cost, price)
            profit = max(profit, price - cost)
        return profit

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.maxProfit(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.best_time_to_buy_and_sell_stock1086
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        profit = 0
        for i in range(1, len(prices)):
            tmp = prices[i] - prices[i - 1]
            if tmp > 0: profit += tmp
        return profit

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.maxProfit(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.candy1087
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def candy(self, ratings: List[int]) -> int:
        left = [1 for _ in range(len(ratings))]
        right = left[:]
        for i in range(1, len(ratings)):
            if ratings[i] > ratings[i - 1]: left[i] = left[i - 1] + 1
        count = left[-1]
        for i in range(len(ratings) - 2, -1, -1):
            if ratings[i] > ratings[i + 1]: right[i] = right[i + 1] + 1
            count += max(left[i], right[i])
        return count

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.candy(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.single_number1088
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def singleNumber(self, nums: List[int]) -> List[int]:
        x = 0
        for num in nums:  # 1. 遍历 nums 执行异或运算
            x ^= num      
        return x;         # 2. 返回出现一次的数字 x


test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.singleNumber(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.single_number1089
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        ones, twos = 0, 0
        for num in nums:
            ones = ones ^ num & ~twos
            twos = twos ^ num & ~ones
        return ones

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.singleNumber(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.single_number1090
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        counts = [0] * 32
        for num in nums:
            for j in range(32):
                counts[j] += num & 1
                num >>= 1
        res, m = 0, 3
        for i in range(32):
            res <<= 1
            res |= counts[31 - i] % m
        return res if counts[31] % m == 0 else ~(res ^ 0xffffffff)


test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.singleNumber(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.copy_list_with_random_pointer1091
    set output_file "main.py"

    set template_content '
from include import *

# Definition for a Node.
class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = int(x)
        self.next = next
        self.random = random

class Solution:
    def copyRandomList(self, head: 'Node') -> 'Node':
        if not head: return None
        dic = {}
        # 复制各节点，并建立 "原节点 -> 新节点" 的 Map 映射
        cur = head
        while cur:
            dic[cur] = Node(cur.val)
            cur = cur.next
        cur = head
        # 构建新节点的 next 和 random 指向
        while cur:
            dic[cur].next = dic.get(cur.next)
            dic[cur].random = dic.get(cur.random)
            cur = cur.next
        # 返回新链表的头节点
        return dic[head]


node1 = Node(7)
node2 = Node(13)
node3 = Node(11)
node4 = Node(10)
node5 = Node(1)
node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5
node2.random = node1
node3.random = node5
node4.random = node3
node5.random = node1

slt = Solution()
result = slt.copyRandomList(node1)
print("Copied list head value:", result.val if result else None)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.copy_list_with_random_pointer1092
    set output_file "main.py"

    set template_content '
from include import *


# Definition for a Node.
class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = int(x)
        self.next = next
        self.random = random

class Solution:
    def copyRandomList(self, head: 'Node') -> 'Node':
        if not head: return None
        cur = head
        # 复制各节点，并构建拼接链表
        while cur:
            tmp = Node(cur.val)
            tmp.next = cur.next
            cur.next = tmp
            cur = tmp.next
        # 构建新节点的 random 指向
        cur = head
        while cur:
            if cur.random:
                cur.next.random = cur.random.next
            cur = cur.next.next
        # 拆分两链表
        cur = res = head.next
        pre = head
        while cur.next:
            pre.next = pre.next.next
            cur.next = cur.next.next
            pre = pre.next
            cur = cur.next
        pre.next = None # 单独处理原链表尾节点
        return res      # 返回新链表头节点


node1 = Node(7)
node2 = Node(13)
node3 = Node(11)
node4 = Node(10)
node5 = Node(1)
node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5
node2.random = node1
node3.random = node5
node4.random = node3
node5.random = node1

slt = Solution()
result = slt.copyRandomList(node1)
print("Copied list head value:", result.val if result else None)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.copy_list_with_random_pointer1093
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def copyRandomList(self, head: 'Node') -> 'Node':
        cur = head
        dum = pre = Node(0)
        while cur:
            node = Node(cur.val) # 复制节点 cur
            pre.next = node      # 新链表的 前驱节点 -> 当前节点
            # pre.random = '???' # 新链表的 「 前驱节点 -> 当前节点 」 无法确定
            cur = cur.next       # 遍历下一节点
            pre = node           # 保存当前新节点
        return dum.next


slt = Solution()
# result = slt.copyRandomList(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.copy_list_with_random_pointer1094
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def copyRandomList(self, head: 'Node') -> 'Node':
        if not head: return
        dic = {}
        # 3. 复制各节点，并建立 “原节点 -> 新节点” 的 Map 映射
        cur = head
        while cur:
            dic[cur] = Node(cur.val)
            cur = cur.next
        cur = head
        # 4. 构建新节点的 next 和 random 指向
        while cur:
            dic[cur].next = dic.get(cur.next)
            dic[cur].random = dic.get(cur.random)
            cur = cur.next
        # 5. 返回新链表的头节点
        return dic[head]



slt = Solution()
# result = slt.copyRandomList(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.copy_list_with_random_pointer1095
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def copyRandomList(self, head: 'Node') -> 'Node':
        if not head: return
        cur = head
        # 1. 复制各节点，并构建拼接链表
        while cur:
            tmp = Node(cur.val)
            tmp.next = cur.next
            cur.next = tmp
            cur = tmp.next
        # 2. 构建各新节点的 random 指向
        cur = head
        while cur:
            if cur.random:
                cur.next.random = cur.random.next
            cur = cur.next.next
        # 3. 拆分两链表
        cur = res = head.next
        pre = head
        while cur.next:
            pre.next = pre.next.next
            cur.next = cur.next.next
            pre = pre.next
            cur = cur.next
        pre.next = None # 单独处理原链表尾节点
        return res      # 返回新链表头节点

slt = Solution()
# result = slt.copyRandomList(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.linked_list_cycle1096
    set output_file "main.py"

    set template_content '
from include import *

class Solution(object):
    def detectCycle(self, head):
        fast, slow = head, head
        while True:
            if not (fast and fast.next): return
            fast, slow = fast.next.next, slow.next
            if fast == slow: break
        fast = head
        while fast != slow:
            fast, slow = fast.next, slow.next
        return fast

slt = Solution()
# result = slt.detectCycle(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.running_sum_of_1d_array1097
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def runningSum(self, nums: List[int]) -> List[int]:
        dp = [0] * len(nums)
        dp[0] = nums[0]
        for i in range(1, len(nums)):
            dp[i] = dp[i - 1] + nums[i]
        return dp

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.runningSum(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.reverse_words_in_a_string1098
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def reverseWords(self, s: str) -> str:
        s = s.strip()                            # 删除首尾空格
        i = j = len(s) - 1
        res = []
        while i >= 0:
            while i >= 0 and s[i] != ' ': i -= 1 # 搜索首个空格
            res.append(s[i + 1: j + 1])          # 添加单词
            while i >= 0 and s[i] == ' ': i -= 1 # 跳过单词间空格
            j = i                                # j 指向下个单词的尾字符
        return ' '.join(res)                     # 拼接并返回


test_input = "example"
slt = Solution()
result = slt.reverseWords(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.reverse_words_in_a_string1098
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def reverseWords(self, s: str) -> str:
        s = s.strip()         # 删除首尾空格
        strs = s.split()      # 分割字符串
        strs.reverse()        # 翻转单词列表
        return ' '.join(strs) # 拼接为字符串并返回

# Test case 1
test_input = "example"

# ====== Driver Code ======
slt = Solution()
result = slt.reverseWords(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.reverse_words_in_a_string1099
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reverseWords(self, s: str) -> str:
        return ' '.join(s.strip().split()[::-1])

test_input = "example"
slt = Solution()
result = slt.reverseWords(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.find_minimum_in_rotated_sorted_array1100
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def findMin(self, nums: [int]) -> int:
        i, j = 0, len(nums) - 1
        while i < j:
            m = (i + j) // 2
            if nums[m] > nums[j]: i = m + 1
            elif nums[m] < nums[j]: j = m
            else: j -= 1
        return nums[i]

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.findMin(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_minimum_in_rotated_sorted_array1101
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def findMin(self, nums: [int]) -> int:
        i, j = 0, len(nums) - 1
        while i < j:
            m = (i + j) // 2
            if nums[m] > nums[j]: i = m + 1
            elif nums[m] < nums[j]: j = m
            else: return min(nums[i:j])
        return nums[i]

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.findMin(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.min_stack1102
    set output_file "main.py"

    set template_content '
from include import *

class MinStack:
    def __init__(self):
        self.stack = []
        self.min_stack = []
    def push(self, x: int) -> None:
        self.stack.append(x)
        if not self.min_stack or x <= self.min_stack[-1]: 
            self.min_stack.append(x)
    def pop(self) -> None:
        if self.stack.pop() == self.min_stack[-1]:
            self.min_stack.pop()
    def top(self) -> int:
        return self.stack[-1]
    def getMin(self) -> int:
        return self.min_stack[-1]


operations = ["MinStack", "push", "push", "push", "getMin", "pop", "top", "getMin"]
values = [[], [-2], [0], [-3], [], [], [], []]
obj = MinStack()
obj.push(-2)
obj.push(0)
obj.push(-3)
print("Min:", obj.getMin())
obj.pop()
print("Top:", obj.top())
print("Min:", obj.getMin())
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.three_sum1103
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def threeSum(self, nums: [int]) -> [[int]]:
        nums.sort()
        res, k = [], 0
        for k in range(len(nums) - 2):
            if nums[k] > 0: break # 1. because of j > i > k.
            if k > 0 and nums[k] == nums[k - 1]: continue # 2. skip the same `nums[k]`.
            i, j = k + 1, len(nums) - 1
            while i < j: # 3. double pointer
                s = nums[k] + nums[i] + nums[j]
                if s < 0:
                    i += 1
                    while i < j and nums[i] == nums[i - 1]: i += 1
                elif s > 0:
                    j -= 1
                    while i < j and nums[j] == nums[j + 1]: j -= 1
                else:
                    res.append([nums[k], nums[i], nums[j]])
                    i += 1
                    j -= 1
                    while i < j and nums[i] == nums[i - 1]: i += 1
                    while i < j and nums[j] == nums[j + 1]: j -= 1
        return res


test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.threeSum(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.intersection_of_two_linked_lists1104
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def getIntersectionNode(self, headA: ListNode, headB: ListNode) -> ListNode:
        A, B = headA, headB
        while A != B:
            A = A.next if A else headB
            B = B.next if B else headA
        return A

headA = list_to_linked_list([4, 1, 8, 4, 5])
headB = list_to_linked_list([5, 6, 1, 8, 4, 5])
slt = Solution()
result = slt.getIntersectionNode(headA, headB)
print("Intersection node value:", result.val if result else None)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.two_sum1105
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def twoSum(self, numbers: List[int], target: int) -> List[int]:
        i, j = 0, len(numbers) - 1
        while i < j:
            s = numbers[i] + numbers[j]
            if s > target: j -= 1
            elif s < target: i += 1
            else: return i + 1, j + 1
        return []

test_input_numbers = [2, 7, 11, 15]
test_input_target = 9
expected_output = [1, 2]
slt = Solution()
result = slt.twoSum(test_input_numbers, test_input_target)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.majority_element1106
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        votes = 0
        for num in nums:
            if votes == 0: x = num
            votes += 1 if num == x else -1
        return x

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.majorityElement(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.majority_element1107
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        votes, count = 0, 0
        for num in nums:
            if votes == 0: x = num
            votes += 1 if num == x else -1
        # 验证 x 是否为众数
        for num in nums:
            if num == x: count += 1
        return x if count > len(nums) // 2 else 0 # 当无众数时返回 0

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.majorityElement(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.largest_number1108
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def largestNumber(self, nums: List[int]) -> str:
        def sort_rule(x, y):
            a, b = x + y, y + x
            if a < b: return 1
            elif a > b: return -1
            else: return 0
        strs = [str(num) for num in nums]
        strs.sort(key = cmp_to_key(sort_rule))
        if strs[0] == "0":
            return "0"
        return ''.join(strs)


test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.largestNumber(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.largest_number1109
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def largestNumber(self, nums: List[int]) -> str:
        def quick_sort(l , r):
            if l >= r: return
            i, j = l, r
            while i < j:
                while strs[j] + strs[l] >= strs[l] + strs[j] and i < j: j -= 1
                while strs[i] + strs[l] <= strs[l] + strs[i] and i < j: i += 1
                strs[i], strs[j] = strs[j], strs[i]
            strs[i], strs[l] = strs[l], strs[i]
            quick_sort(l, i - 1)
            quick_sort(i + 1, r)
        strs = [str(num) for num in nums]
        quick_sort(0, len(strs) - 1) 
        if strs[-1] == "0":
            return "0"
        return ''.join(strs[::-1])

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.largestNumber(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.find_the_winner_of_the_circular_game1110
    set output_file "main.py"

    set template_content '
rom include import *

class Solution:
    def findTheWinner(self, n: int, k: int) -> int:
        x = 0
        for i in range(2, n + 1):
            x = (x + k) % i
        return x + 1

slt = Solution()
# result = slt.findTheWinner(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP._number_of_1_bits1111
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def hammingWeight(self, n: int) -> int:
        res = 0
        while n:
            res += n & 1
            n >>= 1
        return res

slt = Solution()
# result = slt.hammingWeight(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP._number_of_1_bits1112
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def hammingWeight(self, n: int) -> int:
        res = 0
        while n:
            res += 1
            n &= n - 1
        return res


slt = Solution()
# result = slt.hammingWeight(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.house_robber1113
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def rob(self, nums: List[int]) -> int:
        cur, pre = 0, 0
        for num in nums:
            cur, pre = max(pre + num, cur), cur
        return cur

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.rob(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.isomorphic_strings1114
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def isIsomorphic(self, s: str, t: str) -> bool:
        s2t, t2s = {}, {}
        for a, b in zip(s, t):
            # 对于已有映射 a -> s2t[a]，若和当前字符映射 a -> b 不匹配，
            # 说明有一对多的映射关系，则返回 false ；
            # 对于映射 b -> a 也同理
            if a in s2t and s2t[a] != b or \
               b in t2s and t2s[b] != a:
                return False
            s2t[a], t2s[b] = b, a
        return True


test_input_s = "egg"
test_input_t = "add"
expected_output = True
slt = Solution()
result = slt.isIsomorphic(test_input_s, test_input_t)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.reverse_linked_list1115
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def reverseList(self, head: ListNode) -> ListNode:
        cur, pre = head, None
        while cur:
            tmp = cur.next # 暂存后继节点 cur.next
            cur.next = pre # 修改 next 引用指向
            pre = cur      # pre 暂存 cur
            cur = tmp      # cur 访问下一节点
        return pre

head = list_to_linked_list([1, 2, 3, 4, 5])
slt = Solution()
result = slt.reverseList(head)
print_linked_list(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.reverse_linked_list1116
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def reverseList(self, head: ListNode) -> ListNode:
        cur, pre = head, None
        while cur:
            cur.next, pre, cur = pre, cur, cur.next
        return pre

head = list_to_linked_list([1, 2, 3, 4, 5])
slt = Solution()
result = slt.reverseList(head)
print_linked_list(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.reverse_linked_list1117
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def reverseList(self, head: ListNode) -> ListNode:
        def recur(cur, pre):
            if not cur: return pre     # 终止条件
            res = recur(cur.next, cur) # 递归后继节点
            cur.next = pre             # 修改节点引用指向
            return res                 # 返回反转链表的头节点
        return recur(head, None)       # 调用递归并返回

head = list_to_linked_list([1, 2, 3, 4, 5])
slt = Solution()
result = slt.reverseList(head)
print_linked_list(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.course_schedule1118
    set output_file "main.py"

    set template_content '
from include import *

from collections import deque
class Solution:
    def canFinish(self, numCourses: int, prerequisites: List[List[int]]) -> bool:
        indegrees = [0 for _ in range(numCourses)]
        adjacency = [[] for _ in range(numCourses)]
        queue = deque()
        # Get the indegree and adjacency of every course.
        for cur, pre in prerequisites:
            indegrees[cur] += 1
            adjacency[pre].append(cur)
        # Get all the courses with the indegree of 0.
        for i in range(len(indegrees)):
            if not indegrees[i]: queue.append(i)
        # BFS TopSort.
        while queue:
            pre = queue.popleft()
            numCourses -= 1
            for cur in adjacency[pre]:
                indegrees[cur] -= 1
                if not indegrees[cur]: queue.append(cur)
        return not numCourses


test_input_numCourses = 2
test_input_prerequisites = [[1, 0]]
expected_output = True
slt = Solution()
result = slt.canFinish(test_input_numCourses, test_input_prerequisites)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.course_schedule1119
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def canFinish(self, numCourses: int, prerequisites: List[List[int]]) -> bool:
        def dfs(i, adjacency, flags):
            if flags[i] == -1: return True
            if flags[i] == 1: return False
            flags[i] = 1
            for j in adjacency[i]:
                if not dfs(j, adjacency, flags): return False
            flags[i] = -1
            return True
        adjacency = [[] for _ in range(numCourses)]
        flags = [0 for _ in range(numCourses)]
        for cur, pre in prerequisites:
            adjacency[pre].append(cur)
        for i in range(numCourses):
            if not dfs(i, adjacency, flags): return False
        return True


test_input_numCourses = 2
test_input_prerequisites = [[1, 0]]
expected_output = True
slt = Solution()
result = slt.canFinish(test_input_numCourses, test_input_prerequisites)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.valid_parentheses1120
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def isValid(self, s: str) -> bool:
        dic = {'{': '}',  '[': ']', '(': ')', '?': '?'}
        stack = ['?']
        for c in s:
            if c in dic: stack.append(c)
            elif dic[stack.pop()] != c: return False 
        return len(stack) == 1

test_input = "example"
slt = Solution()
result = slt.isValid(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.house_robber1121
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def rob(self, nums: [int]) -> int:
        def my_rob(nums):
            cur, pre = 0, 0
            for num in nums:
                cur, pre = max(pre + num, cur), cur
            return cur
        return max(my_rob(nums[:-1]),my_rob(nums[1:])) if len(nums) != 1 else nums[0]

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.rob(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.kth_largest_element_in_an_array1122
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        def quick_sort(nums, l, r):
            # 子数组长度为 1 时终止递归
            if l >= r: return
            # 哨兵划分操作（以 nums[l] 作为基准数）
            i, j = l, r
            while i < j:
                while i < j and nums[j] >= nums[l]: j -= 1
                while i < j and nums[i] <= nums[l]: i += 1
                nums[i], nums[j] = nums[j], nums[i]
            nums[l], nums[i] = nums[i], nums[l]
            # 递归左（右）子数组执行哨兵划分
            quick_sort(nums, l, i - 1)
            quick_sort(nums, i + 1, r)
        quick_sort(nums, 0, len(nums) - 1)
        return nums[-k]


test_input_nums = [3, 2, 1, 5, 6, 4]
test_input_k = 2
expected_output = 5
slt = Solution()
result = slt.findKthLargest(test_input_nums, test_input_k)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.kth_largest_element_in_an_array1123
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        def quick_sort(l, r):
            i, j = l, r
            while i < j:
                while i < j and nums[j] >= nums[l]: j -= 1
                while i < j and nums[i] <= nums[l]: i += 1
                nums[i], nums[j] = nums[j], nums[i]
            nums[l], nums[i] = nums[i], nums[l]
            if i > len(nums) - k: return quick_sort(l, i - 1) 
            if i < len(nums) - k: return quick_sort(i + 1, r)
            # 若基准数索引为 n - k ，则直接返回该元素
            return nums[-k]
        return quick_sort(0, len(nums) - 1)


test_input_nums = [3, 2, 1, 5, 6, 4]
test_input_k = 2
expected_output = 5
slt = Solution()
result = slt.findKthLargest(test_input_nums, test_input_k)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.merge_two_sorted_lists1124
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:
        cur = dum = ListNode(0)
        while list1 and list2:
            if list1.val < list2.val:
                cur.next, list1 = list1, list1.next
            else:
                cur.next, list2 = list2, list2.next
            cur = cur.next
        cur.next = list1 if list1 else list2
        return dum.next

list1 = list_to_linked_list([1, 2, 4])
list2 = list_to_linked_list([1, 3, 4])
slt = Solution()
result = slt.mergeTwoLists(list1, list2)
print_linked_list(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.invert_binary_tree1125
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if not root: return
        tmp = root.left
        root.left = self.invertTree(root.right)
        root.right = self.invertTree(tmp)
        return root

root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.invertTree(root)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.invert_binary_tree1126
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if not root: return
        root.left, root.right = self.invertTree(root.right), self.invertTree(root.left)
        return root

root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.invertTree(root)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.invert_binary_tree1127
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if not root: return
        stack = [root]
        while stack:
            node = stack.pop()
            if node.left: stack.append(node.left)
            if node.right: stack.append(node.right)
            node.left, node.right = node.right, node.left
        return root

root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.invertTree(root)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.kth_smallest_element_in_a_bst1128
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def kthSmallest(self, root: Optional[TreeNode], k: int) -> int:
        def dfs(root):
            if not root: return
            dfs(root.left)
            if self.k == 0: return
            self.k -= 1
            if self.k == 0: self.res = root.val
            dfs(root.right)
        self.k = k
        dfs(root)
        return self.res

root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.kthSmallest(root, 3)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.power_of_two1129
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def isPowerOfTwo(self, n: int) -> bool:
        return n > 0 and n & (n - 1) == 0


slt = Solution()
# result = slt.isPowerOfTwo(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.implement_queue_using_stacks1130
    set output_file "main.py"

    set template_content '
from include import *

class MyQueue:
    def __init__(self):
        self.A, self.B = [], []
    def push(self, x: int) -> None:
        self.A.append(x)
    def pop(self) -> int:
        peek = self.peek()
        self.B.pop()
        return peek
    def peek(self) -> int:
        if self.B: return self.B[-1]
        if not self.A: return -1
        # 将栈 A 的元素依次移动至栈 B
        while self.A:
            self.B.append(self.A.pop())
        return self.B[-1]
    def empty(self) -> bool:
        return not self.A and not self.B

operations = ["MyQueue", "push", "push", "peek", "pop", "empty"]
values = [[], [1], [2], [], [], []]
obj = MyQueue()
obj.push(1)
obj.push(2)
print("Peek:", obj.peek())
print("Pop:", obj.pop())
print("Empty:", obj.empty())
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.number_of_digit_one1131
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def countDigitOne(self, n: int) -> int:
        high = n // 10
        cur = n % 10
        low = 0
        digit = 1 # 个位
        res = 0
        while high != 0 or cur != 0:
            if cur == 0: res += high * digit
            elif cur == 1: res += high * digit + low + 1
            else: res += (high + 1) * digit
            low += cur * digit
            cur = high % 10
            high //= 10
            digit *= 10
        return res

test_input = 12
expected_output = 5
slt = Solution()
result = slt.countDigitOne(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.number_of_digit_one1132
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def countDigitOne(self, n: int) -> int:
        digit, res = 1, 0
        high, cur, low = n // 10, n % 10, 0
        while high != 0 or cur != 0: # 当 high 和 cur 同时为 0 时，说明已经越过最高位，因此跳出
            if cur == 0: res += high * digit
            elif cur == 1: res += high * digit + low + 1
            else: res += (high + 1) * digit
            low += cur * digit # 将 cur 加入 low ，组成下轮 low
            cur = high % 10 # 下轮 cur 是本轮 high 的最低位
            high //= 10 # 将本轮 high 最低位删除，得到下轮 high
            digit *= 10 # 位因子每轮 × 10
        return res

test_input = 12
expected_output = 5
slt = Solution()
result = slt.countDigitOne(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.number_of_digit_one1133
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def countDigitOne(self, n: int) -> int:
        digit, res = 1, 0
        high, cur, low = n // 10, n % 10, 0
        while high != 0 or cur != 0:
            if cur == 0: res += high * digit
            elif cur == 1: res += high * digit + low + 1
            else: res += (high + 1) * digit
            low += cur * digit
            cur = high % 10
            high //= 10
            digit *= 10
        return res


slt = Solution()
# result = slt.countDigitOne(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP._lowest_common_ancestor_of_a_binary_search_tree1134
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def lowestCommonAncestor(self, root: 'TreeNode', p: 'TreeNode', q: 'TreeNode') -> 'TreeNode':
        while root:
            if root.val < p.val and root.val < q.val: # p,q 都在 root 的右子树中
                root = root.right # 遍历至右子节点
            elif root.val > p.val and root.val > q.val: # p,q 都在 root 的左子树中
                root = root.left # 遍历至左子节点
            else: break
        return root

root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.lowestCommonAncestor(root, root.left, root.right)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP._lowest_common_ancestor_of_a_binary_search_tree1135
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def lowestCommonAncestor(self, root: 'TreeNode', p: 'TreeNode', q: 'TreeNode') -> 'TreeNode':
        if p.val > q.val: p, q = q, p # 保证 p.val < q.val
        while root:
            if root.val < p.val: # p,q 都在 root 的右子树中
                root = root.right # 遍历至右子节点
            elif root.val > q.val: # p,q 都在 root 的左子树中
                root = root.left # 遍历至左子节点
            else: break
        return root

root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.lowestCommonAncestor(root, root.left, root.right)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP._lowest_common_ancestor_of_a_binary_search_tree1136
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def lowestCommonAncestor(self, root: 'TreeNode', p: 'TreeNode', q: 'TreeNode') -> 'TreeNode':
        if root.val < p.val and root.val < q.val:
            return self.lowestCommonAncestor(root.right, p, q)
        if root.val > p.val and root.val > q.val:
            return self.lowestCommonAncestor(root.left, p, q)
        return root


root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.lowestCommonAncestor(root, root.left, root.right)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.lowest_common_ancestor_of_a_binary_tree1137
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def lowestCommonAncestor(self, root: TreeNode, p: TreeNode, q: TreeNode) -> TreeNode:
        if not root or root == p or root == q: return root
        left = self.lowestCommonAncestor(root.left, p, q)
        right = self.lowestCommonAncestor(root.right, p, q)
        if not left: return right
        if not right: return left
        return root

root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.lowestCommonAncestor(root, root.left, root.right)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.lowest_common_ancestor_of_a_binary_tree1138
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def lowestCommonAncestor(self, root: TreeNode, p: TreeNode, q: TreeNode) -> TreeNode:
        if not root or root == p or root == q: return root
        left = self.lowestCommonAncestor(root.left, p, q)
        right = self.lowestCommonAncestor(root.right, p, q)
        if not left and not right: return # 1.
        if not left: return right # 3.
        if not right: return left # 4.
        return root # 2. if left and right:

root = list_to_tree([3, 9, 20, None, None, 15, 7])
slt = Solution()
result = slt.lowestCommonAncestor(root, root.left, root.right)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.delete_node_in_a_linked_list1139
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def deleteNode(self, node):
        node.val = node.next.val
        node.next = node.next.next

slt = Solution()
# result = slt.deleteNode(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.delete_node_in_a_linked_list1140
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def deleteNode(self, node):
        # 复制 node.next 到 node
        node.val = node.next.val
        # 从链表中删除 node.next
        node.next = node.next.next

slt = Solution()
# result = slt.deleteNode(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.product_of_array_except_self1141
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        ans, tmp = [1] * len(nums), 1
        for i in range(1, len(nums)):
            ans[i] = ans[i - 1] * nums[i - 1] # 下三角
        for i in range(len(nums) - 2, -1, -1):
            tmp *= nums[i + 1]                # 上三角
            ans[i] *= tmp                     # 下三角 * 上三角
        return ans


test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.productExceptSelf(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.sliding_window_maximum1142
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        deque = collections.deque()
        res, n = [], len(nums)
        for i, j in zip(range(1 - k, n + 1 - k), range(n)):
            # 删除 deque 中对应的 nums[i-1]
            if i > 0 and deque[0] == nums[i - 1]:
                deque.popleft()
            # 保持 deque 递减
            while deque and deque[-1] < nums[j]:
                deque.pop()
            deque.append(nums[j])
            # 记录窗口最大值
            if i >= 0:
                res.append(deque[0])
        return res

test_input_nums = [1, 3, -1, -3, 5, 3, 6, 7]
test_input_k = 3
expected_output = [3, 3, 5, 5, 6, 7]
slt = Solution()
result = slt.maxSlidingWindow(test_input_nums, test_input_k)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.sliding_window_maximum1143
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        if not nums or k == 0: return []
        deque = collections.deque()
        # 未形成窗口
        for i in range(k):
            while deque and deque[-1] < nums[i]:
                deque.pop()
            deque.append(nums[i])
        res = [deque[0]]
        # 形成窗口后
        for i in range(k, len(nums)):
            if deque[0] == nums[i - k]:
                deque.popleft()
            while deque and deque[-1] < nums[i]:
                deque.pop()
            deque.append(nums[i])
            res.append(deque[0])
        return res

test_input_nums = [1, 3, -1, -3, 5, 3, 6, 7]
test_input_k = 3
expected_output = [3, 3, 5, 5, 6, 7]
slt = Solution()
result = slt.maxSlidingWindow(test_input_nums, test_input_k)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.search_a_2d_matrix1144
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        i, j = len(matrix) - 1, 0
        while i >= 0 and j < len(matrix[0]):
            if matrix[i][j] > target: i -= 1
            elif matrix[i][j] < target: j += 1
            else: return True
        return False

test_input_matrix = [[1, 4, 7, 11, 15], [2, 5, 8, 12, 19], [3, 6, 9, 16, 22], [10, 13, 14, 17, 24], [18, 21, 23, 26, 30]]
test_input_target = 5
expected_output = True
slt = Solution()
result = slt.searchMatrix(test_input_matrix, test_input_target)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.valid_anagram1145
    set output_file "main.py"

    set template_content '
include import *


class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False
        dic = defaultdict(int)
        for c in s:
            dic[c] += 1
        for c in t:
            dic[c] -= 1
        for val in dic.values():
            if val != 0:
                return False
        return True

test_input_s = "anagram"
test_input_t = "nagaram"
expected_output = True
slt = Solution()
result = slt.isAnagram(test_input_s, test_input_t)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.valid_anagram1146
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        # 若 s, t 长度不同，则不互为重排
        if len(s) != len(t):
            return False
        # 初始化字典 dic ，且所有 key 的初始 value 都为 0
        dic = defaultdict(int)
        # 统计字符串 s 各字符数量，遇到 +1
        for c in s:
            dic[c] += 1
        # 统计字符串 t 各字符数量，遇到 -1
        for c in t:
            dic[c] -= 1
        # 遍历 s, t 中各字符的数量差
        for val in dic.values():
            # 若 s, t 中某字符的数量不一致，则不互为重排
            if val != 0:
                return False
        # 所有字符数量都一致，因此互为重排
        return True

test_input_s = "anagram"
test_input_t = "nagaram"
expected_output = True
slt = Solution()
result = slt.isAnagram(test_input_s, test_input_t)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.ugly_number1147
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def nthUglyNumber(self, n: int) -> int:
        res, a, b, c = [1] * n, 0, 0, 0
        for i in range(1, n):
            n2, n3, n5 = res[a] * 2, res[b] * 3, res[c] * 5
            res[i] = min(n2, n3, n5)
            if res[i] == n2: a += 1
            if res[i] == n3: b += 1
            if res[i] == n5: c += 1
        return res[-1]

slt = Solution()
# result = slt.nthUglyNumber(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.palindrome_permutation1148
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def canPermutePalindrome(self, s: str) -> bool:
        dic = defaultdict(int)
        for c in s:
            dic[c] += 1
        odd = 0
        for val in dic.values():
            if val % 2 == 1:
                odd += 1
                if odd > 1:
                    return False
        return True


test_input = "example"
slt = Solution()
result = slt.canPermutePalindrome(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.palindrome_permutation1149
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def canPermutePalindrome(self, s: str) -> bool:
        # 初始化哈希表
        dic = defaultdict(int)
        # 统计字符串中各字符的数量
        for c in s:
            dic[c] += 1
        odd = 0
        for val in dic.values():
            # 统计“数量为奇数”字符的个数
            if val % 2 == 1:
                odd += 1
                # 若“数量为奇数”的字符个数 > 1 ，则不是回文串排列
                if odd > 1:
                    return False
        # 若“数量为奇数”的字符个数 <= 1 ，则是回文串排列
        return True


test_input = "example"
slt = Solution()
result = slt.canPermutePalindrome(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.first_bad_version1150
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def firstBadVersion(self, n: int) -> int:
        i, j = 1, n
        while i <= j:
            # 向下取整除法计算中点 m 
            m = (i + j) // 2
            # 若 m 是错误版本，则最后一个正确版本一定在闭区间 [i, m - 1]
            if isBadVersion(m): j = m - 1
            # 若 m 是正确版本，则首个错误版本一定在闭区间 [m + 1, j]
            else: i = m + 1
        # i 指向首个错误版本，j 指向最后一个正确版本
        return i

slt = Solution()
# result = slt.firstBadVersion(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_the_duplicate_number1151
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        hmap = set()
        for num in nums:
            if num in hmap: return num
            hmap.add(num)
        return -1


test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.findDuplicate(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.find_the_duplicate_number1152
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        i = 0
        while i < len(nums):
            if nums[i] == i:
                i += 1
                continue
            if nums[nums[i]] == nums[i]: return nums[i]
            nums[nums[i]], nums[i] = nums[i], nums[nums[i]]
        return -1

test_input = [1, 3, 4, 2, 2]
expected_output = 2
slt = Solution()
result = slt.findDuplicate(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_the_duplicate_number1153
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        def next(i):
            return nums[i]
        slow = fast = 0
        # 第一次相遇
        while True:
            slow = next(slow)
            fast = next(next(fast))
            if slow == fast:
                break
        slow = 0
        # 第二次相遇
        while slow != fast:
            slow = next(slow)
            fast = next(fast)
        return slow

test_input = [1, 3, 4, 2, 2]
expected_output = 2
slt = Solution()
result = slt.findDuplicate(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_median_from_data_stream1154
    set output_file "main.py"

    set template_content '
from include import *


from heapq import *
class MedianFinder:
    def __init__(self):
        self.A = [] # 小顶堆，保存较大的一半
        self.B = [] # 大顶堆，保存较小的一半
    def addNum(self, num: int) -> None:
        if len(self.A) != len(self.B):
            heappush(self.A, num)
            heappush(self.B, -heappop(self.A))
        else:
            heappush(self.B, -num)
            heappush(self.A, -heappop(self.B))
    def findMedian(self) -> float:
        return self.A[0] if len(self.A) != len(self.B) else (self.A[0] - self.B[0]) / 2.0

operations = ["MedianFinder", "addNum", "addNum", "findMedian", "addNum", "findMedian"]
values = [[], [1], [2], [], [3], []]
obj = MedianFinder()
obj.addNum(1)
obj.addNum(2)
print("Median:", obj.findMedian())
obj.addNum(3)
print("Median:", obj.findMedian()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_median_from_data_stream1155
    set output_file "main.py"

    set template_content '
from include import *

from heapq import *
class MedianFinder:
    def __init__(self):
        self.A = [] # 小顶堆，保存较大的一半
        self.B = [] # 大顶堆，保存较小的一半
    def addNum(self, num: int) -> None:
        if len(self.A) != len(self.B):
            heappush(self.B, -heappushpop(self.A, num))
        else:
            heappush(self.A, -heappushpop(self.B, -num))
    def findMedian(self) -> float:
        return self.A[0] if len(self.A) != len(self.B) else (self.A[0] - self.B[0]) / 2.0


operations = ["MedianFinder", "addNum", "addNum", "findMedian", "addNum", "findMedian"]
values = [[], [1], [2], [], [3], []]
obj = MedianFinder()
obj.addNum(1)
obj.addNum(2)
print("Median:", obj.findMedian())
obj.addNum(3)
print("Median:", obj.findMedian())
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.serialize_and_deserialize_binary_tree1156
    set output_file "main.py"

    set template_content '
from include import *


class Codec:
    def serialize(self, root):
        if not root: return "[]"
        queue = collections.deque()
        queue.append(root)
        res = []
        while queue:
            node = queue.popleft()
            if node:
                res.append(str(node.val))
                queue.append(node.left)
                queue.append(node.right)
            else: res.append("null")
        return '[' + ','.join(res) + ']'
    def deserialize(self, data):
        if data == "[]": return
        vals, i = data[1:-1].split(','), 1
        root = TreeNode(int(vals[0]))
        queue = collections.deque()
        queue.append(root)
        while queue:
            node = queue.popleft()
            if vals[i] != "null":
                node.left = TreeNode(int(vals[i]))
                queue.append(node.left)
            i += 1
            if vals[i] != "null":
                node.right = TreeNode(int(vals[i]))
                queue.append(node.right)
            i += 1
        return root


root = list_to_tree([3, 9, 20, None, None, 15, 7])
codec = Codec()
serialized = codec.serialize(root)
print("Serialized:", serialized)
deserialized = codec.deserialize(serialized)
print("Deserialized root value:", deserialized.val if deserialized else None)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.longest_increasing_subsequence1157
    set output_file "main.py"

    set template_content '
from include import *


# Dynamic programming.
class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        if not nums: return 0
        dp = [1] * len(nums)
        for i in range(len(nums)):
            for j in range(i):
                if nums[j] < nums[i]: # 如果要求非严格递增，将此行 '<' 改为 '<=' 即可。
                    dp[i] = max(dp[i], dp[j] + 1)
        return max(dp)

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.lengthOfLIS(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.longest_increasing_subsequence1158
    set output_file "main.py"

    set template_content '
from include import *

# Dynamic programming + Dichotomy.
class Solution:
    def lengthOfLIS(self, nums: [int]) -> int:
        tails, res = [0] * len(nums), 0
        for num in nums:
            i, j = 0, res
            while i < j:
                m = (i + j) // 2
                if tails[m] < num: i = m + 1 # 如果要求非严格递增，将此行 '<' 改为 '<=' 即可。
                else: j = m
            tails[i] = num
            if j == res: res += 1
        return res

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.lengthOfLIS(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.integer_break1159
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def integerBreak(self, n: int) -> int:
        if n <= 3: return n - 1
        a, b = n // 3, n % 3
        if b == 0: return int(math.pow(3, a))
        if b == 1: return int(math.pow(3, a - 1) * 4)
        return int(math.pow(3, a) * 2)


slt = Solution()
# result = slt.integerBreak(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.sum_of_two_integers1160
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def getSum(self, a: int, b: int) -> int:
        x = 0xffffffff
        a, b = a & x, b & x
        # 循环，当进位为 0 时跳出
        while b != 0:
            # a, b = 非进位和, 进位
            a, b = (a ^ b), (a & b) << 1 & x
        return a if a <= 0x7fffffff else ~(a ^ x)


slt = Solution()
# result = slt.getSum(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.first_unique_character_in_a_string1161
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def firstUniqChar(self, s: str) -> int:
        dic = {}
        for c in s:
            dic[c] = not c in dic
        for i, c in enumerate(s):
            if dic[c]: return i
        return -1


test_input = "example"
slt = Solution()
result = slt.firstUniqChar(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.is_subsequence1162
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def isSubsequence(self, s: str, t: str) -> bool:
        if not s: return True
        i = 0
        for c in t:
            if s[i] == c:
                i += 1
                # 若已经遍历完 s ，则提前返回 true
                if i == len(s):
                    return True
        return False

test_input_s = "abc"
test_input_t = "ahbgdc"
expected_output = True
slt = Solution()
result = slt.isSubsequence(test_input_s, test_input_t)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.decode_string1163
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def decodeString(self, s: str) -> str:
        stack, res, multi = [], "", 0
        for c in s:
            if c == '[':
                stack.append([multi, res])
                res, multi = "", 0
            elif c == ']':
                cur_multi, last_res = stack.pop()
                res = last_res + cur_multi * res
            elif '0' <= c <= '9':
                multi = multi * 10 + int(c)            
            else:
                res += c
        return res

test_input = "example"
slt = Solution()
result = slt.decodeString(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.decode_string1164
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def decodeString(self, s: str) -> str:
        def dfs(s, i):
            res, multi = "", 0
            while i < len(s):
                if '0' <= s[i] <= '9':
                    multi = multi * 10 + int(s[i])
                elif s[i] == '[':
                    i, tmp = dfs(s, i + 1)
                    res += multi * tmp
                    multi = 0
                elif s[i] == ']':
                    return i, res
                else:
                    res += s[i]
                i += 1
            return res
        return dfs(s,0)

test_input = "example"
slt = Solution()
result = slt.decodeString(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.combination_sum1165
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def combinationSum(self, candidates: List[int], target: int) -> List[List[int]]:
        def backtrack(
            state: list[int], target: int, choices: list[int], start: int, res: list[list[int]]
        ):
            """回溯算法：子集和 I"""
            # 子集和等于 target 时，记录解
            if target == 0:
                res.append(list(state))
                return
            # 遍历所有选择
            # 剪枝二：从 start 开始遍历，避免生成重复子集
            for i in range(start, len(choices)):
                # 剪枝一：若子集和超过 target ，则直接结束循环
                # 这是因为数组已排序，后边元素更大，子集和一定超过 target
                if target - choices[i] < 0:
                    break
                # 尝试：做出选择，更新 target, start
                state.append(choices[i])
                # 进行下一轮选择
                backtrack(state, target - choices[i], choices, i, res)
                # 回退：撤销选择，恢复到之前的状态
                state.pop()
        state = []  # 状态（子集）
        candidates.sort()  # 对 candidates 进行排序
        start = 0  # 遍历起始点
        res = []  # 结果列表（子集列表）
        backtrack(state, target, candidates, start, res)
        return res

test_input_candidates = [2, 3, 6, 7]
test_input_target = 7
expected_output = [[2, 2, 3], [7]]
slt = Solution()
result = slt.combinationSum(test_input_candidates, test_input_target)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.combination_sum1166
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def combinationSum(self, candidates: List[int], target: int) -> List[List[int]]:
        def backtrack(
            state: list[int], target: int, choices: list[int], start: int, res: list[list[int]]
        ):
            """回溯算法：子集和 I"""
            # 子集和等于 target 时，记录解
            if target == 0:
                res.append(list(state))
                return
            # 遍历所有选择
            # 剪枝二：从 start 开始遍历，避免生成重复子集
            for i in range(start, len(choices)):
                # 剪枝一：若子集和超过 target ，则直接结束循环
                # 这是因为数组已排序，后边元素更大，子集和一定超过 target
                if target - choices[i] < 0:
                    break
                # 尝试：做出选择，更新 target, start
                state.append(choices[i])
                # 进行下一轮选择
                backtrack(state, target - choices[i], choices, i, res)
                # 回退：撤销选择，恢复到之前的状态
                state.pop()
        state = []  # 状态（子集）
        candidates.sort()  # 对 candidates 进行排序
        start = 0  # 遍历起始点
        res = []  # 结果列表（子集列表）
        backtrack(state, target, candidates, start, res)
        return res

test_input_candidates = [2, 3, 6, 7]
test_input_target = 7
expected_output = [[2, 2, 3], [7]]
slt = Solution()
result = slt.combinationSum(test_input_candidates, test_input_target)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.longest_substring_without_repeating_characters1167
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        dic, res, i = {}, 0, -1
        for j in range(len(s)):
            if s[j] in dic:
                i = max(dic[s[j]], i) # 更新左指针 i
            dic[s[j]] = j # 哈希表记录
            res = max(res, j - i) # 更新结果
        return res


test_input = "example"
slt = Solution()
result = slt.lengthOfLongestSubstring(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.longest_substring_without_repeating_characters1168
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        dic = {}
        res = tmp = 0
        for j in range(len(s)):
            i = dic.get(s[j], -1) # 获取索引 i
            dic[s[j]] = j # 更新哈希表
            tmp = tmp + 1 if tmp < j - i else j - i # dp[j - 1] -> dp[j]
            res = max(res, tmp) # max(dp[j - 1], dp[j])
        return res

test_input = "example"
slt = Solution()
result = slt.lengthOfLongestSubstring(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.nth_digit1169
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def findNthDigit(self, n: int) -> int:
        digit, start, count = 1, 1, 9
        while n > count:
            n -= count
            start *= 10 # 1, 10, 100, ...
            digit += 1  # 1,  2,  3, ...
            count = 9 * start * digit # 9, 180, 2700, ...
        num = start + (n - 1) // digit
        return int(str(num)[(n - 1) % digit])


test_input = 11
expected_output = 0
slt = Solution()
result = slt.findNthDigit(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.nth_digit1170
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def findNthDigit(self, n: int) -> int:
        digit, start, count = 1, 1, 9
        while n > count:
            n -= count
            start *= 10
            digit += 1
            count = 9 * start * digit
        num = start + (n - 1) // digit
        return int(str(num)[(n - 1) % digit])

test_input = 11
expected_output = 0
slt = Solution()
result = slt.findNthDigit(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.nth_digit_1171
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def findNthDigit(self, n: int) -> int:
        digit, start, count = 1, 1, 9
        while n > count:
            n -= count
            start *= 10
            digit += 1
            count = 9 * start * digit
        num = start + (n - 1) // digit
        s = str(num) # 转化为 string
        res = int(s[(n - 1) % digit]) # 获得 num 的 第 (n - 1) % digit 个数位，并转化为 int
        return res


test_input = 11
expected_output = 0
slt = Solution()
result = slt.findNthDigit(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.nth_digit_1172
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def findNthDigit(self, n: int) -> int:
        digit, start, count = 1, 1, 9
        while n > count: # 1.
            n -= count
            start *= 10
            digit += 1
            count = 9 * start * digit
        num = start + (n - 1) // digit # 2.
        return int(str(num)[(n - 1) % digit]) # 3.

test_input = 11
expected_output = 0
slt = Solution()
result = slt.findNthDigit(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.longest_palindrome1173
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def longestPalindrome(self, s: str) -> int:
        # 统计各字符数量
        counter = collections.defaultdict(int)
        for c in s:
            counter[c] += 1
        res, odd = 0, 0
        # 统计构造回文串的最大长度
        for count in counter.values():
            # 将当前字符出现次数向下取偶数，并计入 res
            rem = count % 2
            res += count - rem
            # 若当前字符出现次数为奇数，则将 odd 置 1
            if rem == 1: odd = 1
        return res + odd


test_input = "example"
slt = Solution()
result = slt.longestPalindrome(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.combination_sum_ii_1174
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def combinationSum2(self, candidates: List[int], target: int) -> List[List[int]]:
        def backtrack(
            state: list[int], target: int, choices: list[int], start: int, res: list[list[int]]
        ):
            """回溯算法：子集和 II"""
            # 子集和等于 target 时，记录解
            if target == 0:
                res.append(list(state))
                return
            # 遍历所有选择
            # 剪枝二：从 start 开始遍历，避免生成重复子集
            # 剪枝三：从 start 开始遍历，避免重复选择同一元素
            for i in range(start, len(choices)):
                # 剪枝一：若子集和超过 target ，则直接结束循环
                # 这是因为数组已排序，后边元素更大，子集和一定超过 target
                if target - choices[i] < 0:
                    break
                # 剪枝四：如果该元素与左边元素相等，说明该搜索分支重复，直接跳过
                if i > start and choices[i] == choices[i - 1]:
                    continue
                # 尝试：做出选择，更新 target, start
                state.append(choices[i])
                # 进行下一轮选择
                backtrack(state, target - choices[i], choices, i + 1, res)
                # 回退：撤销选择，恢复到之前的状态
                state.pop()
        state = []  # 状态（子集）
        candidates.sort()  # 对 candidates 进行排序
        start = 0  # 遍历起始点
        res = []  # 结果列表（子集列表）
        backtrack(state, target, candidates, start, res)
        return res

test_input_candidates = [10, 1, 2, 7, 6, 1, 5]
test_input_target = 8
expected_output = [[1, 1, 6], [1, 2, 5], [1, 7], [2, 6]]
slt = Solution()
result = slt.combinationSum2(test_input_candidates, test_input_target)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.combination_sum_ii_1175
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def combinationSum2(self, candidates: List[int], target: int) -> List[List[int]]:
        def backtrack(
            state: list[int], target: int, choices: list[int], start: int, res: list[list[int]]
        ):
            """回溯算法：子集和 II"""
            # 子集和等于 target 时，记录解
            if target == 0:
                res.append(list(state))
                return
            # 遍历所有选择
            # 剪枝二：从 start 开始遍历，避免生成重复子集
            # 剪枝三：从 start 开始遍历，避免重复选择同一元素
            for i in range(start, len(choices)):
                # 剪枝一：若子集和超过 target ，则直接结束循环
                # 这是因为数组已排序，后边元素更大，子集和一定超过 target
                if target - choices[i] < 0:
                    break
                # 剪枝四：如果该元素与左边元素相等，说明该搜索分支重复，直接跳过
                if i > start and choices[i] == choices[i - 1]:
                    continue
                # 尝试：做出选择，更新 target, start
                state.append(choices[i])
                # 进行下一轮选择
                backtrack(state, target - choices[i], choices, i + 1, res)
                # 回退：撤销选择，恢复到之前的状态
                state.pop()
        state = []  # 状态（子集）
        candidates.sort()  # 对 candidates 进行排序
        start = 0  # 遍历起始点
        res = []  # 结果列表（子集列表）
        backtrack(state, target, candidates, start, res)
        return res


test_input_candidates = [10, 1, 2, 7, 6, 1, 5]
test_input_target = 8
expected_output = [[1, 1, 6], [1, 2, 5], [1, 7], [2, 6]]
slt = Solution()
result = slt.combinationSum2(test_input_candidates, test_input_target)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.add_strings1176
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def addStrings(self, num1: str, num2: str) -> str:
        res = ""
        i, j, carry = len(num1) - 1, len(num2) - 1, 0
        while i >= 0 or j >= 0:
            n1 = int(num1[i]) if i >= 0 else 0
            n2 = int(num2[j]) if j >= 0 else 0
            tmp = n1 + n2 + carry
            carry = tmp // 10
            res = str(tmp % 10) + res
            i, j = i - 1, j - 1
        return "1" + res if carry else res


test_input_num1 = "11"
test_input_num2 = "123"
expected_output = "134"
slt = Solution()
result = slt.addStrings(test_input_num1, test_input_num2)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP._convert_binary_search_tree_to_sorted_doubly_linked_list_1177
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def treeToDoublyList(self, root: 'TreeNode') -> 'TreeNode':
        # 打印中序遍历
        def dfs(cur):
            if not cur: return
            dfs(cur.left)  # 左
            if self.pre:
                self.pre.right, cur.left = cur, self.pre
            else:
                self.head = cur
            self.pre = cur
            dfs(cur.right) # 右

        if not root: return
        self.pre = None
        dfs(root)
        self.head.left, self.pre.right = self.pre, self.head
        return self.head


root = list_to_tree([4, 2, 5, 1, 3])
slt = Solution()
result = slt.treeToDoublyList(root)
print("Head value:", result.val if result else None)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP._convert_binary_search_tree_to_sorted_doubly_linked_list_1178
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def treeToDoublyList(self, root: 'Optional[Node]') -> 'Optional[Node]':
        def dfs(cur):
            if not cur: return
            dfs(cur.left) # 递归左子树
            if self.pre: # 修改节点引用
                self.pre.right, cur.left = cur, self.pre
            else: # 记录头节点
                self.head = cur
            self.pre = cur # 保存 cur
            dfs(cur.right) # 递归右子树
        if not root: return
        self.pre = None
        dfs(root)
        self.head.left, self.pre.right = self.pre, self.head
        return self.head


slt = Solution()
# result = slt.treeToDoublyList(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.permutations1179
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def permute(self, nums: List[int]) -> List[List[int]]:
        def dfs(x):
            if x == len(nums) - 1:
                res.append(list(nums))   # 添加排列方案
                return
            for i in range(x, len(nums)):
                nums[i], nums[x] = nums[x], nums[i]  # 交换，将 nums[i] 固定在第 x 位
                dfs(x + 1)                           # 开启固定第 x + 1 位元素
                nums[i], nums[x] = nums[x], nums[i]  # 恢复交换
        res = []
        dfs(0)
        return res


test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.permute(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.permutations1180
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def permuteUnique(self, nums: List[int]) -> List[List[int]]:
        def dfs(x):
            if x == len(nums) - 1:
                res.append(list(nums))   # 添加排列方案
                return
            dic = set()
            for i in range(x, len(nums)):
                if nums[i] in dic: continue # 重复，因此剪枝
                dic.add(nums[i])
                nums[i], nums[x] = nums[x], nums[i]  # 交换，将 nums[i] 固定在第 x 位
                dfs(x + 1)                           # 开启固定第 x + 1 位元素
                nums[i], nums[x] = nums[x], nums[i]  # 恢复交换
        res = []
        dfs(0)
        return res

test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.permuteUnique(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.rotate_image_1181
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def rotate(self, matrix: List[List[int]]) -> None:
        n = len(matrix)
        # 深拷贝 matrix -> tmp
        tmp = copy.deepcopy(matrix)
        # 根据元素旋转公式，遍历修改原矩阵 matrix 的各元素
        for i in range(n):
            for j in range(n):
                matrix[j][n - 1 - i] = tmp[i][j]

test_input = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
expected_output = [[7, 4, 1], [8, 5, 2], [9, 6, 3]]
slt = Solution()
slt.rotate(test_input)
print_matrix(test_input)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.rotate_image_1182
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def rotate(self, matrix: List[List[int]]) -> None:
        n = len(matrix)
        for i in range(n // 2):
            for j in range((n + 1) // 2):
                tmp = matrix[i][j]
                matrix[i][j] = matrix[n - 1 - j][i]
                matrix[n - 1 - j][i] = matrix[n - 1 - i][n - 1 - j]
                matrix[n - 1 - i][n - 1 - j] = matrix[j][n - 1 - i]
                matrix[j][n - 1 - i] = tmp

test_input = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
expected_output = [[7, 4, 1], [8, 5, 2], [9, 6, 3]]
slt = Solution()
slt.rotate(test_input)
print_matrix(test_input)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.rotate_image_1183
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def rotate(self, matrix: List[List[int]]) -> None:
        # 设矩阵行列数为 n
        n = len(matrix)
        # 起始点范围为 0 <= i < n // 2 , 0 <= j < (n + 1) // 2
        # 其中 '//' 为整数除法
        for i in range(n // 2):
            for j in range((n + 1) // 2):
                # 暂存 A 至 tmp
                tmp = matrix[i][j]
                # 元素旋转操作 A <- D <- C <- B <- tmp
                matrix[i][j] = matrix[n - 1 - j][i]
                matrix[n - 1 - j][i] = matrix[n - 1 - i][n - 1 - j]
                matrix[n - 1 - i][n - 1 - j] = matrix[j][n - 1 - i]
                matrix[j][n - 1 - i] = tmp


test_input = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
expected_output = [[7, 4, 1], [8, 5, 2], [9, 6, 3]]
slt = Solution()
slt.rotate(test_input)
print_matrix(test_input)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.fibonacci_number1184
    set output_file "main.py"

    set template_content '

from include import *

class Solution:
    def fib(self, n: int) -> int:
        a, b = 0, 1
        for _ in range(n):
            a, b = b, a + b
        return a


slt = Solution()
# result = slt.fib(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.powx_n_1185
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def myPow(self, x: float, n: int) -> float:
        if x == 0.0: return 0.0
        res = 1
        if n < 0: x, n = 1 / x, -n
        while n:
            if n & 1: res *= x
            x *= x
            n >>= 1
        return res


slt = Solution()
# result = slt.myPow(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.maximum_subarray1186
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        for i in range(1, len(nums)):
            nums[i] += max(nums[i - 1], 0)
        return max(nums)


test_input = [1, 2, 3, 4, 5]
slt = Solution()
result = slt.maxSubArray(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.spiral_matrix1187
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        if not matrix: return []
        l, r, t, b, res = 0, len(matrix[0]) - 1, 0, len(matrix) - 1, []
        while True:
            for i in range(l, r + 1): res.append(matrix[t][i]) # left to right
            t += 1
            if t > b: break
            for i in range(t, b + 1): res.append(matrix[i][r]) # top to bottom
            r -= 1
            if l > r: break
            for i in range(r, l - 1, -1): res.append(matrix[b][i]) # right to left
            b -= 1
            if t > b: break
            for i in range(b, t - 1, -1): res.append(matrix[i][l]) # bottom to top
            l += 1
            if l > r: break
        return res

test_input = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
expected_output = [1, 2, 3, 6, 9, 8, 7, 4, 5]
slt = Solution()
result = slt.spiralOrder(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.spiral_matrix_1188
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def generateMatrix(self, n: int) -> [[int]]:
        l, r, t, b = 0, n - 1, 0, n - 1
        mat = [[0 for _ in range(n)] for _ in range(n)]
        num, tar = 1, n * n
        while num <= tar:
            for i in range(l, r + 1): # left to right
                mat[t][i] = num
                num += 1
            t += 1
            for i in range(t, b + 1): # top to bottom
                mat[i][r] = num
                num += 1
            r -= 1
            for i in range(r, l - 1, -1): # right to left
                mat[b][i] = num
                num += 1
            b -= 1
            for i in range(b, t - 1, -1): # bottom to top
                mat[i][l] = num
                num += 1
            l += 1
        return mat

slt = Solution()
# result = slt.generateMatrix(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.minimum_path_sum1189
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def minPathSum(self, grid: [[int]]) -> int:
        for i in range(len(grid)):
            for j in range(len(grid[0])):
                if i == j == 0: continue
                elif i == 0:  grid[i][j] = grid[i][j - 1] + grid[i][j]
                elif j == 0:  grid[i][j] = grid[i - 1][j] + grid[i][j]
                else: grid[i][j] = min(grid[i - 1][j], grid[i][j - 1]) + grid[i][j]
        return grid[-1][-1]

slt = Solution()
# result = slt.minPathSum(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.valid_number1190
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def isNumber(self, s: str) -> bool:
        states = [
            { ' ': 0, 's': 1, 'd': 2, '.': 4 }, # 0. start with 'blank'
            { 'd': 2, '.': 4 } ,                # 1. 'sign' before 'e'
            { 'd': 2, '.': 3, 'e': 5, ' ': 8 }, # 2. 'digit' before 'dot'
            { 'd': 3, 'e': 5, ' ': 8 },         # 3. 'digit' after 'dot'
            { 'd': 3 },                         # 4. 'digit' after 'dot' (‘blank’ before 'dot')
            { 's': 6, 'd': 7 },                 # 5. 'e'
            { 'd': 7 },                         # 6. 'sign' after 'e'
            { 'd': 7, ' ': 8 },                 # 7. 'digit' after 'e'
            { ' ': 8 }                          # 8. end with 'blank'
        ]
        p = 0                           # start with state 0
        for c in s:
            if '0' <= c <= '9': t = 'd' # digit
            elif c in "+-": t = 's'     # sign
            elif c in "eE": t = 'e'     # e or E
            elif c in ". ": t = c       # dot, blank
            else: t = '?'               # unknown
            if t not in states[p]: return False
            p = states[p][t]
        return p in (2, 3, 7, 8)


test_input = "example"
slt = Solution()
result = slt.isNumber(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.zigzag_conversion1191
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def convert(self, s: str, numRows: int) -> str:
        if numRows < 2: return s
        res = ["" for _ in range(numRows)]
        i, flag = 0, -1
        for c in s:
            res[i] += c
            if i == 0 or i == numRows - 1: flag = -flag
            i += flag
        return "".join(res)

test_input_s = "PAYPALISHIRING"
test_input_numRows = 3
expected_output = "PAHNAPLSIIGYIR"
slt = Solution()
result = slt.convert(test_input_s, test_input_numRows)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP._binary_search1192
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def search(self, nums: List[int], target: int) -> int:
        i, j = 0, len(nums) - 1
        while i <= j:
            m = (i + j) // 2
            if nums[m] < target: i = m + 1
            elif nums[m] > target: j = m - 1
            else: return m
        return -1

test_input_nums = [-1, 0, 3, 5, 9, 12]
test_input_target = 9
expected_output = 4
slt = Solution()
result = slt.search(test_input_nums, test_input_target)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.climbing_stairs1193
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def climbStairs(self, n: int) -> int:
        a, b = 1, 1
        for _ in range(n - 1):
            a, b = b, a + b
        return b


slt = Solution()
# result = slt.climbStairs(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.find_pivot_index1194
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def climbStairs(self, n: int) -> int:
        a, b = 1, 1
        for _ in range(n - 1):
            a, b = b, a + b
        return b

slt = Solution()
# result = slt.climbStairs(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.max_chunks_to_make_sorted_1195
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def climbStairs(self, n: int) -> int:
        a, b = 1, 1
        for _ in range(n - 1):
            a, b = b, a + b
        return b

slt = Solution()
# result = slt.climbStairs(...)
# print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.rotate_string1196
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def rotateString(self, s: str, goal: str) -> bool:
        return len(s) == len(goal) and s in (goal + goal)

test_input_s = "abcde"
test_input_goal = "cdeab"
expected_output = True
slt = Solution()
result = slt.rotateString(test_input_s, test_input_goal)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.word_search1197
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        def dfs(i, j, k):
            if not 0 <= i < len(board) or not 0 <= j < len(board[0]) or board[i][j] != word[k]: return False
            if k == len(word) - 1: return True
            board[i][j] = ''
            res = dfs(i + 1, j, k + 1) or dfs(i - 1, j, k + 1) or dfs(i, j + 1, k + 1) or dfs(i, j - 1, k + 1)
            board[i][j] = word[k]
            return res
        for i in range(len(board)):
            for j in range(len(board[0])):
                if dfs(i, j, 0): return True
        return False


test_input_board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
test_input_word = "ABCCED"
expected_output = True
slt = Solution()
result = slt.exist(test_input_board, test_input_word)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.partition_list_1198
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def partition(self, head: Optional[ListNode], x: int) -> Optional[ListNode]:
        sml_dummy, big_dummy = ListNode(0), ListNode(0)
        sml, big = sml_dummy, big_dummy
        while head:
            if head.val < x:
                sml.next = head
                sml = sml.next
            else:
                big.next = head
                big = big.next
            head = head.next
        sml.next = big_dummy.next
        big.next = None
        return sml_dummy.next


head = list_to_linked_list([1, 4, 3, 2, 5, 2])
x = 3

slt = Solution()
result = slt.partition(head, x)
print_linked_list(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.partition_list_1199
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def partition(self, head: Optional[ListNode], x: int) -> Optional[ListNode]:
        # 新建两个链表
        sml_dummy, big_dummy = ListNode(0), ListNode(0)
        # 遍历链表
        sml, big = sml_dummy, big_dummy
        while head:
            # 将 < x 的节点加入 sml 节点后
            if head.val < x:
                sml.next = head
                sml = sml.next
            # 将 >= x 的节点加入 big 节点后
            else:
                big.next = head
                big = big.next
            head = head.next
        # 拼接两链表
        sml.next = big_dummy.next
        big.next = None
        return sml_dummy.next


head = list_to_linked_list([1, 4, 3, 2, 5, 2])
x = 3
slt = Solution()
result = slt.partition(head, x)
print_linked_list(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.middle_of_the_linked_list1200
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def middleNode(self, head: ListNode) -> ListNode:
        fast = slow = head
        while fast and fast.next:
            fast = fast.next.next
            slow = slow.next
        return slow


head = list_to_linked_list([1, 2, 3, 4, 5])
slt = Solution()
result = slt.middleNode(head)
print_linked_list(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP._gray_code1201
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def grayCode(self, n: int) -> List[int]:
        res, head = [0], 1
        for i in range(n):
            for j in range(len(res) - 1, -1, -1):
                res.append(head + res[j])
            head <<= 1
        return res

test_input = 2
expected_output = [0, 1, 3, 2]
slt = Solution()
result = slt.grayCode(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.string_to_integer_atoi_1202
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def myAtoi(self, s: str) -> int:
        s = s.strip()                      # 删除首尾空格
        if not s: return 0                   # 字符串为空则直接返回
        res, i, sign = 0, 1, 1
        int_max, int_min, bndry = 2 ** 31 - 1, -2 ** 31, 2 ** 31 // 10
        if s[0] == '-': sign = -1            # 保存负号
        elif s[0] != '+': i = 0              # 若无符号位，则需从 i = 0 开始数字拼接
        for c in s[i:]:
            if not '0' <= c <= '9' : break     # 遇到非数字的字符则跳出
            if res > bndry or res == bndry and c > '7': return int_max if sign == 1 else int_min # 数字越界处理
            res = 10 * res + ord(c) - ord('0') # 数字拼接
        return sign * res

test_input = "example"
slt = Solution()
result = slt.myAtoi(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.string_to_integer_atoi_1203
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def myAtoi(self, s: str) -> int:
        res, i, sign, length = 0, 0, 1, len(s)
        int_max, int_min, bndry = 2 ** 31 - 1, -2 ** 31, 2 ** 31 // 10
        if not s: return 0         # 空字符串，提前返回
        while s[i] == ' ':
            i += 1
            if i == length: return 0 # 字符串全为空格，提前返回
        if s[i] == '-': sign = -1
        if s[i] in '+-': i += 1
        for j in range(i, length):
            if not '0' <= s[j] <= '9' : break
            if res > bndry or res == bndry and s[j] > '7':
                return int_max if sign == 1 else int_min
            res = 10 * res + ord(s[j]) - ord('0')
        return sign * res


test_input = "example"
slt = Solution()
result = slt.myAtoi(test_input)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.validate_stack_sequences1204
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def validateStackSequences(self, pushed: List[int], popped: List[int]) -> bool:
        stack, i = [], 0
        for num in pushed:
            stack.append(num) # num 入栈
            while stack and stack[-1] == popped[i]: # 循环判断与出栈
                stack.pop()
                i += 1
        return not stack

test_input_pushed = [1, 2, 3, 4, 5]
test_input_popped = [4, 5, 3, 2, 1]
expected_output = True
slt = Solution()
result = slt.validateStackSequences(test_input_pushed, test_input_popped)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_duplicate_numbers_in_an_array_1205
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def findRepeatNumber(self, nums: List[int]) -> int:
        dic = set()
        for num in nums:
            if num in dic:
                return num
            dic.add(num)
        return -1


nums = [2, 3, 1, 0, 2, 5, 3]
slt = Solution()
res = slt.findRepeatNumber(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_duplicate_numbers_in_an_array_1206
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def findRepeatNumber(self, nums: List[int]) -> int:
        i = 0
        while i < len(nums):
            if nums[i] == i:
                i += 1
                continue
            if nums[nums[i]] == nums[i]:
                return nums[i]
            nums[nums[i]], nums[i] = nums[i], nums[nums[i]]
        return -1


nums = [2, 3, 1, 0, 2, 5, 3]
slt = Solution()
res = slt.findRepeatNumber(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_a_number_in_2d_matrix1207
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def findNumberIn2DArray(self, matrix: List[List[int]], target: int) -> bool:
        i, j = len(matrix) - 1, 0
        while i >= 0 and j < len(matrix[0]):
            if matrix[i][j] > target:
                i -= 1
            elif matrix[i][j] < target:
                j += 1
            else:
                return True
        return False


matrix = [
    [1, 4, 7, 11, 15],
    [2, 5, 8, 12, 19],
    [3, 6, 9, 16, 22],
    [10, 13, 14, 17, 24],
    [18, 21, 23, 26, 30],
]
target = 5
slt = Solution()
res = slt.findNumberIn2DArray(matrix, target)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.replace_spaces_1208
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def replaceSpace(self, s: str) -> str:
        res = []
        for c in s:
            if c == " ":
                res.append("%20")
            else:
                res.append(c)
        return "".join(res)


s = "We are happy."
slt = Solution()
res = slt.replaceSpace(s)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.print_a_linked_list_in_reverse_order_1209
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def reversePrint(self, head: ListNode) -> List[int]:
        return self.reversePrint(head.next) + [head.val] if head else []


head = list_to_linked_list([1, 3, 2])
slt = Solution()
res = slt.reversePrint(head)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.print_a_linked_list_in_reverse_order_1210
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def reversePrint(self, head: ListNode) -> List[int]:
        stack = []
        while head:
            stack.append(head.val)
            head = head.next
        return stack[::-1]

head = list_to_linked_list([1, 3, 2])
slt = Solution()
res = slt.reversePrint(head)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.reconstruct_binary_tree_1211
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def buildTree(self, preorder: List[int], inorder: List[int]) -> TreeNode:
        def recur(root, left, right):
            if left > right:
                return  # 递归终止
            node = TreeNode(preorder[root])  # 建立根节点
            i = dic[preorder[root]]  # 划分根节点、左子树、右子树
            node.left = recur(root + 1, left, i - 1)  # 开启左子树递归
            node.right = recur(i - left + root + 1, i + 1, right)  # 开启右子树递归
            return node  # 回溯返回根节点

        dic, preorder = {}, preorder
        for i in range(len(inorder)):
            dic[inorder[i]] = i
        return recur(0, 0, len(inorder) - 1)


preorder = [3, 9, 20, 15, 7]
inorder = [9, 3, 15, 20, 7]
slt = Solution()
res = slt.buildTree(preorder, inorder)
print_tree(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.implement_a_queue_using_two_stacks_1212
    set output_file "main.py"

    set template_content '
from include import *


class CQueue:
    def __init__(self):
        self.A, self.B = [], []

    def appendTail(self, value: int) -> None:
        self.A.append(value)

    def deleteHead(self) -> int:
        if self.B:
            return self.B.pop()
        if not self.A:
            return -1
        while self.A:
            self.B.append(self.A.pop())
        return self.B.pop()


c_queue = CQueue()
res = [
    c_queue.deleteHead(),
    c_queue.appendTail(5),
    c_queue.appendTail(2),
    c_queue.deleteHead(),
    c_queue.deleteHead(),
]
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.fibonacci_numbers_1213
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def fib(self, n: int) -> int:
        a, b = 0, 1
        for _ in range(n):
            a, b = b, (a + b) % 1000000007
        return a

n = 5
slt = Solution()
res = slt.fib(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.fibonacci_numbers_1214
    set output_file "main.py"

    set template_content '
from include import *

# 不考虑大数越界问题
class Solution:
    def fib(self, n: int) -> int:
        a, b = 0, 1
        for _ in range(n):
            a, b = b, a + b
        return a % 1000000007


n = 5
slt = Solution()
res = slt.fib(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.frog_jump_1215
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def numWays(self, n: int) -> int:
        a, b = 1, 1
        for _ in range(n):
            a, b = b, (a + b) % 1000000007
        return a

n = 7
slt = Solution()
res = slt.numWays(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.frog_jump_1216
    set output_file "main.py"

    set template_content '
from include import *

# 不考虑大数越界问题
class Solution:
    def numWays(self, n: int) -> int:
        a, b = 1, 1
        for _ in range(n):
            a, b = b, a + b
        return a % 1000000007

n = 7
slt = Solution()
res = slt.numWays(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_minimum_in_rotated_sorted_array_1217
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def minArray(self, numbers: List[int]) -> int:
        i, j = 0, len(numbers) - 1
        while i < j:
            m = (i + j) // 2
            if numbers[m] > numbers[j]:
                i = m + 1
            elif numbers[m] < numbers[j]:
                j = m
            else:
                j -= 1
        return numbers[i]

numbers = [3, 4, 5, 1, 2]
slt = Solution()
res = slt.minArray(numbers)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_minimum_in_rotated_sorted_array_1218
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def minArray(self, numbers: List[int]) -> int:
        i, j = 0, len(numbers) - 1
        while i < j:
            m = (i + j) // 2
            if numbers[m] > numbers[j]:
                i = m + 1
            elif numbers[m] < numbers[j]:
                j = m
            else:
                return min(numbers[i:j])
        return numbers[i]


numbers = [3, 4, 5, 1, 2]
slt = Solution()
res = slt.minArray(numbers)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.word_search_1219
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        def dfs(i, j, k):
            if (
                not 0 <= i < len(board)
                or not 0 <= j < len(board[0])
                or board[i][j] != word[k]
            ):
                return False
            if k == len(word) - 1:
                return True
            board[i][j] = ""
            res = (
                dfs(i + 1, j, k + 1)
                or dfs(i - 1, j, k + 1)
                or dfs(i, j + 1, k + 1)
                or dfs(i, j - 1, k + 1)
            )
            board[i][j] = word[k]
            return res

        for i in range(len(board)):
            for j in range(len(board[0])):
                if dfs(i, j, 0):
                    return True
        return False


board = [["A", "B", "C", "E"], ["S", "F", "C", "S"], ["A", "D", "E", "E"]]
word = "ABCCED"
slt = Solution()
res = slt.exist(board, word)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.range_of_motion_of_a_robot_1220
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def movingCount(self, m: int, n: int, k: int) -> int:
        def dfs(i, j, si, sj):
            if i >= m or j >= n or k < si + sj or (i, j) in visited:
                return 0
            visited.add((i, j))
            return (
                1
                + dfs(i + 1, j, si + 1 if (i + 1) % 10 else si - 8, sj)
                + dfs(i, j + 1, si, sj + 1 if (j + 1) % 10 else sj - 8)
            )

        visited = set()
        return dfs(0, 0, 0, 0)

m = 2
n = 3
k = 1
slt = Solution()
res = slt.movingCount(m, n, k)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.range_of_motion_of_a_robot1221
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def movingCount(self, m: int, n: int, k: int) -> int:
        queue, visited = [(0, 0, 0, 0)], set()
        while queue:
            i, j, si, sj = queue.pop(0)
            if i >= m or j >= n or k < si + sj or (i, j) in visited:
                continue
            visited.add((i, j))
            queue.append((i + 1, j, si + 1 if (i + 1) % 10 else si - 8, sj))
            queue.append((i, j + 1, si, sj + 1 if (j + 1) % 10 else sj - 8))
        return len(visited)

m = 2
n = 3
k = 1
slt = Solution()
res = slt.movingCount(m, n, k)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.cut_the_rope1222
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def cuttingRope(self, n: int) -> int:
        if n <= 3:
            return n - 1
        a, b = n // 3, n % 3
        if b == 0:
            return int(math.pow(3, a))
        if b == 1:
            return int(math.pow(3, a - 1) * 4)
        return int(math.pow(3, a) * 2)

n = 10
slt = Solution()
res = slt.cuttingRope(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.cut_the_rope1223
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def cuttingRope(self, n: int) -> int:
        if n <= 3:
            return n - 1
        a, b, p, x, rem = n // 3 - 1, n % 3, 1000000007, 3, 1
        while a > 0:
            if a % 2:
                rem = (rem * x) % p
            x = x**2 % p
            a //= 2
        if b == 0:
            return (rem * 3) % p  # = 3^(a+1) % p
        if b == 1:
            return (rem * 4) % p  # = 3^a * 4 % p
        return (rem * 6) % p  # = 3^(a+1) * 2  % p

n = 10
slt = Solution()
res = slt.cuttingRope(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.cut_the_rope1224
    set output_file "main.py"

    set template_content '

from include import *

# 由于语言特性，Python 可以不考虑大数越界问题
class Solution:
    def cuttingRope(self, n: int) -> int:
        if n <= 3:
            return n - 1
        a, b, p = n // 3, n % 3, 1000000007
        if b == 0:
            return 3**a % p
        if b == 1:
            return 3 ** (a - 1) * 4 % p
        return 3**a * 2 % p

n = 10
slt = Solution()
res = slt.cuttingRope(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.number_of_1_bits1224
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def hammingWeight(self, n: int) -> int:
        res = 0
        while n:
            res += n & 1
            n >>= 1
        return res

n = 11
slt = Solution()
res = slt.hammingWeight(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.number_of_1_bits_1225
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def hammingWeight(self, n: int) -> int:
        res = 0
        while n:
            res += 1
            n &= n - 1
        return res

n = 11
slt = Solution()
res = slt.hammingWeight(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.powers_of_integers_1226
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def myPow(self, x: float, n: int) -> float:
        if x == 0.0:
            return 0.0
        res = 1
        if n < 0:
            x, n = 1 / x, -n
        while n:
            if n & 1:
                res *= x
            x *= x
            n >>= 1
        return res

x = 2.0
n = 10
slt = Solution()
res = slt.myPow(x, n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.print_from_1_to_the_largest_n_digits_1227
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def printNumbers(self, n: int) -> List[int]:
        res = []
        for i in range(1, 10**n):
            res.append(i)
        return res


n = 1
slt = Solution()
res = slt.printNumbers(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.print_from_1_to_the_largest_n_digits_1228
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def printNumbers(self, n: int) -> List[int]:
        def dfs(x):
            if x == n:  # 终止条件：已固定完所有位
                res.append("".join(num))  # 拼接 num 并添加至 res 尾部
                return
            for i in range(10):  # 遍历 0 - 9
                num[x] = str(i)  # 固定第 x 位为 i
                dfs(x + 1)  # 开启固定第 x + 1 位

        num = ["0"] * n  # 起始数字定义为 n 个 0 组成的字符列表
        res = []  # 数字字符串列表
        dfs(0)  # 开启全排列递归
        return ",".join(res)  # 拼接所有数字字符串，使用逗号隔开，并返回


n = 1
slt = Solution()
res = slt.printNumbers(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.print_from_1_to_the_largest_n_digits_1229
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def printNumbers(self, n: int) -> List[int]:
        def dfs(x):
            if x == n:
                s = "".join(num[self.start :])
                if s != "0":
                    res.append(s)
                if n - self.start == self.nine:
                    self.start -= 1
                return
            for i in range(10):
                if i == 9:
                    self.nine += 1
                num[x] = str(i)
                dfs(x + 1)
            self.nine -= 1

        num, res = ["0"] * n, []
        self.nine = 0
        self.start = n - 1
        dfs(0)
        return ",".join(res)


n = 1
slt = Solution()
res = slt.printNumbers(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.print_from_1_to_the_largest_n_digits_1230
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def printNumbers(self, n: int) -> List[int]:
        def dfs(x):
            if x == n:
                s = "".join(num[self.start :])
                if s != "0":
                    res.append(int(s))
                if n - self.start == self.nine:
                    self.start -= 1
                return
            for i in range(10):
                if i == 9:
                    self.nine += 1
                num[x] = str(i)
                dfs(x + 1)
            self.nine -= 1

        num, res = ["0"] * n, []
        self.nine = 0
        self.start = n - 1
        dfs(0)
        return res


n = 1
slt = Solution()
res = slt.printNumbers(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.delete_a_node_from_a_linked_list_1231
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def deleteNode(self, head: ListNode, val: int) -> ListNode:
        if head.val == val:
            return head.next
        pre, cur = head, head.next
        while cur and cur.val != val:
            pre, cur = cur, cur.next
        if cur:
            pre.next = cur.next
        return head

head = list_to_linked_list([4, 5, 1, 9])
val = 5
slt = Solution()
res = slt.deleteNode(head, val)
print_linked_list(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.regular_expression_matching_1232
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        m, n = len(s) + 1, len(p) + 1
        dp = [[False] * n for _ in range(m)]
        dp[0][0] = True
        for j in range(2, n, 2):
            dp[0][j] = dp[0][j - 2] and p[j - 1] == "*"
        for i in range(1, m):
            for j in range(1, n):
                dp[i][j] = (
                    dp[i][j - 2]
                    or dp[i - 1][j]
                    and (s[i - 1] == p[j - 2] or p[j - 2] == ".")
                    if p[j - 1] == "*"
                    else dp[i - 1][j - 1] and (p[j - 1] == "." or s[i - 1] == p[j - 1])
                )
        return dp[-1][-1]

s = "mississippi"
p = "mis*is*p*."
slt = Solution()
res = slt.isMatch(s, p)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.regular_expression_matching_1233
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        m, n = len(s) + 1, len(p) + 1
        dp = [[False] * n for _ in range(m)]
        dp[0][0] = True
        # 初始化首行
        for j in range(2, n, 2):
            dp[0][j] = dp[0][j - 2] and p[j - 1] == "*"
        # 状态转移
        for i in range(1, m):
            for j in range(1, n):
                if p[j - 1] == "*":
                    if dp[i][j - 2]:
                        dp[i][j] = True  # 1.
                    elif dp[i - 1][j] and s[i - 1] == p[j - 2]:
                        dp[i][j] = True  # 2.
                    elif dp[i - 1][j] and p[j - 2] == ".":
                        dp[i][j] = True  # 3.
                else:
                    if dp[i - 1][j - 1] and s[i - 1] == p[j - 1]:
                        dp[i][j] = True  # 1.
                    elif dp[i - 1][j - 1] and p[j - 1] == ".":
                        dp[i][j] = True  # 2.
        return dp[-1][-1]

s = "mississippi"
p = "mis*is*p*."
slt = Solution()
res = slt.isMatch(s, p)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.string_representing_a_numeric_value_1234
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def isNumber(self, s: str) -> bool:
        states = [
            {" ": 0, "s": 1, "d": 2, ".": 4},  # 0. start with 'blank'
            {"d": 2, ".": 4},  # 1. 'sign' before 'e'
            {"d": 2, ".": 3, "e": 5, " ": 8},  # 2. 'digit' before 'dot'
            {"d": 3, "e": 5, " ": 8},  # 3. 'digit' after 'dot'
            {"d": 3},  # 4. 'digit' after 'dot' (‘blank’ before 'dot')
            {"s": 6, "d": 7},  # 5. 'e'
            {"d": 7},  # 6. 'sign' after 'e'
            {"d": 7, " ": 8},  # 7. 'digit' after 'e'
            {" ": 8},  # 8. end with 'blank'
        ]
        p = 0  # start with state 0
        for c in s:
            if "0" <= c <= "9":
                t = "d"  # digit
            elif c in "+-":
                t = "s"  # sign
            elif c in "eE":
                t = "e"  # e or E
            elif c in ". ":
                t = c  # dot, blank
            else:
                t = "?"  # unknown
            if t not in states[p]:
                return False
            p = states[p][t]
        return p in (2, 3, 7, 8)


s = "    .1  "
slt = Solution()
res = slt.isNumber(s)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.adjust_the_order_of_numbers_in_an_array1235
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def exchange(self, nums: List[int]) -> List[int]:
        i, j = 0, len(nums) - 1
        while i < j:
            while i < j and nums[i] & 1 == 1:
                i += 1
            while i < j and nums[j] & 1 == 0:
                j -= 1
            nums[i], nums[j] = nums[j], nums[i]
        return nums

nums = [1, 2, 3, 4]
slt = Solution()
res = slt.exchange(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.kth_node_from_the_end_of_a_linked_list1236
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def getKthFromEnd(self, head: ListNode, k: int) -> ListNode:
        former, latter = head, head
        for _ in range(k):
            former = former.next
        while former:
            former, latter = former.next, latter.next
        return latter


head = list_to_linked_list([1, 2, 3, 4, 5])
k = 2
slt = Solution()
res = slt.getKthFromEnd(head, k)
print_linked_list(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.kth_node_from_the_end_of_a_linked_list1237
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def getKthFromEnd(self, head: ListNode, k: int) -> ListNode:
        former, latter = head, head
        for _ in range(k):
            if not former:
                return
            former = former.next
        while former:
            former, latter = former.next, latter.next
        return latter


head = list_to_linked_list([1, 2, 3, 4, 5])
k = 2
slt = Solution()
res = slt.getKthFromEnd(head, k)
print_linked_list(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.reverse_a_linked_list_1238
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reverseList(self, head: ListNode) -> ListNode:
        cur, pre = head, None
        while cur:
            tmp = cur.next  # 暂存后继节点 cur.next
            cur.next = pre  # 修改 next 引用指向
            pre = cur  # pre 暂存 cur
            cur = tmp  # cur 访问下一节点
        return pre


head = list_to_linked_list([1, 2, 3, 4, 5])
slt = Solution()
res = slt.reverseList(head)
print_linked_list(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.reverse_a_linked_list_1239
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reverseList(self, head: ListNode) -> ListNode:
        cur, pre = head, None
        while cur:
            cur.next, pre, cur = pre, cur, cur.next
        return pre


head = list_to_linked_list([1, 2, 3, 4, 5])
slt = Solution()
res = slt.reverseList(head)
print_linked_list(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.reverse_a_linked_list_1240
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reverseList(self, head: ListNode) -> ListNode:
        def recur(cur, pre):
            if not cur:
                return pre  # 终止条件
            res = recur(cur.next, cur)  # 递归后继节点
            cur.next = pre  # 修改节点引用指向
            return res  # 返回反转链表的头节点

        return recur(head, None)  # 调用递归并返回


head = list_to_linked_list([1, 2, 3, 4, 5])
slt = Solution()
res = slt.reverseList(head)
print_linked_list(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.combine_two_sorted_linked_lists1241
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def mergeTwoLists(self, l1: ListNode, l2: ListNode) -> ListNode:
        cur = dum = ListNode(0)
        while l1 and l2:
            if l1.val < l2.val:
                cur.next, l1 = l1, l1.next
            else:
                cur.next, l2 = l2, l2.next
            cur = cur.next
        cur.next = l1 if l1 else l2
        return dum.next


l1 = list_to_linked_list([1, 2, 4])
l2 = list_to_linked_list([1, 3, 4])
slt = Solution()
res = slt.mergeTwoLists(l1, l2)
print_linked_list(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.mirror_of_a_binary_tree_1242
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def mirrorTree(self, root: TreeNode) -> TreeNode:
        if not root:
            return
        root.left, root.right = self.mirrorTree(root.right), self.mirrorTree(root.left)
        return root

root = list_to_tree(
    [4, 2, 7, 1, 3, 6, 9, None, None, None, None, None, None, None, None]
)
slt = Solution()
res = slt.mirrorTree(root)
print_tree(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.mirror_of_a_binary_tree_1243
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def mirrorTree(self, root: TreeNode) -> TreeNode:
        if not root:
            return
        tmp = root.left
        root.left = self.mirrorTree(root.right)
        root.right = self.mirrorTree(tmp)
        return root

root = list_to_tree(
    [4, 2, 7, 1, 3, 6, 9, None, None, None, None, None, None, None, None]
)
slt = Solution()
res = slt.mirrorTree(root)
print_tree(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.mirror_of_a_binary_tree_1244
    set output_file "main.py"

    set template_content '

from include import *

class Solution:
    def mirrorTree(self, root: TreeNode) -> TreeNode:
        if not root:
            return
        stack = [root]
        while stack:
            node = stack.pop()
            if node.left:
                stack.append(node.left)
            if node.right:
                stack.append(node.right)
            node.left, node.right = node.right, node.left
        return root

root = list_to_tree(
    [4, 2, 7, 1, 3, 6, 9, None, None, None, None, None, None, None, None]
)
slt = Solution()
res = slt.mirrorTree(root)
print_tree(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.symmetric_binary_tree_1245
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def isSymmetric(self, root: TreeNode) -> bool:
        def recur(L, R):
            if not L and not R:
                return True
            if not L or not R or L.val != R.val:
                return False
            return recur(L.left, R.right) and recur(L.right, R.left)

        return not root or recur(root.left, root.right)


root = list_to_tree(
    [1, 2, 2, 3, 4, 4, 3, None, None, None, None, None, None, None, None]
)
slt = Solution()
res = slt.isSymmetric(root)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.print_a_given_matrix_in_spiral_form1246
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        if not matrix:
            return []
        l, r, t, b, res = 0, len(matrix[0]) - 1, 0, len(matrix) - 1, []
        while True:
            for i in range(l, r + 1):
                res.append(matrix[t][i])  # left to right
            t += 1
            if t > b:
                break
            for i in range(t, b + 1):
                res.append(matrix[i][r])  # top to bottom
            r -= 1
            if l > r:
                break
            for i in range(r, l - 1, -1):
                res.append(matrix[b][i])  # right to left
            b -= 1
            if t > b:
                break
            for i in range(b, t - 1, -1):
                res.append(matrix[i][l])  # bottom to top
            l += 1
            if l > r:
                break
        return res


matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
slt = Solution()
res = slt.spiralOrder(matrix)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.min_stack_1247
    set output_file "main.py"

    set template_content '
from include import *

class MinStack:
    def __init__(self):
        self.A, self.B = [], []

    def push(self, x: int) -> None:
        self.A.append(x)
        if not self.B or self.B[-1] >= x:
            self.B.append(x)

    def pop(self) -> None:
        if self.A.pop() == self.B[-1]:
            self.B.pop()

    def top(self) -> int:
        return self.A[-1]

    def min(self) -> int:
        return self.B[-1]


min_stack = MinStack()
res = [
    min_stack.push(-2),
    min_stack.push(0),
    min_stack.push(-3),
    min_stack.min(),
    min_stack.pop(),
    min_stack.top(),
    min_stack.min(),
]
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.validate_stack_sequences1248
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def validateStackSequences(self, pushed: List[int], popped: List[int]) -> bool:
        stack, i = [], 0
        for num in pushed:
            stack.append(num)  # num 入栈
            while stack and stack[-1] == popped[i]:  # 循环判断与出栈
                stack.pop()
                i += 1
        return not stack

pushed = [1, 2, 3, 4, 5]
popped = [4, 5, 3, 2, 1]
slt = Solution()
res = slt.validateStackSequences(pushed, popped)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.print_a_binary_tree_topbottom1249
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def levelOrder(self, root: TreeNode) -> List[int]:
        if not root:
            return []
        res, queue = [], collections.deque()
        queue.append(root)
        while queue:
            node = queue.popleft()
            res.append(node.val)
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)
        return res


root = list_to_tree([3, 9, 20, None, None, 15, 7, None, None, None, None])
slt = Solution()
res = slt.levelOrder(root)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.print_a_binary_tree_topbottom1250
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def levelOrder(self, root: TreeNode) -> List[List[int]]:
        if not root:
            return []
        res, queue = [], collections.deque()
        queue.append(root)
        while queue:
            tmp = []
            for _ in range(len(queue)):
                node = queue.popleft()
                tmp.append(node.val)
                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)
            res.append(tmp)
        return res

root = list_to_tree([3, 9, 20, None, None, 15, 7, None, None, None, None])
slt = Solution()
res = slt.levelOrder(root)
print_matrix(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.print_a_binary_tree_topbottom1251
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def levelOrder(self, root: TreeNode) -> List[List[int]]:
        if not root:
            return []
        res, deque = [], collections.deque([root])
        while deque:
            tmp = collections.deque()
            for _ in range(len(deque)):
                node = deque.popleft()
                if len(res) % 2 == 0:
                    tmp.append(node.val)  # 奇数层 -> 插入队列尾部
                else:
                    tmp.appendleft(node.val)  # 偶数层 -> 插入队列头部
                if node.left:
                    deque.append(node.left)
                if node.right:
                    deque.append(node.right)
            res.append(list(tmp))
        return res

root = list_to_tree([3, 9, 20, None, None, 15, 7, None, None, None, None])
slt = Solution()
res = slt.levelOrder(root)
print_matrix(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.print_a_binary_tree_topbottom1252
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def levelOrder(self, root: TreeNode) -> List[List[int]]:
        if not root:
            return []
        res, deque = [], collections.deque()
        deque.append(root)
        while deque:
            tmp = []
            # 打印奇数层
            for _ in range(len(deque)):
                # 从左向右打印
                node = deque.popleft()
                tmp.append(node.val)
                # 先左后右加入下层节点
                if node.left:
                    deque.append(node.left)
                if node.right:
                    deque.append(node.right)
            res.append(tmp)
            if not deque:
                break  # 若为空则提前跳出
            # 打印偶数层
            tmp = []
            for _ in range(len(deque)):
                # 从右向左打印
                node = deque.pop()
                tmp.append(node.val)
                # 先右后左加入下层节点
                if node.right:
                    deque.appendleft(node.right)
                if node.left:
                    deque.appendleft(node.left)
            res.append(tmp)
        return res


root = list_to_tree([3, 9, 20, None, None, 15, 7, None, None, None, None])
slt = Solution()
res = slt.levelOrder(root)
print_matrix(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.print_a_binary_tree_topbottom1253
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def levelOrder(self, root: TreeNode) -> List[List[int]]:
        if not root:
            return []
        res, queue = [], collections.deque()
        queue.append(root)
        while queue:
            tmp = []
            for _ in range(len(queue)):
                node = queue.popleft()
                tmp.append(node.val)
                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)
            res.append(tmp[::-1] if len(res) % 2 else tmp)
        return res

root = list_to_tree([3, 9, 20, None, None, 15, 7, None, None, None, None])
slt = Solution()
res = slt.levelOrder(root)
print_matrix(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.postorder_traversal_of_a_binary_search_tree1254
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def verifyPostorder(self, postorder: List[int]) -> bool:
        def recur(i, j):
            if i >= j:
                return True
            p = i
            while postorder[p] < postorder[j]:
                p += 1
            m = p
            while postorder[p] > postorder[j]:
                p += 1
            return p == j and recur(i, m - 1) and recur(m, j - 1)

        return recur(0, len(postorder) - 1)


postorder = [1, 6, 3, 2, 5]
slt = Solution()
res = slt.verifyPostorder(postorder)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.postorder_traversal_of_a_binary_search_tree1255
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def verifyPostorder(self, postorder: List[int]) -> bool:
        stack, root = [], float("+inf")
        for i in range(len(postorder) - 1, -1, -1):
            if postorder[i] > root:
                return False
            while stack and postorder[i] < stack[-1]:
                root = stack.pop()
            stack.append(postorder[i])
        return True


postorder = [1, 6, 3, 2, 5]
slt = Solution()
res = slt.verifyPostorder(postorder)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.all_xsum_paths_in_a_binary_tree1256
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def pathSum(self, root: TreeNode, sum: int) -> List[List[int]]:
        res, path = [], []

        def recur(root, tar):
            if not root:
                return
            path.append(root.val)
            tar -= root.val
            if tar == 0 and not root.left and not root.right:
                res.append(list(path))
            recur(root.left, tar)
            recur(root.right, tar)
            path.pop()

        recur(root, sum)
        return res


root = list_to_tree(
    [
        5,
        4,
        8,
        11,
        None,
        13,
        4,
        7,
        2,
        None,
        None,
        5,
        1,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
    ]
)
sum = 22
slt = Solution()
res = slt.pathSum(root, sum)
print_matrix(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.clone_a_linked_list_with_next_and_random_pointer1257
    set output_file "main.py"

    set template_content '
from include import *

class Node:
    def __init__(self, x: int, next: "Node" = None, random: "Node" = None):
        self.val = int(x)
        self.next = next
        self.random = random

class Solution:
    def copyRandomList(self, head: "Node") -> "Node":
        if not head:
            return
        dic = {}
        # 3. 复制各节点，并建立 “原节点 -> 新节点” 的 Map 映射
        cur = head
        while cur:
            dic[cur] = Node(cur.val)
            cur = cur.next
        cur = head
        # 4. 构建新节点的 next 和 random 指向
        while cur:
            dic[cur].next = dic.get(cur.next)
            dic[cur].random = dic.get(cur.random)
            cur = cur.next
        # 5. 返回新链表的头节点
        return dic[head]


test_case = [[7, None], [13, 0], [11, 4], [10, 2], [1, 0]]
# Construct nodes
node_list = [Node(val) for val, _ in test_case]
# Build next reference
for i in range(len(test_case) - 1):
    node_list[i].next = node_list[i + 1]
# Build random reference
for i in range(len(test_case)):
    if test_case[i][1] != None:
        node_list[i].random = node_list[test_case[i][1]]
# Get the head of the linked list
head = node_list[0]
slt = Solution()
res = slt.copyRandomList(head)
# Print the copied linked list
node_list_new = []
while res:
    node_list_new.append(res)
    res = res.next
print(
    [
        [node.val, node_list_new.index(node.random) if node.random else None]
        for node in node_list_new
    ]
)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.clone_a_linked_list_with_next_and_random_pointer1258
    set output_file "main.py"

    set template_content '
from include import *

class Node:
    def __init__(self, x: int, next: "Node" = None, random: "Node" = None):
        self.val = int(x)
        self.next = next
        self.random = random

class Solution:
    def copyRandomList(self, head: "Node") -> "Node":
        if not head:
            return
        cur = head
        # 1. 复制各节点，并构建拼接链表
        while cur:
            tmp = Node(cur.val)
            tmp.next = cur.next
            cur.next = tmp
            cur = tmp.next
        # 2. 构建各新节点的 random 指向
        cur = head
        while cur:
            if cur.random:
                cur.next.random = cur.random.next
            cur = cur.next.next
        # 3. 拆分两链表
        cur = res = head.next
        pre = head
        while cur.next:
            pre.next = pre.next.next
            cur.next = cur.next.next
            pre = pre.next
            cur = cur.next
        pre.next = None  # 单独处理原链表尾节点
        return res  # 返回新链表头节点


test_case = [[7, None], [13, 0], [11, 4], [10, 2], [1, 0]]
# Construct nodes
node_list = [Node(val) for val, _ in test_case]
# Build next reference
for i in range(len(test_case) - 1):
    node_list[i].next = node_list[i + 1]
# Build random reference
for i in range(len(test_case)):
    if test_case[i][1] != None:
        node_list[i].random = node_list[test_case[i][1]]
# Get the head of the linked list
head = node_list[0]
slt = Solution()
res = slt.copyRandomList(head)
# Print the copied linked list
node_list_new = []
while res:
    node_list_new.append(res)
    res = res.next
print(
    [
        [node.val, node_list_new.index(node.random) if node.random else None]
        for node in node_list_new
    ]
)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.binary_search_tree_and_doubly_linked_list1259
    set output_file "main.py"

    set template_content '
from include import *

class Node:
    def __init__(self, val, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def treeToDoublyList(self, root: "Node") -> "Node":
        def dfs(cur):
            if not cur:
                return
            dfs(cur.left)  # 递归左子树
            if self.pre:  # 修改节点引用
                self.pre.right, cur.left = cur, self.pre
            else:  # 记录头节点
                self.head = cur
            self.pre = cur  # 保存 cur
            dfs(cur.right)  # 递归右子树

        if not root:
            return
        self.pre = None
        dfs(root)
        self.head.left, self.pre.right = self.pre, self.head
        return self.head

node_list = [Node(i) for i in range(1, 6)]
node_list[3].left = node_list[1]
node_list[3].right = node_list[4]
node_list[1].left = node_list[0]
node_list[1].right = node_list[2]
root = node_list[3]
slt = Solution()
res = slt.treeToDoublyList(root)
# Print the Doubly circular linked list
nodes_val = []
for _ in range(len(node_list) + 1):
    nodes_val.append(str(res.val))
    res = res.right
print(" <-> ".join(nodes_val))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.serialize_and_deserialize_a_binary_tree1260
    set output_file "main.py"

    set template_content '
from include import *

class Codec:
    def serialize(self, root: TreeNode) -> str:
        if not root:
            return "[]"
        queue = collections.deque()
        queue.append(root)
        res = []
        while queue:
            node = queue.popleft()
            if node:
                res.append(str(node.val))
                queue.append(node.left)
                queue.append(node.right)
            else:
                res.append("null")
        return "[" + ",".join(res) + "]"

    def deserialize(self, data: str) -> TreeNode:
        if data == "[]":
            return
        vals, i = data[1:-1].split(","), 1
        root = TreeNode(int(vals[0]))
        queue = collections.deque()
        queue.append(root)
        while queue:
            node = queue.popleft()
            if vals[i] != "null":
                node.left = TreeNode(int(vals[i]))
                queue.append(node.left)
            i += 1
            if vals[i] != "null":
                node.right = TreeNode(int(vals[i]))
                queue.append(node.right)
            i += 1
        return root

data = "[1,2,3,null,null,4,5,null,null,null,null]"
codec = Codec()
root = codec.deserialize(data)
res = codec.serialize(root)
print_tree(root)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.all_permutations_of_a_string1261
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def permutation(self, s: str) -> List[str]:
        c, res = list(s), []

        def dfs(x):
            if x == len(c) - 1:
                res.append("".join(c))  # 添加排列方案
                return
            dic = set()
            for i in range(x, len(c)):
                if c[i] in dic:
                    continue  # 重复，因此剪枝
                dic.add(c[i])
                c[i], c[x] = c[x], c[i]  # 交换，将 c[i] 固定在第 x 位
                dfs(x + 1)  # 开启固定第 x + 1 位字符
                c[i], c[x] = c[x], c[i]  # 恢复交换

        dfs(0)
        return res


s = "abc"
slt = Solution()
res = slt.permutation(s)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.the_majority_element_in_an_array1262
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        votes = 0
        for num in nums:
            if votes == 0:
                x = num
            votes += 1 if num == x else -1
        return x


nums = [1, 2, 3, 2, 2, 2, 5, 4, 2]
slt = Solution()
res = slt.majorityElement(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.the_majority_element_in_an_array1263
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        votes, count = 0, 0
        for num in nums:
            if votes == 0:
                x = num
            votes += 1 if num == x else -1
        # 验证 x 是否为众数
        for num in nums:
            if num == x:
                count += 1
        return x if count > len(nums) // 2 else 0  # 当无众数时返回 0


nums = [1, 2, 3, 2, 2, 2, 5, 4, 2]
slt = Solution()
res = slt.majorityElement(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.the_smallest_k_numbers1264
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def getLeastNumbers(self, arr: List[int], k: int) -> List[int]:
        def quick_sort(arr, l, r):
            # 子数组长度为 1 时终止递归
            if l >= r:
                return
            # 哨兵划分操作（以 arr[l] 作为基准数）
            i, j = l, r
            while i < j:
                while i < j and arr[j] >= arr[l]:
                    j -= 1
                while i < j and arr[i] <= arr[l]:
                    i += 1
                arr[i], arr[j] = arr[j], arr[i]
            arr[l], arr[i] = arr[i], arr[l]
            # 递归左（右）子数组执行哨兵划分
            quick_sort(arr, l, i - 1)
            quick_sort(arr, i + 1, r)

        quick_sort(arr, 0, len(arr) - 1)
        return arr[:k]


arr = [3, 2, 1]
k = 2
slt = Solution()
res = slt.getLeastNumbers(arr, k)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.the_smallest_k_numbers1265
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def getLeastNumbers(self, arr: List[int], k: int) -> List[int]:
        if k >= len(arr):
            return arr

        def quick_sort(l, r):
            i, j = l, r
            while i < j:
                while i < j and arr[j] >= arr[l]:
                    j -= 1
                while i < j and arr[i] <= arr[l]:
                    i += 1
                arr[i], arr[j] = arr[j], arr[i]
            arr[l], arr[i] = arr[i], arr[l]
            if k < i:
                return quick_sort(l, i - 1)
            if k > i:
                return quick_sort(i + 1, r)
            return arr[:k]

        return quick_sort(0, len(arr) - 1)

arr = [3, 2, 1]
k = 2
slt = Solution()
res = slt.getLeastNumbers(arr, k)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_median_from_data_stream1266
    set output_file "main.py"

    set template_content '
from include import *

from heapq import *


class MedianFinder:
    def __init__(self):
        self.A = []  # 小顶堆，保存较大的一半
        self.B = []  # 大顶堆，保存较小的一半

    def addNum(self, num: int) -> None:
        if len(self.A) != len(self.B):
            heappush(self.A, num)
            heappush(self.B, -heappop(self.A))
        else:
            heappush(self.B, -num)
            heappush(self.A, -heappop(self.B))

    def findMedian(self) -> float:
        return (
            self.A[0] if len(self.A) != len(self.B) else (self.A[0] - self.B[0]) / 2.0
        )

median_finder = MedianFinder()
res = [
    median_finder.addNum(1),
    median_finder.addNum(2),
    median_finder.findMedian(),
    median_finder.addNum(3),
    median_finder.findMedian(),
]
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.median_finder1267
    set output_file "main.py"

    set template_content '
from include import *

from heapq import *


class c:
    def __init__(self):
        self.A = []  # 小顶堆，保存较大的一半
        self.B = []  # 大顶堆，保存较小的一半

    def addNum(self, num: int) -> None:
        if len(self.A) != len(self.B):
            heappush(self.B, -heappushpop(self.A, num))
        else:
            heappush(self.A, -heappushpop(self.B, -num))

    def findMedian(self) -> float:
        return (
            self.A[0] if len(self.A) != len(self.B) else (self.A[0] - self.B[0]) / 2.0
        )


median_finder = MedianFinder()
res = [
    median_finder.addNum(1),
    median_finder.addNum(2),
    median_finder.findMedian(),
    median_finder.addNum(3),
    median_finder.findMedian(),
]
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.largest_sum_contiguous_subarray1268
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        for i in range(1, len(nums)):
            nums[i] += max(nums[i - 1], 0)
        return max(nums)

nums = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
slt = Solution()
res = slt.maxSubArray(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.total_number_of_1_in_integers1269
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def countDigitOne(self, n: int) -> int:
        digit, res = 1, 0
        high, cur, low = n // 10, n % 10, 0
        while high != 0 or cur != 0:
            if cur == 0:
                res += high * digit
            elif cur == 1:
                res += high * digit + low + 1
            else:
                res += (high + 1) * digit
            low += cur * digit
            cur = high % 10
            high //= 10
            digit *= 10
        return res

n = 12
slt = Solution()
res = slt.countDigitOne(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.nth_digit_1270
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def findNthDigit(self, n: int) -> int:
        digit, start, count = 1, 1, 9
        while n > count:  # 1.
            n -= count
            start *= 10
            digit += 1
            count = 9 * start * digit
        num = start + (n - 1) // digit  # 2.
        return int(str(num)[(n - 1) % digit])  # 3.

n = 3
slt = Solution()
res = slt.findNthDigit(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.arrange_an_array_into_the_smallest_number_1271
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def minNumber(self, nums: List[int]) -> str:
        def quick_sort(l, r):
            if l >= r:
                return
            i, j = l, r
            while i < j:
                while strs[j] + strs[l] >= strs[l] + strs[j] and i < j:
                    j -= 1
                while strs[i] + strs[l] <= strs[l] + strs[i] and i < j:
                    i += 1
                strs[i], strs[j] = strs[j], strs[i]
            strs[i], strs[l] = strs[l], strs[i]
            quick_sort(l, i - 1)
            quick_sort(i + 1, r)

        strs = [str(num) for num in nums]
        quick_sort(0, len(strs) - 1)
        return "".join(strs)


nums = [3, 30, 34, 5, 9]
slt = Solution()
res = slt.minNumber(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.arrange_an_array_into_the_smallest_number_1272
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def minNumber(self, nums: List[int]) -> str:
        def sort_rule(x, y):
            a, b = x + y, y + x
            if a > b:
                return 1
            elif a < b:
                return -1
            else:
                return 0

        strs = [str(num) for num in nums]
        strs.sort(key=functools.cmp_to_key(sort_rule))
        return "".join(strs)


nums = [3, 30, 34, 5, 9]
slt = Solution()
res = slt.minNumber(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.translate_numbers_into_strings_1273
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def translateNum(self, num: int) -> int:
        s = str(num)
        a = b = 1
        for i in range(2, len(s) + 1):
            a, b = (a + b if "10" <= s[i - 2 : i] <= "25" else a), a
        return a


num = 12258
slt = Solution()
res = slt.translateNum(num)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.translate_numbers_into_strings_1274
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def translateNum(self, num: int) -> int:
        s = str(num)
        a = b = 1
        for i in range(2, len(s) + 1):
            tmp = s[i - 2 : i]
            c = a + b if "10" <= tmp <= "25" else a
            b = a
            a = c
        return a


num = 12258
slt = Solution()
res = slt.translateNum(num)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.translate_numbers_into_strings_1274
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def translateNum(self, num: int) -> int:
        s = str(num)
        a = b = 1
        for i in range(len(s) - 2, -1, -1):
            a, b = (a + b if "10" <= s[i : i + 2] <= "25" else a), a
        return a


num = 12258
slt = Solution()
res = slt.translateNum(num)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.translate_numbers_into_strings_1275
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def translateNum(self, num: int) -> int:
        a = b = 1
        y = num % 10
        while num > 9:
            num //= 10
            x = num % 10
            a, b = (a + b if 10 <= 10 * x + y <= 25 else a), a
            y = x
        return a


num = 12258
slt = Solution()
res = slt.translateNum(num)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.translate_numbers_into_strings_1276
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def translateNum(self, num: int) -> int:
        a = b = 1
        y = num % 10
        while num > 9:
            num //= 10
            x = num % 10
            tmp = 10 * x + y
            c = a + b if 10 <= tmp <= 25 else a
            a, b = c, a
            y = x
        return a


num = 12258
slt = Solution()
res = slt.translateNum(num)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.the_maximum_value_of_gifts1277
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def maxValue(self, grid: List[List[int]]) -> int:
        for i in range(len(grid)):
            for j in range(len(grid[0])):
                if i == 0 and j == 0:
                    continue
                if i == 0:
                    grid[i][j] += grid[i][j - 1]
                elif j == 0:
                    grid[i][j] += grid[i - 1][j]
                else:
                    grid[i][j] += max(grid[i][j - 1], grid[i - 1][j])
        return grid[-1][-1]


grid = [[1, 3, 1], [1, 5, 1], [4, 2, 1]]
slt = Solution()
res = slt.maxValue(grid)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.the_maximum_value_of_gifts_1278
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def maxValue(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        for j in range(1, n):  # 初始化第一行
            grid[0][j] += grid[0][j - 1]
        for i in range(1, m):  # 初始化第一列
            grid[i][0] += grid[i - 1][0]
        for i in range(1, m):
            for j in range(1, n):
                grid[i][j] += max(grid[i][j - 1], grid[i - 1][j])
        return grid[-1][-1]


grid = [[1, 3, 1], [1, 5, 1], [4, 2, 1]]
slt = Solution()
res = slt.maxValue(grid)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.longest_substring_without_repeated_characters1279
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        dic = {}
        res = tmp = 0
        for j in range(len(s)):
            i = dic.get(s[j], -1)  # 获取索引 i
            dic[s[j]] = j  # 更新哈希表
            tmp = tmp + 1 if tmp < j - i else j - i  # dp[j - 1] -> dp[j]
            res = max(res, tmp)  # max(dp[j - 1], dp[j])
        return res


s = "abcabcbb"
slt = Solution()
res = slt.lengthOfLongestSubstring(s)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.longest_substring_without_repeated_characters1280
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        res = tmp = i = 0
        for j in range(len(s)):
            i = j - 1
            while i >= 0 and s[i] != s[j]:
                i -= 1  # 线性查找 i
            tmp = tmp + 1 if tmp < j - i else j - i  # dp[j - 1] -> dp[j]
            res = max(res, tmp)  # max(dp[j - 1], dp[j])
        return res


s = "abcabcbb"
slt = Solution()
res = slt.lengthOfLongestSubstring(s)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.longest_substring_without_repeated_characters1281
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        dic, res, i = {}, 0, -1
        for j in range(len(s)):
            if s[j] in dic:
                i = max(dic[s[j]], i)  # 更新左指针 i
            dic[s[j]] = j  # 哈希表记录
            res = max(res, j - i)  # 更新结果
        return res


s = "abcabcbb"
slt = Solution()
res = slt.lengthOfLongestSubstring(s)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.ugly_numbers_1282
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def nthUglyNumber(self, n: int) -> int:
        dp, a, b, c = [1] * n, 0, 0, 0
        for i in range(1, n):
            n2, n3, n5 = dp[a] * 2, dp[b] * 3, dp[c] * 5
            dp[i] = min(n2, n3, n5)
            if dp[i] == n2:
                a += 1
            if dp[i] == n3:
                b += 1
            if dp[i] == n5:
                c += 1
        return dp[-1]


n = 10
slt = Solution()
res = slt.nthUglyNumber(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_the_first_nonrepeating_character_in_a_string_1283
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def firstUniqChar(self, s: str) -> str:
        dic = {}
        for c in s:
            dic[c] = not c in dic
        for c in s:
            if dic[c]:
                return c
        return " "


s = "abaccdeff"
slt = Solution()
res = slt.firstUniqChar(s)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_the_first_nonrepeating_character_in_a_string_1284
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def firstUniqChar(self, s: str) -> str:
        dic = collections.OrderedDict()
        for c in s:
            dic[c] = not c in dic
        for k, v in dic.items():
            if v:
                return k
        return " "


s = "abaccdeff"
slt = Solution()
res = slt.firstUniqChar(s)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_the_first_nonrepeating_character_in_a_string_1285
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def firstUniqChar(self, s: str) -> str:
        dic = {}
        for c in s:
            dic[c] = not c in dic
        for k, v in dic.items():
            if v:
                return k
        return " "


s = "abaccdeff"
slt = Solution()
res = slt.firstUniqChar(s)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.reversed_pairs_in_an_array_1286
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reversePairs(self, nums: List[int]) -> int:
        def merge_sort(l, r):
            # 终止条件
            if l >= r:
                return 0
            # 递归划分
            m = (l + r) // 2
            res = merge_sort(l, m) + merge_sort(m + 1, r)
            # 合并阶段
            i, j = l, m + 1
            tmp[l : r + 1] = nums[l : r + 1]
            for k in range(l, r + 1):
                if i == m + 1:
                    nums[k] = tmp[j]
                    j += 1
                elif j == r + 1 or tmp[i] <= tmp[j]:
                    nums[k] = tmp[i]
                    i += 1
                else:
                    nums[k] = tmp[j]
                    j += 1
                    res += m - i + 1  # 统计逆序对
            return res

        tmp = [0] * len(nums)
        return merge_sort(0, len(nums) - 1)


nums = [7, 5, 6, 4]
slt = Solution()
res = slt.reversePairs(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.first_common_node_in_two_linked_lists1287
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def getIntersectionNode(self, headA: ListNode, headB: ListNode) -> ListNode:
        A, B = headA, headB
        while A != B:
            A = A.next if A else headB
            B = B.next if B else headA
        return A


# Build two linked lists with intersection of 8
# headA = 4 -> 1 -> 8 -> 4 -> 5
#                   ↑
# headB = 5 -> 0 -> 1
headA = list_to_linked_list([4, 1, 8, 4, 5])
headB = list_to_linked_list([5, 0, 1, 8, 4, 5])
intersectA = get_list_node(head=headA, val=8)
intersectB = get_list_node(head=headB, val=1)
intersectB.next = intersectA  # Concatenate the two lists
slt = Solution()
res = slt.getIntersectionNode(headA, headB)
print(res.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_a_number_in_a_sorted_array_1288
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def search(self, nums: List[int], target: int) -> int:
        # 搜索右边界 right
        i, j = 0, len(nums) - 1
        while i <= j:
            m = (i + j) // 2
            if nums[m] <= target:
                i = m + 1
            else:
                j = m - 1
        right = i
        # 若数组中无 target ，则提前返回
        if j >= 0 and nums[j] != target:
            return 0
        # 搜索左边界 left
        i = 0
        while i <= j:
            m = (i + j) // 2
            if nums[m] < target:
                i = m + 1
            else:
                j = m - 1
        left = j
        return right - left - 1


nums = [5, 7, 7, 8, 8, 10]
target = 8
slt = Solution()
res = slt.search(nums, target)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.find_a_number_in_a_sorted_array_1289
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def search(self, nums: List[int], target: int) -> int:
        def helper(tar):
            i, j = 0, len(nums) - 1
            while i <= j:
                m = (i + j) // 2
                if nums[m] <= tar:
                    i = m + 1
                else:
                    j = m - 1
            return i

        return helper(target) - helper(target - 1)


nums = [5, 7, 7, 8, 8, 10]
target = 8
slt = Solution()
res = slt.search(nums, target)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.kth_largest_node_of_a_binary_search_tree1290
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def kthLargest(self, root: TreeNode, k: int) -> int:
        def dfs(root):
            if not root:
                return
            dfs(root.right)
            if self.k == 0:
                return
            self.k -= 1
            if self.k == 0:
                self.res = root.val
            dfs(root.left)

        self.k = k
        dfs(root)
        return self.res


root = list_to_tree([3, 1, 4, None, 2, None, None, None, None])
k = 1
slt = Solution()
res = slt.kthLargest(root, k)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.depth_of_a_binary_tree_1291
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def maxDepth(self, root: TreeNode) -> int:
        if not root:
            return 0
        return max(self.maxDepth(root.left), self.maxDepth(root.right)) + 1


root = list_to_tree([3, 9, 20, None, None, 15, 7, None, None, None, None])
slt = Solution()
res = slt.maxDepth(root)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.depth_of_a_binary_tree_1292
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def maxDepth(self, root: TreeNode) -> int:
        if not root:
            return 0
        queue, res = [root], 0
        while queue:
            tmp = []
            for node in queue:
                if node.left:
                    tmp.append(node.left)
                if node.right:
                    tmp.append(node.right)
            queue = tmp
            res += 1
        return res


root = list_to_tree([3, 9, 20, None, None, 15, 7, None, None, None, None])
slt = Solution()
res = slt.maxDepth(root)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.balanced_binary_tree_1293
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def isBalanced(self, root: TreeNode) -> bool:
        def recur(root):
            if not root:
                return 0
            left = recur(root.left)
            if left == -1:
                return -1
            right = recur(root.right)
            if right == -1:
                return -1
            return max(left, right) + 1 if abs(left - right) <= 1 else -1

        return recur(root) != -1


root = list_to_tree([3, 9, 20, None, None, 15, 7, None, None, None, None])
slt = Solution()
res = slt.isBalanced(root)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.isBalanced1294
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def isBalanced(self, root: TreeNode) -> bool:
        if not root:
            return True
        return (
            abs(self.depth(root.left) - self.depth(root.right)) <= 1
            and self.isBalanced(root.left)
            and self.isBalanced(root.right)
        )

    def depth(self, root):
        if not root:
            return 0
        return max(self.depth(root.left), self.depth(root.right)) + 1


root = list_to_tree([3, 9, 20, None, None, 15, 7, None, None, None, None])
slt = Solution()
res = slt.isBalanced(root)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.single_number1295
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def singleNumbers(self, nums: List[int]) -> List[int]:
        x, y, n, m = 0, 0, 0, 1
        for num in nums:  # 1. 遍历异或
            n ^= num
        while n & m == 0:  # 2. 循环左移，计算 m
            m <<= 1
        for num in nums:  # 3. 遍历 nums 分组
            if num & m:
                x ^= num  # 4. 当 num & m != 0
            else:
                y ^= num  # 4. 当 num & m == 0
        return x, y  # 5. 返回出现一次的数字


nums = [4, 1, 4, 6]
slt = Solution()
res = slt.singleNumbers(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.single_number1296
    set output_file "main.py"

    set template_content '
from include import *



class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        ones, twos = 0, 0
        for num in nums:
            ones = ones ^ num & ~twos
            twos = twos ^ num & ~ones
        return ones


nums = [3, 4, 3, 3]
slt = Solution()
res = slt.singleNumber(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.single_number1297
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        counts = [0] * 32
        for num in nums:
            for i in range(32):
                counts[i] += num & 1  # 更新第 i 位 1 的个数之和
                num >>= 1  # 第 i 位 --> 第 i 位
        res, m = 0, 3
        for i in range(31, -1, -1):
            res <<= 1
            res |= counts[i] % m  # 恢复第 i 位
        return res if counts[31] % m == 0 else ~(res ^ 0xFFFFFFFF)


nums = [3, 4, 3, 3]
slt = Solution()
res = slt.singleNumber(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.two_numbers_with_sum1298
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        i, j = 0, len(nums) - 1
        while i < j:
            s = nums[i] + nums[j]
            if s > target:
                j -= 1
            elif s < target:
                i += 1
            else:
                return nums[i], nums[j]
        return []


nums = [2, 7, 11, 15]
target = 9
slt = Solution()
res = slt.twoSum(nums, target)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.consecutive_numbers_with_sum1299
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def findContinuousSequence(self, target: int) -> List[List[int]]:
        i, j, res = 1, 2, []
        while i < j:
            j = (-1 + (1 + 4 * (2 * target + i * i - i)) ** 0.5) / 2
            if i < j and j == int(j):
                res.append(list(range(i, int(j) + 1)))
            i += 1
        return res


target = 9
slt = Solution()
res = slt.findContinuousSequence(target)
print_matrix(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.consecutive_numbers_with_sum1300
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def findContinuousSequence(self, target: int) -> List[List[int]]:
        i, j, s, res = 1, 2, 3, []
        while i < j:
            if s == target:
                res.append(list(range(i, j + 1)))
            if s >= target:
                s -= i
                i += 1
            else:
                j += 1
                s += j
        return res


target = 9
slt = Solution()
res = slt.findContinuousSequence(target)
print_matrix(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.reverse_order_of_words_1301
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reverseWords(self, s: str) -> str:
        s = s.strip()  # 删除首尾空格
        i = j = len(s) - 1
        res = []
        while i >= 0:
            while i >= 0 and s[i] != " ":
                i -= 1  # 搜索首个空格
            res.append(s[i + 1 : j + 1])  # 添加单词
            while i >= 0 and s[i] == " ":
                i -= 1  # 跳过单词间空格
            j = i  # j 指向下个单词的尾字符
        return " ".join(res)  # 拼接并返回


s = "the sky is blue"
slt = Solution()
res = slt.reverseWords(s)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.reverse_order_of_words_1302
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reverseWords(self, s: str) -> str:
        s = s.strip()  # 删除首尾空格
        strs = s.split()  # 分割字符串
        strs.reverse()  # 翻转单词列表
        return " ".join(strs)  # 拼接为字符串并返回


s = "the sky is blue"
slt = Solution()
res = slt.reverseWords(s)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.reverse_order_of_words_1303
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reverseWords(self, s: str) -> str:
        return " ".join(s.strip().split()[::-1])


s = "the sky is blue"
slt = Solution()
res = slt.reverseWords(s)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.left_rotation_of_a_string_1304
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reverseLeftWords(self, s: str, n: int) -> str:
        return s[n:] + s[:n]


s = "abcdefg"
n = 2
slt = Solution()
res = slt.reverseLeftWords(s, n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.left_rotation_of_a_string_1305
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reverseLeftWords(self, s: str, n: int) -> str:
        res = []
        for i in range(n, len(s)):
            res.append(s[i])
        for i in range(n):
            res.append(s[i])
        return "".join(res)


s = "abcdefg"
n = 2
slt = Solution()
res = slt.reverseLeftWords(s, n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.left_rotation_of_a_string_1306
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reverseLeftWords(self, s: str, n: int) -> str:
        res = []
        for i in range(n, n + len(s)):
            res.append(s[i % len(s)])
        return "".join(res)


s = "abcdefg"
n = 2
slt = Solution()
res = slt.reverseLeftWords(s, n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.left_rotation_of_a_string_1307
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reverseLeftWords(self, s: str, n: int) -> str:
        res = ""
        for i in range(n, len(s)):
            res += s[i]
        for i in range(n):
            res += s[i]
        return res


s = "abcdefg"
n = 2
slt = Solution()
res = slt.reverseLeftWords(s, n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.left_rotation_of_a_string_1308
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def reverseLeftWords(self, s: str, n: int) -> str:
        res = ""
        for i in range(n, n + len(s)):
            res += s[i % len(s)]
        return res


s = "abcdefg"
n = 2
slt = Solution()
res = slt.reverseLeftWords(s, n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.sliding_window_maximum_1309
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        deque = collections.deque()
        res, n = [], len(nums)
        for i, j in zip(range(1 - k, n + 1 - k), range(n)):
            # 删除 deque 中对应的 nums[i-1]
            if i > 0 and deque[0] == nums[i - 1]:
                deque.popleft()
            # 保持 deque 递减
            while deque and deque[-1] < nums[j]:
                deque.pop()
            deque.append(nums[j])
            # 记录窗口最大值
            if i >= 0:
                res.append(deque[0])
        return res


nums = [1, 3, -1, -3, 5, 3, 6, 7]
k = 3
slt = Solution()
res = slt.maxSlidingWindow(nums, k)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.sliding_window_maximum_1310
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        if not nums or k == 0:
            return []
        deque = collections.deque()
        # 未形成窗口
        for i in range(k):
            while deque and deque[-1] < nums[i]:
                deque.pop()
            deque.append(nums[i])
        res = [deque[0]]
        # 形成窗口后
        for i in range(k, len(nums)):
            if deque[0] == nums[i - k]:
                deque.popleft()
            while deque and deque[-1] < nums[i]:
                deque.pop()
            deque.append(nums[i])
            res.append(deque[0])
        return res


nums = [1, 3, -1, -3, 5, 3, 6, 7]
k = 3
slt = Solution()
res = slt.maxSlidingWindow(nums, k)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.max_queue_1311
    set output_file "main.py"

    set template_content '
from include import *

import queue


class MaxQueue:
    def __init__(self):
        self.queue = queue.Queue()
        self.deque = queue.deque()

    def max_value(self) -> int:
        return self.deque[0] if self.deque else -1

    def push_back(self, value: int) -> None:
        self.queue.put(value)
        while self.deque and self.deque[-1] < value:
            self.deque.pop()
        self.deque.append(value)

    def pop_front(self) -> int:
        if self.queue.empty():
            return -1
        val = self.queue.get()
        if val == self.deque[0]:
            self.deque.popleft()
        return val


max_queue = MaxQueue()
res = [
    max_queue.push_back(1),
    max_queue.push_back(2),
    max_queue.max_value(),
    max_queue.pop_front(),
    max_queue.max_value(),
]
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.probabilities_for_rolling_n_dices1312
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def dicesProbability(self, n: int) -> List[float]:
        dp = [1 / 6] * 6
        for i in range(2, n + 1):
            tmp = [0] * (5 * i + 1)
            for j in range(len(dp)):
                for k in range(6):
                    tmp[j + k] += dp[j] / 6
            dp = tmp
        return dp


n = 2
slt = Solution()
res = slt.dicesProbability(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.straight_in_poker_1313
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def isStraight(self, nums: List[int]) -> bool:
        repeat = set()
        ma, mi = 0, 14
        for num in nums:
            if num == 0:
                continue  # 跳过大小王
            ma = max(ma, num)  # 最大牌
            mi = min(mi, num)  # 最小牌
            if num in repeat:
                return False  # 若有重复，提前返回 false
            repeat.add(num)  # 添加牌至 Set
        return ma - mi < 5  # 最大牌 - 最小牌 < 5 则可构成顺子


nums = [0, 0, 1, 2, 5]
slt = Solution()
res = slt.isStraight(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.straight_in_poker_1314
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def isStraight(self, nums: List[int]) -> bool:
        joker = 0
        nums.sort()  # 数组排序
        for i in range(4):
            if nums[i] == 0:
                joker += 1  # 统计大小王数量
            elif nums[i] == nums[i + 1]:
                return False  # 若有重复，提前返回 false
        return nums[4] - nums[joker] < 5  # 最大牌 - 最小牌 < 5 则可构成顺子


nums = [0, 0, 1, 2, 5]
slt = Solution()
res = slt.isStraight(nums)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.josephus_problem_1315
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def lastRemaining(self, n: int, m: int) -> int:
        x = 0
        for i in range(2, n + 1):
            x = (x + m) % i
        return x


n = 5
m = 3
slt = Solution()
res = slt.lastRemaining(n, m)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.maximum_profit_of_stocks1316
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        cost, profit = float("+inf"), 0
        for price in prices:
            cost = min(cost, price)
            profit = max(profit, price - cost)
        return profit


prices = [7, 1, 5, 3, 6, 4]
slt = Solution()
res = slt.maxProfit(prices)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.solve_12n_1317
    set output_file "main.py"

    set template_content '

from include import *


class Solution:
    def __init__(self):
        self.res = 0

    def sumNums(self, n: int) -> int:
        n > 1 and self.sumNums(n - 1)
        self.res += n
        return self.res


n = 3
slt = Solution()
res = slt.sumNums(n)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.operation_without_arithmetic_operators1318
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def add(self, a: int, b: int) -> int:
        x = 0xFFFFFFFF
        a, b = a & x, b & x
        while b != 0:
            a, b = (a ^ b), (a & b) << 1 & x
        return a if a <= 0x7FFFFFFF else ~(a ^ x)


a = 1
b = 1
slt = Solution()
res = slt.add(a, b)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.product_array_puzzle_1319
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def constructArr(self, a: List[int]) -> List[int]:
        b, tmp = [1] * len(a), 1
        for i in range(1, len(a)):
            b[i] = b[i - 1] * a[i - 1]  # 下三角
        for i in range(len(a) - 2, -1, -1):
            tmp *= a[i + 1]  # 上三角
            b[i] *= tmp  # 下三角 * 上三角
        return b


a = [1, 2, 3, 4, 5]
slt = Solution()
res = slt.constructArr(a)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.convert_string_to_int_1320
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def strToInt(self, str: str) -> int:
        str = str.strip()  # 删除首尾空格
        if not str:
            return 0  # 字符串为空则直接返回
        res, i, sign = 0, 1, 1
        int_max, int_min, bndry = 2**31 - 1, -(2**31), 2**31 // 10
        if str[0] == "-":
            sign = -1  # 保存负号
        elif str[0] != "+":
            i = 0  # 若无符号位，则需从 i = 0 开始数字拼接
        for c in str[i:]:
            if not "0" <= c <= "9":
                break  # 遇到非数字的字符则跳出
            if res > bndry or res == bndry and c > "7":
                return int_max if sign == 1 else int_min  # 数字越界处理
            res = 10 * res + ord(c) - ord("0")  # 数字拼接
        return sign * res


str = "42"
slt = Solution()
res = slt.strToInt(str)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.convert_string_to_int_1321
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def strToInt(self, str: str) -> int:
        res, i, sign, length = 0, 0, 1, len(str)
        int_max, int_min, bndry = 2**31 - 1, -(2**31), 2**31 // 10
        if not str:
            return 0  # 空字符串，提前返回
        while str[i] == " ":
            i += 1
            if i == length:
                return 0  # 字符串全为空格，提前返回
        if str[i] == "-":
            sign = -1
        if str[i] in "+-":
            i += 1
        for j in range(i, length):
            if not "0" <= str[j] <= "9":
                break
            if res > bndry or res == bndry and str[j] > "7":
                return int_max if sign == 1 else int_min
            res = 10 * res + ord(str[j]) - ord("0")
        return sign * res


str = "42"
slt = Solution()
res = slt.strToInt(str)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.nearest_common_ancestor_of_a_binary_search_tree_1322
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def lowestCommonAncestor(
        self, root: "TreeNode", p: "TreeNode", q: "TreeNode"
    ) -> "TreeNode":
        while root:
            if root.val < p.val and root.val < q.val:  # p,q 都在 root 的右子树中
                root = root.right  # 遍历至右子节点
            elif root.val > p.val and root.val > q.val:  # p,q 都在 root 的左子树中
                root = root.left  # 遍历至左子节点
            else:
                break
        return root


root = list_to_tree(
    [
        6,
        2,
        8,
        0,
        4,
        7,
        9,
        None,
        None,
        3,
        5,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
    ]
)
p = get_tree_node(root=root, val=2)
q = get_tree_node(root=root, val=8)
slt = Solution()
res = slt.lowestCommonAncestor(root, p, q)
print(res.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.nearest_common_ancestor_of_a_binary_search_tree_1323
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def lowestCommonAncestor(
        self, root: "TreeNode", p: "TreeNode", q: "TreeNode"
    ) -> "TreeNode":
        if p.val > q.val:
            p, q = q, p  # 保证 p.val < q.val
        while root:
            if root.val < p.val:  # p,q 都在 root 的右子树中
                root = root.right  # 遍历至右子节点
            elif root.val > q.val:  # p,q 都在 root 的左子树中
                root = root.left  # 遍历至左子节点
            else:
                break
        return root


root = list_to_tree(
    [
        6,
        2,
        8,
        0,
        4,
        7,
        9,
        None,
        None,
        3,
        5,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
    ]
)
p = get_tree_node(root=root, val=2)
q = get_tree_node(root=root, val=8)
slt = Solution()
res = slt.lowestCommonAncestor(root, p, q)
print(res.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.nearest_common_ancestor_of_a_binary_search_tree_1324
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def lowestCommonAncestor(
        self, root: "TreeNode", p: "TreeNode", q: "TreeNode"
    ) -> "TreeNode":
        if root.val < p.val and root.val < q.val:
            return self.lowestCommonAncestor(root.right, p, q)
        if root.val > p.val and root.val > q.val:
            return self.lowestCommonAncestor(root.left, p, q)
        return root


root = list_to_tree(
    [
        6,
        2,
        8,
        0,
        4,
        7,
        9,
        None,
        None,
        3,
        5,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
    ]
)
p = get_tree_node(root=root, val=2)
q = get_tree_node(root=root, val=8)
slt = Solution()
res = slt.lowestCommonAncestor(root, p, q)
print(res.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.nearest_common_ancestor_of_a_binary_tree_1325
    set output_file "main.py"

    set template_content '
from include import *

class Solution:
    def lowestCommonAncestor(
        self, root: TreeNode, p: TreeNode, q: TreeNode
    ) -> TreeNode:
        if not root or root == p or root == q:
            return root
        left = self.lowestCommonAncestor(root.left, p, q)
        right = self.lowestCommonAncestor(root.right, p, q)
        if not left:
            return right
        if not right:
            return left
        return root


root = list_to_tree(
    [
        3,
        5,
        1,
        6,
        2,
        0,
        8,
        None,
        None,
        7,
        4,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
    ]
)
p = get_tree_node(root=root, val=5)
q = get_tree_node(root=root, val=1)
slt = Solution()
res = slt.lowestCommonAncestor(root, p, q)
print(res.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.nearest_common_ancestor_of_a_binary_tree_1326
    set output_file "main.py"

    set template_content '
from include import *


class Solution:
    def lowestCommonAncestor(
        self, root: TreeNode, p: TreeNode, q: TreeNode
    ) -> TreeNode:
        if not root or root == p or root == q:
            return root
        left = self.lowestCommonAncestor(root.left, p, q)
        right = self.lowestCommonAncestor(root.right, p, q)
        if not left and not right:
            return  # 1.
        if not left:
            return right  # 3.
        if not right:
            return left  # 4.
        return root  # 2. if left and right:


root = list_to_tree(
    [
        3,
        5,
        1,
        6,
        2,
        0,
        8,
        None,
        None,
        7,
        4,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
    ]
)
p = get_tree_node(root=root, val=5)
q = get_tree_node(root=root, val=1)
slt = Solution()
res = slt.lowestCommonAncestor(root, p, q)
print(res.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.Find_longest_repeating_substring_in_string1327
    set output_file "main.py"

    set template_content '
def maxStr(string):
    if string == None or len(string) <= 0:
        return
    if len(string) == 1:
        return [string, 0]
    length = len(string)
    temp = []
    for i in range(length):
        temp.append(string[i:])
    listWithIndex = []
    for index, val in enumerate(temp):
        listWithIndex.append([val, index+1])
    listWithIndex.sort()
    maxLength, maxList, maxIndex = 0, "", 0
    for listIndex in range(length-1):
        firstList = listWithIndex[listIndex]
        secondList = listWithIndex[listIndex+1]
        index, tempLength, tempList = 0, 0, ""
        while index < len(firstList[0]) and index < len(secondList[0]) and firstList[0][index] == secondList[0][index]:
            tempLength += 1
            tempList += firstList[0][index]
            index += 1
        if tempLength > maxLength:
            maxLength = tempLength
            maxList = tempList
            maxIndex = min(firstList[1], secondList[1])
    return [maxList, maxIndex]


print(maxStr("yyabcdabjcabceg"))
print(maxStr("abcbc"))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.numbers_from_1_to_largest_number1328
    set output_file "main.py"

    set template_content '
def Print1ToMaxOfNDigits(n):
    if n <= 0:
        return

    number = ['0'] * n
    while not Increment(number):
        PrintNumber(number)

def Increment(number):
    isOverflow = False
    nTakeOver = 0
    nLength = len(number)

    for i in range(nLength-1, -1, -1):
        nSum = int(number[i]) + nTakeOver
        if i == nLength - 1:
            nSum += 1

        if nSum >= 10:
            if i == 0:
                isOverflow = True
            else:
                nSum -= 10
                nTakeOver = 1
                number[i] = str(nSum)
        else:
            number[i] = str(nSum)
            break

    return isOverflow

def PrintNumber(number):
    isBeginning0 = True
    nLength = len(number)

    for i in range(nLength):
        if isBeginning0 and number[i] != '0':
            isBeginning0 = False
        if not isBeginning0:
            print('%c' % number[i], end='')
    print('')
# Print1ToMaxOfNDigits(2)

def Print1ToMaxOfNDigits2(n):
    if n <= 0:
        return

    number = ['0'] * n
    for i in range(10):
        number[0] = str(i)
        Print1ToMaxOfNDigitsRecursively(number, n, 0)

def Print1ToMaxOfNDigitsRecursively(number, length, index):
    if index == length - 1:
        PrintNumber(number)
        return
    for i in range(10):
        number[index + 1] = str(i)
        Print1ToMaxOfNDigitsRecursively(number, length, index+1)

Print1ToMaxOfNDigits2(2)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Straights_in_poker1329
    set output_file "main.py"

    set template_content '
class Solution:
    def IsContinuous(self, numbers):
        if numbers == None or len(numbers) <= 0:
            return False
        # 把A、J、Q、K转化一下
        transDict = {'A': 1, 'J': 11, 'Q': 12, 'K': 13}
        for i in range(len(numbers)):
            if numbers[i] in transDict.keys():
                numbers[i] = transDict[numbers[i]]

        numbers = sorted(numbers)
        numberOfzero = 0
        numberOfGap = 0

        # 统计0的个数
        i = 0
        while i < len(numbers) and numbers[i] == 0:
            numberOfzero += 1
            i += 1
        # 统计间隔的数目
        small = numberOfzero
        big = small + 1
        while big < len(numbers):
            # 出现对子, 不可能是顺子
            if numbers[small] == numbers[big]:
                return False

            numberOfGap += numbers[big] - numbers[small] - 1
            small = big
            big += 1
        return False if numberOfGap > numberOfzero else True

test = ['A', 3, 2, 5, 0]
test2 = [0, 3, 1, 6, 4]
s = Solution()
print(s.IsContinuous(test2))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SerializeBinaryTree1330
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
class Solution:
    def Serialize(self, root):
        serializeStr = ''
        if root == None:
            return '#'
        stack = []
        while root or stack:
            while root:
                serializeStr += str(root.val) + ','
                stack.append(root)
                root = root.left
            serializeStr += '#,'
            root = stack.pop()
            root = root.right
        serializeStr = serializeStr[:-1]
        return serializeStr

    def Deserialize(self, s):
        serialize = s.split(',')
        tree, sp = self.deserialize(serialize, 0)
        return tree

    def deserialize(self, s, sp):
        if sp >= len(s) or s[sp] == '#':
            return None, sp + 1
        node = TreeNode(int(s[sp]))
        sp += 1
        node.left, sp = self.deserialize(s, sp)
        node.right, sp = self.deserialize(s, sp)
        return node, sp
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LockedDoor1331
    set output_file "main.py"

    set template_content '
def openDoor(n):
    if n == None or n <= 0:
        return
    doorList = [0] * (n+1)
    for i in range(1, len(doorList)):
        j = i
        while j <= n:
            doorList[j] = 1 - doorList[j]
            j += i
    output = [i for i, x in enumerate(doorList) if x != 0]
    return output

print(openDoor(16))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SymmetricBinaryTree1332
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
class Solution:
    def isSymmetrical(self, pRoot):
         return self.selfIsSymmetrical(pRoot, pRoot)
    def selfIsSymmetrical(self, pRoot1, pRoot2):
        if pRoot1 == None and pRoot2 == None:
            return True
        if pRoot1 == None or pRoot2 == None:
            return False
        if pRoot1.val != pRoot2.val:
            return False
        return self.selfIsSymmetrical(pRoot1.left, pRoot2.right) and self.selfIsSymmetrical(pRoot1.right, pRoot2.left)
# 非递归实现判断二叉树是否对称
# 利用前序遍历
class Solution2:
    def isSymmetrical(self, pRoot):
        preList = self.preOrder(pRoot)
        mirrorList = self.mirrorPreOrder(pRoot)
        if preList == mirrorList:
            return True
        return False

    def preOrder(self, pRoot):
        if pRoot == None:
            return [None]
        treeStack = []
        output = []
        pNode = pRoot
        while pNode or len(treeStack) > 0:
            while pNode:
                treeStack.append(pNode)
                output.append(pNode.val)
                pNode = pNode.left
                if not pNode:
                    output.append(None)
            if len(treeStack):
                pNode = treeStack.pop()
                pNode = pNode.right
                if not pNode:
                    output.append(None)
        return output

    def mirrorPreOrder(self, pRoot):
        if pRoot == None:
            return [None]
        treeStack = []
        output = []
        pNode = pRoot
        while pNode or len(treeStack) > 0:
            while pNode:
                treeStack.append(pNode)
                output.append(pNode.val)
                pNode = pNode.right
                if not pNode:
                    output.append(None)
            if len(treeStack):
                pNode = treeStack.pop()
                pNode = pNode.left
                if not pNode:
                    output.append(None)
        return output

pNode1 = TreeNode(8)
pNode2 = TreeNode(6)
pNode3 = TreeNode(10)
pNode4 = TreeNode(5)
pNode5 = TreeNode(7)
pNode6 = TreeNode(9)
pNode7 = TreeNode(11)

pNode1.left = pNode2
pNode1.right = pNode3
pNode2.left = pNode4
pNode2.right = pNode5
pNode3.left = pNode6
pNode3.right = pNode7

S = Solution2()
result = S.isSymmetrical(pNode1)
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.non-repeating_characterStream1333
    set output_file "main.py"

    set template_content '
class Solution:
    def __init__(self):
        self.adict = {}
        self.alist = []
    def FirstAppearingOnce(self):
        while len(self.alist) > 0 and self.adict[self.alist[0]] == 2:
            self.alist.pop(0)
        if len(self.alist) == 0:
            return '#'
        else:
            return self.alist[0]
    def Insert(self, char):
        if char not in self.adict.keys():
            self.adict[char] = 1
            self.alist.append(char)
        elif self.adict[char]:
            self.adict[char] = 2
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.String_permutations_combinations1334
    set output_file "main.py"

    set template_content '
class Solution:
    def Permutation(self, ss):
        if not len(ss):
            return []
        if len(ss) == 1:
            return list(ss)

        charList = list(ss)
        charList.sort()
        pStr = []
        for i in range(len(charList)):
            if i > 0 and charList[i] == charList[i-1]:
                continue
            temp = self.Permutation(''.join(charList[:i])+''.join(charList[i+1:]))
            for j in temp:
                pStr.append(charList[i]+j)
        return pStr

    # 扩展习题, 生成字符的所有组合
    # 比如输入abc, 则他们的组合有['a', 'ab', 'abc', 'ac', 'b', 'bc', 'c'], ab和ba属于不同的排列, 但属于同一个组合
    def group(self, ss):
        if not len(ss):
            return []
        if len(ss) == 1:
            return list(ss)
        charList = list(ss)
        charList.sort()
        pStr = []
        for i in range(len(charList)):
            pStr.append(charList[i])
            if i > 0 and charList[i] == charList[i - 1]:
                continue
            temp = self.group(''.join(charList[i + 1:]))
            for j in temp:
                pStr.append(charList[i] + j)
            pStr = list(set(pStr))
            pStr.sort()
        return pStr

ss = 'acb'
S = Solution()
# print(S.Permutation(ss))
print(S.group(ss))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.StringLeftRotation1335
    set output_file "main.py"

    set template_content '
class Solution:
    def LeftRotateString(self, s, n):
        if len(s) <= 0 or len(s) < n or n < 0:
            return ''
        strList= list(s)
        self.Reverse(strList)
        length = len(s)
        pivot = length - n
        frontList = self.Reverse(strList[:pivot])
        behindList = self.Reverse(strList[pivot:])
        resultStr = ''.join(frontList) + ''.join(behindList)
        return resultStr

    def Reverse(self, alist):
        if alist == None or len(alist) <= 0:
            return ''
        startIndex = 0
        endIndex = len(alist) - 1
        while startIndex < endIndex:
            alist[startIndex], alist[endIndex] = alist[endIndex], alist[startIndex]
            startIndex += 1
            endIndex -= 1
        return alist

test = 'abcdefg'
s = Solution()
print(s.LeftRotateString(test, 2))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestSubstring_string_with_sameCharacter1336
    set output_file "main.py"

    set template_content '
def findCommonLCS(s):
    if not s:
        return ""
    if len(s) == 1:
        return s
    length = len(s)
    maxIndex, maxLength = 0, 1
    curIndex = 0
    while curIndex < length:
        tempLength = 1
        while curIndex + tempLength < length and s[curIndex] == s[curIndex+tempLength]:
            tempLength += 1
        if maxLength < tempLength:
            maxLength = tempLength
            maxIndex = curIndex
        if curIndex + tempLength == length:
            break
        curIndex += tempLength
    if maxLength == 1:
        return s[0]
    else:
        res = s[maxIndex:maxIndex+maxLength]
        return res

print(findCommonLCS("abbbasagsagsgdsaagaaccagcfsccccc"))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Copyingcomplexlinkedlists1337
    set output_file "main.py"

    set template_content '
class RandomListNode:
    def __init__(self, x):
        self.label = x
        self.next = None
        self.random = None
class Solution:
    # 返回 RandomListNode
    def Clone(self, pHead):
        if pHead == None:
            return None
        self.CloneNodes(pHead)
        self.ConnectRandomNodes(pHead)
        return self.ReconnectNodes(pHead)
    # 复制原始链表的每个结点, 将复制的结点链接在其原始结点的后面
    def CloneNodes(self, pHead):
        pNode = pHead
        while pNode:
            pCloned = RandomListNode(0)
            pCloned.label = pNode.label
            pCloned.next = pNode.next
            # pCloned.random = None         #不需要写这句话, 因为创建新的结点的时候,random自动指向None

            pNode.next = pCloned
            pNode = pCloned.next

    # 将复制后的链表中的复制结点的random指针链接到被复制结点random指针的后一个结点
    def ConnectRandomNodes(self, pHead):
        pNode = pHead
        while pNode:
            pCloned = pNode.next
            if pNode.random != None:
                pCloned.random = pNode.random.next
            pNode = pCloned.next

    # 拆分链表, 将原始链表的结点组成新的链表, 复制结点组成复制后的链表
    def ReconnectNodes(self, pHead):
        pNode = pHead
        pClonedHead = pClonedNode = pNode.next
        pNode.next = pClonedHead.next
        pNode = pNode.next

        while pNode:
            pClonedNode.next = pNode.next
            pClonedNode = pClonedNode.next
            pNode.next = pClonedNode.next
            pNode = pNode.next

        return pClonedHead

node1 = RandomListNode(1)
node2 = RandomListNode(3)
node3 = RandomListNode(5)
node1.next = node2
node2.next = node3
node1.random = node3

S = Solution()
clonedNode = S.Clone(node1)
print(clonedNode.random.label)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Deletenode_linkedlist1338
    set output_file "main.py"

    set template_content '
class ListNode:
    def __init__(self, x=None):
        self.val = x
        self.next = None
    def __del__(self):
        self.val = None
        self.next = None

class Solution:
    def DeleteNode(self, pListHead, pToBeDeleted):
        if not pListHead or not pToBeDeleted:
            return None

        if pToBeDeleted.next != None:
            pNext = pToBeDeleted.next
            pToBeDeleted.val = pNext.val
            pToBeDeleted.next = pNext.next
            pNext.__del__()


        elif pListHead == pToBeDeleted:
            pToBeDeleted.__del__()
            pListHead.__del__()
        else:
            pNode = pListHead
            while pNode.next != pToBeDeleted:
                pNode = pNode.next
            pNode.next = None
            pToBeDeleted.__del__()


node1 = ListNode(10)
node2 = ListNode(11)
node3 = ListNode(13)
node4 = ListNode(15)
node1.next = node2
node2.next = node3
node3.next = node4

S = Solution()
S.DeleteNode(node1, node3)
print(node3.val)
S.DeleteNode(node1, node3)
print(node3.val)
print(node2.val)
S.DeleteNode(node1, node1)
print(node1.val)
S.DeleteNode(node1, node1)
print(node1.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.continuous_sequence_integerswithSum1339
    set output_file "main.py"

    set template_content '
class Solution:
    def FindContinuousSequence(self, tsum):
        if tsum < 3:
            return []
        small = 1
        big = 2
        middle = (tsum + 1) // 2
        curSum = small + big
        output = []
        while small < middle:
            if curSum == tsum:
                output.append(list(range(small, big+1)))
            while curSum > tsum and small < middle:
                curSum -= small
                small += 1
                if curSum == tsum:
                    output.append(list(range(small, big+1)))
            big += 1
            curSum += big
        return output

    def FindContinuousSequence2(self, tsum):
        if tsum < 3:
            return []
        small, big = 1, 2
        middle = (tsum + 1) >> 1
        curSum = small + big
        output = []
        while small < middle:
            if curSum == tsum:
                output.append(list(range(small, big + 1)))
                big += 1
                curSum += big
            elif curSum > tsum:
                curSum -= small
                small += 1
            else:
                big += 1
                curSum += big
        return output
s = Solution()
print(s.FindContinuousSequence2(15))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TwoNumbersWhoseSum1340
    set output_file "main.py"

    set template_content '
class Solution:
    # 从左右一起查找
    # 因为当两个数的和一定的时候, 两个数字的间隔越大, 乘积越小
    # 所以直接输出查找到的第一对数即可
    def FindNumbersWithSum(self, array, tsum):
        if array == None or len(array) <= 0 or array[-1] + array[-2] < tsum:
            return []
        start = 0
        end = len(array)-1
        while start < end:
            sum = array[start] + array[end]

            if sum < tsum:
                start += 1
            elif sum > tsum:
                end -= 1
            else:
                return [array[start], array[end]]
        return []

test = [1,2,4,7,11,15]
s = Solution()
print(s.FindNumbersWithSum(test, 15))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MergeTwoSorted_linkedLists1341
    set output_file "main.py"

    set template_content '
class ListNode:
    def __init__(self, x):
        self.val = x
        self.next = None
class Solution:
    # 返回合并后列表
    def Merge(self, pHead1, pHead2):
        if pHead1 == None:
            return pHead2
        elif pHead2 == None:
            return pHead1

        pMergedHead = None
        if pHead1.val < pHead2.val:
            pMergedHead = pHead1
            pMergedHead.next = self.Merge(pHead1.next, pHead2)
        else:
            pMergedHead = pHead2
            pMergedHead.next = self.Merge(pHead1, pHead2.next)

        return pMergedHead

node1 = ListNode(1)
node2 = ListNode(3)
node3 = ListNode(5)
node1.next = node2
node2.next = node3

node4 = ListNode(2)
node5 = ListNode(4)
node6 = ListNode(6)
node4.next = node5
node5.next = node6

S = Solution()
S.Merge(node1, node4)
print(node4.next.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CapitalizeFirstLetterEachWord1342
    set output_file "main.py"

    set template_content '
def title(s):
    if not s:
        return ""
    res = ""
    diff = ord("a") - ord("A")
    for i in range(1, len(s)):
        if s[i-1] == " " and s[i] <= "z" and s[i] >= "a":
            res += chr(ord(s[i]) - diff)
        elif s[i-1] != " " and s[i] <= "Z" and s[i] >= "A":
            res += chr(ord(s[i]) + diff)
        else:
            res += s[i]
    if s[0] <= "z" and s[0] >= "a":
        res = chr(ord(s[0]) - diff) + res
    else:
        res = s[0] + res
    return res

def title2(s):
    return s.title()

print(title2(" sDsa sddr jki "))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ReverseLinkedList1343
    set output_file "main.py"

    set template_content '
class ListNode:
    def __init__(self, x):
        self.val = x
        self.next = None
class Solution:
    # 返回ListNode
    def ReverseList(self, pHead):
        pReversedHead = None
        pNode = pHead
        pPrev = None
        while pNode != None:
            pNext = pNode.next

            if pNext == None:
                pReversedHead = pNode

            pNode.next = pPrev
            pPrev = pNode
            pNode = pNext
        return pReversedHead
    # 递归实现反转链表
    def ReverseListRec(self, pHead):
        if not pHead or not pHead.next:
            return pHead
        else:
            pReversedHead = self.ReverseList(pHead.next)
            pHead.next.next = pHead
            pHead.next = None
            return pReversedHead

node1 = ListNode(10)
node2 = ListNode(11)
node3 = ListNode(13)
node1.next = node2
node2.next = node3

S = Solution()
p = S.ReverseList(node1)
print(p.next.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ReversePrintLinkedList1344
    set output_file "main.py"

    set template_content '
class ListNode:
    def __init__(self, x=None):
        self.val = x
        self.next = None

class Solution:
    def printListFromTailToHead(self, listNode):
        if listNode.val == None:
            return
        l = []
        head = listNode
        while head:
            l.insert(0, head.val)
            head = head.next
        return l

node1 = ListNode(10)
node2 = ListNode(11)
node3 = ListNode(13)
node1.next = node2
node2.next = node3

singleNode = ListNode(12)

test = ListNode()

S = Solution()
print(S.printListFromTailToHead(node1))
print(S.printListFromTailToHead(test))
print(S.printListFromTailToHead(singleNode))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.StackFunction1345
    set output_file "main.py"

    set template_content '
class Solution:
    def __init__(self):
        self.stack = []
        self.minStack = []
    def push(self, node):
        self.stack.append(node)
        if self.minStack == [] or node < self.min():
            self.minStack.append(node)
        else:
            temp = self.min()
            self.minStack.append(temp)

    def pop(self):
        if self.stack == [] or self.minStack == []:
            return None
        self.minStack.pop()
        self.stack.pop()

    def top(self):
        return self.stack[-1]
    def min(self):
        return self.minStack[-1]

S = Solution()
S.push(3)
S.push(4)
S.push(2)
S.push(1)
print(S.min())
S.pop()
print(S.min())
S.pop()
print(S.min())
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DetermineBalancedBinaryTree1346
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
class Solution:
    def __init__(self):
        self.flag = True

    def IsBalanced_Solution(self, pRoot):
        self.getDepth(pRoot)
        return self.flag

    def getDepth(self, pRoot):
        if pRoot == None:
            return 0
        left = 1 + self.getDepth(pRoot.left)
        right = 1 + self.getDepth(pRoot.right)

        if abs(left - right) > 1:
            self.flag = False

        return left if left > right else right
class Solution2:
    def getDepth(self, pRoot):
        if pRoot == None:
            return 0
        return max(self.getDepth(pRoot.left), self.getDepth(pRoot.right)) + 1
    def IsBalanced_Solution(self, pRoot):
        if pRoot == None:
            return True
        if abs(self.getDepth(pRoot.left)-self.getDepth(pRoot.right)) > 1:
            return False
        return self.IsBalanced_Solution(pRoot.left) and self.IsBalanced_Solution(pRoot.right)


pNode1 = TreeNode(1)
pNode2 = TreeNode(2)
pNode3 = TreeNode(3)
pNode4 = TreeNode(4)
pNode5 = TreeNode(5)
pNode6 = TreeNode(6)
pNode7 = TreeNode(7)

pNode1.left = pNode2
pNode1.right = pNode3
pNode2.left = pNode4
pNode2.right = pNode5
pNode3.right = pNode6
pNode5.left = pNode7

S = Solution2()
print(S.getDepth(pNode1))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RemoveDuplicateNodes_LinkedList1347
    set output_file "main.py"

    set template_content '
class ListNode:
    def __init__(self, x):
        self.val = x
        self.next = None
class Solution:
    def deleteDuplication(self, pHead):
        if pHead == None:
            return
        preHead = None
        pNode = pHead
        while pNode != None:
            needDelete = False
            nextNode = pNode.next
            if nextNode != None and nextNode.val == pNode.val:
                needDelete = True
            if needDelete == False:
                preHead = pNode
                pNode = pNode.next
            else:
                nodeVal = pNode.val
                pToBeDel = pNode
                while pToBeDel != None and pToBeDel.val == nodeVal:
                    pToBeDel = pToBeDel.next
                if preHead == None:
                    pHead = pToBeDel
                    pNode = pToBeDel
                    continue
                else:
                    preHead.next = pToBeDel
                pNode = preHead
        return pHead

node1 = ListNode(1)
node2 = ListNode(2)
node3 = ListNode(3)
node4 = ListNode(3)
node5 = ListNode(4)
node6 = ListNode(4)
node7 = ListNode(5)
node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5
node5.next = node6
node6.next = node7

s = Solution()
print(s.deleteDuplication(node1).next.next.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Divide_and_conquer1348
    set output_file "main.py"

    set template_content '
class nearestPoint:
    def __init__(self, aList):
        self.aList = aList

    def calculate(self):
        if self.aList == None or len(self.aList) == 0:
            return
        if len(self.aList) == 1:
            return 0

        global xRangeList, yRangeList
        xRangeList, yRangeList = self.Mergesort(self.aList, 0), self.Mergesort(self.aList, 1)
        return self.ClosestPair(xRangeList, yRangeList)

    def Mergesort(self, aList, axis):
        if len(aList) <= 1:
            return aList
        pivot = len(aList)//2
        leftArray = aList[:pivot]
        rightArray = aList[pivot:]
        return self.Merge(self.Mergesort(leftArray, axis), self.Mergesort(rightArray, axis), axis)
    def Merge(self, leftList, rightList, axis):
        output = []
        leftIndex, rightIndex = 0, 0
        while leftIndex < len(leftList) and rightIndex < len(rightList):
            if leftList[leftIndex][axis] < rightList[rightIndex][axis]:
                output.append(leftList[leftIndex])
                leftIndex += 1
            else:
                output.append(rightList[rightIndex])
                rightIndex += 1
        while leftIndex < len(leftList):
            output.append(leftList[leftIndex])
            leftIndex += 1
        while rightIndex < len(rightList):
            output.append(rightList[rightIndex])
            rightIndex += 1
        return output

    def ClosestPair(self, xList, yList):
        if len(xList) == 2:
            temp1 = ((xList[0][0]-xList[1][0])**2+(xList[0][1]-xList[1][1])**2)**0.5
            temp2 = ((yList[0][0]-yList[1][0])**2+(yList[0][1]-yList[1][1])**2)**0.5
            return min(temp1, temp2)
        elif len(xList) == 3:
            temp1 = min((xList[1][0] - xList[0][0])**2 + (xList[1][1] - xList[0][1])**2, (yList[1][0] - yList[0][0])**2 + (yList[1][1] - yList[0][1])**2)
            temp2 = min((xList[2][0] - xList[0][0])**2 + (xList[2][1] - xList[0][1])**2, (yList[2][0] - yList[0][0])**2 + (yList[2][1] - yList[0][1])**2)
            temp3 = min((xList[2][0] - xList[1][0])**2 + (xList[2][1] - xList[1][1])**2, (yList[2][0] - yList[1][0])**2 + (yList[2][1] - yList[1][1])**2)
            temp = min(temp1, temp2)
            return (min(temp, temp3))**0.5
        else:
            length = len(xList)
            pivot = length//2
            xLeft, xRight, yLeft, yRight = xList[:pivot], xList[pivot:], yList[:pivot], yList[pivot:]
            d1, d2 = self.ClosestPair(xLeft, yLeft), self.ClosestPair(xRight, yRight)
            d = min(d1, d2)

            m = xList[pivot][0]
            S = []
            for i in range(len(yList)):
                if abs(yList[i][0] - m) < d:
                    S.append(yList[i])
            dminsq = d**2
            if len(S) > 2:
                for i in range(len(S)-1):
                    k = i + 1
                    while k <= len(S) - 1 and (S[k][1] - S[i][1])**2 < dminsq:
                        dminsq = min((S[k][0]-S[i][0])**2+(S[k][1]-S[i][1])**2, dminsq)
                        k += 1
            elif len(S) == 2:
                dminsq = min((S[1][0]-S[0][0])**2+(S[1][1]-S[0][1])**2, dminsq)
        return dminsq**0.5



A = [[3.7,2.7],[6.9,10.2],[10.5,6.3],[2.0,5.2],[7.6,9.6],[6.4,6.8],[8.9,6.3],[4.8,9.9],[3.1,6.1],[5.3,5.8],[3.6,8.1],[2.9,3.7],[3.2,4.1],[4.7,3.9]]
s = nearestPoint(A)
print(s.calculate())
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.EightQueensProblem1349
    set output_file "main.py"

    set template_content '
class Solution:
    # 全排列出所有顶点组合
    def Permutation(self, pointArr):
        if not len(pointArr):
            return []
        if len(pointArr) == 1:
            return pointArr
        numList = pointArr
        numList.sort()
        pStr = []
        for i in range(len(numList)):
            if i > 0 and numList[i] == numList[i-1]:
                continue
            temp = self.Permutation(numList[:i] + numList[i+1:])
            if type(temp[0]) == int:
                for j in temp:
                    pStr.append([numList[i]] + [j])
            else:
                for j in temp:
                    tempArr = [numList[i]] + j
                    pStr.append(tempArr)
        return pStr

    def Judge(self, alist):
        length = len(alist)
        for i in range(length):
            for j in range(length):
                if i == j:
                    continue
                if i - j == alist[i] - alist[j] or j - i == alist[i] - alist[j]:
                    return False
        return True

    def queen(self, alist):
        allAns = self.Permutation(alist)
        for tempList in allAns:
            isQueen = self.Judge(tempList)
            if isQueen:
                print(tempList)


s = Solution()
s.queen([0, 1, 2, 3, 4, 5, 6,
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.binaryTree_from_top_bottom1350
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
class Solution:
    # 返回从上到下每个节点值列表，例：[1,2,3]
    def PrintFromTopToBottom(self, root):
        queue = []
        if not root:
            return []

        result = []
        queue.append(root)
        while len(queue) > 0:
            currentRoot = queue.pop(0)
            result.append(currentRoot.val)
            if currentRoot.left:
                queue.append(currentRoot.left)
            if currentRoot.right:
                queue.append(currentRoot.right)
        return result

pNode1 = TreeNode(8)
pNode2 = TreeNode(6)
pNode3 = TreeNode(10)
pNode4 = TreeNode(5)
pNode5 = TreeNode(7)
pNode6 = TreeNode(9)
pNode7 = TreeNode(11)

pNode1.left = pNode2
pNode1.right = pNode3
pNode2.left = pNode4
pNode2.right = pNode5
pNode3.left = pNode6
pNode3.right = pNode7

S = Solution()
print(S.PrintFromTopToBottom(pNode1))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.number_1s_binary1351
    set output_file "main.py"

    set template_content '
class Solution:
    def NumberOf1(self, n):
        count = 0
        if n < 0:
            n = n & 0xffffffff
        while n:
            count += 1
            n = (n-1)&n
        return count

    def NumberOf2(self, n):
        if n < 0:
            s = bin(n & 0xffffffff)
        else:
            s = bin(n)
        return s.count('1')

    # 判断一个数是不是2得整数次幂
    def powerOf2(self, n):
        if n&(n-1) == 0:
            return True
        else:
            return False
    # 判断两个数的二进制表示有多少位不一样, 直接比较两个数的二进制异或就可以
    def andOr(self, m, n):
        diff = m^n
        count = 0
        while diff:
            count += 1
            diff = diff&(diff-1)
        return count

S = Solution()
print(S.NumberOf1(-1))
print(S.NumberOf2(-1))
print(S.powerOf2(64))
print(S.powerOf2(63))
print(S.andOr(10, 13))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Two-dimensionalArraySearch1352
    set output_file "main.py"

    set template_content '
class Solution:
    # array 二维列表
    def Find(self, array, target):
        # 判断数组是否为空
        if array == []:
            return False

        rawnum = len(array)
        colnum = len(array[0])

        # 判断非法输入
        # 可以换成 isinstance(target, (int, float)) 进行判断
        if type(target) == float and type(array[0][0]) == int:
            if int(target) == target:
                return False
            target = int(target)
        elif type(target) == int and type(array[0][0]) == float:
            target = float(int)
        elif type(target) != type(array[0][0]):     # 浮点数的相等判断问题需要特别注意, 一般都是判断两个数的差值是否小于一个特别小的数。这里不展开分析。
            return False

        i = colnum - 1
        j = 0
        while i >= 0 and j < rawnum:
            if array[j][i] < target:
                j += 1
            elif array[j][i] > target:
                i -= 1
            else:
                return True
        return False
    # 扩展, 输出数组中target的个数
    def searchMatrix(self, matrix, target):
        if matrix == None or len(matrix) == 0:
            return 0
        rows = len(matrix)
        cols = len(matrix[0])
        row, col = 0, cols - 1
        count = 0
        while row <= rows - 1 and col >= 0:
            if matrix[row][col] > target:
                col -= 1
            elif matrix[row][col] < target:
                row += 1
            else:
                count += 1
                col -= 1
        return count


array = [[1, 2, 8, 9],
         [2, 4, 9, 12],
         [4, 7, 10, 13],
         [6, 8, 11, 15]]
array2 = []
array3 = [['a', 'b', 'c'],
          ['b', 'c', 'd']]
array4 = [[62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80],[63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81],[64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82],[65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83],[66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84],[67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85]]


findtarget = Solution()
print(findtarget.Find(array, 10))
print(findtarget.Find(array, 30))
print(findtarget.Find(array, 13.0))
print(findtarget.Find(array, ''))
print(findtarget.Find(array2, 10))
print(findtarget.Find(array3, 'b'))
print(findtarget.searchMatrix(array4, 81))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinaryTreeMirror1353
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
class Solution:
    # 递归实现
    def Mirror(self, root):
        if root == None:
            return
        if root.left == None and root.right == None:
            return root

        pTemp = root.left
        root.left = root.right
        root.right = pTemp

        self.Mirror(root.left)
        self.Mirror(root.right)

    # 非递归实现
    def Mirror2(self, root):
        if root == None:
            return
        stackNode = []
        stackNode.append(root)
        while len(stackNode) > 0:
            nodeNum = len(stackNode) - 1
            tree = stackNode[nodeNum]
            stackNode.pop()
            nodeNum -= 1
            if tree.left != None or tree.right != None:
                tree.left, tree.right = tree.right, tree.left
            if tree.left:
                stackNode.append(tree.left)
                nodeNum += 1
            if tree.right:
                stackNode.append(tree.right)
                nodeNum += 1
    # 非递归实现
    def MirrorNoRecursion(self, root):
        if root == None:
            return
        nodeQue = [root]
        while len(nodeQue) > 0:
            curLevel, count = len(nodeQue), 0
            while count < curLevel:
                count += 1
                pRoot = nodeQue.pop(0)
                pRoot.left, pRoot.right = pRoot.right, pRoot.left
                if pRoot.left:
                    nodeQue.append(pRoot.left)
                if pRoot.right:
                    nodeQue.append(pRoot.right)

pNode1 = TreeNode(8)
pNode2 = TreeNode(6)
pNode3 = TreeNode(10)
pNode4 = TreeNode(5)
pNode5 = TreeNode(7)
pNode6 = TreeNode(9)
pNode7 = TreeNode(11)

pNode1.left = pNode2
pNode1.right = pNode3
pNode2.left = pNode4
pNode2.right = pNode5
pNode3.left = pNode6
pNode3.right = pNode7

S = Solution()
S.Mirror2(pNode1)
print(pNode1.right.left.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinaryTreeDepth1354
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
class Solution:
    # 递归解法, 简单直接, 时间复杂度O(n), 空间复杂度O(logn)
    def TreeDepth(self, pRoot):
        if pRoot == None:
            return 0
        else:
            return max(self.TreeDepth(pRoot.left), self.TreeDepth(pRoot.right)) + 1
    # 非递归算法，利用一个栈以及一个标志位栈
    def TreeDepth2(self, pRoot):
        if not pRoot:
            return 0
        depth = 0
        stack, tag = [], []
        pNode = pRoot
        while pNode or stack:
            while pNode:
                stack.append(pNode)
                tag.append(0)
                pNode = pNode.left
            if tag[-1] == 1:
                depth = max(depth, len(stack))
                stack.pop()
                tag.pop()
                pNode = None
            else:
                pNode = stack[-1]
                pNode = pNode.right
                tag.pop()
                tag.append(1)
        return depth
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LowestCommonAncestorBinaryTrees1355
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, val):
        self.val = val
        self.left, self.right = None, None
class Solution:
    """
    @param root: The root of the binary search tree.
    @param A and B: two nodes in a Binary.
    @return: Return the least common ancestor(LCA) of the two nodes.
    """

    def lowestCommonAncestor(self, root, A, B):
        # write your code here
        if root == None:
            return False
        pathA = self.storeNodes(root, A)[0]
        pathB = self.storeNodes(root, B)[0]
        if pathA and pathB:
            lenA, lenB = len(pathA), len(pathB)
            diff = abs(lenA - lenB)
            if lenA > lenB:
                markA = lenA - diff - 1
                markB = lenB - 1
            else:
                markA = lenA - 1
                markB = lenB - diff - 1
            while markA >= 0 and markB >= 0:
                if pathA[markA] == pathB[markB]:
                    return pathA[markA]
                markA -= 1
                markB -= 1

    def storeNodes(self, root, targetNode):
        if root == None or targetNode == None:
            return []
        elif root.val == targetNode.val:
            return [[targetNode]]
        stack = []
        if root.left:
            stackLeft = self.storeNodes(root.left, targetNode)
            for i in stackLeft:
                i.insert(0, root)
                stack.append(i)
        if root.right:
            stackRight = self.storeNodes(root.right, targetNode)
            for i in stackRight:
                i.insert(0, root)
                stack.append(i)
        return stack
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NextNodeBinaryTree1356
    set output_file "main.py"

    set template_content '
class TreeLinkNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
        self.next = None
class Solution:
    def GetNext(self, pNode):
        if pNode == None:
            return
        pNext = None
        if pNode.right != None:
            pRight = pNode.right
            while pRight.left != None:
                pRight = pRight.left
            pNext= pRight
        elif pNode.next != None:
            pCurrent = pNode
            pParent = pCurrent.next
            while pParent != None and pCurrent == pParent.right:
                pCurrent = pParent
                pParent = pCurrent.next
            pNext = pParent
        return pNext

class Solution2:
    def GetNext(self, pNode):
        # 输入是一个空节点
        if pNode == None:
            return None
        # 注意当前节点是根节点的情况。所以在最开始设定pNext = None, 如果下列情况都不满足, 说明当前结点为根节点, 直接输出None
        pNext = None
        # 如果输入节点有右子树，则下一个结点是当前节点右子树中最左节点
        if pNode.right:
            pNode = pNode.right
            while pNode.left:
                pNode = pNode.left
            pNext = pNode
        else:
            # 如果当前节点有父节点且当前节点是父节点的左子节点, 下一个结点即为父节点
            if pNode.next and pNode.next.left == pNode:
                pNext = pNode.next
            # 如果当前节点有父节点且当前节点是父节点的右子节点, 那么向上遍历
            # 当遍历到当前节点为父节点的左子节点时, 输入节点的下一个结点为当前节点的父节点
            elif pNode.next and pNode.next.right == pNode:
                pNode = pNode.next
                while pNode.next and pNode.next.right == pNode:
                    pNode = pNode.next
                # 遍历终止时当前节点有父节点, 说明当前节点是父节点的左子节点, 输入节点的下一个结点为当前节点的父节点
                # 反之终止时当前节点没有父节点, 说明当前节点在位于根节点的右子树, 没有下一个结点
                if pNode.next:
                    pNext = pNode.next
        return pNext
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PathsBinaryTree1357
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
class Solution:
    # 返回二维列表，内部每个列表表示找到的路径
    def FindPath(self, root, sum):
        if not root:
            return []
        if root.left == None and root.right == None:
            if sum == root.val:
                return [[root.val]]
            else:
                return []
        stack = []
        leftStack = self.pathSum(root.left, sum - root.val)
        for i in leftStack:
            i.insert(0, root.val)
            stack.append(i)
        rightStack = self.pathSum(root.right, sum - root.val)
        for i in rightStack:
            i.insert(0, root.val)
            stack.append(i)
        return stack

    # 优化写法
    def pathSum(self, root, sum):
        if not root: return []
        if root.left == None and root.right == None:
            if sum == root.val:
                return [[root.val]]
            else:
                return []
        a = self.pathSum(root.left, sum - root.val) + self.pathSum(root.right, sum - root.val)
        return [[root.val] + i for i in a]

pNode1 = TreeNode(10)
pNode2 = TreeNode(5)
pNode3 = TreeNode(12)
pNode4 = TreeNode(4)
pNode5 = TreeNode(7)


pNode1.left = pNode2
pNode1.right = pNode3
pNode2.left = pNode4
pNode2.right = pNode5


S = Solution()
print(S.FindPath(pNode1, 22))
# 测试用例：[1,-2,-3,1,3,-2,null,-1]  -1
# 测试用例：[-2, None, -3] -5
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KNodeBinarySearch1358
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
class Solution:
    # 返回对应节点TreeNode
    def __init__(self):
        self.treeNode = []
    def inOrder(self, pRoot):
        if len(self.treeNode) < 0:
            return None
        if pRoot.left:
            self.inOrder(pRoot.left)
        self.treeNode.append(pRoot)
        if pRoot.right:
            self.inOrder(pRoot.right)
    def KthNode(self, pRoot, k):
        if k == 0 or pRoot == None:
            return
        self.inOrder(pRoot)
        if len(self.treeNode) < k:
            return None
        return self.treeNode[k-1]

    def KthNode2(self, pRoot, k):
        if k <= 0 or not pRoot:
            return None
        treeStack, nodesQue = [], []
        pNode = pRoot
        while pNode or len(treeStack):
            while pNode:
                treeStack.append(pNode)
                pNode = pNode.left
            if len(treeStack):
                pNode = treeStack.pop()
                nodesQue.append(pNode)
                pNode = pNode.right
        if k > len(nodesQue):
            return None
        return nodesQue[k-1]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LowestCommonAncestorBinarySearchTrees1359
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
class Solution:
    def findParent(self, pNode1, pNode2, root):
        if pNode1 == None or pNode2 == None:
            return
        if pNode1 == pNode2:
            return
        val1 = pNode1.val
        val2 = pNode2.val
        while root != None:
            if (val1 - root.val) * (val2 - root.val) <= 0:
                return root.val
            elif val1 > root.val and val2 > root.val:
                root = root.right
            else:
                root = root.left

        return False

pNode1 = TreeNode(8)
pNode2 = TreeNode(6)
pNode3 = TreeNode(10)
pNode4 = TreeNode(5)
pNode5 = TreeNode(7)
pNode6 = TreeNode(9)
pNode7 = TreeNode(11)

pNode1.left = pNode2
pNode1.right = pNode3
pNode2.left = pNode4
pNode2.right = pNode5
pNode3.left = pNode6
pNode3.right = pNode7

S = Solution()
print(S.findParent(pNode3, pNode7, pNode1))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinarySearchTreedDoublyLinkedList1360
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
class Solution:
    def Convert(self, pRootOfTree):
        if pRootOfTree == None:
            return None
        if not pRootOfTree.left and not pRootOfTree.right:
            return pRootOfTree

        # 处理左子树
        self.Convert(pRootOfTree.left)
        left = pRootOfTree.left

        # 连接根与左子树最大结点
        if left:
            while left.right:
                left = left.right
            pRootOfTree.left, left.right = left, pRootOfTree

        # 处理右子树
        self.Convert(pRootOfTree.right)
        right = pRootOfTree.right

        # 连接根与右子树最小结点
        if right:
            while right.left:
                right = right.left
            pRootOfTree.right, right.left = right, pRootOfTree

        while pRootOfTree.left:
            pRootOfTree = pRootOfTree.left

        return pRootOfTree

pNode1 = TreeNode(8)
pNode2 = TreeNode(6)
pNode3 = TreeNode(10)
pNode4 = TreeNode(5)
pNode5 = TreeNode(7)
pNode6 = TreeNode(9)
pNode7 = TreeNode(11)

pNode1.left = pNode2
pNode1.right = pNode3
pNode2.left = pNode4
pNode2.right = pNode5
pNode3.left = pNode6
pNode3.right = pNode7

S = Solution()
newList = S.Convert(pNode1)
print(newList.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FirstCommonNodeTwoLinkedLists1361
    set output_file "main.py"

    set template_content '
class ListNode:
    def __init__(self, x):
        self.val = x
        self.next = None
class Solution:
    def FindFirstCommonNode(self, pHead1, pHead2):
        nLength1 = self.GetListLength(pHead1)
        nLength2 = self.GetListLength(pHead2)
        nLengthDiff = abs(nLength1 - nLength2)

        if nLength1 > nLength2:
            pListHeadLong = pHead1
            pListHeadShort = pHead2
        else:
            pListHeadLong = pHead2
            pListHeadShort = pHead1

        for i in range(nLengthDiff):
            pListHeadLong = pListHeadLong.next

        while pListHeadLong != None and pListHeadShort != None and pListHeadLong != pListHeadShort:
            pListHeadLong = pListHeadLong.next
            pListHeadShort = pListHeadShort.next

        pFirstCommonNode = pListHeadLong
        return pFirstCommonNode

    def GetListLength(self, pHead):
        nLength = 0
        while pHead != None:
            pHead = pHead.next
            nLength += 1
        return nLength
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.UglyNumbers1362
    set output_file "main.py"

    set template_content '
class Solution:
    def GetUglyNumber_Solution(self, index):
        if index == None and len(index) <= 0:
            return 0

        uglyNumbers = [1]*index
        nextIndex = 1

        index2 = 0
        index3 = 0
        index5 = 0

        while nextIndex < index:
            minVal = min(uglyNumbers[index2]*2, uglyNumbers[index3]*3, uglyNumbers[index5]*5)
            uglyNumbers[nextIndex] = minVal

            while uglyNumbers[index2]*2 <= uglyNumbers[nextIndex]:
                index2 += 1
            while uglyNumbers[index3]*3 <= uglyNumbers[nextIndex]:
                index3 += 1
            while uglyNumbers[index5]*5 <= uglyNumbers[nextIndex]:
                index5 += 1
            nextIndex += 1

        return uglyNumbers[-1]


s = Solution()
print(s.GetUglyNumber_Solution(11))

# def getUglyNumber(index):
#     if index <= 0:
#         return 0
#
#     uglyNumbers = [1] * index
#     nextUglyIndex = 1
#
#     index2 = 0
#     index3 = 0
#     index5 = 0
#     multiply2 = uglyNumbers[index2]
#     multiply3 = uglyNumbers[index3]
#     multiply5 = uglyNumbers[index5]
#
#     while nextUglyIndex < index:
#         minVal = min(multiply2 * 2, multiply3 * 3, multiply5 * 5)
#         uglyNumbers[nextUglyIndex] = minVal
#
#         while multiply2 * 2 <= uglyNumbers[nextUglyIndex]:
#             index2 += 1
#             multiply2 = uglyNumbers[index2]
#         while multiply3 * 3 <= uglyNumbers[nextUglyIndex]:
#             index3 += 1
#             multiply3 = uglyNumbers[index3]
#         while multiply5 * 5 <= uglyNumbers[nextUglyIndex]:
#             index5 += 1
#             multiply5 = uglyNumbers[index5]
#
#         nextUglyIndex += 1
#     return uglyNumbers[-1]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.AdditionWithoutUsingAddition1363
    set output_file "main.py"

    set template_content '
# class Solution:
#     def Add(self, num1, num2):
#         while num2:
#             sum = num1 ^ num2
#             carry = (num1 & num2) << 1
#             num1 = sum
#             num2 = carry
#         return num1
# s = Solution()
# print(s.Add(4, 2))
# -*- coding:utf-8 -*-
# 通过每次对num1进行与操作保证是一个32位的整形
# 因此最后我们可以判断符号位是否为1做处理
class Solution:
    def Add(self, num1, num2):
        # write code here
        while num2 != 0:
            temp = num1 ^ num2
            num2 = (num1 & num2) << 1
            num1 = temp & 0xFFFFFFFF
        return num1 if num1 >> 31 == 0 else num1 - 4294967296
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.transSparseMatrix1364
    set output_file "main.py"

    set template_content '
from numpy import *
def sparseToTriple(matrix):
    m, n = shape(matrix)
    triple = []
    for i in range(m):
        for j in range(n):
            if matrix[i][j] != 0:
                triple.append([i, j, matrix[i][j]])
    return triple

def transTriple(triple):
    m, n = shape(triple)
    transMatrix = []
    sortedIndex = array([m[1] for m in triple]).argsort()
    for i in range(m):
        tempArray = triple[sortedIndex[i]]
        transMatrix.append([tempArray[1], tempArray[0], tempArray[2]])
    return transMatrix

def tripleToSparse(triple, m, n):
    outMatrix = zeros([n, m])
    for pointTuple in triple:
        mLocation = pointTuple[0]
        nLocation = pointTuple[1]
        value = pointTuple[2]
        outMatrix[mLocation][nLocation] = value
    return outMatrix

def matrixTrans(matrix):
    m, n = shape(matrix)
    triple = sparseToTriple(matrix)
    transedTriple = transTriple(triple)
    transedMatrix = tripleToSparse(transedTriple, m, n)
    return transedMatrix

matrix = [[0, 0, 0, 0, 0, 0, 6, 0, 0],
          [0, 0, 2, 0, 0, 1, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0],
          [3, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 5, 0],
          [0, 7, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 8],
          [0, 0, 5, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 2, 0, 0, 0, 0, 0]]

transedMatrix = matrixTrans(matrix)
print(transedMatrix)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.numbers_on_n_dice1365
    set output_file "main.py"

    set template_content '
def PrintProbability(number):
    if number < 1:
        return
    maxVal = 6
    # 构造两个数组来存储骰子点数的每一个总数出现的次数
    # 在一次循环中, 第一个数组中的第n个数字表示骰子和为n出现的次数
    # 在下次循环中, 另一个数组的第n个数字设为前一个数组对应的第n-1、n-2、n-3、n-4、n-5、n-6之和
    probStorage = [[], []]
    probStorage[0] = [0]*(maxVal * number + 1)
    flag = 0
    for i in range(1, maxVal+1):
        probStorage[flag][i] = 1
    for time in range(2, number+1):
        probStorage[1-flag] = [0]*(maxVal * number + 1)
        for pCur in range(time, maxVal*time+1):
            diceNum = 1
            while diceNum < pCur and diceNum <= maxVal:
                probStorage[1-flag][pCur] += probStorage[flag][pCur-diceNum]
                diceNum += 1
        flag = 1 - flag
    total = maxVal ** number
    for i in range(number, maxVal*number+1):
        ratio = probStorage[flag][i] / float(total)
        print("{}: {:e}".format(i, ratio))
s = PrintProbability(5)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Singelton1366
    set output_file "main.py"

    set template_content '

#方法1:
class Singleton1(object):
    def __new__(cls, *args, **kwargs):
        if not hasattr(cls, '_instance'):
            orig = super(Singleton1, cls)
            cls._instance = orig.__new__(cls, *args, **kwargs)
        return cls._instance

class Myclass(Singleton1):
    a = 1

one = Myclass()
two = Myclass()

# one和two完全相同, 可以用id(), ==, is检测
print(id(one))
print(id(two))
print(one == two)       # True
print(one is two)       # True

two.a = 3
print(one.a)    # 3


#方法2
class Borg(object):
    _state = {}
    def __new__(cls, *args, **kwargs):
        ob = super(Borg, cls).__new__(cls, *args, **kwargs)
        ob.__dict__ = cls._state
        return ob
class MyClass2(Borg):
    a = 1
one = MyClass2()
two = MyClass2()
two.a = 3
print(one.a)
# one 和 two 是两个不同的对象，id，==，is对比结果可以看出
print(id(one))          # 18410480
print(id(two))          # 18410512
print(one == two)       # False
print(one is two)       # False
# 但是one和two具有相同的（同一个）__dict__属性
print(id(one.__dict__)) # 14194768
print(id(two.__dict__)) # 14194768


#方法3
def singleton(cls, *args, **kwargs):
    instances = {}
    def getinstance():
        if cls not in instances:
            instances[cls] = cls(*args, **kwargs)
        return instances[cls]
    return getinstance
@singleton
class MyClass3(object):
    a = 1
    def __init__(self, x = 0):
        self.x = x

one = MyClass3()
two = MyClass3()
two.a = 3
print(one.a)            # 3
print(id(one))          # 8842576
print(id(two))          # 8842576
print(one == two)       # True
print(one is two)       # True
one.x = 1
print(one.x)            # 1
print(two.x)            # 1


#方法4
# mysingleton.py
# class My_Singleton(object):
#     def foo(self):
#         pass
# my_singleton = My_Singleton()

# to use
from mysingleton import my_singleton
my_singleton.foo()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MatrixMultiSpasse1367
    set output_file "main.py"

    set template_content '
from numpy import *
def sparseToTriple(matrix):
    m, n = shape(matrix)
    triple = []
    for i in range(m):
        for j in range(n):
            if matrix[i][j] != 0:
                triple.append([i, j, matrix[i][j]])
    return triple

def multiTriple(tripleA, tripleB):
    rowA = shape(tripleA)[0]
    rowB = shape(tripleB)[0]
    multiMatrix = []
    for i in range(rowA):
        for j in range(rowB):
            if tripleA[i][1] == tripleB[j][0]:
                multiMatrix.append([tripleA[i][0], tripleB[j][1], tripleA[i][2]*tripleB[j][2]])
    return multiMatrix

def tripleToSparse(triple, m, n):
    outMatrix = zeros([m, n])
    for pointTuple in triple:
        mLocation = pointTuple[0]
        nLocation = pointTuple[1]
        value = pointTuple[2]
        outMatrix[mLocation][nLocation] = value
    return outMatrix

def matrixMultiple(matrixA, matrixB):
    mA, nA = shape(matrixA)
    mB, nB = shape(matrixB)
    if nA != mB:
        print("the two matries doesnt match!")
        return -1

    tripleA = sparseToTriple(matrixA)
    tripleB = sparseToTriple(matrixB)
    multiTriples = multiTriple(tripleA, tripleB)
    print(multiTriples)
    multiMatrix = tripleToSparse(multiTriples, mA, nB)
    return multiMatrix

matrixA = [[3, 0, 0, 7],
           [0, 0, -1, 0],
           [-1, -2, 0, 0],
           [0, 0, 0, 2]]
matrixB = [[0, 0, -2, 0, -1],
           [0, 0, -3, 0, 0],
           [-1, 0, 0, 0, 0],
           [0, 0, 0, 3, 0]]
ans = matrixMultiple(matrixA, matrixB)
print(ans)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.AVL1368
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, key, val, left = None, right = None, parent = None):
        self.key = key
        self.payload = val
        self.leftChild = left
        self.rightChild = right
        self.parent= parent

    def hasLeftChild(self):
        return self.leftChild

    def hasRightChild(self):
        return self.rightChild

    def isLeftChild(self):
        return self.parent and self.parent.leftChild == self

    def isRightChild(self):
        return self.parent and self.parent.rightChild == self

    def isRoot(self):
        return not self.parent

    def isLeaf(self):
        return not (self.rightChild or self.leftChild)

    def hasAnyChildren(self):
        return self.rightChild or self.leftChild

    def hasBothChildren(self):
        return self.rightChild and self.leftChild

    def replaceNodeData(self, key, value, lc, rc):
        self.key = key
        self.payload = value
        self.leftChild = lc
        self.rightChild = rc
        if self.hasLeftChild():
            self.leftChild.parent = self
        if self.hasRightChild():
            self.rightChild.parent = self

class BinarySearchTree:
    def __init__(self):
        self.root = None
        self.size = 0

    def length(self):
        return self.size

    def __len__(self):
        return self.size

    def __iter__(self):
        return self.root.__iter__()

    def put(self, key, val):
        if self.root:
            self._put(key, val, self.root)
        else:
            self.root = TreeNode(key, val)
        self.size = self.size + 1

    def _put(self, key, val, currentNode):
        if key < currentNode.key:
            if currentNode.hasLeftChild():
                self._put(key, val, currentNode.leftChild)
            else:
                currentNode.leftChild = TreeNode(key, val, parent=currentNode)
                self.updateBalance(currentNode.leftChild)
        else:
            if currentNode.hasRightChild():
                self._put(key, val, currentNode.rightChild)
            else:
                currentNode.rightChild = TreeNode(key, val, parent=currentNode)
                self.updateBalance(currentNode.rightChild)

    def updateBalance(self, node):
        if node.balanceFactor > 1 or node.balanceFactor < -1:
            self.rebalance(node)
            return
        if node.parent != None:
            if node.isLeftChild():
                node.parent.balanceFactor += 1
            elif node.isRightChild():
                node.parent.balanceFactor -= 1

            if node.parent.balanceFactor != 0:
                self.updateBalance(node.parent)

    def rotateLeft(self, rotRoot):
        newRoot = rotRoot.rightChild
        rotRoot.rightChild = newRoot.leftChild
        if newRoot.leftChild != None:
            newRoot.leftChild.parent = rotRoot
        newRoot.parent = rotRoot.parent
        if rotRoot.isRoot():
            self.root = newRoot
        else:
            if rotRoot.isLeftChild():
                rotRoot.parent.leftChild = newRoot
            else:
                rotRoot.parent.rightChild = newRoot
        newRoot.leftChild = rotRoot
        rotRoot.parent = newRoot
        rotRoot.balanceFactor = rotRoot.balanceFactor + 1 - min(newRoot.balanceFactor, 0)
        newRoot.balanceFactor = newRoot.balanceFactor + 1 + max(rotRoot.balanceFactor, 0)

    def rotateRight(self, rotRoot):
        newRoot = rotRoot.leftChild
        rotRoot.leftChild = newRoot.rightChild
        if newRoot.rightChild != None:
            newRoot.rightChild.parent = rotRoot
        newRoot.parent = rotRoot.parent
        if rotRoot.isRoot():
            self.root = newRoot
        else:
            if rotRoot.isRightChild():
                rotRoot.parent.rightChild = newRoot
            else:
                rotRoot.parent.rightChild = newRoot
        newRoot.rightChild = rotRoot
        rotRoot.parent = newRoot
        rotRoot.balanceFactor = rotRoot.balanceFactor + 1 - min(newRoot.balanceFactor, 0)
        newRoot.balanceFactor = newRoot.balanceFactor + 1 + max(rotRoot.balanceFactor, 0)

    def rebalance(self, node):
        if node.balanceFactor < 0:
            if node.rightChild.balanceFactor > 0:
                self.rotateRight(node.rightChild)
                self.rotateLeft(node)
            else:
                self.rotateLeft(node)
        elif node.balanceFactor > 0:
            if node.leftChild.balanceFactor < 0:
                self.rotateLeft(node.leftChild)
                self.rotateRight(node)
            else:
                self.rotateRight(node)

    def __setitem__(self, k, v):
        self.put(k, v)

    def get(self, key):
        if self.root:
            res = self._get(key, self.root)
            if res:
                return res.payload
            else:
                return None
        else:
            return None

    def _get(self, key, currentNode):
        if not currentNode:
            return None
        elif currentNode.key == key:
            return currentNode
        elif key < currentNode.key:
            return self._get(key, currentNode.leftChild)
        else:
            return self._get(key, currentNode.rightChild)

    def __getitem__(self, key):
        return self.get(key)

    def __contains__(self, key):
        if self._get(key, self.root):
            return True
        else:
            return False

    def delete(self, key):
        if self.size > 1:
            nodeToRemove = self._get(key, self.root)
            if nodeToRemove:
                self.remove(nodeToRemove)
                self.size -= 1
            else:
                raise KeyError('Error, key not in tree')
        elif self.size == 1 and self.root.key == key:
            self.root = None
            self.size = self.size - 1
        else:
            raise KeyError('Error, key not in tree')

    def __delitem__(self, key):
        self.delete(key)

    def spliceOut(self):
        if self.isLeaf():
            if self.isLeftChild():
                self.parent.leftChild = None
            else:
                self.parent.rightChild = None
        elif self.hasAnyChildren():
            if self.hasLeftChild():
                if self.isLeftChild():
                    self.parent.leftChild = self.leftChild
                else:
                    self.parent.rightChild = self.leftChild
                self.leftChild.parent = self.parent
            else:
                if self.isLeftChild():
                    self.parent.leftChild = self.rightChild
                else:
                    self.parent.rightChild = self.rightChild
                self.rightChild.parent = self.parent

    def findSuccessor(self):
        succ = None
        if self.hasRightChild():
            succ = self.rightChild.findMin()
        else:
            if self.parent:
                if self.isLeftChild():
                    succ = self.parent
                else:
                    self.parent.rightChild = None
                    succ = self.parent.findSuccessor()
                    self.parent.rightChild = self
        return succ

    def findMin(self):
        current = self
        while current.hasLeftChild():
            current = current.leftChild
        return current

    def remove(self, currentNode):
        if currentNode.isLeaf():  # leaf
            if currentNode == currentNode.parent.leftChild:
                currentNode.parent.leftChild = None
            else:
                currentNode.parent.rightChild = None
        elif currentNode.hasBothChildren():  # interior
            succ = currentNode.findSuccessor()
            succ.spliceOut()
            currentNode.key = succ.key
            currentNode.payload = succ.payload

        else:  # this node has one child
            if currentNode.hasLeftChild():
                if currentNode.isLeftChild():
                    currentNode.leftChild.parent = currentNode.parent
                    currentNode.parent.leftChild = currentNode.leftChild
                elif currentNode.isRightChild():
                    currentNode.leftChild.parent = currentNode.parent
                    currentNode.parent.rightChild = currentNode.leftChild
                else:
                    currentNode.replaceNodeData(currentNode.leftChild.key,
                                                currentNode.leftChild.payload,
                                                currentNode.leftChild.leftChild,
                                                currentNode.leftChild.rightChild)
            else:
                if currentNode.isLeftChild():
                    currentNode.rightChild.parent = currentNode.parent
                    currentNode.parent.leftChild = currentNode.rightChild
                elif currentNode.isRightChild():
                    currentNode.rightChild.parent = currentNode.parent
                    currentNode.parent.rightChild = currentNode.rightChild
                else:
                    currentNode.replaceNodeData(currentNode.rightChild.key,
                                                currentNode.rightChild.payload,
                                                currentNode.rightChild.leftChild,
                                                currentNode.rightChild.rightChild)



mytree = BinarySearchTree()
mytree[3]="red"
mytree[4]="blue"
mytree[6]="yellow"
mytree[2]="at"

print(mytree[6])
print(mytree[2])
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.AnagramDetection1369
    set output_file "main.py"

    set template_content '
class AnagramDetection:
    # 先对两个字符串进行list化
    # 对字符串对应的两个list进行排序
    # 依次比较字符是否匹配
    def anagramSolution1(self, s1, s2):
        alist1 = list(s1)
        alist2 = list(s2)

        alist1.sort()
        alist2.sort()

        pos = 0
        matches = True

        while pos < len(s1) and matches:
            if alist1[pos] == alist2[pos]:
                pos = pos + 1
            else:
                matches = False

        return matches

    # 首先生成两个26个字母的list
    # 计算每个字母出现的次数并存入到相应的list中
    # 比较两个list是否相同
    def anagramSolution2(self, s1, s2):
        c1 = [0] * 26
        c2 = [0] * 26

        for i in range(len(s1)):
            pos = ord(s1[i]) - ord('a')
            c1[pos] = c1[pos] + 1

        for i in range(len(s2)):
            pos = ord(s2[i]) - ord('a')
            c2[pos] = c2[pos] + 1

        j = 0
        stillOK = True
        while j < 26 and stillOK:
            if c1[j] == c2[j]:
                j = j + 1
            else:
                stillOK = False

        return stillOK

    # 首先将两个字符串list化
    # 将两个list中的字符生成两个set
    # 比较两个set, 如果不相等直接返回false
    # 如果两个set相等, 比较每个set中字符在相应list中的个数, 个数不同返回false
    def anagramSolution3(self, s1, s2):
        alist1 = list(s1)
        alist2 = list(s2)

        aset1 = set(alist1)
        aset2 = set(alist2)

        if aset1 != aset2:
            return False
        else:
            for ch in aset1:
                if alist1.count(ch) != alist2.count(ch):
                    return False
            return True

s1 = 'abcde'
s2 = 'acbde'
test = AnagramDetection()
print(test.anagramSolution1(s1, s2))
print(test.anagramSolution2(s1, s2))
print(test.anagramSolution3(s1, s2))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinaryHeap1370
    set output_file "main.py"

    set template_content '
class BinHeap:
    def __init__(self):
        self.heapList = [0]
        self.currentSize = 0

    #插入新结点后必要时交换子节点和父节点的位置保持堆的性质
    def percUp(self, i):
        while i//2 > 0:
            if self.heapList[i] < self.heapList[i//2]:
                temp = self.heapList[i//2]
                self.heapList[i//2] = self.heapList[i]
                self.heapList[i] = temp
            i = i//2

    # 插入节点
    def insert(self, k):
        self.heapList.append(k)
        self.currentSize += 1
        self.percUp(self.currentSize)

    # 删除堆顶元素后, 交换堆尾和空堆顶的位置并实现元素的下沉
    def percDown(self, i):
        while (i*2) <= self.currentSize:
            mc = self.minChild(i)
            if self.heapList[i] > self.heapList[mc]:
                temp = self.heapList[i]
                self.heapList[i] = self.heapList[mc]
                self.heapList[mc] = temp
            i = mc

    def minChild(self, i):
        if i * 2 + 1 > self.currentSize:
            return i * 2
        else:
            if self.heapList[i*2] < self.heapList[i*2+1]:
                return i * 2
            else:
                return i * 2 + 1

    def delMin(self):
        retval = self.heapList[1]
        self.heapList[1] = self.heapList[self.currentSize]
        self.currentSize = self.currentSize - 1
        self.heapList.pop()
        self.percDown(1)
        return retval

    def buildHeap(self, alist):
        i = len(alist) // 2
        self.currentSize = len(alist)
        self.heapList = [0] + alist[:]
        while (i > 0):
            self.percDown(i)
            i = i - 1
        return self.heapList

H = BinHeap()
print(H.buildHeap([9, 6, 5, 2, 3]))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinarySearch1371
    set output_file "main.py"

    set template_content '
def binarySearch(alist, item):
    first = 0
    last = len(alist) - 1

    while first <= last:
        mid = (first + last)//2
        print(mid)
        if alist[mid] > item:
            last = mid - 1
        elif alist[mid] < item:
            first = mid + 1
        else:
            return mid+1
    return -1

test = [0, 1, 2, 8, 13, 17, 19, 32, 42]
print(binarySearch(test, 3))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinarySearchTreeNew1372
    set output_file "main.py"

    set template_content '
class TreeNode:
    def __init__(self, key, val, left = None, right = None, parent = None):
        self.key = key
        self.payload = val
        self.leftChild = left
        self.rightChild = right
        self.parent= parent

    def hasLeftChild(self):
        return self.leftChild

    def hasRightChild(self):
        return self.rightChild

    def isLeftChild(self):
        return self.parent and self.parent.leftChild == self

    def isRightChild(self):
        return self.parent and self.parent.rightChild == self

    def isRoot(self):
        return not self.parent

    def isLeaf(self):
        return not (self.rightChild or self.leftChild)

    def hasAnyChildren(self):
        return self.rightChild or self.leftChild

    def hasBothChildren(self):
        return self.rightChild and self.leftChild

    def replaceNodeData(self, key, value, lc, rc):
        self.key = key
        self.payload = value
        self.leftChild = lc
        self.rightChild = rc
        if self.hasLeftChild():
            self.leftChild.parent = self
        if self.hasRightChild():
            self.rightChild.parent = self

class BinarySearchTree:
    def __init__(self):
        self.root = None
        self.size = 0

    def length(self):
        return self.size

    def __len__(self):
        return self.size

    def __iter__(self):
        return self.root.__iter__()

    def put(self, key, val):
        if self.root:
            self._put(key, val, self.root)
        else:
            self.root = TreeNode(key, val)
        self.size = self.size + 1

    def _put(self, key, val, currentNode):
        if key < currentNode.key:
            if currentNode.hasLeftChild():
                self._put(key, val, currentNode.leftChild)
            else:
                currentNode.leftChild = TreeNode(key, val, parent=currentNode)
        else:
            if currentNode.hasRightChild():
                self._put(key, val, currentNode.rightChild)
            else:
                currentNode.rightChild = TreeNode(key, val, parent=currentNode)

    def __setitem__(self, k, v):
        self.put(k, v)

    def get(self, key):
        if self.root:
            res = self._get(key, self.root)
            if res:
                return res.payload
            else:
                return None
        else:
            return None

    def _get(self, key, currentNode):
        if not currentNode:
            return None
        elif currentNode.key == key:
            return currentNode
        elif key < currentNode.key:
            return self._get(key, currentNode.leftChild)
        else:
            return self._get(key, currentNode.rightChild)

    def __getitem__(self, key):
        return self.get(key)

    def __contains__(self, key):
        if self._get(key, self.root):
            return True
        else:
            return False

    def delete(self, key):
        if self.size > 1:
            nodeToRemove = self._get(key, self.root)
            if nodeToRemove:
                self.remove(nodeToRemove)
                self.size -= 1
            else:
                raise KeyError('Error, key not in tree')
        elif self.size == 1 and self.root.key == key:
            self.root = None
            self.size = self.size - 1
        else:
            raise KeyError('Error, key not in tree')

    def __delitem__(self, key):
        self.delete(key)

    def spliceOut(self):
        if self.isLeaf():
            if self.isLeftChild():
                self.parent.leftChild = None
            else:
                self.parent.rightChild = None
        elif self.hasAnyChildren():
            if self.hasLeftChild():
                if self.isLeftChild():
                    self.parent.leftChild = self.leftChild
                else:
                    self.parent.rightChild = self.leftChild
                self.leftChild.parent = self.parent
            else:
                if self.isLeftChild():
                    self.parent.leftChild = self.rightChild
                else:
                    self.parent.rightChild = self.rightChild
                self.rightChild.parent = self.parent

    def findSuccessor(self):
        succ = None
        if self.hasRightChild():
            succ = self.rightChild.findMin()
        else:
            if self.parent:
                if self.isLeftChild():
                    succ = self.parent
                else:
                    self.parent.rightChild = None
                    succ = self.parent.findSuccessor()
                    self.parent.rightChild = self
        return succ

    def findMin(self):
        current = self
        while current.hasLeftChild():
            current = current.leftChild
        return current

    def remove(self, currentNode):
        if currentNode.isLeaf():  # leaf
            if currentNode == currentNode.parent.leftChild:
                currentNode.parent.leftChild = None
            else:
                currentNode.parent.rightChild = None
        elif currentNode.hasBothChildren():  # interior
            succ = currentNode.findSuccessor()
            succ.spliceOut()
            currentNode.key = succ.key
            currentNode.payload = succ.payload

        else:  # this node has one child
            if currentNode.hasLeftChild():
                if currentNode.isLeftChild():
                    currentNode.leftChild.parent = currentNode.parent
                    currentNode.parent.leftChild = currentNode.leftChild
                elif currentNode.isRightChild():
                    currentNode.leftChild.parent = currentNode.parent
                    currentNode.parent.rightChild = currentNode.leftChild
                else:
                    currentNode.replaceNodeData(currentNode.leftChild.key,
                                                currentNode.leftChild.payload,
                                                currentNode.leftChild.leftChild,
                                                currentNode.leftChild.rightChild)
            else:
                if currentNode.isLeftChild():
                    currentNode.rightChild.parent = currentNode.parent
                    currentNode.parent.leftChild = currentNode.rightChild
                elif currentNode.isRightChild():
                    currentNode.rightChild.parent = currentNode.parent
                    currentNode.parent.rightChild = currentNode.rightChild
                else:
                    currentNode.replaceNodeData(currentNode.rightChild.key,
                                                currentNode.rightChild.payload,
                                                currentNode.rightChild.leftChild,
                                                currentNode.rightChild.rightChild)



mytree = BinarySearchTree()
mytree[3]="red"
mytree[4]="blue"
mytree[6]="yellow"
mytree[2]="at"

print(mytree[6])
print(mytree[2])
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinaryTreeNew1373
    set output_file "main.py"

    set template_content '
class BinaryTree:
    def __init__(self, rootObj):
        self.key = rootObj
        self.leftChild = None
        self.rightChild = None

    def insertLeft(self, newNode):
        if self.leftChild == None:
            self.leftChild = BinaryTree(newNode)
        else:
            t = BinaryTree(newNode)
            t.leftChild = self.leftChild
            self.leftChild = t

    def insertRight(self, newNode):
        if self.rightChild == None:
            self.rightChild = BinaryTree(newNode)
        else:
            t = BinaryTree(newNode)
            t.rightChild = self.rightChild
            self.rightChild = t

    def getRightChild(self):
        return self.rightChild

    def getLeftChild(self):
        return self.leftChild

    def setRootVal(self, obj):
        self.key = obj

    def getRootVal(self):
        return self.key

    # 树的前序遍历
    # 树的后序遍历以及中序遍历见ParseTree.py
    def preorder(self):
        print(self.key)
        if self.leftChild:
            self.leftChild.preorder()
        if self.rightChild:
            self.rightChild.preorder()


r = BinaryTree('a')
print(r.getRootVal())
print(r.getLeftChild())
r.insertLeft('b')
print(r.getLeftChild())
print(r.getLeftChild().getRootVal())
r.insertRight('c')
print(r.getRightChild())
print(r.getRightChild().getRootVal())
r.getRightChild().setRootVal('hello')
print(r.getRightChild().getRootVal())

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BubbleSortTwoVariants1374
    set output_file "main.py"

    set template_content '
def bubbleSort(alist):
    for passnum in range(len(alist)-1, 0, -1):
        for i in range(passnum):
            if alist[i] > alist[i+1]:
                alist[i], alist[i+1] = alist[i+1], alist[i]
    return alist

alist = [54,26,93,17,77,31,44,55,20]
print(bubbleSort(alist))

# 改进的冒泡排序, 加入一个校验, 如果某次循环发现没有发生数值交换, 直接跳出循环
def modiBubbleSort(alist):
    exchange = True
    passnum = len(alist) - 1
    while passnum >= 1 and exchange:
        exchange = False
        for i in range(passnum):
            if alist[i] > alist[i+1]:
                alist[i], alist[i+1] = alist[i+1], alist[i]
                exchange = True
        passnum -= 1
    return alist

print(bubbleSort(alist)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CheckErrorWord1375
    set output_file "main.py"

    set template_content '
END = "\$"

def make_trie(words):
    trie = {}
    for word in words:
        t = trie
        for c in word:
            if c not in t:
                t[c] = {}
            t = t[c]
        t[END] = {}
    return trie

def check_fuzzy(trie, word, path='', tol=1):
    if word == '':
        return [path] if END in trie else []
    else:
        p0 = []
        if word[0] in trie:
            p0 = check_fuzzy(trie[word[0]], word[1:], path+word[0], tol)
        p1 = []
        if tol > 0:
            for k in trie:
                if k != word[0]:
                    p1.extend(check_fuzzy(trie[k], word[1:], path+k, tol-1))
        return p0 + p1


# 测试代码
words = ['hello', 'hela', 'dome']
t = make_trie(words)
print(t)
print(check_fuzzy(t, 'hellu'))
print(check_fuzzy(t, 'healu', tol=2))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DynamycProgramming1376
    set output_file "main.py"

    set template_content '
def ChangeMaking(coinVal, change):
    alist = [0]*(change+1)
    for i in range(1, change+1):
        temp = change; j = 0
        while j <= len(coinVal)-1 and i >= coinVal[j]:
            temp = min(alist[i-coinVal[j]], temp)
            j += 1
        alist[i] = temp + 1
    return alist.pop()

print(ChangeMaking([1, 5, 10, 25], 63))

# 解决动态规划中的币值最大化问题---在满足所选硬币不相邻的条件下,从一堆硬币中选择最大金额的硬币
# 输入数组C[1..n]保存n个硬币的面值
# 输出可选硬币的最大金额
def coinRow(coinrow):
    alist = [0]*(len(coinrow)+1)
    alist[1] = coinrow[0]
    for i in range(2, len(coinrow)+1):
        alist[i] = max(coinrow[i-1]+alist[i-2], alist[i-1])
    return alist.pop()

print(coinRow([5, 1, 2, 10, 6, 2]))

# 解决0-1背包问题
def maxBag(weight, value, totalWeight):
    if len(weight) <= 0 or len(value) <= 0 or totalWeight <= 0 or len(weight) != len(value):
        return
    num = len(weight)
    tempMat = []
    for i in range(num+1):
        tempMat.append([0]*(totalWeight+1))
    for i in range(1, num+1):
        for j in range(1, totalWeight+1):
            if j - weight[i-1] >= 0:
                tempMat[i][j] = max(tempMat[i-1][j], value[i-1] + tempMat[i-1][j-weight[i-1]])
            else:
                tempMat[i][j] = tempMat[i-1][j]
    return tempMat[-1][-1]

weight, value, totalWeight = [2,1,3,2], [12,10,20,15], 5
print(maxBag(weight, value, totalWeight))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Hash1377
    set output_file "main.py"

    set template_content '
def hash(astring, tablesize):
    sum = 0
    for pos in astring:
        sum = sum + ord(pos)

    return sum%tablesize

print(hash('cat', 11))  # cat在hash中的位置,hash table长度11

# 改进hash, 让每一位的字母乘以该字母在字串中的位置然后mod
def hash2(astring, tablesize):
    sum = 0
    for pos in range(len(astring)):
        sum += (pos+1) * ord(astring[pos])
    return sum%tablesize

print(hash2('cat', 11))

# 冲突解决:分离链--冲突位置排成一个链; linear probing发生冲突去下一个位置

class HashTable:
    def __init__(self):
        self.size = 11
        self.slots = [None] * self.size
        self.data = [None] * self.size

    def put(self, key, data):
        hashvalue = self.hashfunction(key, self.size)

        if self.slots[hashvalue] == None:
            self.slots[hashvalue] = key
            self.data[hashvalue] = data
        else:
            if self.slots[hashvalue] == key:
                self.data[hashvalue] = data         # 替换相同索引对应的项目
            else:
                if None not in self.slots and key not in self.slots:
                    # 判断hash是否已经满了, 必须添加key not in self.slots, 否则修改已有hash值会直接返回-1
                    print('sorry, there is not enough slots for you!')
                    return -1
                nextslot = self.rehash(hashvalue, len(self.slots))
                while self.slots[nextslot] != None and self.slots[nextslot] != key:
                    nextslot = self.rehash(nextslot, len(self.slots))

                if self.slots[nextslot] == None:
                    self.slots[nextslot] = key
                    self.data[nextslot] = data
                else:
                    self.data[nextslot] = data

    def hashfunction(self, key, size):
        return key%size

    def rehash(self, oldhash, size):
        return (oldhash+1)%size

    def get(self, key):
        startslot = self.hashfunction(key, len(self.slots))

        data = None
        stop = False
        found = False
        position = startslot
        while self.slots[position] != None and not found and not stop:
            if self.slots[position] == key:
                found = True
                data = self.data[position]
            else:
                position = self.rehash(position, len(self.slots))
                if position == startslot:
                    stop = True
        return data

    def __getitem__(self, key):
        return self.get(key)

    def __setitem__(self, key, data):
        self.put(key, data)

H = HashTable()
H[54] = 'cat'
H[26] = "dog"
H[93] = "lion"
H[17] = "tiger"
H[77] = "bird"
H[31] = "cow"
H[44] = "goat"
H[55] = "pig"
H[20] = "chicken"
print(H[20])
print(H.slots)
print(H.data)
print(H[99])
H[21] = "elephant"
H[22] = "sheep"
H[23] = "fish"
print(H.data)
H[20] = 'monkey'
print(H.data)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.InsertionSort1378
    set output_file "main.py"

    set template_content '
def insertionSort(alist):
    for key, item in enumerate(alist):
        index = key
        while index > 0 and alist[index-1] > item:
            alist[index] = alist[index-1]
            index -= 1
        alist[index] = item
    return alist

alist = [54,26,93,17,77,31,44,55,20]
print(insertionSort(alist))

def insertionSort2(alist):
    for index in range(1, len(alist)):
        currentvalue = alist[index]
        position = index

        while position > 0 and alist[position-1] > currentvalue:
            alist[position] = alist[position-1]
            position -= 1
        alist[position] = currentvalue

    return alist

print(insertionSort2(alist))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.List1379
    set output_file "main.py"

    set template_content '
class Node:
    def __init__(self, initdata):
        self.data = initdata
        self.next = None

    def getData(self):
        return self.data

    def getNext(self):
        return self.next

    def setData(self, newdata):
        self.next = newdata

    def setNext(self, nextNode):
        self.next = nextNode


temp = Node(93)
temp.setData(10)
print(temp.getNext())

# 定义一个无序链表
class UnorderedList:
    def __init__(self):
        self.head = None

    def isEmpty(self):
        return self.head == None

    def add(self, item):
        temp = Node(item)
        temp.setNext(self.head)
        self.head = temp

    def size(self):
        current = self.head
        count = 0
        while current != None:
            count += 1
            current = current.getNext()
        return count

    def search(self, item):
        current = self.head
        found = False
        while current != None and not found:
            if current.getData() == item:
                found = True
            else:
                current = current.getNext()
        return found

    def remove(self, item):
        current = self.head
        previous = None
        found = False
        while not found:
            if current.getData() == item:
                found = True
            else:
                previous = current
                current = current.getNext()

        if previous == None:
            self.head = current.getNext()
        else:
            previous.setNext(current.getNext())

myList = UnorderedList()
myList.add(31)
myList.add(77)
myList.add(17)
myList.add(93)
myList.add(26)
myList.add(54)
print(myList.search(17))
myList.remove(54)
print(myList.search(54))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MapReduce_and_filter1380
    set output_file "main.py"

    set template_content '
import functools

# 使用map把list中的int变为str
map(str, [1, 2, 3, 4, 5, 6, 7, 8, 9])


# 使用map()把名字规范化, 首字母大写,其余小写
def standardName(s):
    return s.capitalize()


print([x for x in map(standardName, ["adam", "LISA", "barT"])])
# 在Python2.x中应该使用print(map(standardName, ['adam', 'LISA', 'barT']))


# 使用reduce()输出一个list的所有数的乘积
def prod(aList):
    return functools.reduce(lambda x, y: x * y, aList)


print(prod([1, 2, 3, 4, 5]))


# 使用filter()打印100以内的素数
def isPrime(n):
    isPrimeFlag = True
    if n <= 1:
        isPrimeFlag = False
    i = 2

    while i * i <= n:
        if n % i == 0:
            isPrimeFlag = False
            break
        i += 1
    return n if isPrimeFlag else None


print(filter(isPrime, range(101)))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MergeSort1381
    set output_file "main.py"

    set template_content '
def mergeSort(alist):
    if len(alist) > 1:
        mid = len(alist)//2
        lefthalf = alist[:mid]
        righthalf = alist[mid:]

        mergeSort(lefthalf)
        mergeSort(righthalf)

        i = 0; j = 0; k = 0
        while i < len(lefthalf) and j < len(righthalf):
            if lefthalf[i] < righthalf[j]:
                alist[k] = lefthalf[i]
                i += 1
            else:
                alist[k] = righthalf[j]
                j += 1
            k += 1

        while i < len(lefthalf):
            alist[k] = lefthalf[i]
            i += 1
            k += 1
        while j < len(righthalf):
            alist[k] = righthalf[j]
            j += 1
            k += 1

alist = [54,26,93,17,77,31,44,55,20]
mergeSort(alist)
print(alist)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Queue1382
    set output_file "main.py"

    set template_content '
class Queue:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []

    def enqueue(self, item):
        self.items.insert(0, item)

    def dequeue(self):
        return self.items.pop()

    def size(self):
        return len(self.items)

q = Queue()
q.enqueue(4)
q.enqueue('god')
q.enqueue(True)
print(q.dequeue())

def hotPotato(namelist, num):
    simqueue = Queue()
    for name in namelist:
        simqueue.enqueue(name)

    while simqueue.size() > 1:
        for i in range(num):
            simqueue.enqueue(simqueue.dequeue())
        simqueue.dequeue()

    return simqueue.dequeue()

print(hotPotato(["Bill","David","Susan","Jane","Kent","Brad"],7))

# 设计一个良策都能插入删除的队列deque
class Deque:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []

    def addRear(self, item):
        self.items.insert(0, item)

    def addFront(self, item):
        self.items.append(item)

    def removeFront(self):
        return self.items.pop()

    def removeRear(self):
        return self.items.pop(0)

    def size(self):
        return len(self.items)

# 利用Deque解决回文字符串
def palcheker(aString):
    chardeque = Deque()

    for ch in aString:
        chardeque.addFront(ch)

    stillEqual = True

    while chardeque.size() > 1 and stillEqual:
        first = chardeque.removeFront()
        last = chardeque.removeRear()
        if first != last:
            stillEqual = False

    return stillEqual

print(palcheker('lsdkjfskf'))
print(palcheker('radar'))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.QuickSort1383
    set output_file "main.py"

    set template_content '
def quickSort(alist):
    quickSortHelper(alist, 0, len(alist)-1)

def quickSortHelper(alist, first, last):
    if first < last:
        splitPoint = partition(alist, first, last)

        quickSortHelper(alist, first, splitPoint-1)
        quickSortHelper(alist, splitPoint+1, last)

def partition(alist, first, last):
    pivotvlue = alist[first]

    leftmark = first+1
    rightmark = last
    done = False

    while not done:
        while leftmark <= rightmark and alist[leftmark] <= pivotvlue: # bugfix: 先比较index, 不然数组会越界
            leftmark += 1
        while rightmark >= leftmark and alist[rightmark] >= pivotvlue:
            rightmark -= 1

        if leftmark > rightmark:
            done = True
        else:
            alist[leftmark], alist[rightmark] = alist[rightmark], alist[leftmark]
    alist[rightmark], alist[first] = alist[first], alist[rightmark]
    return rightmark

alist = [54,26,93,17,77,31,44,55,20]
alist2 = [1]
quickSort(alist2)
print(alist2)


if __name__ == "__main__":
    test_data = [3,2,111,3,-1,0,0,1,0,2,4]

    res_stable = sorted(test_data)
    quickSort(test_data)
    print(test_data)
    print(res_stable)
    assert all(map(lambda x: x[0] == x[1], zip(res_stable, test_data)))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.RadixSort1384
    set output_file "main.py"

    set template_content '
def radixSortLSD(alist):
    if len(alist) == 0:
        return
    if len(alist) == 1:
        return alist
    tempList = alist
    maxNum = max(alist)
    radix = 10
    while maxNum * 10 > radix:
        newArr = [[], [], [], [], [], [], [], [], [], []]
        for n1 in tempList:
            testnum = n1 % radix
            testnum = testnum // (radix / 10)
            for n2 in range(10):
                if testnum == n2:
                    newArr[n2].append(n1)
        tempList = []
        for i in range(len(newArr)):
            for j in range(len(newArr[i])):
                tempList.append(newArr[i][j])
        radix *= 10
    return tempList

print(radixSortLSD([10, 12, 24, 23, 13, 52, 15, 158, 74, 32, 254, 201, 30, 19]))
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Recursion1385
    set output_file "main.py"

    set template_content '
def listSum(numlist):
    if len(numlist) == 1:
        return numlist[0]
    else:
        return numlist[0] + listSum(numlist[1:])

print(listSum([1, 2, 3, 4, 5, 6, 7]))

# 递归求阶乘
def listFactorial(num):
    if num <= 1:
        return 1
    else:
        return num * listFactorial(num-1)

print(listFactorial(10))

# 递归实现进制转换:
def toStr(n,base):
   convertString = "0123456789ABCDEF"
   if n < base:
      return convertString[n]
   else:
      return toStr(n//base, base) + convertString[n%base]

print(toStr(1453, 16))

# 递归实现Hanoi塔
def Hanoi(fromPole, withPole, toPole, diskNum):
    if diskNum <= 1:
        print("moving disk from %s to %s" % (fromPole, toPole))
    else:
        Hanoi(fromPole, toPole, withPole, diskNum-1)
        print("moving disk from %s to %s" % (fromPole, toPole))
        Hanoi(withPole, fromPole, toPole, diskNum-1)

Hanoi('A', 'B', 'C', 3)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SelectionSort1386
    set output_file "main.py"

    set template_content '
def selectionSort(alist):
    for i in range(len(alist)-1):
        min = i
        for j in range(i+1, len(alist)):
            if alist[j] < alist[min]:
                min = j
        alist[i], alist[min] = alist[min], alist[i]
    return alist

alist = [54,26,93,17,77,31,44,55,20]
print(selectionSort(alist))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ShellSort1387
    set output_file "main.py"

    set template_content '
def shellSort(alist):
    sublistcount= len(alist)//2
    while sublistcount > 0:
        for startposition in range(sublistcount):
            gapInsertionSort(alist, startposition, sublistcount)
        sublistcount = sublistcount//2
    return alist

def gapInsertionSort(alist, start, gap):
    for i in range(start+gap, len(alist), gap):
        currentValue = alist[i]
        position = i

        while position >= gap and alist[position-gap] > currentValue:
            alist[position] = alist[position-gap]
            position = position-gap
        alist[position] = currentValue

alist = [54,26,93,17,77,31,44,55,20]
print(shellSort(alist))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Stack1388
    set output_file "main.py"

    set template_content "
class Stack():
    # 栈的初始化
    def __init__(self):
        self.items = []
    # 判断栈是否为空,为空返回True
    def isEmpty(self):
        return self.items ==[]
    # 向栈内压入一个元素
    def push(self, item):
        self.items.append(item)
    # 从栈内推出最后一个元素
    def pop(self):
        return self.items.pop()
    # 返回栈顶元素
    def peek(self):
        return self.items[len(self.items)-1]
    # 判断栈的大小
    def size(self):
        return len(self.items)

# 栈属性测试
# 测试数据
# s = Stack()
# print(s.isEmpty())
# s.push(4)
# s.push('dog')
# print(s.peek())
# s.push(True)
# print(s.isEmpty())
# s.push(8.4)
# print(s.pop())
# print(s.pop())
# print(s.size())

# 利用栈将字串的字符反转
def revstring(mystr):
    # your code here
    s = Stack()
    outputStr = ''
    for c in mystr:
        s.push(c)
    while not s.isEmpty():
        outputStr += s.pop()
    return outputStr

# print(revstring('apple'))
# print(revstring('x'))
# print(revstring('1234567890'))

# 利用栈判断括号平衡Balanced parentheses
def parChecker(symbolString):
    s = Stack()
    balanced = True
    index = 0
    while index < len(symbolString) and balanced:
        symbol = symbolString[index]
        if symbol in '([{':
            s.push(symbol)
        else:
            if s.isEmpty():
                balanced = False
            else:
                top = s.pop()
                if not matches(top, symbol):
                    balanced = False
        index += 1

    if balanced and s.isEmpty():
        return True
    else:
        return False

def matches(open, close):
    opens = '([{'
    closers = ')]}'
    return opens.index(open) == closers.index(close)

# print(parChecker('({([()])}){}'))

# 利用栈将十进制整数转化为二进制整数
def Dec2Bin(decNumber):
    s = Stack()

    while decNumber > 0:
        temp = decNumber % 2
        s.push(temp)
        decNumber = decNumber // 2
    binString = ''
    while not s.isEmpty():
        binString += str(s.pop())
    return binString

# print(Dec2Bin(42))

# 利用栈实现多进制转换
def baseConverter(decNumber, base):
    digits = '0123456789ABCDEF'

    s = Stack()

    while decNumber > 0:
        temp = decNumber % base
        s.push(temp)
        decNumber = decNumber // base

    newString = ''
    while not s.isEmpty():
        newString = newString + digits[s.pop()]

    return newString

# print(baseConverter(59, 16))

# 利用栈实现普通多项式的后缀表达式
def infixToPostfix(infixexpr):
    prec = {}
    prec['*'] = 3
    prec['/'] = 3
    prec['+'] = 2
    prec['-'] = 2
    prec['('] = 1
    opStack = Stack()
    postfixList = []
    tokenList = infixexpr.split()

    for token in tokenList:
        if token in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' or token in '0123456789':
            postfixList.append(token)
        elif token == '(':
            opStack.push(token)
        elif token == ')':
            topToken = opStack.pop()
            while topToken != '(':
                postfixList.append(topToken)
                topToken = opStack.pop()
        else:
            while (not opStack.isEmpty()) and (prec[opStack.peek()] >= prec[token]):
                postfixList.append(opStack.pop())
            opStack.push(token)

    while not opStack.isEmpty():
        postfixList.append(opStack.pop())

    return ''.join(postfixList)

print(infixToPostfix("A * B + C * D"))
print(infixToPostfix("( A + B ) * C - ( D - E ) * ( F + G )"))

"
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DivideAndConquer1389
    set output_file "main.py"

    set template_content '
def maxIndex(alist, start, end):
    if start > end or len(alist) == 0:
        return
    pivot = (start+end) >> 1
    if end - start == 1:
        return start
    else:
        temp1 = maxIndex(alist, start, pivot)
        temp2 = maxIndex(alist, pivot, end)
        if alist[temp1] < alist[temp2]:
            return temp2
        else:
            return temp1
print(maxIndex([5,7,9,3,4,8,6,2,0,1], 0, 9))

# 分治法计算正整数幂
def power(base, x):
    if x == 1:
        return base
    else:
        if x & 1 == 1:
            return power(base, x>>1)*power(base, x>>1)*base
        else:
            return power(base, x>>1)*power(base, x>>1)

print(power(2, 6))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.HeapSort1390
    set output_file "main.py"

    set template_content '
def heapSort(alist):
    if alist == None or len(alist) == 0:
        return
    length = len(alist)
    output = []
    for i in range(length):
        tempLen = len(alist)
        for j in range(tempLen//2-1, -1, -1):
            preIndex = j
            preVal, heap = alist[preIndex], False
            while 2 * preIndex < tempLen - 1 and not heap:
                curIndex = 2 * preIndex + 1
                if curIndex < tempLen - 1:
                    if alist[curIndex] < alist[curIndex+1]:
                        curIndex += 1
                if preVal >= alist[curIndex]:
                    heap = True
                else:
                    alist[preIndex] = alist[curIndex]
                    preIndex = curIndex
            alist[preIndex] = preVal
        output.insert(0, alist.pop(0))
    return output

test = [2, 6, 5, 9, 10, 3, 7]
print(heapSort(test))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Singelton1391
    set output_file "main.py"

    set template_content '
class My_Singleton(object):
    def foo(self):
        pass
my_singleton = My_Singleton()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end