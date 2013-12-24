(function(w, d) {
  'use strict';

  w.ls = (function() {
    var dom = {},
        fn = {};

    function selectElement(selector) {
      if (!dom[selector])
        dom[selector] = d.querySelectorAll(selector);

      return dom[selector];
    }

    /**
     * This approach is considerably faster than Zepto for mobile devices.
     * http://jsperf.com/data-attribute-set-get-delete-methods/edit
     *
     * @constructor
     * @param {HTMLElement} target The html element that targets the object youre fetching data attributes from
     */
    function data(target) {
     /**
      * @param {String} dataObj The data attribute youre attempting to get from the target
      */
      function getData(dataObj) {
        return target.getAttribute('data-' + dataObj);
      }

    /**
     * @param {String} dataObj The data attribute youre attempting to set for the target
     * @param {Whatever} value Value of the data attribute you're setting on the target
     */
      function setData(dataObj, value) {
        return target.setAttribute('data-' + dataObj, value);
      }

    /**
     * @param {String} dataObj The data attribute youre attempting to delete from the target
     */
      function removeData(dataObj) {
        return target.removeAttribute('data-' + dataObj);
      }

      return {
        set: setData,
        get: getData,
        remove: removeData
      };

    }

    function getJSON(url, callback){
      var ajax = new XMLHttpRequest();
      ajax.onreadystatechange = function(){
        if(ajax.readyState === 4 && ajax.status === 200){
          var r = ajax.response;

          // parse to json, if "stringified" json
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
      fn: fn,
      data: data,
      ajax: getJSON
    };

  }());

}(window, document));