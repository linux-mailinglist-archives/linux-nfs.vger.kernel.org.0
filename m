Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD6632014A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 23:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBSWUn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 17:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSWUm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 17:20:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3ABC061574
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 14:20:02 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id n1so12398492edv.2
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 14:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nbHA4iC4EUOT+QLsUXHkjW3bne4PQ5OWrJDYNh6xJ0E=;
        b=Lz4ZSF8+GkiGgYMdao6EbxoC0Xy2NeZQkT0bmQkbSB10k4QYHh8VEGmPmH3p0NdV+V
         Ac/t6KvnaLDjbYCRoDjSXuxbOGjhUnVb+dqzk1HrUJ1Kc6EiYUPvdIURGR5rCGM03OP9
         2XX9Ifa8VbyjyJDbQvd54UbhulSd1W/BB55UxZF1yo7nQHJLtlwLv3HXztzPp4DTHxqb
         k2S+detuGMs/JlPPJe1zhacZF79EoqlnT/nf05LT8MKK9eO6IVl1vsRionPStmLJm9YD
         asxjMNjtxJNGoKABBDMbGHyuuB46Z6LUwPqrx5hRRga0vY6ApZBWw1gK3KWsZ7dN2FJ6
         lsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nbHA4iC4EUOT+QLsUXHkjW3bne4PQ5OWrJDYNh6xJ0E=;
        b=m3LBzNVEo13lZxLQjhfO9jXS7+WcMVm3Q6hYxZ0wSYvqLURSbdoTMD7X1aCKJtJVeV
         yxNVM5c2IyLksOW2YiUxoJvFYv1vBhFDHxX43uaBCEnT3jSs+Rz+bOwCE+sd7vi2C5Rj
         aWBHdB9hRUq+sQXPxzoyJDJknjA0ORdSIc6EyPfKI7JKB12xXky7hPAeM6pflz+TKg5F
         uBAZFRzy/otTgnqEGqXOVgqVjO/7MJerUebqdJW9Y3xKYcibn7U+RHw1HRumK5v2LMFY
         yf0Q+DeYMRrEZmjppKty9mQC75C09HUkxy7Udu3oQwAlcVI97r+YwFqVjrA+rqMLh1w8
         mC5w==
X-Gm-Message-State: AOAM530cEWUYfdfRkvaE1X2EYMVXQ0dEFHc3gkquIzzGp39ctzb3DeLO
        85Odh0qdc0P11zS290SKLwFZCADynpBVC1bylAbaLAqKoZvHIA==
X-Google-Smtp-Source: ABdhPJwSgzBKdrW36xx2FDasEKG8Hm9xWqlJ3abkV1d04beRehm/hgsQVdAXlzTLVx3R5ejEmFnmS1rkZ2UhITd+Dt0=
X-Received: by 2002:a05:6402:26d5:: with SMTP id x21mr11446092edd.50.1613773201193;
 Fri, 19 Feb 2021 14:20:01 -0800 (PST)
MIME-Version: 1.0
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Fri, 19 Feb 2021 17:19:45 -0500
Message-ID: <CAFX2JfnuPuE7Bd5nAwgwrVQQ84vAMVwpPf0SFZFTwpX0rib+Hg@mail.gmail.com>
Subject: [GIT PULL] Please pull NFS Client Updates for Linux 5.12
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.12-1

for you to fetch changes up to 7ae017c7322e2b12472033e65a48aa25cde2fb22:

  NFS: Support the '-owrite=' option in /proc/self/mounts and
mountinfo (2021-02-17 15:36:03 -0500)

----------------------------------------------------------------
- New Features:
  - Support for eager writes, and the write=eager and write=wait mount options

- Other Bugfixes and Cleanups:
  - Fix typos in some comments
  - Fix up fall-through warnings for Clang
  - Cleanups to the NFS readpage codepath
  - Remove FMR support in rpcrdma_convert_iovs()
  - Various other cleanups to xprtrdma
  - Fix xprtrdma pad optimization for servers that don't support RFC 8797
  - Improvements to rpcrdma tracepoints
  - Fix up nfs4_bitmask_adjust()
  - Optimize sparse writes past the end of files

Thanks,
Anna
----------------------------------------------------------------
Bhaskar Chowdhury (1):
      net: sunrpc: xprtsock.c: Corrected few spellings ,in comments

Calum Mackay (1):
      SUNRPC: correct error code comment in xs_tcp_setup_socket()

Chuck Lever (7):
      xprtrdma: Remove FMR support in rpcrdma_convert_iovs()
      xprtrdma: Simplify rpcrdma_convert_kvec() and frwr_map()
      xprtrdma: Refactor invocations of offset_in_page()
      rpcrdma: Fix comments about reverse-direction operation
      xprtrdma: Pad optimization, revisited
      rpcrdma: Capture bytes received in Receive completion tracepoints
      xprtrdma: Clean up rpcrdma_prepare_readch()

Dave Wysochanski (5):
      NFS: Clean up nfs_readpage() and nfs_readpages()
      NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read succeeds
      NFS: Refactor nfs_readpage() and nfs_readpage_async() to use nfs_readdesc
      NFS: Call readpage_async_filler() from nfs_readpage_async()
      NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()

Gustavo A. R. Silva (2):
      SUNRPC: Fix fall-through warnings for Clang
      nfs: Fix fall-through warnings for Clang

Menglong Dong (1):
      fs/nfs: remove duplicate include

Trond Myklebust (10):
      NFSv4: Fixes for nfs4_bitmask_adjust()
      NFS: Fix documenting comment for nfs_revalidate_file_size()
      NFS: Optimise sparse writes past the end of file
      NFS: Always clear an invalid mapping when attempting a buffered write
      NFS: Don't set NFS_INO_INVALID_XATTR if there is no xattr cache
      NFS: 'flags' field should be unsigned in struct nfs_server
      NFS: Add support for eager writes
      NFS: Add mount options supporting eager writes
      NFS: Set the stable writes flag when initialising the super block
      NFS: Support the '-owrite=' option in /proc/self/mounts and mountinfo

 fs/nfs/file.c                              |  27 +++++++++++++++++++++------
 fs/nfs/fs_context.c                        |  35
+++++++++++++++++++++++++++++++++++
 fs/nfs/fscache.c                           |   4 ----
 fs/nfs/inode.c                             | 111
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
 fs/nfs/nfs3acl.c                           |   1 +
 fs/nfs/nfs4client.c                        |   1 +
 fs/nfs/nfs4proc.c                          |  21 ++++++++++-----------
 fs/nfs/nfs4state.c                         |   1 +
 fs/nfs/pnfs.c                              |   2 ++
 fs/nfs/read.c                              | 206
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------------------------------------------------------------------
 fs/nfs/super.c                             |   7 +++++++
 fs/nfs/write.c                             |  37
++++++++++++++++++++++++-------------
 include/linux/nfs_fs.h                     |   3 +--
 include/linux/nfs_fs_sb.h                  |   4 +++-
 include/trace/events/rpcrdma.h             |  50
++++++++++++++++++++++++++++++++++++++++++++++++--
 net/sunrpc/rpc_pipe.c                      |   1 +
 net/sunrpc/xprtrdma/backchannel.c          |   4 ++--
 net/sunrpc/xprtrdma/frwr_ops.c             |  12 +++---------
 net/sunrpc/xprtrdma/rpc_rdma.c             |  67
+++++++++++++++++++------------------------------------------------
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   4 ++--
 net/sunrpc/xprtrdma/xprt_rdma.h            |  15 ++++++++-------
 net/sunrpc/xprtsock.c                      |  17 ++++++++---------
 22 files changed, 357 insertions(+), 273 deletions(-)
