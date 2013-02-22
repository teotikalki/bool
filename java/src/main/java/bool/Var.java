package bool;

public class Var implements Expr {
    public final String name;

    public Var(String name) {
        this.name = name;
    }

    @Override
    public <R, A> R walkWith(Walker<R, A> visitor, A arg) {
        return visitor.walk(this, arg);
    }
}
