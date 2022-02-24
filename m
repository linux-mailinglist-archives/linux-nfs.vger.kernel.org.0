Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804BB4C2BA8
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 13:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiBXM0f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 07:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiBXM0e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 07:26:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 266E316042C
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 04:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645705563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jG4+n6OpIU07qOGK7WklsoCEo711NW+OIh9FzbCo+m4=;
        b=C+LrnEixyMDMllHqdwLJ1BUng59FhQNGhFehD69RxnALJMKQFE5MFRD0Po7/xR70YjbHQ7
        Z/1FHWQsBmlFw8yPXBuwi3kkAKy3MSGcugjBJT5cdJfc10ArxE29jVyjPsUGpYkV3rX5YB
        ucgT4MT48XTt1Vue5mjIvBN4BrBkizs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-Sa7hWRq4PvuHjwiXCh0jmA-1; Thu, 24 Feb 2022 07:26:01 -0500
X-MC-Unique: Sa7hWRq4PvuHjwiXCh0jmA-1
Received: by mail-ej1-f71.google.com with SMTP id nb1-20020a1709071c8100b006d03c250b6fso1139625ejc.11
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 04:26:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jG4+n6OpIU07qOGK7WklsoCEo711NW+OIh9FzbCo+m4=;
        b=SJMpPyodJa1K+Wo+VIkBTc2dgYvCWNihQ8d0CDl4q8N3mhDZOj+ROlmR1ODbBXQzPa
         4yU36V2m6CnMWtSBf7tF3OyXubpnHGUfB32ka6tsleHhXb5gRkaPP3RITy+nS2v2yaAT
         14axpFRMbPB7RRN+0hniie5NbUz2wPkTGqcegjPUkDd9BusPBofqr+GVxKP0kwzt9gVf
         aIla77cl0QKqBLoZuSz5hS8KuRLpzKYQK66z6/Pk+XW/TuQh/DBszk0iK6MM41rwLgv6
         ZD3j0q6jHQWAfnbAzvOoPyK7ws7X0RkW5QwWAIkYc3G491uRXeADVdmGS+74QLZKK/TF
         lRAA==
X-Gm-Message-State: AOAM530Y5gWYrIn+e0nVC7ANhRL3bweKYOsASJH5hpFB8Zldbnovxx+o
        ZV62dFpkmgOuKYQB9AGkEVOFIyMRuIt8p53qwN6Co6aT477exVOu2cUOy4gEiRK7lxnUT/sfpBj
        AI8mkVcd6uUZlhVpHtbc0znyHrTmkEP6Ck7qY
X-Received: by 2002:a17:906:344b:b0:6ce:e64e:1b09 with SMTP id d11-20020a170906344b00b006cee64e1b09mr2072300ejb.54.1645705560394;
        Thu, 24 Feb 2022 04:26:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyB+vtZMPgLJhj+pFuFnn4auTFNXutoiZT8NBe9soGbdcNKg5KrwBaD9disL2AIwPPG6fiecsTcZkIgpTyrWiU=
X-Received: by 2002:a17:906:344b:b0:6ce:e64e:1b09 with SMTP id
 d11-20020a170906344b00b006cee64e1b09mr2072286ejb.54.1645705560171; Thu, 24
 Feb 2022 04:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20220223211305.296816-1-trondmy@kernel.org>
In-Reply-To: <20220223211305.296816-1-trondmy@kernel.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 24 Feb 2022 07:25:24 -0500
Message-ID: <CALF+zOnjJoy6mEZ9R0UwxDuSKRB5ODJmh=QnjkM+8wC_AJut6A@mail.gmail.com>
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

Trond I have been following your work here with periodic tests though
not fully following all the patches content.  As you know this is a tricky
area and seems to be a hotspot area for customers that use NFS, with
many scenarios that may go wrong.  Thanks for your work, which now
includes even some tracepoints and Ben's page cache filler.

This patchset seems to be the best of all the ones so far.  My initial
tests (listings when modifying as well as idle directories) indicate
that the issue that Gonzalo reported on Jan 14th [1] looks to be fixed
by this set, but I'll let him confirm.  I'll do some more testing and
let you know if there's anything else I find.  If there're some
scenarios (mount options, servers, etc) you need more testing on, let
us know and we'll try to make that happen.

[1] [PATCH] NFS: limit block size reported for directories

