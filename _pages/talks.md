---
layout: archive
author_profile: true
permalink: /tlk/
title: Talks
---

The list of my last 20 talks - full list available in my [Zotero account](https://www.zotero.org/essepuntato/).

<div class="loader"></div>

<div id="pub"></div>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script>
function prepare_html(bib) {
	s = "<p>";
	
	// authors
	if (bib.creators.length > 0) {
		var is_first = true;
		for (let i = 0; i < bib.creators.length; i++) {
			var creator = bib.creators[i];
			if ((bib.itemType == "book" && creator.creatorType == "editor") || creator.creatorType == "author" || creator.creatorType == "presenter") {
				if (!is_first) {
					s += ", "
				}
				s += creator.lastName;
				
				is_first = is_first & false;
			}
		}
	}
	
	
	// publication date
	date_rex = /([0-9][0-9][0-9][0-9])/
	s += " (" + date_rex.exec(bib.date)[1] + "). ";
	
	// title
	s += bib.title + ".";
	
	// venue
	if (bib.itemType == "journalArticle") {
		s += " <em>" + bib.publicationTitle + "</em>";
		if (bib.volume != "") {
			s += ", " + bib.volume;
		}
		if (bib.issue != "") {
			s += " (" + bib.issue + ")";
		}
		if (bib.pages != "") {
			s += ", " + bib.pages;
		}
		s += "."
	} else if (bib.itemType == "preprint") {
		s += " Preprint";
		if (bib.repository != "") {
			s += " available in " + bib.repository
		}
		s += ".";
	} else if (bib.itemType == "dataset") {
		if (bib.type != "") {
			s += " " + bib.type;
			if (bib.versionNumber != "") {
				s+= " - version: " + bib.versionNumber
				if (bib.format != "") {
					s += ", format(s): " + bib.format
				}
			}
			s +=  ".";
		}
		
		if (bib.repository != "") {
			s += " Data available in ";
			if (bib.repositoryLocation != "") {
				s += "<a href='" + bib.repositoryLocation + "'>";
			}
			s += bib.repository;
			if (bib.repositoryLocation != "") {
				s += "</a>";
			}
		}
		s += ".";
	} else if (bib.itemType == "conferencePaper") {
		if (bib.proceedingsTitle != "") {
			s += " In ";
			var is_first = true;
			for (let i = 0; i < bib.creators.length; i++) {
				var creator = bib.creators[i];
				if (creator.creatorType == "editor") {
					if (!is_first) {
						s += ", "
					}
					s += creator.lastName;
					
					is_first = is_first & false;
						
				}
			}
			if (!is_first) {
				s += " (Eds.), "
			}
			s += "<em>" + bib.proceedingsTitle + "</em>"
			if (bib.pages != "") {
				s += " (pp. " + bib.pages + ")";
			}
			if (bib.series != "") {
				s += ", " + bib.series;
				if (bib.volume != "") {
					s += " (Vol. " + bib.volume + ")"
				}
			}
			s += "."
			if (bib.publisher != "") {
				if (bib.place != "") {
					s += " " + bib.place + ":";
				}
				s += " " + bib.publisher + ".";
			}
		}
		if (bib.conferenceName != "") {
			s += " Presented at the " + bib.conferenceName;
			if (bib.publisher == "") {
				s += ", " + bib.place
			}
			s += "."
		}
	} else if (bib.itemType == "report") {
		if (bib.reportType != "") {
			s += " " + bib.reportType;
			if (bib.reportNumber != "") {
				s += " " + bib.reportNumber;
			}
		}
		if (bib.seriesTitle != "") {
			s += ", <em>" + bib.seriesTitle + "</em>.";
		} else {
			s += ".";
		}
		if (bib.institution	 != "") {
			if (bib.place != "") {
				s += " " + bib.place + ":";
			}
			s += " " + bib.institution + ".";
		}
	} else if (bib.itemType == "book") {
		if (bib.seriesTitle != "") {
			s += " <em>" + bib.seriesTitle + "</em>";
				if (bib.volume != "") {
					s += " (Vol. " + bib.volume + ")"
				}
			s += "."
		}
		if (bib.publisher != "") {
			if (bib.place != "") {
				s += " " + bib.place + ":";
			}
			s += " " + bib.publisher + ".";
		}
	} else if (bib.itemType == "standard") {
		if (bib.type != "") {
			s += " " + bib.type;
			if (bib.versionNumber != "") {
				s += " " + bib.versionNumber;
			}
		}
		if (bib.publisher != "") {
			if (bib.place != "") {
				s += " " + bib.place + ":";
			}
			s += " " + bib.publisher + ".";
		}
	} else if (bib.itemType == "blogPost") {
		if (bib.blogTitle != "") {
			s += " <em>" + bib.blogTitle + "</em>";
				if (bib.websiteType != "") {
					s += " [" + bib.websiteType + "]"
				}
			s += "."
		}
	} else if (bib.itemType == "document") {
		if (bib.publisher != "") {
			s += " " + bib.publisher + ".";
		}
	} else if (bib.itemType == "artwork") {
		s += " Poster."
	} else if (bib.itemType == "bookSection") {
		if (bib.bookTitle != "") {
			s += " In ";
			var is_first = true;
			for (let i = 0; i < bib.creators.length; i++) {
				var creator = bib.creators[i];
				if (creator.creatorType == "editor") {
					if (!is_first) {
						s += ", "
					}
					s += creator.lastName;
					
					is_first = is_first & false;
						
				}
			}
			if (!is_first) {
				s += " (Eds.), "
			}
			s += "<em>" + bib.bookTitle + "</em>"
			if (bib.pages != "") {
				s += " (pp. " + bib.pages + ")";
			}
			if (bib.series != "") {
				s += ", " + bib.series;
				if (bib.volume != "") {
					s += " (Vol. " + bib.volume + ")"
				}
			}
			s += "."
			if (bib.publisher != "") {
				if (bib.place != "") {
					s += " " + bib.place + ":";
				}
				s += " " + bib.publisher + ".";
			}
		}
	} else if (bib.itemType == "presentation") {
		if (bib.presentationType != "") {
			s += " " + bib.presentationType;
			if (bib.meetingName) {
				s +=  " presented at the <em>" + bib.meetingName + "</em>";
			}
			if (bib.place != "") {
				s +=  " (" + bib.place + ")";
			}
			s +=  ".";	
		}
	} else {
		// do nothing
	}
	
	// DOI or URL
	if (bib.DOI != "" && bib.DOI != undefined) {
		s += " <a href='https://doi.org/" + bib.DOI + "'>doi:" + bib.DOI + "</a>"
	} else if (bib.url != "" && bib.url != undefined) {
		s += " <a href='" + bib.url + "'>";
		if (bib.url.startsWith("https://doi.org/")) {
			s += bib.url.replace("https://doi.org/", "doi:");
		} else {
			s += bib.url;
		}
		s += "</a>";
	}
	
	s += "</p>";
	
	return s;
}

$.get("https://api.zotero.org/users/5306497/publications/items?sort=date&itemType=presentation&limit=20", function( data ) {
    $.each(data, function(idx, val) {
        $(".loader").hide();
        $("#pub").append(prepare_html(val.data));
    });
});
</script>  
