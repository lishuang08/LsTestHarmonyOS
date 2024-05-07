import hilog from '@ohos.hilog';
export class Log {
    static setDomain(p1) {
        Log.mDomain = p1;
    }
    static init(i1) {
        const j1 = i1.tag;
        const k1 = i1.domain;
        const l1 = i1.close;
        const m1 = i1.isHilog;
        const n1 = i1.showLogLocation;
        const o1 = i1.logSize;
        if (j1 != undefined) {
            Log.mTag = j1;
        }
        if (k1 != undefined) {
            Log.mDomain = k1;
        }
        if (l1 != undefined) {
            Log.mClose = l1;
        }
        if (m1 != undefined) {
            Log.mHilog = m1;
        }
        if (n1 != undefined) {
            Log.mShowLogLocation = n1;
        }
        if (o1 != undefined) {
            Log.mLogSize = o1;
        }
    }
    static isLoggable(h1) {
        return hilog.isLoggable(Log.mDomain, Log.mTag, h1);
    }
    static log(f1, g1) {
        console.log(Log.getMessage(hilog.LogLevel.INFO, g1 == undefined ? Log.mTag : g1, f1));
    }
    static info(d1, e1) {
        Log.logLevel(hilog.LogLevel.INFO, e1, d1);
    }
    static debug(b1, c1) {
        Log.logLevel(hilog.LogLevel.DEBUG, c1, b1);
    }
    static error(z, a1) {
        Log.logLevel(hilog.LogLevel.ERROR, a1, z);
    }
    static warn(x, y) {
        Log.logLevel(hilog.LogLevel.WARN, y, x);
    }
    static fatal(v, w) {
        Log.logLevel(hilog.LogLevel.FATAL, w, v);
    }
    static logLevel(o, p, q = "") {
        if (Log.mClose) {
            return;
        }
        if (p == undefined) {
            p = Log.mTag;
        }
        const r = Log.getMessage(o, p, q);
        const s = r.length / Log.mLogSize;
        for (let t = 0; t < s; t++) {
            let u = r.substring(t * Log.mLogSize, (t + 1) * Log.mLogSize);
            if (t != 0) {
                u = "|" + u;
            }
            if (Log.mHilog) {
                switch (o) {
                    case hilog.LogLevel.INFO:
                        hilog.info(Log.mDomain, p, u);
                        break;
                    case hilog.LogLevel.WARN:
                        hilog.warn(Log.mDomain, p, u);
                        break;
                    case hilog.LogLevel.DEBUG:
                        hilog.debug(Log.mDomain, p, u);
                        break;
                    case hilog.LogLevel.ERROR:
                        hilog.error(Log.mDomain, p, u);
                        break;
                    case hilog.LogLevel.FATAL:
                        hilog.fatal(Log.mDomain, p, u);
                        break;
                }
            }
            else {
                switch (o) {
                    case hilog.LogLevel.INFO:
                        console.info(u);
                        break;
                    case hilog.LogLevel.WARN:
                        console.warn(u);
                        break;
                    case hilog.LogLevel.DEBUG:
                        console.debug(u);
                        break;
                    case hilog.LogLevel.ERROR:
                        console.error(u);
                        break;
                    case hilog.LogLevel.FATAL:
                        console.log(u);
                        break;
                }
            }
        }
    }
    static getMessage(d, e = "", f) {
        let g = "┌───────" + e + "────────────────────────────────────────────────────────────────────────────────";
        g = g.substring(0, g.length - e.length) + "\n";
        try {
            if (Log.mShowLogLocation && d == hilog.LogLevel.ERROR) {
                const l = new Error().stack;
                const m = l.split('\n');
                const n = m[m.length - 2];
                g = g + "|" + n;
            }
            let i = typeof f;
            if (i == "object") {
                f = Log.getObjectToJson(f);
            }
            else if (i == "string") {
                const j = f + "";
                if (j.startsWith("{") && j.endsWith("}")) {
                    const k = JSON.parse(f.toString());
                    f = Log.getObjectToJson(k);
                }
                else {
                    f = j;
                }
            }
            g = g + "\n|    " + f;
        }
        catch (h) {
        }
        g = g + "\n└───────────────────────────────────────────────────────────────────────────────────────";
        return g;
    }
    static getObjectToJson(a) {
        const b = JSON.stringify(a, null, 2);
        const c = b.replace(/\n/g, "\n|    ");
        return c;
    }
}
Log.mTag = "HarmonyOSLog";
Log.mDomain = 0x0000;
Log.mClose = false;
Log.mHilog = true;
Log.mShowLogLocation = true;
Log.mLogSize = 800;
