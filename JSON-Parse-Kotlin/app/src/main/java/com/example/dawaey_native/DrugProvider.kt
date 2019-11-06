package com.example.dawaey_native

import android.content.Context
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.BufferedReader
import kotlinx.serialization.*
import kotlinx.serialization.json.*
import java.io.InputStreamReader
import java.io.StringReader
import kotlin.system.measureNanoTime


class DrugProvider constructor(val context: Context) {


    private var originalDrugsList: List<Drug> = emptyList()
    private var drugsListFilterd: List<Drug> = emptyList()
    private var filter: String = "";


    val drugsList: List<Drug>
        get() = drugsListFilterd

    suspend fun getJsonFile(): String {
        val res = context.resources
        val in_s = res.openRawResource(R.raw.drugs)
        val b = ByteArray(in_s.available())
        in_s.read(b)
        return String(b)

    }

    suspend fun serializeJson(): List<Drug> {
        val stringFile = getJsonFile()
        var list: List<Drug> = emptyList()
        BenchmarkMS("serializeJson") {
            withContext(Dispatchers.IO) {
                list = Json.parse(Drug.serializer().list, stringFile)
            }
        }
        return list
    }

}