<cfscript>
// request.cacheControlMaxAge = 60 * 20;  // cache for 20 min

oMissing = new lib.missing();
page = {};
page['total'] = arrayLen(application.index.tags) + arrayLen(application.index.functions);
page['functions'] = oMissing.process( application.index.functions );
page['tags'] = oMissing.process( application.index.tags );

page['missing']  = arrayLen(page.functions.examples) + arrayLen(page.tags.examples);
page['complete'] = page.total - page.missing;
page['percent']  = NumberFormat( (page.complete/page.total) * 100, "_.__" );

page.description = "Out of #page.total# tags and functions, #page.complete# have examples, #page.percent#% complete.";
url.name = "missing-examples";
request.gitFilePath = "/edit/master/reports/missing-examples.cfm";
</cfscript>

<cfoutput>
	<style>
	div.missbox {display: inline-block; width: 400px; margin-right: 30px;}
	div.missbox ul {height: 400px; overflow-y: scroll; border: 2px solid ##CBCBCB; background-color: white;}
	div.missbox h4 {font-weight: bold; background-color: ##CBCBCB; padding: 5px; margin: 0; border-radius: 4px 4px 0 0;}
	</style>
	<div class="jumbotron">
		<div class="container">
			<h1 id="docname">#url.name#</h1>
			<p>#autoLink(page.description)#</p>
		</div>
	</div>
	<div class="container">
		<div class="missbox">
			<h4>Tags (#arrayLen(page.tags.examples)#)</h4>
			<ul>
			<cfloop index="r" array="#page.tags.examples#">
				<li><a href="/#r#">#r#</a></li>
			</cfloop>
			</ul>
		</div>
		<div class="missbox">
			<h4>Functions (#arrayLen(page.functions.examples)#)</h4>
			<ul>
			<cfloop index="r" array="#page.functions.examples#">
				<li><a href="/#r#">#r#</a></li>
			</cfloop>
			</ul>
		</div>
	</div>
</cfoutput>
