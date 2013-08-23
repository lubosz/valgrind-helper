<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en" dir="ltr">
<head>
<title>Parse valgrind suppressions.sh - WxWiki</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="generator" content="MediaWiki 1.16.2" />
<link rel="shortcut icon" href="/favicon.ico" />
<link rel="search" type="application/opensearchdescription+xml" href="/opensearch_desc.php" title="WxWiki (en)" />
<link rel="alternate" type="application/atom+xml" title="WxWiki Atom feed" href="/index.php?title=Special:RecentChanges&amp;feed=atom" />
<link rel="stylesheet" href="/skins/common/shared.css?270" media="screen" />
<link rel="stylesheet" href="/skins/common/commonPrint.css?270" media="print" />
<link rel="stylesheet" href="/skins/monobook/main.css?270" media="screen" />
<!--[if lt IE 5.5000]><link rel="stylesheet" href="/skins/monobook/IE50Fixes.css?270" media="screen" /><![endif]-->
<!--[if IE 5.5000]><link rel="stylesheet" href="/skins/monobook/IE55Fixes.css?270" media="screen" /><![endif]-->
<!--[if IE 6]><link rel="stylesheet" href="/skins/monobook/IE60Fixes.css?270" media="screen" /><![endif]-->
<!--[if IE 7]><link rel="stylesheet" href="/skins/monobook/IE70Fixes.css?270" media="screen" /><![endif]-->
<link rel="stylesheet" href="/index.php?title=MediaWiki:Common.css&amp;usemsgcache=yes&amp;ctype=text%2Fcss&amp;smaxage=18000&amp;action=raw&amp;maxage=18000" />
<link rel="stylesheet" href="/index.php?title=MediaWiki:Print.css&amp;usemsgcache=yes&amp;ctype=text%2Fcss&amp;smaxage=18000&amp;action=raw&amp;maxage=18000" media="print" />
<link rel="stylesheet" href="/index.php?title=MediaWiki:Monobook.css&amp;usemsgcache=yes&amp;ctype=text%2Fcss&amp;smaxage=18000&amp;action=raw&amp;maxage=18000" />
<link rel="stylesheet" href="/index.php?title=-&amp;action=raw&amp;maxage=18000&amp;gen=css" />
<script>
var skin="monobook",
stylepath="/skins",
wgUrlProtocols="http\\:\\/\\/|https\\:\\/\\/|ftp\\:\\/\\/|irc\\:\\/\\/|gopher\\:\\/\\/|telnet\\:\\/\\/|nntp\\:\\/\\/|worldwind\\:\\/\\/|mailto\\:|news\\:|svn\\:\\/\\/",
wgArticlePath="/$1",
wgScriptPath="",
wgScriptExtension=".php",
wgScript="/index.php",
wgVariantArticlePath=false,
wgActionPaths={},
wgServer="http://wiki.wxwidgets.org",
wgCanonicalNamespace="",
wgCanonicalSpecialPageName=false,
wgNamespaceNumber=0,
wgPageName="Parse_valgrind_suppressions.sh",
wgTitle="Parse valgrind suppressions.sh",
wgAction="view",
wgArticleId=2469,
wgIsArticle=true,
wgUserName=null,
wgUserGroups=null,
wgUserLanguage="en",
wgContentLanguage="en",
wgBreakFrames=false,
wgCurRevisionId=7962,
wgVersion="1.16.2",
wgEnableAPI=true,
wgEnableWriteAPI=true,
wgSeparatorTransformTable=["", ""],
wgDigitTransformTable=["", ""],
wgMainPageTitle="Main Page",
wgFormattedNamespaces={"-2": "Media", "-1": "Special", "0": "", "1": "Talk", "2": "User", "3": "User talk", "4": "WxWiki", "5": "WxWiki talk", "6": "File", "7": "File talk", "8": "MediaWiki", "9": "MediaWiki talk", "10": "Template", "11": "Template talk", "12": "Help", "13": "Help talk", "14": "Category", "15": "Category talk"},
wgNamespaceIds={"media": -2, "special": -1, "": 0, "talk": 1, "user": 2, "user_talk": 3, "wxwiki": 4, "wxwiki_talk": 5, "file": 6, "file_talk": 7, "mediawiki": 8, "mediawiki_talk": 9, "template": 10, "template_talk": 11, "help": 12, "help_talk": 13, "category": 14, "category_talk": 15, "image": 6, "image_talk": 7},
wgSiteName="WxWiki",
wgCategories=[],
wgRestrictionEdit=[],
wgRestrictionMove=[];
</script><script src="/skins/common/wikibits.js?270"></script>
<script src="/skins/common/ajax.js?270"></script>
<script src="/index.php?title=-&amp;action=raw&amp;gen=js&amp;useskin=monobook&amp;270"></script>

</head>
<body class="mediawiki ltr ns-0 ns-subject page-Parse_valgrind_suppressions_sh skin-monobook">
<div id="globalWrapper">
<div id="column-content"><div id="content" >
	<a id="top"></a>
	
	<h1 id="firstHeading" class="firstHeading">Parse valgrind suppressions.sh</h1>
	<div id="bodyContent">
		<h3 id="siteSub">From WxWiki</h3>
		<div id="contentSub"></div>
		<div id="jump-to-nav">Jump to: <a href="#column-one">navigation</a>, <a href="#searchInput">search</a></div>
		<!-- start content -->
<p>This is a script for parsing valgrind's output when using the --gen-suppressions=all option. See <a href="/Valgrind_Suppression_File_Howto" title="Valgrind Suppression File Howto"> Creating a Valgrind suppression file</a> for too much information.
</p>
<div class="wxGeshiSyntax">
<pre class="wx-c"><span style="color: #339933;">#! /usr/bin/awk -f</span>
<span style="color: #339933;"># A script to extract the actual suppression info from the output of (for example) valgrind --leak-check=full --show-reachable=yes --error-limit=no --gen-suppressions=all ./minimal</span>
<span style="color: #339933;"># The desired bits are between ^{ and ^} (including the braces themselves).</span>
<span style="color: #339933;"># The combined output should either be appended to /usr/lib/valgrind/default.supp, or placed in a .supp of its own</span>
<span style="color: #339933;"># If the latter, either tell valgrind about it each time with --suppressions=&lt;filename&gt;, or add that line to ~/.valgrindrc</span>
&nbsp;
<span style="color: #339933;"># NB This script uses the |&amp; operator, which I believe is gawk-specific. In case of failure, check that you're using gawk rather than some other awk</span>
&nbsp;
<span style="color: #339933;"># The script looks for suppressions. When it finds one it stores it temporarily in an array,</span>
<span style="color: #339933;"># and also feeds it line by line to the external app 'md5sum' which generates a unique checksum for it.</span>
<span style="color: #339933;"># The checksum is used as an index in a different array. If an item with that index already exists the suppression must be a duplicate and is discarded.</span>
&nbsp;
BEGIN <span style="color: #478F47;">&#123;</span> suppression=<span style="color: #8F478F;">0</span>; md5sum = <span style="color: #ff0000;">"md5sum"</span> <span style="color: #478F47;">&#125;</span>
  <span style="color: #339933;"># If the line begins with '{', it's the start of a supression; so set the var and initialise things</span>
  /^<span style="color: #478F47;">&#123;</span>/  <span style="color: #478F47;">&#123;</span>
           suppression=<span style="color: #8F478F;">1</span>;  i=<span style="color: #8F478F;">0</span>; next 
        <span style="color: #478F47;">&#125;</span>
  <span style="color: #339933;"># If the line begins with '}' its the end of a suppression</span>
  /^<span style="color: #478F47;">&#125;</span>/  <span style="color: #478F47;">&#123;</span>
          <span style="color: #7C7C00;">if</span> <span style="color: #478F47;">&#40;</span>suppression<span style="color: #478F47;">&#41;</span>
           <span style="color: #478F47;">&#123;</span> suppression=<span style="color: #8F478F;">0</span>;
             close<span style="color: #478F47;">&#40;</span>md5sum, <span style="color: #ff0000;">"to"</span><span style="color: #478F47;">&#41;</span>  <span style="color: #339933;"># We've finished sending data to md5sum, so close that part of the pipe</span>
             ProcessInput<span style="color: #478F47;">&#40;</span><span style="color: #478F47;">&#41;</span>       <span style="color: #339933;"># Do the slightly-complicated stuff in functions</span>
             delete supparray     <span style="color: #339933;"># We don't want subsequent suppressions to append to it!</span>
           <span style="color: #478F47;">&#125;</span>
     <span style="color: #478F47;">&#125;</span>
  <span style="color: #339933;"># Otherwise, it's a normal line. If we're inside a supression, store it, and pipe it to md5sum. Otherwise it's cruft, so ignore it</span>
     <span style="color: #478F47;">&#123;</span> <span style="color: #7C7C00;">if</span> <span style="color: #478F47;">&#40;</span>suppression<span style="color: #478F47;">&#41;</span>
         <span style="color: #478F47;">&#123;</span> 
            supparray<span style="color: #478F47;">&#91;</span>++i<span style="color: #478F47;">&#93;</span> = $<span style="color: #8F478F;">0</span>
            print |&amp; md5sum
         <span style="color: #478F47;">&#125;</span>
     <span style="color: #478F47;">&#125;</span>
&nbsp;
&nbsp;
 <span style="color: #000000; font-weight: bold;">function</span> ProcessInput<span style="color: #478F47;">&#40;</span><span style="color: #478F47;">&#41;</span>
 <span style="color: #478F47;">&#123;</span>
    <span style="color: #339933;"># Pipe the result from md5sum, then close it     </span>
    md5sum |&amp; getline result
    close<span style="color: #478F47;">&#40;</span>md5sum<span style="color: #478F47;">&#41;</span>
    <span style="color: #339933;"># gawk can't cope with enormous ints like $result would be, so stringify it first by prefixing a definite string</span>
    resultstring = <span style="color: #ff0000;">"prefix"</span>result
&nbsp;
    <span style="color: #7C7C00;">if</span> <span style="color: #478F47;">&#40;</span>! <span style="color: #478F47;">&#40;</span>resultstring in chksum_array<span style="color: #478F47;">&#41;</span> <span style="color: #478F47;">&#41;</span>
      <span style="color: #478F47;">&#123;</span> chksum_array<span style="color: #478F47;">&#91;</span>resultstring<span style="color: #478F47;">&#93;</span> = <span style="color: #8F478F;">0</span>;  <span style="color: #339933;"># This checksum hasn't been seen before, so add it to the array</span>
        OutputSuppression<span style="color: #478F47;">&#40;</span><span style="color: #478F47;">&#41;</span>              <span style="color: #339933;"># and output the contents of the suppression</span>
      <span style="color: #478F47;">&#125;</span>
 <span style="color: #478F47;">&#125;</span>
&nbsp;
 <span style="color: #000000; font-weight: bold;">function</span> OutputSuppression<span style="color: #478F47;">&#40;</span><span style="color: #478F47;">&#41;</span>
 <span style="color: #478F47;">&#123;</span>
  <span style="color: #339933;"># A suppression is surrounded by '{' and '}'. Its data was stored line by line in the array  </span>
  print <span style="color: #ff0000;">"{"</span>  
  <span style="color: #7C7C00;">for</span> <span style="color: #478F47;">&#40;</span>n=<span style="color: #8F478F;">1</span>; n &lt;= i; ++n<span style="color: #478F47;">&#41;</span>
    <span style="color: #478F47;">&#123;</span> print supparray<span style="color: #478F47;">&#91;</span>n<span style="color: #478F47;">&#93;</span> <span style="color: #478F47;">&#125;</span>
  print <span style="color: #ff0000;">"}"</span> 
 <span style="color: #478F47;">&#125;</span></pre></div>

<!-- 
NewPP limit report
Preprocessor node count: 4/1000000
Post-expand include size: 0/2097152 bytes
Template argument size: 0/2097152 bytes
Expensive parser function count: 0/100
-->

<!-- Saved in parser cache with key wx_wiki-wxwiki_:pcache:idhash:2469-0!1!0!!en!2!edit=0 and timestamp 20130822092750 -->
<div class="printfooter">
Retrieved from "<a href="http://wiki.wxwidgets.org/Parse_valgrind_suppressions.sh">http://wiki.wxwidgets.org/Parse_valgrind_suppressions.sh</a>"</div>
		<div id='catlinks' class='catlinks catlinks-allhidden'></div>		<!-- end content -->
				<div class="visualClear"></div>
	</div>
</div></div>
<div id="column-one">
	<div id="p-cactions" class="portlet">
		<h5>Views</h5>
		<div class="pBody">
			<ul>
				 <li id="ca-nstab-main" class="selected"><a href="/Parse_valgrind_suppressions.sh" title="View the content page [c]" accesskey="c">Page</a></li>
				 <li id="ca-talk" class="new"><a href="/index.php?title=Talk:Parse_valgrind_suppressions.sh&amp;action=edit&amp;redlink=1" title="Discussion about the content page [t]" accesskey="t">Discussion</a></li>
				 <li id="ca-viewsource"><a href="/index.php?title=Parse_valgrind_suppressions.sh&amp;action=edit" title="This page is protected.&#10;You can view its source [e]" accesskey="e">View source</a></li>
				 <li id="ca-history"><a href="/index.php?title=Parse_valgrind_suppressions.sh&amp;action=history" title="Past revisions of this page [h]" accesskey="h">History</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-personal">
		<h5>Personal tools</h5>
		<div class="pBody">
			<ul>
				<li id="pt-login"><a href="/index.php?title=Special:UserLogin&amp;returnto=Parse_valgrind_suppressions.sh" title="You are encouraged to log in; however, it is not mandatory [o]" accesskey="o">Log in / create account</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-logo">
		<a style="background-image: url(/skins/common/images/wiki.png);" href="/Main_Page" title="Visit the main page"></a>
	</div>
	<script type="text/javascript"> if (window.isMSIE55) fixalpha(); </script>
	<div class='generated-sidebar portlet' id='p-wiki'>
		<h5>wiki</h5>
		<div class='pBody'>
			<ul>
				<li id="n-Main-Page"><a href="/Main_Page">Main Page</a></li>
				<li id="n-General-Information"><a href="/General_Information">General Information</a></li>
				<li id="n-Tools"><a href="/Tools">Tools</a></li>
				<li id="n-Resources"><a href="/Resources">Resources</a></li>
				<li id="n-Guides-and-Tutorials"><a href="/Guides_%26_Tutorials">Guides and Tutorials</a></li>
				<li id="n-Documentation"><a href="/Documentation">Documentation</a></li>
				<li id="n-Development"><a href="/Development">Development</a></li>
				<li id="n-Recent-Changes"><a href="/Special:RecentChanges">Recent Changes</a></li>
			</ul>
		</div>
	</div>
	<div class='generated-sidebar portlet' id='p-other_resources'>
		<h5>other resources</h5>
		<div class='pBody'>
			<ul>
				<li id="n-wxWidgets-Home"><a href="http://www.wxwidgets.org/">wxWidgets Home</a></li>
				<li id="n-Official-Documentation"><a href="http://www.wxwidgets.org/docs/">Official Documentation</a></li>
				<li id="n-Mailing-Lists"><a href="http://www.wxwidgets.org/support/maillst2.htm">Mailing Lists</a></li>
				<li id="n-Forums"><a href="http://forums.wxwidgets.org/">Forums</a></li>
				<li id="n-Internet-Relay-Chat"><a href="/IRC">Internet Relay Chat</a></li>
				<li id="n-Donations"><a href="http://www.wxwidgets.org/support/spi.htm">Donations</a></li>
			</ul>
		</div>
	</div>
	<div id="p-search" class="portlet">
		<h5><label for="searchInput">Search</label></h5>
		<div id="searchBody" class="pBody">
			<form action="/index.php" id="searchform">
				<input type='hidden' name="title" value="Special:Search"/>
				<input id="searchInput" title="Search WxWiki" accesskey="f" type="search" name="search" />
				<input type='submit' name="go" class="searchButton" id="searchGoButton"	value="Go" title="Go to a page with this exact name if exists" />&nbsp;
				<input type='submit' name="fulltext" class="searchButton" id="mw-searchButton" value="Search" title="Search the pages for this text" />
			</form>
		</div>
	</div>
	<div class="portlet" id="p-tb">
		<h5>Toolbox</h5>
		<div class="pBody">
			<ul>
				<li id="t-whatlinkshere"><a href="/Special:WhatLinksHere/Parse_valgrind_suppressions.sh" title="List of all wiki pages that link here [j]" accesskey="j">What links here</a></li>
				<li id="t-recentchangeslinked"><a href="/Special:RecentChangesLinked/Parse_valgrind_suppressions.sh" title="Recent changes in pages linked from this page [k]" accesskey="k">Related changes</a></li>
<li id="t-specialpages"><a href="/Special:SpecialPages" title="List of all special pages [q]" accesskey="q">Special pages</a></li>
				<li id="t-print"><a href="/index.php?title=Parse_valgrind_suppressions.sh&amp;printable=yes" rel="alternate" title="Printable version of this page [p]" accesskey="p">Printable version</a></li>				<li id="t-permalink"><a href="/index.php?title=Parse_valgrind_suppressions.sh&amp;oldid=7962" title="Permanent link to this revision of the page">Permanent link</a></li>			</ul>
		</div>
	</div>
</div><!-- end of the left (by default at least) column -->
<div class="visualClear"></div>
<div id="footer">
	<div id="f-poweredbyico"><a href="http://www.mediawiki.org/"><img src="/skins/common/images/poweredby_mediawiki_88x31.png" height="31" width="88" alt="Powered by MediaWiki" /></a></div>
	<ul id="f-list">
		<li id="lastmod"> This page was last modified on 17 August 2010, at 21:54.</li>
		<li id="viewcount">This page has been accessed 5,594 times.</li>
		<li id="privacy"><a href="/WxWiki:Privacy_policy" title="WxWiki:Privacy policy">Privacy policy</a></li>
		<li id="about"><a href="/WxWiki:About" title="WxWiki:About">About WxWiki</a></li>
		<li id="disclaimer"><a href="/WxWiki:General_disclaimer" title="WxWiki:General disclaimer">Disclaimers</a></li>
	</ul>
</div>
</div>

<script>if (window.runOnloadHook) runOnloadHook();</script>

<script type="text/javascript">
	var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
	document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
	var pageTracker = _gat._getTracker("UA-794025-3");
	pageTracker._initData();
	pageTracker._trackPageview();
</script>

<!-- Served in 0.173 secs. --></body></html>
