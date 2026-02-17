Return-Path: <linux-nfs+bounces-19012-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIKXDFnnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19012-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:10:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80331151593
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E2730804E6
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127DE3148AC;
	Tue, 17 Feb 2026 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw8GXgMT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B0C313525
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366070; cv=none; b=DvkC4FV7rkvhcHRsBPnAsF3svjyXl1zPp2V7srs+ub5EIYmd1XJ4ZatluhPId3muepjLIYdil3g6eIibJlEC3tQ+gX7yowYeGlGz/38Of1kVIjZbzjDfoQgmxqUPsIKNCZhtUxq6JY/Onvjz62mw+XF/2PUfRmbPd6WjwPXveM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366070; c=relaxed/simple;
	bh=m186EA6r1DMHUo/5o17gOl0stnorsGUxyT4GCBWPawo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmjbUgw/G81kFleSSvZLpFDCpFEleGXjsDf8F+ZrQNNFYtsfoZbR2ZIH3vqMO6AIDUnFUSSSlYiJImcs3Varf9O0QaAjcuoAIRJy269EHDEcLqQfi4lfRpv5L/ldWPGPPF1nyHEUc0ZT4EUg7bFJATMWQCdQVunHiyiKiLH+39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw8GXgMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3889CC19423;
	Tue, 17 Feb 2026 22:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366069;
	bh=m186EA6r1DMHUo/5o17gOl0stnorsGUxyT4GCBWPawo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jw8GXgMTe+V6XZ4y+yUO9effZk1T+mNn20CGrre1dvyKINCW461FRfMlGP67kvXmy
	 nIh9D+9Q9ARJbSZr1pXcW6YxtWSjGoliVYNlxFkFJJT29c+s1vhDZs9fUAQIjvi4xe
	 aMuinTdmJlVTcSa6ua9FQ3mC7pAnReZLOdXaW9T0kYLPnVxnB6ZZ1MhIwkPEOn3Gc0
	 zfdoXOgP4RAoXcEJUDu+seCsT3K1qOXdsBUcsd70dTKNnPNDsCSCwhryoxGgEswi+G
	 WvqfG1kISFMBQR6J7dDiRg2n4RswCQG0oEH5+xkD6+cRfT34Pm0Whd+aB6wqlGrTdy
	 kmmemYAkM8dWw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 29/29] lockd: Remove dead code from fs/lockd/xdr4.c
Date: Tue, 17 Feb 2026 17:07:21 -0500
Message-ID: <20260217220721.1928847-30-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-19012-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uio.no:email]
X-Rspamd-Queue-Id: 80331151593
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Now that all NLMv4 server-side procedures use XDR encoder and
decoder functions generated by xdrgen, the hand-written code in
fs/lockd/xdr4.c is no longer needed. This file contained the
original XDR processing logic that has been systematically
replaced throughout this series.

Remove the file and its Makefile reference to eliminate the
dead code. The helper function nlm4svc_set_file_lock_range()
is still needed by the generated code, so move it to xdr4.h
as an inline function where it remains accessible.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/Makefile   |   2 +-
 fs/lockd/clnt4xdr.c |   2 -
 fs/lockd/lockd.h    |   7 +
 fs/lockd/svc4proc.c |   1 -
 fs/lockd/xdr4.c     | 334 --------------------------------------------
 fs/lockd/xdr4.h     |  33 -----
 6 files changed, 8 insertions(+), 371 deletions(-)
 delete mode 100644 fs/lockd/xdr4.c
 delete mode 100644 fs/lockd/xdr4.h

diff --git a/fs/lockd/Makefile b/fs/lockd/Makefile
index 8e9d18a4348c..808f0f2a7be1 100644
--- a/fs/lockd/Makefile
+++ b/fs/lockd/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_LOCKD) += lockd.o
 
 lockd-y := clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
 	   svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o netlink.o
-lockd-$(CONFIG_LOCKD_V4) += clnt4xdr.o xdr4.o svc4proc.o nlm4xdr_gen.o
+lockd-$(CONFIG_LOCKD_V4) += clnt4xdr.o svc4proc.o nlm4xdr_gen.o
 lockd-$(CONFIG_PROC_FS) += procfs.o
 
 #
diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index c09e67765cac..2058733eacf8 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -18,8 +18,6 @@
 
 #include <uapi/linux/nfs3.h>
 
-#include "xdr4.h"
-
 #define NLMDBG_FACILITY		NLMDBG_XDR
 
 #if (NLMCLNT_OHSIZE > XDR_MAX_NETOBJ)
diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index ad4c6701b64a..a7c85ab6d4b5 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -52,6 +52,13 @@
  */
 #define LOCKD_DFLT_TIMEO	10
 
+/* error codes new to NLMv4 */
+#define	nlm4_deadlock		cpu_to_be32(NLM_DEADLCK)
+#define	nlm4_rofs		cpu_to_be32(NLM_ROFS)
+#define	nlm4_stale_fh		cpu_to_be32(NLM_STALE_FH)
+#define	nlm4_fbig		cpu_to_be32(NLM_FBIG)
+#define	nlm4_failed		cpu_to_be32(NLM_FAILED)
+
 /*
  * Internal-use status codes, not to be placed on the wire.
  * Version handlers translate these to appropriate wire values.
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 4044459b7c49..5de41e249534 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -24,7 +24,6 @@
 
 #include "share.h"
 #include "nlm4xdr_gen.h"
-#include "xdr4.h"
 
 /*
  * Wrapper structures combine xdrgen types with legacy nlm_lock.
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
deleted file mode 100644
index 308aac92a94e..000000000000
--- a/fs/lockd/xdr4.c
+++ /dev/null
@@ -1,334 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/fs/lockd/xdr4.c
- *
- * XDR support for lockd and the lock client.
- *
- * Copyright (C) 1995, 1996 Olaf Kirch <okir@monad.swb.de>
- * Copyright (C) 1999, Trond Myklebust <trond.myklebust@fys.uio.no>
- */
-
-#include <linux/types.h>
-#include <linux/sched.h>
-#include <linux/nfs.h>
-
-#include <linux/sunrpc/xdr.h>
-#include <linux/sunrpc/clnt.h>
-#include <linux/sunrpc/svc.h>
-#include <linux/sunrpc/stats.h>
-
-#include "lockd.h"
-#include "svcxdr.h"
-#include "xdr4.h"
-
-static inline s64
-loff_t_to_s64(loff_t offset)
-{
-	s64 res;
-	if (offset > NLM4_OFFSET_MAX)
-		res = NLM4_OFFSET_MAX;
-	else if (offset < -NLM4_OFFSET_MAX)
-		res = -NLM4_OFFSET_MAX;
-	else
-		res = offset;
-	return res;
-}
-
-/*
- * NLM file handles are defined by specification to be a variable-length
- * XDR opaque no longer than 1024 bytes. However, this implementation
- * limits their length to the size of an NFSv3 file handle.
- */
-static bool
-svcxdr_decode_fhandle(struct xdr_stream *xdr, struct nfs_fh *fh)
-{
-	__be32 *p;
-	u32 len;
-
-	if (xdr_stream_decode_u32(xdr, &len) < 0)
-		return false;
-	if (len > NFS_MAXFHSIZE)
-		return false;
-
-	p = xdr_inline_decode(xdr, len);
-	if (!p)
-		return false;
-	fh->size = len;
-	memcpy(fh->data, p, len);
-	memset(fh->data + len, 0, sizeof(fh->data) - len);
-
-	return true;
-}
-
-static bool
-svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
-{
-	struct file_lock *fl = &lock->fl;
-
-	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-		return false;
-	if (!svcxdr_decode_fhandle(xdr, &lock->fh))
-		return false;
-	if (!svcxdr_decode_owner(xdr, &lock->oh))
-		return false;
-	if (xdr_stream_decode_u32(xdr, &lock->svid) < 0)
-		return false;
-	if (xdr_stream_decode_u64(xdr, &lock->lock_start) < 0)
-		return false;
-	if (xdr_stream_decode_u64(xdr, &lock->lock_len) < 0)
-		return false;
-
-	locks_init_lock(fl);
-	fl->c.flc_type  = F_RDLCK;
-	lockd_set_file_lock_range4(fl, lock->lock_start, lock->lock_len);
-	return true;
-}
-
-static bool
-svcxdr_encode_holder(struct xdr_stream *xdr, const struct nlm_lock *lock)
-{
-	const struct file_lock *fl = &lock->fl;
-	s64 start, len;
-
-	/* exclusive */
-	if (xdr_stream_encode_bool(xdr, fl->c.flc_type != F_RDLCK) < 0)
-		return false;
-	if (xdr_stream_encode_u32(xdr, lock->svid) < 0)
-		return false;
-	if (!svcxdr_encode_owner(xdr, &lock->oh))
-		return false;
-	start = loff_t_to_s64(fl->fl_start);
-	if (fl->fl_end == OFFSET_MAX)
-		len = 0;
-	else
-		len = loff_t_to_s64(fl->fl_end - fl->fl_start + 1);
-	if (xdr_stream_encode_u64(xdr, start) < 0)
-		return false;
-	if (xdr_stream_encode_u64(xdr, len) < 0)
-		return false;
-
-	return true;
-}
-
-static bool
-svcxdr_encode_testrply(struct xdr_stream *xdr, const struct nlm_res *resp)
-{
-	if (!svcxdr_encode_stats(xdr, resp->status))
-		return false;
-	switch (resp->status) {
-	case nlm_lck_denied:
-		if (!svcxdr_encode_holder(xdr, &resp->lock))
-			return false;
-	}
-
-	return true;
-}
-
-
-/*
- * Decode Call arguments
- */
-
-bool
-nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	return true;
-}
-
-bool
-nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	u32 exclusive;
-
-	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return false;
-	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return false;
-	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return false;
-	if (exclusive)
-		argp->lock.fl.c.flc_type = F_WRLCK;
-
-	return true;
-}
-
-bool
-nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	u32 exclusive;
-
-	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return false;
-	if (xdr_stream_decode_bool(xdr, &argp->block) < 0)
-		return false;
-	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return false;
-	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return false;
-	if (exclusive)
-		argp->lock.fl.c.flc_type = F_WRLCK;
-	if (xdr_stream_decode_bool(xdr, &argp->reclaim) < 0)
-		return false;
-	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return false;
-	argp->monitor = 1;		/* monitor client by default */
-
-	return true;
-}
-
-bool
-nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	u32 exclusive;
-
-	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return false;
-	if (xdr_stream_decode_bool(xdr, &argp->block) < 0)
-		return false;
-	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return false;
-	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return false;
-	if (exclusive)
-		argp->lock.fl.c.flc_type = F_WRLCK;
-
-	return true;
-}
-
-bool
-nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-
-	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return false;
-	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return false;
-	argp->lock.fl.c.flc_type = F_UNLCK;
-
-	return true;
-}
-
-bool
-nlm4svc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct nlm_res *resp = rqstp->rq_argp;
-
-	if (!svcxdr_decode_cookie(xdr, &resp->cookie))
-		return false;
-	if (!svcxdr_decode_stats(xdr, &resp->status))
-		return false;
-
-	return true;
-}
-
-bool
-nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct nlm_reboot *argp = rqstp->rq_argp;
-	__be32 *p;
-	u32 len;
-
-	if (xdr_stream_decode_u32(xdr, &len) < 0)
-		return false;
-	if (len > SM_MAXSTRLEN)
-		return false;
-	p = xdr_inline_decode(xdr, len);
-	if (!p)
-		return false;
-	argp->len = len;
-	argp->mon = (char *)p;
-	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return false;
-	p = xdr_inline_decode(xdr, SM_PRIV_SIZE);
-	if (!p)
-		return false;
-	memcpy(&argp->priv.data, p, sizeof(argp->priv.data));
-
-	return true;
-}
-
-bool
-nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_lock	*lock = &argp->lock;
-
-	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return false;
-	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-		return false;
-	if (!svcxdr_decode_fhandle(xdr, &lock->fh))
-		return false;
-	if (!svcxdr_decode_owner(xdr, &lock->oh))
-		return false;
-	/* XXX: Range checks are missing in the original code */
-	if (xdr_stream_decode_u32(xdr, &argp->fsm_mode) < 0)
-		return false;
-	if (xdr_stream_decode_u32(xdr, &argp->fsm_access) < 0)
-		return false;
-
-	return true;
-}
-
-bool
-nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_lock	*lock = &argp->lock;
-
-	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-		return false;
-	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return false;
-
-	return true;
-}
-
-
-/*
- * Encode Reply results
- */
-
-bool
-nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	return true;
-}
-
-bool
-nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct nlm_res *resp = rqstp->rq_resp;
-
-	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
-		svcxdr_encode_testrply(xdr, resp);
-}
-
-bool
-nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct nlm_res *resp = rqstp->rq_resp;
-
-	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
-		svcxdr_encode_stats(xdr, resp->status);
-}
-
-bool
-nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct nlm_res *resp = rqstp->rq_resp;
-
-	if (!svcxdr_encode_cookie(xdr, &resp->cookie))
-		return false;
-	if (!svcxdr_encode_stats(xdr, resp->status))
-		return false;
-	/* sequence */
-	if (xdr_stream_encode_u32(xdr, 0) < 0)
-		return false;
-
-	return true;
-}
diff --git a/fs/lockd/xdr4.h b/fs/lockd/xdr4.h
deleted file mode 100644
index 4ddf51a2e0ea..000000000000
--- a/fs/lockd/xdr4.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * XDR types for the NLM protocol
- *
- * Copyright (C) 1996 Olaf Kirch <okir@monad.swb.de>
- */
-
-#ifndef _LOCKD_XDR4_H
-#define _LOCKD_XDR4_H
-
-/* error codes new to NLMv4 */
-#define	nlm4_deadlock		cpu_to_be32(NLM_DEADLCK)
-#define	nlm4_rofs		cpu_to_be32(NLM_ROFS)
-#define	nlm4_stale_fh		cpu_to_be32(NLM_STALE_FH)
-#define	nlm4_fbig		cpu_to_be32(NLM_FBIG)
-#define	nlm4_failed		cpu_to_be32(NLM_FAILED)
-
-bool	nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-
-bool	nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-
-#endif /* _LOCKD_XDR4_H */
-- 
2.53.0


