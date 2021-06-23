import logging
import azure.functions as func
import requests
import os

key = os.getenv("OCP-APIM-SUBSCRIPTION")


def main(req: func.HttpRequest) -> func.HttpResponse:
    fetch_token_url = 'https://westus.api.cognitive.microsoft.com/sts/v1.0/issueToken'
    headers = {
        'Ocp-Apim-Subscription-Key': key
    }
    response = requests.post(fetch_token_url, headers=headers)
    access_token = str(response.text)
    return func.HttpResponse(
            access_token,
            status_code=200
    )
