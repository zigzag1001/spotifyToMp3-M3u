# Import necessary library
import requests

# Define authentication parameters
response_type= 'code'
client_id= "[your id]"
scope= "playlist-read-private"
redirect_uri= "[redirect]"

# Set up authentication request URL
url = f"https://accounts.spotify.com/authorize?response_type={response_type}&client_id={client_id}&redirect_uri={redirect_uri}&scope={scope}"

# Print the authentication request URL
print(url)
