Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9764868979C
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 12:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjBCLRo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Feb 2023 06:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjBCLRn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Feb 2023 06:17:43 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4E93E25
        for <linux-nfs@vger.kernel.org>; Fri,  3 Feb 2023 03:17:41 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ml19so14561985ejb.0
        for <linux-nfs@vger.kernel.org>; Fri, 03 Feb 2023 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RXMIxGWTHt172JDXaJQxeWSafemTvTg0DTfBUUEyCwA=;
        b=f9sPKJapzCkgkei38N4h204jJNSEz0UvFcbJS8c5GMCyZOmDKxsiMujUyXhal4RRp8
         d/F7XxCfZdpRL4nEfQCJymd0OxRWc1DyT2XiM+eWZIJ6qdUR2sCZPdeRSkIqK9PBnoJt
         aZXvwGi1opC1cjkUXGqxvtFX/CfkzII2BtnuB2z9hktU4QYatMu2VC8RaVbC78FrwWyd
         956matQ3N5yECjaTICPRmNzm8EEXB58DP23W0+Hg03HyzVf6i0kfAu1v9Wy4N3mJTZUh
         5R1eBPtbwLzkiQXsit8CjIO3Gdw/yptnM19LEdlv/m1p23j+Buoy42LqaojHq2rci8Cj
         ESCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXMIxGWTHt172JDXaJQxeWSafemTvTg0DTfBUUEyCwA=;
        b=tJiCad4UmqKUdXga7/L/dGHE4VCHgLv6ifFLcTjbWRCZIXOhfXuFs6oZEWx9fhCOwZ
         /eFMVQOlVPeLME+ueoYfsOMfhRYCZmKRgTUhNn4wuUYT1xQ8spTWjW6KVqO2W9iNkko1
         RVSJnHJuXUto/sIA/KcQfH+LJhxj6kZarZ2Po8Bp5lNj5ELcIew9j667K4Zpa5etDwVN
         Ar8Tvr9vZc3ZUhDh6HPrrLjxIX1fimNZROEMvgx6aawbdy3vfV30HzqTIMTdWLmUlHSu
         IVyuhGTHKu6jD1ErdKcheFRZDKejVvVPTZSxuuW9iP4ni1LNn9dLxPS5hUHk3FxMafpU
         hPaA==
X-Gm-Message-State: AO0yUKUyH3aX4VN5E9WIyLEfD3v7+svmJ7f1CccN4khMZwnxJMgwAI8z
        OXEq1vD1VLrKTaaLD94UvpBaAXtF+bB0G6GL9de7RFV9ZL8=
X-Google-Smtp-Source: AK7set84Kytl/a2P+O8yDDRZvotwv8O3vOIyHe3YdFXDdsyrL5jCMIUI17OvPT48+SlzDsIWaL0tRdoxzcLVgl9II1s=
X-Received: by 2002:a17:906:22d4:b0:878:6643:9754 with SMTP id
 q20-20020a17090622d400b0087866439754mr2916996eja.46.1675423060132; Fri, 03
 Feb 2023 03:17:40 -0800 (PST)
MIME-Version: 1.0
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Fri, 3 Feb 2023 11:17:28 +0000
Message-ID: <CAAmbk-cQNY3Sd9iQ7vghqw_=sk9JsG-_Mf-OM_iRuw+h8j2E_w@mail.gmail.com>
Subject: decant_cull_table intermittently aborting cachefilesd
To:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
        benmaynard@google.com, brennandoyle@google.com, tom@gunpowder.tech,
        daire@dneg.com, Chris Chilvers <chris.chilvers@appsbroker.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I have been having an issue where cachefilesd will randomly crash causing the
cache to be withdrawn. The crash is intermittent and can sometimes happen
within minutes, other times it can take hours, or never.

Fortunately it has produced a crash dump so I've been able to analyse what
happened.

From the stack trace (and debug logging) the last operation it was running is
the decant_cull_table. The code fails in the check block at the end of the
function when it calls abort().

    (gdb) bt
    #0  __pthread_kill_implementation (no_tid=0, signo=6,
threadid=140614334650176) at ./nptl/pthread_kill.c:44
    #1  __pthread_kill_internal (signo=6, threadid=140614334650176) at
./nptl/pthread_kill.c:78
    #2  __GI___pthread_kill (threadid=140614334650176,
signo=signo@entry=6) at ./nptl/pthread_kill.c:89
    #3  0x00007fe353442476 in __GI_raise (sig=sig@entry=6) at
../sysdeps/posix/raise.c:26
    #4  0x00007fe3534287f3 in __GI_abort () at ./stdlib/abort.c:79
    #5  0x0000556d6c9f0965 in decant_cull_table () at cachefilesd.c:1571
    #6  cachefilesd () at cachefilesd.c:780
    #7  0x0000556d6c9f140b in main (argc=<optimized out>,
argv=<optimized out>) at cachefilesd.c:581

For reference the code at frame 5 from the decant_cull_table function is:

    check:
        for (loop = 0; loop < nr_in_ready_table; loop++)
            if (((long)cullready[loop] & 0xf0000000) == 0x60000000)
                abort();

Checking the cull table, the first object in the cull table appears to be
valid.

    (gdb) p nr_in_ready_table
    $1 = 242

    (gdb) p cullready[0]
    $2 = (struct object *) 0x556d6d7382a0

    (gdb) p -pretty -- *cullready[0]
    $3 = {
        parent = 0x556d6d7352b0,
        children = 0x0,
        next = 0x0,
        prev = 0x0,
        dir = 0x0,
        ino = 13631753,
        usage = 1,
        empty = false,
        new = false,
        cullable = true,
        type = OBJTYPE_DATA,
        atime = 1675349423,
        name = "E"
    }

The inode number from the struct matches a file in the fscache.

    $ sudo find /var/cache/fscache -inum 13631753
    /var/cache/fscache/cache/Infs,3.0,2,,300000a,e5e9b1269df2b0d,,,d0,100000,100000,249f0,249f0,249f0,249f0,1/@00/E210w114Hg92Az0HAMYCClFMVmkMY050002w1qO200

However, the memory address of the struct matches (fails) the check.

    (gdb) p (((long)cullready[0] & 0xf0000000) == 0x60000000)
    $4 = 1

      0000 556d 6d73 82a0
    & 0000 0000 f000 0000
    = 0000 0000 6000 0000

    $ file /sbin/cachefilesd
    /sbin/cachefilesd: ELF 64-bit LSB pie executable, x86-64

Looking at the code, I suspect that this magic 0x60000000 number is supposed
to be some kind of sentinel value that's used as a bug check for errors such
as use after free? This would make sense when the application was 32 bit, as
address pattern 0110 in the highest nibble either cannot occur, or lies within
the kernel address space. However, when compiled as 64 bit this assumption is
no longer true and the bit pattern can appear in perfectly valid addresses.

This would also explain the random nature of the crashes, as the cachefilesd
is at the whims of the OS and calloc function.

--
Chris
