/* jshint maxparams: false */
/* global exports, XMLHttpRequest */
"use strict";

// module Audio.WebAudio.AudioContext

exports.makeAudioContext = function() {
  return new (window.AudioContext || window.webkitAudioContext)();
};


exports.createOscillator = function(ctx) {
  return function() {
    return ctx.createOscillator();
  };
};



exports.createGain = function(ctx) {
  return function() {
    return ctx.createGain();
  };
};

exports.createMediaElementSource = function(ctx) {
  return function(elt) {
    return function() {
      return ctx.createMediaElementSource(elt);
    };
  };
};

exports.currentTime = function(cx) {
  return function() {
    return cx.currentTime;
  };
};

exports.decodeAudioData = function(cx) {
  return function(audioData) {
    return function(cb) {
      return function() {
        cx.decodeAudioData(audioData,
          function(data) {
            cb(new PS.Data_Maybe.Just(data))(); },
          function() {
            cb(PS.Data_Maybe.Nothing.value)(); });
      };
    };
  };
};

exports.createBufferSource = function(cx) {
  return function() {
    return cx.createBufferSource();
  };
};



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



