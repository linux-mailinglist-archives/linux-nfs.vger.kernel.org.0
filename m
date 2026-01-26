Return-Path: <linux-nfs+bounces-18493-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGs4Fb7Gd2nckgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18493-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7E8CCCE
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B433A30097F7
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F29288C96;
	Mon, 26 Jan 2026 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdhbhWme"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04687288C81
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457339; cv=none; b=FkCdajgRV/JJWxks98OEGABrK/9OrBXqTS+MrriZtu4/k67Afr/yDTwjazuD8DsW0jagp3TY9AiT7nDq28feIAWTDPk2mRoU/G2KE9BYOFlMMwTjpEhdRTGVmTYKzZW5zF5DVcU8tyFdNXUb+UyVlgkxm8iWIr6qYwaRfMpwNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457339; c=relaxed/simple;
	bh=UKKs11r13z4kTGF1M3bZdVMVFlngahg5VKrGTVkQ8oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pC7EWha1CEw07S2riOBMBv7PwVQyQLRGJ6Gq4BRndv02M9r3WvRyC9zFIoI+ACq8yHy4f0GbCM+hyLRMK4iiM6kXxw9e2czZhfB+n++2OhSYM1TEJx8snLu1fKdfHfkNfxl0Ewr6+dE4Y0YuUXuCoBpmnO4YyGr26PXB7U/gnfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdhbhWme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED699C116C6;
	Mon, 26 Jan 2026 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457338;
	bh=UKKs11r13z4kTGF1M3bZdVMVFlngahg5VKrGTVkQ8oo=;
	h=From:To:Cc:Subject:Date:From;
	b=UdhbhWmerPgUinuvkYpZ8hlqZl7QhF3wqM8kPl1lIRZA2xySXmPlthvu5rqqKqHL+
	 CQHY8DbkE8BvMlHk2s7xeJz3i9QcytI4J2LddjVWG89u66T85A9VgSRWIAqoKEo/gx
	 e/7fq/Bq4kur7iWX6hZyb84ku4j1I3nxK1/ljt3gXbaDL0PN4WDYJP4zuGqJwF4kxi
	 YF2HShZc8bO7Fi3Xxu/BHOQSzAweu+41F7R5MDP1SQaI4lYYyvGQlg0ssIFmYF7tpF
	 tbCRSwy40s2McIv6MgYR5uXczlenhxSR64m22p5pBMJxrzulMlQAzN0A3Q3vrbvzm2
	 /bgVq1vvwhfxQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 00/14] Clarify module API boundaries
Date: Mon, 26 Jan 2026 14:55:21 -0500
Message-ID: <20260126195535.154697-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18493-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 62B7E8CCCE
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
 include/linux/lockd/bind.h          |  25 +++---
 include/linux/lockd/debug.h         |  40 ----------
 26 files changed, 367 insertions(+), 264 deletions(-)
 rename {include/linux => fs}/lockd/lockd.h (85%)
 rename {include/linux => fs}/lockd/nlm.h (91%)
 rename {include/linux => fs}/lockd/share.h (85%)
 rename {include/linux => fs}/lockd/xdr.h (91%)
 rename {include/linux => fs}/lockd/xdr4.h (80%)
 delete mode 100644 include/linux/lockd/debug.h

-- 
2.52.0


