package com.example.anime_app
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL


class MainActivity : FlutterActivity() {
    private val CHANNEL = "animeListChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "fetchAnimeList") {
                GlobalScope.launch(Dispatchers.Default) {
                    try {
                        val response = fetchAnimeListFromServer()
                        result.success(response)
                    } catch (e: Exception) {
                        result.error("FETCH_ERROR", "Error fetching anime list", null)
                    }
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun fetchAnimeListFromServer(): String {
        val url = URL("https://api.jikan.moe/v4/top/anime")
        val connection: HttpURLConnection = url.openConnection() as HttpURLConnection
        try {
            val reader = BufferedReader(InputStreamReader(connection.inputStream))
            val response = StringBuilder()
            var line: String?

            while (reader.readLine().also { line = it } != null) {
                response.append(line)
            }
            return response.toString()
        } finally {
            connection.disconnect()
        }
    }
}
