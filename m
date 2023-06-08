Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259C0728602
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jun 2023 19:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjFHRLW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Jun 2023 13:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjFHRLW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Jun 2023 13:11:22 -0400
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Jun 2023 10:11:17 PDT
Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10262695
        for <linux-nfs@vger.kernel.org>; Thu,  8 Jun 2023 10:11:17 -0700 (PDT)
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
        (Exim 4.96)
        id 1q7J52-000GG5-1E
        for linux-nfs@vger.kernel.org;
        Thu, 08 Jun 2023 13:05:48 -0400
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-973e36a4fccso19176966b.1
         for <linux-nfs@vger.kernel.org>; Thu, 08 Jun 2023 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1686243947; x=1688835947;
         h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
          :date:message-id:reply-to;
         bh=/mN9yfzevpIWTc+IX7MhOJKnR7Xyjtogyl2e/c3T/0Y=;
         b=VpP7bElt3vfPUtJgQd0EnM6lzN0Wnl35joHXP/w7o1ajBhrl4RXw84owWxq/wC0VMA
          cc9DM6ZtfjEDyt1cqn5eJowHZd7rjLJCX3JC/fXmEPnpoG0zVJDNAA/PkM7RyTCRT1yw
          OHA/xVKYpOOhrz+BA2B3eBzUK/FRDT8ulQRbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20221208; t=1686243947; x=1688835947;
         h=to:subject:message-id:date:from:mime-version:x-gm-message-state
          :from:to:cc:subject:date:message-id:reply-to;
         bh=/mN9yfzevpIWTc+IX7MhOJKnR7Xyjtogyl2e/c3T/0Y=;
         b=RcTugXtDmTbmBkt6FuH+dg49mPLpWB8P5sUaSS3QVP3OUomCkDzxGtprEAK2X7qgRE
          25qFXhAUco4LSsHpeGEmkDJfNhQKBRBFRAzbpw/I9pAcx+E4W5J9keAbE+IZ2ofqKBlZ
          5e3Ila70PHQXQvdgFKNE/H3sRqBKjXDeBFF4CS/l6zQvdlyWckw4v9giQuAv9qRphekE
          OV3VxXm+dbpknAjsRf2abtqYqlL/O0rYPHWwUoXoJ1EkjMMAPKpGjvVYm/NkQ+u2JeLl
          rrSkHPp9EQZklFvZpu1uEnceB53VtEFlUmGhzrLS0BkzcFx0c8a4viL2ZRQpn1na0+Rh
          R5nw==
X-Gm-Message-State: AC+VfDzqhk92tuv0ARWBiWRmqBzg/SulP4Z3x3LD+Uk19cYYVAtdLFEb
        o1HPH/fEyicGja01K0TASVklykn8C8j/VT5Utg8aNKLvcjLSwQMCOTG4O7z+9/qb8H7G1CR96Qt
        IzU43FzZcEemmbMyXKGZSuws+0UbFAVR4JJCg7ve8W1c=
X-Received: by 2002:a17:906:19c:b0:978:a991:c367 with SMTP id 28-20020a170906019c00b00978a991c367mr1526045ejb.2.1686243947366;
         Thu, 08 Jun 2023 10:05:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ViYfQ0NmUotGTvqkNSdkHwPSzwvRotU11s5SvfyJBjVBKZqDARbpJWNUyK+nOoAmxmmtcpFaNL6wsIddROhg=
X-Received: by 2002:a17:906:19c:b0:978:a991:c367 with SMTP id
  28-20020a170906019c00b00978a991c367mr1526021ejb.2.1686243946776; Thu, 08 Jun
  2023 10:05:46 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Perl <cperl@janestreet.com>
Date:   Thu, 8 Jun 2023 13:05:10 -0400
Message-ID: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
Subject: Too many ENOSPC errors
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi everyone,

I'm working with several Red Hat derived systems and have noticed an
issue with ENOSPC and NFS that I'm looking for some guidance on.

First let me describe the testing setup, and then I'll share my
results from an EL7 based system (kernel 3.10.0-1160.90.1.el7), an EL8
based system (kernel 4.18.0-425.19.2.el8_7), an EL8 based system
patched with commit e6005436f6cc9ed13288f936903f0151e5543485 (kernel
4.18.0-425.19.2.el8_7 plus that commit), and finally an EL8 based
system but with an upstream 6.1 kernel.

Assume I have a 20M quota on my current working directory which is an
NFS export from one of the major enterprise vendors.

The testing looks like the following:

# rm -f file1
# touch file1
# dd bs=1M count=20 if=/dev/zero of=file2 # this will use all the quota
20+0 records in
20+0 records out
20971520 bytes (21 MB, 20 MiB) copied, 0.193018 s, 109 MB/s
# tee -a file1 <<< abc
abc
tee: file1: No space left on device
# rm -f file2
# tee -a file1 <<< abc
abc

On an EL7 based system, running the above works just as shown. I.e.
you create file1, then use all the quota with file2, attempt to write
to file1 which fails with ENOSPC (as expected), remove file2 (which
frees up the quota), and then attempt to write to file1 again which
succeeds.

However, on a stock EL8 based system, I instead get the following
surprising behavior:

# rm -f file1
# touch file1
# dd bs=1M count=20 if=/dev/zero of=file2 # this will use all the quota
20+0 records in
20+0 records out
20971520 bytes (21 MB, 20 MiB) copied, 0.193018 s, 109 MB/s
# tee -a file1 <<< abc
abc
tee: file1: No space left on device
# rm -f file2
# tee -a file1 <<< abc
abc
tee: file1: No space left on device
# tee -a file1 <<< abc
abc
tee: file1: No space left on device

I.e. Even after freeing the space by removing file2, writing to file1
continues to fail with ENOSPC forever (I've only shown 2 iterations
above) [1]. No amount of waiting will cause it to go away. But, we've
found that running sync(1) on the file will fix it (the sync itself
will complain with ENOSPC, but then subsequent tee invocatinos
succeed).

I thought that perhaps the issue was the fact that kernel
4.18.0-425.19.2.el8_7 was missing commit
e6005436f6cc9ed13288f936903f0151e5543485 (which adds some ENOSPC
handling to `nfs_file_write'), so we patched the kernel with that
patch and tested again. It's worth saying that with this patch, the
behavior of our 4.18 kernel and the 6.1 kernel are consistent when
running this test, but I feel like there might still be a bug here.

What I get now is:

# rm -f file1
# touch file1
# dd bs=1M count=20 if=/dev/zero of=file2 # this will use all the quota
20+0 records in
20+0 records out
20971520 bytes (21 MB, 20 MiB) copied, 0.193018 s, 109 MB/s
# tee -a file1 <<< abc
abc
tee: file1: No space left on device
# rm -f file2
# tee -a file1 <<< abc
abc
tee: file1: No space left on device
# tee -a file1 <<< abc
abc

I.e. The first attempt to write to the file after freeing the quota
fails with ENOSPC, but subsequent attempts succeed. Note that this is
different from the original behavior on our EL7 based system as shown
above where as soon as the quota is freed up, there are no more ENOSPC
errors.

I'm no expert, but below I'm including some digging I did in case it's
helpful for understanding the situation more fully without needing to
reproduce yourselves. If it's not helpful and just distracting,
apologies in advance!

From strace'ing and systemtap'ing I noticed that the first call to
`tee' (after the quota is used up by file2) returns the ENOSPC in
response to close(2) (i.e. via `nfs_file_flush') and the second call
to `tee' (after the quota has been freed) returns the ENOSPC in
response to the write(2) (i.e. via `nfs_file_write' , and then clears
the error via the changes we introduced with commit
e6005436f6cc9ed13288f936903f0151e5543485).

Here is the output of [2], run while reproducing (the comments and
spacing are mine just to more easily be able to tell things apart):

# stap -vv --vp 10101 /tmp/t.stp
...
# This section is the first tee invocation when the quota is fully
consumed by file2
1686164924543967263: tee
module("nfs").function("nfs_file_write@fs/nfs/file.c:592").call
f_wb_err: wb_err: flags:0x0
1686164924543983309: tee
module("nfs").function("nfs_file_write@fs/nfs/file.c:592").return
f_wb_err: wb_err: flags:0x0
1686164924543986715: tee
module("nfs").function("nfs_file_flush@fs/nfs/file.c:139").call
f_wb_err: wb_err: flags:0x0
1686164924545701586: tee
module("nfs").function("nfs_file_flush@fs/nfs/file.c:139").return
f_wb_err: wb_err:ENOSPC flags:0x0

# This section is the second tee invocation when the quota has been freed
1686164933146193798: tee
module("nfs").function("nfs_file_write@fs/nfs/file.c:592").call
f_wb_err: wb_err:ENOSPC flags:0x0
1686164933147496167: tee
module("nfs").function("nfs_file_write@fs/nfs/file.c:592").return
f_wb_err: wb_err: flags:0x0
1686164933147623303: tee
module("nfs").function("nfs_file_flush@fs/nfs/file.c:139").call
f_wb_err: wb_err: flags:0x0
1686164933147627755: tee
module("nfs").function("nfs_file_flush@fs/nfs/file.c:139").return
f_wb_err: wb_err: flags:0x0

# This section is the third tee invocation that succeeds with no errors
1686164937358310484: tee
module("nfs").function("nfs_file_write@fs/nfs/file.c:592").call
f_wb_err: wb_err: flags:0x0
1686164937358323369: tee
module("nfs").function("nfs_file_write@fs/nfs/file.c:592").return
f_wb_err: wb_err: flags:0x0
1686164937358326649: tee
module("nfs").function("nfs_file_flush@fs/nfs/file.c:139").call
f_wb_err: wb_err: flags:0x0
1686164937359877744: tee
module("nfs").function("nfs_file_flush@fs/nfs/file.c:139").return
f_wb_err: wb_err: flags:0x0

I barely know what I'm looking at, but I wondered whether
`nfs_file_flush' should be resetting the error when it returns by
calling `file_check_and_advance_wb_err' instead of
`filemap_check_wb_err'. Given that it's reported the error to user
space, is that sufficient to clear the error? Or, does it need to keep
the error because there are dirty pages that haven't been written back
yet?

I guess what I'm asking is, is the above behavior we've observed on
EL8 patched with e6005436f6cc9ed13288f936903f0151e5543485 and
separately with 6.1 the expected behavior? Or should it behave like it
did in EL7?

Any insight or direction would be greatly appreciated!

Chris


[1]: It's not actually the write(2) that is giving the ENOSPC, it's
the close(2) and in fact the bytes successfully wind up in the file
even though the command appears to fail.

[2]: A systemtap script I threw together to look at fields I thought
might come into play:

function dump(file:long) {
        printf("%d: %s %70s f_wb_err:%6s wb_err:%6s flags:%#x\n",
                   gettimeofday_ns(),
                   execname(),
                   pp(),
                   errno_str(@cast(file, "struct file")->f_wb_err),
                   errno_str(@cast(file, "struct file")->f_mapping->wb_err),
                   @cast(file, "struct file")->f_mapping->flags);
}

probe module("nfs").function("nfs_file_write").call {
        if (!isinstr(execname(), "tee"))
                next
        dump(@cast($iocb, "struct kiocb")->ki_filp);
}

probe module("nfs").function("nfs_file_write").return {
        if (!isinstr(execname(), "tee"))
                next
        dump(@cast(@entry($iocb), "struct kiocb")->ki_filp);
}

probe module("nfs").function("nfs_file_flush").call {
        if (!isinstr(execname(), "tee"))
                next
        dump($file);
}

probe module("nfs").function("nfs_file_flush").return {
        if (!isinstr(execname(), "tee"))
                next
        dump(@entry($file));
}
