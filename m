Return-Path: <linux-nfs+bounces-3800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A3D90828F
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 05:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB40528415D
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 03:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779C2262BE;
	Fri, 14 Jun 2024 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3+Ix5/t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5201BECC
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336668; cv=none; b=EGh1wGIXlV4ov1T2Zs9X3PAR8x3rhzgF2LxX95FVQILoEayrBZ2gwAFkE2KbV/k6xip1Pb+Gj6HQcbmw0xb+3wKL7mUkQPlSYOu1B9yV8FeZF0/uxsYqt2xgVxFcnrszb8RWekBJZena60nfEbGh6yhLZXgjXzSEZP1SZVYCDms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336668; c=relaxed/simple;
	bh=j60dvCHH0MqXwrW2eS6spaN1dX+ak8NtijTCVeFEZwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hXS6PQfZ7Y00pMiNh513TUbHV+9hYBKRcow+j/lAv6jP+9EVfGNbfM9AB0nD8pp5abUx4rZvaJr3dX66aJNUR9s+ul5nEoai6grl8vBHttoi1CONMDiH4THAVxZ4NJ85sq5dqYJXSJFc9PQVXKFUpce1Op7BPRHX21POGUN+y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3+Ix5/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A227EC2BBFC;
	Fri, 14 Jun 2024 03:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718336667;
	bh=j60dvCHH0MqXwrW2eS6spaN1dX+ak8NtijTCVeFEZwo=;
	h=From:To:Cc:Subject:Date:From;
	b=L3+Ix5/tUsCBLpcU5ZPhVy7AbC3paGaspTdJOKDV0lZyczf1rL/NKZ4RWYh+KepeH
	 GN9B8BCy82xqfF5oftojL0gpkPdVtPw5Cjq0yzucjoS61ICvJLYZ2FOOiISkq4Nsn1
	 PkGqJ/i64z55U8Zz0yQBt38VWstvz4uczLssz9ydZjngvn3fgdMGMYApStl9Y+OGX6
	 MXTomGhereGhI/JmKbJYkHiwDGKte1DLTuSrnJKXQcTq1wyCIT9wOBWfL8f3p5PnX/
	 8nJaYxzqL/5vRIK69yXAuh1STYgkyr01yD0HVhSwnHZ+EUbHuEog4+HXK1wzfMJc38
	 2ZHX5j6OpFOcw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v3 00/18] nfs/nfsd: add support for localio
Date: Thu, 13 Jun 2024 23:44:08 -0400
Message-ID: <20240614034426.31043-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I still need to add Documentation and also need to answer Neil's
questions about patch 7 ("NFS: for localio don't call filesystem
read() and write() routines directly").

Most of my time was spent addressing the need to take a proper
reference on the netns (patch 15) and nn->nfsd_serv (patches 16-18).

My git tree is here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/

This v3 is both branch nfs-localio-for-6.11 (always tracks latest)
and nfs-localio-for-6.11.v3

nfs-localio-for-6.11.v2 and nfs-localio-for-6.11.v1 are also there.

To see the changes from v2 to v3 please do:
git remote add snitzer git://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git
git remote update snitzer
git diff snitzer/nfs-localio-for-6.11.v2 snitzer/nfs-localio-for-6.11.v3

These changes have proven stable against various test scenarios:
1) client and server both on localhost (for both v3 and v4.2)
2) various permutations of client and server support enablement for
   both local and remote client and server.
3) client on host, server within a container (for both v3 and v4.2)
   My container testing was in terms of podman managed containers.
4) container stop/restart scenario documented in the last patch

All review and comments are welcome!

Thanks,
Mike

Mike Snitzer (10):
  nfs_common: add NFS LOCALIO protocol extension enablement
  nfs: implement v3 and v4 client support for NFS_LOCALIO_PROGRAM
  nfsd: implement v3 and v4 server support for NFS_LOCALIO_PROGRAM
  nfs/nfsd: consolidate {encode,decode}_opaque_fixed in nfs_xdr.h
  nfs/localio: move managing nfsd_open_local_fh symbol to nfs_common
  nfs/nfsd: ensure localio server always uses its network namespace
  nfsd/localio: manage netns reference in nfsd_open_local_fh
  nfsd: prepare to use SRCU to dereference nn->nfsd_serv
  nfsd: use SRCU to dereference nn->nfsd_serv
  nfsd/localio: use nfsd_serv_get/put in nfsd_open_local_fh

Trond Myklebust (3):
  NFS: for localio don't call filesystem read() and write() routines directly
  NFS: Enable localio for non-pNFS I/O
  pnfs/flexfiles: Enable localio for flexfiles I/O

Weston Andros Adamson (5):
  nfs: pass nfs_client to nfs_initiate_pgio
  nfs: pass descriptor thru nfs_initiate_pgio path
  nfs: pass struct file to nfs_init_pgio and nfs_init_commit
  sunrpc: add rpcauth_map_to_svc_cred_local
  nfs/nfsd: add "localio" support

 fs/Kconfig                                |   3 +
 fs/nfs/Kconfig                            |  30 +
 fs/nfs/Makefile                           |   1 +
 fs/nfs/blocklayout/blocklayout.c          |   6 +-
 fs/nfs/client.c                           |  15 +-
 fs/nfs/filelayout/filelayout.c            |  16 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    | 131 +++-
 fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
 fs/nfs/inode.c                            |  61 +-
 fs/nfs/internal.h                         |  94 ++-
 fs/nfs/localio.c                          | 850 ++++++++++++++++++++++
 fs/nfs/nfs3_fs.h                          |   1 +
 fs/nfs/nfs3client.c                       |  25 +
 fs/nfs/nfs3proc.c                         |   3 +
 fs/nfs/nfs3xdr.c                          |  58 ++
 fs/nfs/nfs4_fs.h                          |   2 +
 fs/nfs/nfs4client.c                       |  23 +
 fs/nfs/nfs4proc.c                         |   3 +
 fs/nfs/nfs4xdr.c                          |  65 +-
 fs/nfs/nfstrace.h                         |  61 ++
 fs/nfs/pagelist.c                         |  32 +-
 fs/nfs/pnfs.c                             |  24 +-
 fs/nfs/pnfs.h                             |   6 +-
 fs/nfs/pnfs_nfs.c                         |   2 +-
 fs/nfs/write.c                            |  13 +-
 fs/nfs_common/Makefile                    |   3 +
 fs/nfs_common/nfslocalio.c                |  71 ++
 fs/nfsd/Kconfig                           |  30 +
 fs/nfsd/Makefile                          |   1 +
 fs/nfsd/filecache.c                       |  15 +-
 fs/nfsd/localio.c                         | 398 ++++++++++
 fs/nfsd/netns.h                           |  16 +-
 fs/nfsd/nfs4state.c                       |  25 +-
 fs/nfsd/nfsctl.c                          |  28 +-
 fs/nfsd/nfsd.h                            |  11 +
 fs/nfsd/nfssvc.c                          | 176 ++++-
 fs/nfsd/trace.h                           |   3 +-
 fs/nfsd/vfs.h                             |   9 +
 fs/nfsd/xdr.h                             |   6 +
 include/linux/nfs.h                       |   2 +
 include/linux/nfs_fs.h                    |   2 +
 include/linux/nfs_fs_sb.h                 |   9 +
 include/linux/nfs_xdr.h                   |  31 +-
 include/linux/nfslocalio.h                |  39 +
 include/linux/sunrpc/auth.h               |   4 +
 include/uapi/linux/nfs.h                  |   4 +
 net/sunrpc/auth.c                         |  15 +
 48 files changed, 2289 insertions(+), 142 deletions(-)
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


