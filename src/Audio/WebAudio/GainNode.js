/* jshint maxparams: false */
/* global exports, XMLHttpRequest */
"use strict";

// module Audio.WebAudio.GainNode

exports.gain = function(node) {
  return function() {
    return node.gain;
  };
};

