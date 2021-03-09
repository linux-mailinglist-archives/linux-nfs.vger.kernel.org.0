Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9404332852
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 15:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhCIOQd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 09:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhCIOQU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 09:16:20 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F11C06174A
        for <linux-nfs@vger.kernel.org>; Tue,  9 Mar 2021 06:16:19 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso6332654wma.4
        for <linux-nfs@vger.kernel.org>; Tue, 09 Mar 2021 06:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:openpgp:autocrypt:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=b5L+D7buJBnsWVKUwK+ftnRkjjwlWqElOl0lXUYZU8o=;
        b=HZqEWw9ZTZ8129j79qdG/zrZDhBPdaqiNtLmswHH+H+U+b5uP8bkw4WJIuob4DowA1
         iyIAodAQQKmsR6Fp0C0D6+s0x+zOjJKQFg+bkS5YL1UeMAnaMymstT9oFJ8a+F8w+3ux
         COzIUbAvK4oGFFJz2EF1gDFo5qW/60kPeXwczzdsO3R0kQaniGcmc/7U0OnsZD2axjDl
         eceUboJPIW+U5O/YscmQuotwsrwAAZgV5CobdCFKqEek2kf/6iZjykVwN+01i1Gbn9wy
         X9dw3oXN/OVFITfPo2+67ewOrQ7CE+Zrn6kVuP++iBcBIxYcG8bBjWFCCAhTsbgPpy48
         vnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:openpgp:autocrypt:to:subject:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=b5L+D7buJBnsWVKUwK+ftnRkjjwlWqElOl0lXUYZU8o=;
        b=i0Lw9X+zatKhv/8u4WSQQNxRQalDO5SYdsEsbuJWRPaZiZmNI8fJPDVhvk16XmwdST
         rulVOUSPCfk/H7Eh30WFlW7TcZjK5lb/eC6LkK8jXJXGJaP271a4lDC97zOVSQONoq5W
         YzN8W4HKJlf3x+I5N8DSibSaGy3eQl4fo7aU1p+K8it+QfzINkeXAVMqGzKVqz2JVfuU
         QppjUAdn+AGyGZHHjTYEUMHo7LoMzPNiLgLUmb7avShPd7yyR+bwWNpyYQnhtNMgQpRb
         bDysoaa/6ylezjeU4WhS94fDD5Z1wa+YeiYvKi3LVRsCcuVB32ZFl/jJTL7tgyO4C0DP
         +obw==
X-Gm-Message-State: AOAM530yWGjBX9s02mlVP4UYKaFchFvrKh4G/Bs8OYFBtfvJwYblo/1i
        TuKkCiItkMxdXJafDDpOAxA=
X-Google-Smtp-Source: ABdhPJyxMY+CTSSCpXxoqDUkI/S/0dndC64xhVO4apuS25Z5OzB+fgz651Xrj4CrITl0vkbZ51SWGw==
X-Received: by 2002:a7b:cdef:: with SMTP id p15mr4394948wmj.0.1615299378401;
        Tue, 09 Mar 2021 06:16:18 -0800 (PST)
Received: from [192.168.178.32] (pd9e1c3b3.dip0.t-ipconnect.de. [217.225.195.179])
        by smtp.gmail.com with ESMTPSA id v6sm24503771wrx.32.2021.03.09.06.16.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 06:16:17 -0800 (PST)
From:   Ephrim Khong <dr.khong@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dr.khong@gmail.com; keydata=
 mQENBF2KH3QBCACy66z3LoDOvFnn3Jl07bZvGy8IWXoClBLBEVQEDMgX6/2VskvAiDFYXjYY
 CBnpMZS7pkHyMj2nAuk8rfz8ofhTMxW1YthQGAGJt0eYMp9dymKG4O9c6Lzwlb54lwWet1AE
 x326ePst0QaBkvksN8HmoqNrTZVth2U+IiAI5y7RJB65ZsXmHoXBt4pfPEoQ01WFTXBrQ2ZR
 LHcweZQdU1uhwPjCB6JV9pNTclzFfQyqqga/JbbDbbplhL5XhA15VJq+3CJSM3Y0M1UGEOUv
 5dcWC15x65jlX4yDIrXUYkWq48byHlC8B75n9EnMAvmkFZ09ntSjwsRJmLILxr8cz9jtABEB
 AAG0J0JlcnRyYW0gRHJvc3QgPGJlcnRyYW0uZHJvc3RAbXZ0ZWMuY29tPokBVAQTAQgAPhYh
 BLWZoXdIkApCXec/7OxiOFtXzt5/BQJgAaaWAhsDBQkDw4IsBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEOxiOFtXzt5/k0MH/3G9nXfyfOiTQlANSQwQrXfpsvX+OJHCjLIpWgIUzMlN
 1LNacOn3fKxUWhiy/eXzNUAumL8lqRuLcjz6BcEhSIp7aWOYNqiQ0zSl7Qo3QxcL4k1tuAXz
 aOo1l9Kk9SzviPN7SGjCK4jrMKlEjBoA3G8OtxaJfk9XQRbkYVJFiIaTHh5puz2aoFgTCtB6
 qWpBfd59rmmYo16VbgK7qx0HaVijFQK6YyUFwnYVzCpGj4xCtrWs0awexbgzRmBUn3hEtD8P
 oMLbf/SaPqYhbH/iRUT8YAteWNi4teD9PQX436FOWXzFTR0DnURlNB9CfDj4YjGm9jeZ31i7
 8KdCEL+7/P25AQ0EXYofdAEIANMR2v+vHOPGHZUG/KrziIdliwF+VIUh58z92nIlvdrb+B2K
 QCVseYwkYvqMJkLaad5DbA2POwU1AofvXhGiNiNhiC02mwO+gHnX6Bz0SubfytdZd70SBcrD
 YNHsqJKHYPRS/AwWA5xRPTt7elsGrMkx7QU3QBeJhYPjEfjOjSAFNuPbSKKBw1oG8cZFihse
 D44MeDUJeODVWI7wl5VfIzW7cQ1HfmhPMC4I7cdz0D19RmTsvwDY5Er8uCiuKD/otnH/GeHp
 PYNSXxcAOjyuCbZOi/ps1BQp1UXJudIxS6w1Z9weJ3dgndd4ZmwcSPq+VHT2xcypM77Iff/g
 nvWK7zcAEQEAAYkBPAQYAQgAJhYhBLWZoXdIkApCXec/7OxiOFtXzt5/BQJdih90AhsMBQkD
 w4IsAAoJEOxiOFtXzt5/f58H/2tYnryojtNWwuVE1iJwBol1FJ+wg+NgqxQ+lgYu/JfoxNJY
 fDAPv5bNsfIoC7D6zJwZ+d6XFjb5tQITXT5fFJYgTaVKE9p+acsgXPoERLqF2NNK5hVHPz5K
 fENTojGN9aLElsyPDmFrnYZYqrvm1Ex4qcQ4mkIWI20CLfK84+Wi/6o/dE/uYu1chKNbfkZh
 B8krQZMfy1FAkrPbaIvuG6HgFd7gTWNmg2O4g7RRM/n+SgBFocnHY4bBc7WNgS+9h5imFeQk
 2Xy+Vjg5pJ+Q5b+6ULbGNUonKFhT9++RFH/FA2A4rYKoyEW3MbZKQAgqOVLDknad5HOaDFA7
 Mt212FU=
To:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: [BUG?] Executable flag lost when O_EXCL is not set
Message-ID: <f84e3f21-e6eb-0698-0e6e-6f96dbed4ab7@gmail.com>
Date:   Tue, 9 Mar 2021 15:16:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I ran into an issue that might or might not be a bug in nfs4. When
creating a file that does not previously exist on my system with

  openat(AT_FDCWD, fname, O_CREAT | O_EXCL, 0777);

vs.

  openat(AT_FDCWD, fname, O_CREAT, 0777);

the file has permissions 0755 for the first version and 0600 for the
second. umask is 0022 in both cases, the calls are in the same program,
right after each other (with an unlink in between). I am mostly worried
about the executable bit for the owner, which is lost.

Executing the code on an ext4 filesystem "works", meaning that it
produces the same permissions for both openat calls, regardless of O_EXCL.

My questions would be
- Is that expected, or an indication that something is off?
- Could it be some issue in the backend, not in nfs4 itself?
- Can someone reproduce this on a NFS4 mount (test is below)?

Thanks
- Eph


System details
**************

The storage backend is some SPSC IBM System.

$> uname -a
Linux xxxx 5.4.0-66-generic #74-Ubuntu SMP Wed Jan 27 22:54:38 UTC 2021
x86_64 x86_64 x86_64 GNU/Linux

$> mount -vv |grep foo

10.0.11.183:/export/foo on /import/foo type nfs4
(rw,relatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=x.x.x.x,local_lock=none,addr=x.x.x.x)

strace
******

This is an strace of a program that triggered this behaviour. Note how
the second openat call has no O_EXCL, but the last lstat reports 0640 as
mode:

 lstat("filename.sh", 0x7ffc2f148c20) = -1 ENOENT (No such file or
directory)
 openat(AT_FDCWD, "filename.sh", O_WRONLY|O_CREAT|O_EXCL, 0777) = 4
 write(4, "#!/bin/bash\n#\n# Build and run hb"..., 1973) = 1973
 fstat(4, {st_mode=S_IFREG|0755, st_size=1973, ...}) = 0
 close(4)                                = 0

 lstat("filename.sh", {st_mode=S_IFREG|0755, st_size=1973, ...}) = 0
 unlink("filename.sh") = 0
	
 openat(AT_FDCWD, "filename.sh", O_WRONLY|O_CREAT|O_TRUNC, 0777) = 4
 write(4, "#!/bin/bash\n#\n# Build and run hb"..., 1973) = 1973
 close(4)                                = 0
 lstat("filename.sh", {st_mode=S_IFREG|0640, st_size=1973, ...}) = 0

Test script to reproduce
************************
Reproduce with

  gcc test.c && ./a.out test_file

The reported st_modes should be identical.

-------------8<---------------

#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <malloc.h>

#define FAIL() {fprintf(stderr, "Failed at %s:%d\n", \
    __FILE__,(int)__LINE__); exit(2); }

#define EXPECT(A,B) {if ((A) != (B)) FAIL(); }

int run_test(const char* const fname)
{
  int res;
  int fd;
  struct stat mystat;

  res = lstat(fname, &mystat);
  if (res != -1)
  {
    /* File exists, delete */
    res = unlink(fname);
    EXPECT(res, 0);
  }

  res = lstat(fname, &mystat);
  EXPECT(res, -1);

  /* Create file with O_EXCL */
  fd = openat(AT_FDCWD, fname, O_CREAT | O_EXCL, 0777);
  if (fd == -1)
    FAIL();

  res = close(fd);
  EXPECT(res, 0);

  res = lstat(fname, &mystat);
  EXPECT(res, 0);
  printf("st_mode after creating with O_EXCL: %4o\n", mystat.st_mode);

  /* Delete file */
  res = unlink(fname);
  EXPECT(res, 0);

  /* Create file without O_EXCL */
  fd = openat(AT_FDCWD, fname, O_CREAT, 0777);
  if (fd == -1)
    FAIL();

  res = close(fd);
  EXPECT(res, 0);

  res = lstat(fname, &mystat);
  EXPECT(res, 0);

  printf("st_mode after creating w/o O_EXCL:  %4o\n", mystat.st_mode);
}

int main(int argc, const char** argv)
{
  if (argc < 2)
  {
    printf("Delete and re-create a file with different modes,\n");
    printf("checking the file permissions bits each time.\n");
    printf("Usage:\n");
    printf("    %s  <filename>\n", argv[0]);
    printf("ATTENTION: The passed filename will be deleted.\n");
    return 1;
  }

  const char* fname = argv[1];
  return run_test(fname);
}
