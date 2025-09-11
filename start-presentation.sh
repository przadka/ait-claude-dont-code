#!/bin/bash

# Simple presentation startup script
# Starts local web server and opens presentation in browser

PORT=8000
PRESENTATION_URL="http://localhost:$PORT"

echo "🎯 Starting presentation server..."
echo "📁 Serving from: $(pwd)"
echo "🌐 URL: $PRESENTATION_URL"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Start the server in background
python3 -m http.server $PORT &
SERVER_PID=$!

# Wait a moment for server to start
sleep 2

# Try to open in browser (works on most Linux distros)
if command -v xdg-open >/dev/null 2>&1; then
    echo "🚀 Opening presentation in browser..."
    xdg-open "$PRESENTATION_URL" 2>/dev/null
elif command -v google-chrome >/dev/null 2>&1; then
    echo "🚀 Opening presentation in Chrome..."
    google-chrome "$PRESENTATION_URL" 2>/dev/null &
elif command -v firefox >/dev/null 2>&1; then
    echo "🚀 Opening presentation in Firefox..."
    firefox "$PRESENTATION_URL" 2>/dev/null &
else
    echo "📋 Please open your browser to: $PRESENTATION_URL"
fi

echo ""
echo "✅ Server running on port $PORT"
echo "🎮 Use arrow keys or spacebar to navigate slides"
echo "🔍 Press ESC in presentation for slide overview"
echo ""

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "🛑 Stopping presentation server..."
    kill $SERVER_PID 2>/dev/null
    echo "✅ Server stopped. Goodbye!"
    exit 0
}

# Trap Ctrl+C and cleanup
trap cleanup INT

# Keep script running
wait $SERVER_PID