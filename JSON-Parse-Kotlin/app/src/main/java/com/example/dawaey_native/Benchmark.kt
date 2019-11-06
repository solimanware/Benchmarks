package com.example.dawaey_native

import android.util.Log

public inline fun BenchmarkMS(name:String,block: () -> Unit) {
    val start = System.currentTimeMillis()
    block()
    val res = System.currentTimeMillis() - start

    Log.d("BENCHMARK","$name took $res ms to execute.")
}