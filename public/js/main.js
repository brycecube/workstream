(function(w, d, ls) {
  'use strict';

  ls.fn.main = (function() {

    function settings() {
      ls.ajax('/account', function(r){
        console.log(r);
      });
      // show or hide settings
    }

    return {
      settings: settings
    };

  }());

}(window, document, window.ls));

/*

template for iife class

(function(w, d, ls) {
  'use strict';

  ls.fn.namespace = (function() {

    function test() {
      console.log('this is a test');
    }

    return {
      test: test
    };

  }());


}(window, document, window.ls));

*/