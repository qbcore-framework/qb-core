window.addEventListener('message', function (event) {
    switch(event.data.action) {
        case 'show':
            ShowNotif(event.data);
            break;
        default:
            ShowNotif(event.data);
            break;
    }
});

function ShowNotif(data) {
    var $notification = $('.notification.template').clone();
    $notification.removeClass('template');
    $notification.addClass(data.type);
    $notification.html(data.text);
    $notification.fadeIn();
    $('.notif-container').prepend($notification);
    setTimeout(function() {
        $.when($notification.fadeOut(1500)).done(function() {
            $notification.remove()
        });
    }, data.length != null ? data.length : 2500);
}