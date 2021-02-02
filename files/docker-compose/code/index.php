<?php
    echo '<div>
        <a href="index.html">## Docker Containers Info</a></br>
        <a href="http://localhost:8183/">## phpMyAdmin</a></br>
        </div>';

    $servername = 'mariaDB';
    $username = 'root';
    $password = '654321';
    $database = 'testdb';

    try {
        $connection = new mysqli($servername, $username, $password, $database);
        if ($connection->connect_error) {
            die("Connection failed");
        }
    
        $sql = "SELECT * FROM ISD_db";
        $result = $connection->query($sql);

        while ($row = $result->fetch_assoc()) {
                echo "Лабораторна робота №" . $row['id'] . " \t Тема. " . $row['theme'];
                echo "<br>";
        }
    } catch (Exception $e) {
        echo 'Exception: ',  $e->getMessage(), "\n";
    }
    echo phpinfo();
?>
