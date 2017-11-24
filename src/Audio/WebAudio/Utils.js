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

exports.unsafeConnectParam = function(_) {
  return function(_) {
    return function(source) {
      return function(target) {
        return function(prop) {
          return function() {
            var value = target[prop];
            source.connect(value);
          };
        };
      };
    };
  };
};
