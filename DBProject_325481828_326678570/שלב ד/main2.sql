
--פונקציה לחישוב ציון לסל

-- FUNCTION: public.basket_quality_score(integer)

-- DROP FUNCTION IF EXISTS public.basket_quality_score(integer);

CREATE OR REPLACE FUNCTION basket_quality_score(
	p_foodbasket_id integer)
    RETURNS numeric
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
  v_score numeric := 10;

  r record;
  v_cal numeric;
  v_pro numeric;
  v_fat numeric;
  v_carb numeric;

--טוען את כל המוצרים שבסל
  cur CURSOR FOR
    SELECT g.groceries_id, g.type
    FROM foodbasket_groceries fg
    JOIN groceries g ON g.groceries_id = fg.groceries_id
    WHERE fg.foodbasket_id = p_foodbasket_id;
BEGIN
  -- סל חייב להתקיים
  IF NOT EXISTS (SELECT 1 FROM foodbasket WHERE foodbasket_id = p_foodbasket_id) THEN
    RAISE EXCEPTION 'foodbasket_id % not found', p_foodbasket_id;
  END IF;

  OPEN cur;
  LOOP
    FETCH cur INTO r;
    EXIT WHEN NOT FOUND;

    -- להביא ערכים תזונתיים של המוצר (אם חסר ערך -> יהיה NULL)
    SELECT
      MAX(CASE WHEN nutrition_id = 1 THEN value END), -- Calories
      MAX(CASE WHEN nutrition_id = 2 THEN value END), -- Protein
      MAX(CASE WHEN nutrition_id = 3 THEN value END), -- Fat
      MAX(CASE WHEN nutrition_id = 4 THEN value END)  -- Carbs
    INTO v_cal, v_pro, v_fat, v_carb
    FROM groceries_nutrition
    WHERE groceries_id = r.groceries_id;

    -- type = 'B' (בסיסי)
    IF r.type = 'B' THEN
      IF v_fat IS NOT NULL AND v_fat > 150 THEN v_score := v_score - 1; END IF;
      IF v_cal IS NOT NULL AND v_cal > 25  THEN v_score := v_score - 1; END IF;
      IF v_pro IS NOT NULL AND v_pro < 100 THEN v_score := v_score - 1; END IF;
      IF v_carb IS NOT NULL AND v_carb > 30 THEN v_score := v_score - 1; END IF;

    -- type = 'M' (ארוחה)
    ELSIF r.type = 'M' THEN
      IF v_pro  IS NOT NULL AND v_pro  < 30 THEN v_score := v_score - 1; END IF;
      IF v_cal  IS NOT NULL AND v_cal  > 50 THEN v_score := v_score - 1; END IF;
      IF v_fat  IS NOT NULL AND v_fat  > 70 THEN v_score := v_score - 1; END IF;
      IF v_carb IS NOT NULL AND v_carb < 30 THEN v_score := v_score - 1; END IF;
    END IF;

  END LOOP;
  CLOSE cur;

-- גבולות: 0..10
  IF v_score < 0 THEN v_score := 0; END IF;
  IF v_score > 10 THEN v_score := 10; END IF;
  
  RETURN v_score;
END;
$BODY$;

--פרוצדורה שעוברת על כל השליחים, במקרה שאין התאמה בין עיר של שליח לעיר של המפשחה, היא מעדכנת שליח שגר בעיר שמתגוררת המשפחה (אם קיים)
CREATE OR REPLACE PROCEDURE fix_courier_city_mismatch()
LANGUAGE plpgsql
AS $$
DECLARE
  r record;
  v_new_courier_id int;

  cur CURSOR FOR
    SELECT
      b.foodbasket_id,
      b.courier_id,
      f.city_id AS family_city_id,
      c.city_id AS courier_city_id
    FROM foodbasket b
    JOIN family f  ON f.family_id = b.family_id
    JOIN courier c ON c.courier_id = b.courier_id
    WHERE b.family_id IS NOT NULL
      AND b.courier_id IS NOT NULL
      AND b.status <> 'delivered';  -- לא נוגעים בסלים שנשלחו
BEGIN
  OPEN cur;

  LOOP
    FETCH cur INTO r;
    EXIT WHEN NOT FOUND;

    BEGIN
      -- אם השליח כבר גר בעיר של המשפחה – אין מה לעשות
      IF r.family_city_id = r.courier_city_id THEN
        CONTINUE;
      END IF;

      -- חיפוש שליח שגר בעיר של המשפחה
      SELECT courier_id
      INTO v_new_courier_id
      FROM courier
      WHERE city_id = r.family_city_id
      ORDER BY courier_id
      LIMIT 1;


      -- אם נמצא שליח מתאים – מעדכנים את הסל
      IF v_new_courier_id IS NOT NULL THEN
        UPDATE foodbasket
        SET courier_id = v_new_courier_id
        WHERE foodbasket_id = r.foodbasket_id;
      END IF;

    EXCEPTION WHEN OTHERS THEN
      -- מדלגים על סל בעייתי וממשיכים
      RAISE NOTICE 'Basket % skipped due to error: %',
        r.foodbasket_id, SQLERRM;
    END;
  END LOOP;

  CLOSE cur;
END;
$$;

--   תוכנית ראשית המזמנת את הפונקציה והפרוצדורה לעיל
CREATE OR REPLACE PROCEDURE main_program()
LANGUAGE plpgsql
AS $$
DECLARE
  r record;
  v_score numeric;
BEGIN
  -- זימון הפרוצדורה
  CALL fix_courier_city_mismatch();

  -- זימון הפונקציה עבור כל סל
  FOR r IN
    SELECT foodbasket_id
    FROM foodbasket
  LOOP
    v_score := basket_quality_score(r.foodbasket_id);

    -- הדפסה בלבד
    RAISE NOTICE 'For basket %: quality score = %',
      r.foodbasket_id, v_score;
  END LOOP;
END;
$$;

