package com.hms.repository

import com.hms.model.Booking
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Transactional
interface BookingRepository : JpaRepository<Booking, Int> {

    fun findByRoomId(roomId: Int): Booking

    fun findByUserId(userId: Int): List<Booking>

    fun deleteByRoomId(roomId: Int)

    fun deleteByUserId(userId: Int)

    fun findByStatus(status: String): List<Booking>

    fun findByDepartureTimeLessThan(departureTime: Date): List<Booking>

    @Query("SELECT e.* FROM Booking AS e WHERE e.room_type_id = :roomType", nativeQuery = true)
    fun findByRoomTypeId(@Param("roomType") roomTypeId: Int): List<Booking>


    @Modifying@Query("DELETE FROM Booking as b where b.id IN :ids", nativeQuery = true)
    fun deleteAllByIds(@Param("ids") ids: List<Integer>)
}