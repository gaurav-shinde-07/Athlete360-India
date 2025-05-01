package athlete.main;

public class GetterSetter {

	 private static int id;
	 private static String email;
	 private static String name;
	 
	public static String getName() {
		return name;
	}
	public static void setName(String name) {
		GetterSetter.name = name;
	}
	public static int getId() {
		return id;
	}
	public static void setId(int id) {
		GetterSetter.id = id;
	}
	public static String getEmail() {
		return email;
	}
	public static void setEmail(String email) {
	     GetterSetter.email = email;
	}
	 
}
