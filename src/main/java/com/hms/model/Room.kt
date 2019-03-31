package com.hms.model

import org.hibernate.annotations.Proxy
import java.io.Serializable
import javax.persistence.*
import javax.validation.constraints.NotNull

@Entity
@Table(name = "ROOM")
@Proxy(lazy = false)
class Room : Serializable {

    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int? = null

    @Column(name = "NAME", nullable = false, unique = true)
    var name: String? = null


    @Column(name = "DESCRIPTION", nullable = true)
    var description: String? = null

    @Column(name = "STATUS")
    var status: String? = null

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "TYPE", nullable = false)
    var type: RoomType? = null

    @OneToOne(mappedBy = "room", fetch = FetchType.EAGER)
    var booking: Booking? = null


    override fun toString(): String {
        return "Room [id=" + id + ", name=" + name +
                ", description=" + description +
                 ", type=" + type +
                ", status=" + status + "]"
    }

    override fun equals(other: Any?): Boolean {
        if (this === other)
            return true
        if (other == null)
            return false
        if (other !is Room)
            return false
        val oth = other as Room?
        if (id == null) {
            if (oth!!.id != null)
                return false
        } else if (id != oth!!.id)
            return false
        if (name == null) {
            if (oth.name != null)
                return false
        } else if (name != oth.name)
            return false
        return true
    }

    override fun hashCode(): Int {
        var result = (id ?: 0).toInt()
        result = 31 * result + (name?.hashCode() ?: 0)
        result = 31 * result + (description?.hashCode() ?: 0)
        result = 31 * result + (status?.hashCode() ?: 0)
        result = 31 * result + (type?.hashCode() ?: 0)
        result = 31 * result + (booking?.hashCode() ?: 0)
        return result
    }

}