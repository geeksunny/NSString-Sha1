//
//  NSString+Hashes.m
//  LIFTUPP
//
//  Created by Klaus-Peter Dudas on 26/07/2011.
//  Modified by hd@onlinecity.dk to not use NSMutableString which is (kinda) slow.
//  Copyright: Do whatever you want with this, i.e. Public Domain
//

#import <CommonCrypto/CommonDigest.h>

#import "NSString+Hashes.h"

@implementation NSString (Hashes)

- (NSString *)md5
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];

    CC_MD5(data.bytes, data.length, digest);
    
    // Convert to hex (high performance)
    static const char HexEncodeChars[] = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
    char *resultData;
    resultData = malloc(CC_MD5_DIGEST_LENGTH*2+1);
    
    for (uint i=0;i<CC_MD5_DIGEST_LENGTH;i++) {
        resultData[i*2]=HexEncodeChars[(digest[i] >> 4)];
        resultData[i*2+1]=HexEncodeChars[(digest[i] % 0x10)];
    }
    resultData[CC_MD5_DIGEST_LENGTH*2] = 0;
    
    // Return as a NSString without copying the bytes
    return [[NSString alloc] initWithBytesNoCopy:resultData
                                          length:CC_MD5_DIGEST_LENGTH*2
                                        encoding:NSASCIIStringEncoding
                                    freeWhenDone:YES];
}

- (NSString *)sha1
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    // Convert to hex (high performance)
    static const char HexEncodeChars[] = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
    char *resultData;
    resultData = malloc(CC_SHA1_DIGEST_LENGTH*2+1);
    
    for (uint i=0;i<CC_SHA1_DIGEST_LENGTH;i++) {
        resultData[i*2]=HexEncodeChars[(digest[i] >> 4)];
        resultData[i*2+1]=HexEncodeChars[(digest[i] % 0x10)];
    }
    resultData[CC_SHA1_DIGEST_LENGTH*2] = 0;
    
    // Return as a NSString without copying the bytes
    return [[NSString alloc] initWithBytesNoCopy:resultData
                                          length:CC_SHA1_DIGEST_LENGTH*2
                                        encoding:NSASCIIStringEncoding
                                    freeWhenDone:YES];
}

- (NSString *)sha256
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    // Convert to hex (high performance)
    static const char HexEncodeChars[] = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
    char *resultData;
    resultData = malloc(CC_SHA256_DIGEST_LENGTH*2+1);
    
    for (uint i=0;i<CC_SHA256_DIGEST_LENGTH;i++) {
        resultData[i*2]=HexEncodeChars[(digest[i] >> 4)];
        resultData[i*2+1]=HexEncodeChars[(digest[i] % 0x10)];
    }
    resultData[CC_SHA256_DIGEST_LENGTH*2] = 0;
    
    // Return as a NSString without copying the bytes
    return [[NSString alloc] initWithBytesNoCopy:resultData
                                          length:CC_SHA256_DIGEST_LENGTH*2
                                        encoding:NSASCIIStringEncoding
                                    freeWhenDone:YES];
}

- (NSString *)sha512
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, data.length, digest);
    
    // Convert to hex (high performance)
    static const char HexEncodeChars[] = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
    char *resultData;
    resultData = malloc(CC_SHA512_DIGEST_LENGTH*2+1);
    
    for (uint i=0;i<CC_SHA512_DIGEST_LENGTH;i++) {
        resultData[i*2]=HexEncodeChars[(digest[i] >> 4)];
        resultData[i*2+1]=HexEncodeChars[(digest[i] % 0x10)];
    }
    resultData[CC_SHA512_DIGEST_LENGTH*2] = 0;
    
    // Return as a NSString without copying the bytes
    return [[NSString alloc] initWithBytesNoCopy:resultData
                                          length:CC_SHA512_DIGEST_LENGTH*2
                                        encoding:NSASCIIStringEncoding
                                    freeWhenDone:YES];
}

@end
