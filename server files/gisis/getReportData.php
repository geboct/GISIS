

<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

include 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $reportType = $_POST['reportType'];
    $data = [];
    $success = false;
    $message = '';

    switch ($reportType) {
        case 'Daily':
            $query = "SELECT 
                        type, 
                        COUNT(*) as total, 
                        SUM(status = 'approved') as approved, 
                        SUM(status = 'rejected') as rejected 
                      FROM documents 
                      WHERE DATE(created_at) = CURDATE() 
                      GROUP BY type";
            break;
        case 'Monthly':
            $query = "SELECT 
                        type, 
                        COUNT(*) as total, 
                        SUM(status = 'approved') as approved, 
                        SUM(status = 'rejected') as rejected 
                      FROM documents 
                      WHERE MONTH(created_at) = MONTH(CURRENT_DATE()) 
                      AND YEAR(created_at) = YEAR(CURRENT_DATE()) 
                      GROUP BY type";
            break;
        case 'Yearly':
            $query = "SELECT 
                        type, 
                        COUNT(*) as total, 
                        SUM(status = 'approved') as approved, 
                        SUM(status = 'rejected') as rejected 
                      FROM documents 
                      WHERE YEAR(created_at) = YEAR(CURRENT_DATE()) 
                      GROUP BY type";
            break;
        default:
            $message = 'Invalid report type';
            echo json_encode(['success' => false, 'data' => $data, 'message' => $message]);
            exit();
    }

    $result = $conn->query($query);

    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $data[] = [
                'label' => $row['type'],
                'total' => (int)$row['total'],
                'approved' => (int)$row['approved'],
                'rejected' => (int)$row['rejected']
            ];
        }
        $success = true;
    } else {
        $message = 'Failed to fetch data';
    }

    echo json_encode(['success' => $success, 'data' => $data, 'message' => $message]);
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}
?>
