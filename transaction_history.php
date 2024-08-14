<?php
include "db_connection.php";
session_start();

// Check if the user is logged in
if (!isset($_SESSION['email'])) {
    header("Location: login.php");
    exit();
}

// Initialize filters
$transactionTypeFilter = isset($_GET['transaction_type']) ? $_GET['transaction_type'] : '';
$startDateFilter = isset($_GET['start_date']) ? $_GET['start_date'] : '';
$endDateFilter = isset($_GET['end_date']) ? $_GET['end_date'] : '';

// Fetch distinct transaction types for the filter dropdown
$transactionTypesQuery = "SELECT DISTINCT transaction_type FROM deposit UNION SELECT DISTINCT transaction_type FROM transactions";
$transactionTypesResult = $conn->query($transactionTypesQuery);

if (!$transactionTypesResult) {
    die("Query failed for transaction types: " . $conn->error);
}

// Fetch transaction history from the deposit table based on the filters
$queryDeposits = "SELECT name, account_number, account_type, transaction_type, created_at, deposited_amount FROM deposit WHERE 1=1";
if ($transactionTypeFilter) {
    $queryDeposits .= " AND transaction_type = '$transactionTypeFilter'";
}
if ($startDateFilter) {
    $queryDeposits .= " AND DATE(created_at) >= '$startDateFilter'";
}
if ($endDateFilter) {
    $queryDeposits .= " AND DATE(created_at) <= '$endDateFilter'";
}
$resultDeposits = $conn->query($queryDeposits);

if (!$resultDeposits) {
    die("Query failed for deposits: " . $conn->error);
}

// Fetch transaction history from the transactions table based on the filters
$queryTransactions = "SELECT sender_account, recipient_account, amount, transaction_type, created_at FROM transactions WHERE 1=1";
if ($transactionTypeFilter) {
    $queryTransactions .= " AND transaction_type = '$transactionTypeFilter'";
}
if ($startDateFilter) {
    $queryTransactions .= " AND DATE(created_at) >= '$startDateFilter'";
}
if ($endDateFilter) {
    $queryTransactions .= " AND DATE(created_at) <= '$endDateFilter'";
}
$resultTransactions = $conn->query($queryTransactions);

if (!$resultTransactions) {
    die("Query failed for transactions: " . $conn->error);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Optional: Bootstrap JavaScript for interactive components -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h2>Transactions History</h2>

        <!-- Filter Form -->
        <form method="GET" action="">
            <div class="form-row">
                <div class="form-group col-md-4">
                    <label for="transaction_type">Filter by Transaction Type</label>
                    <select name="transaction_type" id="transaction_type" class="form-control">
                        <option value="">All</option>
                        <?php while ($row = $transactionTypesResult->fetch_assoc()): ?>
                            <option value="<?php echo htmlspecialchars($row['transaction_type']); ?>" <?php if ($row['transaction_type'] == $transactionTypeFilter) echo 'selected'; ?>>
                                <?php echo htmlspecialchars($row['transaction_type']); ?>
                            </option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="form-group col-md-3">
                    <label for="start_date">Start Date</label>
                    <input type="date" name="start_date" id="start_date" class="form-control" value="<?php echo htmlspecialchars($startDateFilter); ?>">
                </div>
                <div class="form-group col-md-3">
                    <label for="end_date">End Date</label>
                    <input type="date" name="end_date" id="end_date" class="form-control" value="<?php echo htmlspecialchars($endDateFilter); ?>">
                </div>
                <div class="form-group col-md-2 align-self-end">
                    <button type="submit" class="btn btn-primary">Filter</button>
                </div>
            </div>
        </form>

        <table class="table table-bordered mt-4">
            <thead>
                <tr>
                    <th>Name/Account</th>
                    <th>Account Number</th>
                    <th>Account Type</th>
                    <th>Transaction Type</th>
                    <th>Date</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <!-- Display Deposit Transactions -->
                <?php while ($row = $resultDeposits->fetch_assoc()): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($row['name']); ?></td>
                        <td><?php echo htmlspecialchars($row['account_number']); ?></td>
                        <td><?php echo htmlspecialchars($row['account_type']); ?></td>
                        <td><?php echo htmlspecialchars($row['transaction_type']); ?></td>
                        <td><?php echo htmlspecialchars($row['created_at']); ?></td>
                        <td><?php echo htmlspecialchars($row['deposited_amount']); ?></td>
                    </tr>
                <?php endwhile; ?>

                <!-- Display Fund Transfer Transactions -->
                <?php while ($row = $resultTransactions->fetch_assoc()): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($row['sender_account']); ?></td>
                        <td><?php echo htmlspecialchars($row['recipient_account']); ?></td>
                        <td><?php echo 'N/A'; ?></td>
                        <td><?php echo htmlspecialchars($row['transaction_type']); ?></td>
                        <td><?php echo htmlspecialchars($row['created_at']); ?></td>
                        <td><?php echo htmlspecialchars($row['amount']); ?></td>
                    </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
        <a href="transactions.php" class="btn btn-secondary mt-3">Back</a>
    </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

<?php
$conn->close();
?>
