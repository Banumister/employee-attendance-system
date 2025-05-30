# GitHub Setup Instructions

## Step 1: Create a New GitHub Repository
- Go to [https://github.com](https://github.com)
- Click on **New repository**
- Name it `employee-attendance-system`
- Add a README, .gitignore for SQL, and license if needed

## Step 2: Push Project from Local Machine
```bash
# Clone the empty repo
git clone https://github.com/your-username/employee-attendance-system.git
cd employee-attendance-system

# Copy contents into repo
cp -r /path/to/unzipped/folder/* .

# Stage and push
git add .
git commit -m "Initial commit - Employee Attendance System"
git push origin main
```