// Scenario 3: Users send a POST request to add a resource

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

    const payload = JSON.stringify({
        email: 'aaa',
        password: 'bbb',
      });
    
    const params = {
        headers: {
          'Content-Type': 'application/json',
        },
    };

    const res = http.post('http://localhost:8083/api/todos', payload, params);
    
    check(res, {
        "status was 201": (r) => r.status == 201,
    })
    sleep(1)
}
