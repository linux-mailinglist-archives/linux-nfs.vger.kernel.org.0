Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3127131D167
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 21:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBPUNk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 15:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBPUNi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Feb 2021 15:13:38 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA86C061574;
        Tue, 16 Feb 2021 12:12:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id do6so8192628ejc.3;
        Tue, 16 Feb 2021 12:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFY3DWXmxGfZDW5PIinyDoY6VRCpFaPsbuNKCfaklzA=;
        b=GbKyIBFIcZETvym+2t4xzdEGBhgJxDSaSe/kpCKvbywEB9srrtIOl0Dv9i95ZAmjJQ
         iw+0K8vmXFF7UYTRzOtQxtIBQQ7LifIRCNYr3hchLMvMfTvLZIzwqm912graWuQJ6p81
         WdIpzQRaaBtss+AZLDwnpKuSqHhlD4LaQOlZKs+Dzm5Z0EmoDLGFr8s7RScFjXjXJ6C2
         7/JZyYJ+ljNs0zetS6cUqxzIL2/vAUsdHGXAZiAixHT8+QQYW7fN4x9mTu1AFqpm1/kz
         k+42bWv8qy+2j0UNp4CR3QMyNN/sKp4b2h3I9gRexXBJjCR8RfjkukyOYidjIZ+qUcn6
         MjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFY3DWXmxGfZDW5PIinyDoY6VRCpFaPsbuNKCfaklzA=;
        b=HL/NQeskl3ZGHMkhZ6601GP1SGUEWwbCx4s3Xbi4z7NRi50lH3KA+sEBUL5YI70crZ
         rGjE9LrLg+VRP20E8GDZ//RjD+dgRAdVQEUdm9zfo77PneALv21BoYXTVGCIEOQgyIfH
         d8eR4y7tFVaSvFFKMJLmSJ6rfoDm9Xg5HAQmRo/yIYfc8aXkO5id2KJrPf2ulI/zxhSz
         mMgPwY8/doWxBNSfajzBAl2D5PWNk+m2p5Qn72gYor5M1Nv+ssaAiBPsY46GKyiflmpZ
         4ibrcI2uaGGUPtbtdUMK7jdJI/jB2Wg+Scdyx6UcHnnJM5LVI6snO/TXisTxya6t1UEh
         DErg==
X-Gm-Message-State: AOAM532ihpkyQiYHTmyyj5GpoWbmMSsXDQi1knXEXV+wHyUn7vW9e5JG
        Ts0oIRsbeJ4XwNCLobKQOmes+hhiv5OSMfo94sSy/To9Mnc=
X-Google-Smtp-Source: ABdhPJziEJe2br4ImstTMlwL/yY6J6hEIIAIVyFFI59+wJEQVk2Mut8aiQuVbWToCGvurcT2co/9Z4WeQv5ipckn2II=
X-Received: by 2002:a17:907:35ca:: with SMTP id ap10mr22508352ejc.451.1613506377040;
 Tue, 16 Feb 2021 12:12:57 -0800 (PST)
MIME-Version: 1.0
References: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
In-Reply-To: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 16 Feb 2021 15:12:45 -0500
Message-ID: <CAN-5tyE4OyNOZRXGnyONcdGsHaRAF39LSE5416Kj964m-+_C2A@mail.gmail.com>
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
To:     Timo Rothenpieler <timo@rothenpieler.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Timo,

Can you get a network trace? Also, you say that the copy_file_range()
(after what looks like a successful copy) never returns (and
application hangs), can you get a sysrq output of what the process's
stack (echo t > /proc/sysrq-trigger  and see what gets dumped into the
var log messages and locate your application and report what the stack
says)?

On Sat, Feb 13, 2021 at 10:41 PM Timo Rothenpieler
<timo@rothenpieler.org> wrote:
>
> On our Fileserver, running a few weeks old 5.10, we are running into a
> weird issue with NFS 4.2 Server-Side Copy and RDMA (and ZFS, though I'm
> not sure how relevant that is to the issue).
> The servers are connected via InfiniBand, on a Mellanox ConnectX-4 card,
> using the mlx5 driver.
>
> Anything using the copy_file_range() syscall to copy stuff just hangs.
> In strace, the syscall never returns.
>
> Simple way to reproduce on the client:
>  > xfs_io -fc "pwrite 0 1M" testfile
>  > xfs_io -fc "copy_range testfile" testfile.copy
>
> The second call just never exits. It sits in S+ state, with no CPU
> usage, and can easily be killed via Ctrl+C.
> I let it sit for a couple hours as well, it does not seem to ever complete.
>
> Some more observations about it:
>
> If I do a fresh reboot of the client, the operation works fine for a
> short while (like, 10~15 minutes). No load is on the system during that
> time, it's effectively idle.
>
> The operation actually does successfully copy all data. The size and
> checksum of the target file is as expected. It just never returns.
>
> This only happens when mounting via RDMA. Mounting the same NFS share
> via plain TCP has the operation work reliably.
>
> Had this issue with Kernel 5.4 already, and had hoped that 5.10 might
> have fixed it, but unfortunately it didn't.
>
> I tried two server and 30 different client machines, they all exhibit
> the exact same behaviour. So I'd carefully rule out a hardware issue.
>
>
> Any pointers on how to debug or maybe even fix this?
>
>
>
> Thanks,
> Timo
