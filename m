Return-Path: <linux-nfs+bounces-18574-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OUcIU4peml/3gEAu9opvQ
	(envelope-from <linux-nfs+bounces-18574-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:20:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3B6A3AD8
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A2E8302E855
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 15:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C0736BCFA;
	Wed, 28 Jan 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzswNVmQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500DB36BCCE
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613584; cv=none; b=k6PfEqIG0kBDGx7HsBW5THb53Ke3YR3OOXqZudp64IdoVpk7wcw/qrOyKBan/9bxYCpaISd2F+8hNG4BJtkc7yvSIhYXVeRw/qU3xGPYmFuFDG1ArK9mRI+CNd+KaSbnLLkF6HVLJDHI4AeFmSKeeeBJRbyqjhiw3Z4+xGcM23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613584; c=relaxed/simple;
	bh=AvcIQtXptvlkEV7bDS03Ps0J7MwSfIx9DLMdyrspvrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDTeQ1zy6ckOU+mQ4PnDpqRoiJZm6BBZg/8JFvn847rs538CEO7sqhf9k8lRfRI0wrqRCGZfZRlV9e/AlDhdb5q08MaF06SP/HQhbObMlnEh8X3QsNzSAwNiz74BG1VydJR+gBtt1krNP4I5oJiHp/qfVEaR6FbUfh/vp9YxLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzswNVmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661B5C4CEF1;
	Wed, 28 Jan 2026 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613584;
	bh=AvcIQtXptvlkEV7bDS03Ps0J7MwSfIx9DLMdyrspvrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pzswNVmQmeqQQQkwCLAC0dcehxeKy1HFeWnnSS7BMJ22alBQa7IK+vGJE3nCsTTPl
	 1VGuTzk9S68IS2iObDDkQoPK0dc8UTOwQp1Z1JMhpI3l8u812I0q9EpzfxfNKM9nOV
	 zWKLV3bK59tlvGAkZtJHxpX9Bs9C/lowEgko9i55Q0oioTO78R0Y+8yDhy/ubmAMqT
	 IO+NVPKPsmYkHQrgI/mCoYfw2xg/ITeJw+Zx8GciZY0GSNf6tzi0ix2VIp8mgmTjUb
	 cH+ct4AusMkGWR1PbEyOT5JWzqzGRaMgCxx7Fw4BM2mhKqpCIWZfbyWR1UV9ih90N8
	 aWp4vCRsoDpZg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 08/14] lockd: Move share.h from include/linux/lockd/ to fs/lockd/
Date: Wed, 28 Jan 2026 10:19:29 -0500
Message-ID: <20260128151935.1646063-9-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128151935.1646063-1-cel@kernel.org>
References: <20260128151935.1646063-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18574-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RSPAMD_EMAILBL_FAIL(0.00)[jlayton.kernel.org:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,swb.de:email]
X-Rspamd-Queue-Id: 9F3B6A3AD8
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The share.h header defines struct nlm_share and declares the DOS
share management functions used by the NLM server to implement
NLM_SHARE and NLM_UNSHARE operations. These interfaces are used
exclusively within the lockd subsystem. A git grep search confirms
no external code references them.

Relocating this header from include/linux/lockd/ to fs/lockd/
narrows the public API surface of the lockd module. Out-of-tree
code cannot depend on these internal interfaces after this change.
Future refactoring of the share management implementation thus
requires no consideration of external consumers.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 {include/linux => fs}/lockd/share.h | 8 +++-----
 fs/lockd/svc4proc.c                 | 2 +-
 fs/lockd/svcproc.c                  | 3 ++-
 fs/lockd/svcshare.c                 | 3 ++-
 fs/lockd/svcsubs.c                  | 3 ++-
 include/linux/lockd/lockd.h         | 2 ++
 6 files changed, 12 insertions(+), 9 deletions(-)
 rename {include/linux => fs}/lockd/share.h (85%)

diff --git a/include/linux/lockd/share.h b/fs/lockd/share.h
similarity index 85%
rename from include/linux/lockd/share.h
rename to fs/lockd/share.h
index 1f18a9faf645..d8f4ebd9c278 100644
--- a/include/linux/lockd/share.h
+++ b/fs/lockd/share.h
@@ -1,14 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * linux/include/linux/lockd/share.h
- *
  * DOS share management for lockd.
  *
  * Copyright (C) 1996, Olaf Kirch <okir@monad.swb.de>
  */
 
-#ifndef LINUX_LOCKD_SHARE_H
-#define LINUX_LOCKD_SHARE_H
+#ifndef _LOCKD_SHARE_H
+#define _LOCKD_SHARE_H
 
 /*
  * DOS share for a specific file
@@ -29,4 +27,4 @@ __be32	nlmsvc_unshare_file(struct nlm_host *, struct nlm_file *,
 void	nlmsvc_traverse_shares(struct nlm_host *, struct nlm_file *,
 					       nlm_host_match_fn_t);
 
-#endif /* LINUX_LOCKD_SHARE_H */
+#endif /* _LOCKD_SHARE_H */
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 51d072a83a49..da88b638d90d 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -11,9 +11,9 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/lockd/lockd.h>
-#include <linux/lockd/share.h>
 #include <linux/sunrpc/svc_xprt.h>
 
+#include "share.h"
 #include "xdr4.h"
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 272c8f36ed2a..8441fabd019f 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -11,9 +11,10 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/lockd/lockd.h>
-#include <linux/lockd/share.h>
 #include <linux/sunrpc/svc_xprt.h>
 
+#include "share.h"
+
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
 #ifdef CONFIG_LOCKD_V4
diff --git a/fs/lockd/svcshare.c b/fs/lockd/svcshare.c
index 88c81ce1148d..8e06840834c6 100644
--- a/fs/lockd/svcshare.c
+++ b/fs/lockd/svcshare.c
@@ -15,7 +15,8 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
-#include <linux/lockd/share.h>
+
+#include "share.h"
 
 static inline int
 nlm_cmp_owner(struct nlm_share *share, struct xdr_netobj *oh)
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 4186e53190ac..678b492d682e 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -16,11 +16,12 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/lockd/lockd.h>
-#include <linux/lockd/share.h>
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <uapi/linux/nfs2.h>
 
+#include "share.h"
+
 #define NLMDBG_FACILITY		NLMDBG_SVCSUBS
 
 
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 46f244141645..eebcecd12fae 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -155,6 +155,8 @@ struct nlm_rqst {
 	void *	a_callback_data; /* sent to nlmclnt_operations callbacks */
 };
 
+struct nlm_share;
+
 /*
  * This struct describes a file held open by lockd on behalf of
  * an NFS client.
-- 
2.52.0


