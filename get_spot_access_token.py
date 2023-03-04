"""Sets up authentication parameters and headers to access the Spotify API, 
sends an authentication request, and extracts the access token from the response. 
If a refresh token exists, it is used to get a new access token. If a refresh token does not exist,
the user is prompted to input an auth code. Finally, the function returns headers that can be used
to access the Spotify API with the obtained access token."""

# Import necessary libraries
import subprocess
import requests
import base64
import json
import os

# Define function to get access token
def getAccessToken():

    # Set client ID and secret for Spotify API
    CLIENT_ID = "[your id]"
    CLIENT_SECRET = "[your secret]"

    # Set authentication URL
    authUrl = "https://accounts.spotify.com/api/token"

    # Define authentication parameters
    data = {"grant_type": "authorization_code",
            "code": "x",
            "redirect_uri": "[redirect]",
            "client_id": CLIENT_ID,
            "client_secret": CLIENT_SECRET}

    # Set authentication headers
    authHeaders = {"Content-Type": "application/x-www-form-urlencoded"}

    # Check if refresh token exists in current directory
    succ = False
    for file in os.listdir():
        if ".spot" in file:
            succ = True
            data["grant_type"] = "refresh_token"
            data["refresh_token"] = file[:-5]
            break

    # If refresh token does not exist, prompt user for auth code
    if not succ:
        data["code"] = input("=============\nInput Auth Code:")

    # Send authentication request and get response
    req0 = requests.post(authUrl, data = data, headers = authHeaders).text

    # Extract access token from response
    access_token = json.loads(req0)["access_token"]

    # If refresh token does not exist, save it to a file
    if not succ:
        refresh_token = json.loads(req0)["refresh_token"]
        bash_command = "touch " + refresh_token + ".spot"
        subprocess.run(bash_command, shell=True)

    # Set headers for accessing Spotify API with access token
    headers = {"Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": f"Bearer {access_token}"}

    # Return headers for accessing Spotify API
    return headers


