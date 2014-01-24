var webrtc_capable = true,
    rtc_peer_connnection = mozRTCPeerConnection,
    rtc_session_description = mozRTCSessionDescription,
    get_user_media = navigator.mozGetUserMedia,
    connect_stream_to_rtc = null,
    stun_server = "stun.l.google.com:19302";

connect_stream_to_src = function(media_stream, media_element) {
    media_element.srcObject = media_stream;
    media_element.play();
};
