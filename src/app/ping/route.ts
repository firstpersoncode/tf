export async function GET(request: Request) {
    return new Response(request.headers.get('X-Forwarded-For'), {
        status: 200,
    });
}