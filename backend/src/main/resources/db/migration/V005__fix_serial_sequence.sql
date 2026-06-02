SELECT setval(
  pg_get_serial_sequence('orders', 'id'),
  (SELECT COALESCE(MAX(id), 0) FROM orders)
);
