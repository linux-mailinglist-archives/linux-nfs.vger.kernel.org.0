Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AE035E01A
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 15:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhDMNcM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 09:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhDMNcL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Apr 2021 09:32:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A94C061574
        for <linux-nfs@vger.kernel.org>; Tue, 13 Apr 2021 06:31:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r22so19384503edq.9
        for <linux-nfs@vger.kernel.org>; Tue, 13 Apr 2021 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAPrL35m/+L6o8mh2iFLReVi+jumD1TrRJTUo3XOC9U=;
        b=jd/4/wP3YKfvZv7mvrCFIRGHluLB4Hbrdh/jZu9avsV1eBdt3iT4s7ItFwPTiVTAR3
         t7ELFN25tBEL4T+1yRh9s6tAlixAphcYFnWYZ2ZJP5qjuyjumifwnP2QuGV06WW3Dnv0
         qZ5xzhYKhZPgzmyHwJDUF/rmrCbJ9SlVQFPYFhxxQljnOy/h18Du4+hoEgFam54vv78e
         rMvxgHBnJa499SjpgczkaD6nm8Q7w3vn03aoylF29RP2RJPtG4jpZHNqB61Cfx9hW3W3
         sfuho+ber71nxBqTMx+TzvVkIC1z5IbNzYbv8Uoq/479LTLSJPLm/kSIV8LpdAmLRYlB
         SGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAPrL35m/+L6o8mh2iFLReVi+jumD1TrRJTUo3XOC9U=;
        b=Uh8VRNE0gGL+9C/UMLlb9jo66z6GG7KOYEuN8ffymchMu8OpOuCcCj1HvEP/lzBeI6
         B5qwKSGrohdYzZruk7mzDfMvMgKnArVn2k+pGqJroL4Ujb1/YFA80KQuS7N+/4UwyGJT
         dTcSJVLO34+Ol7TsMhN9dcxpSIIA0P4Q12HOhWm6txvFMkTpsU2RgFH0ZEiqMQvfuXIY
         0Xwwusu33XnGL+MXBvkjipBBvU0t07frAkz6EoHBZQ3ixmyrULyr2Wbp4DPJ+vw0qrci
         4a/zpT58vYu7ly54QIHK1GYjI1sNoxa6SFr0ai9LEWlKijG5ua57wUCIo53BUN7OHDcx
         2tcg==
X-Gm-Message-State: AOAM532ee/RRRdRjHwtuZSaMke11RmgU4DQi8+/RzVnX/d/xqUXXJJ3O
        nTfHuQsFjpFemTiuYS1i0hw7HWQeRS44VfzxCJc=
X-Google-Smtp-Source: ABdhPJzAuq2SfyIK+xrQBXXCDpIG+lUbVLGL1guWzXJrT+q1m3pEF8Myv2kkkrOt3Fv38OOEJQXoltK/mTUJSTPE2jw=
X-Received: by 2002:a05:6402:9:: with SMTP id d9mr34732473edu.67.1618320708924;
 Tue, 13 Apr 2021 06:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <YQXPR0101MB0968E44CE6FB05F22DE27716DD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQXPR0101MB0968E44CE6FB05F22DE27716DD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 13 Apr 2021 09:31:37 -0400
Message-ID: <CAN-5tyEWwAtBG41VByps+zS6Sw_z9U7Q8HZb84SqyXp4woUiPA@mail.gmail.com>
Subject: Re: Linux NFSv4.1 client session seqid sometimes advances by 2
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     Linux-NFS <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 13, 2021 at 3:08 AM Rick Macklem <rmacklem@uoguelph.ca> wrote:
>
> Hi,
>
> During testing of a Fedora Core 30 (5.2.10 kernel) against a FreeBSD
> server (4.1 mount), I have been simulating a network partitioning
> for a few minutes (until the TCP connection goes to SYN_SENT on
> the Linux client).
>
> Sometimes, after the network partition heals, the FreeBSD server
> replies NFS4ERR_SEQ_MISORDERED.
> Looking at the packet trace, the seqid for the slot has advanced by
> 2 instead of 1. An RPC request for old-seqid + 1 never seems to get
> sent.
> --> Since sending an RPC with "seqid + 2" but never sending one
>        that is "seqid + 1" for a slot seems harmless, I have added an optional
>        hack (can be turned off), to allow this case instead of replying
>        NFS4ERR_SEQ_MISORDERED for it. The code will still reply
>        NFS4ERR_SEQ_MISORDERED if an RPC for the slot with
>        "old seqid + 1" in it.
>        --> Yes, doing this hack is a violation of RFC5661, but I've
>              done it anyhow.
>
> If you are interested in a packet capture with this in it:
> fetch https://people.freebsd.org/~rmacklem/linuxtofreenfs.pcap
> - then look at packet #1945 and #2072
>   --> You'll see that slot #1 seqid goes from 4 to 6. There is no
>          slot#1 seqid 5 RPC sent on the wire.
>          (This packet capture was taken on the Linux client using
>           tcpdump.)
> --> Btw, the "RST battle" you'll see in the above trace between
>        #2005 and #2068 that goes on until the FreeBSD
>        krpc/NFS times out the connection after 6min. seems to be a recent
>        FreeBSD TCP bug.
>        I have reproduced this seqid advances by 2 on an older system
>        that does not "RST battle" and allows the reconnect right away,
>        once the network partition is healed, so it does seem to be
>        relevant to this bug.
>
> Someday, I will get around to upgrading to a more recent Linux
> kernel and will test to see if I can still reproduce this bug.
> On 5.2.10, it is intermittent and does not occur every time I
> do the network partitioning test.
>
> Mostly just fyi, rick

Hi Rick,

I think this is happening because slotid=1 had something queued up
using seqid=5 and that was interrupted because the connection was
RSTed. For the interrupted slot, the client would send solo SEQUENCE
with +1 seqid.
