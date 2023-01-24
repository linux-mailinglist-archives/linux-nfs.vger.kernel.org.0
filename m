Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30716679E32
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 17:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjAXQHq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 11:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjAXQHp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 11:07:45 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D823F65BD
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 08:07:43 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a184so11507016pfa.9
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 08:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d2IuVCJBKswzDb6e8ctiUzNOQcpAaOiJqmRSoK265as=;
        b=Z+1LgT4wR9gaQoyPQLk3LwD60sagS2vEIstmy45oTPnrR00UrW0ZVq6G8rschwh+bI
         sY24mBvHfUj6Tkdy1v5VKd+EXGEP28ieeEdmKJ4qKy992cMgohwBOXplEyAbLdSjbz4D
         g/59iW3VieGXjTJSBX4TyhUpnYpxWO2ANNOVSSH5X+iq+fGmRUYz2JDFZ7423poBFT2X
         rdIl9fGatb2cURQdrvXwYB7oaa+jTQ7wGXJ7ELUZLBCTyjopYX2BD4a1PtIRxReXyP8b
         pAXoDYrlK9EUrJPqEEybbYjKJGx5B+9LvjurS8NmEgNV9rJPfdwQpCDmbPPQ0xknkhg3
         3GlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2IuVCJBKswzDb6e8ctiUzNOQcpAaOiJqmRSoK265as=;
        b=rKArgX9IYh1XLLDj1Yu606xc2yhvKT3MWnc/rA3SV7/iXXXoPWoYizEGUu54B0eDb9
         /2XXdSmPQiIbBQP5noTuUaOk8sEQnrFbTvZeRwojwVEe2Q5JqawxByxuhWpmw/z62C2X
         uKRpY2PdJZP0nVhkBOIV+D0oI8sWZuhIme10WSgtM4m7tvHRlkRAFA3C/NFfbfKRg7QV
         B76OCT9sae7G+Vtdt11l1htIyF7qnn8VrAR7mg3yyFLT2VWBYw0c2+JWrXD1phOJcM+d
         dblK2b3wS2WqrMNk08u5VfH2FfTb9QmuFpCXpuN8gKtBQJzjxm/MftftDyWNlJTHtYfK
         8I4A==
X-Gm-Message-State: AFqh2kr9p7h1HcYxzIRvYJJKA3Nf1Dn+lSysaFV9N5PVVjVVqB5VTy/c
        QvT247AH+hTNPF0LYEDUEKm/Ex29v4U/VXtdybw=
X-Google-Smtp-Source: AMrXdXsktM7fZhENBQQfXoTpUQ+LdCZabs290vsbpOQTRNlHGNquJwYN4cCgRKtnKZ3UrJVqf9v+VPo8DpaYG3mBaX0=
X-Received: by 2002:a62:1b0a:0:b0:58d:8e62:6c0b with SMTP id
 b10-20020a621b0a000000b0058d8e626c0bmr3032541pfb.42.1674576463161; Tue, 24
 Jan 2023 08:07:43 -0800 (PST)
MIME-Version: 1.0
References: <20230119213351.443388-1-trondmy@kernel.org>
In-Reply-To: <20230119213351.443388-1-trondmy@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 24 Jan 2023 11:07:31 -0500
Message-ID: <CAN-5tyFbSaaQBGHkOuckjqPP56QFS-=fF9TuYVLMiaFD0UBCTg@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Initial conversion of NFS basic I/O to use folios
To:     trondmy@kernel.org
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 20, 2023 at 12:10 AM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> This set of patches represents an initial effort to convert the page
> cache I/O in the NFS client to use native folio functionality. It should
> allow the nfs_page structs and their helpers to carry folios (including
> folios of order > 0) and to pass their data contents through to the RPC
> layer.
> Note that because O_DIRECT uses pages, we still need to support the
> traditional page based I/O, and so the new struct nfs_page will carry
> both types.
> I did not touch the fscache code, but I expect that to be able to
> continue to work with order 0 folios.
>
> The plan is to merge this functionality with order 0 folios first, in
> order to catch any regressions in existing functionality. Then we can
> enable order n > 0 once we're happy about the stability (at least for
> the non-fscache case).
>
> At this point, the xfstests are all passing without any regressions on
> my setup, so I'm throwing the patches over the fence to allow for wider
> testing.
> Please make sure, in particular to test pNFS if your server supports it.
> I didn't have to make any changes to the pNFS code, and I don't expect
> any trouble, but it would be good to have validation of that assumption.

Here's my experience with running with these patches running thru
xfstest's quick group:
Against a linux server: takes about a couple of minutes longer to run
with folio patches (48m with folio, 45 without) but that's just from 1
run with and and without.

Against an ontap server (so pnfs case):  total time is higher with
patches: I have a difference of 47m with folio and 38m without.

While I don't believe this is related to folio patches but I need to
increase my vm's size to 4g to have a successful run of xfstest. Tests
generic/531 and generic/460 are problematic with 2G. generic/531 leads
to oom-killer and generic/460 hangs.


>
> ---
> v2:
>  - Fix a bisectability issue reported by Anna
>  - Remove an unnecessary NULL pointer check in nfs_read_folio()
>
> Trond Myklebust (18):
>   NFS: Fix for xfstests generic/208
>   NFS: Add basic functionality for tracking folios in struct nfs_page
>   NFS: Support folios in nfs_generic_pgio()
>   NFS: Fix nfs_coalesce_size() to work with folios
>   NFS: Add a helper to convert a struct nfs_page into an inode
>   NFS: Convert the remaining pagelist helper functions to support folios
>   NFS: Add a helper nfs_wb_folio()
>   NFS: Convert buffered reads to use folios
>   NFS: Convert the function nfs_wb_page() to use folios
>   NFS: Convert buffered writes to use folios
>   NFS: Remove unused function nfs_wb_page()
>   NFS: Convert nfs_write_begin/end to use folios
>   NFS: Fix up nfs_vm_page_mkwrite() for folios
>   NFS: Clean up O_DIRECT request allocation
>   NFS: fix up nfs_release_folio() to try to release the page
>   NFS: Enable tracing of nfs_invalidate_folio() and nfs_launder_folio()
>   NFS: Improve tracing of nfs_wb_folio()
>   NFS: Remove unnecessary check in nfs_read_folio()
>
>  fs/nfs/direct.c          |  12 +-
>  fs/nfs/file.c            | 124 +++++++------
>  fs/nfs/internal.h        |  38 ++--
>  fs/nfs/nfstrace.h        |  58 ++++--
>  fs/nfs/pagelist.c        | 217 +++++++++++++++++-----
>  fs/nfs/pnfs.h            |  10 +-
>  fs/nfs/pnfs_nfs.c        |  18 +-
>  fs/nfs/read.c            |  94 +++++-----
>  fs/nfs/write.c           | 380 ++++++++++++++++++++-------------------
>  include/linux/nfs_fs.h   |   7 +-
>  include/linux/nfs_page.h |  79 +++++++-
>  11 files changed, 646 insertions(+), 391 deletions(-)
>
> --
> 2.39.0
>
