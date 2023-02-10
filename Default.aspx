<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

</head>
<body>
   
    <form id="form1" runat="server">
        <style>
            @font-face {
                font-family: Pixel;
                src: url(font/Pixel.ttf);
            }

            .score{
                position:absolute;
                top:10%;
                left:70%;
            }
            .scoremid {
                position: absolute;
                top: 47%;
                width:100%;
                color: white;
            }



            body {
                background-color: black;
                color: white;
                font-family: Pixel;
                font-size: 15px;
                margin: 0;
                padding: 0;
                height: 100%;
            }
            input {
                border: 0;
                border-bottom: 1px solid #555;
                background: transparent;
                width: 100%;
                padding: 8px 0 5px 0;
                font-size: 16px;
                color: #fff;
                text-align:center;
            }



                input:focus {
                    border: none;
                    outline: none;
                    border-bottom: 1px solid #e74c3c;
                     text-align:center;
                }

                #btnSubmit{
                border:groove;
                width: 100%;
                font-size: 16px;
                text-align:center;
                }

                #btnSubmit:hover{
                border:groove;
                background-color:yellow;
                color:black;
                }


            #dvStart {
                position: absolute;
                top: 0;
                bottom: 0;
                left: 0;
                right: 0;
                margin: auto;
                background-color: black;
                border: dashed;
                border-color: yellow;
                width: 500px;
                height: 200px;
            }

            .footer {
                position: fixed;
                left: 0;
                bottom: 0;
                width: 100%;
                color: white;
                text-align: center;
            }

            @media screen and (max-width: 500px) {
  
            #dvStart{
                width: 70%;
            }
        }
       

        </style>


        <div id="dvStart" style="display:none">
           <div align="center">HOW TO PLAY</div>
           <p>
               A very very simple guess the image game. A pixelated image will be shown and as the time passes by the blurred/pixelated image will become more clear.
               Your objective is to guess the answer (or name) as quickly as possible. When you're ready click START to begin. Good Luck!
           </p>
            <input type="button" id="btnStart" value="Start" class="btn-warning" />
        </div>

       

        <div align="center" id="dvPlay" style="display:none">
        <div style="display:none">Speed:<span id="spnSpeed"></span></div>
        <div>Time:<span id="spnTime"></span></div>
            <asp:HiddenField runat="server" ID="hdnValueResult" />
                        <asp:HiddenField runat="server" ID="hdnValueID" />

            


        <canvas id="canvas" style="width:50%; height:65%;"></canvas>
            <br />
            <table style="width:35%;">
                <tr>
                    <td align="center"><input type="text" id="txtAnswer" placeholder="Your Answer" width="400px" /><br /><br /><span id="spnWrong" style="display:none" class="label label-danger">Wrong!</span><span id="spnRight" style="display:none" class="label label-success">Correct!</span>
                        <br /><input type="button" style="width:50%" id="btnSubmit" class="btn-primary" value="Submit" />
                        <br />
                        <span id="spnMessage"></span>
                    </td>
                    </tr>
                <tr><td>&nbsp;</td></tr>
            
            </table>
          
                       
    </div>

        <div id="dvScore" align="center" class="footer" style="display:none;">
            <table class="table table-bordered">
                <tr>
                    <td style="background-color:Yellow;color:black">Stats</td>
                    <td>Image:<span id="spnPictureNumber"></span></td>
                    <td>Total Time:<span id="spnTimeTaken"></span></td>

                </tr>
            </table>
        </div>

          <script>
              var canvas = document.getElementById('canvas');
              var ctx = canvas.getContext('2d');

              // Create an image element
              var img = new Image();

              window.mobileCheck = function () {
                  let check = false;
                  (function (a) { if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))) check = true; })(navigator.userAgent || navigator.vendor || window.opera);
                  return check;
              };

              if (window.mobileCheck()) {
                  if (window.innerHeight > window.innerWidth) {
                      $('#canvas').css("width", "95%");
                      $('#canvas').css("height", "60%");

                  }
                  else {
                      $('#canvas').css("width", "50%");
                      $('#canvas').css("height", "50%");

                  }

              }


              $(document).ready(function () {


                  $('#btnStart').click(function () {
                      $('#dvScore').show();
                      $('#dvPlay').show();
                      $('#dvStart').hide();
                      $('#spnTime').html(1);
                  });

                  getData();

                  $("#btnSubmit").click(function () {
                      var answer = $('#hdnValueResult').val();
                      if ($('#txtAnswer').val().toLowerCase() == answer.toLowerCase()) {
                          $('#spnRight').show().fadeOut(2500);
                          saveData();
                          setTimeout(
                              function () {
                                  getData();
                              }, 1500);
                      }
                      else {
                          $('#spnWrong').show().fadeOut(5000);
                      }
                      $('#txtAnswer').val('');
                  });

              });

              function getData() {
                  $.ajax({
                      type: "POST",
                      url: "Default.aspx/GetData",
                      data: JSON.stringify(),
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (r) {
                          var result = r.d;

                          var id = result.split(';')[0];
                          var image = result.split(';')[1];
                          var answer = result.split(';')[2];
                          var TimeTaken = result.split(';')[3];
                          var SavedID = result.split(';')[4];
                          $('#hdnValueResult').val(answer);
                          $('#hdnValueID').val(id);
                          //display result
                          $('#spnTimeTaken').html(TimeTaken + ' s');
                          $('#spnPictureNumber').html(id + '/10');
                          //display result

                          if (SavedID < 10 && SavedID > 0) {
                              draw(image);
                              $('#dvPlay').show();
                              $('#dvScore').show();
                          }
                          else if (SavedID == 0) {
                              draw(image);
                              $('#dvPlay').hide();
                              $('#dvScore').hide();
                              $('#dvStart').show();
                          }
                          else {
                              $('#dvPlay').hide();
                              $('#dvScore').show();
                              $('#dvScore').removeClass('footer');
                              $('#dvScore').addClass('scoremid');
                              clearInterval(intervalTimer);
                          }

                      }
                  });
                  return false;
              }

              function saveData() {
                  var id = $('#hdnValueID').val();
                  var time = $('#spnTime').html();
                  $.ajax({
                      type: "POST",
                      url: "Default.aspx/SaveData",
                      data: '{id: ' + JSON.stringify(id) + ',time: ' + JSON.stringify(time) + '}',
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (response) {
                          //  alert("Saved");
                          // window.location.reload();
                      }
                  });


                  return false;


              }

              var intervalTimer;
              //takes any image URL and creates an un pixelated image /4 the orginal size of the image
              function draw(imgURL) {
                  // Specify the src to load the image
                  clearInterval(intervalTimer);
                  img.crossOrigin = "anonymous";
                  img.src = imgURL;

                  img.onload = function () {
                      canvas.height = img.height / 4;
                      canvas.width = img.width / 4;
                      //ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
                      var speed = 1;
                      var timer = 1;
                      intervalTimer = setInterval(function () {
                          speed += 0.5;
                          timer += 1;
                          $('#spnTime').html(timer);
                          $('#spnSpeed').html(speed);
                          pixelate(speed);
                          if (speed >= 100)
                              clearInterval(intervalTimer);
                      }, 1000);
                  };
              }

              function pixelate(speed) {
                  //dynamically adjust canvas size to the size of the uploaded image
                  canvas.height = img.height;
                  canvas.width = img.width;

                  /// if in play mode use that value, else use slider value
                  var size = speed * 0.01,

                      /// cache scaled width and height
                      w = canvas.width * size,
                      h = canvas.height * size;

                  /// draw original image to the scaled size
                  ctx.drawImage(img, 0, 0, w, h);

                  /// then draw that scaled image thumb back to fill canvas
                  /// As smoothing is off the result will be pixelated
                  ctx.mozImageSmoothingEnabled = false;
                  ctx.imageSmoothingEnabled = false;
                  ctx.drawImage(canvas, 0, 0, w, h, 0, 0, canvas.width, canvas.height);
              }
          </script>


    </form>
</body>
</html>
