Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801946D55B0
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Apr 2023 03:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjDDBBU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Apr 2023 21:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDDBBT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Apr 2023 21:01:19 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F568F;
        Mon,  3 Apr 2023 18:01:17 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s72so2885263pgs.9;
        Mon, 03 Apr 2023 18:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1680570077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CCXfWeH7hgQCw5saAwEpRaRCrJP+i78j7lB5LVUpd8=;
        b=nmWwWUE/fkCtsfJvnUl82hrVl6oxI9/MYCz/mM+BLSpxE7UKfc9QeAiBde78HSgETr
         2bj+URMx3h7FKoHjkRsGnv3SZJEJSzHgE6V7TBpHkrxWjnzRFE/WFSoB5ZMJB4QIUJHZ
         O8+auzs/J4sGPZ6HWQCZH7D1OYIIolhiFtMPWvXCrh6zYMYEEmEUKteDlgVs+Norjosk
         FHnGKNHP/20SqRRx7+go+0YwEGivkQ4s/jxl6Ttl31nz/+0G9Me4rF3NMDY435aZgKHc
         kd6hvFVAP3eu6DLx/6eU+wyJE6syAscIv24RSo/iLvGhoxQ+ogLoDEiHJc2koxG2RhR2
         Y0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680570077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CCXfWeH7hgQCw5saAwEpRaRCrJP+i78j7lB5LVUpd8=;
        b=pMKLbGP9IjmQGYhDo7UhE56ow8n+jGWF6u4irEPA98vSs52f49l54+/DGqRS63110w
         z+Ebip9xhd/lLpvDlkFFQ9g6wijmJbREKTopGVA4HkYyBaxjXlyYLQWq1Ud1Y5LI+rR/
         RBuAMCVGGZM9voT/z2zI6YfdhjZi5I7OK+kxYH1KWQeEHnKKr+e1gMu2t3FjAQHc0BtY
         EXyUZEwu7w0n4SF87klfmIPOOAA7w15yaHsdByNuemdNMCldUdhbaKnDXvLZQmZ3g0uO
         pYSteSQMfLC00vV1Jj660brCL8XU2rWg58Ay8sG2IBcJ3xoA3eXoZJjRN5ERhugoEwr+
         CHzQ==
X-Gm-Message-State: AAQBX9ej2c56TJSlKsyhWvyIsBOLufRzttxGetVKAne3S2Hxb/8sias/
        qsKTeJUsJmrVwUyDIZWAepAGl6TMJ52H6bP4UeQEaUyG
X-Google-Smtp-Source: AKy350Z0Jumxnzu4j0LMC/0GWLLbOZQTW95t5t77bxz9o/266/b/hqHx2mZkBE3E5U2fL4G8QoJnSngCBwVH+0AY1u0=
X-Received: by 2002:a63:2587:0:b0:50f:8d8a:f9b1 with SMTP id
 l129-20020a632587000000b0050f8d8af9b1mr149466pgl.12.1680570077127; Mon, 03
 Apr 2023 18:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org> <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org> <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <CAFX2Jf=5X3zyZEWQmD6Rg9jQAD7ccDbae5LQCwrAyPCVVoFumg@mail.gmail.com>
 <2add1769-1458-b185-bc78-6d573f61b6fc@linaro.org> <CAFX2JfnKy7juGQaDTzqosN9SF-zd+XrhSL9uh_Xg0GpJGDux-A@mail.gmail.com>
 <32530c36-91d0-d351-0689-aed6a0975a4b@linaro.org> <2f285607-cbf9-6abc-f436-edb6e9a3938b@linaro.org>
 <CAFX2Jfmz7QqZBEdzbPUhPs0yctnXVaVF68tX1c57YX=6ki=0TA@mail.gmail.com>
 <4fe39d77-eb7c-a578-aefa-45b76e2247c2@linaro.org> <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
 <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org> <CAFX2JfnS9GVc4NaxKhr9E4y10NNv6SPgcv1yoeHTfEw5NvZgMg@mail.gmail.com>
In-Reply-To: <CAFX2JfnS9GVc4NaxKhr9E4y10NNv6SPgcv1yoeHTfEw5NvZgMg@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 3 Apr 2023 21:01:06 -0400
Message-ID: <CAN-5tyGUBB0zoPbdJ=3yCE+eJJyP2qH3uobFP+XEMsFNex_LEA@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 6, 2023 at 12:12=E2=80=AFPM Anna Schumaker <schumaker.anna@gmai=
l.com> wrote:
>
> Hi Krzysztof,
>
> On Tue, Feb 14, 2023 at 6:02=E2=80=AFAM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 12/02/2023 15:05, Anna Schumaker wrote:
> > >>> From ac2d6c501dbcdb306480edaee625b5496f1fb4f5 Mon Sep 17 00:00:00 2=
001
> > >>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >>> Date: Fri, 10 Feb 2023 15:50:22 -0500
> > >>> Subject: [PATCH] NFSv4.2: Rework scratch handling for READ_PLUS
> > >>>
> > >>
> > >> Patch is corrupted - maybe mail program reformatted it when sending:
> > >>
> > >> Applying: NFSv4.2: Rework scratch handling for READ_PLUS
> > >> error: corrupt patch at line 12
> > >> Patch failed at 0001 NFSv4.2: Rework scratch handling for READ_PLUS
> > >
> > > That's weird. I wasn't expecting gmail to reformat the patch but I
> > > guess it did. I've added it as an attachment so that shouldn't happen
> > > again.
> >
> > Still null ptr (built on 420b2d4 with your patch):
>
> We're through the merge window and at rc1 now, so I can spend more
> time scratching my head over your bug again. We've come up with a
> patch (attached) that adds a bunch of printks to show us what the
> kernel thinks is going on. Do you mind trying it out and letting us
> know what gets printed out? You'll need to make sure
> CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kernel.

Hi Krzystof,

Since you are the only one hitting the problem, could you be so kind
as to help with getting this resolved.

Thank you.

>
> Thanks,
> Anna
>
> >
> > [  144.690844] mmiocpy from xdr_inline_decode (net/sunrpc/xdr.c:1419 ne=
t/sunrpc/xdr.c:1454)
> > [  144.695950] xdr_inline_decode from nfs4_xdr_dec_read_plus (fs/nfs/nf=
s42xdr.c:1063 fs/nfs/nfs42xdr.c:1147 fs/nfs/nfs42xdr.c:1360 fs/nfs/nfs42xdr=
.c:1341)
> > [  144.702452] nfs4_xdr_dec_read_plus from call_decode (net/sunrpc/clnt=
.c:2595)
> > [  144.708429] call_decode from __rpc_execute (include/asm-generic/bito=
ps/generic-non-atomic.h:128 net/sunrpc/sched.c:954)
> > [  144.713538] __rpc_execute from rpc_async_schedule (include/linux/sch=
ed/mm.h:336 net/sunrpc/sched.c:1035)
> > [  144.719170] rpc_async_schedule from process_one_work (include/linux/=
jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/workqu=
eue.h:108 kernel/workqueue.c:2294)
> > [  144.725238] process_one_work from worker_thread (include/linux/list.=
h:292 kernel/workqueue.c:2437)
> > [  144.730782] worker_thread from kthread (kernel/kthread.c:378)
> > [  144.735547] kthread from ret_from_fork (arch/arm/kernel/entry-common=
.S:149)
> >
> >
> >
> > Best regards,
> > Krzysztof
> >
