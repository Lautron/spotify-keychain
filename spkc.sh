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
echo "Last arg is: $1" 
tipo=$(echo "$1" | grep -oP "(?<=(.com/)).*(?=/)")
id=$(echo "$1" | grep -oE "\w{22}")
if [[ $tipo = '' ]] || [[ $id = '' ]]; then
  echo "Invalid argument"
  exit 1  
fi
svgFile="$id.svg"
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
  openscad -o "output/$id.stl" -D "code_file=\"$svgFile\"" Custom_Spotify_Code_V07.scad
  echo -e "\nCheck output at 'output/$id.stl'"
fi

rm "$svgFile"
}

if [[ "$file" = '' ]]
then
  echo "lol"
  main $lastArg $openGui 
else
  echo "lol2"
  while IFS= read -r line; do
    echo "Text read from file: $line"
    main $line $openGui
done < "$file"
fi
  
