//
//  NSStringNSData+Hashes.m
//
//  Created by Klaus-Peter Dudas on 26/07/2011.
//  Modified by hd@onlinecity.dk to not use NSMutableString which is (kinda) slow.
//  NSData adapted from NSString+Hashes by Justin Swanson on 02/25/2013.
//  Copyright: Do whatever you want with this, i.e. Public Domain
//

#import <CommonCrypto/CommonDigest.h>

#import "NSStringNSData+Hashes.h"

static inline NSString *NSStringCCHashFunction(unsigned char *(function)(const void *data, CC_LONG len, unsigned char *md), CC_LONG digestLength, NSString *string) {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[digestLength];

    function(data.bytes, (CC_LONG)data.length, digest);

    // Convert to hex (high performance)
    static const char HexEncodeChars[] = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
    char *resultData;
    resultData = malloc(digestLength*2+1);

    for (uint i = 0; i < digestLength; i++) {
        resultData[i*2]=HexEncodeChars[(digest[i] >> 4)];
        resultData[i*2+1]=HexEncodeChars[(digest[i] % 0x10)];
    }
    resultData[digestLength*2] = 0;

    // Return as a NSString without copying the bytes
    return [[NSString alloc] initWithBytesNoCopy:resultData
                                          length:digestLength*2
                                        encoding:NSASCIIStringEncoding
                                    freeWhenDone:YES];
}
                             
static inline NSString *NSDataCCHashFunction(unsigned char *(function)(const void *data, CC_LONG len, unsigned char *md), CC_LONG digestLength, NSData *data) {
    uint8_t digest[digestLength];

    function(data.bytes, (CC_LONG)data.length, digest);

    // Convert to hex (high performance)
    static const char HexEncodeChars[] = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
    char *resultData;
    resultData = malloc(digestLength*2+1);

    for (uint i = 0; i < digestLength; i++) {
        resultData[i*2]=HexEncodeChars[(digest[i] >> 4)];
        resultData[i*2+1]=HexEncodeChars[(digest[i] % 0x10)];
    }
    resultData[digestLength*2] = 0;

    // Return as a NSString without copying the bytes
    return [[NSString alloc] initWithBytesNoCopy:resultData
                                          length:digestLength*2
                                        encoding:NSASCIIStringEncoding
                                    freeWhenDone:YES];
}
                             
@implementation NSString (Hashes)

- (NSString *)md5 {
    return NSStringCCHashFunction(CC_MD5, CC_MD5_DIGEST_LENGTH, self);
}

- (NSString *)sha1 {
    return NSStringCCHashFunction(CC_SHA1, CC_SHA1_DIGEST_LENGTH, self);
}

- (NSString *)sha224 {
    return NSStringCCHashFunction(CC_SHA224, CC_SHA224_DIGEST_LENGTH, self);
}

- (NSString *)sha256 {
    return NSStringCCHashFunction(CC_SHA256, CC_SHA256_DIGEST_LENGTH, self);
}

- (NSString *)sha384 {
    return NSStringCCHashFunction(CC_SHA384, CC_SHA384_DIGEST_LENGTH, self);
}
- (NSString *)sha512 {
    return NSStringCCHashFunction(CC_SHA512, CC_SHA512_DIGEST_LENGTH, self);
}

@end

@implementation NSData (Hashes)

- (NSString *)md5 {
    return NSDataCCHashFunction(CC_MD5, CC_MD5_DIGEST_LENGTH, self);
}

- (NSString *)sha1 {
    return NSDataCCHashFunction(CC_SHA1, CC_SHA1_DIGEST_LENGTH, self);
}

- (NSString *)sha224 {
    return NSDataCCHashFunction(CC_SHA224, CC_SHA224_DIGEST_LENGTH, self);
}

- (NSString *)sha256 {
    return NSDataCCHashFunction(CC_SHA256, CC_SHA256_DIGEST_LENGTH, self);
}

- (NSString *)sha384 {
    return NSDataCCHashFunction(CC_SHA384, CC_SHA384_DIGEST_LENGTH, self);
}
- (NSString *)sha512{
    return NSDataCCHashFunction(CC_SHA512, CC_SHA512_DIGEST_LENGTH, self);
}

@end