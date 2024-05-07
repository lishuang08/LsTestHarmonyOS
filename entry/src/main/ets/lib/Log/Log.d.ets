import hilog from '@ohos.hilog';
import { LogOptions } from './LogOptions';
export declare class Log {
    private static mTag?;
    private static mDomain?;
    private static mClose?;
    private static mHilog?;
    private static mShowLogLocation?;
    private static mLogSize;
    static setDomain(h2: number): void;
    static init(g2: LogOptions): void;
    static isLoggable(f2: hilog.LogLevel): boolean;
    static log(d2: string | object, e2?: string | undefined): void;
    static info(b2: string | object, c2?: string): void;
    static debug(z1: string | object, a2?: string): void;
    static error(x1: string | object, y1?: string): void;
    static warn(v1: string | object, w1?: string): void;
    static fatal(t1: string, u1?: string): void;
    private static logLevel;
    static getMessage(q1: hilog.LogLevel, r1: string, s1: string | object): string;
    private static getObjectToJson;
}
