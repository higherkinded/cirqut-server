{-# LANGUAGE OverloadedStrings #-}
module Types.Misc.Color
  ( Color (..)
  , ansiStart
  , ansiTerminate
  , colorize
  ) where


import Data.Monoid ((<>))
import Data.Text
import Util.Common.Text


data Color
  = Black
  | Red
  | Green
  | Yellow
  | Blue
  | Magenta
  | Cyan
  | White
  deriving (Eq, Enum)

instance Show Color where show = show . fromEnum


esc  :: Text
esc  = "\ESC["
cesc = esc <> "3"


ansiStart :: Color -> Text
ansiStart = (<> "m") . (cesc <>) . pshow


ansiTerminate :: Text
ansiTerminate = (esc <> "0") <> "m"


colorize :: Color -> Text -> Text
colorize c = (<> ansiTerminate) . (ansiStart c <>)
