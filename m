Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F75C479643
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 22:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhLQV3W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 16:29:22 -0500
Received: from mail-yb1-f171.google.com ([209.85.219.171]:35526 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhLQV3U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 16:29:20 -0500
Received: by mail-yb1-f171.google.com with SMTP id f186so10180554ybg.2;
        Fri, 17 Dec 2021 13:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pn0ur1BFCtLMdbUNUW1pRKzy9PScyNapSw3t2m+VPHs=;
        b=x/oByh2QOKozuF1fNjucuXN1+6F6/nnHoeJnHVRi0TbWQkG9yPX1B5Sc5/gjFTzO34
         nIdk6UXxJ2Y2L1Y7gxxaaMCvPxv9/NfhL8A4Rq6fAITWzFuIo4znbq6EFREzyM8bBYJ3
         K665J8wLRZYtQWm/3E2afhx+gJGg0+pvKU7hv6BIaq/ScKECYgaMKskQ4IkgSADph/g2
         cIE3xOFu1HkVTXrUqw6Rz+xfotGCtjn9UXMDoJuQXn5mXrdzEWRqrNp0rtd+dKFr9QQK
         2HkUbEmWY3SayH+VpjrYgCgbwhSTASpQJxFb371SQobWolM8f4V2I5d3QGirCnfWccC9
         4AmA==
X-Gm-Message-State: AOAM531Kwo/rl03LNTrfTOhU8QmltuBVHJWHMZeQsg4NF6XlXmKnqqit
        ynMXTS0g/9jNjgsKXA1lwnb5WLsCAei5H4ch2NhsFDs9
X-Google-Smtp-Source: ABdhPJy6jeik1QNjwZIRl0fu/oN70pld3AjcZtGtfXBKs01Qz4BvvrtKocCFuNv13tHpUTDgy6zPXHoRVGxE6lOIV6g=
X-Received: by 2002:a25:4c8:: with SMTP id 191mr6909174ybe.357.1639776559935;
 Fri, 17 Dec 2021 13:29:19 -0800 (PST)
MIME-Version: 1.0
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Fri, 17 Dec 2021 16:29:04 -0500
Message-ID: <CAFX2Jfn8jER-aV_ttiAe1tkh8f+m=5-whEBTWbHO1uVwf=B4bw@mail.gmail.com>
Subject: Re: [PATCH 00/18 V2] Repair SWAP-over-NFS
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil,

On Thu, Dec 16, 2021 at 7:07 PM NeilBrown <neilb@suse.de> wrote:
>
> swap-over-NFS currently has a variety of problems.
>
> swap writes call generic_write_checks(), which always fails on a swap
> file, so it completely fails.
> Even without this, various deadlocks are possible - largely due to
> improvements in NFS memory allocation (using NOFS instead of ATOMIC)
> which weren't tested against swap-out.
>
> NFS is the only filesystem that has supported fs-based swap IO, and it
> hasn't worked for several releases, so now is a convenient time to clean
> up the swap-via-filesystem interfaces - we cannot break anything !
>
> So the first few patches here clean up and improve various parts of the
> swap-via-filesystem code.  ->activate_swap() is given a cleaner
> interface, a new ->swap_rw is introduced instead of burdening
> ->direct_IO, etc.
>
> Current swap-to-filesystem code only ever submits single-page reads and
> writes.  These patches change that to allow multi-page IO when adjacent
> requests are submitted.  Writes are also changed to be async rather than
> sync.  This substantially speeds up write throughput for swap-over-NFS.
>
> Some of the NFS patches can land independently of the MM patches.  A few
> require the MM patches to land first.

Thanks for fixing swap-over-NFS! Looks like it passes all the
swap-related xfstests except for generic/357 on NFS v4.2. This test
checks that we get -EINVAL on a reflinked swapfile, but I'm not sure
if there is a way to check for that on the client side but if you have
any ideas it would be nice to get that test passing while you're at
it!

Anna

>
> Thanks,
> NeilBrown
>
>
> ---
>
> NeilBrown (18):
>       Structural cleanup for filesystem-based swap
>       MM: create new mm/swap.h header file.
>       MM: use ->swap_rw for reads from SWP_FS_OPS swap-space
>       MM: perform async writes to SWP_FS_OPS swap-space
>       MM: reclaim mustn't enter FS for SWP_FS_OPS swap-space
>       MM: submit multipage reads for SWP_FS_OPS swap-space
>       MM: submit multipage write for SWP_FS_OPS swap-space
>       MM: Add AS_CAN_DIO mapping flag
>       NFS: rename nfs_direct_IO and use as ->swap_rw
>       NFS: swap IO handling is slightly different for O_DIRECT IO
>       SUNRPC/call_alloc: async tasks mustn't block waiting for memory
>       SUNRPC/auth: async tasks mustn't block waiting for memory
>       SUNRPC/xprt: async tasks mustn't block waiting for memory
>       SUNRPC: remove scheduling boost for "SWAPPER" tasks.
>       NFS: discard NFS_RPC_SWAPFLAGS and RPC_TASK_ROOTCREDS
>       SUNRPC: improve 'swap' handling: scheduling and PF_MEMALLOC
>       NFSv4: keep state manager thread active if swap is enabled
>       NFS: swap-out must always use STABLE writes.
>
>
>  drivers/block/loop.c            |   4 +-
>  fs/fcntl.c                      |   5 +-
>  fs/inode.c                      |   3 +
>  fs/nfs/direct.c                 |  56 ++++++----
>  fs/nfs/file.c                   |  25 +++--
>  fs/nfs/inode.c                  |   1 +
>  fs/nfs/nfs4_fs.h                |   1 +
>  fs/nfs/nfs4proc.c               |  20 ++++
>  fs/nfs/nfs4state.c              |  39 ++++++-
>  fs/nfs/read.c                   |   4 -
>  fs/nfs/write.c                  |   2 +
>  fs/open.c                       |   2 +-
>  fs/overlayfs/file.c             |  10 +-
>  include/linux/fs.h              |   2 +-
>  include/linux/nfs_fs.h          |  11 +-
>  include/linux/nfs_xdr.h         |   2 +
>  include/linux/pagemap.h         |   3 +-
>  include/linux/sunrpc/auth.h     |   1 +
>  include/linux/sunrpc/sched.h    |   1 -
>  include/linux/swap.h            | 121 --------------------
>  include/linux/writeback.h       |   7 ++
>  include/trace/events/sunrpc.h   |   1 -
>  mm/madvise.c                    |   9 +-
>  mm/memory.c                     |   3 +-
>  mm/mincore.c                    |   1 +
>  mm/page_alloc.c                 |   1 +
>  mm/page_io.c                    | 189 ++++++++++++++++++++++++++------
>  mm/shmem.c                      |   1 +
>  mm/swap.h                       | 140 +++++++++++++++++++++++
>  mm/swap_state.c                 |  32 ++++--
>  mm/swapfile.c                   |   6 +
>  mm/util.c                       |   1 +
>  mm/vmscan.c                     |  31 +++++-
>  net/sunrpc/auth.c               |   8 +-
>  net/sunrpc/auth_gss/auth_gss.c  |   6 +-
>  net/sunrpc/auth_unix.c          |  10 +-
>  net/sunrpc/clnt.c               |   7 +-
>  net/sunrpc/sched.c              |  29 +++--
>  net/sunrpc/xprt.c               |  19 ++--
>  net/sunrpc/xprtrdma/transport.c |  10 +-
>  net/sunrpc/xprtsock.c           |   8 ++
>  41 files changed, 558 insertions(+), 274 deletions(-)
>  create mode 100644 mm/swap.h
>
> --
> Signature
>
