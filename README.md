# glue-missing-field-bug-reproduction
A repo that helps AWS technical support team to reproduce the bug of missing fields in Glue when using the MongoDB connector
The bug is probably related to:
 - <https://repost.aws/questions/QUe1pgoK93TgWi0dG5ysaX1Q/aws-glue-missing-fields-after-extraction>
 - <https://www.tecracer.com/blog/2022/02/working-around-glues-habit-of-dropping-unsuspecting-columns.html>
 - <https://stackoverflow.com/questions/76118661/missing-columns-in-aws-glue>

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
