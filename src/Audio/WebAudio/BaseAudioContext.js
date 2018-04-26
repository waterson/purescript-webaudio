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

exports._state = function(ctx) {
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

/* uncurrried version */
function _decodeAudioData (cx, audioData, onError, onSuccess) {
   cx.decodeAudioData(audioData, function (buff) {
     // console.log('buffer decoded OK ');
     onSuccess(buff);
    },
    function (e) {
      // console.log('buffer decode failed ');
      onError(e.err);
   });
};


exports.decodeAudioDataAsyncImpl = function(cx) {
  return function(audioData) {
    return function (onError, onSuccess) {
       _decodeAudioData (cx, audioData, onError, onSuccess);
       // Return a canceler, which is just another Aff effect.
       return function (cancelError, cancelerError, cancelerSuccess) {
         cancelerSuccess(); // invoke the success callback for the canceler
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

exports.createBiquadFilter = function(ctx) {
  return function() {
    return ctx.createBiquadFilter();
  };
};

exports.createDelay = function(ctx) {
  return function() {
    return ctx.createDelay();
  };
};

exports.createAnalyser = function(ctx) {
  return function() {
    return ctx.createAnalyser();
  };
};

exports.createStereoPanner = function(ctx) {
  return function() {
    return ctx.createStereoPanner();
  };
};

exports.createDynamicsCompressor = function(ctx) {
  return function() {
    return ctx.createDynamicsCompressor();
  };
};

exports.createConvolver = function(ctx) {
  return function() {
    return ctx.createConvolver();
  };
};

exports.newAudioContext = function() {
  return new (window.AudioContext || window.webkitAudioContext)();
};
