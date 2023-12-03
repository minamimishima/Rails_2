class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :headcount, presence: true, numericality: { greater_than_or_equal_to: 1}
  validates :checkin_date, presence: true
  validates :checkout_date, presence: true
  validate :checkin_date_cannot_be_before_today
  validate :checkout_date_cannot_be_before_checkin_date

  def checkin_date_cannot_be_before_today
    if checkin_date.present? && checkin_date < Time.zone.today
      errors.add(:checkin_date, "は今日の日付より後に設定してください")
    end
  end

  def checkout_date_cannot_be_before_checkin_date
    if checkout_date.present? && checkout_date < checkin_date
      errors.add(:checkout_date, "はチェックイン日より後に設定してください")
    end
  end

end
