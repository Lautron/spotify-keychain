#! ./venv/bin/python3
import spotipy, sys
from spotipy.oauth2 import SpotifyClientCredentials
from config import config

sp = spotipy.Spotify(
    auth_manager=SpotifyClientCredentials(
        client_id=config.sp_id,
        client_secret=config.sp_secret)
)

def get_plst_by_name(id_: str):
    results = sp.track(id_)
    return results['name'].replace(' ', '_')

print(get_plst_by_name(sys.argv[1]))

