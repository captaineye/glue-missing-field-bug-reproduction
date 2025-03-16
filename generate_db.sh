#!/bin/bash
# Purpose: Generate 100,100 documents of the following structure:
# {
#  "name": "string"
#  "missingField": boolean
# }
# Only 100 of the documents will have the "missingField" field.
#
# Author: Felix Korovin <felix@captain-eye.com>
# Usage: ./generate_db.sh <cluster_name> <db_username> <db_password> <db_name>

if [ "$#" -ne 4 ]; then
    echo "Illegal number of parameters"
    echo "Usage: ./generate_db.sh <cluster_name> <db_username> <db_password> <db_name>"
    exit 1
fi


readonly cluster_name=$1
readonly db_username=$2
readonly db_password=$3
readonly db_name=$4

echo "Generating data for the database"

for j in {1..100}
do
    echo "Inserting data into the database. Iteration: $j"

    names_json_string='['
    for i in {1..1000}
    do
      names_json_string="$names_json_string{\"name\": \"$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 5 | head -n 1)\"},"
    done

    names_json_string="$names_json_string{\"name\": \"nameWithMissingField\", \"missingField\": true},"

    names_json_string="${names_json_string%?}]"

    mongosh "mongodb+srv://$cluster_name.vfq19.mongodb.net/$db_name" --apiVersion 1 --username $db_username --password $db_password --quiet \
        --eval "db.getCollection('missing-fields-bug-reproduction').insert($names_json_string);"
done
