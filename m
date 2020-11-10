Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104CD2AE202
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 22:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgKJVrx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 16:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJVrw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 16:47:52 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C63D20781
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 21:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044872;
        bh=TYbmKTIID8R8kkCK4ckGWaU2mCRjRHbZX1QmVxkl7p4=;
        h=From:To:Subject:Date:From;
        b=U8w4fZ2M6qFhRfWJ4Bfl1AbjviZy/8nju6ZaRS/4T5A4Zv3YZJaUCYRgzrJrjWkbm
         vU/8v4gdFx7WyFUIOZUkN50eiUjhJmNKaB1yvcgRso7/NxxKM3gYhBNdsDrYS4xzYV
         TaGhNH/pmROyCxh6mghlFfD4XNimns7lBEHUdYNA=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 00/22] Readdir enhancements
Date:   Tue, 10 Nov 2020 16:37:19 -0500
Message-Id: <20201110213741.860745-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patch series performs a number of cleanups on the readdir
code.
It also adds support for 1MB readdir RPC calls on-the-wire, and modifies
the caching code to ensure that we cache the entire contents of that
1MB call (instead of discarding the data that doesn't fit into a single
page).
For filesystems that use ordered readdir cookie schemes (e.g. XFS), it
optimises searching for cookies in the client's page cache by skipping
over pages that contain cookie values that are not in the range we are
searching for.
Finally, it improves scalability when dealing with very large
directories by turning off caching when those directories are changing,
so as to avoid the need for a linear search on the client of the entire
directory when looking for the first entry pointed to by the current
file descriptor offset.

v2: Fix the handling of the NFSv3/v4 directory verifier.
v3: Optimise searching when the readdir cookies are seen to be ordered.
v4: Optimise performance for large directories that are changing.
    Add in llseek dependency patches.
v5: Integrate Olga's patch for the READDIR security label handling.
    Record more entries in the uncached readdir case. Bump the max
    number of pages to 512, but allocate them on demand in case the
    readdir RPC call returns fewer entries.

Olga Kornievskaia (1):
  NFSv4.2: condition READDIR's mask for security label based on LSM
    state

Trond Myklebust (21):
  NFS: Remove unnecessary inode locking in nfs_llseek_dir()
  NFS: Remove unnecessary inode lock in nfs_fsync_dir()
  NFS: Ensure contents of struct nfs_open_dir_context are consistent
  NFS: Clean up readdir struct nfs_cache_array
  NFS: Clean up nfs_readdir_page_filler()
  NFS: Clean up directory array handling
  NFS: Don't discard readdir results
  NFS: Remove unnecessary kmap in nfs_readdir_xdr_to_array()
  NFS: Replace kmap() with kmap_atomic() in nfs_readdir_search_array()
  NFS: Simplify struct nfs_cache_array_entry
  NFS: Support larger readdir buffers
  NFS: More readdir cleanups
  NFS: nfs_do_filldir() does not return a value
  NFS: Reduce readdir stack usage
  NFS: Cleanup to remove nfs_readdir_descriptor_t typedef
  NFS: Allow the NFS generic code to pass in a verifier to readdir
  NFS: Handle NFS4ERR_NOT_SAME and NFSERR_BADCOOKIE from readdir calls
  NFS: Improve handling of directory verifiers
  NFS: Optimisations for monotonically increasing readdir cookies
  NFS: Reduce number of RPC calls when doing uncached readdir
  NFS: Do uncached readdir when we're seeking a cookie in an empty page
    cache

 fs/nfs/client.c         |   4 +-
 fs/nfs/dir.c            | 734 +++++++++++++++++++++++++---------------
 fs/nfs/inode.c          |   7 -
 fs/nfs/internal.h       |   6 -
 fs/nfs/nfs3proc.c       |  35 +-
 fs/nfs/nfs4proc.c       |  48 +--
 fs/nfs/proc.c           |  18 +-
 include/linux/nfs_fs.h  |   9 +-
 include/linux/nfs_xdr.h |  17 +-
 9 files changed, 541 insertions(+), 337 deletions(-)

-- 
2.28.0

