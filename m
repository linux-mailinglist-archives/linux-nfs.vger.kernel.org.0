Return-Path: <linux-nfs+bounces-18511-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA2aKkHRd2mxlQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18511-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:40:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB58D291
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B246301A3BF
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021992D7397;
	Mon, 26 Jan 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igZWyWk/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BD2D6E74
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459979; cv=none; b=lolG3P8x/yavvZdMkOS1R5YSv9ViZt2JlxFubgJRSIZHrPt0txR3ydKdq/X4dx2ASA5NBW1RWnjCztRGLcwpyAz/JF4nU05LUqzUJl+aUY7mBfIlBAdjRe9sTSGGU0WkNhs+es9FcPDi8tun7v/2K74ySpFyN/cXAiU+O/vJhbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459979; c=relaxed/simple;
	bh=8SSNIjeKTzQ69zineYmB6eT/Qi211qkToyRetrPZZzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDQnZoeGGdGu31inLG3i0un4hAPhAiz0PbYjWqjmEzfYwuI2d0C0inqIzO/ZR3xF1RPGMoqDGckvvviexr5gaBcjpahCEjSDF2kwtyZDjEDw1roIg/ooOyNW93dmmWTpXSN3H0bwo2TvPb6BH5e1vZQCfgySTkIRczgNHnw2xic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igZWyWk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEB1C116C6;
	Mon, 26 Jan 2026 20:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459979;
	bh=8SSNIjeKTzQ69zineYmB6eT/Qi211qkToyRetrPZZzU=;
	h=From:To:Cc:Subject:Date:From;
	b=igZWyWk/Fh7oy2epc2Wk9gFaF7KQBKtJW3Z87zogvQ6GF6hLpuxwdwdnpKqHceYsK
	 KJOzXZy+sZxMIsEgs3pvUpHbCMx+zr0SNLR3jvU92binPzJFZhXxCtRQHyiVuM8PNX
	 koqQ7khin2p1rq3UU+W+t80nlG5VhDi8T/Z5k66y6a4GAvIApEDbT+KGQzHjzLRD0p
	 d5dxvdcErCJVa4ix+YQkLbMRzoVBBidYPeBI90ugRYSVBCG52tzOghsA2gW5EZXGFv
	 uooXb8HoSNmP0of/O2p1S6JTbZdn+ari10LGddZFEqMMWZWkWGLwcHzDag7Y3VCbPn
	 VrjQpgqyQ3yYA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 00/14] NFS: Make NFS v4.0 KConfig-urable
Date: Mon, 26 Jan 2026 15:39:24 -0500
Message-ID: <20260126203938.450304-1-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18511-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 14FB58D291
X-Rspamd-Action: no action

From: Anna Schumaker <anna.schumaker@oracle.com>

A desire to deprecate NFS v4.0 came up as a discussion topic during the
October Bake-a-thon last year. This patchset takes the first step by
moving NFS v4.0 only code into new files prefixed with "nfs40" and
introducing a KConfig option to compile without NFS v4.0 support.

At the same time, I promote NFS v4.1 to be the default NFSv4
minorversion included in the kernel to prevent the situation where we
have NFS v4 enabled without any minor versions.

Changes in v2:
- KConfig-out NFS v4.0-only operations from nfs4xdr.c
- Fix a kernel test robot build warning

Thoughts?
Anna


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

 fs/nfs/Kconfig            |  26 +-
 fs/nfs/Makefile           |   4 +-
 fs/nfs/callback.c         |  13 +-
 fs/nfs/callback.h         |   3 -
 fs/nfs/callback_proc.c    |   3 -
 fs/nfs/callback_xdr.c     |  21 --
 fs/nfs/client.c           |   8 +-
 fs/nfs/fs_context.c       |   3 +-
 fs/nfs/internal.h         |  15 +-
 fs/nfs/netns.h            |   4 +-
 fs/nfs/nfs40.h            |  19 ++
 fs/nfs/nfs40client.c      | 247 ++++++++++++++
 fs/nfs/nfs40proc.c        | 395 ++++++++++++++++++++++
 fs/nfs/nfs42proc.c        |  13 +-
 fs/nfs/nfs4_fs.h          |  83 ++---
 fs/nfs/nfs4client.c       | 193 +----------
 fs/nfs/nfs4proc.c         | 682 +++++++-------------------------------
 fs/nfs/nfs4session.c      |   4 -
 fs/nfs/nfs4session.h      |  23 --
 fs/nfs/nfs4state.c        |  91 +----
 fs/nfs/nfs4trace.c        |   2 -
 fs/nfs/nfs4trace.h        |  16 -
 fs/nfs/nfs4xdr.c          | 109 ++----
 fs/nfs/pnfs.h             |   6 +-
 fs/nfs/read.c             |   4 +-
 fs/nfs/super.c            |  16 +-
 fs/nfs/sysfs.c            |  10 +-
 fs/nfs/write.c            |   2 +-
 include/linux/nfs_fs_sb.h |   2 -
 include/linux/nfs_xdr.h   |   7 +-
 30 files changed, 902 insertions(+), 1122 deletions(-)
 create mode 100644 fs/nfs/nfs40.h
 create mode 100644 fs/nfs/nfs40client.c
 create mode 100644 fs/nfs/nfs40proc.c

-- 
2.52.0


