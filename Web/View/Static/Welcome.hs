module Web.View.Static.Welcome where
import Web.View.Prelude

data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|
        <div class="task-app">
            <div class="task-container">
                <header class="app-header">
                    <h1>🗒️ Lista de Tareas</h1>
                    <p>Organiza tus actividades diarias</p>
                </header>

                <!-- Panel mejorado -->
                <div class="action-panel">
                    <div class="search-box">
                        <input type="text" id="search-input" placeholder="Buscar..." class="search-input"/>
                        <button class="search-button" id="search-btn">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
                                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                            </svg>
                        </button>
                    </div>
                    <button class="add-button" id="show-modal-btn">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16" class="button-icon">
                            <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                        </svg>
                        Nueva Tarea
                    </button>
                </div>

                <!-- Filtros combinados -->
                <div class="filters">
                    <div class="filter-group">
                        <button class="filter-button active" data-filter="all">Todas</button>
                        <button class="filter-button" data-filter="pending">Pendientes</button>
                        <button class="filter-button" data-filter="completed">Completadas</button>
                    </div>
                    <div class="filter-group">
                        <select id="priority-filter" class="filter-select">
                            <option value="all">Cualquier prioridad</option>
                            <option value="high">Alta prioridad</option>
                            <option value="medium">Media prioridad</option>
                            <option value="low">Baja prioridad</option>
                        </select>
                    </div>
                </div>

                <!-- Tabla mejorada -->
                <div class="task-table-container">
                    <table class="task-table">
                        <thead>
                            <tr>
                                <th width="40%">Tarea</th>
                                <th width="20%">Estado</th>
                                <th width="20%">Fecha</th>
                                <th width="20%">Acciones</th>
                            </tr>
                        </thead>
                        <tbody id="task-list">
                            <!-- Dinámico -->
                        </tbody>
                    </table>
                </div>

                <!-- Resumen estadístico -->
                <div class="task-stats">
                    <div class="stat-card">
                        <span class="stat-count" id="total-count">0</span>
                        <span class="stat-label">Total</span>
                    </div>
                    <div class="stat-card">
                        <span class="stat-count" id="pending-count">0</span>
                        <span class="stat-label">Pendientes</span>
                    </div>
                    <div class="stat-card">
                        <span class="stat-count" id="completed-count">0</span>
                        <span class="stat-label">Completadas</span>
                    </div>
                    <div class="stat-card">
                        <span class="stat-count" id="high-priority-count">0</span>
                        <span class="stat-label">Urgentes</span>
                    </div>
                </div>
            </div>

            <!-- Modal mejorado -->
            <div id="task-modal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 id="modal-title">Nueva Tarea</h2>
                        <button class="close-modal">&times;</button>
                    </div>
                    <form id="task-form">
                        <input type="hidden" id="task-id">
                        
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="task-name-input">Nombre*</label>
                                <input type="text" id="task-name-input" required class="form-input">
                            </div>
                            
                            <div class="form-group">
                                <label for="task-date">Fecha*</label>
                                <input type="date" id="task-date" required class="form-input">
                            </div>
                            
                            <div class="form-group">
                                <label for="task-status">Estado*</label>
                                <select id="task-status" required class="form-input">
                                    <option value="pending">Pendiente</option>
                                    <option value="completed">Completada</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="task-priority">Prioridad*</label>
                                <select id="task-priority" required class="form-input">
                                    <option value="low">Baja</option>
                                    <option value="medium" selected>Media</option>
                                    <option value="high">Alta</option>
                                </select>
                            </div>
                            
                            <div class="form-group full-width">
                                <label for="task-description">Descripción</label>
                                <textarea id="task-description" rows="3" class="form-input"></textarea>
                            </div>
                            
                            <div class="form-group full-width">
                                <label for="task-tags">Etiquetas <small>(separadas por comas)</small></label>
                                <input type="text" id="task-tags" placeholder="trabajo, personal, urgente" class="form-input">
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <button type="button" id="cancel-task" class="btn btn-secondary">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Guardar Tarea</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Modal de confirmación -->
            <div id="confirm-modal" class="modal">
                <div class="modal-content confirm-content">
                    <div class="modal-header">
                        <h2>Confirmar</h2>
                        <button class="close-modal">&times;</button>
                    </div>
                    <p>¿Estás seguro de eliminar esta tarea?</p>
                    <div class="modal-actions">
                        <button id="cancel-delete" class="btn btn-secondary">Cancelar</button>
                        <button id="confirm-delete" class="btn btn-danger">Eliminar</button>
                    </div>
                </div>
            </div>
        </div>

        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --success-color: #4cc9f0;
                --danger-color: #f72585;
                --warning-color: #f8961e;
                --light-color: #f8f9fa;
                --dark-color: #212529;
            }
            
            /* Estructura principal */
            .task-app {
                min-height: 100vh;
                background: linear-gradient(135deg, #f6f7fc 0%, #e9ecff 100%);
                padding: 2rem;
                font-family: 'Segoe UI', system-ui, sans-serif;
            }
            
            .task-container {
                max-width: 1200px;
                margin: 0 auto;
                background: white;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                padding: 2rem;
            }
            
            .app-header {
                text-align: center;
                margin-bottom: 2rem;
                padding-bottom: 1.5rem;
                border-bottom: 1px solid #eee;
            }
            
            .app-header h1 {
                color: var(--primary-color);
                font-size: 2.2rem;
                margin-bottom: 0.5rem;
                font-weight: 600;
            }
            
            .app-header p {
                color: #666;
                font-size: 1.05rem;
            }
            
            /* Panel de acciones */
            .action-panel {
                display: flex;
                justify-content: space-between;
                gap: 1rem;
                margin-bottom: 1.5rem;
                flex-wrap: wrap;
            }
            
            .search-box {
                display: flex;
                flex: 1;
                min-width: 300px;
                position: relative;
            }
            
            .search-input {
                flex: 1;
                padding: 0.75rem 1rem;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 1rem;
                transition: all 0.2s;
                padding-left: 2.5rem;
            }
            
            .search-input:focus {
                border-color: var(--primary-color);
                outline: none;
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
            }
            
            .search-button {
                position: absolute;
                left: 0.75rem;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                color: #666;
                cursor: pointer;
            }
            
            .add-button {
                background-color: var(--primary-color);
                color: white;
                border: none;
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 500;
                font-size: 1rem;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                transition: all 0.2s;
            }
            
            .add-button:hover {
                background-color: var(--secondary-color);
                transform: translateY(-1px);
            }
            
            /* Filtros */
            .filters {
                display: flex;
                gap: 1rem;
                margin-bottom: 1.5rem;
                flex-wrap: wrap;
            }
            
            .filter-group {
                display: flex;
                gap: 0.5rem;
                align-items: center;
            }
            
            .filter-button {
                padding: 0.5rem 1rem;
                border-radius: 20px;
                border: 1px solid #ddd;
                background: white;
                cursor: pointer;
                font-size: 0.9rem;
                transition: all 0.2s;
            }
            
            .filter-button:hover {
                background-color: #f5f5f5;
            }
            
            .filter-button.active {
                background-color: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }
            
            .filter-select {
                padding: 0.5rem 1rem;
                border-radius: 20px;
                border: 1px solid #ddd;
                font-size: 0.9rem;
                cursor: pointer;
            }
            
            /* Tabla */
            .task-table-container {
                overflow-x: auto;
                margin-bottom: 2rem;
                border-radius: 8px;
                border: 1px solid #eee;
            }
            
            .task-table {
                width: 100%;
                border-collapse: collapse;
            }
            
            .task-table th {
                background-color: #f8f9fa;
                padding: 1rem;
                text-align: left;
                font-weight: 600;
                color: #333;
                border-bottom: 2px solid #eee;
            }
            
            .task-table td {
                padding: 1rem;
                border-bottom: 1px solid #eee;
                vertical-align: top;
            }
            
            .task-table tr:last-child td {
                border-bottom: none;
            }
            
            .task-table tr:hover td {
                background-color: #fafafa;
            }
            
            /* Elementos de tarea */
            .task-name {
                font-weight: 500;
                color: #333;
            }
            
            .task-description {
                color: #666;
                font-size: 0.9rem;
                margin-top: 0.5rem;
                line-height: 1.4;
            }
            
            .task-tags {
                display: flex;
                gap: 0.5rem;
                flex-wrap: wrap;
                margin-top: 0.75rem;
            }
            
            .task-tag {
                background-color: #e3f2fd;
                color: #1565c0;
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 500;
            }
            
            .status {
                display: inline-flex;
                align-items: center;
                gap: 0.25rem;
                padding: 0.35rem 0.75rem;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 500;
            }
            
            .status.completed {
                background-color: #e8f5e9;
                color: #2e7d32;
            }
            
            .status.pending {
                background-color: #fff8e1;
                color: #ff8f00;
            }
            
            .priority {
                display: inline-flex;
                align-items: center;
                gap: 0.25rem;
                margin-left: 0.5rem;
                font-size: 0.8rem;
            }
            
            .priority-high {
                color: #d32f2f;
            }
            
            .priority-medium {
                color: #ff9800;
            }
            
            .priority-low {
                color: #4caf50;
            }
            
            /* Acciones */
            .task-actions {
                display: flex;
                gap: 0.5rem;
            }
            
            .action-button {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                border: none;
                background: none;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s;
            }
            
            .action-button:hover {
                background-color: #f0f0f0;
            }
            
            .edit-button {
                color: var(--primary-color);
            }
            
            .delete-button {
                color: var(--danger-color);
            }
            
            /* Estadísticas */
            .task-stats {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                gap: 1rem;
                margin-bottom: 2rem;
            }
            
            .stat-card {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 1rem;
                text-align: center;
            }
            
            .stat-count {
                display: block;
                font-size: 1.75rem;
                font-weight: 600;
                color: var(--primary-color);
                margin-bottom: 0.25rem;
            }
            
            .stat-label {
                color: #666;
                font-size: 0.9rem;
            }
            
            /* Modales */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 1000;
                justify-content: center;
                align-items: center;
            }
            
            .modal-content {
                background-color: white;
                border-radius: 12px;
                width: 100%;
                max-width: 600px;
                animation: modalOpen 0.3s ease-out;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            }
            
            .modal-header {
                padding: 1.25rem 1.5rem;
                border-bottom: 1px solid #eee;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .modal-header h2 {
                margin: 0;
                font-size: 1.5rem;
                color: #333;
            }
            
            .close-modal {
                background: none;
                border: none;
                font-size: 1.75rem;
                cursor: pointer;
                color: #666;
                transition: color 0.2s;
            }
            
            .close-modal:hover {
                color: #333;
            }
            
            /* Formulario */
            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
                padding: 1.5rem;
            }
            
            .form-group {
                margin-bottom: 0;
            }
            
            .form-group.full-width {
                grid-column: span 2;
            }
            
            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
                color: #444;
                font-size: 0.95rem;
            }
            
            .form-group small {
                color: #666;
                font-size: 0.85rem;
            }
            
            .form-input {
                width: 100%;
                padding: 0.75rem;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 1rem;
                transition: all 0.2s;
            }
            
            .form-input:focus {
                border-color: var(--primary-color);
                outline: none;
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
            }
            
            textarea.form-input {
                min-height: 100px;
                resize: vertical;
            }
            
            /* Botones */
            .form-actions {
                padding: 1rem 1.5rem;
                border-top: 1px solid #eee;
                display: flex;
                justify-content: flex-end;
                gap: 1rem;
            }
            
            .btn {
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s;
                border: none;
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                color: white;
            }
            
            .btn-primary:hover {
                background-color: var(--secondary-color);
                transform: translateY(-1px);
            }
            
            .btn-secondary {
                background-color: #f0f0f0;
                color: #333;
            }
            
            .btn-secondary:hover {
                background-color: #e0e0e0;
            }
            
            .btn-danger {
                background-color: var(--danger-color);
                color: white;
            }
            
            .btn-danger:hover {
                background-color: #e91e63;
                transform: translateY(-1px);
            }
            
            /* Animaciones */
            @keyframes modalOpen {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            /* Responsive */
            @media (max-width: 768px) {
                .task-container {
                    padding: 1.5rem;
                }
                
                .form-grid {
                    grid-template-columns: 1fr;
                }
                
                .form-group.full-width {
                    grid-column: span 1;
                }
                
                .action-panel {
                    flex-direction: column;
                }
                
                .search-box {
                    min-width: 100%;
                }
            }
        </style>

        <script>
        document.addEventListener('DOMContentLoaded', function() {
            // ========== CONSTANTES ==========
            const STORAGE_KEY = 'tasks-app-pro';
            const PRIORITY_COLORS = {
                high: 'priority-high',
                medium: 'priority-medium',
                low: 'priority-low'
            };
            
            // ========== ELEMENTOS DOM ==========
            const elements = {
                taskList: document.getElementById('task-list'),
                showModalBtn: document.getElementById('show-modal-btn'),
                taskModal: document.getElementById('task-modal'),
                confirmModal: document.getElementById('confirm-modal'),
                taskForm: document.getElementById('task-form'),
                searchInput: document.getElementById('search-input'),
                filterButtons: document.querySelectorAll('.filter-button'),
                priorityFilter: document.getElementById('priority-filter'),
                counters: {
                    total: document.getElementById('total-count'),
                    pending: document.getElementById('pending-count'),
                    completed: document.getElementById('completed-count'),
                    highPriority: document.getElementById('high-priority-count')
                }
            };
            
            // ========== ESTADO ==========
            let state = {
                tasks: loadTasks(),
                currentFilter: 'all',
                currentPriorityFilter: 'all',
                currentTaskId: null
            };
            
            // ========== INICIALIZACIÓN ==========
            init();
            
            // ========== FUNCIONES PRINCIPALES ==========
            function init() {
                renderTasks();
                setupEventListeners();
                
                // Cargar tareas de ejemplo si no hay
                if (state.tasks.length === 0) {
                    loadSampleTasks();
                    renderTasks();
                }
            }
            
            function loadSampleTasks() {
                const samples = [
                    {
                        name: "Terminar el proyecto IHP",
                        description: "Completar todas las funcionalidades pendientes",
                        status: "pending",
                        priority: "high",
                        tags: ["trabajo", "urgente"],
                        date: new Date(Date.now() + 86400000 * 2).toISOString().split('T')[0] // 2 días después
                    },
                    {
                        name: "Revisar documentación",
                        description: "Leer la guía oficial de IHP",
                        status: "pending",
                        priority: "medium",
                        tags: ["aprendizaje"],
                        date: new Date().toISOString().split('T')[0] // Hoy
                    },
                    {
                        name: "Configurar entorno",
                        description: "Instalar todas las dependencias necesarias",
                        status: "completed",
                        priority: "low",
                        tags: ["setup"],
                        date: new Date(Date.now() - 86400000).toISOString().split('T')[0] // Ayer
                    }
                ];
                
                samples.forEach(task => addTask(
                    task.name,
                    task.status,
                    task.date,
                    task.priority,
                    task.tags,
                    task.description
                ));
            }
            
            // ========== FUNCIONES DE TAREAS ==========
            function addTask(name, status, date, priority = 'medium', tags = [], description = '') {
                const task = {
                    id: Date.now(),
                    name,
                    status,
                    date,
                    priority,
                    tags: Array.isArray(tags) ? tags : tags.split(',').map(t => t.trim()).filter(t => t),
                    description,
                    createdAt: new Date().toISOString(),
                    updatedAt: new Date().toISOString()
                };
                
                state.tasks.push(task);
                saveTasks();
                return task;
            }
            
            function updateTask(id, updates) {
                const task = state.tasks.find(t => t.id === id);
                if (task) {
                    Object.assign(task, updates, { updatedAt: new Date().toISOString() });
                    saveTasks();
                    return task;
                }
                return null;
            }
            
            function deleteTask(id) {
                state.tasks = state.tasks.filter(t => t.id !== id);
                saveTasks();
            }
            
            function getFilteredTasks() {
                let filtered = [...state.tasks];
                
                // Filtrar por estado
                if (state.currentFilter !== 'all') {
                    filtered = filtered.filter(t => t.status === state.currentFilter);
                }
                
                // Filtrar por prioridad
                if (state.currentPriorityFilter !== 'all') {
                    filtered = filtered.filter(t => t.priority === state.currentPriorityFilter);
                }
                
                // Filtrar por búsqueda
                const searchTerm = elements.searchInput.value.trim().toLowerCase();
                if (searchTerm) {
                    filtered = filtered.filter(t => 
                        t.name.toLowerCase().includes(searchTerm) || 
                        (t.description && t.description.toLowerCase().includes(searchTerm)) ||
                        t.tags.some(tag => tag.toLowerCase().includes(searchTerm))
                    );
                }
                
                return filtered;
            }
            
            // ========== RENDERIZADO ==========
            function renderTasks() {
                const tasks = getFilteredTasks();
                elements.taskList.innerHTML = tasks.length > 0 
                    ? tasks.map(renderTask).join('')
                    : `<tr><td colspan="4" class="empty-message">No hay tareas que coincidan</td></tr>`;
                
                updateCounters();
                setupTaskEventListeners();
            }
            
            function renderTask(task) {
                const statusClass = task.status === 'completed' ? 'completed' : 'pending';
                const statusText = task.status === 'completed' ? 'Completada' : 'Pendiente';
                const priorityClass = PRIORITY_COLORS[task.priority] || '';
                
                return `
                    <tr data-id="${task.id}">
                        <td>
                            <div class="task-name">${escapeHtml(task.name)}</div>
                            ${task.description ? `<div class="task-description">${escapeHtml(task.description)}</div>` : ''}
                            ${task.tags.length > 0 ? `
                                <div class="task-tags">
                                    ${task.tags.map(tag => `<span class="task-tag">${escapeHtml(tag)}</span>`).join('')}
                                </div>
                            ` : ''}
                        </td>
                        <td>
                            <span class="status ${statusClass}">
                                ${statusText}
                                <span class="priority ${priorityClass}">
                                    ${task.priority === 'high' ? '▲' : task.priority === 'medium' ? '●' : '▼'}
                                </span>
                            </span>
                        </td>
                        <td>${formatDate(task.date)}</td>
                        <td>
                            <div class="task-actions">
                                <button class="action-button edit-button" data-id="${task.id}" title="Editar">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                        <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                                    </svg>
                                </button>
                                <button class="action-button delete-button" data-id="${task.id}" title="Eliminar">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                        <path d="M3 6h18"></path>
                                        <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                    </svg>
                                </button>
                            </div>
                        </td>
                    </tr>
                `;
            }
            
            function updateCounters() {
                const stats = {
                    total: state.tasks.length,
                    completed: state.tasks.filter(t => t.status === 'completed').length,
                    highPriority: state.tasks.filter(t => t.priority === 'high').length
                };
                
                elements.counters.total.textContent = stats.total;
                elements.counters.pending.textContent = stats.total - stats.completed;
                elements.counters.completed.textContent = stats.completed;
                elements.counters.highPriority.textContent = stats.highPriority;
            }
            
            // ========== MANEJO DE EVENTOS ==========
            function setupEventListeners() {
                // Modal
                elements.showModalBtn.addEventListener('click', () => showTaskForm());
                document.querySelectorAll('.close-modal').forEach(btn => {
                    btn.addEventListener('click', () => closeAllModals());
                });
                
                // Formulario
                elements.taskForm.addEventListener('submit', handleFormSubmit);
                document.getElementById('cancel-task').addEventListener('click', () => {
                    elements.taskModal.style.display = 'none';
                });
                
                // Filtros
                elements.filterButtons.forEach(btn => {
                    btn.addEventListener('click', () => {
                        elements.filterButtons.forEach(b => b.classList.remove('active'));
                        btn.classList.add('active');
                        state.currentFilter = btn.dataset.filter;
                        renderTasks();
                    });
                });
                
                elements.priorityFilter.addEventListener('change', (e) => {
                    state.currentPriorityFilter = e.target.value;
                    renderTasks();
                });
                
                // Búsqueda
                elements.searchInput.addEventListener('input', debounce(() => {
                    renderTasks();
                }, 300));
                
                // Cerrar modales al hacer clic fuera
                window.addEventListener('click', (e) => {
                    if (e.target === elements.taskModal || e.target === elements.confirmModal) {
                        closeAllModals();
                    }
                });
                
                // Confirmación de eliminación
                document.getElementById('confirm-delete').addEventListener('click', () => {
                    if (state.currentTaskId) {
                        deleteTask(state.currentTaskId);
                        elements.confirmModal.style.display = 'none';
                        state.currentTaskId = null;
                        renderTasks();
                    }
                });
                
                document.getElementById('cancel-delete').addEventListener('click', () => {
                    elements.confirmModal.style.display = 'none';
                    state.currentTaskId = null;
                });
            }
            
            function setupTaskEventListeners() {
                document.querySelectorAll('.edit-button').forEach(btn => {
                    btn.addEventListener('click', (e) => {
                        const taskId = parseInt(e.currentTarget.dataset.id);
                        showTaskForm(taskId);
                    });
                });
                
                document.querySelectorAll('.delete-button').forEach(btn => {
                    btn.addEventListener('click', (e) => {
                        state.currentTaskId = parseInt(e.currentTarget.dataset.id);
                        elements.confirmModal.style.display = 'flex';
                    });
                });
            }
            
            // ========== MANEJO DE FORMULARIO ==========
            function showTaskForm(taskId = null) {
                const form = elements.taskForm;
                const modalTitle = document.getElementById('modal-title');
                
                if (taskId) {
                    // Modo edición
                    const task = state.tasks.find(t => t.id === taskId);
                    if (task) {
                        modalTitle.textContent = 'Editar Tarea';
                        form.elements['task-id'].value = task.id;
                        form.elements['task-name-input'].value = task.name;
                        form.elements['task-status'].value = task.status;
                        form.elements['task-priority'].value = task.priority;
                        form.elements['task-date'].value = task.date;
                        form.elements['task-tags'].value = task.tags.join(', ');
                        form.elements['task-description'].value = task.description || '';
                    }
                } else {
                    // Modo nueva tarea
                    modalTitle.textContent = 'Nueva Tarea';
                    form.reset();
                    form.elements['task-date'].value = new Date().toISOString().split('T')[0];
                    form.elements['task-priority'].value = 'medium';
                }
                
                elements.taskModal.style.display = 'flex';
            }
            
            function handleFormSubmit(e) {
                e.preventDefault();
                const form = e.target;
                const formData = new FormData(form);
                
                const taskData = {
                    name: formData.get('task-name-input'),
                    status: formData.get('task-status'),
                    date: formData.get('task-date'),
                    priority: formData.get('task-priority'),
                    tags: formData.get('task-tags').split(',').map(t => t.trim()).filter(t => t),
                    description: formData.get('task-description')
                };
                
                const taskId = formData.get('task-id');
                if (taskId) {
                    updateTask(parseInt(taskId), taskData);
                } else {
                    addTask(
                        taskData.name,
                        taskData.status,
                        taskData.date,
                        taskData.priority,
                        taskData.tags,
                        taskData.description
                    );
                }
                
                elements.taskModal.style.display = 'none';
                renderTasks();
            }
            
            // ========== UTILIDADES ==========
            function loadTasks() {
                try {
                    const data = localStorage.getItem(STORAGE_KEY);
                    return data ? JSON.parse(data) : [];
                } catch (e) {
                    console.error("Error loading tasks:", e);
                    return [];
                }
            }
            
            function saveTasks() {
                localStorage.setItem(STORAGE_KEY, JSON.stringify(state.tasks));
            }
            
            function closeAllModals() {
                elements.taskModal.style.display = 'none';
                elements.confirmModal.style.display = 'none';
            }
            
            function formatDate(dateString) {
                const options = { day: '2-digit', month: '2-digit', year: 'numeric' };
                return new Date(dateString).toLocaleDateString('es-ES', options);
            }
            
            function escapeHtml(unsafe) {
                return unsafe
                    .replace(/&/g, "&amp;")
                    .replace(/</g, "&lt;")
                    .replace(/>/g, "&gt;")
                    .replace(/"/g, "&quot;")
                    .replace(/'/g, "&#039;");
            }
            
            function debounce(func, timeout = 300) {
                let timer;
                return (...args) => {
                    clearTimeout(timer);
                    timer = setTimeout(() => { func.apply(this, args); }, timeout);
                };
            }
        });
        </script>
    |]