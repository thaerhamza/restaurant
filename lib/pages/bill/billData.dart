class BillData {
  String bil_id;
  String bil_address;
  String bil_after_note;
  String bil_before_note;
  String bil_rate;
  String cus_id;
  String del_id;
  String bil_regdate;

  BillData(
      {this.bil_id,
      this.bil_before_note,
      this.bil_address,
      this.bil_after_note,
      this.bil_rate,
      this.bil_regdate,
      this.cus_id,
      this.del_id});
}
