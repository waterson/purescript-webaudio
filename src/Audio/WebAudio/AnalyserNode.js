"use strict";

exports.getFloatFrequencyData = function(analyserNode) {
  return function(dataArray) {
    return function() {
      return analyserNode.getFloatFrequencyata(dataArray);
    };
  };
};

exports.getByteFrequencyData = function(analyserNode) {
  return function(dataArray) {
    return function() {
      return analyserNode.getByteFrequencyata(dataArray);
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
