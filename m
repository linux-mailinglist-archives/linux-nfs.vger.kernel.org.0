Return-Path: <linux-nfs+bounces-18566-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAnwABcpemlk3QEAu9opvQ
	(envelope-from <linux-nfs+bounces-18566-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:19:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1E5A3A7F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F26543002E22
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE52FFDDE;
	Wed, 28 Jan 2026 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4iAt9/9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205032BD5AF
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613578; cv=none; b=sjpZ+L+3mllgXNK4jybhRcTtz2dl4wQWuRiSF0j0muzABHvIZMhptmptY2cW+qpuB6zI3jLh+0LwNdhWW2wsYG88kWw49d+jp2TXinxs93hNBMHJm1JEm5sbvCphHDqY9mH2skPcnN//npJc6+5sPrH4rEOGqcrLvnhkKPwTBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613578; c=relaxed/simple;
	bh=eFxmbVXKNIHOJ0p5t6uvtE36/T2eNE8w3m/tt9Ne0kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LeEbAivuKqcB7Is/m2acYgRarES212Oc5UKZo6GHZ/Uco6d+TCfZY4AVkNLcQ3tT9klWqwUr9LaECe76nLFXAWZbfKKA/LLbJCnYScNaOkSM7G4SO+oLq5IcHSJYbhuEJHJrUdcMKlddy1qrzYgKSwqZetH7op5fklV5Jj7vaQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4iAt9/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD61C4CEF1;
	Wed, 28 Jan 2026 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613577;
	bh=eFxmbVXKNIHOJ0p5t6uvtE36/T2eNE8w3m/tt9Ne0kw=;
	h=From:To:Cc:Subject:Date:From;
	b=X4iAt9/9z/tXcbRuK6HTYC1wS4KguJ6vQpiZy1DEEpk/dUS4qepdMqu0DmmIhptu3
	 OLqUBulCTYY+ikccZRm/db94Pq65WioKaEKTYHhokwolDXU3I8AvA+0ffFMz8NUCiU
	 lB8q9oQu2F+Nzogc9v9KGrcPwhPQHE/b9MRfkRTHiqSNlAVZYwRgjMzoh4N4kVcFyz
	 s3JoyCytYWuz/nqvIu8rbo7b8Fu7alVOZ8trEq3AvAndnyWvdXWFK+Uke7wvl2kbnt
	 XZM5KQdpmooWBy6EveK1cT5NkQJIcLkVsJYDO1+wudl62ygS2HTvL/GLxL4lbD4NW6
	 Gpg7md9/HjjFQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 00/14] Subject: Clarify module API boundaries
Date: Wed, 28 Jan 2026 10:19:21 -0500
Message-ID: <20260128151935.1646063-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18566-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D1E5A3A7F
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The patches in this series refactor the lockd code base to clearly
separate its public API from internal implementation and NLM
protocol details.

As context, the patches in this series are pre-requisite to the
XDR changes posted earlier:

  https://lore.kernel.org/linux-nfs/f41b27dc-fd7a-4a39-b490-1a19b3947f90@kernel.org/T/#t

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

Changes since v3:
- Address a build failure due to header reorganization

Changes since v2:
- Serialize client-side NLM shutdown to avoid UAF and NPD
- Address a build failure due to header reorganization
- Rename internal status code nlm_drop_reply

Changes since v1:
- Refine the pre-requisite header adjustments
- Reduce stack consumption by moving large structures to wrappers
- Additional extensive clean up

Chuck Lever (14):
  lockd: Simplify cast_status() in svcproc.c
  lockd: Relocate and rename nlm_drop_reply
  lockd: Introduce nlm__int__deadlock
  lockd: Have nlm_fopen() return errno values
  lockd: Relocate nlmsvc_unlock API declarations
  NFS: Use nlmclnt_shutdown_rpc_clnt() to safely shut down NLM
  lockd: Move xdr4.h from include/linux/lockd/ to fs/lockd/
  lockd: Move share.h from include/linux/lockd/ to fs/lockd/
  lockd: Relocate include/linux/lockd/lockd.h
  lockd: Remove lockd/debug.h
  lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
  lockd: Make linux/lockd/nlm.h an internal header
  lockd: Move nlm4svc_set_file_lock_range()
  lockd: Relocate svc_version definitions to XDR layer

 fs/lockd/clnt4xdr.c                 |   7 +-
 fs/lockd/clntlock.c                 |   2 +-
 fs/lockd/clntproc.c                 |   2 +-
 fs/lockd/clntxdr.c                  |   3 +-
 fs/lockd/host.c                     |  31 +++++++-
 {include/linux => fs}/lockd/lockd.h |  94 +++++++++++++++++-----
 fs/lockd/mon.c                      |   2 +-
 {include/linux => fs}/lockd/nlm.h   |   8 +-
 {include/linux => fs}/lockd/share.h |   8 +-
 fs/lockd/svc.c                      |  50 +++---------
 fs/lockd/svc4proc.c                 |  77 ++++++++++++++----
 fs/lockd/svclock.c                  |  16 ++--
 fs/lockd/svcproc.c                  | 119 ++++++++++++++++++++--------
 fs/lockd/svcshare.c                 |   5 +-
 fs/lockd/svcsubs.c                  |  32 ++++++--
 fs/lockd/trace.h                    |   3 +-
 fs/lockd/xdr.c                      |   3 +-
 {include/linux => fs}/lockd/xdr.h   |  15 +---
 fs/lockd/xdr4.c                     |  16 +---
 {include/linux => fs}/lockd/xdr4.h  |  16 +---
 fs/nfs/nfs3proc.c                   |   1 +
 fs/nfs/sysfs.c                      |   4 +-
 fs/nfsd/lockd.c                     |  50 +++++++-----
 fs/nfsd/nfsctl.c                    |   2 +-
 include/linux/lockd/bind.h          |  26 +++---
 include/linux/lockd/debug.h         |  40 ----------
 26 files changed, 368 insertions(+), 264 deletions(-)
 rename {include/linux => fs}/lockd/lockd.h (85%)
 rename {include/linux => fs}/lockd/nlm.h (91%)
 rename {include/linux => fs}/lockd/share.h (85%)
 rename {include/linux => fs}/lockd/xdr.h (91%)
 rename {include/linux => fs}/lockd/xdr4.h (80%)
 delete mode 100644 include/linux/lockd/debug.h

-- 
2.52.0


