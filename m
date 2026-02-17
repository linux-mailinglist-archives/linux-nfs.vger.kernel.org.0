Return-Path: <linux-nfs+bounces-19010-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBFHB1HnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19010-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:10:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4815151585
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 227AE307C4A7
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C80313547;
	Tue, 17 Feb 2026 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlUOPIzL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBD313525
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366068; cv=none; b=NTV4plXfDdsFqdowqS32Fsu+lcNtWWpiXA4UXxq6DWKy7Nmre96UvkAtzZbk9lMGhqDo9vYo8qz5L+ZpkiEXH6zqlQ4v5JH7NGRTgkSjxtxTJ3cTlWCmrfNmM4+g/ZQ4jkbtwJlxmADmEBPZIXZzOZEviNPxrUzf3FiF6TaC/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366068; c=relaxed/simple;
	bh=3p2HDtjpwK9JkbjiFgr0GI4hZa/XqYnb9gMWRE2WOKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQif/gPX/m4/YOX03jsFSic095RZV5Ij2GfC1WkknRlayQwslkNzm22RtiP23Qpg9O+Y9xA4p4U0si+sZ4aKdKS5cBNGLmUwiWmAtnnqFel6Ji9c4mTENfYccwZ5oxJmRLOa/nMTZm0d3vJ9+VzJGLRoYqoYAv0Au1+EIyOyv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlUOPIzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9670FC19423;
	Tue, 17 Feb 2026 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366068;
	bh=3p2HDtjpwK9JkbjiFgr0GI4hZa/XqYnb9gMWRE2WOKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UlUOPIzLavEPL4TiU1SJ2tLm69XD/0c9CKIcv+A7lAIwZJOteS41H6J05vKFIh1uw
	 oqdW8bcSC4y1yxYyEvTbLjlRF+LkQCfCfufuOPorePxCwJqGYOmeHNOPIT/jWLjEGm
	 PqH5E0otv9EEwLf8EnS7dMJR74cBYJXYfCKFgvFA7xVjQ4ZNDSk1Tmfnug+cBFU/8f
	 dk5U3tduD+CVH8HmlKN2sh/DILoeyspWhWsYi3RHoBI41GlilQRX4t7nbCuQ9vBTlz
	 J69F4c9bEvI5ajVzgVMPI9/YWG+b6wqUfYd+bvrjeQOJsxcHVafrXvqBzKP8AnTglA
	 O0TcuUwmf7xtg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 27/29] lockd: Add LOCKD_SHARE_SVID constant for DOS sharing mode
Date: Tue, 17 Feb 2026 17:07:19 -0500
Message-ID: <20260217220721.1928847-28-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217220721.1928847-1-cel@kernel.org>
References: <20260217220721.1928847-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-19010-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4815151585
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Replace the magic value ~(u32)0 with a named constant. This value
is used as a synthetic svid when looking up lockowners for DOS
share operations, which have no real process ID associated with
them.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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
index ca0409ea6b2d..ce340ea0d304 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -985,7 +985,7 @@ static __be32 nlm4svc_proc_share(struct svc_rqst *rqstp)
 	struct nlm4_lock xdr_lock = {
 		.fh		= argp->xdrgen.share.fh,
 		.oh		= argp->xdrgen.share.oh,
-		.svid		= ~(u32)0,
+		.svid		= LOCKD_SHARE_SVID,
 	};
 
 	resp->xdrgen.cookie = argp->xdrgen.cookie;
@@ -1051,7 +1051,7 @@ static __be32 nlm4svc_proc_unshare(struct svc_rqst *rqstp)
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
2.53.0


