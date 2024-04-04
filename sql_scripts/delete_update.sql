UPDATE room
SET capacity = 
  CASE
    WHEN capacity <= 3 THEN capacity + 1
    WHEN capacity >= 4 THEN capacity + 2
    ELSE capacity
  END
WHERE capacity > 0;

DELETE FROM appointment
WHERE DATE(Day) = '2024-04-02';