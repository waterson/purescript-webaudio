module Audio.WebAudio.Utils where

import Control.Monad.Eff

foreign import unsafeSetProp
  "function unsafeSetProp(prop) { \n\
  \  return function(obj) { \n\
  \    return function(value) { \n\
  \      return function() { \n\
  \        obj[prop] = value; \n\
  \      }; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall obj val eff. String -> obj -> val -> (Eff eff Unit)

foreign import unsafeGetProp
  "function unsafeGetProp(prop) { \n\
  \  return function(obj) { \n\
  \    return function() { \n\
  \      return obj[prop]; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall obj val eff. String -> obj -> (Eff eff val)

