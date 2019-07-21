xquery version "1.0-ml";

import module namespace search = "http://marklogic.com/appservices/search" at "/MarkLogic/appservices/search/search.xqy";
import module namespace alert = "http://marklogic.com/xdmp/alert" at "/MarkLogic/alert.xqy";

declare namespace ns = "http://www.w3.org/1999/xhtml";
declare variable $ascending := 1;
	declare variable $asc := 1;
	declare variable $desc := 2;


declare function local:result-controller()
{
	(: xdmp:get-request-field("orderby1")) :)
	
	(: if(xdmp:get-request-field('orderby') eq "ascending") :)
		(: then  :)
			(: $ascending := $asc :)
		(: else $ascending := $desc :)

	if(xdmp:get-request-field("term")) 
		then
			local:search-results($ascending)
		else local:default-results($ascending)
};

declare function local:default-results($vl)
{
   (for $doc in fn:doc()
	order by 
	(: ($doc/PLAY/TITLE) descending :)
	if ($vl eq 1) then ($doc/PLAY/TITLE) else () ascending,
  	if ($vl eq 2) then () else ($doc/PLAY/TITLE) descending
	return <div class="result-item">
				<span class="article-heading">
					<h3>
					{$doc/PLAY/TITLE/text()},
					</h3>
				</span>
				<span class="article-subtitle">
					{$doc/PLAY/PLAYSUBT/text()},
				</span>
				<div class="article-scene">
					{$doc/PLAY/ACT[1]/SCENE[1]/TITLE/text()}
				</div>
				<div class="article-stagedir">
					{$doc/PLAY/ACT[1]/SCENE[1]/STAGEDIR/text()}
				</div>
				
			</div>) 
};


declare function local:search-results($vl)
{
	for $result in search:search(xdmp:get-request-field("term"))/search:result
	let $uri := fn:string($result/@uri)
    let $doc := fn:doc($uri)
	return <div class="result-item">
				<span class="article-heading">
					<h3>
					{$doc/PLAY/TITLE/text()},
					</h3>
				</span>
				{
				for $text in $result/search:snippet/search:match/node() 
				return
					if(fn:node-name($text) eq xs:QName("search:highlight"))
					then <span class="highlight">{$text/text()}</span>
					else ($text, " ")
				}
			</div>
};

xdmp:set-response-content-type("text/html; charset=utf-8"),
<html>
<head>
<title>Shakespeare&apos;s Plays</title>
<link href="boilerplate.css" rel="stylesheet" type="text/css"/>
<link href="fluid.css" rel="stylesheet" type="text/css"/>
<link href="shakplays.css" rel="stylesheet" type="text/css"/>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	
</head>
<body>
	<div class="gridContainer clearfix">
      <div class="header"><br/><h1>Shakespeare&apos;s Plays</h1></div>
      <div class="section">
		<div class="main-column">  
			<div id="form">
				<form name="form" method="get" action="index.xqy" id="form">
					<input type="text" class="form-control search-box" name="term" id="term" size="50" value="{xdmp:get-request-field("term")}"/>
					<input type="radio" name="orderby" checked="true" id="orderby1" value="ascending" /> Ascending 
  					<input type="radio" name="orderby" id="orderby2" value="descending"/> Descending
					<input type="submit" class="btn btn-success" name="submitbtn" id="submitbtn" value="search"/>
				</form> 
				<br/>
				{local:result-controller()}
				
			</div>
		</div>
	  </div>
      <div class="footer"><br/><br/><hr/>source articles from <b class="dark-gray">The Plays of William Shakespeare</b><br/><br/></div>
	</div>
</body>
</html>
