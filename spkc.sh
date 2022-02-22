tipo=$(echo "$1" | grep -oP "(?<=(.com/)).*(?=/)")
id=$(echo $1 | grep -oE "\w{22}")
file="$id.svg"
url="https://scannables.scdn.co/uri/plain/svg/000000/white/640/spotify:$tipo:$id"  
curl $url -o "$file"
sed -i '2d' "./$file"
#openscad -o "$id.stl" -D "code_file=\"$file\"" Custom_Spotify_Code_V07.scad
openscad -D "code_file=\"$file\"" Custom_Spotify_Code_V07.scad
rm "$file"

