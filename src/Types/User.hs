{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Types.User
  ( User  (..)
  , PUser (..)
  ) where


import Types.EntityT
import Types.Role

import Types.Meta     (RawMeta)

import Data.Aeson     (ToJSON, FromJSON)
import GHC.Generics


data User = User
  { roles :: [()]
  } deriving (Generic, Eq, Show)


instance ToJSON   User
instance FromJSON User


type PWHash = String
data PUser = PUser User PWHash
