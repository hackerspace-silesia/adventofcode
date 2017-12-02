class LookAndSay {
	public static void main(String[] args) {
		String input = "1113222113";
		for (int i=0; i<50; i++)
			input = looksay(input);
		System.out.println(input.length());
	}
	public static String looksay(String s) {
		StringBuilder out = new StringBuilder();
   		for (int i=0; i<s.length(); i++) {
        	int count = 1;
        	char c = s.charAt(i);
        	while (i+1<s.length() && s.charAt(i+1) == c) {
            	++i;
            	++count;
        	}
        	out.append(count);
        	out.append(c);
    	}
    return out.toString();
	}
}
