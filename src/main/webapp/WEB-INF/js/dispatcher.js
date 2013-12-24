(function(w, d, ls) {
  'use strict';

  var body = d.body;

  // fire "clicks" for desktop
  if (!('ontouchend' in window)) {
    body.addEventListener('click', function(e){
      $(e.target).trigger('tap');
      e.preventDefault();
    });
   }

  $('body').tap(function(e){
    var target = e.target,
        id,
        fireEvent;

    id = ls.data(target).get('el').split('.');

    if (id && (fireEvent = ls.fn[id[0]][id[1]])) {
      fireEvent(target);
    }

  });

  $('body').swipe(function(e){
    var target = e.target;
    console.log(target);
  });

}(window, document, window.ls));