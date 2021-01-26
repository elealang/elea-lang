
module Main where


import Options.Applicative
import Data.Semigroup ((<>))


import qualified CLI (run)



main :: IO ()
main = CLI.run

