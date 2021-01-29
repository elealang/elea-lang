
{-# OPTIONS_GHC -F -pgmF=record-dot-preprocessor #-}

module GenApp.Golang where


import Data.Text (Text)



data Definition = Definition
  { repository :: Text
  , output     :: Output
  , params     :: Parameters
  } deriving (Eq, Show)


data Output = Output
  { dataFilepath :: Text
  , other        :: Text
  } deriving (Eq, Show)


data Parameters = Parameters
  { moduleName :: Text
  , other      :: Text
  } deriving (Eq, Show)


