Table before {
  id serial [pk]
  value boolean [not null]
}

Table public_holiday {
  id serial [pk]
  name text [not null]
  date_holiday date [not null]
}

Table member_type {
  id serial [pk]
  value text [not null]
  quota_loan integer [not null]
  quota_reservation integer [not null]
  quota_extension integer [not null]
  loan_duration integer [not null]
  extension_duration integer [not null]
  penality_duration integer [not null]
}

Table status {
  id serial [pk]
  value text [not null]
}

Table member {
  id serial [pk]
  email text [not null]
  id_member_type integer [not null]
  username text [not null]
  birth date [not null]
  password text [not null]
  registration_date date [not null]
}

Table member_status {
  id serial [pk]
  id_member integer [not null]
  id_status integer [not null]
  status_date date [not null]
}

Table librarian {
  id serial [pk]
  username text [not null]
  password text [not null]
}

Table subscription_type {
  id serial [pk]
  name text [not null]
  duration integer [not null]
}

Table subscription {
  id serial [pk]
  id_member integer [not null]
  id_subscription_type integer [not null]
  id_librarian integer [not null]
  subscription_date date [not null]
  subscription_start date [not null]
  subscription_end date [not null]
}

Table book_genre {
  id serial [pk]
  value text [not null]
}

Table book_theme {
  id serial [pk]
  value text [not null]
}

Table author {
  id serial [pk]
  name text [not null]
  artist_name text
}

Table book {
  id serial [pk]
  title text [not null]
  id_author integer [not null]
  id_book_genre integer [not null]
  edition_date date [not null]
  age integer [not null]
}

Table book_details {
  id serial [pk]
  id_book integer [not null]
  id_book_theme integer [not null]
}

Table copy {
  id serial [pk]
  id_book integer [not null]
  copy_id integer [not null]
}

Table loan {
  id serial [pk]
  id_member integer [not null]
  id_copy integer [not null]
  id_librarian_loan integer [not null]
  loan_date date [not null]
  start_date date [not null]
  due_date date [not null]
  id_librarian_return integer
  return_date date
}

Table reservation {
  id serial [pk]
  id_member integer [not null]
  id_book integer [not null]
  reservation_date date [not null]
  ask_start_date date [not null]
  ask_due_date date [not null]
  id_librarian integer
  treatment_date date
  id_loan integer
}

Table extension {
  id serial [pk]
  id_loan integer [not null]
  extension_date date [not null]
  actual_due_date date [not null]
  ask_due_date date [not null]
  id_librarian integer
  treatment_date date
  is_allowed boolean
}

Table penality {
  id serial [pk]
  id_loan integer [not null]
  id_member integer [not null]
  start_date date [not null]
  end_date date [not null]
}

Table member_quota_loan {
  id serial [pk]
  id_member integer [not null]
  quota integer [not null]
  quota_date date [not null]
  id_loan integer [not null]
}

Table member_quota_reservation {
  id serial [pk]
  id_member integer [not null]
  quota integer [not null]
  quota_date date [not null]
  id_reservation integer [not null]
}

Table member_quota_extension {
  id serial [pk]
  id_member integer [not null]
  quota integer [not null]
  quota_date date [not null]
  id_extension integer [not null]
}

Table authorisation {
  id serial [pk]
  id_member_type integer [not null]
  id_book integer [not null]
}

Ref: member.id_member_type > member_type.id [delete: cascade]

Ref: member_status.id_member > member.id [delete: cascade]
Ref: member_status.id_status > status.id [delete: cascade]

Ref: subscription.id_member > member.id [delete: cascade]
Ref: subscription.id_subscription_type > subscription_type.id [delete: cascade]
Ref: subscription.id_librarian > librarian.id [delete: cascade]

Ref: book.id_author > author.id [delete: cascade]
Ref: book.id_book_genre > book_genre.id [delete: cascade]

Ref: book_details.id_book > book.id [delete: cascade]
Ref: book_details.id_book_theme > book_theme.id [delete: cascade]

Ref: copy.id_book > book.id [delete: cascade]

Ref: loan.id_member > member.id [delete: cascade]
Ref: loan.id_copy > copy.id [delete: cascade]
Ref: loan.id_librarian_loan > librarian.id [delete: cascade]
Ref: loan.id_librarian_return > librarian.id [delete: set null]

Ref: reservation.id_member > member.id [delete: cascade]
Ref: reservation.id_book > book.id [delete: cascade]
Ref: reservation.id_librarian > librarian.id [delete: set null]
Ref: reservation.id_loan > loan.id [delete: set null]

Ref: extension.id_loan > loan.id [delete: cascade]
Ref: extension.id_librarian > librarian.id [delete: set null]

Ref: penality.id_loan > loan.id [delete: cascade]
Ref: penality.id_member > member.id [delete: cascade]

Ref: member_quota_loan.id_member > member.id [delete: cascade]

Ref: member_quota_reservation.id_member > member.id [delete: cascade]

Ref: member_quota_extension.id_member > member.id [delete: cascade]

Ref: authorisation.id_member_type > member_type.id [delete: cascade]
Ref: authorisation.id_book > book.id [delete: cascade]