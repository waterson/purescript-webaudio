/* jshint maxparams: false */
/* global exports, XMLHttpRequest */
"use strict";

// module Audio.WebAudio.StereoPannerNode

exports.pan = function(node) {
  return function() {
    return node.pan;
  };
};
