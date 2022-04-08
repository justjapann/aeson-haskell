{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

import Data.Aeson
import Data.Text
import qualified Data.ByteString.Lazy as B
import GHC.Generics

data Person =
  Person { firstName   :: !Text
         , age         :: Int
         , language    :: !Text
         } deriving (Show,Generic)

instance FromJSON Person
instance ToJSON Person

jsonFile :: FilePath
jsonFile = "./src/dados.json"

getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile


main :: IO ()
main = do
 d <- (eitherDecode <$> getJSON) :: IO (Either String [Person])
 case d of
  Left err -> putStrLn err
  Right ps -> print ps
