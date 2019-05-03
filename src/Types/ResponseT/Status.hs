{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Types.ResponseT.Status
  ( Status (..)
  , emptyStatus
  ) where

import Data.Aeson   (ToJSON, FromJSON)
import Data.List    (intercalate)
import Data.Text    (Text)
import GHC.Generics (Generic)
import Types.Misc.Color
import Util.Common.Text

data Status = Status { code :: Int, reason :: Text }
  deriving (Eq, Generic)

instance ToJSON   Status
instance FromJSON Status
instance Show     Status where
  show (Status c r) = intercalate " " ["Status", show c, show r]

emptyStatus :: Int -> Status
emptyStatus = flip Status ""
