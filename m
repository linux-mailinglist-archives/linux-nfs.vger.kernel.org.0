Return-Path: <linux-nfs+bounces-8017-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF639CFC3A
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 02:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BBABB2771A
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 01:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7A5161;
	Sat, 16 Nov 2024 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T18X3Cz8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285D4C8F
	for <linux-nfs@vger.kernel.org>; Sat, 16 Nov 2024 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721268; cv=none; b=j0m7T4k19/fGp1IUeiQ6PlkWD2EPKp6Gg1d1Wdpg4xOPXRlxTAE/HOUXSKs1iJ1PPciSysVLXjqluChV/uluvMCeZOSZu8ac4+cbHAtOoICb6lKbwhS7BV4sAGdpomaarNqzHPADb5tLKwGbf8FGNUbASdBirVPn0g+l4AskX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721268; c=relaxed/simple;
	bh=8zskGgLOdkwtsjH4Pb8r7R3MjVmfL40r2MBOYJ6yCD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vexwxmm8z4joYQgaonS+faxJH5hSjX0XU7eycyikMVks/7MaxorZbTXTagKaT88Ak7maDfyPHsxqN9h67qQB2dMyHWQVg1KyJcC9lrU5ec9iSO7ATBPrYFPYCGlV5kwZgHyqmD+e12cBwUjzcCPG2LSSHAkQ9MbnEtaX4qTjZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T18X3Cz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D9EC4CECF;
	Sat, 16 Nov 2024 01:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731721267;
	bh=8zskGgLOdkwtsjH4Pb8r7R3MjVmfL40r2MBOYJ6yCD4=;
	h=From:To:Cc:Subject:Date:From;
	b=T18X3Cz81u0DR+AbX2tdzcSQWjqdCzoHRuu32u7PLsjD5rnwPzsyoNgjHExJmnn+R
	 N3m9cwgirdfljhDjU226OFCJBdWv209W+lXL+cInJlHNLCOQd7frVcJK4HPo8fbOyD
	 82EhNZcUzlZjIsm3jcg7KeXN7Ip48bsTD6SNBfJvijp08zwZal1LoKOb0nIRP/jKLI
	 PqhbPhggFvEBo6pMzHhv7DgykXmoNpDQpRpU6DBw7VTdxc8jx22z119BiCImcnBy3Q
	 MyqaCwB5b9w3mP4XLhkm+v3yKK3XshUixTc74kKJBpmcf8W/Ctyz/oHOG7cy8kwF6o
	 hxoSgQxRVKAjA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v3 00/14] nfs/nfsd: improvements for LOCALIO
Date: Fri, 15 Nov 2024 20:40:52 -0500
Message-ID: <20241116014106.25456-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

All available here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next

Changes since v2:
- switched from rcu_assign_pointer to RCU_INIT_POINTER when setting to
  NULL.
- removed some unnecessary #if IS_ENABLED(CONFIG_NFS_LOCALIO)
- revised the NFS v3 probe patch to use a new nfsv3.ko modparam
  'nfs3_localio_probe_throttle' to control if NFSv3 will probe for
  LOCALIO. Avoids use of NFS_CS_LOCAL_IO and will probe every
  'nfs3_localio_probe_throttle' IO requests (defaults to 0, disabled).
- added "Module Parameters" section to localio.rst

All review appreciated, thanks.
Mike

Mike Snitzer (14):
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

 Documentation/filesystems/nfs/localio.rst |  98 +++++----
 fs/nfs/client.c                           |   6 +-
 fs/nfs/direct.c                           |   1 +
 fs/nfs/flexfilelayout/flexfilelayout.c    |  25 +--
 fs/nfs/flexfilelayout/flexfilelayout.h    |   1 +
 fs/nfs/inode.c                            |   3 +
 fs/nfs/internal.h                         |   9 +-
 fs/nfs/localio.c                          | 232 +++++++++++++++-----
 fs/nfs/nfs3proc.c                         |  46 +++-
 fs/nfs/nfs4state.c                        |   1 +
 fs/nfs/nfstrace.h                         |  32 ---
 fs/nfs/pagelist.c                         |   5 +-
 fs/nfs/write.c                            |   3 +-
 fs/nfs_common/Makefile                    |   3 +-
 fs/nfs_common/localio_trace.c             |  10 +
 fs/nfs_common/localio_trace.h             |  56 +++++
 fs/nfs_common/nfslocalio.c                | 250 +++++++++++++++++-----
 fs/nfsd/filecache.c                       |  20 +-
 fs/nfsd/localio.c                         |   9 +-
 fs/nfsd/netns.h                           |  12 +-
 fs/nfsd/nfsctl.c                          |   6 +-
 fs/nfsd/nfssvc.c                          |  40 ++--
 include/linux/nfs_fs.h                    |  22 +-
 include/linux/nfs_fs_sb.h                 |   3 +-
 include/linux/nfs_xdr.h                   |   1 +
 include/linux/nfslocalio.h                |  48 +++--
 26 files changed, 674 insertions(+), 268 deletions(-)
 create mode 100644 fs/nfs_common/localio_trace.c
 create mode 100644 fs/nfs_common/localio_trace.h

-- 
2.44.0


