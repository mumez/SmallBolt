# SmallBolt

[Neo4j](https://neo4j.com/) bolt driver for Pharo Smalltalk, based on [Seabolt](https://github.com/neo4j-drivers/seabolt).

## Example

### Simple cypher execution

```smalltalk
client := SbClient new.
client settings password: 'neoneo'.
client connect.
cypher := 'UNWIND range(1, 10) AS n RETURN n'.
result := client transactCypher: cypher.
client release.
result inspect.
```

### Using session manager

```smalltalk
sessionManager := SbClientSessionManager default.
sessionManager standBy: 3 setting: [:settings | settings password: 'neoneo'].
cypher := 'MATCH p = (n:Movie)<-[r]-(m) RETURN p LIMIT 10'.
sessionManager clientDo: [ :cli | 
  result := cli runCypher: cypher.
  Transcript cr; show: result fieldValues.
].
```

## Installation

```smalltalk
Metacello new
  baseline: 'SmallBolt';
  repository: 'github://mumez/SmallBolt/src';
  load.
```

You also need to put a Seabolt shared library (libseabolt).
The latest pre-built libraries are in [shared-libraries](./shared-libraries/) directory.
The libraries tagged with #stable are located at [stable release]([https://github.com/mumez/Smallbolt/releases/stable]). BaselineOfSmallBolt will  automatically download the appropriate library from the [release]([https://github.com/mumez/Smallbolt/releases/stable]) according to the current platform.

## Performance

SmallBolt communicates with Neo4j via efficient Bolt protocol using FFI. Generally, it is about 3 times faster than [Neo4reSt](https://github.com/mumez/Neo4reSt) REST client.

[Neo4reSt](https://github.com/mumez/Neo4reSt) REST client:
```smalltalk
graphDb := N4GraphDb new.
graphDb settings password: 'neoneo'.

[1000 timesRepeat: [ 
cypher := 'MATCH (m:Movie)<-[r]-(n) RETURN m,r,n LIMIT 10'.
resp := graphDb restClient queryByCypher: cypher.
resp result data
]] timeToRun. "=>0:00:00:04.854"
```

SmallBolt:
```smalltalk
client := SbClient new.
client settings password: 'neoneo'.
client connect.

[1000 timesRepeat: [  
cypher := 'MATCH (m:Movie)<-[r]-(n) RETURN m,r,n LIMIT 10'.
result := client runCypher: cypher.	
result fieldValues
]] timeToRun. "=>0:00:00:01.499"
```