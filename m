Return-Path: <linux-nfs+bounces-18361-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E/nFprDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18361-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E81CA79C9B
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55F2F3006468
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D38218AAD;
	Fri, 23 Jan 2026 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLHDcwZJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1123C4E9
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194383; cv=none; b=de5KEeinp9w1kJfdrIr9xZWpc94LTN2BXsRLVxCMMk3TkCqznMO5DRo4RPEyg+rd2R+0WhbJAIddSkFryzmOjA+OCIEQ4IyrnLYMkcVi081+0xNmLH1BFIsYL891G/9PYqzACxnJpIkDGKbY94op68pWln6ypLNAnDZ0PbHcD+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194383; c=relaxed/simple;
	bh=bUHe+RImwh1IeG7q9KUqdg/bYkoLZA/X7NKlRalpLok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQtwQG50wgsat4raSoZ0er6pPDCr/i1j+JOdmBQ9ICfAoP0TR3YgoRSX95zxQEH1nfXFAgLla5cJPHcpnXbricsCNyABKBdDblKALQQEQ70ZfvsQT6NIvDCBS01rOJhnuL9+PWaT9SGF6L52x21zU06qLcYseWGB+QZK4wsRpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLHDcwZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F4DC4CEF1;
	Fri, 23 Jan 2026 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194383;
	bh=bUHe+RImwh1IeG7q9KUqdg/bYkoLZA/X7NKlRalpLok=;
	h=From:To:Cc:Subject:Date:From;
	b=dLHDcwZJ5TJF0pz085Am+LCSw2mlAo9GILfdmikBAjrnUyUdarYv9IssWjTBON/DZ
	 p+BSIua914spyOd8AVXpv3UScC1RboPQcISKk7Yh8cW+15f1KK0NsacTAOFoN8hNnG
	 FYHv8HJIKPN5Ek+t1c+SkOW0RGFG2PhLxunDkoROrZoBvo+Ep/aTB01NINozvCcaQS
	 fZwLY3LEefhHT/alQgViFhWfJutsva21E7SM5+epTHLimORSbX3ODxjz7MibROpmrl
	 mJbCVzQ8jFUAbL0v32WvNgAz6yTPY+AdPzW8FXc75o9Le+L+GYuuM7su+XojmCgKDQ
	 d/2IE0zzlgmLg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 00/42] Clarify module API boundaries
Date: Fri, 23 Jan 2026 13:52:17 -0500
Message-ID: <20260123185259.1215767-1-cel@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18361-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: E81CA79C9B
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The first thirteen patches in this series refactor the lockd code
base to clearly separate its public API from internal implementation
details. The remainder are presented for context, but demonstrate
the intended purpose of the clean-up in the first thirteen.

The lockd subsystem currently exposes internal implementation headers
through include/linux/lockd/, creating implicit API contracts that
complicate maintenance. External consumers such as NFSD and the NFS
client have developed dependencies on internal structures like struct
nlm_host, and wire protocol constants leak into high-level module
interfaces.

These patches work to establish clean architectural boundaries. The
public API in include/linux/lockd/ is reduced to bind.h and nlm.h,
which define the contract between lockd and its consumers. Private
implementation details including XDR definitions, share management,
and host structures are relocated to fs/lockd/ where they belong.
Layering violations are corrected: the NFS client now uses accessor
helpers instead of dereferencing internal structures, and nlm_fopen()
returns errno values instead of wire protocol codes.

These changes enable subsequent work to modernize the NLMv4 XDR
layer using xdrgen without risk of breaking external consumers.
This work appears in the remaining patches in this series, which
are presented here only to provide context for the API adjustments.
No need to review those closely just yet.

The series is based on the public nfsd-testing branch.

---

Changes since v1:
- Refine the pre-requisite header adjustments
- Reduce stack consumption by moving large structures to wrappers
- Additional extensive clean up

Chuck Lever (42):
  lockd: Simplify cast_status() in svcproc.c
  lockd: Introduce nlm__int__deadlock
  lockd: Have nlm_fopen() return errno values
  lockd: Relocate nlmsvc_unlock API declarations
  NFS: Use nlmclnt_rpc_clnt() helper to retrieve nlm_host's rpc_clnt
  lockd: Move xdr4.h from include/linux/lockd/ to fs/lockd/
  lockd: Move share.h from include/linux/lockd/ to fs/lockd/
  lockd: Relocate include/linux/lockd/lockd.h
  lockd: Remove lockd/debug.h
  lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
  lockd: Make linux/lockd/nlm.h an internal header
  lockd: Move nlm4svc_set_file_lock_range()
  lockd: Relocate svc_version definitions to XDR layer
  Documentation: Add the RPC language description of NLM version 4
  lockd: Use xdrgen XDR functions for the NLMv4 NULL procedure
  lockd: Use xdrgen XDR functions for the NLMv4 TEST procedure
  lockd: Use xdrgen XDR functions for the NLMv4 LOCK procedure
  lockd: Use xdrgen XDR functions for the NLMv4 CANCEL procedure
  lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK procedure
  lockd: Use xdrgen XDR functions for the NLMv4 GRANTED procedure
  lockd: Refactor nlm4svc_callback()
  lockd: Use xdrgen XDR functions for the NLMv4 TEST_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 LOCK_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 TEST_RES procedure
  lockd: Use xdrgen XDR functions for the NLMv4 LOCK_RES procedure
  lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_RES procedure
  lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK_RES procedure
  lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_RES procedure
  lockd: Use xdrgen XDR functions for the NLMv4 SM_NOTIFY procedure
  lockd: Convert server-side undefined procedures to xdrgen
  lockd: Hoist file_lock init out of nlm4svc_decode_shareargs()
  lockd: Prepare share helpers for xdrgen conversion
  lockd: Use xdrgen XDR functions for the NLMv4 SHARE procedure
  lockd: Use xdrgen XDR functions for the NLMv4 UNSHARE procedure
  lockd: Use xdrgen XDR functions for the NLMv4 NM_LOCK procedure
  lockd: Use xdrgen XDR functions for the NLMv4 FREE_ALL procedure
  lockd: Add LOCKD_SHARE_SVID constant for DOS sharing mode
  lockd: Remove C macros that are no longer used
  lockd: Remove dead code from fs/lockd/xdr4.c

 Documentation/sunrpc/xdr/nlm4.x     |  211 ++++
 fs/lockd/Makefile                   |   30 +-
 fs/lockd/clnt4xdr.c                 |    5 +-
 fs/lockd/clntlock.c                 |    2 +-
 fs/lockd/clntproc.c                 |    2 +-
 fs/lockd/clntxdr.c                  |    3 +-
 fs/lockd/host.c                     |    2 +-
 {include/linux => fs}/lockd/lockd.h |   99 +-
 fs/lockd/mon.c                      |    2 +-
 {include/linux => fs}/lockd/nlm.h   |    8 +-
 fs/lockd/nlm4xdr_gen.c              |  724 +++++++++++
 fs/lockd/nlm4xdr_gen.h              |   32 +
 {include/linux => fs}/lockd/share.h |   19 +-
 fs/lockd/svc.c                      |   50 +-
 fs/lockd/svc4proc.c                 | 1783 ++++++++++++++++++---------
 fs/lockd/svclock.c                  |   12 +-
 fs/lockd/svcproc.c                  |   99 +-
 fs/lockd/svcshare.c                 |   40 +-
 fs/lockd/svcsubs.c                  |   32 +-
 fs/lockd/trace.h                    |    3 +-
 fs/lockd/xdr.c                      |    6 +-
 {include/linux => fs}/lockd/xdr.h   |   15 +-
 fs/lockd/xdr4.c                     |  347 ------
 fs/nfs/sysfs.c                      |   10 +-
 fs/nfsd/lockd.c                     |   51 +-
 fs/nfsd/nfsctl.c                    |    2 +-
 include/linux/lockd/bind.h          |   23 +-
 include/linux/lockd/debug.h         |   40 -
 include/linux/lockd/xdr4.h          |   43 -
 include/linux/sunrpc/xdrgen/nlm4.h  |  233 ++++
 30 files changed, 2750 insertions(+), 1178 deletions(-)
 create mode 100644 Documentation/sunrpc/xdr/nlm4.x
 rename {include/linux => fs}/lockd/lockd.h (84%)
 rename {include/linux => fs}/lockd/nlm.h (91%)
 create mode 100644 fs/lockd/nlm4xdr_gen.c
 create mode 100644 fs/lockd/nlm4xdr_gen.h
 rename {include/linux => fs}/lockd/share.h (58%)
 rename {include/linux => fs}/lockd/xdr.h (91%)
 delete mode 100644 fs/lockd/xdr4.c
 delete mode 100644 include/linux/lockd/debug.h
 delete mode 100644 include/linux/lockd/xdr4.h
 create mode 100644 include/linux/sunrpc/xdrgen/nlm4.h

-- 
2.52.0


