Return-Path: <linux-nfs+bounces-3656-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BE3904952
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232511F21F81
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 03:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43A617BB9;
	Wed, 12 Jun 2024 03:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWCcugnu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03FA1799B
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 03:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161674; cv=none; b=fO4Q01dY9cjiEdQpbxtEgDGMkkP5Ot9ONeuG0Hq0pU20LttqTCiRRIs7N0VctniY0uVDscbRKwVlJXRIUXfkx3q96dxLY7oL3hq+UgyDf4iB0Rk8V9zmYY7SAS3JQvNnrrlBuCQLBgBks3psktmWm7JsmYEr3/U4hsKkdweKm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161674; c=relaxed/simple;
	bh=jXhnViIe7fzMZvQsFuF6K9Ax83b2+vjS+Tc2uXM0Fx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/f1sd6Xb4fXaPE91VumeSmWaihXsCNJdObvcwJu7/gdIeMo1x80RjchImQbxv4kKs08LPYnu9+68WS2F9uBatRxTIHEYRuBVl/2sgcpn9/MBZC9gUzNN0ZkjCPJGXDpyY8IE3RV5uIBxHlroiGO1q1X82/N+bnrLlgOf6sCBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWCcugnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB9EC2BD10;
	Wed, 12 Jun 2024 03:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161674;
	bh=jXhnViIe7fzMZvQsFuF6K9Ax83b2+vjS+Tc2uXM0Fx8=;
	h=From:To:Cc:Subject:Date:From;
	b=uWCcugnumeh5aOu5Z8hBkzWW5KNgjVAzsFqb2Sg0vk2pisy8q2/mlVNApbfJH2OsD
	 YeCCVUlQ0mmfmUOyd0QG9n8fPRypSpbwScVZ1d5NW0faAmhpgWNFhxNBTYWMgKIUvm
	 1FjOp3XL14165T5emgW8dpIpDCeaOi0J4gYZEPvrfsghnGawPWr0IrRXp76d4xvujl
	 zJvh9mHE8asl42ZdJCP5/mwVm19qGIy5WmiB/GanocIbNhQIUC8lJzFq4DhoTrC2Om
	 FQQj08S4fLgCX4fi89axgnNviObZvTppxiONLvaFukp6aC9UcqYKGu0ivHxrwikVs0
	 hf5jp1jy1J8Fg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [RFC PATCH v2 00/15] nfs/nfsd: add support for localio
Date: Tue, 11 Jun 2024 23:07:37 -0400
Message-ID: <20240612030752.31754-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series rebases "localio" changes that Hammerspace (and
Primary Data before it) has been carrying since 2014. The reason they
weren't proposed for upstream inclusion until now was the handshake
for whether or not a client and server are local was brittle, for more
context please see this commit from v1:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-6.11.v1&id=8069f78e10f8fa4dd6aa6ba3ad643de6f95be6f6

Aside from rebasing the original changes from a 5.15.130-stable
kernel, my contribution to this series started with making the localio
handshake more robust. To do so a new LOCALIO protocol extension has
been added to both NFS v3 and v4. It follows the well-worn pattern
established by the ACL protocol extension.

These changes have proven stable against various test scenarios:
1) client and server both on localhost (for both v3 and v4.2)
2) various permutations of client and server support enablement for
   both local and remote client and server.
3) client on host, server within a container (for both v3 and v4.2)
   My container testing was in terms of podman managed containers.

That said, v2 is "RFC" because it still lacks proper refcounting on
nn->nfsd_serv and I need help on how others would like to see that
happen given svc_get/svc_put were removed with commit 1e3577a4521e
("SUNRPC: discard sv_refcnt, and svc_get/svc_put").

* Changes since v1: lots of folding and rebasing of patches to try to
  minimize needless preservation of old code that later patches
  removed. Dropped patches that weren't needed. Some renames and 
  comments. Some refactoring of nfsiod_start.

All review and comments are welcome!

Thanks,
Mike

Mike Snitzer (6):
  nfs_common: add NFS LOCALIO protocol extension enablement
  nfs: implement v3 and v4 client support for NFS_LOCALIO_PROGRAM
  nfsd: implement v3 and v4 server support for NFS_LOCALIO_PROGRAM
  nfs/nfsd: consolidate {encode,decode}_opaque_fixed in nfs_xdr.h
  nfs/localio: move managing nfsd_open_local_fh symbol to nfs_common
  nfs/nfsd: ensure localio server always uses its network namespace

Peng Tao (1):
  nfs: move nfs_stat_to_errno to nfs.h

Trond Myklebust (3):
  NFS: for localio don't call filesystem read() and write() routines
    directly
  NFS: Enable localio for non-pNFS I/O
  pnfs/flexfiles: Enable localio for flexfiles I/O

Weston Andros Adamson (5):
  nfs: pass nfs_client to nfs_initiate_pgio
  nfs: pass descriptor thru nfs_initiate_pgio path
  nfs: pass struct file to nfs_init_pgio and nfs_init_commit
  sunrpc: add rpcauth_map_to_svc_cred_local
  nfs/nfsd: add "localio" support

 fs/Kconfig                                |   3 +
 fs/nfs/Kconfig                            |  25 +
 fs/nfs/Makefile                           |   2 +
 fs/nfs/blocklayout/blocklayout.c          |   6 +-
 fs/nfs/client.c                           |  17 +-
 fs/nfs/filelayout/filelayout.c            |  16 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    | 131 +++-
 fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
 fs/nfs/inode.c                            |  61 +-
 fs/nfs/internal.h                         |  96 ++-
 fs/nfs/localio.c                          | 830 ++++++++++++++++++++++
 fs/nfs/nfs2xdr.c                          |  69 --
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
 fs/nfsd/Kconfig                           |  25 +
 fs/nfsd/Makefile                          |   2 +
 fs/nfsd/filecache.c                       |   2 +-
 fs/nfsd/localio.c                         | 330 +++++++++
 fs/nfsd/netns.h                           |   4 +
 fs/nfsd/nfsd.h                            |  11 +
 fs/nfsd/nfssvc.c                          |  93 ++-
 fs/nfsd/trace.h                           |   3 +-
 fs/nfsd/vfs.h                             |   9 +
 fs/nfsd/xdr.h                             |   6 +
 include/linux/nfs.h                       |  65 ++
 include/linux/nfs_fs.h                    |   2 +
 include/linux/nfs_fs_sb.h                 |   9 +
 include/linux/nfs_xdr.h                   |  31 +-
 include/linux/nfslocalio.h                |  39 +
 include/linux/sunrpc/auth.h               |   4 +
 include/uapi/linux/nfs.h                  |   4 +
 net/sunrpc/auth.c                         |  17 +
 47 files changed, 2146 insertions(+), 166 deletions(-)
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


