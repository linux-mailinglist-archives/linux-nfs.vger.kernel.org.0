Return-Path: <linux-nfs+bounces-17446-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0BECF1204
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 17:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BDC03009420
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jan 2026 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C26274B42;
	Sun,  4 Jan 2026 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFLZ92Sf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259427056F
	for <linux-nfs@vger.kernel.org>; Sun,  4 Jan 2026 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543054; cv=none; b=I29U8wVI0AC3m5BmWwJFbmthsdq7M+KEAH8e3Vzdbi6fQpTCMe4aQlsykGKfmVPPlNQtHsCknU9R/X7qXBDsEQt9aJFe50iyiIzmZSXL7T8aUpIOsDIEqvKmJXfiTgVtoVXmi+lpyUqV0SYBPuALzj3L0QNQ4o6bw6ALiQAaqYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543054; c=relaxed/simple;
	bh=NGmILRgVsiRWBQATgJ53QQ3/PcJA36pOdG41nEng4mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT7vvwo8bBnHgBWbreNEquyCHlkgF8II0YKVRJ0rmlIEf3xDsHjkZWAeIj9yh1TVAsGt7p/RlZ6XnPHjO8mfMrNNryW4BqAVOezkgoLEvfeijjPoa/CIiOBy0YcDuLFDjxWxE7/HSHJw+DtdDFM/aekzOC4ylROp6PCECN17sdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFLZ92Sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1EAC19423;
	Sun,  4 Jan 2026 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767543053;
	bh=NGmILRgVsiRWBQATgJ53QQ3/PcJA36pOdG41nEng4mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFLZ92SfzuT0Sl4UdjpbU06QJQ5ifHeH2IPI/DEeHAxGc+uJXGKk+f/JrwKxH9rum
	 7gNwiiePDRoorKhXShvHvWEDNjU5wNdrw1M2rLSPgaW1iG4LgM/TtV/VotQSOtLzOR
	 RgTiKIEnueRdX+1oLGQyZ6OItAPs4PM1o9uYR6yZxA02msKAgtcB5lI0eGLDl2HVYZ
	 B3TV7v+fpSUlaJF1XWQU9RLRAytUrOpsoDNofDEyaLmOsPPTfosEmO5xcJaxrtXta6
	 WyCFgLRq09C8kiH8LtJBghExL2eIKmdYzu0LM1/Wf9LjIK2H2ZvxfNUlIogKGrzXiM
	 0QIXyZ0ZR7b+A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 12/12] NFSD: Add POSIX ACL file attributes to SUPPATTR bitmasks
Date: Sun,  4 Jan 2026 11:10:49 -0500
Message-ID: <20260104161049.3404551-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104161049.3404551-1-cel@kernel.org>
References: <20260104161049.3404551-1-cel@kernel.org>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsd.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index b0283213a8f5..8720d1507bcc 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -462,7 +462,11 @@ enum {
 	FATTR4_WORD2_XATTR_SUPPORT | \
 	FATTR4_WORD2_TIME_DELEG_ACCESS | \
 	FATTR4_WORD2_TIME_DELEG_MODIFY | \
-	FATTR4_WORD2_OPEN_ARGUMENTS)
+	FATTR4_WORD2_OPEN_ARGUMENTS | \
+	FATTR4_WORD2_ACL_TRUEFORM | \
+	FATTR4_WORD2_ACL_TRUEFORM_SCOPE | \
+	FATTR4_WORD2_POSIX_DEFAULT_ACL | \
+	FATTR4_WORD2_POSIX_ACCESS_ACL)
 
 extern const u32 nfsd_suppattrs[3][3];
 
@@ -530,11 +534,18 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
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
@@ -550,6 +561,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
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


