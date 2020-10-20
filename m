Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D918294291
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Oct 2020 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437881AbgJTS4O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Oct 2020 14:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437774AbgJTS4N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Oct 2020 14:56:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E483C0613CE;
        Tue, 20 Oct 2020 11:56:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t25so4257626ejd.13;
        Tue, 20 Oct 2020 11:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oaHYHo0DL85pJZuXVraOD4YFd1qfVqQ/EyXoOLxy32k=;
        b=o6jp6zbN7tWpfx3a+bboEkrdi49IGBP+yo/6MvaAQdVChUSVtRyRm2iAGFbmqh6mnh
         fA28pSqbgRqKedn0Xgtk5wIpt32FfEa+xZXIMuQE3rRzR3SSyldiGgOo+oSRZ4+rm8TZ
         zPb1wycAqs8gD4OH0jOPjfnqgkaMjEWdxLiCq4RjDCi/nBiCA9J1H+vLvikwnTQYhC9U
         s976kjelCM3nROdbdzd4TqmkKpyYpci3F9psXAnfKBc7c1EN5UcMjQRmiFY5V5Yl6kmu
         mgJ6G0uZGSevnJbEYMGvLqc7vra1KAAMOK3WG2Z4zo8iMvnStk4BIVE7zkgrA8m7C6nd
         fPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oaHYHo0DL85pJZuXVraOD4YFd1qfVqQ/EyXoOLxy32k=;
        b=Lt6ekaFW8cc1FQj6wiXnlQzYh3mk+Unh2+Ad0Sn8NVK6m6i8eJ+ghz/5pbpuJWIjOg
         Cf5si8v8NciJhso6/A9LNN+1WMT7qQ6frFG85HN3fgFeW0KcBD2xeX/AF0V86KtkJRRk
         poX0umdvcow7oN2KLbDHknoITK5qLNhQLowbAcYAzrsRuSoP3Lb4yBLOPldt9zbZk9pA
         GZlu+wLQ2RbgDv41hvrPuYeajojpNZka3rORlcCBqrXlkAC7hIOwUP03BEZR+ieX8QQq
         OfhlUcW9IAH0a3ooHXe4ROJQjORM/PjRy4DnLsFYRlBAGqexFP6COpRQcV4EzBTYK2hb
         DFJw==
X-Gm-Message-State: AOAM531R1sYzssMWWTldrN33h3VycAihvq1+/lIf4h2n8U8AxEVupKMf
        XVtk9UBKhsv2PmWlXA6RVsgduVbW2G/K9QLoICUBX0sM5S7xOg==
X-Google-Smtp-Source: ABdhPJw5YHVtlGzTmR1YlrXgeZWYkXjeDXxh2dMp1H7LKi3vCkTqLnjGrZ188PrR2hK+SNmpkHJpdXYCARyi03BqrO4=
X-Received: by 2002:a17:906:6d89:: with SMTP id h9mr4418743ejt.152.1603220168989;
 Tue, 20 Oct 2020 11:56:08 -0700 (PDT)
MIME-Version: 1.0
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 20 Oct 2020 14:55:52 -0400
Message-ID: <CAFX2JfnGTLccrN4x2FB_m8v+_gJNXCYFfQf=O50mfouiCd+Vsg@mail.gmail.com>
Subject: [GIT PULL] Please pull NFS Client Updates for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.10-1

for you to fetch changes up to 8c39076c276be0b31982e44654e2c2357473258a:

  NFSv4.2: support EXCHGID4_FLAG_SUPP_FENCE_OPS 4.2 EXCHANGE_ID flag
(2020-10-16 09:28:43 -0400)

----------------------------------------------------------------
- Stable Fixes:
  - Wait for stateid updates after CLOSE/OPEN_DOWNGRADE # v5.4+
  - Fix nfs_path in case of a rename retry
  - Support EXCHID4_FLAG_SUPP_FENCE_OPS v4.2 EXCHANGE_ID flag

- New features and improvements:
  - Replace dprintk() calls with tracepoints
  - Make cache consistency bitmap dynamic
  - Added support for the NFS v4.2 READ_PLUS operation
  - Improvements to net namespace uniquifier

- Other bugfixes and cleanups
  - Remove redundant clnt pointer
  - Don't update timeout values on connection resets
  - Remove redundant tracepoints
  - Various cleanups to comments
  - Fix oops when trying to use copy_file_range with v4.0 source server
  - Improvements to flexfiles mirrors
  - Add missing "local_lock=posix" mount option

As a side note, I updated my gpg key today while putting together the
tag. Hopefully everything just works for you!

Thanks,
Anna
----------------------------------------------------------------
Alexander A. Klimov (1):
      Replace HTTP links with HTTPS ones: NFS, SUNRPC, and LOCKD clients

Anna Schumaker (10):
      SUNRPC: Split out a function for setting current page
      SUNRPC: Implement a xdr_page_pos() function
      NFS: Use xdr_page_pos() in NFSv4 decode_getacl()
      NFS: Add READ_PLUS data segment support
      SUNRPC: Split out xdr_realign_pages() from xdr_align_pages()
      SUNRPC: Split out _shift_data_right_tail()
      SUNRPC: Add the ability to expand holes in data pages
      NFS: Add READ_PLUS hole segment decoding
      SUNRPC: Add an xdr_align_data() function
      NFS: Decode a full READ_PLUS reply

Ashish Sangwan (1):
      NFS: fix nfs_path in case of a rename retry

Benjamin Coddington (1):
      NFSv4: Wait for stateid updates after CLOSE/OPEN_DOWNGRADE

Chengguang Xu (1):
      nfs4: strengthen error check to avoid unexpected result

Chuck Lever (22):
      SUNRPC: Remove trace_xprt_complete_rqst()
      SUNRPC: Hoist trace_xprtrdma_op_allocate into generic code
      SUNRPC: Remove debugging instrumentation from xprt_release
      SUNRPC: Update debugging instrumentation in xprt_do_reserve()
      SUNRPC: Replace dprintk() call site in xprt_prepare_transmit
      SUNRPC: Replace dprintk() call site in xs_nospace()
      SUNRPC: Remove the dprint_status() macro
      SUNRPC: Remove dprintk call site in call_start()
      SUNRPC: Replace connect dprintk call sites with a tracepoint
      SUNRPC: Mitigate cond_resched() in xprt_transmit()
      SUNRPC: Add trace_rpc_timeout_status()
      SUNRPC: Trace call_refresh events
      SUNRPC: Remove dprintk call site in call_decode
      SUNRPC: Clean up call_bind_status() observability
      SUNRPC: Remove rpcb_getport_async dprintk call sites
      SUNRPC: Hoist trace_xprtrdma_op_setport into generic code
      SUNRPC: Remove dprintk call sites in rpcbind XDR functions
      SUNRPC: Remove more dprintks in rpcb_clnt.c
      SUNRPC: Replace rpcbind dprintk call sites with tracepoints
      SUNRPC: Clean up RPC scheduler tracepoints
      SUNRPC: Remove dprintk call sites in RPC queuing functions
      SUNRPC: Remove remaining dprintks from sched.c

Colin Ian King (1):
      NFS: remove redundant pointer clnt

Dave Wysochanski (1):
      NFS4: Fix oops when copy_file_range is attempted with NFS4.0 source

Frank van der Linden (1):
      NFSv4.2: xattr cache: remove unused cache struct field

Julia Lawall (1):
      xprtrdma: drop double zeroing

Miaohe Lin (1):
      nfs: Convert to use the preferred fallthrough macro

Nick Desaulniers (1):
      nfs: remove incorrect fallthrough label

Olga Kornievskaia (3):
      SUNRPC dont update timeout value on connection reset
      NFSv4: make cache consistency bitmask dynamic
      NFSv4.2: support EXCHGID4_FLAG_SUPP_FENCE_OPS 4.2 EXCHANGE_ID flag

Randy Dunlap (1):
      sunrpc: fix duplicated word in <linux/sunrpc/cache.h>

Sargun Dhillon (1):
      NFS: Only reference user namespace from nfs4idmap struct instead of cred

Scott Mayhew (1):
      nfs: add missing "posix" local_lock constant table definition

Trond Myklebust (5):
      pNFS/flexfiles: Ensure we initialise the mirror bsizes correctly on read
      pNFS/flexfiles: Be consistent about mirror index types
      NFSv4: Clean up initialisation of uniquified client id strings
      NFSv4: Use the net namespace uniquifier if it is set
      NFSv4: Fix up RCU annotations for struct nfs_netns_client

Wang Qing (1):
      nfs: fix spellint typo in pnfs.c

Yang Shi (1):
      fs: nfs: return per memcg count for xattr shrinkers

 fs/lockd/mon.c                         |   2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c |  43 ++++++-------
 fs/nfs/fs_context.c                    |   1 +
 fs/nfs/namespace.c                     |  12 ++--
 fs/nfs/nfs42xattr.c                    |   5 +-
 fs/nfs/nfs42xdr.c                      | 167
+++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4_fs.h                       |   8 +++
 fs/nfs/nfs4client.c                    |   2 +
 fs/nfs/nfs4file.c                      |   3 +-
 fs/nfs/nfs4idmap.c                     |  15 ++---
 fs/nfs/nfs4proc.c                      | 272
++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 fs/nfs/nfs4trace.h                     |   1 +
 fs/nfs/nfs4xdr.c                       |   7 +--
 fs/nfs/pnfs.c                          |   2 +-
 fs/nfs/super.c                         |   2 +-
 fs/nfs/sysfs.c                         |  11 +++-
 fs/nfs/sysfs.h                         |   2 +-
 include/linux/nfs4.h                   |   2 +-
 include/linux/nfs_fs_sb.h              |   1 +
 include/linux/nfs_xdr.h                |  12 ++--
 include/linux/sunrpc/bc_xprt.h         |   2 +-
 include/linux/sunrpc/cache.h           |   3 +-
 include/linux/sunrpc/msg_prot.h        |   2 +-
 include/linux/sunrpc/xdr.h             |   3 +
 include/trace/events/rpcrdma.h         |  63 --------------------
 include/trace/events/sunrpc.h          | 286
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 include/uapi/linux/nfs4.h              |   3 +
 net/sunrpc/backchannel_rqst.c          |   2 +-
 net/sunrpc/clnt.c                      |  78 +++++-------------------
 net/sunrpc/rpcb_clnt.c                 | 131
++++++++--------------------------------
 net/sunrpc/sched.c                     |  52 ++--------------
 net/sunrpc/sunrpc.h                    |   2 +-
 net/sunrpc/xdr.c                       | 305
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 net/sunrpc/xprt.c                      |  24 +++-----
 net/sunrpc/xprtrdma/frwr_ops.c         |   2 +-
 net/sunrpc/xprtrdma/transport.c        |   7 ---
 net/sunrpc/xprtsock.c                  |   5 +-
 37 files changed, 1014 insertions(+), 526 deletions(-)
