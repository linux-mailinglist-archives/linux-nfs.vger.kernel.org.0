Return-Path: <linux-nfs+bounces-17224-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9493CCD822
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2142305C81D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9672D877D;
	Thu, 18 Dec 2025 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcnZ1T4n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CAE2D8DA8
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088858; cv=none; b=ad/QvurIUCyGLSt5UM4CJo/la3IKXwg6bbIZZluCgHYaU9+YpapKOdzv3o+koXN5Y80Z1poH0SYE7XGVZSdn1VPlQQRIurjtKCQBnlGBOq36IHqVvj++qmtWWV2KgJr6yUAK8nHFpPSdr/21FiDtJEey0TmV8iPpjdcImvkiXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088858; c=relaxed/simple;
	bh=z58CuNbDHHd2WhXCRR38SYCANzaoXTmhD8jbLY8IZTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peIskg96xyX8K4GpDGcsmUEJOUSdWLF9Iiexmuar1j+7kqcSLIZWCX0ojVkz5NsPLsd0dCjxYqtDxABJqzrvxcXdK6C0MRP/BknZ7dYLeL2ciUBecip8Gj9WMgc3SzZz/Jzb2JS1yXqwkFquoENQBHgrQmt1boquyQLD35FaqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcnZ1T4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7E8C19423;
	Thu, 18 Dec 2025 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088858;
	bh=z58CuNbDHHd2WhXCRR38SYCANzaoXTmhD8jbLY8IZTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BcnZ1T4nOnlAsVDJxexH2/IJAp2PqM6QjiC4m/pS/kNQ9T9qkaxR4orFOeHzkS4na
	 uSsdUb7zt6Lmm++ofrjtYCHV2ZLdAWGMCT3TRdXkxIG1IsRytyzzsKFGe8jpg6/Gdo
	 5H2MUYipDsJJWcL116wsdnpLbhPjBsahNQER8qfoA2+WgKgyDTPZzpCiUzk1fm9Gp9
	 Em1hElxeXqG/DTGG8GzEY5H/cNb9V/3cJ+YEcVAYZinQXhVBRXHbcgJaq5ZbHd5SKG
	 3QaqFYuLnt2+jkX5bdTvHkkExXaqIYOB/HRCupfHaYShcjrOJATa8Fj4Xew4sVnjQp
	 8q+0i7mTaxJVg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 36/36] lockd: Remove dead code from fs/lockd/xdr4.c
Date: Thu, 18 Dec 2025 15:13:46 -0500
Message-ID: <20251218201346.1190928-37-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/Makefile |   2 +-
 fs/lockd/xdr4.c   | 345 ----------------------------------------------
 fs/lockd/xdr4.h   |  25 ++--
 3 files changed, 12 insertions(+), 360 deletions(-)
 delete mode 100644 fs/lockd/xdr4.c

diff --git a/fs/lockd/Makefile b/fs/lockd/Makefile
index e1e49ff2f766..60fa69b6658e 100644
--- a/fs/lockd/Makefile
+++ b/fs/lockd/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_LOCKD) += lockd.o
 
 lockd-y := clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
 	   svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o netlink.o
-lockd-$(CONFIG_LOCKD_V4) += clnt4xdr.o xdr4.o svc4proc.o nlm4xdr_gen.o
+lockd-$(CONFIG_LOCKD_V4) += clnt4xdr.o svc4proc.o nlm4xdr_gen.o
 lockd-$(CONFIG_PROC_FS) += procfs.o
 
 .PHONY: xdrgen
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
deleted file mode 100644
index 57d513879ddf..000000000000
--- a/fs/lockd/xdr4.c
+++ /dev/null
@@ -1,345 +0,0 @@
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
-void nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 len)
-{
-	s64 end = off + len - 1;
-
-	fl->fl_start = off;
-	if (len == 0 || end < 0)
-		fl->fl_end = OFFSET_MAX;
-	else
-		fl->fl_end = end;
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
-	nlm4svc_set_file_lock_range(fl, lock->lock_start, lock->lock_len);
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
index b08e35abbd5d..dc0f528da180 100644
--- a/fs/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -8,6 +8,7 @@
 #ifndef _LOCKD_XDR4_H
 #define _LOCKD_XDR4_H
 
+#include <linux/filelock.h>
 #include <linux/sunrpc/xdrgen/nlm4.h>
 
 /* error codes new to NLMv4 */
@@ -86,21 +87,17 @@ struct nlm4_shareres_wrapper {
 
 static_assert(offsetof(struct nlm4_shareres_wrapper, xdrgen) == 0);
 
-void	nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 len);
-bool	nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+static inline void
+nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 len)
+{
+	s64 end = off + len - 1;
 
-bool	nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+	fl->fl_start = off;
+	if (len == 0 || end < 0)
+		fl->fl_end = OFFSET_MAX;
+	else
+		fl->fl_end = end;
+}
 
 extern const struct rpc_version nlm_version4;
 
-- 
2.52.0


