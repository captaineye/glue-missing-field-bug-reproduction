# glue-missing-field-bug-reproduction
A repo that helps AWS technical support team to reproduce the bug of missing fields in Glue when using the MongoDB connector

The schema I have received in the output of the job is sometimes correct:
```
root
|-- _id: string
|-- missingField: boolean
|-- name: string
```
But sometimes it is missing the `missingField` field:
```
root
|-- _id: string
|-- name: string
```

