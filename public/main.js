// Initial data passed to Elm (should match `Flags` defined in `Shared.elm`)
// https://guide.elm-lang.org/interop/flags.html
var flags = null

// Start our Elm application
var app = Elm.Main.init({ flags: flags })
var video;
let photo;
let canvas;

    app.ports.startCamera.subscribe(function() { 
    video = document.querySelector("#videoElement");

    if (navigator.mediaDevices.getUserMedia) {
        navigator.mediaDevices.getUserMedia({ video: true })
        .then(function (stream) {
            video.srcObject = stream;
        })
        .catch(function (err0r) {
            console.log("Something went wrong!");
        });
    }
});

app.ports.takePicture.subscribe(function() { 
    photo = document.getElementById('photo');
    canvas = document.getElementById('canvas');
    var context = canvas.getContext('2d');
    canvas.width = 500;
    canvas.height = 375;
    context.drawImage(video, 0, 0, 500, 375);

    var data = canvas.toDataURL('image/png');
    photo.setAttribute('src', data);
});

app.ports.clearPicture.subscribe(function() { 
    var context = canvas.getContext('2d');
    context.fillStyle = "#fff";
    context.fillRect(0, 0, canvas.width, canvas.height);

    var data = canvas.toDataURL('image/png');
    photo.setAttribute('src', data);
})
