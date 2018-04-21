/* jshint maxparams: false */
/* global exports, XMLHttpRequest */
"use strict";

// module Audio.WebAudio.AudioContext

exports.createMediaElementSource = function(ctx) {
  return function(elt) {
    return function() {
      return ctx.createMediaElementSource(elt);
    };
  };
};
