// Scenario 1: Users send a GET request to the homepage

import http from 'k6/http'
import { sleep, check} from 'k6'

export const options = {
    stages: [
        { duration: '30s', target: 50},
        { duration: '1m', target: 100},
        { duration: '20s', target: 0}
    ]
}

export default function () {
    
    const res = http.get('http://localhost:8083')
    check(res, {
        "status was 200": (r) => r.status == 200,
    })
    sleep(1)
}
