while getopts ":g" opt; do
  case $opt in
    g)
      echo "Opening GUI" >&2
      openGui=true
      ;;
    *)
      openGui=false
      ;;
  esac
done

tipo=$(echo "$1" | grep -oP "(?<=(.com/)).*(?=/)")
id=$(echo $1 | grep -oE "\w{22}")
file="$id.svg"
url="https://scannables.scdn.co/uri/plain/svg/000000/white/640/spotify:$tipo:$id"  

curl -s $url -o "$file" && echo "Downloaded svg..."
sed -i '2d' "./$file"

if [[ $openGui = true ]]
then
  openscad -D "code_file=\"$file\"" Custom_Spotify_Code_V07.scad
else
  echo -e "Generating stl...\n"
  [ ! -d "output" ] && mkdir output
  openscad -o "output/$id.stl" -D "code_file=\"$file\"" Custom_Spotify_Code_V07.scad
  echo -e "\nCheck output at 'output/$id.stl'"
fi

rm "$file"

