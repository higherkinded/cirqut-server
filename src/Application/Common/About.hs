{-# LANGUAGE OverloadedStrings #-}
module Application.Common.About
  ( author
  , license
  , repoLoc
  , version
  ) where

import Data.ByteString

b = id :: ByteString -> ByteString

author  = b"higherkinded"
license = b"BSD 3-Clause"
version = b"0.0.1.0"
repoLoc = b"https://github.com/higherkinded/cirqut-server"
