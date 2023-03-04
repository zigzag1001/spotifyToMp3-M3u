# spotifyToMp3-M3u
Uses the Spotify api and spotdl to download m3u and mp3 files. Keeps playlists in sync to your spotify. Used for self hosted music libraries.


Use:

	Create a new Spotify App in the Spotify Developer Dashboard

	Configure the apps settings, add a redirect URI and appropriate scopes

	Copy the client id and client secret into get_spot_access_token.py

	Go to extras/get_spot_auth_url.py paste your client id into appropriate space and run

	Log in using the url printed, and allow access

	You will be redirected to a new page, copy the auth code at the end of the url

	bash update_all.sh and input the auth code when prompted

	If you want it to update every 12/24 hours use run_every_24h.sh

ive got no idea if it works, i forgor right after it was made