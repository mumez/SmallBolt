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
sessionManager := SmClientSessionManager default.
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

You also need to put a SeaBolt shared library. Please download it from [Seabolt releases](https://github.com/neo4j-drivers/seabolt/releases) section.

