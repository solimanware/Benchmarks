package com.example.dawaey_native

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.internal.*

@Serializable
data class Drug (
    val id: Long? = null,
    val tradename: String? = null,
    val activeingredient: String? = null,
    val price: String? = null,
    val company: String? = null,
    val group: String? = null,
    val pamphlet: String? = null,
    val dosage: String? = null,
    val composition: String? = null
)
