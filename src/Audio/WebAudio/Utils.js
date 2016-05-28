/* jshint maxparams: false */
/* global exports, XMLHttpRequest */
"use strict";

// module Audio.WebAudio.Utils


exports.unsafeSetProp = function(prop) {
  return function(obj) {
    return function(value) {
      return function() {
        obj[prop] = value;
      };
    };
  };
};


exports.unsafeGetProp = function(prop) {
  return function(obj) {
    return function() {
      return obj[prop];
    };
  };
};
