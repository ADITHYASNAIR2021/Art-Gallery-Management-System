<?php
$host = "localhost";
$user = "root";
$password = "";
$database = "art_gallery";

$con = new mysqli($host, $user, $password, $database);

if ($con->connect_error) {
    die("Connection failed: " . $con->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $sql_query = $_POST['sql_query'];

    // Basic validation to prevent SQL injection (this is a simplistic approach, not foolproof)
    if (stripos($sql_query, 'DROP') !== false || stripos($sql_query, 'DELETE') !== false) {
        echo "Invalid query!";
        exit;
    }

    $result = $con->query($sql_query);

    if ($result) {
        if ($result->num_rows > 0) {
            echo "<div style='overflow-x:auto;'>";
            echo "<table style='width: 100%; border-collapse: collapse; margin: 20px 0;'>";
            echo "<tr style='background-color: #f4f4f4;'>";
            // Fetching field names
            while ($field = $result->fetch_field()) {
                echo "<th style='padding: 10px; border: 1px solid #ddd;'>{$field->name}</th>";
            }
            echo "</tr>";
            // Fetching rows
            while ($row = $result->fetch_assoc()) {
                echo "<tr>";
                foreach ($row as $cell) {
                    echo "<td style='padding: 10px; border: 1px solid #ddd;'>{$cell}</td>";
                }
                echo "</tr>";
            }
            echo "</table>";
            echo "</div>";
        } else {
            echo "<p style='color: red;'>No results found.</p>";
        }
    } else {
        echo "<p style='color: red;'>Error: " . $con->error . "</p>";
    }
}

$con->close();
?>
