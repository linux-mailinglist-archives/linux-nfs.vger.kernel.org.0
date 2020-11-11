Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C622AFB31
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 23:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKKWQF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Nov 2020 17:16:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgKKWQC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Nov 2020 17:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605132960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6aNe1Ae8qpcfbkD6nKYxaBIO+QpbabBldM5maHx0Jw=;
        b=RT02KJaK2IPwdCjQbG7oz4ufPK/dcWQ7Msy9G1A6Zjbp4S4TLltEMHgWtOnxRSJda60v9k
        mwlk65w1oLRGY5/1awWW2Bg9ucC850SQ1AwC0efWFp2isjAIIM12/PKD2nKMYHlLuuuT60
        3hi1zCCT9xWUi3htskyUjNymwyh5zD8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-x3_tBMKhO3uTgYUSoeBTCA-1; Wed, 11 Nov 2020 17:15:58 -0500
X-MC-Unique: x3_tBMKhO3uTgYUSoeBTCA-1
Received: by mail-ej1-f72.google.com with SMTP id 27so1162041ejy.8
        for <linux-nfs@vger.kernel.org>; Wed, 11 Nov 2020 14:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6aNe1Ae8qpcfbkD6nKYxaBIO+QpbabBldM5maHx0Jw=;
        b=W4nEYD5YF3gNA2JDZeJT2KLdEkONfluipHrgkB/qgtHMqGoWsO3ZcW4K5vGGe9F+jd
         jx2wTMlUkJCMTL9mrzRWkXa04MZGZHQhOVoY4vlRqgnr/PbG2SMhE0DFZ/9XSxhTeCwO
         kzlw87EJ2DR+L5RYJjmzMkIE/73Os1siKrqgPL7J15zZLAx/HKDDh0pvxlW4Py1h7N9u
         SB/mV/xCm8nGGURd7l+OTf243leCttsCmrY2QrocaFAY6PyunBBLh5n8Y4jRI3MXZ8FH
         eOUPYb1p33uO7rluRMMzg1Am6QX0McdsSE8/5BAhan4nK5U8aXzPWdOloFA9VSejaQlf
         PwSA==
X-Gm-Message-State: AOAM531+5896BFURTj/hIAafkfIX4K3ZefMRF4/0oTnMaEGz5wfyG4DO
        +e8rj4/JoHiN/PMP6ivFqKf8vcpvVbgD9OIX5nl/uHhNBOIHdBCiQ3P6q2B+oLZW7bcnYhQ4Ccz
        JYkVIwOHt7usoVsLprE4acadfT++5wrelvCUd
X-Received: by 2002:a50:e705:: with SMTP id a5mr1844884edn.29.1605132956909;
        Wed, 11 Nov 2020 14:15:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwR8aPdx2ibCLm2kefHxUPraAxKY7thQRDwXxALwHrljf7ye0qDc7n474F37QQjkdQSkNEk7ocOj1V+sUqY62A=
X-Received: by 2002:a50:e705:: with SMTP id a5mr1844872edn.29.1605132956708;
 Wed, 11 Nov 2020 14:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20201110213741.860745-1-trondmy@kernel.org>
In-Reply-To: <20201110213741.860745-1-trondmy@kernel.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 11 Nov 2020 17:15:20 -0500
Message-ID: <CALF+zOkdXMDZ3TNGSNJQPtxy-ru_4iCYTz3U2uwkPAo3j55FZg@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] Readdir enhancements
To:     trondmy@kernel.org
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 10, 2020 at 4:48 PM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> The following patch series performs a number of cleanups on the readdir
> code.
> It also adds support for 1MB readdir RPC calls on-the-wire, and modifies
> the caching code to ensure that we cache the entire contents of that
> 1MB call (instead of discarding the data that doesn't fit into a single
> page).
> For filesystems that use ordered readdir cookie schemes (e.g. XFS), it
> optimises searching for cookies in the client's page cache by skipping
> over pages that contain cookie values that are not in the range we are
> searching for.
> Finally, it improves scalability when dealing with very large
> directories by turning off caching when those directories are changing,
> so as to avoid the need for a linear search on the client of the entire
> directory when looking for the first entry pointed to by the current
> file descriptor offset.
>
> v2: Fix the handling of the NFSv3/v4 directory verifier.
> v3: Optimise searching when the readdir cookies are seen to be ordered.
> v4: Optimise performance for large directories that are changing.
>     Add in llseek dependency patches.
> v5: Integrate Olga's patch for the READDIR security label handling.
>     Record more entries in the uncached readdir case. Bump the max
>     number of pages to 512, but allocate them on demand in case the
>     readdir RPC call returns fewer entries.
>
> Olga Kornievskaia (1):
>   NFSv4.2: condition READDIR's mask for security label based on LSM
>     state
>
> Trond Myklebust (21):
>   NFS: Remove unnecessary inode locking in nfs_llseek_dir()
>   NFS: Remove unnecessary inode lock in nfs_fsync_dir()
>   NFS: Ensure contents of struct nfs_open_dir_context are consistent
>   NFS: Clean up readdir struct nfs_cache_array
>   NFS: Clean up nfs_readdir_page_filler()
>   NFS: Clean up directory array handling
>   NFS: Don't discard readdir results
>   NFS: Remove unnecessary kmap in nfs_readdir_xdr_to_array()
>   NFS: Replace kmap() with kmap_atomic() in nfs_readdir_search_array()
>   NFS: Simplify struct nfs_cache_array_entry
>   NFS: Support larger readdir buffers
>   NFS: More readdir cleanups
>   NFS: nfs_do_filldir() does not return a value
>   NFS: Reduce readdir stack usage
>   NFS: Cleanup to remove nfs_readdir_descriptor_t typedef
>   NFS: Allow the NFS generic code to pass in a verifier to readdir
>   NFS: Handle NFS4ERR_NOT_SAME and NFSERR_BADCOOKIE from readdir calls
>   NFS: Improve handling of directory verifiers
>   NFS: Optimisations for monotonically increasing readdir cookies
>   NFS: Reduce number of RPC calls when doing uncached readdir
>   NFS: Do uncached readdir when we're seeking a cookie in an empty page
>     cache
>
>  fs/nfs/client.c         |   4 +-
>  fs/nfs/dir.c            | 734 +++++++++++++++++++++++++---------------
>  fs/nfs/inode.c          |   7 -
>  fs/nfs/internal.h       |   6 -
>  fs/nfs/nfs3proc.c       |  35 +-
>  fs/nfs/nfs4proc.c       |  48 +--
>  fs/nfs/proc.c           |  18 +-
>  include/linux/nfs_fs.h  |   9 +-
>  include/linux/nfs_xdr.h |  17 +-
>  9 files changed, 541 insertions(+), 337 deletions(-)
>
> --
> 2.28.0
>

I wrote a test script and ran this patchset against 5.10-rc2 in a
variety of scenarios listing 1 million files and various directory
modification scenarios. The test checked ops, runtime and cookie
resets (via tcpdump).

All runs performed very well on all scenarios I threw at it on all NFS
versions (I tested 3, 4.0, 4.1, and 4.2) with fairly dramatic
improvements vs the same runs on 5.10-rc2.   One scenario I found
where a single 'ls -l' could take a long time (about 5 minutes, but
not unbounded time) was when the directory was being modified with
both file adds and removed, but this seemed due to other ops unrelated
to readdir performance.   A second scenario that this patchset does
not fix is the scenario where the directory is large enough to exceed
the acdirmax, is being modified (adds and removes), and _multiple_
processes are listing it.  In this scenario a lister can still have
unbounded time, but the existing readdir code also has this problem
and fixing that probably requires another patch / approach (such as
reworking the structure of the cache or an approach such as the flag
on per-process dir context).

I think these patches make NFS readdir dramatically better, and they
fix a lot of underlying issues with the existing code, like the cookie
resets when pagecache is dropped, single page rx data problem, etc.
Thank you for doing these patches.

Tested-by: Dave Wysochanski

