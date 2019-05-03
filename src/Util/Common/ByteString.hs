module Util.Common.ByteString
  ( toLazy
  ) where


import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as LBS


toLazy :: BS.ByteString -> LBS.ByteString
toLazy = LBS.fromChunks . (:[])