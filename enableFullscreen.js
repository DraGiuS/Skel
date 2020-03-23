const fullscreenControl = document.querySelector("#video-fullscreen-button");

function show() {
  fullscreenControl.style.display = ""
  fullscreenControl.disabled = false
}
setInterval(() => {
  show()
}, 1000)