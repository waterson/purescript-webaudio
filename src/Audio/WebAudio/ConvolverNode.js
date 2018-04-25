/* jshint maxparams: false */
/* global exports, XMLHttpRequest */
"use strict";

// module Audio.WebAudio.ConvolverNode


exports.setBuffer = function(buf) {
  return function(src) {
    return function() {
      src.buffer = buf;
    };
  };
};
