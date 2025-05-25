import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Container, Table, Button, Modal, Form, Alert, Badge, ToggleButton, ToggleButtonGroup, Tab, Tabs } from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';

function App() {
  const [classrooms, setClassrooms] = useState([]);
  const [teachers, setTeachers] = useState([]);
  const [sections, setSections] = useState([]);
  const [showModal, setShowModal] = useState(false);
  const [selectedClassroom, setSelectedClassroom] = useState(null);
  const [selectedStatus, setSelectedStatus] = useState('Vacant');
  const [selectedTeacher, setSelectedTeacher] = useState('');
  const [timetable, setTimetable] = useState([]);
  const [sectionTimetable, setSectionTimetable] = useState([]);
  const [showTimetable, setShowTimetable] = useState(false);
  const [showSectionTimetable, setShowSectionTimetable] = useState(false);
  const [alert, setAlert] = useState({ show: false, message: '', variant: 'success' });
  const [autoUpdate, setAutoUpdate] = useState(true);
  const [currentTime, setCurrentTime] = useState(new Date());
  const [activeTab, setActiveTab] = useState('classrooms');

  // Update current time every minute
  useEffect(() => {
    const timer = setInterval(() => {
      setCurrentTime(new Date());
    }, 60000);
    return () => clearInterval(timer);
  }, []);

  // Fetch data
  useEffect(() => {
    fetchClassrooms();
    fetchTeachers();
    fetchSections();

    if (autoUpdate) {
      const interval = setInterval(() => {
        fetchClassrooms();
      }, 30000); // Update every 30 seconds
      return () => clearInterval(interval);
    }
  },);

  const fetchClassrooms = async () => {
    try {
      const response = await axios.get('http://localhost:5000/api/classrooms');
      setClassrooms(response.data);
    } catch (error) {
      console.error('Error fetching classrooms:', error);
      showAlert('Error fetching classrooms', 'danger');
    }
  };

  const fetchTeachers = async () => {
    try {
      const response = await axios.get('http://localhost:5000/api/teachers');
      setTeachers(response.data);
    } catch (error) {
      console.error('Error fetching teachers:', error);
    }
  };

  const fetchSections = async () => {
    try {
      const response = await axios.get('http://localhost:5000/api/sections');
      setSections(response.data);
    } catch (error) {
      console.error('Error fetching sections:', error);
    }
  };

  const fetchTimetable = async (roomId) => {
    try {
      const response = await axios.get(`http://localhost:5000/api/classrooms/${roomId}/timetable`);
      setTimetable(response.data);
      setShowTimetable(true);
    } catch (error) {
      console.error('Error fetching timetable:', error);
      showAlert('Error fetching timetable', 'danger');
    }
  };

  const fetchSectionTimetable = async (sectionId) => {
    try {
      const response = await axios.get(`http://localhost:5000/api/sections/${sectionId}/timetable`);
      setSectionTimetable(response.data);
      setShowSectionTimetable(true);
    } catch (error) {
      console.error('Error fetching section timetable:', error);
      showAlert('Error fetching section timetable', 'danger');
    }
  };

  const showAlert = (message, variant) => {
    setAlert({ show: true, message, variant });
    setTimeout(() => setAlert({ ...alert, show: false }), 3000);
  };

  const handleStatusChange = (classroom) => {
    setSelectedClassroom(classroom);
    setSelectedStatus(classroom.current_status || 'Vacant');
    setSelectedTeacher(classroom.updated_by || '');
    setShowModal(true);
  };

  const handleSubmit = async () => {
    try {
      await axios.put(`http://localhost:5000/api/classrooms/${selectedClassroom.room_id}/status`, {
        status: selectedStatus,
        teacherId: selectedTeacher
      });
      fetchClassrooms();
      setShowModal(false);
      showAlert('Status updated successfully', 'success');
    } catch (error) {
      console.error('Error updating status:', error);
      showAlert('Error updating status', 'danger');
    }
  };

  const formatTime = (timeString) => {
    if (!timeString) return '';
    const time = new Date(`2000-01-01T${timeString}`);
    return time.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  };

  const getStatusBadge = (classroom) => {
    const isAuto = classroom.update_method === 'auto';
    const variant = classroom.current_status === 'Occupied' 
      ? 'danger' 
      : classroom.current_status === 'Maintenance' 
        ? 'warning' 
        : 'success';
    
    return (
      <Badge bg={variant}>
        {classroom.current_status || 'Vacant'}
        {isAuto && classroom.current_status === 'Occupied' && (
          <span className="ms-1">(Auto)</span>
        )}
      </Badge>
    );
  };

  return (
    <Container className="mt-4">
      <h1 className="mb-4">Classroom Occupancy Tracker</h1>
      <div className="d-flex justify-content-between mb-3">
        <div>Current Time: {currentTime.toLocaleTimeString()}</div>
        <ToggleButtonGroup
          type="radio"
          name="options"
          value={autoUpdate}
          onChange={(val) => setAutoUpdate(val)}
        >
          <ToggleButton id="auto-btn" value={true} variant={autoUpdate ? 'primary' : 'outline-secondary'}>
            Auto Mode
          </ToggleButton>
          <ToggleButton id="manual-btn" value={false} variant={!autoUpdate ? 'primary' : 'outline-secondary'}>
            Manual Mode
          </ToggleButton>
        </ToggleButtonGroup>
      </div>
      
      {alert.show && (
        <Alert variant={alert.variant} onClose={() => setAlert({ ...alert, show: false })} dismissible>
          {alert.message}
        </Alert>
      )}

      <Tabs
        activeKey={activeTab}
        onSelect={(k) => setActiveTab(k)}
        className="mb-3"
      >
        <Tab eventKey="classrooms" title="Classrooms">
          <Table striped bordered hover responsive className="mt-3">
            <thead>
              <tr>
                <th>Room</th>
                <th>Type</th>
                <th>Capacity</th>
                <th>Current Status</th>
                <th>Last Updated</th>
                <th>Updated By</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {classrooms.map((room) => (
                <tr key={room.room_id}>
                  <td>{room.name}</td>
                  <td>{room.room_type}</td>
                  <td>{room.capacity}</td>
                  <td>{getStatusBadge(room)}</td>
                  <td>{room.last_updated ? new Date(room.last_updated).toLocaleString() : 'N/A'}</td>
                  <td>{room.updated_by || 'System'}</td>
                  <td>
                    <Button 
                      variant="primary" 
                      size="sm" 
                      onClick={() => handleStatusChange(room)}
                      className="me-2"
                      disabled={autoUpdate && room.current_status === 'Occupied' && room.update_method === 'auto'}
                    >
                      Update Status
                    </Button>
                    <Button 
                      variant="info" 
                      size="sm" 
                      onClick={() => fetchTimetable(room.room_id)}
                    >
                      View Timetable
                    </Button>
                  </td>
                </tr>
              ))}
            </tbody>
          </Table>
        </Tab>
        <Tab eventKey="sections" title="Sections">
          <Table striped bordered hover responsive className="mt-3">
            <thead>
              <tr>
                <th>Section Name</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {sections.map((section) => (
                <tr key={section.section_id}>
                  <td>{section.name}</td>
                  <td>
                    <Button 
                      variant="info" 
                      size="sm" 
                      onClick={() => fetchSectionTimetable(section.section_id)}
                    >
                      View Timetable
                    </Button>
                  </td>
                </tr>
              ))}
            </tbody>
          </Table>
        </Tab>
      </Tabs>

      {/* Status Update Modal */}
      <Modal show={showModal} onHide={() => setShowModal(false)}>
        <Modal.Header closeButton>
          <Modal.Title>Update Status for {selectedClassroom?.name}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form>
            <Form.Group className="mb-3">
              <Form.Label>Status</Form.Label>
              <Form.Select 
                value={selectedStatus} 
                onChange={(e) => setSelectedStatus(e.target.value)}
              >
                <option value="Vacant">Vacant</option>
                <option value="Occupied">Occupied</option>
                <option value="Maintenance">Maintenance</option>
              </Form.Select>
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>Updated By (Teacher)</Form.Label>
              <Form.Select 
                value={selectedTeacher} 
                onChange={(e) => setSelectedTeacher(e.target.value)}
              >
                <option value="">Select Teacher</option>
                {teachers.map((teacher) => (
                  <option key={teacher.teacher_id} value={teacher.teacher_id}>
                    {teacher.name}
                  </option>
                ))}
              </Form.Select>
            </Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={() => setShowModal(false)}>
            Cancel
          </Button>
          <Button variant="primary" onClick={handleSubmit}>
            Save Changes
          </Button>
        </Modal.Footer>
      </Modal>

      {/* Classroom Timetable Modal */}
      <Modal 
        show={showTimetable} 
        onHide={() => setShowTimetable(false)}
        size="lg"
      >
        <Modal.Header closeButton>
          <Modal.Title>Timetable for {selectedClassroom?.name}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {timetable.length > 0 ? (
            <Table striped bordered hover>
              <thead>
                <tr>
                  <th>Day</th>
                  <th>Time</th>
                  <th>Section</th>
                  <th>Subject</th>
                  <th>Teacher</th>
                </tr>
              </thead>
              <tbody>
                {timetable.map((item, index) => (
                  <tr key={index}>
                    <td>{item.day_of_week}</td>
                    <td>{formatTime(item.start_time)} - {formatTime(item.end_time)}</td>
                    <td>{item.section_name}</td>
                    <td>{item.subject_name}</td>
                    <td>{item.teacher_name}</td>
                  </tr>
                ))}
              </tbody>
            </Table>
          ) : (
            <p>No timetable entries found for this classroom.</p>
          )}
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={() => setShowTimetable(false)}>
            Close
          </Button>
        </Modal.Footer>
      </Modal>

      {/* Section Timetable Modal */}
      <Modal 
        show={showSectionTimetable} 
        onHide={() => setShowSectionTimetable(false)}
        size="lg"
      >
        <Modal.Header closeButton>
          <Modal.Title>Section Timetable</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {sectionTimetable.length > 0 ? (
            <Table striped bordered hover>
              <thead>
                <tr>
                  <th>Day</th>
                  <th>Time</th>
                  <th>Classroom</th>
                  <th>Subject</th>
                  <th>Teacher</th>
                </tr>
              </thead>
              <tbody>
                {sectionTimetable.map((item, index) => (
                  <tr key={index}>
                    <td>{item.day_of_week}</td>
                    <td>{formatTime(item.start_time)} - {formatTime(item.end_time)}</td>
                    <td>{item.room_name}</td>
                    <td>{item.subject_name}</td>
                    <td>{item.teacher_name}</td>
                  </tr>
                ))}
              </tbody>
            </Table>
          ) : (
            <p>No timetable entries found for this section.</p>
          )}
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={() => setShowSectionTimetable(false)}>
            Close
          </Button>
        </Modal.Footer>
      </Modal>
    </Container>
  );
}

export default App;