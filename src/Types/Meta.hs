{-# LANGUAGE
    DeriveAnyClass, DeriveGeneric, FlexibleInstances, StandaloneDeriving
  , TypeApplications, TypeFamilies, TypeSynonymInstances #-}
module Types.Meta
  ( MetafieldT (..)
  , Metafield
  , RawMeta    (..)
  ) where


import Control.Exception
import Data.Aeson
import Data.ByteString.Lazy   (toStrict)
import Data.Text
import Data.Text.Encoding
import Database.Beam
import GHC.Generics    hiding (C)
import Util.Common.ByteString


type Relation = Text
type Key      = Text
type Val      = Value


-- data RawMeta = RawMeta Key Val deriving (Eq, Show)

-- | Used to represent the metadata associated with entities
data RawMeta = MkRaw { key :: Key, value :: Val }
  deriving (Eq, Generic, Show)


instance ToJSON RawMeta where
instance FromJSON RawMeta where


-- | Tabular data type that interacts with DB
data MetafieldT f = Metafield
  { _metaid   :: C f Text
  , _relation :: C f Text
  , _key      :: C f Text
  , _value    :: C f Text
  } deriving (Beamable, Generic)


instance Table MetafieldT where
  data PrimaryKey MetafieldT f =
    MetafieldId (Columnar f Text) deriving (Generic, Beamable)
  primaryKey = MetafieldId
               . _metaid


-- | A more "concrete" 'MetafieldT'
type Metafield = MetafieldT Identity


deriving instance Eq   Metafield
deriving instance Show Metafield


toRaw :: Metafield -> Either String RawMeta
toRaw m =
  let parsed = eitherDecode
               . toLazy
               . encodeUtf8
               $ _value m :: Either String Value
  in case parsed of
    Right r -> Right
               . flip MkRaw r
               $ _key m
    Left  e -> Left e


fromRaw :: RawMeta -> Text -> Text -> Metafield
fromRaw r id rel = Metafield @Identity id rel k v
  where k = key r
        v = decodeUtf8
            . toStrict
            . encode
            $ value r
