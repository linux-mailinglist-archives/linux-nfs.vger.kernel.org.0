Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8392ABB42
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 14:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbgKIN03 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 08:26:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387470AbgKINQX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 08:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604927782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zq8ORpf5b367SGyFYJJFJlR91r7aoSyG9EF+t6agL2w=;
        b=AnCgMwNYxE42YvFFIIDk5nQnf/DYynYfO5EqJ4BbIiRQomiKkPwKa2ziR/234QIPtttP9k
        Gp2zT6lSBOiuj2yP/J+OYqA0gEE0wHBVvKay1+rkAQUH+7KMp42Cp5VPmFrEbYEDOU18Ju
        iDk+0MCqwad4nQJQKfE1C2PJqldXLB0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-O68-2ZN7Mjq1-U310Y0OvA-1; Mon, 09 Nov 2020 08:16:17 -0500
X-MC-Unique: O68-2ZN7Mjq1-U310Y0OvA-1
Received: by mail-ed1-f69.google.com with SMTP id t4so2689185edv.7
        for <linux-nfs@vger.kernel.org>; Mon, 09 Nov 2020 05:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zq8ORpf5b367SGyFYJJFJlR91r7aoSyG9EF+t6agL2w=;
        b=roGGT/RoXvjm56mfaqZr2n8nJrTLYQuAUNGMul+bVvG+9yEGxZzDMRiXAUd9yXGEnB
         +DeC0LVzcR5Ud3FtKsAVzZG0905FopbTGIG2UG56mlcj2ZsnhmtQjvVfcyTQlYh5AkZl
         dwsNmJq4X179PufEZDTL1jpGynvTAC2/sYgPWZgH5JRftuoXdiGSQcIerpNpPBDIrz+S
         NdHWc/prXpxeu+LQcEQP77Tz072KT4JiWAi/deIgTcgOBDpIJrzPOWoVd4Inu7VQ0gkI
         66qLMjdsJ9hV+F8UaAc1oYhgm4u48W2fRfh/T2irzmZ4XlDZwmbp5PZWjxmexG8dugjS
         q2ZA==
X-Gm-Message-State: AOAM533tLipW3xC/Q0qgbihaJp4pZpwHvQgGAsY5+TS0xTMC15z23voZ
        +muf/6yM+skoigkJQM5kqtwiECrXotZ73IoVAL9JDO8XrDFmExjMNpqnrS0BqAZVtIpYH9hc53A
        bvkbvc47bvsly2i1v1pcKHnhTyxBNxosKfRf4
X-Received: by 2002:a17:906:3547:: with SMTP id s7mr7052441eja.70.1604927775710;
        Mon, 09 Nov 2020 05:16:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwq3JJX4pcVhoGfC/D6Zf3VawNJDdmG/SNNWrLzGcjzdSKd7L5ikqLsPf7eWfxF3CHZI+d8MuTYno0fE4ZK75w=
X-Received: by 2002:a17:906:3547:: with SMTP id s7mr7052430eja.70.1604927775511;
 Mon, 09 Nov 2020 05:16:15 -0800 (PST)
MIME-Version: 1.0
References: <20201107140325.281678-1-trondmy@kernel.org>
In-Reply-To: <20201107140325.281678-1-trondmy@kernel.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 9 Nov 2020 08:15:39 -0500
Message-ID: <CALF+zOm7Y8ac7QstbdsmyopaKY4z9507Lff1mHAbQyACRZEX0w@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] Readdir enhancements
To:     trondmy@kernel.org
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 7, 2020 at 9:13 AM <trondmy@kernel.org> wrote:
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

Thanks for these last couple patches to handle changing directories /
uncached scenario better.  I'm testing with this set now and should
have results later today.

