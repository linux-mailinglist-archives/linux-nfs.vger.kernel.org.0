Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033D8699B66
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Feb 2023 18:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBPRka (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Feb 2023 12:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBPRk3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Feb 2023 12:40:29 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674FE3B855;
        Thu, 16 Feb 2023 09:40:28 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso6652557pju.0;
        Thu, 16 Feb 2023 09:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V+KTxKIHjRmWBf0QETpjuOdM8DYig3OAwkvnEuzaxSU=;
        b=K09IVJNC7CR6Vj9s+Sa4FSd5pt3rF8aeDkMbwTg0mXZfk8aJ8m+ZEFc/4sH8acTAcF
         JrsEgtMgVVTwR9xiuoDm2UndcobmlgfCa0UkuviWbd7NsLFCKMkU7rLl3hWzJB2cfhcA
         AnsM3VaqEybR+ccR9p3UjHOUNmaRYBqIr0RYtDIRK+/FpBFWl02Sp+azJVv9Hql0PXS8
         3n1IKSLP/+V/AL+rKUgUK/NU5cDjhjGqAdpvebYjh7BLgzQkwMQ/Z2by7pzYuA3Wn5B4
         YBvZZ8q4QDdtD41fF123Bc0ItfG0a3Lz6Vvld1BIGUveu3jN/frShp/F6+j/c/weTi5W
         w4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+KTxKIHjRmWBf0QETpjuOdM8DYig3OAwkvnEuzaxSU=;
        b=Povemtm//zcReHKAXDos0QsO1c2AJZGHpRil7Xnx2rPZfGv0fKxfyTuE5+LNF6E1kM
         El/ok6n8W/G2n4+Fmg+M/4w2Xh2o8h/P9i3OCdOquYeKUUSaN1n+dvCuaVS14KQYA6Ho
         i1kHuAe6Q8Riu2oSJj3pXt8PAtHSwRyMd8v9sSXxZuuICiL3OeHNnF2dBXfGrvNLN4Vg
         ea+tES7uitBlwrhfL7MvR8vX/lL6BOdCrgp0aPGadX7GNt1Buo5IrjIicrKV8Lq/tIjB
         Op0zXOc12KgS79v9uEcrPYHVoQ7KfyJPAz6thq2QpuN1A4ePYoGiLFwpe/jaIa4V8TWi
         Q8xA==
X-Gm-Message-State: AO0yUKUvpnsVBNo5eop0VavmCN2xwTEKzgFZyq1kDtyt5OthKCl0+9Wo
        +rO1Am2crdNxOW6R7P5I+GfvSNw0RpDFDSwnqzc=
X-Google-Smtp-Source: AK7set/vWx1/1G+jCPRA4Yilt8YKORdc3vNIfM+JZrKCrXM/T3QMA7eVNW1h0Ylwq1MI1m/Ngdkg1zKNCq8ayGJdDTA=
X-Received: by 2002:a17:90b:390b:b0:233:e236:d54e with SMTP id
 ob11-20020a17090b390b00b00233e236d54emr751381pjb.123.1676569227665; Thu, 16
 Feb 2023 09:40:27 -0800 (PST)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org> <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org> <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <CAFX2Jf=5X3zyZEWQmD6Rg9jQAD7ccDbae5LQCwrAyPCVVoFumg@mail.gmail.com>
 <2add1769-1458-b185-bc78-6d573f61b6fc@linaro.org> <CAFX2JfnKy7juGQaDTzqosN9SF-zd+XrhSL9uh_Xg0GpJGDux-A@mail.gmail.com>
 <32530c36-91d0-d351-0689-aed6a0975a4b@linaro.org> <2f285607-cbf9-6abc-f436-edb6e9a3938b@linaro.org>
 <CAFX2Jfmz7QqZBEdzbPUhPs0yctnXVaVF68tX1c57YX=6ki=0TA@mail.gmail.com>
 <4fe39d77-eb7c-a578-aefa-45b76e2247c2@linaro.org> <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
 <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org>
In-Reply-To: <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 16 Feb 2023 12:40:16 -0500
Message-ID: <CAN-5tyEPP-mcDv7f-=BTZdGWMuFh16R9QnsU6THdp3U0QgbeVA@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Anna Schumaker <schumaker.anna@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 14, 2023 at 6:08 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/02/2023 15:05, Anna Schumaker wrote:
> >>> From ac2d6c501dbcdb306480edaee625b5496f1fb4f5 Mon Sep 17 00:00:00 2001
> >>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>> Date: Fri, 10 Feb 2023 15:50:22 -0500
> >>> Subject: [PATCH] NFSv4.2: Rework scratch handling for READ_PLUS
> >>>
> >>
> >> Patch is corrupted - maybe mail program reformatted it when sending:
> >>
> >> Applying: NFSv4.2: Rework scratch handling for READ_PLUS
> >> error: corrupt patch at line 12
> >> Patch failed at 0001 NFSv4.2: Rework scratch handling for READ_PLUS
> >
> > That's weird. I wasn't expecting gmail to reformat the patch but I
> > guess it did. I've added it as an attachment so that shouldn't happen
> > again.
>
> Still null ptr (built on 420b2d4 with your patch):
>
> [  144.690844] mmiocpy from xdr_inline_decode (net/sunrpc/xdr.c:1419 net/sunrpc/xdr.c:1454)
> [  144.695950] xdr_inline_decode from nfs4_xdr_dec_read_plus (fs/nfs/nfs42xdr.c:1063 fs/nfs/nfs42xdr.c:1147 fs/nfs/nfs42xdr.c:1360 fs/nfs/nfs42xdr.c:1341)
> [  144.702452] nfs4_xdr_dec_read_plus from call_decode (net/sunrpc/clnt.c:2595)
> [  144.708429] call_decode from __rpc_execute (include/asm-generic/bitops/generic-non-atomic.h:128 net/sunrpc/sched.c:954)
> [  144.713538] __rpc_execute from rpc_async_schedule (include/linux/sched/mm.h:336 net/sunrpc/sched.c:1035)
> [  144.719170] rpc_async_schedule from process_one_work (include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/workqueue.h:108 kernel/workqueue.c:2294)
> [  144.725238] process_one_work from worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437)
> [  144.730782] worker_thread from kthread (kernel/kthread.c:378)
> [  144.735547] kthread from ret_from_fork (arch/arm/kernel/entry-common.S:149)

My 2cents...

From what I can tell read_plus only calls xdr_inline_decode() for
"numbers" (eof, #segs, type, offset, length) and we always expect that
__xdr_inline_decode() would return a a non-null "p". But if
__xdr_inline_decode() returned null, the code would call
xdr_copy_to_scratch() which would ultimately call the memcpy().
xdr_copy_to_scrach() expects the scratch buffer to be setup. However,
as I said, for the decode of numbers we don't set up the scratch
space. Which then leads to this oops. How, the reason the
__xdr_inline_decode() would return a null pointer if it ran out it's
provided xdr space which was provided #decode_read_plus_maxsz.

#define NFS42_READ_PLUS_DATA_SEGMENT_SIZE \
                                        (1 /* data_content4 */ + \
                                         2 /* data_info4.di_offset */ + \
                                         1 /* data_info4.di_length */)
#define decode_read_plus_maxsz          (op_decode_hdr_maxsz + \
                                         1 /* rpr_eof */ + \
                                         1 /* rpr_contents count */ + \
                                         NFS42_READ_PLUS_DATA_SEGMENT_SIZE)

while a data segment needs (2) + (1), a hole segment needs to be (2) +
(2) (as both offset and lengths are longs.

while a "correct" maxsz is important for page alignment for reads, it
might means we are not providing enough space for when there are hole
segments? It seems weird that for the spec we have hole length and
data length of different types (long and int).

>
>
>
> Best regards,
> Krzysztof
>
