// app.js
import express from 'express';
import db from './db.js';

const app = express();
app.use(express.json());

// --------- User CRUD Operations ---------

// Create a new user
app.post('/users', async (req, res) => {
    const { username, password } = req.body;
    try {
        const [results] = await db.query('INSERT INTO User_Table (Username, Password) VALUES (?, ?)', [username, password]);
        res.status(201).send({ message: 'User created', userId: results.insertId });
    } catch (err) {
        res.status(500).send(err);
    }
});

// Read all users
app.get('/users', async (req, res) => {
    try {
        const [results] = await db.query('SELECT * FROM User_Table');
        res.status(200).json(results);
    } catch (err) {
        res.status(500).send(err);
    }
});

// Read a single user by ID
app.get('/users/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [results] = await db.query('SELECT * FROM User_Table WHERE User_id = ?', [id]);
        if (results.length === 0) return res.status(404).send({ message: 'User not found' });
        res.status(200).json(results[0]);
    } catch (err) {
        res.status(500).send(err);
    }
});

// Update a user by ID
app.put('/users/:id', async (req, res) => {
    const { id } = req.params;
    const { username, password } = req.body;
    try {
        await db.query('UPDATE User_Table SET Username = ?, Password = ? WHERE User_id = ?', [username, password, id]);
        res.status(200).send({ message: 'User updated' });
    } catch (err) {
        res.status(500).send(err);
    }
});

// Delete a user by ID
app.delete('/users/:id', async (req, res) => {
    const { id } = req.params;
    try {
        await db.query('DELETE FROM User_Table WHERE User_id = ?', [id]);
        res.status(200).send({ message: 'User deleted' });
    } catch (err) {
        res.status(500).send(err);
    }
});

// --------- User Information CRUD Operations ---------

// Create user information
app.post('/user-info', async (req, res) => {
    const { user_id, firstname, lastname, age } = req.body;
    try {
        const [results] = await db.query('INSERT INTO User_information (User_id, Firstname, Lastname, Age) VALUES (?, ?, ?, ?)', [user_id, firstname, lastname, age]);
        res.status(201).send({ message: 'User information created', id: results.insertId });
    } catch (err) {
        res.status(500).send(err);
    }
});

// Read all user information
app.get('/user-info', async (req, res) => {
    try {
        const [results] = await db.query('SELECT * FROM User_information');
        res.status(200).json(results);
    } catch (err) {
        res.status(500).send(err);
    }
});

// Update user information by ID
app.put('/user-info/:id', async (req, res) => {
    const { id } = req.params;
    const { firstname, lastname, age } = req.body;
    try {
        await db.query('UPDATE User_information SET Firstname = ?, Lastname = ?, Age = ? WHERE id = ?', [firstname, lastname, age, id]);
        res.status(200).send({ message: 'User information updated' });
    } catch (err) {
        res.status(500).send(err);
    }
});

// Delete user information by ID
app.delete('/user-info/:id', async (req, res) => {
    const { id } = req.params;
    try {
        await db.query('DELETE FROM User_information WHERE id = ?', [id]);
        res.status(200).send({ message: 'User information deleted' });
    } catch (err) {
        res.status(500).send(err);
    }
});

// --------- Room CRUD Operations ---------

// Create a new room
app.post('/rooms', async (req, res) => {
    const { room_number, stay, user_id } = req.body;
    try {
        const [results] = await db.query('INSERT INTO Room_table (room_number, Stay, User_id) VALUES (?, ?, ?)', [room_number, stay, user_id]);
        res.status(201).send({ message: 'Room created', roomId: results.insertId });
    } catch (err) {
        res.status(500).send(err);
    }
});

app.get('/rooms', async (req, res) => {
    try {
        const [rooms] = await db.query('SELECT room_id, room_number, Stay, User_id FROM Room_table');
        res.json(rooms); // Send only the room data
    } catch (err) {
        res.status(500).json({ error: 'Failed to fetch rooms' });
    }
});


// Update a room by ID
app.put('/rooms/:id', async (req, res) => {
    const { id } = req.params;
    const { room_number, stay, user_id } = req.body;
    try {
        await db.query('UPDATE Room_table SET room_number = ?, Stay = ?, User_id = ? WHERE room_id = ?', [room_number, stay, user_id, id]);
        res.status(200).send({ message: 'Room updated' });
    } catch (err) {
        res.status(500).send(err);
    }
});

// Delete a room by ID
app.delete('/rooms/:id', async (req, res) => {
    const { id } = req.params;
    try {
        await db.query('DELETE FROM Room_table WHERE room_id = ?', [id]);
        res.status(200).send({ message: 'Room deleted' });
    } catch (err) {
        res.status(500).send(err);
    }
});

// --------- Admin CRUD Operations ---------

// Create a new admin
app.post('/admins', async (req, res) => {
    const { username, password } = req.body;
    try {
        const [results] = await db.query('INSERT INTO Admin_table (username, password) VALUES (?, ?)', [username, password]);
        res.status(201).send({ message: 'Admin created', adminId: results.insertId });
    } catch (err) {
        res.status(500).send(err);
    }
});

// Read all admins
app.get('/admins', async (req, res) => {
    try {
        const [results] = await db.query('SELECT * FROM Admin_table');
        res.status(200).json(results);
    } catch (err) {
        res.status(500).send(err);
    }
});

// Update an admin by ID
app.put('/admins/:id', async (req, res) => {
    const { id } = req.params;
    const { username, password } = req.body;
    try {
        await db.query('UPDATE Admin_table SET username = ?, password = ? WHERE Admin_id = ?', [username, password, id]);
        res.status(200).send({ message: 'Admin updated' });
    } catch (err) {
        res.status(500).send(err);
    }
});

// Delete an admin by ID
app.delete('/admins/:id', async (req, res) => {
    const { id } = req.params;
    try {
        await db.query('DELETE FROM Admin_table WHERE Admin_id = ?', [id]);
        res.status(200).send({ message: 'Admin deleted' });
    } catch (err) {
        res.status(500).send(err);
    }
});

// --------- Bills CRUD Operations ---------

// Create a new bill
app.post('/bills', async (req, res) => {
    const { room_id, rent, water_fee, electricity_fee, other_fees, bill_status, date, pay } = req.body;

    try {
        const [result] = await db.query(
            'INSERT INTO bills_table (room_id, rent, water_fee, electricity_fee, other_fees, bill_status, date, pay) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
            [room_id, rent, water_fee, electricity_fee, other_fees, bill_status, date, pay]
        );

        res.status(201).json({ bill_id: result.insertId });
    } catch (err) {
        res.status(500).json({ error: 'Failed to add bill' });
    }
});


// Read all bills
app.get('/bills', async (req, res) => {
    const roomId = req.query.room_id;
    try {
        const [bills] = await db.query('SELECT * FROM bills_table WHERE room_id = ?', [roomId]);
        res.json(bills);
    } catch (err) {
        res.status(500).json({ error: 'Failed to fetch bills' });
    }
});


// Update an existing bill
app.put('/bills/:billId', async (req, res) => {
    const billId = req.params.billId;
    const { rent, water_fee, electricity_fee, other_fees, date } = req.body;

    try {
        const [result] = await db.query(
            'UPDATE bills_table SET rent = ?, water_fee = ?, electricity_fee = ?, other_fees = ?, date = ? WHERE bill_id = ?',
            [rent, water_fee, electricity_fee, other_fees, date, billId]
        );

        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'Bill updated successfully' });
        } else {
            res.status(404).json({ message: 'Bill not found' });
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Failed to update bill', error: err });
    }
});

// Get the latest bill for a specific room
app.get('/bills/latest/:roomId', async (req, res) => {
    const roomId = req.params.roomId;

    try {
        const [results] = await db.query(
            `SELECT * FROM bills_table WHERE room_id = ? ORDER BY date DESC LIMIT 1`,
            [roomId]
        );

        if (results.length > 0) {
            res.json(results[0]);
        } else {
            res.status(404).json({ message: 'No bills found for this room' });
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Failed to load billing details' });
    }
});


// Delete a bill by ID
// app.delete('/bills/:id', async (req, res) => {
//     const { id } = req.params;
//     try {
//         await db.query('DELETE FROM bills_table WHERE bill_id = ?', [id]);
//         res.status(200).send({ message: 'Bill deleted' });
//     } catch (err) {
//         res.status(500).send(err);
//     }
// });

// DELETE a bill by ID
app.delete('/bills/:billId', async (req, res) => {
    const billId = req.params.billId;

    try {
        const [result] = await db.query('DELETE FROM bills_table WHERE bill_id = ?', [billId]);

        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'Bill deleted successfully' });
        } else {
            res.status(404).json({ message: 'Bill not found' });
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Failed to delete bill', error: err });
    }
});


// app.js (Express server)
app.post('/users/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        // Query to fetch user info and associated room ID
        const [results] = await db.query(`
            SELECT User_Table.User_id, User_Table.Username, Room_table.room_id 
            FROM User_Table 
            LEFT JOIN Room_table ON User_Table.User_id = Room_table.User_id
            WHERE User_Table.Username = ? AND User_Table.Password = ?
        `, [username, password]);

        if (results.length > 0) {
            const user = results[0];
            // Respond with isValid: true and include the userId and roomId
            res.json({ isValid: true, userId: user.User_id, roomId: user.room_id });
        } else {
            res.json({ isValid: false });
        }
    } catch (err) {
        res.status(500).json({ message: 'Internal server error', error: err });
    }
});

// app.js (Express server)
app.get('/bills/:roomId', async (req, res) => {
    const { roomId } = req.params;

    try {
        // Query the database for bill details based on the room ID
        const [billResults] = await db.query(`
      SELECT 
        bill_id, rent, water_fee, electricity_fee, other_fees, 
        bill_status, date, pay,
        (rent + water_fee + electricity_fee + other_fees) as total
      FROM bills_table 
      WHERE room_id = ?
    `, [roomId]);

        if (billResults.length > 0) {
            const bill = billResults[0]; // Assuming one bill per room

            res.json({
                bill_id: bill.bill_id,
                room_id: roomId,
                items: [
                    { title: 'ค่าน้ำ', amount: bill.water_fee },
                    { title: 'ค่าไฟ', amount: bill.electricity_fee },
                    { title: 'ค่าทิ้งขยะ', amount: bill.other_fees },
                    { title: 'ค่าห้อง', amount: bill.rent },
                ],
                total: bill.total,
                bill_status: bill.bill_status,
                date: bill.date,
                pay: bill.pay
            });
        } else {
            res.status(404).json({ message: 'No billing information found for this room' });
        }
    } catch (err) {
        res.status(500).json({ message: 'Internal server error', error: err });
    }
});



// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
