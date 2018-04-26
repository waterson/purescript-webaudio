/* jshint maxparams: false */
/* global exports, XMLHttpRequest */
"use strict";

// module Audio.WebAudio.DynamicsCompressorNode

exports.threshold = function(node) {
  return function() {
    return node.threshold;
  };
};

exports.knee = function(node) {
  return function() {
    return node.knee;
  };
};

exports.ratio = function(node) {
  return function() {
    return node.ratio;
  };
};

exports.attack = function(node) {
  return function() {
    return node.attack;
  };
};

exports.release = function(node) {
  return function() {
    return node.release;
  };
};
