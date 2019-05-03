{-# LANGUAGE DataKinds, DeriveGeneric, FlexibleInstances, OverloadedStrings, DeriveAnyClass
  , TypeApplications, TypeFamilies, TypeSynonymInstances, StandaloneDeriving #-}
module Types.Permissions
  ( PermissionT (..)
  , Permission
  , PermissionId
  ) where


import Data.Aeson
import Data.Text
import Database.Beam
import GHC.Generics hiding (C)
import Types.Meta
import Typeclasses.Entity


data PermissionT f = Permission
  { _id       :: C f Text
  , _ns       :: C f Text
  , _name     :: C f Text
  , _meta     :: C f [RawMeta]
  , _relation :: C f Text
  , _enabled  :: C f Bool
  } deriving (Generic, Beamable)


type Permission = PermissionT Identity


deriving instance Eq   Permission
deriving instance Show Permission


instance ToJSON   Permission
instance FromJSON Permission


instance Table PermissionT where
  data PrimaryKey PermissionT f =
    PermissionId (Columnar f Text) deriving (Generic, Beamable)
  primaryKey = PermissionId
               . _id


type PermissionId = PrimaryKey PermissionT Identity


deriving instance Eq   PermissionId
deriving instance Show PermissionId


instance ToJSON PermissionId
instance FromJSON PermissionId


instance Entity Permission where
  id        = _id
  namespace = _ns
  name      = _name
  meta      = _meta
