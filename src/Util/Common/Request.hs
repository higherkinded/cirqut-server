{-# LANGUAGE OverloadedStrings #-}
module Util.Common.Request
  ( pathInfo'
  , Path (..)
  , dissectPath
  , dissectPathInfo
  , popPath
  ) where


import Data.Text   hiding (filter)
import Network.Wai


pathInfo' = Prelude.filter (/="") . pathInfo


data Path = PathEmpty
          | PathChain Text [Text]
          deriving (Show, Eq, Ord)


dissectPath :: [Text] -> Path
dissectPath []     = PathEmpty
dissectPath (x:xs) = PathChain x xs


dissectPathInfo :: Request -> Path
dissectPathInfo = dissectPath . pathInfo'


_popPath :: Path -> Path
_popPath (PathChain _ xs) = dissectPath xs
_popPath PathEmpty        = PathEmpty


_toPathInfo :: Path -> [Text]
_toPathInfo PathEmpty        = []
_toPathInfo (PathChain x xs) = x:xs


popPath :: Request -> Request
popPath r = r { pathInfo = _toPathInfo . _popPath $ dissectPathInfo r }