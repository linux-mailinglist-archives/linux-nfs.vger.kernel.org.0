Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D96494210
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jan 2022 21:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiASUrW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jan 2022 15:47:22 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:36412 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiASUrW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jan 2022 15:47:22 -0500
Received: by mail-yb1-f182.google.com with SMTP id c6so11254635ybk.3
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jan 2022 12:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tebmDInaGItKeffwJUHRDietEP7W63b6sWkiIZ3v5Q0=;
        b=NqhFqSTYTT18tzXziZOggyQ9j69qungwklMdTFzXpnXPeoE8qRTCNYxowI/fwr40z8
         kcB33qv2RlwO2dGRatlEfFQqpvZWxyrWfV3lEQZvvNlzA7H/19U52JdDVWEgLUukImdK
         4NZL8+y3iF45ys0heZVuL2lGjvndYcVoE0kPjF5m2JT3SJCbOtpuDmYq5Z1JxhTbkJlQ
         I42Id9CAIsCgrT2XHBsnyzZYCEFq42kjsaBVzx4juxssXpv8lKZ2u0XanojsYJH9khAp
         5YukfuXfnDjvWozcN2P0zMG75/B+WtZbsvNeb4P9YIuc1n9VS2RVfG+IUhyeot8m6XVi
         IDbg==
X-Gm-Message-State: AOAM533mC3Ty6o2HdwcUqyEp1Cp9Ldgl3eP2E/U8LnuULIpjOa7WC+CR
        iQh3v3pjIllw7rYd17FKOCFWl2EOOpgUWEUIVCaauzrjq4Q=
X-Google-Smtp-Source: ABdhPJwdd6gpGN4CriEIAgV6rZQX27NBUmsgO5QINJLcCC8vKjIfulOb8wH4PMx28SVpLbWPfBoSxED7+wO60H5bgVA=
X-Received: by 2002:a25:1ec4:: with SMTP id e187mr40457365ybe.276.1642625241163;
 Wed, 19 Jan 2022 12:47:21 -0800 (PST)
MIME-Version: 1.0
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Wed, 19 Jan 2022 15:47:05 -0500
Message-ID: <CAFX2Jf=8s+rrwgGxm1FsaPUvEHygLFaUCNeFh989v4MXmLJFSg@mail.gmail.com>
Subject: [GIT PULL] Please pull NFS Client Updates for 5.17
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit c9e6606c7fe92b50a02ce51dda82586ebdf99b48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.17-1

for you to fetch changes up to aed28b7a2d620cb5cd0c554cb889075c02e25e8e:

  SUNRPC: Don't dereference xprt->snd_task if it's a cookie
(2022-01-14 10:37:00 -0500)

----------------------------------------------------------------
- New Features:
  - Basic handling for case insensitive filesystems
  - Initial support for fs_locations and server trunking

- Bugfixes and Cleanups:
  - Cleanups to how the "struct cred *" is handled for the nfs_access_entry
  - Ensure the server has an up to date ctimes before hardlinking or renaming
  - Update 'blocks used' after writeback, fallocate, and clone
  - nfs_atomic_open() fixes
  - Improvements to sunrpc tracing
  - Various null check & indenting related cleanups
  - Some improvements to the sunrpc sysfs code
    - Use default_groups in kobj_type
    - Fix some potential races and reference leaks
  - A few tracepoint cleanups in xprtrdma

I had to drop a few patches at the end of last week when some last
minute objections came in, but everything else should be ready.

Thanks,
Anna
----------------------------------------------------------------
Anna Schumaker (1):
      sunrpc: Fix potential race conditions in rpc_sysfs_xprt_state_change()

Chuck Lever (3):
      xprtrdma: Remove final dprintk call sites from xprtrdma
      xprtrdma: Remove definitions of RPCDBG_FACILITY
      SUNRPC: Don't dereference xprt->snd_task if it's a cookie

Greg Kroah-Hartman (2):
      NFS: use default_groups in kobj_type
      SUNRPC: use default_groups in kobj_type

Gustavo A. R. Silva (1):
      nfs41: pnfs: filelayout: Replace one-element array with
flexible-array member

Jiapeng Chong (1):
      SUNRPC: clean up some inconsistent indenting

NeilBrown (3):
      NFS: change nfs_access_get_cached to only report the mask
      NFS: pass cred explicitly for access tests
      NFS: don't store 'struct cred *' in struct nfs_access_entry

Olga Kornievskaia (8):
      NFSv4 only print the label when its queried
      NFSv4 remove zero number of fs_locations entries error check
      NFSv4 store server support for fs_location attribute
      NFSv4.1 query for fs_location attr on a new file system
      NFSv4 expose nfs_parse_server_name function
      NFSv4 handle port presence in fs_location server string
      SUNRPC allow for unspecified transport time in rpc_clnt_add_xprt
      NFSv4.1 test and add 4.1 trunking transport

Pierguido Lambri (1):
      SUNRPC: Add source address/port to rpc_socket* traces

Trond Myklebust (12):
      NFS: Ensure the server has an up to date ctime before hardlinking
      NFS: Ensure the server has an up to date ctime before renaming
      NFSv4.1: Fix uninitialised variable in devicenotify
      NFSv4: Add some support for case insensitive filesystems
      NFSv4: Just don't cache negative dentries on case insensitive servers
      NFS: Invalidate negative dentries on all case insensitive
directory changes
      NFS: Add a helper to remove case-insensitive aliases
      NFS: Fix the verifier for case sensitive filesystem in nfs_atomic_open()
      NFSv4: Allow writebacks to request 'blocks used'
      NFSv42: Fallocate and clone should also request 'blocks used'
      NFSv4: Handle case where the lookup of a directory fails
      NFSv4: nfs_atomic_open() can race when looking up a non-regular file

Xiaoke Wang (1):
      nfs: nfs4clinet: check the return value of kstrdup()

Xiyu Yang (1):
      net/sunrpc: fix reference count leaks in rpc_sysfs_xprt_state_change

Xu Wang (1):
      sunrpc: Remove unneeded null check

 fs/nfs/callback.h                       |   2 +-
 fs/nfs/callback_proc.c                  |   2 +-
 fs/nfs/callback_xdr.c                   |  22 +++++++++++-----------
 fs/nfs/client.c                         |   7 +++++++
 fs/nfs/dir.c                            | 146
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
 fs/nfs/filelayout/filelayout.h          |   2 +-
 fs/nfs/filelayout/filelayoutdev.c       |   4 +---
 fs/nfs/internal.h                       |   1 +
 fs/nfs/nfs3proc.c                       |   5 +++--
 fs/nfs/nfs42proc.c                      |  13 ++++++++-----
 fs/nfs/nfs4_fs.h                        |  14 +++++++++-----
 fs/nfs/nfs4client.c                     |   5 ++++-
 fs/nfs/nfs4namespace.c                  |  19 ++++++++++++-------
 fs/nfs/nfs4proc.c                       | 197
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------
 fs/nfs/nfs4state.c                      |   6 +++++-
 fs/nfs/nfs4xdr.c                        |  49
++++++++++++++++++++++++++++++++++++++++++++-----
 fs/nfs/sysfs.c                          |   3 ++-
 include/linux/nfs_fs.h                  |  10 ++++++----
 include/linux/nfs_fs_sb.h               |   4 +++-
 include/linux/nfs_xdr.h                 |   5 ++++-
 include/trace/events/sunrpc.h           |  70
+++++++++++++++++++++++++++++++++++++++++++++-------------------------
 net/sunrpc/auth_gss/gss_generic_token.c |   6 ++----
 net/sunrpc/clnt.c                       |   5 ++++-
 net/sunrpc/sysfs.c                      |  47
+++++++++++++++++++++++++++--------------------
 net/sunrpc/xprtrdma/backchannel.c       |   4 ----
 net/sunrpc/xprtrdma/frwr_ops.c          |   4 ----
 net/sunrpc/xprtrdma/rpc_rdma.c          |   4 ----
 net/sunrpc/xprtrdma/transport.c         |   4 ----
 net/sunrpc/xprtrdma/verbs.c             |  23 -----------------------
 net/sunrpc/xprtsock.c                   |   2 +-
 30 files changed, 476 insertions(+), 209 deletions(-)
