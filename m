Return-Path: <linux-nfs+bounces-18500-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IVzE9DGd2nckgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18500-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:56:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DB18CD01
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93771302B386
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7DF28BAB9;
	Mon, 26 Jan 2026 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3vcW4qJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FA28A72F
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457344; cv=none; b=tl3OZdaEOQMq3q3PGXpwpWSlCH0qV4p9sKaxZ4EokMeMp/ddR+tRmfbQ2NDZtahrboNMlgDi9bAap4CISefWqZIUu6lQXiNiNTZM2QwYfCQoBrce53gs2J4LMjewvjj0gA/qNzIZayp0UqLaA9L42i0qqMcgh8kb6qXvu8N1KdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457344; c=relaxed/simple;
	bh=kT7i5WgDfCwbWQ8qJ7eWsnaOm7l1ZyRb6z1kYgaNEcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dl0IWbymc5e9Vbq8sIPb4Y5xM9x2xPrv++7eXynb2imgvZ5sB97yB1ygS+mEmifOzT+YP6knlNdOb2OGOnb5NuZfM/3rPqt0ZVeVvfttfDtgh+DfiQdzaF9oH9D9ibhIEX/Xhm3zdlE6o37F9NxTRF9WrAeDxJ3uW+bcbxm/fvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3vcW4qJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68929C19425;
	Mon, 26 Jan 2026 19:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457344;
	bh=kT7i5WgDfCwbWQ8qJ7eWsnaOm7l1ZyRb6z1kYgaNEcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e3vcW4qJc98EJTggM4ywdJue+WF5626PQZ8pPi3Brt4EQ2MY/wpMsAsuvYPluZN1D
	 5PSmbAtb/M812XAqyricK6t37XEtNKapV3ok41y0T+OuHpYEqdxAv5ll2MNiFxTbKP
	 niFd2S0Y0rkWTHMX58RsIMgsRYKIu/4fg70jyDuTGHvz70jggz8dvvlEzXLWdStQf0
	 WI5F0N9tmsuZslAXoJkEwIDGREUN3fWNn+sg9MAIb6CsVHUjZAIOqYhCE+d+Ci1Csy
	 3MACCA+sFKA7xeiZm2OjENAw601xyjhlHfWZFyGnEPCNvU1bU+uMrd7tVJWNVXFkWV
	 5/DsT/yzloBIg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 07/14] lockd: Move xdr4.h from include/linux/lockd/ to fs/lockd/
Date: Mon, 26 Jan 2026 14:55:28 -0500
Message-ID: <20260126195535.154697-8-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126195535.154697-1-cel@kernel.org>
References: <20260126195535.154697-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18500-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,swb.de:email]
X-Rspamd-Queue-Id: D3DB18CD01
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The xdr4.h header declares NLMv4-specific XDR encoder/decoder
functions and error codes that are used exclusively within the
lockd subsystem. Moving it from include/linux/lockd/ to fs/lockd/
clarifies the intended scope of these declarations and prevents
external code from depending on lockd-internal interfaces.

This change reduces the public API surface of the lockd module
and makes it easier to refactor NLMv4 internals without risk of
breaking out-of-tree consumers. The header's contents are
implementation details of the NLMv4 wire protocol handling, not
a contract with other kernel subsystems.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/clnt4xdr.c                |  2 ++
 fs/lockd/svc4proc.c                |  2 ++
 fs/lockd/xdr4.c                    |  1 +
 {include/linux => fs}/lockd/xdr4.h | 15 +++------------
 include/linux/lockd/bind.h         |  3 ---
 include/linux/lockd/lockd.h        |  7 ++++---
 6 files changed, 12 insertions(+), 18 deletions(-)
 rename {include/linux => fs}/lockd/xdr4.h (84%)

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 527458db4525..23896073c7e5 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -17,6 +17,8 @@
 
 #include <uapi/linux/nfs3.h>
 
+#include "xdr4.h"
+
 #define NLMDBG_FACILITY		NLMDBG_XDR
 
 #if (NLMCLNT_OHSIZE > XDR_MAX_NETOBJ)
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 4ceb27cc72e4..51d072a83a49 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -14,6 +14,8 @@
 #include <linux/lockd/share.h>
 #include <linux/sunrpc/svc_xprt.h>
 
+#include "xdr4.h"
+
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
 /*
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index e343c820301f..5b1e15977697 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -19,6 +19,7 @@
 #include <linux/lockd/lockd.h>
 
 #include "svcxdr.h"
+#include "xdr4.h"
 
 static inline s64
 loff_t_to_s64(loff_t offset)
diff --git a/include/linux/lockd/xdr4.h b/fs/lockd/xdr4.h
similarity index 84%
rename from include/linux/lockd/xdr4.h
rename to fs/lockd/xdr4.h
index 72831e35dca3..7be318c0512b 100644
--- a/include/linux/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -1,19 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * linux/include/linux/lockd/xdr4.h
- *
  * XDR types for the NLM protocol
  *
  * Copyright (C) 1996 Olaf Kirch <okir@monad.swb.de>
  */
 
-#ifndef LOCKD_XDR4_H
-#define LOCKD_XDR4_H
-
-#include <linux/fs.h>
-#include <linux/nfs.h>
-#include <linux/sunrpc/xdr.h>
-#include <linux/lockd/xdr.h>
+#ifndef _LOCKD_XDR4_H
+#define _LOCKD_XDR4_H
 
 /* error codes new to NLMv4 */
 #define	nlm4_deadlock		cpu_to_be32(NLM_DEADLCK)
@@ -38,6 +31,4 @@ bool	nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-extern const struct rpc_version nlm_version4;
-
-#endif /* LOCKD_XDR4_H */
+#endif /* _LOCKD_XDR4_H */
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index 39c124dcb19c..077da0696f12 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -13,9 +13,6 @@
 #include <linux/lockd/nlm.h>
 /* need xdr-encoded error codes too, so... */
 #include <linux/lockd/xdr.h>
-#ifdef CONFIG_LOCKD_V4
-#include <linux/lockd/xdr4.h>
-#endif
 
 /* Dummy declarations */
 struct svc_rqst;
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 0d883f48ec21..46f244141645 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -22,9 +22,6 @@
 #include <linux/utsname.h>
 #include <linux/lockd/bind.h>
 #include <linux/lockd/xdr.h>
-#ifdef CONFIG_LOCKD_V4
-#include <linux/lockd/xdr4.h>
-#endif
 #include <linux/lockd/debug.h>
 #include <linux/sunrpc/svc.h>
 
@@ -235,6 +232,10 @@ int		  nlmclnt_reclaim(struct nlm_host *, struct file_lock *,
 				  struct nlm_rqst *);
 void		  nlmclnt_next_cookie(struct nlm_cookie *);
 
+#ifdef CONFIG_LOCKD_V4
+extern const struct rpc_version nlm_version4;
+#endif
+
 /*
  * Host cache
  */
-- 
2.52.0


