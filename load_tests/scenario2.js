/* Scenario 2:  Users go to the Homepage 
                Then they look on the todo list
                After that they look on a single to do entry in detail
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
        '/api/todos/1',
    ]
    
    for (const page of pages) {
        const res = http.get('http://localhost:8083' + page)
        check(res, {
            "status was 200": (r) => r.status == 200,
        })
        sleep(1)
    }
}
