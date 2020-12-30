import snunit._

object Main {
  def main(args: Array[String]): Unit = {
    val server = SyncServerBuilder()
      .withRequestHandler(req =>
        req.send(
          statusCode = StatusCode.OK,
          content = s"hello, world!\n",
          headers = Seq("Content-Type" -> "text/plain")
        )
      )
      .build()

    server.listen()
  }
}
