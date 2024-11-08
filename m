Return-Path: <linux-nfs+bounces-7792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FA99C2824
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709E31F22786
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22118F54;
	Fri,  8 Nov 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKj7rkEc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B449610D
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109204; cv=none; b=l64uFlwsWYyURj12L7Y27raXsSC+D9Ca4LA3IKdwhEU4nj2Iiyu1lq5ZLhzbycPj4aQltBhsxmPB7Dtlr2d4WBTMMYepnq98FqUyUuC6Y0b25hZb5OyfKDBF+lho2al0Y362bwFlcXeZwiT4zP0FruF0hmEupro6Qbt1iGDuZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109204; c=relaxed/simple;
	bh=IbBOfsiAYZR60vffQC4Onc478JNdR0Eqy1xyDqzELPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eampta/6oO5FWobZMNWYaX21jC17wniMQQjnGuLzL0pjIfwHZfv2A0tqoGA9AZ5FYFWWZ5hT8fcWlM6OpSjrXA6MZCZudREPiEuD3OWJjAHLMeZlHB6SLUodIswNSdHiwQuT+eNdD5hdtv4SfQN0XKxcV2MUJLJW8NDbIT4xCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKj7rkEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44F1C4CED2;
	Fri,  8 Nov 2024 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109204;
	bh=IbBOfsiAYZR60vffQC4Onc478JNdR0Eqy1xyDqzELPE=;
	h=From:To:Cc:Subject:Date:From;
	b=YKj7rkEcAH/lrnZIBzVWeUUBaN26qIiILKLpUNqrFvHnClxZBcVw/N0rXgpO2hvu4
	 FXBslpqR3zRMDPSyMADrehDspdrYljGGlzU89HmtGlu73F2uXG0RNfZJp5ibc9Q2Ch
	 p02kF6NwRuP7gK/F2FI2DHUWMuQ0j6zhuRFxXQSFTHawvbcgJckXtIOXLxeypJROey
	 ah5as1dDrHflRHcWEyoa8+Vu/hszG363Wjt5b9oQ4+BWfwGC6ZJaTcOngyhTQ8jila
	 tBHoRJzb4Rc1+HPIljTkvNybYInyZrB7eCQH3uDWia219yNIKQCH2+7G9hs5IKuAk1
	 JquYevckPAA5g==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 00/19] nfs/nfsd: fixes and improvements for LOCALIO
Date: Fri,  8 Nov 2024 18:39:43 -0500
Message-ID: <20241108234002.16392-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I really wanted to post these patches at the beginning of the week (or
sooner) but I had quite a few issues to work through.  The biggest
challenge came from trying to develop the final patch only to hit the
wall of needing to find and fix memory corruption with the first
patch.

HUGE special thanks to NeilBrown for helping me identify the source of
the NFSv3 LOCALIO memory corruption fixed by the first patch.  Anna,
we'd do well for that patch to land upstream for 6.12 final (but Trond
if it slips to the 6.13 merge window pull that should be fine, as the
Fixes: tag should get it to land in 6.12-stable).

The 2nd patch is also a fundamental fix but it is kernel config
dependant on whether you'll experience the RCU splat it fixes.

Patches 3 - 6 are cleanups I've been carrying since just after the
6.12 merge window.

Patch 7 adds a 'localio_O_DIRECT_semantics' nfs module parameter that
when set will allow the use of O_DIRECT from the LOCALIO client
through to the underlying filesystem.

Patches 8 and beyond are dealing with the leftover bake-a-thon
business of switching from caching LOCALIO's open nfsd_file in the
server to doing so in the client.  Definitely took some effort but the
end result is working really well.

This is quite a bit of change at the end of the 6.13 development
window, but I _think_ it worthy of considersation for 6.13 (the bulk
of the changes are confined to fs/nfs/localio.c and
fs/nfs_common/nfslocalio.c which are only built if LOCALIO Kconfig
options enabled (even general NFS code paths are all wrapped with
CONFIG_NFS_LOCALIO).

I'm happy to work through any issues found in review with urgency next
week (or this weekend if others are interested to look and happen to
find something).

Happy to take it as it comes, I'm in no way _pushing_ for these
changes to land for 6.13.  I'm just now comfortable posting them for
serious consideration.

Thanks,
Mike

Mike Snitzer (18):
  nfs_common: must not hold RCU while calling nfsd_file_put_local
  nfs/localio: remove redundant suid/sgid handling
  nfs/localio: eliminate unnecessary kref in nfs_local_fsync_ctx
  nfs/localio: remove extra indirect nfs_to call to check {read,write}_iter
  nfs/localio: eliminate need for nfs_local_fsync_work forward declaration
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
  nfs: probe for LOCALIO when v4 client reconnects to server
  nfs: probe for LOCALIO when v3 client reconnects to server

NeilBrown (1):
  nfs/localio: must clear res.replen in nfs_local_read_done

 fs/nfs/client.c                        |   1 -
 fs/nfs/direct.c                        |   1 +
 fs/nfs/flexfilelayout/flexfilelayout.c |  29 ++-
 fs/nfs/flexfilelayout/flexfilelayout.h |   1 +
 fs/nfs/inode.c                         |   3 +
 fs/nfs/internal.h                      |  11 +-
 fs/nfs/localio.c                       | 319 ++++++++++++++++++-------
 fs/nfs/nfs3proc.c                      |  34 ++-
 fs/nfs/nfs4state.c                     |   1 +
 fs/nfs/pagelist.c                      |   5 +-
 fs/nfs/write.c                         |   3 +-
 fs/nfs_common/Makefile                 |   3 +-
 fs/nfs_common/localio_trace.c          |  10 +
 fs/nfs_common/localio_trace.h          |  56 +++++
 fs/nfs_common/nfslocalio.c             | 269 ++++++++++++++++-----
 fs/nfsd/filecache.c                    |  32 ++-
 fs/nfsd/filecache.h                    |   2 +-
 fs/nfsd/localio.c                      |   9 +-
 fs/nfsd/netns.h                        |  12 +-
 fs/nfsd/nfsctl.c                       |   6 +-
 fs/nfsd/nfssvc.c                       |  40 ++--
 include/linux/nfs_fs.h                 |  22 +-
 include/linux/nfs_fs_sb.h              |   3 +-
 include/linux/nfs_xdr.h                |   1 +
 include/linux/nfslocalio.h             |  65 +++--
 25 files changed, 712 insertions(+), 226 deletions(-)
 create mode 100644 fs/nfs_common/localio_trace.c
 create mode 100644 fs/nfs_common/localio_trace.h

-- 
2.44.0


