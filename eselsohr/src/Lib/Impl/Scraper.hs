module Lib.Impl.Scraper
  ( scrapWebsite,
  )
where

import Lib.Core.Domain.Uri (Uri, render)
import qualified Text.HTML.Scalpel as SC

type WithScraper m = MonadIO m

scrapWebsite :: WithScraper m => Uri -> m Text
scrapWebsite uri =
  fromMaybe "Empty Title" <$> scrapWebsiteDirect uri

scrapWebsiteDirect :: WithScraper m => Uri -> m (Maybe Text)
scrapWebsiteDirect uri =
  let sUrl = toString $ render uri
   in liftIO $ SC.scrapeURL sUrl titleScraper

titleScraper :: SC.Scraper Text Text
titleScraper = SC.text "h1"
