"use strict";

exports.maybeFn = function (nothing, just, a) {
  return a == null ? nothing : just(a);
};

exports.makeXMLHttpRequest = function () {
  return new XMLHttpRequest();
};

exports.unsafeOpen = function (obj, method, url) {
  return function () {
    obj.open(method, url);
    return {};
  };
};

exports.unsafeResponseType = function (obj) {
  return function () {
    return obj.responseType;
  };
};

exports.unsafeSetResponseType = function (obj, rt) {
  return function () {
    obj.responseType = rt;
    return {};
  };
};

exports.unsafeResponse = function (obj) {
  return function () {
    return obj.response;
  };
};

exports.unsafeSend = function (obj) {
  return function () {
    obj.send();
    return {};
  };
};

exports.unsafeSendWithPayload = function (obj, payload) {
  return function () {
    obj.send(payload);
    return {};
  };
};

exports.unsafeAddEventListener = function (targ) {
  return function (cb) {
    return function (src) {
      return function () {
        src.addEventListener(targ, function (evt) {
          cb(evt)();
        });
      };
    };
  };
};

exports.unsafeEventTarget = function (event) {
  return function () {
    return event.target;
  };
};

exports.unsafeEventProp = function (prop) {
  return function (event) {
    return function () {
      return event[prop];
    };
  };
};
