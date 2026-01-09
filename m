Return-Path: <linux-nfs+bounces-17697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C56ED0B418
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 17:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37FFF30363DD
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12993644A5;
	Fri,  9 Jan 2026 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIrDtkZc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE5364049
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975711; cv=none; b=O/GvxTMfYLuwO9EoIjZh7AnkPpJ7KnPfGNuzaEbkLnjCTKc/u9q/85RdaF6onaPMEba4h0Udd+IO6WfrlRrOD9rpNU4NeWNL2eMqumWmAWlGp35qSRmK4Q5+q+ZDSNWldNcUx1md+XSN1QGqAay+RgeBnhcmT5ytVlEfWK/XFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975711; c=relaxed/simple;
	bh=WoIjQ3QZMq7VQJKuZ4j/ThYOwfJqX59cyFq+ycqkyDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUIVxgfi8N5tYu1EfQnDayqdQ0ZqWlLpfkYBsuvu1Kbyikjil93899JvghMVhRDqRXEboGZKYA6jy1283aNvNLD2wdkfd3i6s+Vw1A2izxD++8wyBvXD2pighTyE7aR8lW69qe7WXWlM0yb7ROVC3PhykYHC9UURFrzu5vCKXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIrDtkZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A25C4CEF7;
	Fri,  9 Jan 2026 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975711;
	bh=WoIjQ3QZMq7VQJKuZ4j/ThYOwfJqX59cyFq+ycqkyDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIrDtkZcDdgkDPlgBTnoWwklwZ9/49DvCS/uzKZ/BygFAnD1nkd2+PTlOvIgC0MJW
	 orOO0w5RJOzVP1jlylu+8jR8Whk854N/L32Iu1RWGOkNyNkyduMv1AZlNMae7ep+5w
	 RiTfXz728DBYJrLOsgfSors1QMtMQSQRR+XDVxxCsYq5GUgW5PkvpBV0WvuPPqojJq
	 kLHJ8sqkRmJNyZNNu9I6Adw7efXwueejja12dAMorrbjNNKkFWGisZ9BPk2/9u/dRr
	 QAKjfHW+2tZJJU2jKUUCvcxUKqf521AldelTGZKHRjg52ALREiJcnMusj9690WU4C7
	 5R2HV6mCPI1kg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 03/13] Add RPC language definition of NFSv4 POSIX ACL extension
Date: Fri,  9 Jan 2026 11:21:32 -0500
Message-ID: <20260109162143.4186112-4-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109162143.4186112-1-cel@kernel.org>
References: <20260109162143.4186112-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The language definition was extracted from the new
draft-ietf-nfsv4-posix-acls specification. This ensures good
constant and type name alignment between the spec and the Linux
kernel source code, and brings in some basic XDR utilities for
handling NFSv4 POSIX draft ACLs.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/sunrpc/xdr/nfs4_1.x    |  61 +++++++
 fs/nfsd/nfs4xdr_gen.c                | 239 ++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr_gen.h                |  12 +-
 include/linux/nfs4.h                 |   4 +
 include/linux/sunrpc/xdrgen/nfs4_1.h |  97 ++++++++++-
 5 files changed, 410 insertions(+), 3 deletions(-)

diff --git a/Documentation/sunrpc/xdr/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
index ca95150a3a29..5b45547b2ebc 100644
--- a/Documentation/sunrpc/xdr/nfs4_1.x
+++ b/Documentation/sunrpc/xdr/nfs4_1.x
@@ -53,6 +53,11 @@ typedef unsigned int	uint32_t;
  */
 typedef uint32_t	bitmap4<>;
 
+typedef opaque		utf8string<>;
+typedef utf8string	utf8str_cis;
+typedef utf8string	utf8str_cs;
+typedef utf8string	utf8str_mixed;
+
 /*
  * Timeval
  */
@@ -184,3 +189,59 @@ enum open_delegation_type4 {
        OPEN_DELEGATE_READ_ATTRS_DELEG      = 4,
        OPEN_DELEGATE_WRITE_ATTRS_DELEG     = 5
 };
+
+
+/*
+ * The following content was extracted from draft-ietf-nfsv4-posix-acls
+ */
+
+enum aclmodel4 {
+	ACL_MODEL_NFS4		= 1,
+	ACL_MODEL_POSIX_DRAFT	= 2,
+	ACL_MODEL_NONE		= 3
+};
+pragma public aclmodel4;
+
+enum aclscope4 {
+	ACL_SCOPE_FILE_OBJECT	= 1,
+	ACL_SCOPE_FILE_SYSTEM	= 2,
+	ACL_SCOPE_SERVER	= 3
+};
+pragma public aclscope4;
+
+enum posixacetag4 {
+	POSIXACE4_TAG_USER_OBJ	= 1,
+	POSIXACE4_TAG_USER	= 2,
+	POSIXACE4_TAG_GROUP_OBJ	= 3,
+	POSIXACE4_TAG_GROUP	= 4,
+	POSIXACE4_TAG_MASK	= 5,
+	POSIXACE4_TAG_OTHER	= 6
+};
+pragma public posixacetag4;
+
+typedef uint32_t	posixaceperm4;
+pragma public posixaceperm4;
+
+/* Bit definitions for posixaceperm4. */
+const POSIXACE4_PERM_EXECUTE	= 0x00000001;
+const POSIXACE4_PERM_WRITE	= 0x00000002;
+const POSIXACE4_PERM_READ	= 0x00000004;
+
+struct posixace4 {
+	posixacetag4		tag;
+	posixaceperm4		perm;
+	utf8str_mixed		who;
+};
+
+typedef aclmodel4	fattr4_acl_trueform;
+typedef aclscope4	fattr4_acl_trueform_scope;
+typedef posixace4	fattr4_posix_default_acl<>;
+typedef posixace4	fattr4_posix_access_acl<>;
+
+%/*
+% * New for POSIX ACL extension
+% */
+const FATTR4_ACL_TRUEFORM	= 89;
+const FATTR4_ACL_TRUEFORM_SCOPE	= 90;
+const FATTR4_POSIX_DEFAULT_ACL	= 91;
+const FATTR4_POSIX_ACCESS_ACL	= 92;
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index ce5c36e9070a..824497051b87 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x
-// XDR specification modification time: Thu Jan  8 23:11:48 2026
+// XDR specification modification time: Thu Jan  8 23:12:07 2026
 
 #include <linux/sunrpc/svc.h>
 
@@ -30,6 +30,30 @@ xdrgen_decode_bitmap4(struct xdr_stream *xdr, bitmap4 *ptr)
 	return true;
 }
 
+static bool __maybe_unused
+xdrgen_decode_utf8string(struct xdr_stream *xdr, utf8string *ptr)
+{
+	return xdrgen_decode_opaque(xdr, ptr, 0);
+}
+
+static bool __maybe_unused
+xdrgen_decode_utf8str_cis(struct xdr_stream *xdr, utf8str_cis *ptr)
+{
+	return xdrgen_decode_utf8string(xdr, ptr);
+}
+
+static bool __maybe_unused
+xdrgen_decode_utf8str_cs(struct xdr_stream *xdr, utf8str_cs *ptr)
+{
+	return xdrgen_decode_utf8string(xdr, ptr);
+}
+
+static bool __maybe_unused
+xdrgen_decode_utf8str_mixed(struct xdr_stream *xdr, utf8str_mixed *ptr)
+{
+	return xdrgen_decode_utf8string(xdr, ptr);
+}
+
 static bool __maybe_unused
 xdrgen_decode_nfstime4(struct xdr_stream *xdr, struct nfstime4 *ptr)
 {
@@ -222,6 +246,125 @@ xdrgen_decode_open_delegation_type4(struct xdr_stream *xdr, open_delegation_type
 	return true;
 }
 
+bool
+xdrgen_decode_aclmodel4(struct xdr_stream *xdr, aclmodel4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	/* Compiler may optimize to a range check for dense enums */
+	switch (val) {
+	case ACL_MODEL_NFS4:
+	case ACL_MODEL_POSIX_DRAFT:
+	case ACL_MODEL_NONE:
+		break;
+	default:
+		return false;
+	}
+	*ptr = val;
+	return true;
+}
+
+bool
+xdrgen_decode_aclscope4(struct xdr_stream *xdr, aclscope4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	/* Compiler may optimize to a range check for dense enums */
+	switch (val) {
+	case ACL_SCOPE_FILE_OBJECT:
+	case ACL_SCOPE_FILE_SYSTEM:
+	case ACL_SCOPE_SERVER:
+		break;
+	default:
+		return false;
+	}
+	*ptr = val;
+	return true;
+}
+
+bool
+xdrgen_decode_posixacetag4(struct xdr_stream *xdr, posixacetag4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	/* Compiler may optimize to a range check for dense enums */
+	switch (val) {
+	case POSIXACE4_TAG_USER_OBJ:
+	case POSIXACE4_TAG_USER:
+	case POSIXACE4_TAG_GROUP_OBJ:
+	case POSIXACE4_TAG_GROUP:
+	case POSIXACE4_TAG_MASK:
+	case POSIXACE4_TAG_OTHER:
+		break;
+	default:
+		return false;
+	}
+	*ptr = val;
+	return true;
+}
+
+bool
+xdrgen_decode_posixaceperm4(struct xdr_stream *xdr, posixaceperm4 *ptr)
+{
+	return xdrgen_decode_uint32_t(xdr, ptr);
+}
+
+static bool __maybe_unused
+xdrgen_decode_posixace4(struct xdr_stream *xdr, struct posixace4 *ptr)
+{
+	if (!xdrgen_decode_posixacetag4(xdr, &ptr->tag))
+		return false;
+	if (!xdrgen_decode_posixaceperm4(xdr, &ptr->perm))
+		return false;
+	if (!xdrgen_decode_utf8str_mixed(xdr, &ptr->who))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_fattr4_acl_trueform(struct xdr_stream *xdr, fattr4_acl_trueform *ptr)
+{
+	return xdrgen_decode_aclmodel4(xdr, ptr);
+}
+
+static bool __maybe_unused
+xdrgen_decode_fattr4_acl_trueform_scope(struct xdr_stream *xdr, fattr4_acl_trueform_scope *ptr)
+{
+	return xdrgen_decode_aclscope4(xdr, ptr);
+}
+
+static bool __maybe_unused
+xdrgen_decode_fattr4_posix_default_acl(struct xdr_stream *xdr, fattr4_posix_default_acl *ptr)
+{
+	if (xdr_stream_decode_u32(xdr, &ptr->count) < 0)
+		return false;
+	for (u32 i = 0; i < ptr->count; i++)
+		if (!xdrgen_decode_posixace4(xdr, &ptr->element[i]))
+			return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_fattr4_posix_access_acl(struct xdr_stream *xdr, fattr4_posix_access_acl *ptr)
+{
+	if (xdr_stream_decode_u32(xdr, &ptr->count) < 0)
+		return false;
+	for (u32 i = 0; i < ptr->count; i++)
+		if (!xdrgen_decode_posixace4(xdr, &ptr->element[i]))
+			return false;
+	return true;
+}
+
+/*
+ * New for POSIX ACL extension
+ */
+
 static bool __maybe_unused
 xdrgen_encode_int64_t(struct xdr_stream *xdr, const int64_t value)
 {
@@ -245,6 +388,30 @@ xdrgen_encode_bitmap4(struct xdr_stream *xdr, const bitmap4 value)
 	return true;
 }
 
+static bool __maybe_unused
+xdrgen_encode_utf8string(struct xdr_stream *xdr, const utf8string value)
+{
+	return xdr_stream_encode_opaque(xdr, value.data, value.len) >= 0;
+}
+
+static bool __maybe_unused
+xdrgen_encode_utf8str_cis(struct xdr_stream *xdr, const utf8str_cis value)
+{
+	return xdrgen_encode_utf8string(xdr, value);
+}
+
+static bool __maybe_unused
+xdrgen_encode_utf8str_cs(struct xdr_stream *xdr, const utf8str_cs value)
+{
+	return xdrgen_encode_utf8string(xdr, value);
+}
+
+static bool __maybe_unused
+xdrgen_encode_utf8str_mixed(struct xdr_stream *xdr, const utf8str_mixed value)
+{
+	return xdrgen_encode_utf8string(xdr, value);
+}
+
 static bool __maybe_unused
 xdrgen_encode_nfstime4(struct xdr_stream *xdr, const struct nfstime4 *value)
 {
@@ -330,3 +497,73 @@ xdrgen_encode_open_delegation_type4(struct xdr_stream *xdr, open_delegation_type
 {
 	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
 }
+
+bool
+xdrgen_encode_aclmodel4(struct xdr_stream *xdr, aclmodel4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+bool
+xdrgen_encode_aclscope4(struct xdr_stream *xdr, aclscope4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+bool
+xdrgen_encode_posixacetag4(struct xdr_stream *xdr, posixacetag4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+bool
+xdrgen_encode_posixaceperm4(struct xdr_stream *xdr, const posixaceperm4 value)
+{
+	return xdrgen_encode_uint32_t(xdr, value);
+}
+
+static bool __maybe_unused
+xdrgen_encode_posixace4(struct xdr_stream *xdr, const struct posixace4 *value)
+{
+	if (!xdrgen_encode_posixacetag4(xdr, value->tag))
+		return false;
+	if (!xdrgen_encode_posixaceperm4(xdr, value->perm))
+		return false;
+	if (!xdrgen_encode_utf8str_mixed(xdr, value->who))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_fattr4_acl_trueform(struct xdr_stream *xdr, const fattr4_acl_trueform value)
+{
+	return xdrgen_encode_aclmodel4(xdr, value);
+}
+
+static bool __maybe_unused
+xdrgen_encode_fattr4_acl_trueform_scope(struct xdr_stream *xdr, const fattr4_acl_trueform_scope value)
+{
+	return xdrgen_encode_aclscope4(xdr, value);
+}
+
+static bool __maybe_unused
+xdrgen_encode_fattr4_posix_default_acl(struct xdr_stream *xdr, const fattr4_posix_default_acl value)
+{
+	if (xdr_stream_encode_u32(xdr, value.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value.count; i++)
+		if (!xdrgen_encode_posixace4(xdr, &value.element[i]))
+			return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_fattr4_posix_access_acl(struct xdr_stream *xdr, const fattr4_posix_access_acl value)
+{
+	if (xdr_stream_encode_u32(xdr, value.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value.count; i++)
+		if (!xdrgen_encode_posixace4(xdr, &value.element[i]))
+			return false;
+	return true;
+}
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
index 8dfe10246506..1c487f1a11ab 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Thu Jan  8 23:11:48 2026 */
+/* XDR specification modification time: Thu Jan  8 23:12:07 2026 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DECL_H
 #define _LINUX_XDRGEN_NFS4_1_DECL_H
@@ -21,5 +21,15 @@ bool xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fattr4
 
 bool xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg_modify *ptr);
 bool xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fattr4_time_deleg_modify *value);
+bool xdrgen_decode_aclmodel4(struct xdr_stream *xdr, aclmodel4 *ptr);
+bool xdrgen_encode_aclmodel4(struct xdr_stream *xdr, aclmodel4 value);
+bool xdrgen_decode_aclscope4(struct xdr_stream *xdr, aclscope4 *ptr);
+bool xdrgen_encode_aclscope4(struct xdr_stream *xdr, aclscope4 value);
+bool xdrgen_decode_posixacetag4(struct xdr_stream *xdr, posixacetag4 *ptr);
+bool xdrgen_encode_posixacetag4(struct xdr_stream *xdr, posixacetag4 value);
+
+bool xdrgen_decode_posixaceperm4(struct xdr_stream *xdr, posixaceperm4 *ptr);
+bool xdrgen_encode_posixaceperm4(struct xdr_stream *xdr, const posixaceperm4 value);
+
 
 #endif /* _LINUX_XDRGEN_NFS4_1_DECL_H */
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index e947af6a3684..d87be1f25273 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -598,6 +598,10 @@ enum {
 #define FATTR4_WORD2_TIME_DELEG_ACCESS	BIT(FATTR4_TIME_DELEG_ACCESS - 64)
 #define FATTR4_WORD2_TIME_DELEG_MODIFY	BIT(FATTR4_TIME_DELEG_MODIFY - 64)
 #define FATTR4_WORD2_OPEN_ARGUMENTS	BIT(FATTR4_OPEN_ARGUMENTS - 64)
+#define FATTR4_WORD2_ACL_TRUEFORM	BIT(FATTR4_ACL_TRUEFORM - 64)
+#define FATTR4_WORD2_ACL_TRUEFORM_SCOPE	BIT(FATTR4_ACL_TRUEFORM_SCOPE - 64)
+#define FATTR4_WORD2_POSIX_DEFAULT_ACL	BIT(FATTR4_POSIX_DEFAULT_ACL - 64)
+#define FATTR4_WORD2_POSIX_ACCESS_ACL	BIT(FATTR4_POSIX_ACCESS_ACL - 64)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)
diff --git a/include/linux/sunrpc/xdrgen/nfs4_1.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
index 5283739242c7..4ac54bdbd335 100644
--- a/include/linux/sunrpc/xdrgen/nfs4_1.h
+++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Thu Jan  8 23:11:48 2026 */
+/* XDR specification modification time: Thu Jan  8 23:12:07 2026 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DEF_H
 #define _LINUX_XDRGEN_NFS4_1_DEF_H
@@ -18,6 +18,14 @@ typedef struct {
 	uint32_t *element;
 } bitmap4;
 
+typedef opaque utf8string;
+
+typedef utf8string utf8str_cis;
+
+typedef utf8string utf8str_cs;
+
+typedef utf8string utf8str_mixed;
+
 struct nfstime4 {
 	int64_t seconds;
 	uint32_t nseconds;
@@ -141,11 +149,85 @@ enum open_delegation_type4 {
 
 typedef enum open_delegation_type4 open_delegation_type4;
 
+enum aclmodel4 {
+	ACL_MODEL_NFS4 = 1,
+	ACL_MODEL_POSIX_DRAFT = 2,
+	ACL_MODEL_NONE = 3,
+};
+
+typedef enum aclmodel4 aclmodel4;
+
+enum aclscope4 {
+	ACL_SCOPE_FILE_OBJECT = 1,
+	ACL_SCOPE_FILE_SYSTEM = 2,
+	ACL_SCOPE_SERVER = 3,
+};
+
+typedef enum aclscope4 aclscope4;
+
+enum posixacetag4 {
+	POSIXACE4_TAG_USER_OBJ = 1,
+	POSIXACE4_TAG_USER = 2,
+	POSIXACE4_TAG_GROUP_OBJ = 3,
+	POSIXACE4_TAG_GROUP = 4,
+	POSIXACE4_TAG_MASK = 5,
+	POSIXACE4_TAG_OTHER = 6,
+};
+
+typedef enum posixacetag4 posixacetag4;
+
+typedef uint32_t posixaceperm4;
+
+enum { POSIXACE4_PERM_EXECUTE = 0x00000001 };
+
+enum { POSIXACE4_PERM_WRITE = 0x00000002 };
+
+enum { POSIXACE4_PERM_READ = 0x00000004 };
+
+struct posixace4 {
+	posixacetag4 tag;
+	posixaceperm4 perm;
+	utf8str_mixed who;
+};
+
+typedef aclmodel4 fattr4_acl_trueform;
+
+typedef aclscope4 fattr4_acl_trueform_scope;
+
+typedef struct {
+	u32 count;
+	struct posixace4 *element;
+} fattr4_posix_default_acl;
+
+typedef struct {
+	u32 count;
+	struct posixace4 *element;
+} fattr4_posix_access_acl;
+
+/*
+ * New for POSIX ACL extension
+ */
+
+enum { FATTR4_ACL_TRUEFORM = 89 };
+
+enum { FATTR4_ACL_TRUEFORM_SCOPE = 90 };
+
+enum { FATTR4_POSIX_DEFAULT_ACL = 91 };
+
+enum { FATTR4_POSIX_ACCESS_ACL = 92 };
+
 #define NFS4_int64_t_sz                 \
 	(XDR_hyper)
 #define NFS4_uint32_t_sz                \
 	(XDR_unsigned_int)
 #define NFS4_bitmap4_sz                 (XDR_unsigned_int)
+#define NFS4_utf8string_sz              (XDR_unsigned_int)
+#define NFS4_utf8str_cis_sz             \
+	(NFS4_utf8string_sz)
+#define NFS4_utf8str_cs_sz              \
+	(NFS4_utf8string_sz)
+#define NFS4_utf8str_mixed_sz           \
+	(NFS4_utf8string_sz)
 #define NFS4_nfstime4_sz                \
 	(NFS4_int64_t_sz + NFS4_uint32_t_sz)
 #define NFS4_fattr4_offline_sz          \
@@ -164,5 +246,18 @@ typedef enum open_delegation_type4 open_delegation_type4;
 #define NFS4_fattr4_time_deleg_modify_sz \
 	(NFS4_nfstime4_sz)
 #define NFS4_open_delegation_type4_sz   (XDR_int)
+#define NFS4_aclmodel4_sz               (XDR_int)
+#define NFS4_aclscope4_sz               (XDR_int)
+#define NFS4_posixacetag4_sz            (XDR_int)
+#define NFS4_posixaceperm4_sz           \
+	(NFS4_uint32_t_sz)
+#define NFS4_posixace4_sz               \
+	(NFS4_posixacetag4_sz + NFS4_posixaceperm4_sz + NFS4_utf8str_mixed_sz)
+#define NFS4_fattr4_acl_trueform_sz     \
+	(NFS4_aclmodel4_sz)
+#define NFS4_fattr4_acl_trueform_scope_sz \
+	(NFS4_aclscope4_sz)
+#define NFS4_fattr4_posix_default_acl_sz (XDR_unsigned_int)
+#define NFS4_fattr4_posix_access_acl_sz (XDR_unsigned_int)
 
 #endif /* _LINUX_XDRGEN_NFS4_1_DEF_H */
-- 
2.52.0


