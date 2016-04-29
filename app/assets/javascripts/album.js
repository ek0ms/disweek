<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script>
$(document).ready(function()
{

$('body').on("click",'.heart',function()
  {

    var A=$(this).attr("id");
    var B=A.split("like");
      var messageID=B[1];
      var C=parseInt($("#likeCount"+messageID).html());
    $(this).css("background-position","")
      var D=$(this).attr("rel");

      if(D === 'like')
      {
      $("#likeCount"+messageID).html(C+1);
      $(this).addClass("heartAnimation").attr("rel","unlike");

      }
      else
      {
      $("#likeCount"+messageID).html(C-1);
      $(this).removeClass("heartAnimation").attr("rel","like");
      $(this).css("background-position","left");
      }


  });


});
</script>
