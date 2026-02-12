Return-Path: <linux-nfs+bounces-18908-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OFfHehOjmljBgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18908-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Feb 2026 23:06:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 998BB131742
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Feb 2026 23:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFD1C3008D0A
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Feb 2026 22:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65135771F;
	Thu, 12 Feb 2026 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omZJXzFL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2769A299950
	for <linux-nfs@vger.kernel.org>; Thu, 12 Feb 2026 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770933987; cv=none; b=LCHX/H0FJ0v/NKd0CvZ1nx5AYau8xnKetHEMvvYFahgEcQpQYqsUMcrSvXcAqfImfAR3jTJx1pT4gUdK6ANbIQvczu531/DDjVOxHPF0yZM08Cu8HLQbwUBCeOUunDBXoXLqCMgNbLRA5MX9eRrEcqS6O2FfVNHGgi8FdO6RDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770933987; c=relaxed/simple;
	bh=sceOw9dDW5/IzMxos+t/HwiICqHx4CQ6jp2kRwBfrBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSQ1e+qY0fmDOZoTjMgScOxAjP9ke2VErx3QIHeSmBgH+l0gdGKFasiRRhjf77U8cArCmfM/qXwwGnYE3BQiMGAfto7bX++QhBO1ICpXzLFpsqc0rhkZTf9/IL/QIEf+jeX7IRlXk0ajDCJk+YeRP7y1KDTsDY4Wa3xzaW4T4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omZJXzFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D61C19421;
	Thu, 12 Feb 2026 22:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770933986;
	bh=sceOw9dDW5/IzMxos+t/HwiICqHx4CQ6jp2kRwBfrBE=;
	h=From:To:Cc:Subject:Date:From;
	b=omZJXzFLuzIfkKgv4jF7Tdud0LXcorQj8+Ebl2VQdAM1GxnaKDoQNAxEm/RELdPdG
	 ese2h31DiTlwj+dxELouYSjQlNNM2iWVo7Bifz08B50UCfh9wkyPB5TxqAhEWx9c/L
	 dq+izknjhtlyxfhBdxaFYuD+FCtcYZYQtrIUwV4VQJFZS1ydIdahapU1o1Jlwv0ovw
	 WKT/4qukvXpjXmWmBAlVWRkauUC5BTq/fUJvZhwxcFRuCz6J7Z9GeV4k64IT8xB7AU
	 K0sxYtexVWFGuHQ1puInjMyCZM/e0+hidOCeRrQSKj9qpHq07pSta7dTMEhsCsqjmN
	 XPcFvUsYYoP9Q==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Updates for Linux 7.0
Date: Thu, 12 Feb 2026 17:06:25 -0500
Message-ID: <20260212220625.358550-1-anna@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18908-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 998BB131742
X-Rspamd-Action: no action

Hi Linus,

The following changes since commit 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7:

  Linux 6.19-rc6 (2026-01-18 15:42:45 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-7.0-1

for you to fetch changes up to dd2fdc3504592d85e549c523b054898a036a6afe:

  SUNRPC: fix gss_auth kref leak in gss_alloc_msg error path (2026-02-09 16:39:50 -0500)

----------------------------------------------------------------
NFS Client Updates for Linux 7.0

New Features:
 * Use an LRU list for returning unused delegations
 * Introduce a KConfig option to disable NFS v4.0 and make NFS v4.1 the default

Bugfixes:
 * NFS/localio: Handle short writes by retrying
 * NFS/localio: prevent direct reclaim recursion into NFS via nfs_writepages
 * NFS/localio: use GFP_NOIO and non-memreclaim workqueue in nfs_local_commit
 * NFS/localio: remove -EAGAIN handling in nfs_local_doio()
 * pNFS: fix a missing wake up while waiting on NFS_LAYOUT_DRAIN
 * fs/nfs: Fix a readdir slow-start regression
 * SUNRPC: fix gss_auth kref leak in gss_alloc_msg error path

Other Cleanups and Improvements:
  * A few other NFS/localio cleanups
  * Various other delegation handling cleanups from Christoph
  * Unify security_inode_listsecurity() calls
  * Improvements to NFSv4 lease handling
  * Clean up SUNRPC *_debug fields when CONFIG_SUNRPC_DEBUG is not set

Thanks,
Anna

----------------------------------------------------------------
Anna Schumaker (14):
      NFS: Move nfs40_call_sync_ops into nfs40proc.c
      NFS: Split out the nfs40_reboot_recovery_ops into nfs40client.c
      NFS: Split out the nfs40_nograce_recovery_ops into nfs40proc.c
      NFS: Split out the nfs40_state_renewal_ops into nfs40proc.c
      NFS: Split out the nfs40_mig_recovery_ops to nfs40proc.c
      NFS: Move the NFS v4.0 minor version ops into nfs40proc.c
      NFS: Make the various NFS v4.0 operations static again
      NFS: Move nfs40_shutdown_client into nfs40client.c
      NFS: Move nfs40_init_client into nfs40client.c
      NFS: Move NFS v4.0 pathdown recovery into nfs40client.c
      NFS: Pass a struct nfs_client to nfs4_init_sequence()
      NFS: Move sequence slot operations into minorversion operations
      NFS: Add a way to disable NFS v4.0 via KConfig
      NFS: Merge CONFIG_NFS_V4_1 with CONFIG_NFS_V4

Ben Dooks (1):
      sunrpc: rpc_debug and others are defined even if CONFIG_SUNRPC_DEBUG unset

Chen Ni (1):
      nfs: nfs4proc: Convert comma to semicolon

Chenguang Zhao (1):
      SUNRPC: Change list definition method

Christoph Hellwig (31):
      NFS: remove __nfs_client_for_each_server
      NFS: remove nfs_client_mark_return_unused_delegation_types
      NFS: remove nfs_client_mark_return_all_delegations
      NFS: remove the NULL inode check in nfs4_inode_return_delegation_on_close
      NFS: remove nfs_inode_detach_delegation
      NFS: remove nfs_start_delegation_return
      NFS: assert rcu_read_lock is held in nfs_start_delegation_return_locked
      NFS: drop the _locked postfix from nfs_start_delegation_return
      NFS: remove NFS_DELEGATION_INODE_FREEING
      NFS: open code nfs_delegation_need_return
      NFS: remove nfs_free_delegation
      NFS: rewrite nfs_delegations_present in terms of nr_active_delegations
      NFS: move delegation lookup into can_open_delegated
      NFS: return bool from nfs_detach_delegation{,_locked}
      NFS: move the deleg_cur check out of nfs_detach_delegation_locked
      NFS: simplify the detached delegation check in update_open_stateid
      NFS: take a delegation reference in nfs4_get_valid_delegation
      NFS: don't consume a delegation reference in nfs_end_delegation_return
      NFS: use refcount_inc_not_zero nfs_start_delegation_return
      NFS: use a local RCU critical section in nfs_start_delegation_return
      NFS: reformat nfs_mark_delegation_revoked
      NFS: add a separate delegation return list
      NFS: return delegations from the end of a LRU when over the watermark
      NFS: make nfs_mark_return_unreferenced_delegations less aggressive
      NFS: return void from nfs4_inode_make_writeable
      NFS: return void from ->return_delegation
      NFS: use bool for the issync argument to nfs_end_delegation_return
      NFS: remove the delegation == NULL check in nfs_end_delegation_return
      NFS: fold nfs_abort_delegation_return into nfs_end_delegation_return
      NFS: simplify error handling in nfs_end_delegation_return
      NFS: fix delayed delegation return handling

Daniel Hodges (1):
      SUNRPC: fix gss_auth kref leak in gss_alloc_msg error path

Mike Snitzer (4):
      NFS/localio: prevent direct reclaim recursion into NFS via nfs_writepages
      NFS/localio: use GFP_NOIO and non-memreclaim workqueue in nfs_local_commit
      NFS/localio: remove -EAGAIN handling in nfs_local_doio()
      NFS/localio: switch nfs_local_do_read and nfs_local_do_write to return void

Olga Kornievskaia (1):
      pNFS: fix a missing wake up while waiting on NFS_LAYOUT_DRAIN

Sagi Grimberg (1):
      fs/nfs: Fix readdir slow-start regression

Sergey Shtylyov (2):
      NFSv4: pass lease period in seconds to nfs4_set_lease_period()
      NFSv4: limit lease period in nfs4_set_lease_period()

Stephen Smalley (1):
      nfs: unify security_inode_listsecurity() calls

Trond Myklebust (2):
      NFS/localio: Handle short writes by retrying
      NFS/localio: Cleanup the nfs_local_pgio_done() parameters

 fs/nfs/Kconfig                 |  26 +-
 fs/nfs/Makefile                |   4 +-
 fs/nfs/callback.c              |  13 +-
 fs/nfs/callback.h              |   3 -
 fs/nfs/callback_proc.c         |  16 +-
 fs/nfs/callback_xdr.c          |  21 --
 fs/nfs/client.c                |  12 +-
 fs/nfs/delegation.c            | 594 +++++++++++++++---------------
 fs/nfs/delegation.h            |   9 +-
 fs/nfs/dir.c                   |   4 +-
 fs/nfs/fs_context.c            |   3 +-
 fs/nfs/internal.h              |  15 +-
 fs/nfs/localio.c               | 126 ++++---
 fs/nfs/netns.h                 |   4 +-
 fs/nfs/nfs3proc.c              |   3 +-
 fs/nfs/nfs40.h                 |  19 +
 fs/nfs/nfs40client.c           | 245 +++++++++++++
 fs/nfs/nfs40proc.c             | 395 ++++++++++++++++++++
 fs/nfs/nfs42proc.c             |  13 +-
 fs/nfs/nfs4_fs.h               |  86 +++--
 fs/nfs/nfs4client.c            | 193 +---------
 fs/nfs/nfs4proc.c              | 804 +++++++++--------------------------------
 fs/nfs/nfs4renewd.c            |  15 +-
 fs/nfs/nfs4session.c           |   4 -
 fs/nfs/nfs4session.h           |  23 --
 fs/nfs/nfs4state.c             |  93 +----
 fs/nfs/nfs4trace.c             |   2 -
 fs/nfs/nfs4trace.h             |  21 +-
 fs/nfs/nfs4xdr.c               | 109 ++----
 fs/nfs/pnfs.c                  |   3 +-
 fs/nfs/pnfs.h                  |   6 +-
 fs/nfs/proc.c                  |   3 +-
 fs/nfs/read.c                  |   4 +-
 fs/nfs/super.c                 |  30 +-
 fs/nfs/sysfs.c                 |  10 +-
 fs/nfs/write.c                 |   2 +-
 include/linux/nfs_fs_sb.h      |  10 +-
 include/linux/nfs_xdr.h        |   9 +-
 include/linux/sunrpc/debug.h   |   2 -
 net/sunrpc/auth_gss/auth_gss.c |   3 +
 net/sunrpc/backchannel_rqst.c  |   3 +-
 41 files changed, 1372 insertions(+), 1588 deletions(-)
 create mode 100644 fs/nfs/nfs40.h
 create mode 100644 fs/nfs/nfs40client.c
 create mode 100644 fs/nfs/nfs40proc.c

