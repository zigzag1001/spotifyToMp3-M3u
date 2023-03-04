from get_spot_access_token import getAccessToken
from get_all_playlists import getAllPlaylists

headers = getAccessToken()

getAllPlaylists(headers)
