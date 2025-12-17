
ALTER TABLE courier
ADD COLUMN bonus NUMERIC(10,2) DEFAULT 0;

--הוספת טבלת תיעוד
CREATE TABLE IF NOT EXISTS public.basket_audit (
    audit_id      bigserial PRIMARY KEY,
    event_time    timestamptz NOT NULL DEFAULT now(),
    event_type    text        NOT NULL,
    details       text,
    foodbasket_id integer,
    family_id     integer,
    courier_id    integer,

    CONSTRAINT basket_audit_foodbasket_fk FOREIGN KEY (foodbasket_id)
        REFERENCES public.foodbasket (foodbasket_id) ON DELETE CASCADE
);
