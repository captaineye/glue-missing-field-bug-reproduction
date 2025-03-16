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

## Steps to reproduce the bug
1. Clone this repo
2. Create a Glue job with the `glue_job.py` script
3. Generate the MongoDB data using the `generate_db.sh` script
4. Run the Glue job and check the schema in the output

For the bash script, [mongosh](https://www.mongodb.com/try/download/shell) is required to be installed.
