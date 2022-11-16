import java.util.* ;
public class pnr_generator {

    private final Random random = new Random();
    private final BitSet used = new BitSet();
    private final int min = 10000;
    private final int max = 99999;
    private int numbersAvailable = max - min + 1;

    public static void main (String[] args) {

        pnr_generator randomNumbers = new pnr_generator();
        for (int i = 0; i < 100; i++) {
            System.out.println(randomNumbers.nextRandom());
        }
    }

    public int nextRandom () throws NoSuchElementException {

        while (numbersAvailable > 0) {
            int rnd = min + random.nextInt(max - min + 1);
            if (!used.get(rnd)) {
                used.set(rnd);
                numbersAvailable--;
                return rnd;
            }
        }
        throw new NoSuchElementException();
    }
}