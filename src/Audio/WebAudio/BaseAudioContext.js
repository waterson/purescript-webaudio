/* jshint maxparams: false */
/* global exports, XMLHttpRequest */
"use strict";

// module Audio.WebAudio.AudioContext

exports.sampleRate = function(cx) {
  return function() {
    return cx.sampleRate;
  };
};

exports.currentTime = function(cx) {
  return function() {
    return cx.currentTime;
  };
};

exports.stateImpl = function(ctx) {
  return function() {
    return ctx.state;
  };
};

exports.suspend = function(ctx) {
  return function() {
    return ctx.suspend();
  };
};

exports.resume = function(ctx) {
  return function() {
    return ctx.resume();
  };
};

exports.decodeAudioData = function(cx) {
  return function(audioData) {
    return function(success) {
      return function(failure) {
        return function() {
          cx.decodeAudioData(audioData,
            function(data) {
              success(data)();
            },
            function(e) {
              failure(e.err);
            });
        };
      };
    };
  };
};

exports.createBufferSource = function(cx) {
  return function() {
    return cx.createBufferSource();
  };
};

exports.createGain = function(ctx) {
  return function() {
    return ctx.createGain();
  };
};

exports.createOscillator = function(ctx) {
  return function() {
    return ctx.createOscillator();
  };
};

exports.newAudioContext = function() {
  return new (window.AudioContext || window.webkitAudioContext)();
};
