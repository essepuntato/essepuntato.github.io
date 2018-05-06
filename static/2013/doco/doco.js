function showDivs() {
    $(".table-div,.container-div,.headedcontainer-div,.record-div,.popup-div").show();
}

translation = { 
    "table":"Tab",
    "tablebox":"Tabbox",
    "list":"List",
    "paragraph":"Par",
    "reference":">",
    "section":"Sec",
    "sectiontitle":"Sectit",
    "figure":"Fig",
    "figurebox":"Figbox",
    "bodymatter":"Body",
    "frontmatter":"Front",
    "title":"Tit",
    "bibliographicreferencelist":"Biblist",
    "bibliographicreference":"Bibref",
    "bibliography":"Bib",
    "footnote":"Note"};

references = { 
	    "table":"t",
	    "tablebox":"t",
	    "section":"s",
	    "figure":"f",
	    "figurebox":"f",
	    "bibliographicreference":"b",
	    "footnote":"#"};

function showDoco(classname) {
    showStruct("doco",classname,translation);
}

function showDocoText(classname) {
    showStructText("doco",classname,translation);
}

function showDeo(classname) {
    showStruct("deo",classname,translation);
}

function showDeoText(classname) {
    showStructText("deo",classname,translation);
}

function showRef(classname) {
    showStruct("ref",classname,references);
}

function showRefText(classname) {
    showStructText("ref",classname,references);
}

function showStruct(type,classname,translation) {
    $("." + type + "-" + classname + " *").hide();
    $("." + type + "-" + classname + " > .table-div,." + type + "-" + classname + " > .container-div,." + type + "-" + classname + " > .headedcontainer-div,." + type + "-" + classname + " > .record-div,." + type + "-" + classname + " > .popup-div").text(translation[classname]);
}

function showStructText(type,classname,translation) {
    $("." + type + "-" + classname + " > *:first-child").text(translation[classname]);
}

$(document).ready(
    function () {
        showDoco("table");
        showDoco("tablebox");
        showDoco("list");
        //showDocoText("list");
        showDocoText("paragraph");
        showDeoText("reference");
        showDocoText("section");
        showDocoText("sectiontitle");
        showDocoText("figure");
        showDoco("figurebox");
        showDocoText("bodymatter");
        showDocoText("frontmatter");
        showDocoText("title");
        showDocoText("bibliographicreferencelist");
        showDeoText("bibliographicreference");
        showDocoText("bibliography");
        showDocoText("footnote");
        
        showRefText("section");
        showRefText("table");
        showRefText("tablebox");
        showRefText("figure");
        showRefText("figurebox");
        showRefText("bibliographicreference");
        showRefText("footnote");
        showDivs();
});