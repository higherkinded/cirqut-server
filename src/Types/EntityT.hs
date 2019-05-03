{-# LANGUAGE
    DeriveAnyClass, DeriveGeneric, FlexibleInstances, GADTs, OverloadedStrings
  , StandaloneDeriving, TypeApplications, TypeFamilies, TypeSynonymInstances, PolyKinds #-}
module Types.EntityT
  ( EntityT (..)
  , Entity
--, entity
  ) where


import Database.Beam
import Data.Aeson
import Data.Text
import Types.Meta
import GHC.Generics


type Name = Text
type NS   = Text
type ID   = Text

data EntityT f a = Entity
  { _data :: Columnar f a
  , _id   :: Columnar f ID
  , _ns   :: Columnar f NS
  , _name :: Columnar f Name
  , _meta :: Columnar f [RawMeta]
  } deriving (Generic)


type Entity a = EntityT Identity a


deriving instance Show a => Show (Entity a)
deriving instance Eq   a => Eq   (Entity a)


entity :: a
       -> ID
       -> NS
       -> Name
       -> [RawMeta]
       -> Entity a
entity = Entity @Identity


instance ToJSON   a => ToJSON   (Entity a)
instance FromJSON a => FromJSON (Entity a)


-- instance (ToJSON a) => ToJSON (EntityT a) where
--   toJSON (Entity v i ns name meta) = object
--     [ "data"  .= v
--     , "id"    .= i
--     , "meta"  .= meta
--     , "name"  .= name
--     , "ns"    .= ns
--     ]

-- instance (FromJSON a) => FromJSON (EntityT a) where
--   parseJSON (Object j) = Entity
--     <$> j .: "data"
--     <*> j .: "id"
--     <*> j .: "ns"
--     <*> j .: "name"
--     <*> j .: "meta"
