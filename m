Return-Path: <linux-nfs+bounces-17707-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F9DD0B436
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 17:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 930EF30745B5
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 16:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6731B3644DC;
	Fri,  9 Jan 2026 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuGy0MdA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445CB2773DA
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975720; cv=none; b=FGwfCI893pSPQifazD4AyPn7NHJ5NCqDC/P0PSSZQn5K1fmQMkfwTTf9Q36D0HTOvC9wgGZOtqzlciW2tzqIyjKAwse2sePaB5ilfw0kFzKjJqlGOMe27mvm5sH/Tm6g+vpMlLAc6KvYhosAc99AEWTOYOpXtMJvMqyKPWkRQms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975720; c=relaxed/simple;
	bh=47V8qt0VplEubsd3O+n1QeIWCAsHkEZsWGIgBFlNuxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTB+dF7CxU0Ltv82Hu/53FnSoS6jhrawv8DM1QUgATxla2J2orn6ngiypQ7cBzIQ35VfUxlIi6IyZ3O+6eGzdeSIMsVDFD5UMiYRQI2hhc7Spb+v3Dhalt2dz6jOHlmyyxLxb3apttxBEkf9U/eTMLuQzgg5aXmWrtuynx/kq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuGy0MdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54176C19423;
	Fri,  9 Jan 2026 16:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975719;
	bh=47V8qt0VplEubsd3O+n1QeIWCAsHkEZsWGIgBFlNuxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AuGy0MdAmaLlJHGmGkbfExMo+BIfn47NrP+YHTDxkd82oFMmigv1VpoJgHYAJeXIr
	 54MUETWGm9t9Vj7R0DH32U3BLE8nDL0bm4PlZpC5W46docUbZljNnPuFQqucY9uLB4
	 uvByVpkN4PMcZ5cSRebPLnbiWby1Lb4qMZ4SRjQfzRU8o+wbfB6N0AjWx3sxNLC+AU
	 3QRnhotAUypFWLFzlrbVceGlWlh/P0q04xmeBvOlxEi6BskYXo8JAGgHgOmGCLGRP+
	 dYuvlmjwDvbPmhRFizgduKyBmJntcPctY49+06ARobyce62MUV/5gnxpfgwq2wg28u
	 lfNj9hFFeb0Qg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 13/13] NFSD: Add POSIX ACL file attributes to SUPPATTR bitmasks
Date: Fri,  9 Jan 2026 11:21:42 -0500
Message-ID: <20260109162143.4186112-14-cel@kernel.org>
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

Now that infrastructure for NFSv4 POSIX draft ACL has been added
to NFSD, it should be safe to advertise support to NFS clients.

NFSD_SUPPATTR_EXCLCREAT_WORD2 includes NFSv4.2-only attributes,
but version filtering occurs via nfsd_suppattrs[] before this
mask is applied, ensuring pre-4.2 clients never see unsupported
attributes.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsd.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index b0283213a8f5..a01d70953358 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -454,6 +454,16 @@ enum {
 #define NFSD4_2_SECURITY_ATTRS		0
 #endif
 
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
 #define NFSD4_2_SUPPORTED_ATTRS_WORD2 \
 	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
 	FATTR4_WORD2_MODE_UMASK | \
@@ -462,7 +472,8 @@ enum {
 	FATTR4_WORD2_XATTR_SUPPORT | \
 	FATTR4_WORD2_TIME_DELEG_ACCESS | \
 	FATTR4_WORD2_TIME_DELEG_MODIFY | \
-	FATTR4_WORD2_OPEN_ARGUMENTS)
+	FATTR4_WORD2_OPEN_ARGUMENTS | \
+	NFSD4_2_POSIX_ACL_ATTRS)
 
 extern const u32 nfsd_suppattrs[3][3];
 
@@ -530,11 +541,18 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
 #else
 #define MAYBE_FATTR4_WORD2_SECURITY_LABEL 0
 #endif
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+#define MAYBE_FATTR4_WORD2_POSIX_ACL_ATTRS \
+	FATTR4_WORD2_POSIX_DEFAULT_ACL | FATTR4_WORD2_POSIX_ACCESS_ACL
+#else
+#define MAYBE_FATTR4_WORD2_POSIX_ACL_ATTRS 0
+#endif
 #define NFSD_WRITEABLE_ATTRS_WORD2 \
 	(FATTR4_WORD2_MODE_UMASK \
 	| MAYBE_FATTR4_WORD2_SECURITY_LABEL \
 	| FATTR4_WORD2_TIME_DELEG_ACCESS \
 	| FATTR4_WORD2_TIME_DELEG_MODIFY \
+	| MAYBE_FATTR4_WORD2_POSIX_ACL_ATTRS \
 	)
 
 #define NFSD_SUPPATTR_EXCLCREAT_WORD0 \
@@ -550,6 +568,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
  * The FATTR4_WORD2_TIME_DELEG attributes are not to be allowed for
  * OPEN(create) with EXCLUSIVE4_1. It doesn't make sense to set a
  * delegated timestamp on a new file.
+ *
+ * This mask includes NFSv4.2-only attributes (e.g., POSIX ACLs).
+ * Version filtering occurs via nfsd_suppattrs[] before this mask
+ * is applied, so pre-4.2 clients never see unsupported attributes.
  */
 #define NFSD_SUPPATTR_EXCLCREAT_WORD2 \
 	(NFSD_WRITEABLE_ATTRS_WORD2 & \
-- 
2.52.0


