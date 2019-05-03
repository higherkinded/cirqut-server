{-# LANGUAGE OverloadedStrings #-}
module Util.Common.Response
  ( badRequest
  , forbidden
  , iAmATeaPot
  , loggedResponse
  , methodNotAllowed
  , notFound
  , plaintext
  , serverError
  , todo
  , tooManyRequests
  , unauthenticated
  ) where


import Application.Common.Headers
import Data.ByteString.Lazy       (ByteString)
import Data.Text
import Data.Text.Encoding
import Network.HTTP.Types
import Network.Wai
import Util.Log

import qualified Data.ByteString as BS


-- | Logs a 'Response', returns it back untouched 
loggedResponse :: Method -> BS.ByteString -> Response -> IO Response
loggedResponse m rp r =
  logResponse ( decodeUtf8 m
                <> " "
                <> decodeUtf8 rp
                <> " - "
                <> (pack . show . statusCode $ responseStatus r)
              ) >> pure r


-- | Creates a basic plaintext response
plaintext :: Status -> ByteString -> Response
plaintext = flip responseLBS [server, cPlaintext]


todo :: Response
todo = plaintext status501 "TODO"


badRequest       = plaintext status400 "400 - Bad Request"
unauthenticated  = plaintext status401 "401 - Unauthenticated"
forbidden        = plaintext status403 "403 - Forbidden"
notFound         = plaintext status404 "404 - Not Found"
methodNotAllowed = plaintext status405 "405 - Method Not Allowed"
iAmATeaPot       =
  plaintext status418 "418 - I'm a teapot. And I won't brew you a coffee."
tooManyRequests  = plaintext status429 "429 - Too Many Requests"
serverError      = plaintext status500 "500 - Internal Server Error"



