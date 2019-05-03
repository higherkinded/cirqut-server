{-# LANGUAGE DeriveGeneric #-}
module Types.Resource
  ( Resource (..)
  ) where

import Types.EntityT

import Data.Aeson   (ToJSON, FromJSON)
import GHC.Generics (Generic)


data Resource = Resource
  { unit          :: String
  , rel           :: String -- ID
  , initialAmount :: Double
  , currentAmount :: Double
  } deriving (Eq, Generic)


instance ToJSON   Resource
instance FromJSON Resource
