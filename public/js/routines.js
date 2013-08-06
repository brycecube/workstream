(function(w, d, ls) {
  'use strict';

  ls.fn.routine = (function() {

    function showHideRoutine(target) {
      if (ls.data(target).get('active')) {
        target.className = target.className.replace(/\sactive/,'');
        ls.data(target).remove('active');
      } else {
        target.className += ' active';
        ls.data(target).set('active', 'active');
      }
    }

    return {
      showHideRoutine: showHideRoutine
    };

  }());

}(window, document, window.ls));