(function(w, d) {
  'use strict';

  w.ls.routine = (function() {

    function openRoutine(target) {
      if (ls.data(target).get('active')) {
        target.className = target.className.replace(/\sactive/,'');
        ls.data(target).remove('active');
      } else {
        target.className += ' active';
        ls.data(target).set('active', 'active');
      }
    }

    return {
      openRoutine: openRoutine
    }
  }());


}(window, document));