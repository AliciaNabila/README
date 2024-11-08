# ALICIA AYU NABILA-21.01.55.0022 (UTS)
## Tujuan
Membuat dan menguji web service untuk manajemen tickets menggunakan PHP dan MySQL.

## Alat yang Dibutuhkan
1. XAMPP
2. Text editor (Visual Studio Code)
3. Postman

## Langkah-langkah Praktikum

### 1. Persiapan Lingkungan
1. Buat folder baru bernama `rest_tickets` di dalam direktori `htdocs` XAMPP

### 2. Membuat Database
1. Buka phpMyAdmin (http://localhost/phpmyadmin)
2. Buat database baru bernama `ticketstore`
3. Pilih database `ticketstore`, lalu buka tab SQL
4. Jalankan query SQL berikut untuk membuat tabel dan menambahkan data sampel:

```sql
CREATE TABLE ticketstore (
    id INT AUTO_INCREMENT PRIMARY KEY,
    destination VARCHAR(30),
    date DATE,
    price DECIMAL(10, 2), 
    stock INT(11)
);

INSERT INTO ticketstore (destination, date, price, stock) VALUES
('Jakarta - Kota Metropolitan', '2024-12-10', 550000.00, 90),
('Bandung - Kota Kembang', '2024-12-11', 320000.00, 140),
('Surabaya - Kota Pahlawan', '2024-12-12', 480000.00, 75),
('Yogyakarta - Kota Budaya', '2024-12-13', 360000.00, 110),
('Bali - Pulau Dewata', '2024-12-14', 620000.00, 55),
('Medan - Kota Bersejarah', '2024-12-15', 500000.00, 85),
('Makassar - Kota Pelabuhan', '2024-12-16', 470000.00, 70),
('Semarang - Kota Pelayaran', '2024-12-17', 400000.00, 95),
('Palembang - Kota Musi', '2024-12-18', 430000.00, 65),
('Balikpapan - Kota Minyak', '2024-12-19', 510000.00, 80);
```

### 3. Membuat File PHP untuk Web Service
1. Buka text editor (Visual Studio Code)
2. Buat file baru dan simpan sebagai `tickets_api.php` di dalam folder `rest_tickets`.
3. Salin dan tempel kode berikut ke dalam `tickets_api.php`:

```php
<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$method = $_SERVER['REQUEST_METHOD'];
$request = [];

if (isset($_SERVER['PATH_INFO'])) {
    $request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
}

function getConnection() {
    $host = 'localhost';
    $db   = 'ticketstore';
    $user = 'root';
    $pass = ''; // Ganti dengan password MySQL Anda jika ada
    $charset = 'utf8mb4';

    $dsn = "mysql:host=$host;dbname=$db;charset=$charset";
    $options = [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ];
    try {
        return new PDO($dsn, $user, $pass, $options);
    } catch (\PDOException $e) {
        throw new \PDOException($e->getMessage(), (int)$e->getCode());
    }
}

function response($status, $data = NULL) {
    header("HTTP/1.1 " . $status);
    if ($data) {
        echo json_encode($data);
    }
    exit();
}

$db = getConnection();

switch ($method) {
    case 'GET':
        if (!empty($request) && isset($request[0])) {
            $id = $request[0];
            $stmt = $db->prepare("SELECT * FROM ticketstore WHERE id = ?");
            $stmt->execute([$id]);
            $tickets = $stmt->fetch();
            if ($tickets) {
                response(200, $tickets);
            } else {
                response(404, ["message" => "tickets not found"]);
            }
        } else {
            $stmt = $db->query("SELECT * FROM ticketstore");
            $tickets = $stmt->fetchAll();
            response(200, $tickets);
        }
        break;
    
    case 'POST':
        $data = json_decode(file_get_contents("php://input"));
        if (!isset($data->destination) || !isset($data->date) || !isset($data->price) || !isset($data->stock)) {
            response(400, ["message" => "Missing required fields"]);
        }
        $sql = "INSERT INTO ticketstore (destination, date, price, stock) VALUES (?, ?, ?, ?)";
        $stmt = $db->prepare($sql);
        if ($stmt->execute([$data->destination, $data->date, $data->price, $data->stock])) {
            response(201, ["message" => "tickets created", "id" => $db->lastInsertId()]);
        } else {
            response(500, ["message" => "Failed to create tickets"]);
        }
        break;
    
    case 'PUT':
        if (empty($request) || !isset($request[0])) {
            response(400, ["message" => "tickets ID is required"]);
        }
        $id = $request[0];
        $data = json_decode(file_get_contents("php://input"));
        if (!isset($data->destination) || !isset($data->date) || !isset($data->price) || !isset($data->stock)) {
            response(400, ["message" => "Missing required fields"]);
        }
        $sql = "UPDATE ticketstore SET destination = ?, date = ?, price = ?, stock = ? WHERE id = ?";
        $stmt = $db->prepare($sql);
        if ($stmt->execute([$data->destination, $data->date, $data->price, $data->stock, $id])) {
            response(200, ["message" => "tickets updated"]);
        } else {
            response(500, ["message" => "Failed to update tickets"]);
        }
        break;

    case 'DELETE':
        if (empty($request) || !isset($request[0])) {
            response(400, ["message" => "tickets ID is required"]);
        }
        $id = $request[0];
        $sql = "DELETE FROM ticketstore WHERE id = ?";
        $stmt = $db->prepare($sql);
        if ($stmt->execute([$id])) {
            response(200, ["message" => "tickets deleted"]);
        } else {
            response(500, ["message" => "Failed to delete tickets"]);
        }
        break;
    
    default:
        response(405, ["message" => "Method not allowed"]);
        break;
}
?>
```

### 4. Pengujian dengan Postman
1. Buka Postman
2. Buat request baru untuk setiap operasi berikut:

#### a. GET All Tickets
- Method: GET
- URL: ` http://localhost/rest_tickets/tickets_api.php`
- Klik "Send"

#### b. GET Specific Tickets
- Method: GET
- URL: `http://localhost/rest_tickets/tickets_api.php/5` (untuk buku dengan ID 5)
- Klik "Send"

#### c. POST Tickets
- Method: POST
- URL: `http://localhost/rest_tickets/tickets_api.php`
- Headers: 
  - Key: Content-Type
  - Value: application/json
- Body:
  - Pilih "raw" dan "JSON"
  - Masukkan:
    ```json
    {
        "destination": "Pekanbaru - Kota Bertuah",
        "date": "2024-12-20",
        "price": "820000.00",
        "stock" : 65
    }
    ```
- Klik "Send"


#### d. PUT (Update) Tickets
- Method: PUT
- URL: `http://localhost/rest_tickets/tickets_api.php/12` (asumsikan ID buku baru adalah 12)
- Headers: 
  - Key: Content-Type
  - Value: application/json
- Body:
  - Pilih "raw" dan "JSON"
  - Masukkan:
    ```json
    {
        "destinantion": "Pekanbaru - Kota Bertuah : Kota Madani",
        "date": "2024-12-20",
        "price": "820000.00",
        "stock" : 65
    }
    ```
- Klik "Send"
#### e. DELETE Tickets
- Method: DELETE
- URL: `http://localhost/rest_tickets/tickets_api.php/12` (untuk menghapus buku dengan ID 12)
- Klik "Send"
### Hasil Screenshoot
![Screenshot (53)](https://github.com/user-attachments/assets/e0f8288b-db9a-4e30-b91f-8e4008be5556)
![Screenshot (54)](https://github.com/user-attachments/assets/613220a5-9991-46a6-b542-4ff1e9a2cc02)
![Screenshot (55)](https://github.com/user-attachments/assets/234caf8f-11ce-41ea-a6bc-2748bdbaeb22)
![Screenshot (59)](https://github.com/user-attachments/assets/a62479eb-a8ee-4503-a27d-21996a73d4f0)
![Screenshot (60)](https://github.com/user-attachments/assets/60e199bb-fdbc-4d63-baa4-67fde48b232a)

