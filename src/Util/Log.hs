{-# LANGUAGE OverloadedStrings #-}
module Util.Log
  ( logEvent
  , logResponse
  , outputEvent
  , warnEvent
  ) where


import Prelude hiding (putStrLn)

import Data.Time.Clock
import Data.Text
import Data.Text.IO
import Text.Printf
import Types.Misc.Color


outputEvent :: Text -> Text -> IO ()
outputEvent label evt =
  putStrLn =<< (<> "] <" <> label <> "> " <> evt) . ("[" <>) . pack . show
  <$> getCurrentTime


logEvent :: Text -> IO ()
logEvent = outputEvent $ colorize Green "Info"


logResponse :: Text -> IO ()
logResponse = outputEvent $ colorize Cyan "Response"


warnEvent :: Text -> IO ()
warnEvent = outputEvent $ colorize Yellow "Warning"
