<html>
<head>
<title>Uniform Server - TEST2</title>
<link href="main.css" rel="stylesheet" type="text/css">
</head >
<body>
<div id="wrapper">

<div id="header">
<img src="mpg.gif" width="53" height="38" align="absmiddle"> Uniform Server - TEST2
</div>

<div id="content">

<?
//===============================================
//== Check initial page
if (isset($_GET['page'])){
 $new_page = $_GET['page'].".html";

  //== Check book
  if ($_GET['page']== 'book1'){
    //check chapter
    if (isset($_GET['chapter'])){
      //check chapter page
        if (isset($_GET['pg'])){
         $new_page=$_GET['page']."_" . $_GET['chapter']. '_' . $_GET['pg'] . ".html";          
        }
        else{
          $new_page=$_GET['page']."_" . $_GET['chapter']. '.html';
        }
    }
    else{
       $new_page=$_GET['page']. '.html';
    }  
  }
}
else{
 $new_page='home.html';
}
//we have some file does it exist
if (file_exists($new_page)){
 require_once("$new_page"); 
}
else{
 echo "<h1>Page Not Found</h1>";
}

//================================================
?>
</div>

<div id="mainNav">
<div class="mainNav1">
<ul>
<li><a href="index.php?page=home">Home - Intro</a></li>
<li><a href="index.php?page=about">About - Mini Server 1</a></li>
<li><a href="index.php?page=links">Links - Mini Server 2</a></li>
<li><a href="index.php?page=contact">Contact - Mini Server 3</a></li>
</ul>
</div>
<br>
<div class="mainNav1">
<ul>
<li><a href="index.php?page=book1">BOOK1 - Mini Server 4</a></li>
<li><a href="index.php?page=book1&&chapter=chapter1">&nbsp;Chapter 1 - Mini Server 5</a></li>
<li><a href="index.php?page=book1&&chapter=chapter1&&pg=page1">&nbsp;&nbsp;&nbsp;&nbsp;page 1 - Mini Server 6</a></li>
<li><a href="index.php?page=book1&&chapter=chapter1&&pg=page2">&nbsp;&nbsp;&nbsp;&nbsp;page 2 - Mini Server 7</a></li>
<li><a href="index.php?page=book1&&chapter=chapter1&&pg=page3">&nbsp;&nbsp;&nbsp;&nbsp;page 3 - Mini Server 8</a></li>
<li><a href="index.php?page=book1&&chapter=chapter2">&nbsp;Chapter 2 - Mini Server 9</a></li>
<li><a href="index.php?page=book1&&chapter=chapter2&&pg=page1">&nbsp;&nbsp;&nbsp;&nbsp;page 1 - Mini Server 10</a></li>
<li><a href="index.php?page=book1&&chapter=chapter2&&pg=page2">&nbsp;&nbsp;&nbsp;&nbsp;page 2 - Mini Server 11</a></li>
<li><a href="index.php?page=book1&&chapter=chapter2&&pg=page3">&nbsp;&nbsp;&nbsp;&nbsp;page 3 - Mini Server 12</a></li>
</ul>
</div>


</div>

<div id="footer">
•&nbsp;Mini Server 8 | © 2008 The Uniform Server Development Team &nbsp;•
</div>

</div>
</body>
</html>