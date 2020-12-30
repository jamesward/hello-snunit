enablePlugins(ScalaNativePlugin)

name := "hello-snunit"

scalaVersion := "2.11.12"

libraryDependencies ++= Seq(
  "com.github.lolgab" %%% "snunit" % "0.0.3"
)

nativeMode := "release"
