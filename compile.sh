if [[ $# -eq 0 ]]; then
	echo "Missing argument — list name"
	exit 1
fi

# One temp dir is enough
if [ -d 'tmp' ]; then
	rm -r tmp
fi
mkdir -p tmp/__INTERNAL__

echo "<html><head></head><body><ol>" > tmp/index.html

counter=0
while IFS= read -r line; do
	counter=$[counter+1]
	
	# Parse
	mercury-parser "$line" > tmp/__INTERNAL__/$counter.json
	jq -r '.content' tmp/__INTERNAL__/$counter.json > tmp/__INTERNAL__/$counter.html
	
	# Cache
	title=$(jq -r '.title' tmp/__INTERNAL__/$counter.json)
	mkdir "tmp/$counter"
	
	# Force ipv4
	wget -4 -e robots=off --page-requisites --span-hosts --convert-links --adjust-extension --no-directories --directory-prefix="tmp/$counter" --accept-regex="(jpe?g|gif|png|html?)" "http://localhost:8000/tmp/__INTERNAL__/$counter.html"
	
	# So that Calibre won't choke
	sed -i'.bak' "1s/^/<html><head><h1>$title<\/h1><\/head><body>/" "tmp/$counter/$counter.html"
	echo '</body></html>' >> "tmp/$counter/$counter.html"
	
	# Index
	echo "<li><a href='$counter/$counter.html'>$title</a></li>" >> tmp/index.html
done < "$1"

echo "</ol></body></html>" >> tmp/index.html

# Finalize
output=$(basename $1)
ebook-convert tmp/index.html "$output.epub" --smarten-punctuation --chapter-mark both --change-justification left --title "$output" --no-chapters-in-toc --authors "Multiple Authors" 
# ebook-convert "$output.epub" "$output.mobi" --output-profile kindle_voyage
