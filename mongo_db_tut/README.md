NOTES:

- (1) to run mongo db run below command 
`mongod --config /usr/local/etc/mongod.conf --fork`
if using an **M1 Mac** run this one instead
`mongod --config /opt/homebrew/etc/mongod.conf --fork`
<br>
- (2) then we can run `mongo` command and connect to database
- (3) create a database with the command `use dbname`
- (4) to create a collection in a mongo database use command 
`db.createCollection('users');` 
- (5) to exit the database call `exit`
- (6) to populate a collection in our mongodb from a json array in a file we can use command `mongoimport --jsonArray -d <yourDatabaseName> -c <yourCollectionName> --file <path/To/File.json>`
- (7) to see our new entries in db collection. run the following commands 
`mongo`
`use dbname`
`show collections`
`db.collectionName.find({});`