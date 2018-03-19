"use strict";


exports.nodeConnect = function(_) {
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

exports.nodeDisconnect = function(_) {
  return function(_) {
    return function(source) {
      return function(sink) {
        return function() {
          source.disconnect(sink);
        };
      };
    };
  };
};

exports.unsafeConnectParam = function(_) {
  return function(_) {
    return function(source) {
      return function(target) {
        return function(prop) {
          return function() {
            var value = target[prop];
            source.connect(value);
          };
        };
      };
    };
  };
};
