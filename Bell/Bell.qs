namespace Quantum.Bell
{
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    operation Set (desired: Result, q1: Qubit) : Unit
    {
        if (desired != M(q1))
        {
            X(q1);
        }
    }

    operation BellTest (count : Int, initial: Result) : (Int, Int, Int)
    {
        mutable numOnes = 0;
        mutable agree = 0;
        // allocate 1 qubit
        // using (qubit = Qubit())
        // allocate 2 qubits
        using ((q0, q1) = (Qubit(), Qubit()))
        {
            for (test in 1..count) {
                Set (initial, q0);
                Set (Zero, q1);
                // Use X to flip the qubit
                // X(qubit);
                // Use H to Hadamard the qubit
                H(q0);
                CNOT(q0, q1);
                let res = M (q0);

                if (M (q1) == res) {
                    set agree += 1;
                }

                // Count the number of ones we saw:
                if (res == One) {
                    set numOnes += 1;
                }
                Set(Zero, q0);
                Set(Zero, q1);
            }
        }

        // Return number of times we saw a |0> and number of times we saw a |1?
        return (count-numOnes, numOnes, agree);
    }
}