Return-Path: <linux-nfs+bounces-5812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A089961408
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 18:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9691F23E1C
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB011A01CD;
	Tue, 27 Aug 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfLa83XM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7414481CD
	for <linux-nfs@vger.kernel.org>; Tue, 27 Aug 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776084; cv=none; b=gXqvO9pkDV9dTJNCZwiyY+IRMMcpbsti/78KSulbhmUs7pgiDI3f/0oMg7amMm1J2mNSiNhb+sxuV5QXT54GNMpHpl5fYD5+a4epf3+D2hIxfIuNQCGeGJgIICEK4exrK5WpSI+gD1VzsmsJMFl7/ivsqn3h6OdARsvbR6WMolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776084; c=relaxed/simple;
	bh=MFcwOv1iBFMnbCAmpn08k8cTTdm3QhJrLLQBGrzhVPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhgxYXWaAjUqMUw/6rgoI7+WYiZu3sB3K/l2XiwsvCsf/K/bft6kDhX7cCCSdohf1S5bq/s8jnmK70g4rselFn1zsA8PQ9deGsAk+YcTaR9W1Uxk80jPHmQ5nbIQ7XjJ2ZPKProa5qG1JeNkHw1gnSZ3FXVZ0SK4Cs7E1TfeRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfLa83XM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7D8C4CA0B;
	Tue, 27 Aug 2024 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724776084;
	bh=MFcwOv1iBFMnbCAmpn08k8cTTdm3QhJrLLQBGrzhVPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MfLa83XMZXgoAwL178TTDwvDAq7Zm4f6HkxDa8ztVyK3E5RA5pLs0jU0v7Xt0dVIw
	 9J9AikejgAh5HSahdoiw7e0kgaWWt59wALYtThTbcdD1XnClC+8xpUTc1g+TI7LEt+
	 TiUpf7tD/I5tnXQj9hYMvTG/E1aaS3RDuBv5S73b2vZ/mlYTp3F8yoMZPHCo55I1oj
	 lUFmnYrs5HSy7BVF2YNhUY9rejqyieS+FZyn6UtN7d0qe14tFVtTU6bwOv6mPn+0t2
	 huS4Z/ufBDnGmwkWQqBk/MAkr6vGZI068OylsViKMiS9dJlakqCJfT3OScJU97NQQd
	 Fvmu4IqQYifKw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/2] NFSD: Create an initial nfs4_1.x file
Date: Tue, 27 Aug 2024 12:27:18 -0400
Message-ID: <20240827162718.42342-3-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827162718.42342-1-cel@kernel.org>
References: <20240827162718.42342-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Build an NFSv4 protocol snippet to support the delstid extensions.
The new fs/nfsd/nfs4_1.x file can be added to over time as other
parts of NFSD's XDR functions are converted to machine-generated
code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4_1.x      | 164 +++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr_gen.c | 236 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr_gen.h | 100 ++++++++++++++++++
 3 files changed, 500 insertions(+)
 create mode 100644 fs/nfsd/nfs4_1.x
 create mode 100644 fs/nfsd/nfs4xdr_gen.c
 create mode 100644 fs/nfsd/nfs4xdr_gen.h

diff --git a/fs/nfsd/nfs4_1.x b/fs/nfsd/nfs4_1.x
new file mode 100644
index 000000000000..d2fde450de5e
--- /dev/null
+++ b/fs/nfsd/nfs4_1.x
@@ -0,0 +1,164 @@
+/*
+ * Copyright (c) 2010 IETF Trust and the persons identified
+ * as the document authors.  All rights reserved.
+ *
+ * The document authors are identified in RFC 3530 and
+ * RFC 5661.
+ *
+ * Redistribution and use in source and binary forms, with
+ * or without modification, are permitted provided that the
+ * following conditions are met:
+ *
+ * - Redistributions of source code must retain the above
+ *   copyright notice, this list of conditions and the
+ *   following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the
+ *   following disclaimer in the documentation and/or other
+ *   materials provided with the distribution.
+ *
+ * - Neither the name of Internet Society, IETF or IETF
+ *   Trust, nor the names of specific contributors, may be
+ *   used to endorse or promote products derived from this
+ *   software without specific prior written permission.
+ *
+ *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS
+ *   AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
+ *   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ *   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ *   FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
+ *   EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ *   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
+ *   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *   NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ *   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ *   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ *   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ *   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ *   IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ *   ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+pragma header nfs4;
+
+/*
+ * Basic typedefs for RFC 1832 data type definitions
+ */
+typedef hyper		int64_t;
+typedef unsigned int	uint32_t;
+
+/*
+ * Basic data types
+ */
+typedef uint32_t	bitmap4<>;
+
+/*
+ * Timeval
+ */
+struct nfstime4 {
+	int64_t		seconds;
+	uint32_t	nseconds;
+};
+
+
+/*
+ * The following content was extracted from draft-ietf-nfsv4-delstid
+ */
+
+typedef bool            fattr4_offline;
+
+
+const FATTR4_OFFLINE            = 83;
+
+
+struct open_arguments4 {
+  bitmap4  oa_share_access;
+  bitmap4  oa_share_deny;
+  bitmap4  oa_share_access_want;
+  bitmap4  oa_open_claim;
+  bitmap4  oa_create_mode;
+};
+
+
+enum open_args_share_access4 {
+   OPEN_ARGS_SHARE_ACCESS_READ  = 1,
+   OPEN_ARGS_SHARE_ACCESS_WRITE = 2,
+   OPEN_ARGS_SHARE_ACCESS_BOTH  = 3
+};
+
+
+enum open_args_share_deny4 {
+   OPEN_ARGS_SHARE_DENY_NONE  = 0,
+   OPEN_ARGS_SHARE_DENY_READ  = 1,
+   OPEN_ARGS_SHARE_DENY_WRITE = 2,
+   OPEN_ARGS_SHARE_DENY_BOTH  = 3
+};
+
+
+enum open_args_share_access_want4 {
+   OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG           = 3,
+   OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG            = 4,
+   OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL              = 5,
+   OPEN_ARGS_SHARE_ACCESS_WANT_SIGNAL_DELEG_WHEN_RESRC_AVAIL
+                                                   = 17,
+   OPEN_ARGS_SHARE_ACCESS_WANT_PUSH_DELEG_WHEN_UNCONTENDED
+                                                   = 18,
+   OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS    = 20,
+   OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 21
+};
+
+
+enum open_args_open_claim4 {
+   OPEN_ARGS_OPEN_CLAIM_NULL          = 0,
+   OPEN_ARGS_OPEN_CLAIM_PREVIOUS      = 1,
+   OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR  = 2,
+   OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV = 3,
+   OPEN_ARGS_OPEN_CLAIM_FH            = 4,
+   OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH  = 5,
+   OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH = 6
+};
+
+
+enum open_args_createmode4 {
+   OPEN_ARGS_CREATEMODE_UNCHECKED4     = 0,
+   OPEN_ARGS_CREATE_MODE_GUARDED       = 1,
+   OPEN_ARGS_CREATEMODE_EXCLUSIVE4     = 2,
+   OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1  = 3
+};
+
+
+typedef open_arguments4 fattr4_open_arguments;
+pragma public fattr4_open_arguments;
+
+
+%/*
+% * Determine what OPEN supports.
+% */
+const FATTR4_OPEN_ARGUMENTS     = 86;
+
+
+const OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 0x200000;
+
+
+const OPEN4_RESULT_NO_OPEN_STATEID = 0x00000010;
+
+
+/*
+ * attributes for the delegation times being
+ * cached and served by the "client"
+ */
+typedef nfstime4        fattr4_time_deleg_access;
+typedef nfstime4        fattr4_time_deleg_modify;
+
+
+%/*
+% * New RECOMMENDED Attribute for
+% * delegation caching of times
+% */
+const FATTR4_TIME_DELEG_ACCESS  = 84;
+const FATTR4_TIME_DELEG_MODIFY  = 85;
+
+
+const OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 0x100000;
+
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
new file mode 100644
index 000000000000..2503f58f2f47
--- /dev/null
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+// Generated by xdrgen. Manual edits will be lost.
+// XDR specification modification time: Tue Aug 27 12:10:19 2024
+
+#include "nfs4xdr_gen.h"
+
+static bool __maybe_unused
+xdrgen_decode_int64_t(struct xdr_stream *xdr, int64_t *ptr)
+{
+	return xdrgen_decode_hyper(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_uint32_t(struct xdr_stream *xdr, uint32_t *ptr)
+{
+	return xdrgen_decode_unsigned_int(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_bitmap4(struct xdr_stream *xdr, bitmap4 *ptr)
+{
+	if (xdr_stream_decode_u32(xdr, &ptr->count) < 0)
+		return false;
+	for (u32 i = 0; i < ptr->count; i++)
+		if (!xdrgen_decode_uint32_t(xdr, &ptr->element[i]))
+			return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_nfstime4(struct xdr_stream *xdr, struct nfstime4 *ptr)
+{
+	if (!xdrgen_decode_int64_t(xdr, &ptr->seconds))
+		return false;
+	if (!xdrgen_decode_uint32_t(xdr, &ptr->nseconds))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_fattr4_offline(struct xdr_stream *xdr, fattr4_offline *ptr)
+{
+	return xdrgen_decode_bool(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_open_arguments4(struct xdr_stream *xdr, struct open_arguments4 *ptr)
+{
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_access))
+		return false;
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_deny))
+		return false;
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_access_want))
+		return false;
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_open_claim))
+		return false;
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_create_mode))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_open_args_share_access4(struct xdr_stream *xdr, enum open_args_share_access4 *ptr)
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
+xdrgen_decode_open_args_share_deny4(struct xdr_stream *xdr, enum open_args_share_deny4 *ptr)
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
+xdrgen_decode_open_args_share_access_want4(struct xdr_stream *xdr, enum open_args_share_access_want4 *ptr)
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
+xdrgen_decode_open_args_open_claim4(struct xdr_stream *xdr, enum open_args_open_claim4 *ptr)
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
+xdrgen_decode_open_args_createmode4(struct xdr_stream *xdr, enum open_args_createmode4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+bool
+xdrgen_decode_fattr4_open_arguments(struct xdr_stream *xdr, fattr4_open_arguments *ptr)
+{
+	return xdrgen_decode_open_arguments4(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_fattr4_time_deleg_access(struct xdr_stream *xdr, fattr4_time_deleg_access *ptr)
+{
+	return xdrgen_decode_nfstime4(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg_modify *ptr)
+{
+	return xdrgen_decode_nfstime4(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_encode_int64_t(struct xdr_stream *xdr, const int64_t value)
+{
+	return xdrgen_encode_hyper(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_uint32_t(struct xdr_stream *xdr, const uint32_t value)
+{
+	return xdrgen_encode_unsigned_int(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_bitmap4(struct xdr_stream *xdr, const bitmap4 value)
+{
+	if (xdr_stream_encode_u32(xdr, value.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value.count; i++)
+		if (!xdrgen_encode_uint32_t(xdr, value.element[i]))
+			return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_nfstime4(struct xdr_stream *xdr, const struct nfstime4 *value)
+{
+	if (!xdrgen_encode_int64_t(xdr, value->seconds))
+		return false;
+	if (!xdrgen_encode_uint32_t(xdr, value->nseconds))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_fattr4_offline(struct xdr_stream *xdr, const fattr4_offline value)
+{
+	return xdrgen_encode_bool(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_open_arguments4(struct xdr_stream *xdr, const struct open_arguments4 *value)
+{
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_access))
+		return false;
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_deny))
+		return false;
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_access_want))
+		return false;
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_open_claim))
+		return false;
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_create_mode))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_open_args_share_access4(struct xdr_stream *xdr, enum open_args_share_access4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_open_args_share_deny4(struct xdr_stream *xdr, enum open_args_share_deny4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_open_args_share_access_want4(struct xdr_stream *xdr, enum open_args_share_access_want4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_open_args_open_claim4(struct xdr_stream *xdr, enum open_args_open_claim4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_open_args_createmode4(struct xdr_stream *xdr, enum open_args_createmode4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+bool
+xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const fattr4_open_arguments *value)
+{
+	return xdrgen_encode_open_arguments4(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fattr4_time_deleg_access *value)
+{
+	return xdrgen_encode_nfstime4(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fattr4_time_deleg_modify *value)
+{
+	return xdrgen_encode_nfstime4(xdr, value);
+};
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
new file mode 100644
index 000000000000..edcc052626de
--- /dev/null
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Generated by xdrgen. Manual edits will be lost. */
+/* XDR specification modification time: Tue Aug 27 12:10:19 2024 */
+
+#ifndef _LINUX_NFS4_XDRGEN_H
+#define _LINUX_NFS4_XDRGEN_H
+
+#include <linux/types.h>
+#include <linux/sunrpc/svc.h>
+
+#include <linux/sunrpc/xdrgen-builtins.h>
+
+typedef s64 int64_t;
+
+typedef u32 uint32_t;
+
+typedef struct {
+	u32 count;
+	uint32_t *element;
+} bitmap4;
+
+struct nfstime4 {
+	int64_t seconds;
+	uint32_t nseconds;
+};
+
+typedef bool fattr4_offline;
+
+enum { FATTR4_OFFLINE = 83 };
+
+struct open_arguments4 {
+	bitmap4 oa_share_access;
+	bitmap4 oa_share_deny;
+	bitmap4 oa_share_access_want;
+	bitmap4 oa_open_claim;
+	bitmap4 oa_create_mode;
+};
+
+enum open_args_share_access4 {
+	OPEN_ARGS_SHARE_ACCESS_READ = 1,
+	OPEN_ARGS_SHARE_ACCESS_WRITE = 2,
+	OPEN_ARGS_SHARE_ACCESS_BOTH = 3,
+};
+
+enum open_args_share_deny4 {
+	OPEN_ARGS_SHARE_DENY_NONE = 0,
+	OPEN_ARGS_SHARE_DENY_READ = 1,
+	OPEN_ARGS_SHARE_DENY_WRITE = 2,
+	OPEN_ARGS_SHARE_DENY_BOTH = 3,
+};
+
+enum open_args_share_access_want4 {
+	OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG = 3,
+	OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG = 4,
+	OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL = 5,
+	OPEN_ARGS_SHARE_ACCESS_WANT_SIGNAL_DELEG_WHEN_RESRC_AVAIL = 17,
+	OPEN_ARGS_SHARE_ACCESS_WANT_PUSH_DELEG_WHEN_UNCONTENDED = 18,
+	OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 20,
+	OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 21,
+};
+
+enum open_args_open_claim4 {
+	OPEN_ARGS_OPEN_CLAIM_NULL = 0,
+	OPEN_ARGS_OPEN_CLAIM_PREVIOUS = 1,
+	OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR = 2,
+	OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV = 3,
+	OPEN_ARGS_OPEN_CLAIM_FH = 4,
+	OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH = 5,
+	OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH = 6,
+};
+
+enum open_args_createmode4 {
+	OPEN_ARGS_CREATEMODE_UNCHECKED4 = 0,
+	OPEN_ARGS_CREATE_MODE_GUARDED = 1,
+	OPEN_ARGS_CREATEMODE_EXCLUSIVE4 = 2,
+	OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1 = 3,
+};
+
+typedef struct open_arguments4 fattr4_open_arguments;
+bool xdrgen_decode_fattr4_open_arguments(struct xdr_stream *xdr, fattr4_open_arguments *ptr);
+bool xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const fattr4_open_arguments *value);
+
+
+enum { FATTR4_OPEN_ARGUMENTS = 86 };
+
+enum { OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 0x200000 };
+
+enum { OPEN4_RESULT_NO_OPEN_STATEID = 0x00000010 };
+
+typedef struct nfstime4 fattr4_time_deleg_access;
+
+typedef struct nfstime4 fattr4_time_deleg_modify;
+
+enum { FATTR4_TIME_DELEG_ACCESS = 84 };
+
+enum { FATTR4_TIME_DELEG_MODIFY = 85 };
+
+enum { OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 0x100000 };
+
+#endif /* _LINUX_NFS4_XDRGEN_H */
-- 
2.45.2


