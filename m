Return-Path: <linux-nfs+bounces-6259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9D796E2C5
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B348287308
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C332D18BC31;
	Thu,  5 Sep 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGwv2eVL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F975158DC8
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563413; cv=none; b=p2JWpGkFj/f+KCFD4ICVvUssmqMF8b4GpWvbCh1KvxEu4ExpDtqvtxq5KG7b30is49AC4yT1HpDwAGfUcD0rL5c//WhJ/5lvPO1MZ3Do4hFUoX/wT+k1jDDWXxFmUCtHGFAp0bKu8k70Ym31d+4OCPmGjasGvBG1mfs4fkl1DRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563413; c=relaxed/simple;
	bh=e6QQgInlWJ3IMMqy/mPD2ZKdbHs3YnGwwD1ByaKWhIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mo4L4vwT+kZFOhW1tuiuKia2CKao8E7k3wUgT933JTG8zeEXjaTIJOCOok3f/J7a6UJTo2yZL/+JhI3pHNdtT5A7Jz/7ULuHkPLFQtplKCB869yCrSjYqXfwi0ayxrCEfkiX5t8kLgxV5oeCp4ePZ0jccKJLvTMNJCqvGWl0bqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGwv2eVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF30C4CEC3;
	Thu,  5 Sep 2024 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563413;
	bh=e6QQgInlWJ3IMMqy/mPD2ZKdbHs3YnGwwD1ByaKWhIM=;
	h=From:To:Cc:Subject:Date:From;
	b=hGwv2eVLE8nTNK92VGHvEa8kQJvalAB+SsBnKNM+20fVOY3BbGCbs0BqdCjavWpcu
	 vTBFguH6z5UftUJ4tAOQe3+WfqnqJ/3eQxI1S4dRGoK3fEHFpzJ3Qs2Cfnn4khTZhy
	 hP0f6KTLH5IfwyxsCxVA3TGBdMsyfJ8wbuCq7QtM/nHNmDQSt5LEx2E62Y1TFwtCDD
	 hdzXMh4/fijV+zoS1nz1dbuaRTXRUJegmJ0LCiDX1HpbcE5LOEmKVJThl8yCGVhH3n
	 jXxbTxbB7OqR4akCCk7/gEibot+IUtomXN3i1fz/mj5l16cCvqJhGpA/V4Ho3p19p2
	 /OhykXko8SrQA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 00/26] nfs/nfsd: add support for LOCALIO
Date: Thu,  5 Sep 2024 15:09:34 -0400
Message-ID: <20240905191011.41650-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

These latest changes are available in my git tree here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next

The NFSD changes have all settled with this v16.  This is the natural
pivot point for NFS client review to be completed (my understanding
from Trond is that Anna will be taking a close look).

Changes since v15, which are reflected in the top 3 commits on this
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next.v15-with-fixups

- Fixes to nfs_to to follow normal operations table pattern
  Switch 'nfs_to' to a proper pointer that just needs a simple
  assignment rather than memcpy() to initialize.  Updated all 'nfs_to'
  callers accordingly.  Removed the associated 'nfs_to_<nfsd_func>_t'
  function pointer typedefs that really weren't helpful.

- Removed EXPORT_SYMBOL_GPL for nfsd_serv_put, nfsd_file_put_local
  and nfsd_file_file (these symbols are only used directly in nfsd, but
  they are exposed to nfs via 'nfs_to' operations table).

- A few sparse fixes dealing primarily with rcu usage.

- nfs_common: push nfsd_open_local_fh rcu requirements to caller.
  Now nfs_open_local_fh safely gets reference to nfsd_serv and then
  drops rcu before its call to nfs_to->nfsd_open_local_fh.  If that
  call fails then nfs_to->nfsd_serv_put is needed.  This cleans up the
  awkward rcu bouncing that was in nfsd_open_local_fh but introduces
  the need for both nfs_to->nfsd_serv_try_get and nfs_to->nfsd_serv_put.

All review appreciated, thanks!
Mike

Chuck Lever (2):
  NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
  NFSD: Short-circuit fh_verify tracepoints for LOCALIO

Mike Snitzer (12):
  nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
  nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
  nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
  nfsd: add nfsd_serv_try_get and nfsd_serv_put
  SUNRPC: remove call_allocate() BUG_ONs
  nfs_common: add NFS LOCALIO auxiliary protocol enablement
  nfs_common: prepare for the NFS client to use nfsd_file for LOCALIO
  nfsd: implement server support for NFS_LOCALIO_PROGRAM
  nfs: pass struct nfsd_file to nfs_init_pgio and nfs_init_commit
  nfs: implement client support for NFS_LOCALIO_PROGRAM
  nfs: add Documentation/filesystems/nfs/localio.rst
  nfs: add "NFS Client and Server Interlock" section to localio.rst

NeilBrown (5):
  NFSD: Handle @rqstp == NULL in check_nfsd_access()
  NFSD: Refactor nfsd_setuser_and_check_port()
  nfsd: factor out __fh_verify to allow NULL rqstp to be passed
  nfsd: add nfsd_file_acquire_local()
  SUNRPC: replace program list with program array

Trond Myklebust (4):
  nfs: enable localio for non-pNFS IO
  pnfs/flexfiles: enable localio support
  nfs/localio: use dedicated workqueues for filesystem read and write
  nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst

Weston Andros Adamson (3):
  SUNRPC: add svcauth_map_clnt_to_svc_cred_local
  nfsd: add LOCALIO support
  nfs: add LOCALIO support

 Documentation/filesystems/nfs/localio.rst | 357 ++++++++++
 fs/Kconfig                                |  23 +
 fs/nfs/Kconfig                            |   1 +
 fs/nfs/Makefile                           |   1 +
 fs/nfs/client.c                           |  15 +-
 fs/nfs/filelayout/filelayout.c            |   6 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    |  56 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
 fs/nfs/inode.c                            |  57 +-
 fs/nfs/internal.h                         |  53 +-
 fs/nfs/localio.c                          | 757 ++++++++++++++++++++++
 fs/nfs/nfs2xdr.c                          |  70 +-
 fs/nfs/nfs3xdr.c                          | 108 +--
 fs/nfs/nfs4xdr.c                          |  84 +--
 fs/nfs/nfstrace.h                         |  61 ++
 fs/nfs/pagelist.c                         |  16 +-
 fs/nfs/pnfs_nfs.c                         |   2 +-
 fs/nfs/write.c                            |  12 +-
 fs/nfs_common/Makefile                    |   5 +
 fs/nfs_common/common.c                    | 134 ++++
 fs/nfs_common/nfslocalio.c                | 172 +++++
 fs/nfsd/Kconfig                           |   1 +
 fs/nfsd/Makefile                          |   1 +
 fs/nfsd/export.c                          |  30 +-
 fs/nfsd/filecache.c                       | 101 ++-
 fs/nfsd/filecache.h                       |   5 +
 fs/nfsd/localio.c                         | 169 +++++
 fs/nfsd/netns.h                           |  12 +-
 fs/nfsd/nfsctl.c                          |  27 +-
 fs/nfsd/nfsd.h                            |   6 +-
 fs/nfsd/nfsfh.c                           | 137 ++--
 fs/nfsd/nfsfh.h                           |   2 +
 fs/nfsd/nfssvc.c                          | 105 ++-
 fs/nfsd/trace.h                           |  21 +-
 fs/nfsd/vfs.h                             |   2 +
 include/linux/nfs.h                       |   9 +
 include/linux/nfs_common.h                |  17 +
 include/linux/nfs_fs_sb.h                 |   9 +
 include/linux/nfs_xdr.h                   |  20 +-
 include/linux/nfslocalio.h                |  74 +++
 include/linux/sunrpc/svc.h                |   7 +-
 include/linux/sunrpc/svcauth.h            |   5 +
 net/sunrpc/clnt.c                         |   6 -
 net/sunrpc/svc.c                          |  68 +-
 net/sunrpc/svc_xprt.c                     |   2 +-
 net/sunrpc/svcauth.c                      |  28 +
 net/sunrpc/svcauth_unix.c                 |   3 +-
 47 files changed, 2454 insertions(+), 409 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/localio.rst
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/common.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfs_common.h
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


