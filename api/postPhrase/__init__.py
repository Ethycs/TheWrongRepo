import logging
import base64
import json
from azure.cosmos import CosmosClient
import azure.functions as func
import uuid
import os

url_connection = os.getenv('ENDPOINT')
key = os.getenv('COSMOS_KEY')
database_name = 'corvox-heart'
container_name = 'corvox-conduit'

client = CosmosClient(url_connection, key)
database = client.get_database_client(database=database_name)
container = database.get_container_client(
    container=container_name, 
)

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')
    header = req.headers['x-ms-client-principal']
    client_json = base64.b64decode(header)
    client_str = client_json.decode('ascii')
    principal_dict = json.loads(client_str) # Parsing the client header
    user_id = principal_dict['userId']
    fragment = req.params.get('fragment')
    timestamp = req.params.get('timestamp')
    if not user_id or fragment or timestamp:
        return func.HttpResponse(
            status_code=400
        )

    dialog_fragment = {
        'id': str(uuid.uuid4()),
        'userId': user_id,
        'timestamp': timestamp,
        'fragment': fragment
    }

    container.create_item(
        dialog_fragment
    )
    
    return func.HttpResponse(
            status_code=200
    )
 