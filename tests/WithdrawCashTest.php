<?php
use PHPUnit\Framework\TestCase;

class WithdrawCashTest extends TestCase
{
    private $conn;
    private $transactionStarted = false;

    protected function setUp(): void
    {
        $this->conn = new mysqli('localhost', 'root', '', 'bank_app');
        if ($this->conn->connect_error) {
            die("Connection failed: " . $this->conn->connect_error);
        }

        // Start a transaction
        $this->conn->begin_transaction();
        $this->transactionStarted = true;

        // Ensure the user exists and balance is set for testing
        $this->conn->query("DELETE FROM users WHERE email = 'test@example.com'");
        $this->conn->query("INSERT INTO users (email, name, account_number, account_type, balance) VALUES
            ('test@example.com', 'John Doe', '123456789', 'Savings', 1000.00)");
    }

    protected function tearDown(): void
    {
        if ($this->transactionStarted) {
            // Rollback the transaction
            $this->conn->rollback();
            $this->transactionStarted = false;
        }
        $this->conn->close();
    }

    public function testWithdraw()
    {
        $_SESSION['email'] = 'test@example.com';
        $_POST['transaction_amount'] = 200;
        $_POST['transaction_type'] = 'Withdraw';

        // Ensure the correct path to withdraw_cash.php
        include __DIR__ . 'widhraw_cash.php';

        $result = $this->conn->query("SELECT balance FROM users WHERE email = 'test@example.com'");
        $row = $result->fetch_assoc();
        $this->assertEquals(800.00, (float)$row['balance']); // Ensure type is float
    }

    public function testDeposit()
    {
        $_SESSION['email'] = 'test@example.com';
        $_POST['transaction_amount'] = 200;
        $_POST['transaction_type'] = 'Deposit';

        
        include __DIR__ . 'widhraw_cash.php';

        $result = $this->conn->query("SELECT balance FROM users WHERE email = 'test@example.com'");
        $row = $result->fetch_assoc();
        $this->assertEquals(1200.00, (float)$row['balance']); // Ensure type is float
    }
}
?>
