package medical;

public class Customer {
    private String name, phone, district, gender, buyDate, medicine;

    public Customer(String name, String phone, String district, String gender, String buyDate, String medicine) {
        this.name = name;
        this.phone = phone;
        this.district = district;
        this.gender = gender;
        this.buyDate = buyDate;
        this.medicine = medicine;
    }

    public String getName() { return name; }
    public String getPhone() { return phone; }
    public String getDistrict() { return district; }
    public String getGender() { return gender; }
    public String getBuyDate() { return buyDate; }
    public String getMedicine() { return medicine; }
}
