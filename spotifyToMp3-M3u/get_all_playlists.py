"""Sets up a URL for getting a user's Spotify playlists, sends a request to retrieve
the playlists using the provided authentication headers, and parses the response as 
JSON. It then creates an empty dictionary to store the playlists and their URLs, iterates 
through each playlist in the response and adds it to the dictionary (excluding the "Discover Weekly" playlist), 
and finally prints the dictionary as a string in JSON format."""

# Import necessary libraries
import requests
import json

# Define function to get all playlists for a user
def getAllPlaylists(headers):

    # Set URL for getting playlists
    PlUrl = "https://api.spotify.com/v1/me/playlists"

    # Send request to get playlists and get response
    req = requests.get(PlUrl, headers = headers).text

    # Parse response as JSON
    fullReq = json.loads(req)

    # Create an empty dictionary to store playlists and their URLs
    PLdict = {}

    # Iterate through each playlist and add it to the dictionary
    for item in fullReq["items"]:
        if item["name"] != "Discover Weekly":
            # Exclude the "Discover Weekly" playlist
            PLdict[item["name"]] = item["external_urls"]["spotify"]

    # Print the dictionary as a string in JSON format
    print(str(PLdict).replace("'", '"'))
