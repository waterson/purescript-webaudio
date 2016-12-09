/* jshint maxparams: false */
/* global exports, XMLHttpRequest */
"use strict";

// module Audio.WebAudio.Oscillator

exports.startOscillator = function(when) {
  return function(n) {
    return function() {
      return n[n.start ? 'start' : 'noteOn'](when);
    };
  };
};


exports.stopOscillator = function(when) {
  return function(n) {
    return function() {
      return n[n.stop ? 'stop' : 'noteOff'](when);
    };
  };
};
