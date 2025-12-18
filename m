Return-Path: <linux-nfs+bounces-17197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A06FCCD7E3
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 596E43029C66
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327182D5419;
	Thu, 18 Dec 2025 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmTOPHeO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F72C3248
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088837; cv=none; b=m1XXq8beiknqCTydcDSvWD4pc33Z7pw9nJbmCqgAVDzfRMbQ/48i/12M3ncBs62x1MQzi2ZuiIgfb8Bj/R3aZt1T+MglTkR5E9/LSsgc6R2bZvMdJbLmLu5zkC3h2FBDya9nV2WXgNtkGuxbbz3X/p4iK+jdfF3jSOyqmK1qiLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088837; c=relaxed/simple;
	bh=gzKrEl6Elg+0p7PJBI6agk310oi26sH0XaLmv5ZjHGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q755+OjknBKGkJ2Jcug9/pY1u2nWw0Jbl8gYSFDP6NbZyze00mxGHldOY3ZpbJWKHaFba2JGkxgC6NX5Z1T15G5xLrIyy95hM2+uJMZNUkTSQuqokweJSpHMTuMyNblR0wnywRmaNMi5wDqOhdG+M7zQAmtwjU1On/Wqs0qE/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmTOPHeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31241C16AAE;
	Thu, 18 Dec 2025 20:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088836;
	bh=gzKrEl6Elg+0p7PJBI6agk310oi26sH0XaLmv5ZjHGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmTOPHeOmHmC4hwBQFyD33PUzMUIe6K8SHbfxFxh47QG9QDe2Vfn3kDtwhsO9Cl9W
	 VBbTHw4sh7bNGSIo2PvMfE4SDipXLiBN+bFwHIp7z2tFlDqy361Ut9SEE2z8yjOJ+T
	 7jMbA1e83DJFCP1OpVX+cvL12DJ+w0lU1zAmcIEUYbFF3Mkx7OLVUpCQ6p+AntZNdr
	 tMmDlhZw+pdVGzNChgHG4xSBKLPy1fn1USrBMavzWvFVcYpy7OMvrnQe/zBy3WGq56
	 RKqR0mokxGF+1aGbJdry19a/qopkIWUw98EutFfvgYqpuUmn6ycFcx9H1EmasRvK75
	 4DN2XHxi8CFbQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 09/36] Documentation: Add the RPC language description of NLM version 4
Date: Thu, 18 Dec 2025 15:13:19 -0500
Message-ID: <20251218201346.1190928-10-cel@kernel.org>
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

In order to generate source code to encode and decode NLMv4 protocol
elements, include a copy of the RPC language description of NLMv4
for xdrgen to process. The language description is an amalgam of
RFC 1813 and the Open Group's XNFS specification:

  https://pubs.opengroup.org/onlinepubs/9629799/chap10.htm

The C code committed here was generated from the new nlm4.x file
using tools/net/sunrpc/xdrgen/xdrgen.

The goals of replacing hand-written XDR functions with ones that
are tool-generated are to improve memory safety and make XDR
encoding and decoding less brittle to maintain. Parts of the
NFSv4 protocol are still being extended actively. Tool-generated
XDR code reduces the time it takes to get a working implementation
of new protocol elements.

The xdrgen utility derives both the type definitions and the
encode/decode functions directly from protocol specifications,
using names and symbols familiar to anyone who knows those specs.
Unlike hand-written code that can inadvertently diverge from the
specification, xdrgen guarantees that the generated code matches
the specification exactly.

We would eventually like xdrgen to generate Rust code as well,
making the conversion of the kernel's NFS stacks to use Rust just
a little easier for us.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/sunrpc/xdr/nlm4.x    | 211 +++++++++
 fs/lockd/Makefile                  |  21 +-
 fs/lockd/nlm4xdr_gen.c             | 724 +++++++++++++++++++++++++++++
 fs/lockd/nlm4xdr_gen.h             |  32 ++
 fs/lockd/svc4proc.c                |   1 +
 fs/lockd/xdr.h                     |   4 +-
 fs/lockd/xdr4.h                    |   2 +
 include/linux/sunrpc/xdrgen/nlm4.h | 231 +++++++++
 8 files changed, 1222 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/sunrpc/xdr/nlm4.x
 create mode 100644 fs/lockd/nlm4xdr_gen.c
 create mode 100644 fs/lockd/nlm4xdr_gen.h
 create mode 100644 include/linux/sunrpc/xdrgen/nlm4.h

diff --git a/Documentation/sunrpc/xdr/nlm4.x b/Documentation/sunrpc/xdr/nlm4.x
new file mode 100644
index 000000000000..ee2114537d54
--- /dev/null
+++ b/Documentation/sunrpc/xdr/nlm4.x
@@ -0,0 +1,211 @@
+/*
+ * This file was extracted by hand from
+ * https://www.rfc-editor.org/rfc/rfc1813.html .
+ *
+ * Note that RFC 1813 is Informational. Its official date of
+ * publication (June 1995) is before the IETF required its RFCs to
+ * carry an explicit copyright or other IP ownership notices.
+ *
+ * Note also that RFC 1813 does not specify the whole NLM4 protocol.
+ * In particular, the argument and result types are not present in
+ * that document, and had to be reverse-engineered.
+ */
+
+/*
+ * The NLMv4 protocol
+ */
+
+pragma header nlm4;
+
+/*
+ * The following definitions are missing in RFC 1813,
+ * but can be found in the OpenNetworking Network Lock
+ * Manager protocol:
+ *
+ * https://pubs.opengroup.org/onlinepubs/9629799/chap10.htm
+ */
+
+const LM_MAXSTRLEN = 1024;
+
+const LM_MAXNAMELEN = 1025;
+
+const MAXNETOBJ_SZ = 1024;
+
+typedef opaque netobj<MAXNETOBJ_SZ>;
+
+enum fsh4_mode {
+	fsm_DN = 0,
+	fsm_DR = 1,
+	fsm_DW = 2,
+	fsm_DRW = 3
+};
+
+enum fsh4_access {
+	fsa_NONE = 0,
+	fsa_R = 1,
+	fsa_W = 2,
+	fsa_RW = 3
+};
+
+/*
+ * The following definitions come from the OpenNetworking
+ * Network Status Monitor protocol:
+ *
+ * https://pubs.opengroup.org/onlinepubs/9629799/chap11.htm
+ */
+
+const SM_MAXSTRLEN = 1024;
+
+/*
+ * The NLM protocol as extracted from:
+ * https://tools.ietf.org/html/rfc1813 Appendix II
+ */
+
+typedef unsigned hyper uint64;
+
+typedef hyper int64;
+
+typedef unsigned long uint32;
+
+typedef long int32;
+
+enum nlm4_stats {
+	NLM4_GRANTED = 0,
+	NLM4_DENIED = 1,
+	NLM4_DENIED_NOLOCKS = 2,
+	NLM4_BLOCKED = 3,
+	NLM4_DENIED_GRACE_PERIOD = 4,
+	NLM4_DEADLCK = 5,
+	NLM4_ROFS = 6,
+	NLM4_STALE_FH = 7,
+	NLM4_FBIG = 8,
+	NLM4_FAILED = 9
+};
+
+pragma big_endian nlm4_stats;
+
+struct nlm4_holder {
+	bool		exclusive;
+	int32		svid;
+	netobj		oh;
+	uint64		l_offset;
+	uint64		l_len;
+};
+
+union nlm4_testrply switch (nlm4_stats stat) {
+	case NLM4_DENIED:
+		nlm4_holder	holder;
+	default:
+		void;
+};
+
+struct nlm4_stat {
+	nlm4_stats	stat;
+};
+
+struct nlm4_res {
+	netobj		cookie;
+	nlm4_stat	stat;
+};
+
+struct nlm4_testres {
+	netobj		cookie;
+	nlm4_testrply	stat;
+};
+
+struct nlm4_lock {
+	string		caller_name<LM_MAXSTRLEN>;
+	netobj		fh;
+	netobj		oh;
+	int32		svid;
+	uint64		l_offset;
+	uint64		l_len;
+};
+
+struct nlm4_lockargs {
+	netobj		cookie;
+	bool		block;
+	bool		exclusive;
+	nlm4_lock	alock;
+	bool		reclaim;
+	int32		state;
+};
+
+struct nlm4_cancargs {
+	netobj		cookie;
+	bool		block;
+	bool		exclusive;
+	nlm4_lock	alock;
+};
+
+struct nlm4_testargs {
+	netobj		cookie;
+	bool		exclusive;
+	nlm4_lock	alock;
+};
+
+struct nlm4_unlockargs {
+	netobj		cookie;
+	nlm4_lock	alock;
+};
+
+struct nlm4_share {
+	string		caller_name<LM_MAXSTRLEN>;
+	netobj		fh;
+	netobj		oh;
+	fsh4_mode	mode;
+	fsh4_access	access;
+};
+
+struct nlm4_shareargs {
+	netobj		cookie;
+	nlm4_share	share;
+	bool		reclaim;
+};
+
+struct nlm4_shareres {
+	netobj		cookie;
+	nlm4_stats	stat;
+	int32		sequence;
+};
+
+struct nlm4_notify {
+	string		name<LM_MAXNAMELEN>;
+	int32		state;
+};
+
+/*
+ * Argument for the Linux-private SM_NOTIFY procedure
+ */
+const SM_PRIV_SIZE = 16;
+
+struct nlm4_notifyargs {
+	nlm4_notify	notify;
+	opaque		private[SM_PRIV_SIZE];
+};
+
+program NLM4_PROG {
+	version NLM4_VERS {
+		void		NLMPROC4_NULL(void)			= 0;
+		nlm4_testres	NLMPROC4_TEST(nlm4_testargs)		= 1;
+		nlm4_res	NLMPROC4_LOCK(nlm4_lockargs)		= 2;
+		nlm4_res	NLMPROC4_CANCEL(nlm4_cancargs)		= 3;
+		nlm4_res	NLMPROC4_UNLOCK(nlm4_unlockargs)	= 4;
+		nlm4_res	NLMPROC4_GRANTED(nlm4_testargs)		= 5;
+		void		NLMPROC4_TEST_MSG(nlm4_testargs)	= 6;
+		void		NLMPROC4_LOCK_MSG(nlm4_lockargs)	= 7;
+		void		NLMPROC4_CANCEL_MSG(nlm4_cancargs)	= 8;
+		void		NLMPROC4_UNLOCK_MSG(nlm4_unlockargs)	= 9;
+		void		NLMPROC4_GRANTED_MSG(nlm4_testargs)	= 10;
+		void		NLMPROC4_TEST_RES(nlm4_testres)		= 11;
+		void		NLMPROC4_LOCK_RES(nlm4_res)		= 12;
+		void		NLMPROC4_CANCEL_RES(nlm4_res)		= 13;
+		void		NLMPROC4_UNLOCK_RES(nlm4_res)		= 14;
+		void		NLMPROC4_GRANTED_RES(nlm4_res)		= 15;
+		void		NLMPROC4_SM_NOTIFY(nlm4_notifyargs)	= 16;
+		nlm4_shareres	NLMPROC4_SHARE(nlm4_shareargs)		= 20;
+		nlm4_shareres	NLMPROC4_UNSHARE(nlm4_shareargs)	= 21;
+		nlm4_res	NLMPROC4_NM_LOCK(nlm4_lockargs)		= 22;
+		void		NLMPROC4_FREE_ALL(nlm4_notify)		= 23;
+	} = 4;
+} = 100021;
diff --git a/fs/lockd/Makefile b/fs/lockd/Makefile
index 51bbe22d21e3..e1e49ff2f766 100644
--- a/fs/lockd/Makefile
+++ b/fs/lockd/Makefile
@@ -9,5 +9,24 @@ obj-$(CONFIG_LOCKD) += lockd.o
 
 lockd-y := clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
 	   svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o netlink.o
-lockd-$(CONFIG_LOCKD_V4) += clnt4xdr.o xdr4.o svc4proc.o
+lockd-$(CONFIG_LOCKD_V4) += clnt4xdr.o xdr4.o svc4proc.o nlm4xdr_gen.o
 lockd-$(CONFIG_PROC_FS) += procfs.o
+
+.PHONY: xdrgen
+
+XDRGEN			= ../../tools/net/sunrpc/xdrgen/xdrgen
+
+XDRGEN_DEFINITIONS	= ../../include/linux/sunrpc/xdrgen/nlm4.h
+XDRGEN_DECLARATIONS	= nlm4xdr_gen.h
+XDRGEN_SOURCE		= nlm4xdr_gen.c
+
+xdrgen: $(XDRGEN_DEFINITIONS) $(XDRGEN_DECLARATIONS) $(XDRGEN_SOURCE)
+
+../../include/linux/sunrpc/xdrgen/nlm4.h: ../../Documentation/sunrpc/xdr/nlm4.x
+	$(XDRGEN) definitions $< > $@
+
+nlm4xdr_gen.h: ../../Documentation/sunrpc/xdr/nlm4.x
+	$(XDRGEN) declarations $< > $@
+
+nlm4xdr_gen.c: ../../Documentation/sunrpc/xdr/nlm4.x
+	$(XDRGEN) source --peer server $< > $@
diff --git a/fs/lockd/nlm4xdr_gen.c b/fs/lockd/nlm4xdr_gen.c
new file mode 100644
index 000000000000..df9ea534b87d
--- /dev/null
+++ b/fs/lockd/nlm4xdr_gen.c
@@ -0,0 +1,724 @@
+// SPDX-License-Identifier: GPL-2.0
+// Generated by xdrgen. Manual edits will be lost.
+// XDR specification file: ../../Documentation/sunrpc/xdr/nlm4.x
+// XDR specification modification time: Thu Dec 18 15:01:58 2025
+
+#include <linux/sunrpc/svc.h>
+
+#include "nlm4xdr_gen.h"
+
+static bool __maybe_unused
+xdrgen_decode_netobj(struct xdr_stream *xdr, netobj *ptr)
+{
+	return xdrgen_decode_opaque(xdr, ptr, MAXNETOBJ_SZ);
+}
+
+static bool __maybe_unused
+xdrgen_decode_fsh4_mode(struct xdr_stream *xdr, fsh4_mode *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_fsh4_access(struct xdr_stream *xdr, fsh4_access *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_uint64(struct xdr_stream *xdr, uint64 *ptr)
+{
+	return xdrgen_decode_unsigned_hyper(xdr, ptr);
+}
+
+static bool __maybe_unused
+xdrgen_decode_int64(struct xdr_stream *xdr, int64 *ptr)
+{
+	return xdrgen_decode_hyper(xdr, ptr);
+}
+
+static bool __maybe_unused
+xdrgen_decode_uint32(struct xdr_stream *xdr, uint32 *ptr)
+{
+	return xdrgen_decode_unsigned_long(xdr, ptr);
+}
+
+static bool __maybe_unused
+xdrgen_decode_int32(struct xdr_stream *xdr, int32 *ptr)
+{
+	return xdrgen_decode_long(xdr, ptr);
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_stats(struct xdr_stream *xdr, nlm4_stats *ptr)
+{
+	return xdr_stream_decode_be32(xdr, ptr) == 0;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_holder(struct xdr_stream *xdr, struct nlm4_holder *ptr)
+{
+	if (!xdrgen_decode_bool(xdr, &ptr->exclusive))
+		return false;
+	if (!xdrgen_decode_int32(xdr, &ptr->svid))
+		return false;
+	if (!xdrgen_decode_netobj(xdr, &ptr->oh))
+		return false;
+	if (!xdrgen_decode_uint64(xdr, &ptr->l_offset))
+		return false;
+	if (!xdrgen_decode_uint64(xdr, &ptr->l_len))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_testrply(struct xdr_stream *xdr, struct nlm4_testrply *ptr)
+{
+	if (!xdrgen_decode_nlm4_stats(xdr, &ptr->stat))
+		return false;
+	switch (ptr->stat) {
+	case __constant_cpu_to_be32(NLM4_DENIED):
+		if (!xdrgen_decode_nlm4_holder(xdr, &ptr->u.holder))
+			return false;
+		break;
+	default:
+		break;
+	}
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_stat(struct xdr_stream *xdr, struct nlm4_stat *ptr)
+{
+	if (!xdrgen_decode_nlm4_stats(xdr, &ptr->stat))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_res(struct xdr_stream *xdr, struct nlm4_res *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_nlm4_stat(xdr, &ptr->stat))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_testres(struct xdr_stream *xdr, struct nlm4_testres *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_nlm4_testrply(xdr, &ptr->stat))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_lock(struct xdr_stream *xdr, struct nlm4_lock *ptr)
+{
+	if (!xdrgen_decode_string(xdr, (string *)ptr, LM_MAXSTRLEN))
+		return false;
+	if (!xdrgen_decode_netobj(xdr, &ptr->fh))
+		return false;
+	if (!xdrgen_decode_netobj(xdr, &ptr->oh))
+		return false;
+	if (!xdrgen_decode_int32(xdr, &ptr->svid))
+		return false;
+	if (!xdrgen_decode_uint64(xdr, &ptr->l_offset))
+		return false;
+	if (!xdrgen_decode_uint64(xdr, &ptr->l_len))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_lockargs(struct xdr_stream *xdr, struct nlm4_lockargs *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->block))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->exclusive))
+		return false;
+	if (!xdrgen_decode_nlm4_lock(xdr, &ptr->alock))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->reclaim))
+		return false;
+	if (!xdrgen_decode_int32(xdr, &ptr->state))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_cancargs(struct xdr_stream *xdr, struct nlm4_cancargs *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->block))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->exclusive))
+		return false;
+	if (!xdrgen_decode_nlm4_lock(xdr, &ptr->alock))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_testargs(struct xdr_stream *xdr, struct nlm4_testargs *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->exclusive))
+		return false;
+	if (!xdrgen_decode_nlm4_lock(xdr, &ptr->alock))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_unlockargs(struct xdr_stream *xdr, struct nlm4_unlockargs *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_nlm4_lock(xdr, &ptr->alock))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_share(struct xdr_stream *xdr, struct nlm4_share *ptr)
+{
+	if (!xdrgen_decode_string(xdr, (string *)ptr, LM_MAXSTRLEN))
+		return false;
+	if (!xdrgen_decode_netobj(xdr, &ptr->fh))
+		return false;
+	if (!xdrgen_decode_netobj(xdr, &ptr->oh))
+		return false;
+	if (!xdrgen_decode_fsh4_mode(xdr, &ptr->mode))
+		return false;
+	if (!xdrgen_decode_fsh4_access(xdr, &ptr->access))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_shareargs(struct xdr_stream *xdr, struct nlm4_shareargs *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_nlm4_share(xdr, &ptr->share))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->reclaim))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_shareres(struct xdr_stream *xdr, struct nlm4_shareres *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_nlm4_stats(xdr, &ptr->stat))
+		return false;
+	if (!xdrgen_decode_int32(xdr, &ptr->sequence))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_notify(struct xdr_stream *xdr, struct nlm4_notify *ptr)
+{
+	if (!xdrgen_decode_string(xdr, (string *)ptr, LM_MAXNAMELEN))
+		return false;
+	if (!xdrgen_decode_int32(xdr, &ptr->state))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm4_notifyargs(struct xdr_stream *xdr, struct nlm4_notifyargs *ptr)
+{
+	if (!xdrgen_decode_nlm4_notify(xdr, &ptr->notify))
+		return false;
+	if (xdr_stream_decode_opaque_fixed(xdr, ptr->private, SM_PRIV_SIZE) < 0)
+		return false;
+	return true;
+}
+
+/**
+ * nlm4_svc_decode_void - Decode a void argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm4_svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	return xdrgen_decode_void(xdr);
+}
+
+/**
+ * nlm4_svc_decode_nlm4_testargs - Decode a nlm4_testargs argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm4_svc_decode_nlm4_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm4_testargs *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm4_testargs(xdr, argp);
+}
+
+/**
+ * nlm4_svc_decode_nlm4_lockargs - Decode a nlm4_lockargs argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm4_svc_decode_nlm4_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm4_lockargs *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm4_lockargs(xdr, argp);
+}
+
+/**
+ * nlm4_svc_decode_nlm4_cancargs - Decode a nlm4_cancargs argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm4_svc_decode_nlm4_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm4_cancargs *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm4_cancargs(xdr, argp);
+}
+
+/**
+ * nlm4_svc_decode_nlm4_unlockargs - Decode a nlm4_unlockargs argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm4_svc_decode_nlm4_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm4_unlockargs *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm4_unlockargs(xdr, argp);
+}
+
+/**
+ * nlm4_svc_decode_nlm4_testres - Decode a nlm4_testres argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm4_svc_decode_nlm4_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm4_testres *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm4_testres(xdr, argp);
+}
+
+/**
+ * nlm4_svc_decode_nlm4_res - Decode a nlm4_res argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm4_svc_decode_nlm4_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm4_res *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm4_res(xdr, argp);
+}
+
+/**
+ * nlm4_svc_decode_nlm4_notifyargs - Decode a nlm4_notifyargs argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm4_svc_decode_nlm4_notifyargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm4_notifyargs *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm4_notifyargs(xdr, argp);
+}
+
+/**
+ * nlm4_svc_decode_nlm4_shareargs - Decode a nlm4_shareargs argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm4_svc_decode_nlm4_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm4_shareargs *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm4_shareargs(xdr, argp);
+}
+
+/**
+ * nlm4_svc_decode_nlm4_notify - Decode a nlm4_notify argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm4_svc_decode_nlm4_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm4_notify *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm4_notify(xdr, argp);
+}
+
+static bool __maybe_unused
+xdrgen_encode_netobj(struct xdr_stream *xdr, const netobj value)
+{
+	return xdr_stream_encode_opaque(xdr, value.data, value.len) >= 0;
+}
+
+static bool __maybe_unused
+xdrgen_encode_fsh4_mode(struct xdr_stream *xdr, fsh4_mode value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_fsh4_access(struct xdr_stream *xdr, fsh4_access value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_uint64(struct xdr_stream *xdr, const uint64 value)
+{
+	return xdrgen_encode_unsigned_hyper(xdr, value);
+}
+
+static bool __maybe_unused
+xdrgen_encode_int64(struct xdr_stream *xdr, const int64 value)
+{
+	return xdrgen_encode_hyper(xdr, value);
+}
+
+static bool __maybe_unused
+xdrgen_encode_uint32(struct xdr_stream *xdr, const uint32 value)
+{
+	return xdrgen_encode_unsigned_long(xdr, value);
+}
+
+static bool __maybe_unused
+xdrgen_encode_int32(struct xdr_stream *xdr, const int32 value)
+{
+	return xdrgen_encode_long(xdr, value);
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_stats(struct xdr_stream *xdr, nlm4_stats value)
+{
+	return xdr_stream_encode_be32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_holder(struct xdr_stream *xdr, const struct nlm4_holder *value)
+{
+	if (!xdrgen_encode_bool(xdr, value->exclusive))
+		return false;
+	if (!xdrgen_encode_int32(xdr, value->svid))
+		return false;
+	if (!xdrgen_encode_netobj(xdr, value->oh))
+		return false;
+	if (!xdrgen_encode_uint64(xdr, value->l_offset))
+		return false;
+	if (!xdrgen_encode_uint64(xdr, value->l_len))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_testrply(struct xdr_stream *xdr, const struct nlm4_testrply *ptr)
+{
+	if (!xdrgen_encode_nlm4_stats(xdr, ptr->stat))
+		return false;
+	switch (ptr->stat) {
+	case __constant_cpu_to_be32(NLM4_DENIED):
+		if (!xdrgen_encode_nlm4_holder(xdr, &ptr->u.holder))
+			return false;
+		break;
+	default:
+		break;
+	}
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_stat(struct xdr_stream *xdr, const struct nlm4_stat *value)
+{
+	if (!xdrgen_encode_nlm4_stats(xdr, value->stat))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_res(struct xdr_stream *xdr, const struct nlm4_res *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_nlm4_stat(xdr, &value->stat))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_testres(struct xdr_stream *xdr, const struct nlm4_testres *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_nlm4_testrply(xdr, &value->stat))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_lock(struct xdr_stream *xdr, const struct nlm4_lock *value)
+{
+	if (value->caller_name.len > LM_MAXSTRLEN)
+		return false;
+	if (xdr_stream_encode_opaque(xdr, value->caller_name.data, value->caller_name.len) < 0)
+		return false;
+	if (!xdrgen_encode_netobj(xdr, value->fh))
+		return false;
+	if (!xdrgen_encode_netobj(xdr, value->oh))
+		return false;
+	if (!xdrgen_encode_int32(xdr, value->svid))
+		return false;
+	if (!xdrgen_encode_uint64(xdr, value->l_offset))
+		return false;
+	if (!xdrgen_encode_uint64(xdr, value->l_len))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_lockargs(struct xdr_stream *xdr, const struct nlm4_lockargs *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->block))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->exclusive))
+		return false;
+	if (!xdrgen_encode_nlm4_lock(xdr, &value->alock))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->reclaim))
+		return false;
+	if (!xdrgen_encode_int32(xdr, value->state))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_cancargs(struct xdr_stream *xdr, const struct nlm4_cancargs *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->block))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->exclusive))
+		return false;
+	if (!xdrgen_encode_nlm4_lock(xdr, &value->alock))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_testargs(struct xdr_stream *xdr, const struct nlm4_testargs *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->exclusive))
+		return false;
+	if (!xdrgen_encode_nlm4_lock(xdr, &value->alock))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_unlockargs(struct xdr_stream *xdr, const struct nlm4_unlockargs *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_nlm4_lock(xdr, &value->alock))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_share(struct xdr_stream *xdr, const struct nlm4_share *value)
+{
+	if (value->caller_name.len > LM_MAXSTRLEN)
+		return false;
+	if (xdr_stream_encode_opaque(xdr, value->caller_name.data, value->caller_name.len) < 0)
+		return false;
+	if (!xdrgen_encode_netobj(xdr, value->fh))
+		return false;
+	if (!xdrgen_encode_netobj(xdr, value->oh))
+		return false;
+	if (!xdrgen_encode_fsh4_mode(xdr, value->mode))
+		return false;
+	if (!xdrgen_encode_fsh4_access(xdr, value->access))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_shareargs(struct xdr_stream *xdr, const struct nlm4_shareargs *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_nlm4_share(xdr, &value->share))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->reclaim))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_shareres(struct xdr_stream *xdr, const struct nlm4_shareres *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_nlm4_stats(xdr, value->stat))
+		return false;
+	if (!xdrgen_encode_int32(xdr, value->sequence))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_notify(struct xdr_stream *xdr, const struct nlm4_notify *value)
+{
+	if (value->name.len > LM_MAXNAMELEN)
+		return false;
+	if (xdr_stream_encode_opaque(xdr, value->name.data, value->name.len) < 0)
+		return false;
+	if (!xdrgen_encode_int32(xdr, value->state))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm4_notifyargs(struct xdr_stream *xdr, const struct nlm4_notifyargs *value)
+{
+	if (!xdrgen_encode_nlm4_notify(xdr, &value->notify))
+		return false;
+	if (xdr_stream_encode_opaque_fixed(xdr, value->private, SM_PRIV_SIZE) < 0)
+		return false;
+	return true;
+}
+
+/**
+ * nlm4_svc_encode_void - Encode a void result
+ * @rqstp: RPC transaction context
+ * @xdr: target XDR data stream
+ *
+ * Return values:
+ *   %true: procedure results encoded successfully
+ *   %false: encode failed
+ */
+bool nlm4_svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	return xdrgen_encode_void(xdr);
+}
+
+/**
+ * nlm4_svc_encode_nlm4_testres - Encode a nlm4_testres result
+ * @rqstp: RPC transaction context
+ * @xdr: target XDR data stream
+ *
+ * Return values:
+ *   %true: procedure results encoded successfully
+ *   %false: encode failed
+ */
+bool nlm4_svc_encode_nlm4_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm4_testres *resp = rqstp->rq_resp;
+
+	return xdrgen_encode_nlm4_testres(xdr, resp);
+}
+
+/**
+ * nlm4_svc_encode_nlm4_res - Encode a nlm4_res result
+ * @rqstp: RPC transaction context
+ * @xdr: target XDR data stream
+ *
+ * Return values:
+ *   %true: procedure results encoded successfully
+ *   %false: encode failed
+ */
+bool nlm4_svc_encode_nlm4_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm4_res *resp = rqstp->rq_resp;
+
+	return xdrgen_encode_nlm4_res(xdr, resp);
+}
+
+/**
+ * nlm4_svc_encode_nlm4_shareres - Encode a nlm4_shareres result
+ * @rqstp: RPC transaction context
+ * @xdr: target XDR data stream
+ *
+ * Return values:
+ *   %true: procedure results encoded successfully
+ *   %false: encode failed
+ */
+bool nlm4_svc_encode_nlm4_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm4_shareres *resp = rqstp->rq_resp;
+
+	return xdrgen_encode_nlm4_shareres(xdr, resp);
+}
diff --git a/fs/lockd/nlm4xdr_gen.h b/fs/lockd/nlm4xdr_gen.h
new file mode 100644
index 000000000000..7833862dd004
--- /dev/null
+++ b/fs/lockd/nlm4xdr_gen.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Generated by xdrgen. Manual edits will be lost. */
+/* XDR specification file: ../../Documentation/sunrpc/xdr/nlm4.x */
+/* XDR specification modification time: Thu Dec 18 15:01:58 2025 */
+
+#ifndef _LINUX_XDRGEN_NLM4_DECL_H
+#define _LINUX_XDRGEN_NLM4_DECL_H
+
+#include <linux/types.h>
+
+#include <linux/sunrpc/xdr.h>
+#include <linux/sunrpc/xdrgen/_defs.h>
+#include <linux/sunrpc/xdrgen/_builtins.h>
+#include <linux/sunrpc/xdrgen/nlm4.h>
+
+bool nlm4_svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm4_svc_decode_nlm4_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm4_svc_decode_nlm4_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm4_svc_decode_nlm4_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm4_svc_decode_nlm4_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm4_svc_decode_nlm4_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm4_svc_decode_nlm4_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm4_svc_decode_nlm4_notifyargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm4_svc_decode_nlm4_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm4_svc_decode_nlm4_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+
+bool nlm4_svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm4_svc_encode_nlm4_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm4_svc_encode_nlm4_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm4_svc_encode_nlm4_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+
+#endif /* _LINUX_XDRGEN_NLM4_DECL_H */
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index b6d1dcddd8a6..b975bddf3776 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -14,6 +14,7 @@
 
 #include "lockd.h"
 #include "share.h"
+#include "nlm4xdr_gen.h"
 #include "xdr4.h"
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
diff --git a/fs/lockd/xdr.h b/fs/lockd/xdr.h
index a8090191434e..49e319c3e613 100644
--- a/fs/lockd/xdr.h
+++ b/fs/lockd/xdr.h
@@ -12,9 +12,7 @@
 #include <linux/filelock.h>
 #include <linux/nfs.h>
 #include <linux/sunrpc/xdr.h>
-
-#define SM_MAXSTRLEN		1024
-#define SM_PRIV_SIZE		16
+#include <linux/sunrpc/xdrgen/nlm4.h>
 
 struct nsm_private {
 	unsigned char		data[SM_PRIV_SIZE];
diff --git a/fs/lockd/xdr4.h b/fs/lockd/xdr4.h
index 0fe88e317da6..7167ae50485c 100644
--- a/fs/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -8,6 +8,8 @@
 #ifndef _LOCKD_XDR4_H
 #define _LOCKD_XDR4_H
 
+#include <linux/sunrpc/xdrgen/nlm4.h>
+
 /* error codes new to NLMv4 */
 #define	nlm4_deadlock		cpu_to_be32(NLM_DEADLCK)
 #define	nlm4_rofs		cpu_to_be32(NLM_ROFS)
diff --git a/include/linux/sunrpc/xdrgen/nlm4.h b/include/linux/sunrpc/xdrgen/nlm4.h
new file mode 100644
index 000000000000..58865718b912
--- /dev/null
+++ b/include/linux/sunrpc/xdrgen/nlm4.h
@@ -0,0 +1,231 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Generated by xdrgen. Manual edits will be lost. */
+/* XDR specification file: ../../Documentation/sunrpc/xdr/nlm4.x */
+/* XDR specification modification time: Thu Dec 18 15:01:58 2025 */
+
+#ifndef _LINUX_XDRGEN_NLM4_DEF_H
+#define _LINUX_XDRGEN_NLM4_DEF_H
+
+#include <linux/types.h>
+#include <linux/sunrpc/xdrgen/_defs.h>
+
+enum { LM_MAXSTRLEN = 1024 };
+
+enum { LM_MAXNAMELEN = 1025 };
+
+enum { MAXNETOBJ_SZ = 1024 };
+
+typedef opaque netobj;
+
+enum fsh4_mode {
+	fsm_DN = 0,
+	fsm_DR = 1,
+	fsm_DW = 2,
+	fsm_DRW = 3,
+};
+
+typedef enum fsh4_mode fsh4_mode;
+
+enum fsh4_access {
+	fsa_NONE = 0,
+	fsa_R = 1,
+	fsa_W = 2,
+	fsa_RW = 3,
+};
+
+typedef enum fsh4_access fsh4_access;
+
+enum { SM_MAXSTRLEN = 1024 };
+
+typedef u64 uint64;
+
+typedef s64 int64;
+
+typedef u32 uint32;
+
+typedef s32 int32;
+
+enum nlm4_stats {
+	NLM4_GRANTED = 0,
+	NLM4_DENIED = 1,
+	NLM4_DENIED_NOLOCKS = 2,
+	NLM4_BLOCKED = 3,
+	NLM4_DENIED_GRACE_PERIOD = 4,
+	NLM4_DEADLCK = 5,
+	NLM4_ROFS = 6,
+	NLM4_STALE_FH = 7,
+	NLM4_FBIG = 8,
+	NLM4_FAILED = 9,
+};
+
+typedef __be32 nlm4_stats;
+
+struct nlm4_holder {
+	bool exclusive;
+	int32 svid;
+	netobj oh;
+	uint64 l_offset;
+	uint64 l_len;
+};
+
+struct nlm4_testrply {
+	nlm4_stats stat;
+	union {
+		struct nlm4_holder holder;
+	} u;
+};
+
+struct nlm4_stat {
+	nlm4_stats stat;
+};
+
+struct nlm4_res {
+	netobj cookie;
+	struct nlm4_stat stat;
+};
+
+struct nlm4_testres {
+	netobj cookie;
+	struct nlm4_testrply stat;
+};
+
+struct nlm4_lock {
+	string caller_name;
+	netobj fh;
+	netobj oh;
+	int32 svid;
+	uint64 l_offset;
+	uint64 l_len;
+};
+
+struct nlm4_lockargs {
+	netobj cookie;
+	bool block;
+	bool exclusive;
+	struct nlm4_lock alock;
+	bool reclaim;
+	int32 state;
+};
+
+struct nlm4_cancargs {
+	netobj cookie;
+	bool block;
+	bool exclusive;
+	struct nlm4_lock alock;
+};
+
+struct nlm4_testargs {
+	netobj cookie;
+	bool exclusive;
+	struct nlm4_lock alock;
+};
+
+struct nlm4_unlockargs {
+	netobj cookie;
+	struct nlm4_lock alock;
+};
+
+struct nlm4_share {
+	string caller_name;
+	netobj fh;
+	netobj oh;
+	fsh4_mode mode;
+	fsh4_access access;
+};
+
+struct nlm4_shareargs {
+	netobj cookie;
+	struct nlm4_share share;
+	bool reclaim;
+};
+
+struct nlm4_shareres {
+	netobj cookie;
+	nlm4_stats stat;
+	int32 sequence;
+};
+
+struct nlm4_notify {
+	string name;
+	int32 state;
+};
+
+enum { SM_PRIV_SIZE = 16 };
+
+struct nlm4_notifyargs {
+	struct nlm4_notify notify;
+	u8 private[SM_PRIV_SIZE];
+};
+
+enum {
+	NLMPROC4_NULL = 0,
+	NLMPROC4_TEST = 1,
+	NLMPROC4_LOCK = 2,
+	NLMPROC4_CANCEL = 3,
+	NLMPROC4_UNLOCK = 4,
+	NLMPROC4_GRANTED = 5,
+	NLMPROC4_TEST_MSG = 6,
+	NLMPROC4_LOCK_MSG = 7,
+	NLMPROC4_CANCEL_MSG = 8,
+	NLMPROC4_UNLOCK_MSG = 9,
+	NLMPROC4_GRANTED_MSG = 10,
+	NLMPROC4_TEST_RES = 11,
+	NLMPROC4_LOCK_RES = 12,
+	NLMPROC4_CANCEL_RES = 13,
+	NLMPROC4_UNLOCK_RES = 14,
+	NLMPROC4_GRANTED_RES = 15,
+	NLMPROC4_SM_NOTIFY = 16,
+	NLMPROC4_SHARE = 20,
+	NLMPROC4_UNSHARE = 21,
+	NLMPROC4_NM_LOCK = 22,
+	NLMPROC4_FREE_ALL = 23,
+};
+
+#ifndef NLM4_PROG
+#define NLM4_PROG (100021)
+#endif
+
+#define NLM4_netobj_sz                  (XDR_unsigned_int + XDR_QUADLEN(MAXNETOBJ_SZ))
+#define NLM4_fsh4_mode_sz               (XDR_int)
+#define NLM4_fsh4_access_sz             (XDR_int)
+#define NLM4_uint64_sz                  \
+	(XDR_unsigned_hyper)
+#define NLM4_int64_sz                   \
+	(XDR_hyper)
+#define NLM4_uint32_sz                  \
+	(XDR_unsigned_long)
+#define NLM4_int32_sz                   \
+	(XDR_long)
+#define NLM4_nlm4_stats_sz              (XDR_int)
+#define NLM4_nlm4_holder_sz             \
+	(XDR_bool + NLM4_int32_sz + NLM4_netobj_sz + NLM4_uint64_sz + NLM4_uint64_sz)
+#define NLM4_nlm4_testrply_sz           \
+	(NLM4_nlm4_stats_sz + NLM4_nlm4_holder_sz)
+#define NLM4_nlm4_stat_sz               \
+	(NLM4_nlm4_stats_sz)
+#define NLM4_nlm4_res_sz                \
+	(NLM4_netobj_sz + NLM4_nlm4_stat_sz)
+#define NLM4_nlm4_testres_sz            \
+	(NLM4_netobj_sz + NLM4_nlm4_testrply_sz)
+#define NLM4_nlm4_lock_sz               \
+	(XDR_unsigned_int + XDR_QUADLEN(LM_MAXSTRLEN) + NLM4_netobj_sz + NLM4_netobj_sz + NLM4_int32_sz + NLM4_uint64_sz + NLM4_uint64_sz)
+#define NLM4_nlm4_lockargs_sz           \
+	(NLM4_netobj_sz + XDR_bool + XDR_bool + NLM4_nlm4_lock_sz + XDR_bool + NLM4_int32_sz)
+#define NLM4_nlm4_cancargs_sz           \
+	(NLM4_netobj_sz + XDR_bool + XDR_bool + NLM4_nlm4_lock_sz)
+#define NLM4_nlm4_testargs_sz           \
+	(NLM4_netobj_sz + XDR_bool + NLM4_nlm4_lock_sz)
+#define NLM4_nlm4_unlockargs_sz         \
+	(NLM4_netobj_sz + NLM4_nlm4_lock_sz)
+#define NLM4_nlm4_share_sz              \
+	(XDR_unsigned_int + XDR_QUADLEN(LM_MAXSTRLEN) + NLM4_netobj_sz + NLM4_netobj_sz + NLM4_fsh4_mode_sz + NLM4_fsh4_access_sz)
+#define NLM4_nlm4_shareargs_sz          \
+	(NLM4_netobj_sz + NLM4_nlm4_share_sz + XDR_bool)
+#define NLM4_nlm4_shareres_sz           \
+	(NLM4_netobj_sz + NLM4_nlm4_stats_sz + NLM4_int32_sz)
+#define NLM4_nlm4_notify_sz             \
+	(XDR_unsigned_int + XDR_QUADLEN(LM_MAXNAMELEN) + NLM4_int32_sz)
+#define NLM4_nlm4_notifyargs_sz         \
+	(NLM4_nlm4_notify_sz + XDR_QUADLEN(SM_PRIV_SIZE))
+
+#endif /* _LINUX_XDRGEN_NLM4_DEF_H */
-- 
2.52.0


