Return-Path: <linux-nfs+bounces-23281-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lOQgNSf9U2qVggMAu9opvQ
	(envelope-from <linux-nfs+bounces-23281-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 441AA745E10
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l06Hxd49;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23281-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23281-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1472300DDDD
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 20:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C677E0E4;
	Sun, 12 Jul 2026 20:46:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8963B2D14
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 20:46:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783889164; cv=none; b=az1rNWWeAW+bHVkilOi4mkMXlvYNKJTsRMgkoQzz+JCOsHMyEBVdoJLCaaY8WDY+MlU5GjMJEg6kbaG7MWaS0C6q7uEvAeI1Pm2stZDw26v+k+hQ8D6yISonP2U22iHXY5JjdGhPXHAk2CLF1F29/MuYEt8nAyrpv1Q0LSkk9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783889164; c=relaxed/simple;
	bh=uqG5sOM0q2zgId50xGJf0Y51ny2cYG61Fzou3drKEbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTNMIgr/raAjUxCe38/nhEmEtwqWl9datITyZk3d6f+PLUfeG+i5Syly57GtoluVyG2Gaiey0xaFnLbguh7zMiPkGI6FPbAvV2hGrNlXynRTlX/Bi8PI0vubcZIyO4Q8v3/APZ+GWqmmUarFl9yHPdtPXHNH8B2Gre/HthT0Gac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l06Hxd49; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D8C1F00A3E;
	Sun, 12 Jul 2026 20:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783889163;
	bh=aUOVJ6DRTvA8HLm8Ieque6cvXagne0S/VQVdgI1FUGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l06Hxd49KSUiiLmYgUscNPeho/zashVgI0YjOpCwHxnYwj9Qs9HOwx98ZcLFzcIvA
	 5v31iHzjS/DX7VD2NGp95OnbgzXITHpThxP7p48IL1bghJaKI+hR9/eRKSsjQUdP84
	 NikgRhhnpeTY8NnGa6gDw7tS1ZBx/xEn/uRCVD71cBne7vvzlvMZ6cV689WjagDSFI
	 YkU0NcceAofxmLJ6cR1cUjehDLWW4xyohTc6odU5q+YYNF0YgaOWyeU2nXKWeYwxQS
	 JH6I39nbI31iRJTDP4sfeJ9OoKj7zG2qPaCi+GxV3lTvmzIeD+0YchSY/9iLKtSncH
	 a5oTHvpM7KLaA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 9/9] NFSD: Relocate NFSv4 "supported attributes" to new header
Date: Sun, 12 Jul 2026 16:45:54 -0400
Message-ID: <20260712204554.125308-10-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712204554.125308-1-cel@kernel.org>
References: <20260712204554.125308-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23281-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:jlayton@kernel.org,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 441AA745E10

These NFSv4 attribute bitmask definitions live in nfsd.h, which
nearly every nfsd source file includes, yet only nfs4proc.c and
nfs4xdr.c reference them. Move them to a dedicated header so only
those two consumers pull them in.

While moving the block, correct the stale QUOTA_* annotation: the
promised support never materialized, so these attributes are
unlikely to be supported any time soon rather than forthcoming.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/attr4.h    | 162 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4proc.c |   1 +
 fs/nfsd/nfs4xdr.c  |   1 +
 fs/nfsd/nfsd.h     | 150 -----------------------------------------
 4 files changed, 164 insertions(+), 150 deletions(-)
 create mode 100644 fs/nfsd/attr4.h

diff --git a/fs/nfsd/attr4.h b/fs/nfsd/attr4.h
new file mode 100644
index 000000000000..f0b51f8050b7
--- /dev/null
+++ b/fs/nfsd/attr4.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * NFSv4 file attributes supported by this implementation
+ */
+
+#ifndef _LINUX_NFSD_ATTR4_H
+#define _LINUX_NFSD_ATTR4_H
+
+#include <linux/types.h>
+#include <linux/nfs4.h>
+
+/*
+ * The following attributes are not implemented by NFSD:
+ *    ARCHIVE       (deprecated anyway)
+ *    HIDDEN        (unlikely to be supported any time soon)
+ *    MIMETYPE      (unlikely to be supported any time soon)
+ *    QUOTA_*       (unlikely to be supported any time soon)
+ *    SYSTEM        (unlikely to be supported any time soon)
+ *    TIME_BACKUP   (unlikely to be supported any time soon)
+ */
+#define NFSD4_SUPPORTED_ATTRS_WORD0                                                         \
+(FATTR4_WORD0_SUPPORTED_ATTRS   | FATTR4_WORD0_TYPE         | FATTR4_WORD0_FH_EXPIRE_TYPE   \
+ | FATTR4_WORD0_CHANGE          | FATTR4_WORD0_SIZE         | FATTR4_WORD0_LINK_SUPPORT     \
+ | FATTR4_WORD0_SYMLINK_SUPPORT | FATTR4_WORD0_NAMED_ATTR   | FATTR4_WORD0_FSID             \
+ | FATTR4_WORD0_UNIQUE_HANDLES  | FATTR4_WORD0_LEASE_TIME   | FATTR4_WORD0_RDATTR_ERROR     \
+ | FATTR4_WORD0_ACLSUPPORT      | FATTR4_WORD0_CANSETTIME   | FATTR4_WORD0_CASE_INSENSITIVE \
+ | FATTR4_WORD0_CASE_PRESERVING | FATTR4_WORD0_CHOWN_RESTRICTED                             \
+ | FATTR4_WORD0_FILEHANDLE      | FATTR4_WORD0_FILEID       | FATTR4_WORD0_FILES_AVAIL      \
+ | FATTR4_WORD0_FILES_FREE      | FATTR4_WORD0_FILES_TOTAL  | FATTR4_WORD0_FS_LOCATIONS | FATTR4_WORD0_HOMOGENEOUS      \
+ | FATTR4_WORD0_MAXFILESIZE     | FATTR4_WORD0_MAXLINK      | FATTR4_WORD0_MAXNAME          \
+ | FATTR4_WORD0_MAXREAD         | FATTR4_WORD0_MAXWRITE     | FATTR4_WORD0_ACL)
+
+#define NFSD4_SUPPORTED_ATTRS_WORD1                                                         \
+(FATTR4_WORD1_MODE              | FATTR4_WORD1_NO_TRUNC     | FATTR4_WORD1_NUMLINKS         \
+ | FATTR4_WORD1_OWNER	        | FATTR4_WORD1_OWNER_GROUP  | FATTR4_WORD1_RAWDEV           \
+ | FATTR4_WORD1_SPACE_AVAIL     | FATTR4_WORD1_SPACE_FREE   | FATTR4_WORD1_SPACE_TOTAL      \
+ | FATTR4_WORD1_SPACE_USED      | FATTR4_WORD1_TIME_ACCESS  | FATTR4_WORD1_TIME_ACCESS_SET  \
+ | FATTR4_WORD1_TIME_DELTA      | FATTR4_WORD1_TIME_METADATA   | FATTR4_WORD1_TIME_CREATE      \
+ | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_WORD1_MOUNTED_ON_FILEID)
+
+#define NFSD4_SUPPORTED_ATTRS_WORD2 0
+
+/* 4.1 */
+#ifdef CONFIG_NFSD_PNFS
+#define PNFSD_SUPPORTED_ATTRS_WORD1	FATTR4_WORD1_FS_LAYOUT_TYPES
+#define PNFSD_SUPPORTED_ATTRS_WORD2 \
+(FATTR4_WORD2_LAYOUT_BLKSIZE	| FATTR4_WORD2_LAYOUT_TYPES)
+#else
+#define PNFSD_SUPPORTED_ATTRS_WORD1	0
+#define PNFSD_SUPPORTED_ATTRS_WORD2	0
+#endif /* CONFIG_NFSD_PNFS */
+
+#define NFSD4_1_SUPPORTED_ATTRS_WORD0 \
+	NFSD4_SUPPORTED_ATTRS_WORD0
+
+#define NFSD4_1_SUPPORTED_ATTRS_WORD1 \
+	(NFSD4_SUPPORTED_ATTRS_WORD1	| PNFSD_SUPPORTED_ATTRS_WORD1)
+
+#define NFSD4_1_SUPPORTED_ATTRS_WORD2 \
+	(NFSD4_SUPPORTED_ATTRS_WORD2	| PNFSD_SUPPORTED_ATTRS_WORD2 | \
+	 FATTR4_WORD2_SUPPATTR_EXCLCREAT)
+
+/* 4.2 */
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+#define NFSD4_2_SECURITY_ATTRS		FATTR4_WORD2_SECURITY_LABEL
+#else
+#define NFSD4_2_SECURITY_ATTRS		0
+#endif
+
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+#define NFSD4_2_POSIX_ACL_ATTRS \
+	(FATTR4_WORD2_ACL_TRUEFORM | \
+	FATTR4_WORD2_ACL_TRUEFORM_SCOPE | \
+	FATTR4_WORD2_POSIX_DEFAULT_ACL | \
+	FATTR4_WORD2_POSIX_ACCESS_ACL)
+#else
+#define NFSD4_2_POSIX_ACL_ATTRS		0
+#endif
+
+#define NFSD4_2_SUPPORTED_ATTRS_WORD2 \
+	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
+	FATTR4_WORD2_MODE_UMASK | \
+	FATTR4_WORD2_CLONE_BLKSIZE | \
+	NFSD4_2_SECURITY_ATTRS | \
+	FATTR4_WORD2_XATTR_SUPPORT | \
+	FATTR4_WORD2_TIME_DELEG_ACCESS | \
+	FATTR4_WORD2_TIME_DELEG_MODIFY | \
+	FATTR4_WORD2_OPEN_ARGUMENTS | \
+	NFSD4_2_POSIX_ACL_ATTRS)
+
+/* These will return ERR_INVAL if specified in GETATTR or READDIR. */
+#define NFSD_WRITEONLY_ATTRS_WORD1 \
+	(FATTR4_WORD1_TIME_ACCESS_SET   | FATTR4_WORD1_TIME_MODIFY_SET)
+
+/*
+ * These are the only attrs allowed in CREATE/OPEN/SETATTR. Don't add
+ * a writeable attribute here without also adding code to parse it to
+ * nfsd4_decode_fattr4().
+ */
+#define NFSD_WRITEABLE_ATTRS_WORD0 \
+	(FATTR4_WORD0_SIZE | FATTR4_WORD0_ACL)
+#define NFSD_WRITEABLE_ATTRS_WORD1 \
+	(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP \
+	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_CREATE \
+	| FATTR4_WORD1_TIME_MODIFY_SET)
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+#define MAYBE_FATTR4_WORD2_SECURITY_LABEL \
+	FATTR4_WORD2_SECURITY_LABEL
+#else
+#define MAYBE_FATTR4_WORD2_SECURITY_LABEL 0
+#endif
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+#define MAYBE_FATTR4_WORD2_POSIX_ACL_ATTRS \
+	FATTR4_WORD2_POSIX_DEFAULT_ACL | FATTR4_WORD2_POSIX_ACCESS_ACL
+#else
+#define MAYBE_FATTR4_WORD2_POSIX_ACL_ATTRS 0
+#endif
+#define NFSD_WRITEABLE_ATTRS_WORD2 \
+	(FATTR4_WORD2_MODE_UMASK \
+	| MAYBE_FATTR4_WORD2_SECURITY_LABEL \
+	| FATTR4_WORD2_TIME_DELEG_ACCESS \
+	| FATTR4_WORD2_TIME_DELEG_MODIFY \
+	| MAYBE_FATTR4_WORD2_POSIX_ACL_ATTRS \
+	)
+
+#define NFSD_SUPPATTR_EXCLCREAT_WORD0 \
+	NFSD_WRITEABLE_ATTRS_WORD0
+/*
+ * we currently store the exclusive create verifier in the v_{a,m}time
+ * attributes so the client can't set these at create time using EXCLUSIVE4_1
+ */
+#define NFSD_SUPPATTR_EXCLCREAT_WORD1 \
+	(NFSD_WRITEABLE_ATTRS_WORD1 & \
+	 ~(FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_MODIFY_SET))
+/*
+ * The FATTR4_WORD2_TIME_DELEG attributes are not to be allowed for
+ * OPEN(create) with EXCLUSIVE4_1. It doesn't make sense to set a
+ * delegated timestamp on a new file.
+ *
+ * This mask includes NFSv4.2-only attributes (e.g., POSIX ACLs).
+ * Version filtering occurs via nfsd_suppattrs[] before this mask
+ * is applied, so pre-4.2 clients never see unsupported attributes.
+ */
+#define NFSD_SUPPATTR_EXCLCREAT_WORD2 \
+	(NFSD_WRITEABLE_ATTRS_WORD2 & \
+	~(FATTR4_WORD2_TIME_DELEG_ACCESS | FATTR4_WORD2_TIME_DELEG_MODIFY))
+
+extern const u32 nfsd_suppattrs[3][3];
+
+static inline bool bmval_is_subset(const u32 *bm1, const u32 *bm2)
+{
+	return !((bm1[0] & ~bm2[0]) ||
+	         (bm1[1] & ~bm2[1]) ||
+		 (bm1[2] & ~bm2[2]));
+}
+
+static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
+{
+	return bmval_is_subset(bmval, nfsd_suppattrs[minorversion]);
+}
+
+#endif /* _LINUX_NFSD_ATTR4_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 59889cdca109..9031a5bdb0fc 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -42,6 +42,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_ssc.h>
 
+#include "attr4.h"
 #include "idmap.h"
 #include "cache.h"
 #include "xdr4.h"
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index cba2e72d616c..29105580c203 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -47,6 +47,7 @@
 
 #include <uapi/linux/xattr.h>
 
+#include "attr4.h"
 #include "auth.h"
 #include "idmap.h"
 #include "acl.h"
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 33015657b16f..76a69d9a4e73 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -367,156 +367,6 @@ enum {
 #define NFSD_DELEGRETURN_TIMEOUT	(HZ / 34)	/* 30ms */
 #define	NFSD_CB_GETATTR_TIMEOUT		NFSD_DELEGRETURN_TIMEOUT
 
-/*
- * The following attributes are not implemented by NFSD:
- *    ARCHIVE       (deprecated anyway)
- *    HIDDEN        (unlikely to be supported any time soon)
- *    MIMETYPE      (unlikely to be supported any time soon)
- *    QUOTA_*       (will be supported in a forthcoming patch)
- *    SYSTEM        (unlikely to be supported any time soon)
- *    TIME_BACKUP   (unlikely to be supported any time soon)
- */
-#define NFSD4_SUPPORTED_ATTRS_WORD0                                                         \
-(FATTR4_WORD0_SUPPORTED_ATTRS   | FATTR4_WORD0_TYPE         | FATTR4_WORD0_FH_EXPIRE_TYPE   \
- | FATTR4_WORD0_CHANGE          | FATTR4_WORD0_SIZE         | FATTR4_WORD0_LINK_SUPPORT     \
- | FATTR4_WORD0_SYMLINK_SUPPORT | FATTR4_WORD0_NAMED_ATTR   | FATTR4_WORD0_FSID             \
- | FATTR4_WORD0_UNIQUE_HANDLES  | FATTR4_WORD0_LEASE_TIME   | FATTR4_WORD0_RDATTR_ERROR     \
- | FATTR4_WORD0_ACLSUPPORT      | FATTR4_WORD0_CANSETTIME   | FATTR4_WORD0_CASE_INSENSITIVE \
- | FATTR4_WORD0_CASE_PRESERVING | FATTR4_WORD0_CHOWN_RESTRICTED                             \
- | FATTR4_WORD0_FILEHANDLE      | FATTR4_WORD0_FILEID       | FATTR4_WORD0_FILES_AVAIL      \
- | FATTR4_WORD0_FILES_FREE      | FATTR4_WORD0_FILES_TOTAL  | FATTR4_WORD0_FS_LOCATIONS | FATTR4_WORD0_HOMOGENEOUS      \
- | FATTR4_WORD0_MAXFILESIZE     | FATTR4_WORD0_MAXLINK      | FATTR4_WORD0_MAXNAME          \
- | FATTR4_WORD0_MAXREAD         | FATTR4_WORD0_MAXWRITE     | FATTR4_WORD0_ACL)
-
-#define NFSD4_SUPPORTED_ATTRS_WORD1                                                         \
-(FATTR4_WORD1_MODE              | FATTR4_WORD1_NO_TRUNC     | FATTR4_WORD1_NUMLINKS         \
- | FATTR4_WORD1_OWNER	        | FATTR4_WORD1_OWNER_GROUP  | FATTR4_WORD1_RAWDEV           \
- | FATTR4_WORD1_SPACE_AVAIL     | FATTR4_WORD1_SPACE_FREE   | FATTR4_WORD1_SPACE_TOTAL      \
- | FATTR4_WORD1_SPACE_USED      | FATTR4_WORD1_TIME_ACCESS  | FATTR4_WORD1_TIME_ACCESS_SET  \
- | FATTR4_WORD1_TIME_DELTA      | FATTR4_WORD1_TIME_METADATA   | FATTR4_WORD1_TIME_CREATE      \
- | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_WORD1_MOUNTED_ON_FILEID)
-
-#define NFSD4_SUPPORTED_ATTRS_WORD2 0
-
-/* 4.1 */
-#ifdef CONFIG_NFSD_PNFS
-#define PNFSD_SUPPORTED_ATTRS_WORD1	FATTR4_WORD1_FS_LAYOUT_TYPES
-#define PNFSD_SUPPORTED_ATTRS_WORD2 \
-(FATTR4_WORD2_LAYOUT_BLKSIZE	| FATTR4_WORD2_LAYOUT_TYPES)
-#else
-#define PNFSD_SUPPORTED_ATTRS_WORD1	0
-#define PNFSD_SUPPORTED_ATTRS_WORD2	0
-#endif /* CONFIG_NFSD_PNFS */
-
-#define NFSD4_1_SUPPORTED_ATTRS_WORD0 \
-	NFSD4_SUPPORTED_ATTRS_WORD0
-
-#define NFSD4_1_SUPPORTED_ATTRS_WORD1 \
-	(NFSD4_SUPPORTED_ATTRS_WORD1	| PNFSD_SUPPORTED_ATTRS_WORD1)
-
-#define NFSD4_1_SUPPORTED_ATTRS_WORD2 \
-	(NFSD4_SUPPORTED_ATTRS_WORD2	| PNFSD_SUPPORTED_ATTRS_WORD2 | \
-	 FATTR4_WORD2_SUPPATTR_EXCLCREAT)
-
-/* 4.2 */
-#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-#define NFSD4_2_SECURITY_ATTRS		FATTR4_WORD2_SECURITY_LABEL
-#else
-#define NFSD4_2_SECURITY_ATTRS		0
-#endif
-
-#ifdef CONFIG_NFSD_V4_POSIX_ACLS
-#define NFSD4_2_POSIX_ACL_ATTRS \
-	(FATTR4_WORD2_ACL_TRUEFORM | \
-	FATTR4_WORD2_ACL_TRUEFORM_SCOPE | \
-	FATTR4_WORD2_POSIX_DEFAULT_ACL | \
-	FATTR4_WORD2_POSIX_ACCESS_ACL)
-#else
-#define NFSD4_2_POSIX_ACL_ATTRS		0
-#endif
-
-#define NFSD4_2_SUPPORTED_ATTRS_WORD2 \
-	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
-	FATTR4_WORD2_MODE_UMASK | \
-	FATTR4_WORD2_CLONE_BLKSIZE | \
-	NFSD4_2_SECURITY_ATTRS | \
-	FATTR4_WORD2_XATTR_SUPPORT | \
-	FATTR4_WORD2_TIME_DELEG_ACCESS | \
-	FATTR4_WORD2_TIME_DELEG_MODIFY | \
-	FATTR4_WORD2_OPEN_ARGUMENTS | \
-	NFSD4_2_POSIX_ACL_ATTRS)
-
-extern const u32 nfsd_suppattrs[3][3];
-
-static inline bool bmval_is_subset(const u32 *bm1, const u32 *bm2)
-{
-	return !((bm1[0] & ~bm2[0]) ||
-	         (bm1[1] & ~bm2[1]) ||
-		 (bm1[2] & ~bm2[2]));
-}
-
-static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
-{
-	return bmval_is_subset(bmval, nfsd_suppattrs[minorversion]);
-}
-
-/* These will return ERR_INVAL if specified in GETATTR or READDIR. */
-#define NFSD_WRITEONLY_ATTRS_WORD1 \
-	(FATTR4_WORD1_TIME_ACCESS_SET   | FATTR4_WORD1_TIME_MODIFY_SET)
-
-/*
- * These are the only attrs allowed in CREATE/OPEN/SETATTR. Don't add
- * a writeable attribute here without also adding code to parse it to
- * nfsd4_decode_fattr().
- */
-#define NFSD_WRITEABLE_ATTRS_WORD0 \
-	(FATTR4_WORD0_SIZE | FATTR4_WORD0_ACL)
-#define NFSD_WRITEABLE_ATTRS_WORD1 \
-	(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP \
-	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_CREATE \
-	| FATTR4_WORD1_TIME_MODIFY_SET)
-#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-#define MAYBE_FATTR4_WORD2_SECURITY_LABEL \
-	FATTR4_WORD2_SECURITY_LABEL
-#else
-#define MAYBE_FATTR4_WORD2_SECURITY_LABEL 0
-#endif
-#ifdef CONFIG_NFSD_V4_POSIX_ACLS
-#define MAYBE_FATTR4_WORD2_POSIX_ACL_ATTRS \
-	FATTR4_WORD2_POSIX_DEFAULT_ACL | FATTR4_WORD2_POSIX_ACCESS_ACL
-#else
-#define MAYBE_FATTR4_WORD2_POSIX_ACL_ATTRS 0
-#endif
-#define NFSD_WRITEABLE_ATTRS_WORD2 \
-	(FATTR4_WORD2_MODE_UMASK \
-	| MAYBE_FATTR4_WORD2_SECURITY_LABEL \
-	| FATTR4_WORD2_TIME_DELEG_ACCESS \
-	| FATTR4_WORD2_TIME_DELEG_MODIFY \
-	| MAYBE_FATTR4_WORD2_POSIX_ACL_ATTRS \
-	)
-
-#define NFSD_SUPPATTR_EXCLCREAT_WORD0 \
-	NFSD_WRITEABLE_ATTRS_WORD0
-/*
- * we currently store the exclusive create verifier in the v_{a,m}time
- * attributes so the client can't set these at create time using EXCLUSIVE4_1
- */
-#define NFSD_SUPPATTR_EXCLCREAT_WORD1 \
-	(NFSD_WRITEABLE_ATTRS_WORD1 & \
-	 ~(FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_MODIFY_SET))
-/*
- * The FATTR4_WORD2_TIME_DELEG attributes are not to be allowed for
- * OPEN(create) with EXCLUSIVE4_1. It doesn't make sense to set a
- * delegated timestamp on a new file.
- *
- * This mask includes NFSv4.2-only attributes (e.g., POSIX ACLs).
- * Version filtering occurs via nfsd_suppattrs[] before this mask
- * is applied, so pre-4.2 clients never see unsupported attributes.
- */
-#define NFSD_SUPPATTR_EXCLCREAT_WORD2 \
-	(NFSD_WRITEABLE_ATTRS_WORD2 & \
-	~(FATTR4_WORD2_TIME_DELEG_ACCESS | FATTR4_WORD2_TIME_DELEG_MODIFY))
-
 extern int nfsd4_is_junction(struct dentry *dentry);
 extern int register_cld_notifier(void);
 extern void unregister_cld_notifier(void);
-- 
2.54.0


