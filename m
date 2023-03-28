Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFDC6CC931
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Mar 2023 19:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjC1RXL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Mar 2023 13:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjC1RXI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Mar 2023 13:23:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5D6E191
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 10:23:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ew6so52673220edb.7
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680024180;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMXmHQsVcoXJgrM8aqkbsjB3AVZGOKdI9LNYNjA7GOo=;
        b=RG1k7YQeS065uT0wtSQcmvvFuzbUVG+1mqvLiT21tJw9K5AGm4iYVMXASoNs3Js+Nd
         aXQu1dOlzFvDXCAfyf9JnjlciW2ENUX6g1bSa+lxCiP8d82W/UH9kno796/XkZ+9Zx5M
         30gmGK4aczSONgxuFSJSVDhHXzPz69r5C94eNKutw+YCYm1xWYSAI+ekIJoQJ+RcwXu4
         PFo/9+GWubrgxvMu9J86cT1XoDLOh4M7gJEP8AQrj4K/xWntJQl/QP71vkSwtlOZCUtA
         OpVAwRK5qRGyDtx+p3oVwNW+64NzVJwpejhkcP7FNBcIGjH9OFYPKn9lVjMdVVJGNbp+
         C/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024180;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMXmHQsVcoXJgrM8aqkbsjB3AVZGOKdI9LNYNjA7GOo=;
        b=yQ/kR91Pe4N3gDDUv0yg6O4SaSOI8zyvyFp2/WFH1CrfTa+z58X/xYq1e51bdQTDDF
         w5uLwgtkKfzHOkfykOw55kbQuVuLhbNTgSwq3K7QA7SwG6CVJE72BmwVMu5KbeGTdXl1
         k+51e6m3UcvfVCV+kc5AkMMGDqdXmc1fkWGBAtrI+PlgfKhMmF0cDm0qFofl2HztDF72
         JT2KJOuLyiJFJphSk0tH2rQfbLL80gvzIvGOOwsvwUZQw5bdoqg2SLJeB6qGRZ3X8rIv
         dC5LqY3Yzb7BC3rZcetmSH1hh69WUcB8jpJmsbFaRJcglDgKyxlrfcY9tYgJXs9NfTEn
         WhhA==
X-Gm-Message-State: AAQBX9cdHJ6OXDT/P3rH+TP9lLbbp0emFYIfieVYSbCiJ5jwHgYf0WmT
        i3kxo0C2VCKlT+S+CXKVo5lg1vyPWVWQAO/giFw=
X-Google-Smtp-Source: AKy350YL6Jwju8WjJsDXBH4J20X7plPEdUG7cNSqv2dK7/NNvW7gq2AKWVHZYGQqtlEgz/4L14PVg9fxd9TF24gfC5g=
X-Received: by 2002:a17:907:c317:b0:930:310:abef with SMTP id
 tl23-20020a170907c31700b009300310abefmr10222404ejc.3.1680024179809; Tue, 28
 Mar 2023 10:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmbk-cQNY3Sd9iQ7vghqw_=sk9JsG-_Mf-OM_iRuw+h8j2E_w@mail.gmail.com>
In-Reply-To: <CAAmbk-cQNY3Sd9iQ7vghqw_=sk9JsG-_Mf-OM_iRuw+h8j2E_w@mail.gmail.com>
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Tue, 28 Mar 2023 18:22:49 +0100
Message-ID: <CAAmbk-dAD65xUNQ5C004rc_AU4qXhYj5NTLzwm7khQr-KV1LYg@mail.gmail.com>
Subject: Re: decant_cull_table intermittently aborting cachefilesd
To:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
        benmaynard@google.com, brennandoyle@google.com, tom@gunpowder.tech,
        daire@dneg.com, Chris Chilvers <chris.chilvers@appsbroker.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 3 Feb 2023 at 11:17, Chris Chilvers <chilversc@gmail.com> wrote:
>
> I have been having an issue where cachefilesd will randomly crash causing the
> cache to be withdrawn. The crash is intermittent and can sometimes happen
> within minutes, other times it can take hours, or never.
>
> Fortunately it has produced a crash dump so I've been able to analyse what
> happened.
>
> From the stack trace (and debug logging) the last operation it was running is
> the decant_cull_table. The code fails in the check block at the end of the
> function when it calls abort().
>
>     (gdb) bt
>     #0  __pthread_kill_implementation (no_tid=0, signo=6,
> threadid=140614334650176) at ./nptl/pthread_kill.c:44
>     #1  __pthread_kill_internal (signo=6, threadid=140614334650176) at
> ./nptl/pthread_kill.c:78
>     #2  __GI___pthread_kill (threadid=140614334650176,
> signo=signo@entry=6) at ./nptl/pthread_kill.c:89
>     #3  0x00007fe353442476 in __GI_raise (sig=sig@entry=6) at
> ../sysdeps/posix/raise.c:26
>     #4  0x00007fe3534287f3 in __GI_abort () at ./stdlib/abort.c:79
>     #5  0x0000556d6c9f0965 in decant_cull_table () at cachefilesd.c:1571
>     #6  cachefilesd () at cachefilesd.c:780
>     #7  0x0000556d6c9f140b in main (argc=<optimized out>,
> argv=<optimized out>) at cachefilesd.c:581
>
> For reference the code at frame 5 from the decant_cull_table function is:
>
>     check:
>         for (loop = 0; loop < nr_in_ready_table; loop++)
>             if (((long)cullready[loop] & 0xf0000000) == 0x60000000)
>                 abort();
>
> Checking the cull table, the first object in the cull table appears to be
> valid.
>
>     (gdb) p nr_in_ready_table
>     $1 = 242
>
>     (gdb) p cullready[0]
>     $2 = (struct object *) 0x556d6d7382a0
>
>     (gdb) p -pretty -- *cullready[0]
>     $3 = {
>         parent = 0x556d6d7352b0,
>         children = 0x0,
>         next = 0x0,
>         prev = 0x0,
>         dir = 0x0,
>         ino = 13631753,
>         usage = 1,
>         empty = false,
>         new = false,
>         cullable = true,
>         type = OBJTYPE_DATA,
>         atime = 1675349423,
>         name = "E"
>     }
>
> The inode number from the struct matches a file in the fscache.
>
>     $ sudo find /var/cache/fscache -inum 13631753
>     /var/cache/fscache/cache/Infs,3.0,2,,300000a,e5e9b1269df2b0d,,,d0,100000,100000,249f0,249f0,249f0,249f0,1/@00/E210w114Hg92Az0HAMYCClFMVmkMY050002w1qO200
>
> However, the memory address of the struct matches (fails) the check.
>
>     (gdb) p (((long)cullready[0] & 0xf0000000) == 0x60000000)
>     $4 = 1
>
>       0000 556d 6d73 82a0
>     & 0000 0000 f000 0000
>     = 0000 0000 6000 0000
>
>     $ file /sbin/cachefilesd
>     /sbin/cachefilesd: ELF 64-bit LSB pie executable, x86-64
>
> Looking at the code, I suspect that this magic 0x60000000 number is supposed
> to be some kind of sentinel value that's used as a bug check for errors such
> as use after free? This would make sense when the application was 32 bit, as
> address pattern 0110 in the highest nibble either cannot occur, or lies within
> the kernel address space. However, when compiled as 64 bit this assumption is
> no longer true and the bit pattern can appear in perfectly valid addresses.
>
> This would also explain the random nature of the crashes, as the cachefilesd
> is at the whims of the OS and calloc function.
>
> --
> Chris

Any thoughts on this issue? I think the main question to be answered is if the
debug checks such as "(0x6b000000 | __LINE__)" still have any value. If not
this can be simplified by simply setting the pointer to null, and updating
the check to look for nulls.

If __LINE__ still has value then there are two questions to answer:

1. How to make this safe for 64 bit architectures?
2. Should __LINE__ only be included in debug builds, and null used normally?
