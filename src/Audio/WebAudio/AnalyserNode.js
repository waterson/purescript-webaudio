"use strict";

exports.getFloatFrequencyData = function(analyserNode) {
  return function(dataArray) {
    return function() {
      return analyserNode.getFloatFrequencyData(dataArray);
    };
  };
};

exports.getByteFrequencyData = function(analyserNode) {
  return function(dataArray) {
    return function() {
      return analyserNode.getByteFrequencyData(dataArray);
    };
  };
};

exports.getFloatTimeDomainData = function(analyserNode) {
  return function(dataArray) {
    return function() {
      return analyserNode.getFloatTimeDomainData(dataArray);
    };
  };
};

exports.getByteTimeDomainData = function(analyserNode) {
  return function(dataArray) {
    return function() {
      return analyserNode.getByteTimeDomainData(dataArray);
    };
  };
};
