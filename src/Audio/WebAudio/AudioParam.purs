module Audio.WebAudio.AudioParam where

import Control.Monad.Eff
import Audio.WebAudio.Types

foreign import setValue
  "function setValue(value) { \n\
  \  return function(param) { \n\
  \    return function() { \n\
  \      param.value = value; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. Number -> AudioParam -> (Eff (wau :: WebAudio | eff) Unit)

foreign import getValue
  "function getValue(param) { \n\
  \  return function() { \n\
  \    return param.value; \n\
  \  }; \n\
  \}" :: forall wau eff. AudioParam -> (Eff (wau :: WebAudio | eff) Number)

foreign import setValueAtTime
  "function setValueAtTime(value) { \n\
  \  return function(startTime) { \n\
  \    return function(param) { \n\
  \      return function() { \n\
  \        param.setValueAtTime(value, startTime); \n\
  \      }; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. Number -> Number -> AudioParam -> (Eff (wau :: WebAudio | eff) Number)

foreign import linearRampToValueAtTime
  "function linearRampToValueAtTime(value) { \n\
  \  return function(endTime) { \n\
  \    return function(param) { \n\
  \      return function() { \n\
  \        param.lienarRampToValueAtTime(value, endTime); \n\
  \      }; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. Number -> Number -> AudioParam -> (Eff (wau :: WebAudio | eff) Number)

foreign import exponentialRampToValueAtTime
  "function exponentialRampToValueAtTime(value) { \n\
  \  return function(endTime) { \n\
  \    return function(param) { \n\
  \      return function() { \n\
  \        param.exponentialRampToValueAtTime(value, endTime); \n\
  \      }; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. Number -> Number -> AudioParam -> (Eff (wau :: WebAudio | eff) Number)

foreign import cancelScheduledValues
  "function cancelScheduledValues(startTime) { \n\
  \  return function(param) { \n\
  \    return function() { \n\
  \      param.cancelScheduledValues(startTime); \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. Number -> AudioParam -> (Eff (wau :: WebAudio | eff) Number)



