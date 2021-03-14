-- | Common helpers for writing tests.
module Test.Common
  ( joinSpecs,
  )
where

import Lib.App (AppEnv)
import Test.Hspec (Spec, describe)

-- | Joins list of specs into single test group with given name.
joinSpecs :: String -> [AppEnv -> Spec] -> AppEnv -> Spec
joinSpecs name specs env = describe name $ traverse_ ($ env) specs