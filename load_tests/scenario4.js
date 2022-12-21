/* Scenario 4:  Users go to the Homepage 
                Then they look on the todo list
                After that they post another to do list entry
 */

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
    const pages = [
        '/',
        '/api/todos',
    ]
    
    for (const page of pages) {
        const res = http.get('http://localhost:8083' + page)
        check(res, {
            "status was 200": (r) => r.status == 200,
        })
        sleep(1)
    }

    const payload = JSON.stringify({
        email: 'aaa',
        password: 'bbb',
      });
    
    const params = {
        headers: {
          'Content-Type': 'application/json',
        },
    };

    const post_res = http.post('http://localhost:8083' + pages[1], payload, params);
    check(post_res, {
        "status was 201": (r) => r.status == 201,
    })
    sleep(1)
}
