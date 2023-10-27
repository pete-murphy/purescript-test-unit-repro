module Test.Unit.Mytest where

import Prelude

import Effect (Effect)
import Node.Encoding (Encoding(..))
import Node.FS.Aff as FS
import Test.Unit (suite, test, timeout)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTest)

main ∷ Effect Unit
main = runTest do
  suite "sync code" do
    test "arithmetic" do
      Assert.assert "2 + 2 should be 4" $ (2 + 2) == 4
      Assert.assertFalse "2 + 2 shouldn't be 5" $ (2 + 2) == 5
      Assert.equal 4 (2 + 2)
      Assert.expectFailure "2 + 2 shouldn't be 5" $ Assert.equal 5 (2 + 2)
  suite "async code" do
    test "with async IO" do
      fileContents <- FS.readTextFile UTF8 "file.txt"
      Assert.equal "hello here are your file contents\n" fileContents
    test "async operation with a timeout" do
      timeout 100 $ do
        file2Contents <- FS.readTextFile UTF8 "file2.txt"
        Assert.equal "can we read a file in 100ms?\n" file2Contents