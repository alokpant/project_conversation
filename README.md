# Project Documentation


### Overview

The task is to build a conversation history for a project where users can leave comments and change the status of the project. The conversation history should capture both the comments and the status changes for a given project and present them in an easy-to-read format. This feature will help users track the progress and discussions surrounding a project.

### Questions
a. What should be included in the conversation history?
b. How should we handle the user permissions for comments and status changes?
c. How should we represent the status change in the history?
d. What information should be recorded for each comment and status change?
e. Are Project History available to all users? Will everyone be able to comment, update or create Projects?
f. How will the conversation history be presented to the user?

### Assumptions
Here are the assumptions I made based on the answers to the questions:
a. The conversation history will include both comments and status changes. Therefore, two models are required: Comment and StatusChange.
b. Comments can be left by any user with access to the project, but only the project owner can change the status. This means we need to enforce role-based access control for status changes.
c. A status change needs to record both the old and new status of the project. This means the StatusChange model will store the previous and new statuses.
d. The Comment model will store the content of the comment, the user who left it, and the timestamp. The StatusChange model will store the user, the old and new statuses, and the timestamp of the status change.
e. The conversation history will be displayed in a list format showing the details (user, timestamp, action). Comments and status changes will be grouped together in chronological order.
f. The projects table will store the status attribute that represents the current status of the project, while the comments and status_changes tables will be used to track the history.

### Solution

#### Database Schema

##### Project Model
Represents a project.

- Attributes: name, status (string), user_id (foreign key to user)

- Relationships:
  - A project has many comments.
  - A project has many status changes.

##### Comment Model
Represents a comment on a project.
  - Attributes: body (string), user_id (foreign key to user), project_id (foreign key to project)

  - Relationships:
    - A comment belongs to a user.
    - A comment belongs to a project.

##### StatusChange
Represents a change in the project's status.
  - Attributes: previous_status (string), new_status (string), user_id (foreign key to user), project_id (foreign key to project)

  - Relationships:
    - A status change belongs to a user.
    - A status change belongs to a project.


### Running the Project

#### Setup Instructions

**Clone the repository**:
```
git clone git@github.com:alokpant/project_conversation.git
cd project_conversation
```

**Install dependencies:**
```
bundle install
```

**Set up the database:**
```
rails db:create db:migrate db:seed
```

**Start the Rails server:**
```
rails s
```

**Run the tests:**
```
rails test
```