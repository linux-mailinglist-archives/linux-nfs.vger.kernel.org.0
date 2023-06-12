Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EEC72D005
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 21:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjFLT7T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 15:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjFLT7D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 15:59:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9502B1BF4
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 12:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DA7862DE5
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 19:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2FCC43443
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686599875;
        bh=BoxfFe9BgcsSYc3QKLmO5lLxAe+qk80k0IuzyW/9cCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VkFxlexBMOXDrUNU/VIkvUupInoz1EMkZODTCNofY3cJpIa5Y6dnQsN6PR42ctE0G
         yb+1irUjuHuUWgtwHGcJu+idD4Qmrdi1ktKoxFDIBD6W2jvRuwFj6itLCp6qmWXPGs
         8DaoxQ2Aez8H3VWI96GgkiKmYWi7y20JmouBJiUJv6EYniVmNkIbOdBWDoYf+Tp1o1
         Q9Gq6byTMI1wXmCEqnIM6dIufarTdj8drpH1l+TnYhsd9oXnyxEaL5+o6Us7O2nqQ8
         O3P/FvEY7FFKFp8XWaiuJpjJHP2LJ9+ADsXeaJKTGIu5r4hMUZG8PU181F0Lac/hgq
         wky/d3irmf/MQ==
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-3f9e4adf29eso2346261cf.0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 12:57:55 -0700 (PDT)
X-Gm-Message-State: AC+VfDytYStYsuBaAINDLnZPqqeUA85fxv1/4+oW97d8GZsOUZdP0Sll
        W3gmgnb8BfG2GOLXnNDB677RU+PJd1/An9CRCVM=
X-Google-Smtp-Source: ACHHUZ6bjRdlJLhOU9lYrikiqEBQe26Ns0kfC9DYMeXELUkveqvIYKMbIfSwPjpP/7xU6CQpmYaOAJ6gQDMQ1K6nvsg=
X-Received: by 2002:a05:622a:251:b0:3f9:b37c:4ee4 with SMTP id
 c17-20020a05622a025100b003f9b37c4ee4mr11370643qtx.60.1686599874544; Mon, 12
 Jun 2023 12:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230609200013.849882-1-anna@kernel.org> <20230609200013.849882-3-anna@kernel.org>
 <c6e8ecea-d85c-dc12-34c0-6070f104d61b@linaro.org>
In-Reply-To: <c6e8ecea-d85c-dc12-34c0-6070f104d61b@linaro.org>
From:   Anna Schumaker <anna@kernel.org>
Date:   Mon, 12 Jun 2023 15:57:38 -0400
X-Gmail-Original-Message-ID: <CAFX2Jf=dnTL2_Sv4-uw1uJm0_JCjOCOS2vbQ4kJjU9-3fYcXZg@mail.gmail.com>
Message-ID: <CAFX2Jf=dnTL2_Sv4-uw1uJm0_JCjOCOS2vbQ4kJjU9-3fYcXZg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] NFSv4.2: Rework scratch handling for READ_PLUS (again)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jun 10, 2023 at 6:13=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
>
> On 09/06/2023 22:00, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > I found that the read code might send multiple requests using the same
> > nfs_pgio_header, but nfs4_proc_read_setup() is only called once. This i=
s
> > how we ended up occasionally double-freeing the scratch buffer, but als=
o
> > means we set a NULL pointer but non-zero length to the xdr scratch
> > buffer. This results in an oops the first time decoding needs to copy
> > something to scratch, which frequently happens when decoding READ_PLUS
> > hole segments.
> >
> > I fix this by moving scratch handling into the pageio read code. I
> > provide a function to allocate scratch space for decoding read replies,
> > and free the scratch buffer when the nfs_pgio_header is freed.
> >
> > Krzysztof Kozlowski hit a bug a while ago with similar symptoms,
> > and I'm hopeful that this patch fixes his issue.
>
> Unfortunately it does not help. Same NULL ptr, next-20230609 with this
> patchset:

That's unfortunate. I was really hoping between patch #2 and #3 that
it would finally address the issue. I think you said your client is
ARM v7, that's 32-bit right? I'll try to do some 32-bit testing to see
if that uncovers anything on my end. In the meantime, I'll try to
update the debugging printk() patch based on what I learned while
working patch #3 last week. I'll try to get that to you in the next
day or two.

Anna

>
>
> [   26.780433] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000004 when read
>
> [   27.124547] mmiocpy from xdr_inline_decode (net/sunrpc/xdr.c:1424 net/=
sunrpc/xdr.c:1459)
> [   27.129643] xdr_inline_decode from nfs4_xdr_dec_read_plus (fs/nfs/nfs4=
2xdr.c:1069 fs/nfs/nfs42xdr.c:1152 fs/nfs/nfs42xdr.c:1365 fs/nfs/nfs42xdr.c=
:1346)
> [   27.136147] nfs4_xdr_dec_read_plus from call_decode (net/sunrpc/clnt.c=
:2592)
> [   27.142124] call_decode from __rpc_execute (include/asm-generic/bitops=
/generic-non-atomic.h:128 net/sunrpc/sched.c:952)
> [   27.147232] __rpc_execute from rpc_async_schedule (include/linux/sched=
/mm.h:368 net/sunrpc/sched.c:1033)
> [   27.152864] rpc_async_schedule from process_one_work (include/linux/at=
omic/atomic-arch-fallback.h:444 include/linux/jump_label.h:260 include/linu=
x/jump_label.h:270 include/trace/events/workqueue.h:108 kernel/workqueue.c:=
2599)
> [   27.158935] process_one_work from worker_thread (include/linux/list.h:=
292 kernel/workqueue.c:2746)
> [   27.164476] worker_thread from kthread (kernel/kthread.c:381)
> [   27.169329] kthread from ret_from_fork (arch/arm/kernel/entry-common.S=
:134)
>
> Best regards,
> Krzysztof
>
