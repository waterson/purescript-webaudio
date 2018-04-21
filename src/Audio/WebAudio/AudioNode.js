/* jshint maxparams: false */
/* global exports, XMLHttpRequest */
"use strict";

// module Audio.WebAudio.AudioNode

exports.connect = function(_) {
  return function(_) {
    return function(source) {
      return function(sink) {
        return function() {
          source.connect(sink);
        };
      };
    };
  };
};


exports.disconnect = function(_) {
  return function(_) {
    return function(source) {
      return function(sink) {
        return function() {
          source.disconnect(sink);
        };
      };
    };
  };
};
