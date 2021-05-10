module Lib.Core.Domain.StoreEvent
  ( StoreData(..)
  , SynchronizedStoreEvent(..)
  , StoreEvent(..)
  , apply
  ) where

import           Lib.Core.Domain.Article        ( Article )
import           Lib.Core.Domain.Capability     ( Capability )
import           Lib.Core.Domain.Id             ( Id )
import           Lib.Core.Domain.Resource       ( Resource )

data StoreData a = StoreData
  { setter :: !(Resource -> a -> Resource)
  , newVal :: !a
  }

data StoreEvent
  = SeInsertArticle !(StoreData (Id Article, Article))
  | SeUpdateArticle !(StoreData (Article -> Article))
  | SeDeleteArticle !(StoreData (Id Article))
  | SeInsertCapability !(StoreData (Id Capability, Capability))
  | SeUpdateCapability !(StoreData (Capability -> Capability))
  | SeDeleteCapability !(StoreData (Id Capability))

data SynchronizedStoreEvent = SynchronizedStoreEvent
  { syncStoreResId  :: !(Id Resource)
  , syncStoreEvents :: !(Seq StoreEvent)
  , syncVar         :: !(TMVar ())
  }

apply :: Resource -> StoreEvent -> Resource
apply res se = case se of
  SeInsertArticle    StoreData {..} -> setter res newVal
  SeUpdateArticle    StoreData {..} -> setter res newVal
  SeDeleteArticle    StoreData {..} -> setter res newVal
  SeInsertCapability StoreData {..} -> setter res newVal
  SeUpdateCapability StoreData {..} -> setter res newVal
  SeDeleteCapability StoreData {..} -> setter res newVal
