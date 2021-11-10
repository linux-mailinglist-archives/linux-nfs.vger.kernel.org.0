Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156F844CB6B
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Nov 2021 22:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhKJVxM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Nov 2021 16:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhKJVxM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Nov 2021 16:53:12 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA5C061766;
        Wed, 10 Nov 2021 13:50:24 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 88B4F1504; Wed, 10 Nov 2021 16:50:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 88B4F1504
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1636581022;
        bh=Qk/E2ziDB97yyEwhuGBRymygMWbo9oCDhI2CfuBu5qM=;
        h=Date:To:Cc:Subject:From:From;
        b=pJTTu5ii8x5h0R7gnge0b4xL/gz/sLt+29yIC3cxxK+HtP5s0JCx347NSbUHJsfT6
         UtkuGTZEaN6nvCwtF7jUMUEJHkElmehj0/Y8J+ARvc/gVNUQFrsV7ujgUICxoEP+ej
         hCyekQG8L/1qXsALzleqKTOyzlndQqfT8cWlo09k=
Date:   Wed, 10 Nov 2021 16:50:22 -0500
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [GIT PULL] nfsd changes for 5.16
Message-ID: <20211110215022.GA17888@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please pull:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.16

for 5.16 nfsd changes.

A slow cycle for nfsd: mainly cleanup, including Neil's patch dropping
support for a filehandle format deprecated 20 years ago, and further
xdr-related cleanup from Chuck.

--b.

Changcheng Deng (1):
      NFSD:fix boolreturn.cocci warning

Chuck Lever (15):
      NFSD: Optimize DRC bucket pruning
      SUNRPC: xdr_stream_subsegment() must handle non-zero page_bases
      NFSD: Have legacy NFSD WRITE decoders use xdr_stream_subsegment()
      svcrdma: Split the svcrdma_wc_receive() tracepoint
      svcrdma: Split the svcrdma_wc_send() tracepoint
      svcrdma: Split svcrmda_wc_{read,write} tracepoints
      SUNRPC: Add trace event when alloc_pages_bulk() makes no progress
      SUNRPC: Capture value of xdr_buf::page_base
      SUNRPC: Simplify the SVC dispatch code path
      SUNRPC: De-duplicate .pc_release() call sites
      SUNRPC: Replace the "__be32 *p" parameter to .pc_decode
      SUNRPC: Change return value type of .pc_decode
      NFSD: Save location of NFSv4 COMPOUND status
      SUNRPC: Replace the "__be32 *p" parameter to .pc_encode
      SUNRPC: Change return value type of .pc_encode

Colin Ian King (1):
      NFSD: Initialize pointer ni with NULL and not plain integer 0

J. Bruce Fields (5):
      nfsd: don't alloc under spinlock in rpc_parse_scope_id
      nfs: reexport documentation
      nfsd: update create verifier comment
      nfsd: document server-to-server-copy parameters
      nfsd4: remove obselete comment

NeilBrown (3):
      NFSD: move filehandle format declarations out of "uapi".
      NFSD: drop support for ancient filehandles
      NFSD: simplify struct nfsfh

Yang Li (1):
      UNRPC: Return specific error code on kmalloc failure

 Documentation/admin-guide/kernel-parameters.txt |  14 +
 Documentation/filesystems/nfs/index.rst         |   1 +
 Documentation/filesystems/nfs/reexport.rst      | 113 +++++++
 fs/lockd/svc.c                                  |   6 +-
 fs/lockd/xdr.c                                  | 152 +++++-----
 fs/lockd/xdr4.c                                 | 153 +++++-----
 fs/nfs/callback_xdr.c                           |   4 +-
 fs/nfsd/flexfilelayout.c                        |   2 +-
 fs/nfsd/lockd.c                                 |   2 +-
 fs/nfsd/nfs2acl.c                               |  44 +--
 fs/nfsd/nfs3acl.c                               |  48 +--
 fs/nfsd/nfs3proc.c                              |   3 +-
 fs/nfsd/nfs3xdr.c                               | 387 +++++++++++-------------
 fs/nfsd/nfs4callback.c                          |   2 +-
 fs/nfsd/nfs4proc.c                              |  11 +-
 fs/nfsd/nfs4state.c                             |   6 +-
 fs/nfsd/nfs4xdr.c                               |  52 ++--
 fs/nfsd/nfscache.c                              |  17 +-
 fs/nfsd/nfsctl.c                                |   6 +-
 fs/nfsd/nfsd.h                                  |   6 +-
 fs/nfsd/nfsfh.c                                 | 173 ++++-------
 fs/nfsd/nfsfh.h                                 |  55 +++-
 fs/nfsd/nfsproc.c                               |   3 +-
 fs/nfsd/nfssvc.c                                |  28 +-
 fs/nfsd/nfsxdr.c                                | 187 +++++-------
 fs/nfsd/vfs.c                                   |   7 +-
 fs/nfsd/xdr.h                                   |  37 +--
 fs/nfsd/xdr3.h                                  |  63 ++--
 fs/nfsd/xdr4.h                                  |   7 +-
 include/linux/lockd/xdr.h                       |  27 +-
 include/linux/lockd/xdr4.h                      |  29 +-
 include/linux/sunrpc/svc.h                      |  14 +-
 include/trace/events/rpcrdma.h                  | 185 ++++++++++-
 include/trace/events/sunrpc.h                   |  38 ++-
 include/uapi/linux/nfsd/nfsfh.h                 | 115 -------
 net/sunrpc/addr.c                               |  40 ++-
 net/sunrpc/auth_gss/svcauth_gss.c               |   2 +-
 net/sunrpc/svc.c                                |  80 +----
 net/sunrpc/svc_xprt.c                           |   1 +
 net/sunrpc/xdr.c                                |  32 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c         |   9 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c               |  30 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c           |  14 +-
 43 files changed, 1155 insertions(+), 1050 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/reexport.rst
 delete mode 100644 include/uapi/linux/nfsd/nfsfh.h
