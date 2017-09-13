module SimpleDom where

-- Ported necessary components from https://github.com/aktowns/purescript-simple-dom
-- to run Test03 only

import Prelude

import Control.Monad.Eff (Eff)
import DOM (DOM)
import Data.ArrayBuffer.Types (ArrayBuffer)
import Data.Function.Uncurried (Fn2, Fn3, Fn1, runFn1, runFn2, runFn3)

type Url = String

data HttpMethod = GET
instance showHttpMethod :: Show HttpMethod where
  show GET = "GET"

data ResponseType = ArrayBuffer | Default
instance showResponseType :: Show ResponseType where
  show ArrayBuffer = "arraybuffer"
  show Default = ""

data ProgressEventType = ProgressLoadEvent
instance showProgressEventType :: Show ProgressEventType where
    show ProgressLoadEvent = "load"

data HttpData a
  = NoData
  | ArrayBufferData ArrayBuffer
  | TextData String

foreign import maybeFn :: forall a b. Fn3 b (a -> b) a b

foreign import data DOMEvent          :: Type
foreign import data XMLHttpRequest    :: Type
foreign import makeXMLHttpRequest :: forall eff. (Eff (dom :: DOM | eff) XMLHttpRequest)
foreign import unsafeOpen :: forall eff. Fn3 XMLHttpRequest String String (Eff (dom :: DOM | eff) Unit)
foreign import unsafeSend :: forall eff. Fn1 XMLHttpRequest (Eff (dom :: DOM | eff) Unit)
foreign import unsafeSendWithPayload :: forall eff a. Fn2 XMLHttpRequest a (Eff (dom :: DOM | eff) Unit)
foreign import unsafeAddEventListener :: forall eff t e b. String -> (e -> Eff (dom :: DOM | t) Unit) -> b -> (Eff (dom :: DOM | eff) Unit)
foreign import unsafeEventTarget :: forall eff a. DOMEvent -> (Eff (dom :: DOM | eff) a)
foreign import unsafeEventProp :: forall v eff. String -> DOMEvent -> (Eff (dom :: DOM | eff) v)
foreign import unsafeResponseType :: forall eff. XMLHttpRequest -> Eff (dom :: DOM | eff) String
foreign import unsafeResponse :: forall eff a. XMLHttpRequest -> Eff (dom :: DOM | eff) a
foreign import unsafeSetResponseType :: forall eff. Fn2 XMLHttpRequest String (Eff (dom :: DOM | eff) Unit)

open :: forall eff. HttpMethod -> Url -> XMLHttpRequest -> Eff (dom :: DOM | eff) Unit
open m u x = runFn3 unsafeOpen x (show m) u

send :: forall eff a. HttpData a -> XMLHttpRequest -> Eff (dom :: DOM | eff) Unit
send _ x = runFn1 unsafeSend x  -- NoData (GET)

class Event e where
  eventTarget     :: forall eff a. e -> (Eff (dom :: DOM | eff) a)

instance eventDOMEvent :: Event DOMEvent where
  eventTarget     = unsafeEventTarget

readProgressEventType :: String -> ProgressEventType
readProgressEventType "load"      = ProgressLoadEvent
readProgressEventType _           = ProgressLoadEvent

class (Event e) <= ProgressEvent e where
    progressEventType :: forall eff. e -> (Eff (dom :: DOM | eff) ProgressEventType)

instance progressEventDOMEvent :: ProgressEvent DOMEvent where
    progressEventType ev = readProgressEventType <$> unsafeEventProp "type" ev

class ProgressEventTarget b where
    addProgressEventListener :: forall e t ta. (ProgressEvent e) =>
                                ProgressEventType
                                    -> (e -> Eff (dom :: DOM | t) Unit)
                                    -> b
                                    -> (Eff (dom :: DOM | ta) Unit)


instance progressEventTargetXMLHttpRequest :: ProgressEventTarget XMLHttpRequest where
    addProgressEventListener typ    = unsafeAddEventListener (show typ)

responseType :: forall eff. XMLHttpRequest -> Eff (dom :: DOM | eff) ResponseType
responseType obj = do
  rt <- unsafeResponseType obj
  pure $ case rt of
    "arraybuffer" -> ArrayBuffer
    _ -> Default

setResponseType :: forall eff. String -> XMLHttpRequest -> Eff (dom :: DOM | eff) Unit
setResponseType rt xhr = runFn2 unsafeSetResponseType xhr rt

response :: forall eff a. XMLHttpRequest -> Eff (dom :: DOM | eff) (HttpData a)
response xhr = do
  rt <- responseType xhr
  case rt of
    ArrayBuffer           -> get ArrayBufferData
    _                     -> get TextData  -- Default
  where
    get :: forall eff' a' b. (a' -> HttpData b) -> Eff (dom :: DOM | eff') (HttpData b)
    get rt = runFn3 maybeFn NoData rt <$> unsafeResponse xhr
