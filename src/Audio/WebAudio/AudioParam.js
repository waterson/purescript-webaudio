/* jshint maxparams: false */
/* global exports, XMLHttpRequest */
"use strict";

// module Audio.WebAudio.AudioParam

exports.setValue = function(value) {
  return function(param) {
    return function() {
      param.value = value;
    };
  };
};


exports.getValue = function(param) {
  return function() {
    return param.value;
  };
};


exports.setValueAtTime = function(value) {
  return function(startTime) {
    return function(param) {
      return function() {
        param.setValueAtTime(value, startTime);
      };
    };
  };
};

exports.setTargetAtTime = function(value) {
  return function(startTime) {
    return function(timeConstant) {
      return function(param) {
        return function() {
          param.setTargetAtTime(value, startTime, timeConstant);
        };
      };
    };
  };
};


exports.linearRampToValueAtTime = function(value) {
  return function(endTime) {
    return function(param) {
      return function() {
        param.linearRampToValueAtTime(value, endTime);
      };
    };
  };
};


exports.exponentialRampToValueAtTime = function(value) {
  return function(endTime) {
    return function(param) {
      return function() {
        param.exponentialRampToValueAtTime(value, endTime);
      };
    };
  };
};


exports.cancelScheduledValues = function(startTime) {
  return function(param) {
    return function() {
      param.cancelScheduledValues(startTime);
    };
  };
};
