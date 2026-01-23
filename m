Return-Path: <linux-nfs+bounces-18401-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCCkDQbEc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18401-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:55:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D798979DD8
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5282305222D
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CB829B8E5;
	Fri, 23 Jan 2026 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm1UJI0O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F359623182D
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194415; cv=none; b=lmqYrickMTVBVBYxacKmnCyL9i3OtWkBS1IxSCToz2Oq6cA3WJfU7E4Muqq7ISIpFCPnsC/1zvWvIsojbShIvsNurcD4WVQjhYfDOgkgTZ5zZQVokz86ERmNyiS2Sy5lUAHNWBPDruA+HBI7KfTlYq1VgPpfvbxHMN65GAEsxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194415; c=relaxed/simple;
	bh=ecJ6wCLsewox5ms3HgcJTkN3M/oC9ReY4GzfrBDtiJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ta0ygMXpSwmChsfGCr1JTgZZ/EM5v+dz/HP1LKAGB5c9Yx+WL3KhHH2XHk+tfot++vL2fJhj/634BA/Rz4LJVBUYRsTOTWhr3wYegTvfe8pV5+/DrGS36G+TtHGAS+3D0PHbTQR/WA/zBRnaUjyGvd7kWjMV2KmXjce3P8DviUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm1UJI0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8BAC116D0;
	Fri, 23 Jan 2026 18:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194414;
	bh=ecJ6wCLsewox5ms3HgcJTkN3M/oC9ReY4GzfrBDtiJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tm1UJI0OSZ3EPLF0jrBXS2bElF64lYL9VP5LNO5//CTkotJSjldsN3JDuPfaKYhWd
	 /gKgbxHJYUm4s5eXcPUxPZFwlsSj6YG5UFfGFChyPnDkC1TPtE1dh2c2CaHksV9aep
	 v82QpL6vPR7jdMctV/gGJFnVEO73tID6D44V3dA8QGiFO3QlMFv+SIS1cytXAfNOo/
	 wzYQdvZE0NiceglVKHYvPxO9S+RElnOMkEBaESI96qXj52lCgjVz0kXi8aeY/isRa9
	 GBt9FHtN7KJDtiZVFBKnHDfFfHhRmU/Ury/0IAo0/jwFDNZsNguFaUKAKo2W/cWt9i
	 EJAaZFATBMmjQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 40/42] lockd: Add LOCKD_SHARE_SVID constant for DOS sharing mode
Date: Fri, 23 Jan 2026 13:52:57 -0500
Message-ID: <20260123185259.1215767-41-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123185259.1215767-1-cel@kernel.org>
References: <20260123185259.1215767-1-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18401-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D798979DD8
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Replace the magic value ~(u32)0 with a named constant. This value
is used as a synthetic svid when looking up lockowners for DOS
share operations, which have no real process ID associated with
them.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/share.h    | 3 +++
 fs/lockd/svc4proc.c | 4 ++--
 fs/lockd/xdr.c      | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/lockd/share.h b/fs/lockd/share.h
index a2867e30c593..20ea8ee49168 100644
--- a/fs/lockd/share.h
+++ b/fs/lockd/share.h
@@ -8,6 +8,9 @@
 #ifndef _LOCKD_SHARE_H
 #define _LOCKD_SHARE_H
 
+/* Synthetic svid for lockowner lookup during share operations */
+#define LOCKD_SHARE_SVID	(~(u32)0)
+
 /*
  * DOS share for a specific file
  */
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 6b1a80084d1a..3c50bd18c45a 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -982,7 +982,7 @@ static __be32 nlm4svc_proc_share(struct svc_rqst *rqstp)
 	struct nlm4_lock xdr_lock = {
 		.fh		= argp->xdrgen.share.fh,
 		.oh		= argp->xdrgen.share.oh,
-		.svid		= ~(u32)0,
+		.svid		= LOCKD_SHARE_SVID,
 	};
 
 	resp->xdrgen.cookie = argp->xdrgen.cookie;
@@ -1048,7 +1048,7 @@ static __be32 nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 	struct nlm4_lock xdr_lock = {
 		.fh		= argp->xdrgen.share.fh,
 		.oh		= argp->xdrgen.share.oh,
-		.svid		= ~(u32)0,
+		.svid		= LOCKD_SHARE_SVID,
 	};
 	struct nlm_host	*host = NULL;
 	struct nlm_file	*file = NULL;
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 5aac49d1875a..dfca8b8dab73 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -19,6 +19,7 @@
 #include <uapi/linux/nfs2.h>
 
 #include "lockd.h"
+#include "share.h"
 #include "svcxdr.h"
 
 static inline loff_t
@@ -274,7 +275,7 @@ nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 
 	memset(lock, 0, sizeof(*lock));
 	locks_init_lock(&lock->fl);
-	lock->svid = ~(u32)0;
+	lock->svid = LOCKD_SHARE_SVID;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
 		return false;
-- 
2.52.0


