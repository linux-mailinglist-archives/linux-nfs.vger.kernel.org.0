Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2ABE1458C5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 16:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAVP1w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 10:27:52 -0500
Received: from fieldses.org ([173.255.197.46]:38340 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgAVP1v (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 22 Jan 2020 10:27:51 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 8DC5C3EB; Wed, 22 Jan 2020 10:27:51 -0500 (EST)
Date:   Wed, 22 Jan 2020 10:27:51 -0500
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/9] Fix error reporting for NFS writes
Message-ID: <20200122152751.GD2654@fieldses.org>
References: <20200106184037.563557-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106184037.563557-1-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

By the way, anyone know how to handle quoted-printable patches?

For some reason, git-am seems to deal with them, but git-apply doesn't.
So it's fine until there's some minor conflict.

--b.

On Mon, Jan 06, 2020 at 01:40:28PM -0500, Trond Myklebust wrote:
> In cases where we have transient errors, such as ENOSPC, it is important
> to ensure that errors are reported on all writes that may be affected.
> 
> The problem we have is that not all errors are guaranteed to be reported
> at write time. Some are reported only when we call fsync(). In
> particular, this can be a problem for stable NFS writes. Since most
> filesystems protect the write to the page cache with the inode lock,
> but do not protect the subsequent call to generic_write_sync(), this
> means that if we have parallel writes to the same file, we can end up
> assigning the error to the wrong stable write call. If the application
> expects to be able to fix the transient errors, it may end up replaying
> the wrong write. One area where we have seen this happen is in flexfiles
> writes, where the server is capable of freeing up space on the DS in
> case of ENOSPC.
> 
> The other area where we have seen a similar problem is when we have
> unstable writes, and the client sends a backgrounded commit in order
> to free up memory. If there are outstanding writes while the commit
> gets a transient error and bumps the write verifier, then we want to
> ensure that those writes get the approprite write verifier depending
> on whether they were affected by the fsync() or not. Right now,
> because the NFSv3 verifier is set in the XDR encoder well after the
> write is done, there is fairly large window for a race with a
> background commit.
> 
> This patch series deals with both issues by adding per-file-descriptor
> locking that ensures that writes, fsync error handling, and write verifier
> updates are appropriately serialised.
> 
> Trond Myklebust (9):
>   nfsd: Allow nfsd_vfs_write() to take the nfsd_file as an argument
>   nfsd: Fix stable writes
>   nfsd: Update the boot verifier on stable writes too.
>   nfsd: Pass the nfsd_file as arguments to nfsd4_clone_file_range()
>   nfsd: Ensure exclusion between CLONE and WRITE errors
>   sunrpc: Fix potential leaks in sunrpc_cache_unhash()
>   sunrpc: clean up cache entry add/remove from hashtable
>   nfsd: Ensure sampling of the commit verifier is atomic with the commit
>   nfsd: Ensure sampling of the write verifier is atomic with the write
> 
>  fs/nfsd/filecache.c |  1 +
>  fs/nfsd/filecache.h |  1 +
>  fs/nfsd/nfs3proc.c  |  5 +--
>  fs/nfsd/nfs3xdr.c   | 16 +++------
>  fs/nfsd/nfs4proc.c  | 14 ++++----
>  fs/nfsd/nfsproc.c   |  2 +-
>  fs/nfsd/vfs.c       | 79 ++++++++++++++++++++++++++++++++++-----------
>  fs/nfsd/vfs.h       | 16 +++++----
>  fs/nfsd/xdr3.h      |  2 ++
>  net/sunrpc/cache.c  | 48 ++++++++++++++-------------
>  10 files changed, 115 insertions(+), 69 deletions(-)
> 
> -- 
> 2.24.1
