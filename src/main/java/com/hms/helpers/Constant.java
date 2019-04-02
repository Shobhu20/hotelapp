package com.hms.helpers;

public class Constant {
    public static class ROOM_STATUS {
        public static String VERIFIED = "VERIFIED";
        public static String UNVERIFIED = "UNVERIFIED";
    }

    public static class BOOKING_STATUS {
        public static String PENDING = "PENDING";
        public static String CONFIRMED = "CONFIRMED";
        public static String COMPLETED = "COMPLETED";
    }

    public static class ROOM_TYPE {
        public static String STANDARD = "STANDARD";
        public static String DELUXE = "DELUXE";
        public static String SUITE = "SUITE";
    }

    public static class ROOM_TYPE_VALUE {
        public static Integer STANDARD = 1;
        public static Integer DELUXE = 2;
        public static Integer SUITE = 3;
    }

    public static class USER_ROLE {
        public static Integer VERIFIED = 1;
        public static Integer ADMIN = 2;
    }
}
