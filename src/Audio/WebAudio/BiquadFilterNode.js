"use strict";

// module Audio.WebAudio.BiquadFilterNode

exports.gain = function(node) {
  return function() {
    return node.gain;
  };
};
