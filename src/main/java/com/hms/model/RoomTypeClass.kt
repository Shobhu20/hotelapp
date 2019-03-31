package com.hms.model

import java.io.Serializable

enum class RoomTypeClass private constructor(roomTypeClass: String) : Serializable {
    STANDARD("STANDARD"),
    DELUXE("DELUXE"),
    SUITE("SUITE");

    var roomTypeClass: String
        internal set

    init {
        this.roomTypeClass = roomTypeClass
    }
}