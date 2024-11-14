Return-Path: <linux-nfs+bounces-7951-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5192A9C8194
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 05:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192741F22ED1
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 03:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCE67CF16;
	Thu, 14 Nov 2024 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQmfK6+5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A446BF
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556794; cv=none; b=oCM6hJ7uu42T21Vps1rNIzXx4SOT3KcNEA+RsSIu7xvk1LpkhL3oz7b9t4/Gb0oDXILplPrX6WnRpLM4DJbBcpKsHWMT1WrOz2HWkBPwvnPYh7fJkwslQRJqovCDFwuvQnB3Pqw8cs7006OpawwI2QIIZ0r1MyoMd/UsutmOros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556794; c=relaxed/simple;
	bh=detGLLelBNonIL/fGiWVo7g6uIJImVM5pwmCMuf3YGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAJt9xiU4MJqVqc6HfOhSHPnqDQIJHO3bE2PyS85xN6/B1QCrbvlrKMtPdrOW+uHUYfHkkVIBO7jVkV/GF4IftQMNXq8ODMp5mkAJ0DBwJrflvoGNZ7o//kynNX4xNoeLyQRKhnfgBkTbEKBg+gnKBJvd1AuvmbuCCzz2tLZ+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQmfK6+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9BEC4CED0;
	Thu, 14 Nov 2024 03:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556793;
	bh=detGLLelBNonIL/fGiWVo7g6uIJImVM5pwmCMuf3YGE=;
	h=From:To:Cc:Subject:Date:From;
	b=KQmfK6+5ILmqWUrYsqBexE+qaCXiVdBU/M6y+jDnmcnUWBckRfoN8bJLJY2G5OQHf
	 GwubIijMKEMAFMyChNE0nZoAsY7rgfP6a5/HlaDn44lWM7Q4/hk6kgHwzVoYB1VFXO
	 QofUY19trn4fCaIkinp4YamwhXEhLuACwtVp1JiK6Snla+RvOJXpFOcPsXzgZtJN5D
	 cjj129SOEJ+V+6+Wz4ld5dLMabLkX98JT3bCUtaqUKhLUrzeTwFDfHZJNiVvBOVFVt
	 7nzp9QIc4bVQyNYKuyPbfq+D7mNTxNe/D4bEoZ5Qd7hSFV9aKA9L3xd9FDi/aclN0C
	 lhf6YOOviCpMA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v2 00/15] nfs/nfsd: fixes and improvements for LOCALIO
Date: Wed, 13 Nov 2024 22:59:37 -0500
Message-ID: <20241114035952.13889-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This v2 is rebased ontop of Chuck's nfsd-next and Trond's nfs-next,
see: https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next

(Neil, ~3 patches from v1 that you Reviewed-by were already staged by
Trond, without your Reviewed-by, because they were in the nfs patch
queue carried over from just after the 6.12 merge window closed).

Changes since v1:
- added Reviewed-by tags and Fixes where provided/suggested
- removed unnecessary use of RCU read-side critical section in
  nfs_server_uuid_is_local 
- switched to using RCU_INIT_POINTER to set nfs_uuid->net to NULL
- updated Documentation/filesystems/nfs/localio.rst to reflect the
  percpu_ref change from nfsd_serv to nfsd_net. Also discuss O_DIRECT
  relative to LOCALIO and document the nfs module param (Chuck, I do
  think we need it, otherwise O_DIRECT regressions are possible).
- removed redundant code and simplify LOCALIO enablement, the
  nfs_client struct is still used in nfs_common/nfslocalio.c but it is
  very limited (clp->cl_uuid and the established tracepoints).
- eliminated repeat INIT_WORK in nfs_local_probe_async
- kept the NFS v3 LOCALIO reconnect approach but eliminated the use of
  a mutex and also increased the throttling from every 256 to 512
  IOs. Updated patch header to expalin that more work is needed.

I think the final NFSv3 reconnect patch works well for now, but I am
completely on board with making it work well for the scenarios that
were discussed. I just didn't have time to perfect the approach. So
I'll defer to Trond, Anna and others on whether or not its best to
just drop patch 15 for now -- so continue to let LOCALIO get disabled,
if the server is restarted, and require manual LOCALIO recovery (via
remount).

Thanks,
Mike

Mike Snitzer (15):
  nfs_common: must not hold RCU while calling nfsd_file_put_local
  nfs/localio: add direct IO enablement with sync and async IO support
  nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
  nfs_common: rename functions that invalidate LOCALIO nfs_clients
  nfs_common: move localio_lock to new lock member of nfs_uuid_t
  nfs: cache all open LOCALIO nfsd_file(s) in client
  nfsd: update percpu_ref to manage references on nfsd_net
  nfsd: rename nfsd_serv_ prefixed methods and variables with nfsd_net_
  nfsd: nfsd_file_acquire_local no longer returns GC'd nfsd_file
  nfs_common: rename nfslocalio nfs_uuid_lock to nfs_uuids_lock
  nfs_common: track all open nfsd_files per LOCALIO nfs_client
  nfs_common: add nfs_localio trace events
  nfs/localio: remove redundant code and simplify LOCALIO enablement
  nfs: probe for LOCALIO when v4 client reconnects to server
  nfs: probe for LOCALIO when v3 client reconnects to server

 Documentation/filesystems/nfs/localio.rst |  78 +++----
 fs/nfs/client.c                           |   4 +-
 fs/nfs/direct.c                           |   1 +
 fs/nfs/flexfilelayout/flexfilelayout.c    |  29 ++-
 fs/nfs/flexfilelayout/flexfilelayout.h    |   1 +
 fs/nfs/inode.c                            |   3 +
 fs/nfs/internal.h                         |  14 +-
 fs/nfs/localio.c                          | 250 ++++++++++++++++-----
 fs/nfs/nfs3proc.c                         |  32 ++-
 fs/nfs/nfs4state.c                        |   1 +
 fs/nfs/nfstrace.h                         |  32 ---
 fs/nfs/pagelist.c                         |   5 +-
 fs/nfs/write.c                            |   3 +-
 fs/nfs_common/Makefile                    |   3 +-
 fs/nfs_common/localio_trace.c             |  10 +
 fs/nfs_common/localio_trace.h             |  56 +++++
 fs/nfs_common/nfslocalio.c                | 258 +++++++++++++++++-----
 fs/nfsd/filecache.c                       |  32 ++-
 fs/nfsd/filecache.h                       |   2 +-
 fs/nfsd/localio.c                         |   9 +-
 fs/nfsd/netns.h                           |  12 +-
 fs/nfsd/nfsctl.c                          |   6 +-
 fs/nfsd/nfssvc.c                          |  40 ++--
 include/linux/nfs_fs.h                    |  22 +-
 include/linux/nfs_fs_sb.h                 |   2 +-
 include/linux/nfs_xdr.h                   |   1 +
 include/linux/nfslocalio.h                |  64 ++++--
 27 files changed, 688 insertions(+), 282 deletions(-)
 create mode 100644 fs/nfs_common/localio_trace.c
 create mode 100644 fs/nfs_common/localio_trace.h

-- 
2.44.0


