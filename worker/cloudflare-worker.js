const CHOREO_HOST = "REPLACE_WITH_CHOREO_HOST";
const REST_PATH_PREFIX = "/default/sub2api/v1.0";
const WS_PATH_PREFIX = "/default/sub2api/sub2api_ws/v1.0";

export default {
  async fetch(request) {
    const incomingUrl = new URL(request.url);
    const isWebSocket = request.headers.get("Upgrade")?.toLowerCase() === "websocket";
    const targetUrl = new URL(request.url);

    // Choreo REST 和 WS endpoint 路径不同，Worker 按 Upgrade 头分流。
    targetUrl.protocol = isWebSocket ? "wss:" : "https:";
    targetUrl.hostname = CHOREO_HOST;
    targetUrl.pathname = joinPaths(isWebSocket ? WS_PATH_PREFIX : REST_PATH_PREFIX, incomingUrl.pathname);
    targetUrl.search = incomingUrl.search;

    const headers = new Headers(request.headers);
    headers.set("X-Forwarded-Host", incomingUrl.host);
    headers.set("X-Forwarded-Proto", incomingUrl.protocol.replace(":", ""));

    // Sub2API HTML 使用 CSP nonce；避免 304 复用旧 HTML 导致 nonce 与响应头不一致。
    if (!isWebSocket && acceptsHtml(request)) {
      headers.delete("If-None-Match");
      headers.delete("If-Modified-Since");
    }

    const response = await fetch(new Request(targetUrl.toString(), {
      method: request.method,
      headers,
      body: request.body,
      redirect: "manual",
    }));

    if (isWebSocket) {
      return response;
    }

    return rewriteRedirectLocation(response, incomingUrl);
  },
};

function acceptsHtml(request) {
  return request.headers.get("Accept")?.includes("text/html") === true;
}

function joinPaths(prefix, pathname) {
  const cleanPrefix = `/${prefix.replace(/^\/+|\/+$/g, "")}`;
  const cleanPath = pathname === "/" ? "" : `/${pathname.replace(/^\/+/, "")}`;
  return `${cleanPrefix}${cleanPath}`;
}

function rewriteRedirectLocation(response, incomingUrl) {
  const location = response.headers.get("Location");
  if (!location) {
    return response;
  }

  const rewrittenHeaders = new Headers(response.headers);
  try {
    const locationUrl = new URL(location);
    if (locationUrl.hostname === CHOREO_HOST) {
      locationUrl.protocol = incomingUrl.protocol;
      locationUrl.hostname = incomingUrl.hostname;
      locationUrl.port = incomingUrl.port;
      locationUrl.pathname = stripKnownPrefix(locationUrl.pathname);
      rewrittenHeaders.set("Location", locationUrl.toString());
    }
  } catch {
    // 兼容相对 Location，只移除已知的 Choreo endpoint 前缀。
    rewrittenHeaders.set("Location", stripKnownPrefix(location));
  }

  return new Response(response.body, {
    status: response.status,
    statusText: response.statusText,
    headers: rewrittenHeaders,
  });
}

function stripKnownPrefix(pathname) {
  for (const prefix of [REST_PATH_PREFIX, WS_PATH_PREFIX]) {
    if (pathname === prefix) {
      return "/";
    }
    if (pathname.startsWith(`${prefix}/`)) {
      return pathname.slice(prefix.length);
    }
  }
  return pathname;
}
