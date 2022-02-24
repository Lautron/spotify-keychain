lastArg="$BASH_ARGV"
file=''
openGui=false

while getopts "f:g" opt; do
  case $opt in
    f) 
      file=$OPTARG
      ;;
    g)
      echo "Opening GUI" >&2
      openGui=true
      ;;
    *)
      ;;
  esac
done

function main ()
{
tipo=$(echo "$1" | grep -oP "(?<=(.com/)).*(?=/)")
id=$(echo "$1" | grep -oE "\w{22}")
if [[ $tipo = '' ]] || [[ $id = '' ]]; then
  echo "Invalid argument: $1"
  exit 1  
fi
svgFile="$id.svg"
name=$(./get_name.py "$id")
url="https://scannables.scdn.co/uri/plain/svg/000000/white/640/spotify:$tipo:$id"  
echo -e "$url\n"

curl -s $url -o "$svgFile" && echo "Downloaded svg..."
sed -i '2d' "./$svgFile"

if [[ $2 = true ]]
then
  openscad -D "code_file=\"$svgFile\"" Custom_Spotify_Code_V07.scad
else
  echo -e "Generating stl...\n"
  [ -d "output" ] || mkdir output
  openscad -o "output/$name.stl" -D "code_file=\"$svgFile\"" Custom_Spotify_Code_V07.scad
  echo -e "\nCheck output at 'output/$name.stl'"
fi

rm "$svgFile"
}

if [[ "$file" = '' ]]
then
  main $lastArg $openGui 
else
  while IFS= read -r line; do
    main $line $openGui
done < "$file"
fi
  
