Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130AB1F6BB3
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2020 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgFKP5p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jun 2020 11:57:45 -0400
Received: from fieldses.org ([173.255.197.46]:39928 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgFKP5o (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 11 Jun 2020 11:57:44 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 51AFD878E; Thu, 11 Jun 2020 11:57:43 -0400 (EDT)
Date:   Thu, 11 Jun 2020 11:57:43 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: [GIT PULL] nfsd changes for 5.8
Message-ID: <20200611155743.GC16376@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please pull nfsd changes for 5.8 from:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.8

Highlights:

- Keep nfsd clients from unnecessarily breaking their own delegations:
  Note this requires a small kthreadd addition, discussed at:
  https://lore.kernel.org/r/1588348912-24781-1-git-send-email-bfields@redhat.com
  The result is Tejun Heo's suggestion, and he was OK with this going
  through my tree.
- Patch nfsd/clients/ to display filenames, and to fix byte-order when
  displaying stateid's.
- fix a module loading/unloading bug, from Neil Brown.
- A big series from Chuck Lever with RPC/RDMA and tracing improvements,
  and lay some groundwork for RPC-over-TLS.

Note Stephen Rothwell spotted two conflicts in linux-next.  Both should
be straightforward:
	include/trace/events/sunrpc.h
		https://lore.kernel.org/r/20200529105917.50dfc40f@canb.auug.org.au
	net/sunrpc/svcsock.c
		https://lore.kernel.org/r/20200529131955.26c421db@canb.auug.org.au

----------------------------------------------------------------
Achilles Gaikwad (1):
      nfsd4: add filename to states output

Chen Zhou (1):
      sunrpc: use kmemdup_nul() in gssp_stringify()

Chuck Lever (32):
      SUNRPC: Move xpt_mutex into socket xpo_sendto methods
      svcrdma: Clean up the tracing for rw_ctx_init errors
      svcrdma: Clean up handling of get_rw_ctx errors
      svcrdma: Trace page overruns when constructing RDMA Reads
      svcrdma: trace undersized Write chunks
      svcrdma: Fix backchannel return code
      svcrdma: Remove backchannel dprintk call sites
      svcrdma: Rename tracepoints that record header decoding errors
      svcrdma: Remove the SVCRDMA_DEBUG macro
      svcrdma: Displayed remote IP address should match stored address
      svcrdma: Add tracepoints to report ->xpo_accept failures
      SUNRPC: Remove kernel memory address from svc_xprt tracepoints
      SUNRPC: Tracepoint to record errors in svc_xpo_create()
      SUNRPC: Trace a few more generic svc_xprt events
      SUNRPC: Remove "#include <trace/events/skb.h>"
      SUNRPC: Add more svcsock tracepoints
      SUNRPC: Replace dprintk call sites in TCP state change callouts
      SUNRPC: Trace server-side rpcbind registration events
      SUNRPC: Rename svc_sock::sk_reclen
      SUNRPC: Restructure svc_tcp_recv_record()
      SUNRPC: Replace dprintk() call sites in TCP receive path
      SUNRPC: Refactor recvfrom path dealing with incomplete TCP receives
      SUNRPC: Clean up svc_release_skb() functions
      SUNRPC: Refactor svc_recvfrom()
      SUNRPC: Restructure svc_udp_recvfrom()
      SUNRPC: svc_show_status() macro should have enum definitions
      NFSD: Add tracepoints to NFSD's duplicate reply cache
      NFSD: Add tracepoints to the NFSD state management code
      NFSD: Add tracepoints for monitoring NFSD callbacks
      SUNRPC: Clean up request deferral tracepoints
      NFSD: Squash an annoying compiler warning
      NFSD: Fix improperly-formatted Doxygen comments

J. Bruce Fields (8):
      nfsd4: common stateid-printing code
      nfsd4: stid display should preserve on-the-wire byte order
      nfsd: handle repeated BIND_CONN_TO_SESSION
      kthread: save thread function
      nfsd: clients don't need to break their own delegations
      Merge branch 'nfsd-5.8' of git://linux-nfs.org/~cel/cel-2.6 into for-5.8-incoming
      nfsd4: make drc_slab global, not per-net
      nfsd: safer handling of corrupted c_type

Ma Feng (1):
      nfsd: Fix old-style function definition

NeilBrown (3):
      sunrpc: check that domain table is empty at module unload.
      sunrpc: svcauth_gss_register_pseudoflavor must reject duplicate registrations.
      sunrpc: clean up properly in gss_mech_unregister()

Xiongfeng Wang (1):
      sunrpc: add missing newline when printing parameter 'pool_mode' by sysfs

Xiyu Yang (2):
      nfsd: Fix svc_xprt refcnt leak when setup callback client failed
      SUNRPC: Remove unreachable error condition in rpcb_getport_async()

YueHaibing (1):
      sunrpc: Remove unused function ip_map_update

 Documentation/filesystems/locking.rst      |   2 +
 fs/locks.c                                 |   3 +
 fs/nfsd/cache.h                            |   2 +
 fs/nfsd/netns.h                            |   1 -
 fs/nfsd/nfs4callback.c                     |  39 +--
 fs/nfsd/nfs4proc.c                         |   9 +-
 fs/nfsd/nfs4state.c                        | 166 ++++++++----
 fs/nfsd/nfscache.c                         |  89 +++---
 fs/nfsd/nfsctl.c                           |  32 ++-
 fs/nfsd/nfsd.h                             |   2 +
 fs/nfsd/nfssvc.c                           |   6 +
 fs/nfsd/state.h                            |   7 -
 fs/nfsd/trace.h                            | 345 ++++++++++++++++++++++++
 include/linux/fs.h                         |   1 +
 include/linux/kthread.h                    |   1 +
 include/linux/sunrpc/gss_api.h             |   1 +
 include/linux/sunrpc/svc.h                 |   2 +
 include/linux/sunrpc/svc_rdma.h            |   6 +-
 include/linux/sunrpc/svc_xprt.h            |   6 +
 include/linux/sunrpc/svcauth_gss.h         |   3 +-
 include/linux/sunrpc/svcsock.h             |   6 +-
 include/trace/events/rpcrdma.h             | 142 ++++++++--
 include/trace/events/sunrpc.h              | 419 +++++++++++++++++++++++++++--
 kernel/kthread.c                           |  17 ++
 net/sunrpc/auth_gss/gss_mech_switch.c      |  12 +-
 net/sunrpc/auth_gss/gss_rpc_upcall.c       |   2 +-
 net/sunrpc/auth_gss/svcauth_gss.c          |  18 +-
 net/sunrpc/rpcb_clnt.c                     |   6 -
 net/sunrpc/sunrpc.h                        |   1 +
 net/sunrpc/sunrpc_syms.c                   |   2 +
 net/sunrpc/svc.c                           |  29 +-
 net/sunrpc/svc_xprt.c                      |  53 ++--
 net/sunrpc/svcauth.c                       |  25 ++
 net/sunrpc/svcauth_unix.c                  |   9 -
 net/sunrpc/svcsock.c                       | 407 ++++++++++++++--------------
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 121 +++------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |  21 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |  92 ++++---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |  10 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  55 ++--
 net/sunrpc/xprtsock.c                      |  12 +-
 41 files changed, 1527 insertions(+), 655 deletions(-)
