{-# LANGUAGE OverloadedStrings #-}
module Application.Common.Headers
  ( server
  , cPlaintext
  ) where

import Application.Common.About (version)
import Data.ByteString (ByteString)
import Data.CaseInsensitive (CI)
import Data.Monoid ((<>))


_mkHeader :: CI ByteString -> ByteString -> (CI ByteString, ByteString)
_mkHeader = (,)


server     = _mkHeader "Server" ("Warp/Cirqut-" <> version)
cPlaintext = _mkHeader "Content-Type" "text/plain"
