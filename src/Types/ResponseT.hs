{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Types.ResponseT
  ( ResponseT (..)
  ) where

import Data.Aeson
import Data.Text
import Types.ResponseT.Status (Status)

data ResponseT a = Response { status :: Status, payload :: a }
  deriving (Show, Eq)

instance ToJSON a => ToJSON (ResponseT a) where
  toJSON (Response s x) = object [ "status" .= s, "payload" .= x ]
