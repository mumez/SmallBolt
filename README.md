# SmallBolt
Neo4j bolt driver for Pharo Smalltalk, based on [Seabolt](https://github.com/neo4j-drivers/seabolt).

## Example

```smalltalk
client := SbClient new.
client settings password: 'neoneo'.
client connect.
cypher := 'UNWIND range(1, 10) AS n RETURN n'.
result := client requester transactCypher: cypher.
client release.
result inspect.
```

## WIP

