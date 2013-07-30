(function(w, d) {
  'use strict';

  var body = d.body;

  var evtDel = {
    'routine': ls.routine.openRoutine
  };

  // fire "clicks" for desktop
  if (!('ontouchend' in window)) {
    body.addEventListener('click', function(e){
      $(e.target).trigger('tap');
    });
   }

  $('body').tap(function(e){
    var target = e.target,
        id,
        fireEvent;

    if ((id = target.getAttribute('data-el')) && (fireEvent = evtDel[id])) {
      fireEvent(target);
    }

  });

  $('body').swipe(function(e){
    var target = e.target;
    console.log(target);
  });

}(window, document));