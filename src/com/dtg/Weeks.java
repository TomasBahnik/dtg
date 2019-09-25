package com.dtg;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class Weeks {

    private static final int STD_NUM_OF_WEEKS = 52;
    private int compareWithYear = 0;
    private boolean isNewYearAfterThu = false;
    private int week = 1;
    private int startWeek = 1;
    private static LocalDate startDate = LocalDate.of(2020, 1, 1);
    private static LocalDate endDate = LocalDate.of(2023, 1, 30);


    private int getWeekOfDay(LocalDate day) {
        int actualYear = day.getYear();
        DayOfWeek dayOfWeek = day.getDayOfWeek();
        if (actualYear == compareWithYear) {
            if (dayOfWeek == DayOfWeek.MONDAY) {
                System.out.println(" --------------------------------------- ");
                if (week == STD_NUM_OF_WEEKS && isNewYearAfterThu) {
                    week = 1;
                    return week;
                }
                week = week > STD_NUM_OF_WEEKS ? 1 : week + 1;
                return week;
            } else
                return week;
        } else {
            //new year
            compareWithYear = day.getYear();
            LocalDate newYear = LocalDate.of(compareWithYear, 1, 1);
            isNewYearAfterThu = afterThu(newYear);
            if (!afterThu(day) || dayOfWeek == DayOfWeek.MONDAY) {
                System.out.println(" *** new year **** first week *****");
                week = 1;
            }
            return week;
        }
    }

    private boolean afterThu(LocalDate day) {
        DayOfWeek dayOfWeek = day.getDayOfWeek();
        return dayOfWeek == DayOfWeek.THURSDAY || dayOfWeek == DayOfWeek.FRIDAY ||
                dayOfWeek == DayOfWeek.SATURDAY || dayOfWeek == DayOfWeek.SUNDAY;
    }

    public static void main(String[] args) {
        Weeks weeks = new Weeks();
        weeks.compareWithYear = startDate.getYear();
        LocalDate newYear = LocalDate.of(weeks.compareWithYear, 1, 1);
        weeks.isNewYearAfterThu = weeks.afterThu(newYear);
        weeks.week = weeks.startWeek;
        long days = ChronoUnit.DAYS.between(startDate, endDate);
        //int period = Period.between(startDate, endDate).
        for (int i = 0; i < days; i++) {
            LocalDate aDay = startDate.plusDays(i);
            int aWeek = weeks.getWeekOfDay(aDay);
            String output = String.format("%-10s : %-30s : %-30s", aDay, aDay.getDayOfWeek(), aWeek);
            System.out.println(output);
        }
    }
}
