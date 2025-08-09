# Pizza Management API

A comprehensive RESTful API for managing pizzas and toppings with role-based authentication and authorization. Built with Ruby on Rails and designed to support pizza store operations with different user roles.

## Overview

This application provides a backend API for pizza management with the following key features:

- **Role-based Authentication**: JWT-based authentication with three user roles (Super Admin, Pizza Store Owner, Pizza Chef)
- **Pizza Management**: Full CRUD operations for pizzas with topping associations
- **Topping Management**: Complete topping management with price tracking
- **Authorization**: Policy-based access control using Pundit
- **Data Persistence**: PostgreSQL database for reliable data storage
- **API Documentation**: RESTful API design with JSON responses

## Technical Choices

### Architecture & Framework

- **Ruby on Rails (API-only)**: Chosen for rapid development, convention over configuration, and robust ecosystem
- **PostgreSQL**: Selected for ACID compliance, reliability, and excellent Rails integration
- **JWT Authentication**: Stateless authentication suitable for API consumption
- **Pundit Authorization**: Policy-based authorization for granular access control

### Key Design Decisions

- **Role-based Access Control**: Three distinct roles to match real-world pizza operations
- **Many-to-Many Relationships**: Flexible pizza-topping associations allowing complex recipes
- **JSON API Serializers**: Consistent API responses with relationship data
- **Error Handling**: Comprehensive error responses with detailed validation messages

## Prerequisites

- Ruby 3.2.0 or higher
- PostgreSQL 14+
- Node.js (for Rails asset pipeline)
- Git

## System Dependencies

- Rails 8.0
- PostgreSQL adapter (pg gem)
- JWT for authentication
- Pundit for authorization
- RSpec for testing
- FactoryBot for test data

## Local Development Setup

### 1. Clone the Repository

```bash
git clone <git@github.com:manhxnguyen/sm_pizza_backend.git>
cd sm_pizza_backend
```

### 2. Install Database and Dependencies

```bash
# Install PostgreSQL on macOS with Homebrew:
brew install postgresql
brew services start postgresql

# Install Ruby dependencies
bundle install
```

### 3. Database Configuration

After installing PostgreSQL, you need to configure the database connection in `config/database.yml`:

```yaml
# config/database.yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: sm_pizza_backend_development
  username: postgres
  password: postgres # Change this to your PostgreSQL password
  host: localhost
  port: 5432

test:
  <<: *default
  database: sm_pizza_backend_test
  username: postgres
  password: postgres # Change this to your PostgreSQL password
  host: localhost
  port: 5432
```

**Note**: Update the `username` and `password` in `database.yml` to match your local PostgreSQL configuration.

### 4. Database Setup

```bash
# Create and setup database
rails db:create
rails db:migrate

# Seed with initial data (optional)
rails db:seed
```

### 5. Environment Configuration

Create a `.env` file in the root directory (optional for development):

```bash
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/sm_pizza_backend_development
RAILS_MASTER_KEY=<your-master-key>
```

### 6. Start the Server

```bash
# Development server
rails server -p 3001

# Or using the dev script
PORT=3001 bin/dev
```

The API will be available at `http://localhost:3001`

## Running Tests

This project includes a comprehensive test suite using RSpec with FactoryBot for test data generation.

### Run All Tests

```bash
# Run the complete test suite
bundle exec rspec

# Or using Rails test command
rails test

# Run with coverage report
COVERAGE=true bundle exec rspec
```

### Run Specific Test Types

```bash
# Run model tests only
bundle exec rspec spec/models/

# Run controller/request tests
bundle exec rspec spec/requests/

# Run specific test file
bundle exec rspec spec/models/pizza_spec.rb

# Run tests with specific tag
bundle exec rspec --tag focus
```

### Test Categories Covered

- **Model Tests**: Validations, associations, and business logic
- **Request Tests**: API endpoints and HTTP responses
- **Policy Tests**: Authorization rules and permissions
- **Factory Tests**: Test data generation and validity

### Continuous Integration

The project includes GitHub Actions CI/CD pipeline that runs:

- **Security Scanning**: Brakeman for Rails security vulnerabilities
- **Code Linting**: RuboCop for code style and quality
- **Test Suite**: Complete RSpec test execution
- **Database Testing**: PostgreSQL integration tests

## API Endpoints

### Authentication

- `POST /api/v1/login` - User authentication
- `GET /api/v1/profile` - Get user profile
- `DELETE /api/v1/logout` - User logout

### Dashboard

- `GET /api/v1/dashboard` - Get dashboard statistics (Authenticated users)

### Toppings Management

- `GET /api/v1/toppings` - List all toppings
- `POST /api/v1/toppings` - Create new topping (Store Owner + Admin)
- `GET /api/v1/toppings/:id` - Get specific topping
- `PUT /api/v1/toppings/:id` - Update topping (Store Owner + Admin)
- `DELETE /api/v1/toppings/:id` - Delete topping (Store Owner + Admi)

### Pizza Management

- `GET /api/v1/pizzas` - List all pizzas
- `POST /api/v1/pizzas` - Create new pizza (Chef + Admin)
- `GET /api/v1/pizzas/:id` - Get specific pizza
- `PUT /api/v1/pizzas/:id` - Update pizza (Chef + Admin)
- `DELETE /api/v1/pizzas/:id` - Delete pizza (Chef + Admin)
- `POST /api/v1/pizzas/:id/add_topping` - Add topping to pizza (Chef + Admin)
- `DELETE /api/v1/pizzas/:id/remove_topping` - Remove topping from pizza (Chef + Admin)

## User Roles & Permissions

### Super Admin

- Full access to all resources
- System-wide permissions

### Pizza Store Owner

- Manage toppings (create, update, delete)
- View all pizzas and statistics
- Topping inventory control

### Pizza Chef

- Create and manage pizzas
- Add/remove toppings from pizzas
- View available toppings

## Code Quality & Best Practices

### Code Style

- RuboCop configuration for consistent styling
- Rails best practices and conventions
- Comprehensive error handling

### Security

- JWT token-based authentication
- Role-based authorization policies
- SQL injection prevention through ActiveRecord
- CORS configuration for cross-origin requests

### Performance

- Database indexing for frequently queried fields
- Eager loading to prevent N+1 queries
- Pagination for large datasets

## Deployment

The application is configured for deployment with:

- **Docker**: Containerization support
- **Kamal**: Deployment configuration
- **Environment Variables**: Production configuration
- **Database Migrations**: Automated schema updates

### Production Considerations

- Set `RAILS_MASTER_KEY` environment variable
- Configure database connection string
- Set up SSL certificates
- Configure CORS for frontend domains

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/example-feature`)
3. Commit your changes (`git commit -m 'Add example feature'`)
4. Push to the branch (`git push origin feature/example-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
