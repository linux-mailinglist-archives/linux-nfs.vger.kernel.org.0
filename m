Return-Path: <linux-nfs+bounces-14969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46177BB828C
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 23:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A643C31ED
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 21:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E90E22E3E9;
	Fri,  3 Oct 2025 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc4GwVzW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A26A228CBC
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525270; cv=none; b=YNDzfJ1sjLlIYd6SvieV/J5I6/dV2uPG561c2+bHZbwY2JmXV/a8lK0yzmTbw1q5L2yBOdSdDCywHcRku9jbXt+4cVNT93r84zmEQxgPiEFYG+y30eP79oA57zmrHycfXOjK3Bk7yXpcD5uoQaElUTYxOYBKMhesieSR22P2i2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525270; c=relaxed/simple;
	bh=bA4gkp0aEj3L7ntxRrtvdZ+BO3Uu/dLayDimue3dIzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtDKezjZGgn2y8urA8D3IyBdJQkBXLM78R9dHPGpkTQPbv3VxnDb3VpqAfrrpifXkSDRfr2I/McWLUcRLNnyyX7xX8n3+B772rsCw1kd27O/Tw5GnmqL4mDx0oUBnrWRkRI75oOWLAfoTy6F5M9fqlH+de/3qxFqrgVR/ihbVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc4GwVzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E26C4CEF5;
	Fri,  3 Oct 2025 21:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759525268;
	bh=bA4gkp0aEj3L7ntxRrtvdZ+BO3Uu/dLayDimue3dIzM=;
	h=From:To:Cc:Subject:Date:From;
	b=Dc4GwVzWkVMvEo4feu6+358QUUymLqmAspjEnkN3pLDQpXWiq8V30oUWAr9CO2ic7
	 9mPnMav4pQvEjCTYenJtIIuv96usIzEfYR5CdyaWxmmbvNmSAUSFMFFYnkCGuLXLaQ
	 wDa/BF5pMISxnesP+U6pQqtAao2MhcVVPihd4JO/gllrSwFPcmempxOgdbA3w7CYbx
	 wfMkHPsKqypDcYe13YdeRQHEYjnNhyJsQJULrb2N71LSNBDMpOXTWekceS/SBRmfze
	 WEwAX+k4tbfb413+Vk+gJofj8k1SGvuAGi9CbeFEtnnmtz+aYyR83ORmmPgi9yI71U
	 ZISfw20z4recg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [GIT PULL] <INSERT SUBJECT HERE>
Date: Fri,  3 Oct 2025 17:01:07 -0400
Message-ID: <20251003210107.683479-1-anna@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 07e27ad16399afcd693be20211b0dfae63e0615f:

  Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.18-1

for you to fetch changes up to 1f0d4ab0f5326ab6f940482b1941d2209d61285a:

  NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support (2025-09-30 16:10:30 -0400)

----------------------------------------------------------------
NFS Client Updates for Linux 6.18

New Features:
 * Add a Kconfig option to redirect dfprintk() to the trace buffer
 * Enable use of the RWF_DONTCACHE flag on the NFS client
 * Add striped layout handling to pNFS flexfiles
 * Add proper localio handling for READ and WRITE O_DIRECT

Bugfixes:
 * Handle NFS4ERR_GRACE errors during delegation recall
 * Fix NFSv4.1 backchannel max_resp_sz verification check
 * Fix mount hang after CREATE_SESSION failure
 * Fix d_parent->d_inode locking in nfs4_setup_readdir()

Other Cleanups and Improvements:
 * Improvements to write handling tracepoints
 * Fix a few trivial spelling mistakes
 * Cleanups to the rpcbind cleanup call sites
 * Convert the SUNRPC xdr_buf to use a scratch folio instead of scratch page
 * Remove unused NFS_WBACK_BUSY() macro
 * Remove __GFP_NOWARN flags
 * Unexport rpc_malloc() and rpc_free()


There is a conflict with the nfsd tree due to the localio changes. It should
be resolved through this fix:


diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 3edccc38db42e..e70bc699e9a51 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -697,6 +697,10 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
 		.dentry		= fhp->fh_dentry,
 	};
 	u32 request_mask = STATX_BASIC_STATS;
+	struct inode *inode = d_inode(p.dentry);
+
+	if (S_ISREG(inode->i_mode))
+		request_mask |= (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
 
 	if (fhp->fh_maxsize == NFS4_FHSIZE)
 		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);


Thanks,
Anna

----------------------------------------------------------------
Al Viro (1):
      nfs4_setup_readdir(): insufficient locking for ->d_parent->d_inode dereferencing

Anna Schumaker (9):
      SUNRPC: Introduce xdr_set_scratch_folio()
      NFS: Update readdir to use a scratch folio
      NFS: Update getacl to use xdr_set_scratch_folio()
      NFS: Update listxattr to use xdr_set_scratch_folio()
      NFS: Update the blocklayout to use xdr_set_scratch_folio()
      NFS: Update the filelayout to use xdr_set_scratch_folio()
      NFS: Update the flexfilelayout driver to use xdr_set_scratch_folio()
      SUNRPC: Update svcxdr_init_decode() to call xdr_set_scratch_folio()
      SUNRPC: Update gssx_accept_sec_context() to use xdr_set_scratch_folio()

Anthony Iliopoulos (2):
      NFSv4.1: fix backchannel max_resp_sz verification check
      NFSv4.1: fix mount hang after CREATE_SESSION failure

Chuck Lever (2):
      NFS: Remove rpcbind cleanup for NFSv4.0 callback
      SUNRPC: Move the svc_rpcb_cleanup() call sites

Jeff Layton (8):
      nfs: add tracepoints to nfs_file_read() and nfs_file_write()
      nfs: new tracepoints around write handling
      nfs: more in-depth tracing of writepage events
      nfs: add tracepoints to nfs_writepages()
      sunrpc: remove dfprintk_cont() and dfprintk_rcu_cont()
      sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer
      nfs: remove NFS_WBACK_BUSY()
      sunrpc: unexport rpc_malloc() and rpc_free()

Jonathan Curley (9):
      NFSv4/flexfiles: Remove cred local variable dependency
      NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
      NFSv4/flexfiles: Add data structure support for striped layouts
      NFSv4/flexfiles: Update low level helper functions to be DS stripe aware.
      NFSv4/flexfiles: Read path updates for striped layouts
      NFSv4/flexfiles: Commit path updates for striped layouts
      NFSv4/flexfiles: Write path updates for striped layouts
      NFSv4/flexfiles: Update layout stats & error paths for striped layouts
      NFSv4/flexfiles: Add support for striped layouts

Leo Martins (1):
      nfs: cleanup tracepoint declarations

Mike Snitzer (8):
      NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
      nfs/localio: make trace_nfs_local_open_fh more useful
      nfs/localio: avoid issuing misaligned IO using O_DIRECT
      nfs/localio: refactor iocb and iov_iter_bvec initialization
      nfs/localio: refactor iocb initialization
      nfs/localio: add proper O_DIRECT support for READ and WRITE
      nfs/localio: add tracepoints for misaligned DIO READ and WRITE support
      NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support

Olga Kornievskaia (1):
      NFSv4: handle ERR_GRACE on delegation recalls

Qianfeng Rong (1):
      SUNRPC: Remove redundant __GFP_NOWARN

Trond Myklebust (3):
      filemap: Add a helper for filesystems implementing dropbehind
      filemap: Add a version of folio_end_writeback that ignores dropbehind
      NFS: Enable use of the RWF_DONTCACHE flag on the NFS client

Xichao Zhao (1):
      NFSv4: fix "prefered"->"preferred"

 fs/lockd/svc.c                            |   6 +-
 fs/nfs/blocklayout/blocklayout.c          |   8 +-
 fs/nfs/blocklayout/dev.c                  |   8 +-
 fs/nfs/callback.c                         |  10 +-
 fs/nfs/dir.c                              |   8 +-
 fs/nfs/file.c                             |  29 +-
 fs/nfs/filelayout/filelayout.c            |  10 +-
 fs/nfs/filelayout/filelayoutdev.c         |  10 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    | 808 ++++++++++++++++++++----------
 fs/nfs/flexfilelayout/flexfilelayout.h    |  64 ++-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 115 +++--
 fs/nfs/inode.c                            |  15 +
 fs/nfs/internal.h                         |  10 +
 fs/nfs/localio.c                          | 405 +++++++++++----
 fs/nfs/nfs2xdr.c                          |   2 +-
 fs/nfs/nfs3xdr.c                          |   2 +-
 fs/nfs/nfs42proc.c                        |   4 +-
 fs/nfs/nfs42xdr.c                         |   2 +-
 fs/nfs/nfs4file.c                         |   1 +
 fs/nfs/nfs4proc.c                         |  12 +-
 fs/nfs/nfs4state.c                        |   3 +
 fs/nfs/nfs4xdr.c                          |   4 +-
 fs/nfs/nfstrace.h                         | 215 +++++++-
 fs/nfs/write.c                            |  34 +-
 fs/nfsd/filecache.c                       |  34 ++
 fs/nfsd/filecache.h                       |   4 +
 fs/nfsd/localio.c                         |  11 +
 fs/nfsd/nfsctl.c                          |   2 +-
 fs/nfsd/nfssvc.c                          |   7 +-
 fs/nfsd/trace.h                           |  27 +
 fs/nfsd/vfs.h                             |   4 +
 include/linux/nfs_page.h                  |   2 -
 include/linux/nfs_xdr.h                   |   4 +-
 include/linux/nfslocalio.h                |   2 +
 include/linux/pagemap.h                   |   2 +
 include/linux/sunrpc/debug.h              |  30 +-
 include/linux/sunrpc/svc.h                |   4 +-
 include/linux/sunrpc/svc_xprt.h           |   3 +-
 include/linux/sunrpc/xdr.h                |   8 +-
 include/trace/misc/fs.h                   |  22 +
 mm/filemap.c                              |  34 +-
 net/sunrpc/Kconfig                        |  14 +
 net/sunrpc/auth_gss/gss_rpc_xdr.c         |   8 +-
 net/sunrpc/sched.c                        |   2 -
 net/sunrpc/socklib.c                      |   2 +-
 net/sunrpc/svc.c                          |  11 +-
 net/sunrpc/svc_xprt.c                     |   7 +-
 net/sunrpc/xprtrdma/rpc_rdma.c            |   2 +-
 48 files changed, 1472 insertions(+), 559 deletions(-)

