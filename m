Return-Path: <linux-nfs+bounces-21577-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YImILjxwA2p15wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21577-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:23:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 468935277E1
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DEF8317E8F5
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB30437F012;
	Tue, 12 May 2026 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8pRRkV/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87AE375AB1
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609672; cv=none; b=GW0umHYr60rBTbJ8wct9m/KAOPJkQ0xjnNlb0/jy8BefcDxzXzMI77E66l9v9xND1y1I2Sg3izxrYTMxo4MbEcbmeaKCSNeMLulz1itBaw0SUk6NhET7dzmJYnWW+jK3UbGoZ3ivznJb3RnbmfjM4WgW/fIO4DhhKKHfa9D/Eik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609672; c=relaxed/simple;
	bh=u1Uve6+uLs6pLQXpXpQt64FT4Bwf19zp/6/MzKY2+pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ekz1ZFOiUaKfl4MupzGgo/TQz4Co+7yK/LSKLjYXdYLMNysakM4fuwgK4dypy5GVu6AfDcLznCh1I5yXaHQU4qbxCJ+tMWwDxOHg668mAtPSJI/wtULQOQU40qOpnNpb1fqUldRuoSlWh+mHREWvF/MAlJlN/aW9QNGRKNuyDAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8pRRkV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0365C2BCF5;
	Tue, 12 May 2026 18:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609672;
	bh=u1Uve6+uLs6pLQXpXpQt64FT4Bwf19zp/6/MzKY2+pc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V8pRRkV/TepqIi8OLsz67sXbN9GWstrBs7SCypcQvIDBUe25pl33tlE9Gi+w7VoEq
	 YOAHDKKEcKJi7jEtPzpKcnQOt+5uNCQLm+kxYVsv5dJqo+VlKAL0YLWnmGu++6Lbob
	 BsHNAiIQ1aGMH5Rf5kTcV71U/bhqc8DVrRDRomJQxPpIJTk+FiWHEHgQKtYmrn09FY
	 CR8Mox5qxsm0s46tRh1LprKx2hWi880GOZ3gB9tJ3O1hFvCV+QzqSXo4SG09lHMj/t
	 Ta7E3kAMT0iERsFVxq8fwH9EcvpMfpBd9qfXpTlTNtDVvWOEQV2tbGj4e580z+7i9r
	 fNIZr8gda1log==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:12 -0400
Subject: [PATCH 37/38] lockd: Remove dead code from fs/lockd/xdr.c
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-37-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=14996;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=tw9Nux9+8dSo2W/RB6OTRY4rOFyfY8FkctGEZJh5yoo=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23nCF1DC0bTC5O37LI0JVkVpjH+EUZhtjUcv
 diwSxin7BOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5wAKCRAzarMzb2Z/
 lzlQD/sFDueknyVmu0tNOEjE1aoVso2tT6PVv0Jgz+iioQH7PB1zMsbHuQdjHMobXM6NMKlozFf
 pYTiv9L79CgpIIES1NthyC+3EaanPj0dhoNIacgWG/RZK6P+0LfONdN2FS4jv0eTY5cP9+Ds9xd
 +z3aGXci6G1gcjaFln4t4RXjavcuWgR+3O5q4VqucFDwOhGMMRcYQpgxATxG9Z4/m0Uon2gYoO6
 mp+ZekSwx061KT6iDzwYGs7WD+MigvkDgjcQupfSigS0DnxBy7Gij5dyDxYK6hH/rwygYYrytX6
 3zBJCMm1qSLurMUvS79dDiERUdnBG+jJHermpHhIUL/27Dg5asQcRMNrMpgtKBVl9a0kVxp/5tB
 gKJJrlPqsXmPw44JX/JPArc5oz7rPE4Hdrboj/Zq62RsXTDfkS0hb2yjO48cCQZYJl1qojS4xWW
 PIhn30SbMmOV5m93MKp1OrH0leVV6JsRmPfrMQYTV+iTBddbsceY3TVwk0brOXUTcmnn7oBY/8n
 eJGjGwleogwquj0OEWPTpJdkJl2m4B6ZAK2Ns+8OCXTaMTPg3YrUIfvqd5pj/bgxjJ1p9pfe258
 lk4HWlSRpz2m9afBc3djkhymUa/0hvz+iGwz6OKf0LZUCpzzF2QkmgqnvE3GaGwdMnKAOLQ6dL8
 6qEFTEe31LB97MA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 468935277E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21577-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,swb.de:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

All NLMv3 server-side procedures now dispatch through
xdrgen-generated encoder and decoder functions, leaving the
hand-written XDR processing in fs/lockd/xdr.c with no remaining
callers.

Remove fs/lockd/xdr.c, the fs/lockd/svcxdr.h header it included,
the Makefile entry, and the now-unused nlmsvc_decode_* /
nlmsvc_encode_* prototypes from fs/lockd/xdr.h. The structure
definitions and status code macros in xdr.h are retained as they
are still used by the client-side code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/Makefile |   2 +-
 fs/lockd/svcxdr.h | 142 ----------------------
 fs/lockd/xdr.c    | 354 ------------------------------------------------------
 fs/lockd/xdr.h    |  20 ---
 4 files changed, 1 insertion(+), 517 deletions(-)

diff --git a/fs/lockd/Makefile b/fs/lockd/Makefile
index 951a74e4847a..3f9569d3ba0e 100644
--- a/fs/lockd/Makefile
+++ b/fs/lockd/Makefile
@@ -8,7 +8,7 @@ ccflags-y += -I$(src)			# needed for trace events
 obj-$(CONFIG_LOCKD) += lockd.o
 
 lockd-y := clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
-	   svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o netlink.o \
+	   svcshare.o svcproc.o svcsubs.o mon.o trace.o netlink.o \
 	   nlm3xdr_gen.o
 lockd-$(CONFIG_LOCKD_V4) += clnt4xdr.o svc4proc.o nlm4xdr_gen.o
 lockd-$(CONFIG_PROC_FS) += procfs.o
diff --git a/fs/lockd/svcxdr.h b/fs/lockd/svcxdr.h
deleted file mode 100644
index 911b5fd707b1..000000000000
--- a/fs/lockd/svcxdr.h
+++ /dev/null
@@ -1,142 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Encode/decode NLM basic data types
- *
- * Basic NLMv3 XDR data types are not defined in an IETF standards
- * document.  X/Open has a description of these data types that
- * is useful.  See Chapter 10 of "Protocols for Interworking:
- * XNFS, Version 3W".
- *
- * Basic NLMv4 XDR data types are defined in Appendix II.1.4 of
- * RFC 1813: "NFS Version 3 Protocol Specification".
- *
- * Author: Chuck Lever <chuck.lever@oracle.com>
- *
- * Copyright (c) 2020, Oracle and/or its affiliates.
- */
-
-#ifndef _LOCKD_SVCXDR_H_
-#define _LOCKD_SVCXDR_H_
-
-static inline bool
-svcxdr_decode_stats(struct xdr_stream *xdr, __be32 *status)
-{
-	__be32 *p;
-
-	p = xdr_inline_decode(xdr, XDR_UNIT);
-	if (!p)
-		return false;
-	*status = *p;
-
-	return true;
-}
-
-static inline bool
-svcxdr_encode_stats(struct xdr_stream *xdr, __be32 status)
-{
-	__be32 *p;
-
-	p = xdr_reserve_space(xdr, XDR_UNIT);
-	if (!p)
-		return false;
-	*p = status;
-
-	return true;
-}
-
-static inline bool
-svcxdr_decode_string(struct xdr_stream *xdr, char **data, unsigned int *data_len)
-{
-	__be32 *p;
-	u32 len;
-
-	if (xdr_stream_decode_u32(xdr, &len) < 0)
-		return false;
-	if (len > NLM_MAXSTRLEN)
-		return false;
-	p = xdr_inline_decode(xdr, len);
-	if (!p)
-		return false;
-	*data_len = len;
-	*data = (char *)p;
-
-	return true;
-}
-
-/*
- * NLM cookies are defined by specification to be a variable-length
- * XDR opaque no longer than 1024 bytes. However, this implementation
- * limits their length to 32 bytes, and treats zero-length cookies
- * specially.
- */
-static inline bool
-svcxdr_decode_cookie(struct xdr_stream *xdr, struct lockd_cookie *cookie)
-{
-	__be32 *p;
-	u32 len;
-
-	if (xdr_stream_decode_u32(xdr, &len) < 0)
-		return false;
-	if (len > NLM_MAXCOOKIELEN)
-		return false;
-	if (!len)
-		goto out_hpux;
-
-	p = xdr_inline_decode(xdr, len);
-	if (!p)
-		return false;
-	cookie->len = len;
-	memcpy(cookie->data, p, len);
-
-	return true;
-
-	/* apparently HPUX can return empty cookies */
-out_hpux:
-	cookie->len = 4;
-	memset(cookie->data, 0, 4);
-	return true;
-}
-
-static inline bool
-svcxdr_encode_cookie(struct xdr_stream *xdr, const struct lockd_cookie *cookie)
-{
-	__be32 *p;
-
-	if (xdr_stream_encode_u32(xdr, cookie->len) < 0)
-		return false;
-	p = xdr_reserve_space(xdr, cookie->len);
-	if (!p)
-		return false;
-	memcpy(p, cookie->data, cookie->len);
-
-	return true;
-}
-
-static inline bool
-svcxdr_decode_owner(struct xdr_stream *xdr, struct xdr_netobj *obj)
-{
-	__be32 *p;
-	u32 len;
-
-	if (xdr_stream_decode_u32(xdr, &len) < 0)
-		return false;
-	if (len > XDR_MAX_NETOBJ)
-		return false;
-	p = xdr_inline_decode(xdr, len);
-	if (!p)
-		return false;
-	obj->len = len;
-	obj->data = (u8 *)p;
-
-	return true;
-}
-
-static inline bool
-svcxdr_encode_owner(struct xdr_stream *xdr, const struct xdr_netobj *obj)
-{
-	if (obj->len > XDR_MAX_NETOBJ)
-		return false;
-	return xdr_stream_encode_opaque(xdr, obj->data, obj->len) > 0;
-}
-
-#endif /* _LOCKD_SVCXDR_H_ */
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
deleted file mode 100644
index c78c64557fea..000000000000
--- a/fs/lockd/xdr.c
+++ /dev/null
@@ -1,354 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/fs/lockd/xdr.c
- *
- * XDR support for lockd and the lock client.
- *
- * Copyright (C) 1995, 1996 Olaf Kirch <okir@monad.swb.de>
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
-#include <uapi/linux/nfs2.h>
-
-#include "lockd.h"
-#include "share.h"
-#include "svcxdr.h"
-
-static inline loff_t
-s32_to_loff_t(__s32 offset)
-{
-	return (loff_t)offset;
-}
-
-static inline __s32
-loff_t_to_s32(loff_t offset)
-{
-	__s32 res;
-	if (offset >= NLM_OFFSET_MAX)
-		res = NLM_OFFSET_MAX;
-	else if (offset <= -NLM_OFFSET_MAX)
-		res = -NLM_OFFSET_MAX;
-	else
-		res = offset;
-	return res;
-}
-
-/*
- * NLM file handles are defined by specification to be a variable-length
- * XDR opaque no longer than 1024 bytes. However, this implementation
- * constrains their length to exactly the length of an NFSv2 file
- * handle.
- */
-static bool
-svcxdr_decode_fhandle(struct xdr_stream *xdr, struct nfs_fh *fh)
-{
-	__be32 *p;
-	u32 len;
-
-	if (xdr_stream_decode_u32(xdr, &len) < 0)
-		return false;
-	if (len != NFS2_FHSIZE)
-		return false;
-
-	p = xdr_inline_decode(xdr, len);
-	if (!p)
-		return false;
-	fh->size = NFS2_FHSIZE;
-	memcpy(fh->data, p, len);
-	memset(fh->data + NFS2_FHSIZE, 0, sizeof(fh->data) - NFS2_FHSIZE);
-
-	return true;
-}
-
-static bool
-svcxdr_decode_lock(struct xdr_stream *xdr, struct lockd_lock *lock)
-{
-	struct file_lock *fl = &lock->fl;
-	s32 start, len, end;
-
-	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-		return false;
-	if (!svcxdr_decode_fhandle(xdr, &lock->fh))
-		return false;
-	if (!svcxdr_decode_owner(xdr, &lock->oh))
-		return false;
-	if (xdr_stream_decode_u32(xdr, &lock->svid) < 0)
-		return false;
-	if (xdr_stream_decode_u32(xdr, &start) < 0)
-		return false;
-	if (xdr_stream_decode_u32(xdr, &len) < 0)
-		return false;
-
-	locks_init_lock(fl);
-	fl->c.flc_flags = FL_POSIX;
-	fl->c.flc_type  = F_RDLCK;
-	end = start + len - 1;
-	fl->fl_start = s32_to_loff_t(start);
-	if (len == 0 || end < 0)
-		fl->fl_end = OFFSET_MAX;
-	else
-		fl->fl_end = s32_to_loff_t(end);
-
-	return true;
-}
-
-static bool
-svcxdr_encode_holder(struct xdr_stream *xdr, const struct lockd_lock *lock)
-{
-	const struct file_lock *fl = &lock->fl;
-	s32 start, len;
-
-	/* exclusive */
-	if (xdr_stream_encode_bool(xdr, fl->c.flc_type != F_RDLCK) < 0)
-		return false;
-	if (xdr_stream_encode_u32(xdr, lock->svid) < 0)
-		return false;
-	if (!svcxdr_encode_owner(xdr, &lock->oh))
-		return false;
-	start = loff_t_to_s32(fl->fl_start);
-	if (fl->fl_end == OFFSET_MAX)
-		len = 0;
-	else
-		len = loff_t_to_s32(fl->fl_end - fl->fl_start + 1);
-	if (xdr_stream_encode_u32(xdr, start) < 0)
-		return false;
-	if (xdr_stream_encode_u32(xdr, len) < 0)
-		return false;
-
-	return true;
-}
-
-static bool
-svcxdr_encode_testrply(struct xdr_stream *xdr, const struct lockd_res *resp)
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
-nlmsvc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	return true;
-}
-
-bool
-nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct lockd_args *argp = rqstp->rq_argp;
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
-nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct lockd_args *argp = rqstp->rq_argp;
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
-nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct lockd_args *argp = rqstp->rq_argp;
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
-nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct lockd_args *argp = rqstp->rq_argp;
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
-nlmsvc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct lockd_res *resp = rqstp->rq_argp;
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
-nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct lockd_reboot *argp = rqstp->rq_argp;
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
-nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct lockd_lock *lock = &argp->lock;
-
-	memset(lock, 0, sizeof(*lock));
-	locks_init_lock(&lock->fl);
-	lock->svid = LOCKD_SHARE_SVID;
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
-nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct lockd_lock *lock = &argp->lock;
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
-nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	return true;
-}
-
-bool
-nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct lockd_res *resp = rqstp->rq_resp;
-
-	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
-		svcxdr_encode_testrply(xdr, resp);
-}
-
-bool
-nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct lockd_res *resp = rqstp->rq_resp;
-
-	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
-		svcxdr_encode_stats(xdr, resp->status);
-}
-
-bool
-nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
-{
-	struct lockd_res *resp = rqstp->rq_resp;
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
diff --git a/fs/lockd/xdr.h b/fs/lockd/xdr.h
index 65d2d6d34310..a1126cca98c6 100644
--- a/fs/lockd/xdr.h
+++ b/fs/lockd/xdr.h
@@ -20,8 +20,6 @@ struct nsm_private {
 	unsigned char		data[SM_PRIV_SIZE];
 };
 
-struct svc_rqst;
-
 #define NLM_MAXCOOKIELEN    	32
 #define NLM_MAXSTRLEN		1024
 
@@ -63,9 +61,6 @@ struct lockd_args {
 	u32			block;
 	u32			reclaim;
 	u32			state;
-	u32			monitor;
-	u32			fsm_access;
-	u32			fsm_mode;
 };
 
 /*
@@ -87,19 +82,4 @@ struct lockd_reboot {
 	struct nsm_private	priv;
 };
 
-bool	nlmsvc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlmsvc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-
-bool	nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-bool	nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-
 #endif /* _LOCKD_XDR_H */

-- 
2.54.0


