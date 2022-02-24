Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E2C4C2F00
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 16:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiBXPI3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 10:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiBXPI2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 10:08:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E94042A2F
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645715277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zW8MpZRIcYdegour5AdeFQYVjH6vtNmq9KFcn/WZe70=;
        b=N+pDUYgdSCx9BCD+AfKkWiri1+k5L0HiwXbJqEe8ftQaByuh3zcAdYQdN/1/v9zEUlovCV
        nKeQ40c+57PYVfMcvWUzBZiqk3a10YD7MwoFRmh16419ehkLZ9g/rG3MHjvOkM1MmaOXs5
        x/fndCvuue8xWV0tPZxOJypKTz7ShUk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-3243B_PZPu6tNAgCbiB9uA-1; Thu, 24 Feb 2022 10:07:56 -0500
X-MC-Unique: 3243B_PZPu6tNAgCbiB9uA-1
Received: by mail-ej1-f70.google.com with SMTP id m12-20020a1709062acc00b006cfc98179e2so1351843eje.6
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 07:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zW8MpZRIcYdegour5AdeFQYVjH6vtNmq9KFcn/WZe70=;
        b=P/mkBsQY0Z09DIfwr0NrVeKWz9sabcGABRlvgPEvZ1VasJHClHAOQ73KgG4dT/QWa5
         ixxNOo7zWN2n92R7bMjnMgMzFTcPtfDgZC4cwRJfi93ScB9oWmpo4QdBgffYqDZVZe/l
         SbzwjNLuXLsHKgq13z8OPciue8r6aMyBjERDCI+0NpWwiGN/iGAhZdJbJfcHG+bzFigD
         f1+7ZqRMI//MJ5a5LkP98R1Kb0qTvvS5e7McysYRVKQvkr5aF1Xa1zikABSUQ+/rnvKu
         BSPTMFsd67SOMH2/r67Qx39k8Urjn5TVfYbR2p0EpFxJkclc10HH36WiM8PDPFFPrOUd
         P4qg==
X-Gm-Message-State: AOAM532RyIRBKb32sFwdwrkMYZ1QFSiSZO7QYbUy2c0Cz4RdNhjs61Wi
        EPzGLXXlLsEGZLbx5mnhYB18aDU5tvXDuAR2qKXollbLdkaxx+55aR49gl2AlLN/kcreheMH5Qk
        U6GjhRSO5Qxl9re8R1pHmcpe6/wIMakH37HTR
X-Received: by 2002:aa7:c982:0:b0:406:3862:a717 with SMTP id c2-20020aa7c982000000b004063862a717mr2742175edt.358.1645715274471;
        Thu, 24 Feb 2022 07:07:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/bJLORKKAWCX9RlnSJli1ofbnNUkj8eGydLZvxOJt6Oy7Q3WTIi49EUjY41Sm0oquCVNr0n3mEB+SsV0eD5g=
X-Received: by 2002:aa7:c982:0:b0:406:3862:a717 with SMTP id
 c2-20020aa7c982000000b004063862a717mr2742152edt.358.1645715274269; Thu, 24
 Feb 2022 07:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20220223211305.296816-1-trondmy@kernel.org>
In-Reply-To: <20220223211305.296816-1-trondmy@kernel.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 24 Feb 2022 10:07:18 -0500
Message-ID: <CALF+zOm0X8oH2=QbpdDJzCvZLq5qb2ygsuQAUo4e4P242Px+dQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/21] Readdir improvements
To:     trondmy@kernel.org
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 23, 2022 at 4:24 PM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> The current NFS readdir code will always try to maximise the amount of
> readahead it performs on the assumption that we can cache anything that
> isn't immediately read by the process.
> There are several cases where this assumption breaks down, including
> when the 'ls -l' heuristic kicks in to try to force use of readdirplus
> as a batch replacement for lookup/getattr.
>
> This series also implement Ben's page cache filter to ensure that we can
> improve the ability to share cached data between processes that are
> reading the same directory at the same time, and to avoid live-locks
> when the directory is simultaneously changing.
>
> --
> v2: Remove reset of dtsize when NFS_INO_FORCE_READDIR is set
> v3: Avoid excessive window shrinking in uncached_readdir case
> v4: Track 'ls -l' cache hit/miss statistics
>     Improved algorithm for falling back to uncached readdir
>     Skip readdirplus when files are being written to
> v5: bugfixes
>     Skip readdirplus when the acdirmax/acregmax values are low
>     Request a full XDR buffer when doing READDIRPLUS
> v6: Add tracing
>     Don't have lookup request readdirplus when it won't help
> v7: Implement Ben's page cache filter
>     Reduce the use of uncached readdir
>     Change indexing of the page cache to improve seekdir() performance.
>
> Trond Myklebust (21):
>   NFS: constify nfs_server_capable() and nfs_have_writebacks()
>   NFS: Trace lookup revalidation failure
>   NFS: Use kzalloc() to avoid initialising the nfs_open_dir_context
>   NFS: Calculate page offsets algorithmically
>   NFS: Store the change attribute in the directory page cache
>   NFS: If the cookie verifier changes, we must invalidate the page cache
>   NFS: Don't re-read the entire page cache to find the next cookie
>   NFS: Adjust the amount of readahead performed by NFS readdir
>   NFS: Simplify nfs_readdir_xdr_to_array()
>   NFS: Reduce use of uncached readdir
>   NFS: Improve heuristic for readdirplus
>   NFS: Don't ask for readdirplus unless it can help nfs_getattr()
>   NFSv4: Ask for a full XDR buffer of readdir goodness
>   NFS: Readdirplus can't help lookup for case insensitive filesystems
>   NFS: Don't request readdirplus when revalidation was forced
>   NFS: Add basic readdir tracing
>   NFS: Trace effects of readdirplus on the dcache
>   NFS: Trace effects of the readdirplus heuristic
>   NFS: Convert readdir page cache to use a cookie based index
>   NFS: Fix up forced readdirplus
>   NFS: Remove unnecessary cache invalidations for directories
>
>  fs/nfs/dir.c           | 450 ++++++++++++++++++++++++-----------------
>  fs/nfs/inode.c         |  46 ++---
>  fs/nfs/internal.h      |   4 +-
>  fs/nfs/nfs3xdr.c       |   7 +-
>  fs/nfs/nfs4proc.c      |   2 -
>  fs/nfs/nfs4xdr.c       |   6 +-
>  fs/nfs/nfstrace.h      | 122 ++++++++++-
>  include/linux/nfs_fs.h |  19 +-
>  8 files changed, 421 insertions(+), 235 deletions(-)
>
> --
> 2.35.1
>

I don't see this pushed this to your 'testing' branch, but I applied
manually after resetting at 3f58e709c162

