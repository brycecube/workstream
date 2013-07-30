(function(w, d) {
  'use strict';

  w.ls = (function() {
    var dom = {};

    function selectElement(selector) {
      if (!dom[selector])
        dom[selector] = d.querySelectorAll(selector);

      return dom[selector];
    }

    /*
    * This approach is considerably faster than Zepto for mobile devices.
    * http://jsperf.com/data-attribute-set-get-delete-methods/edit
    */
    function data(target) {
      function getData(dataObj) {
        return target.getAttribute('data-' + dataObj);
      }

      function setData(dataObj, value) {
        return target.setAttribute('data-' + dataObj, value);
      }

      function removeData(dataObj) {
        return target.removeAttribute('data-' + dataObj);
      }

      return {
        set: setData,
        get: getData,
        remove: removeData
      }
    }

    function getJSON(url, callback){
      var ajax = new XMLHttpRequest();
      ajax.onreadystatechange = function(){
        if(ajax.readyState === 4 && ajax.status === 200){
          var r = ajax.response;

          // parse to json if "string" json
          if (r.match(/^(\[|\{)/)) {
            r = JSON.parse(r);
          }

          callback(r);
        }
      };

      ajax.open('GET', url, !0);
      ajax.send();
    }

    return {
      $: selectElement,
      data: data,
      ajax: getJSON
    }


  }());

}(window, document));