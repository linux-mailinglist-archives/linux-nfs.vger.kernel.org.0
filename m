Return-Path: <linux-nfs+bounces-12929-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7863AFD015
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F891AA0678
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424BA2E4242;
	Tue,  8 Jul 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saFJkSVN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F02E0B58
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990798; cv=none; b=pJw1BkPs+JxG9MQPhh8SOmlzaaw6oKPK+6NfvMYQzsrjSST/lWV71lmkrb93dQjICzTc/itmPkpQmDob8duQqLwp3Dbe8Wl7CIwFTf1aekI+/JWHSBa7yXQZ89h0DHw41avgaeLYd+vfCmrhnhWbPaFqS+DS5qPs49/+b/BwAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990798; c=relaxed/simple;
	bh=z6IE/iV/Qey3mNmw+1HVgy4SEo8XOTOVWa3lXjNRe70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3rAvK6BGmTTxdUw8qLluDBpH2aQQUZ+hVN+yApEKiWhB2BTdA2ov7tBVJBTpdwaj1i+Snh+MzZCjjI/JQJe59L0yX2X0Kxr1hIdL9v5njr4yC0XpVXBolJ4zc/HiAb1mqZUg0A0Nz6m04pO8VHJWHcDWKtZbb0mfrhwRBhszLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saFJkSVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8F9C4CEED;
	Tue,  8 Jul 2025 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990798;
	bh=z6IE/iV/Qey3mNmw+1HVgy4SEo8XOTOVWa3lXjNRe70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=saFJkSVNGfWcxoeGGceODlw+CX/0sUce7WQ1KXlHSXx6CDH6pU80OscooUQMSqlYo
	 2KHuoum61BzF3yhZtaE+joS30gX5GuAyQYBF5trhNvLHezPOJ7lBRkYPHKlQVcP0Gw
	 0IYnhSD+9A4OlyItpA6vOMl1/DLcjyGVDH92hb4ZDHA2Ap/r0dsRFyhrUfq6ZVouGy
	 AauFAwrOOjtKDCehDyqbjIr6hDpKaH3rUvnE9jRgKS8fCbxcqKqt/iMBFjx4eFZT/i
	 kWaYM463/AcsedMS5/6aAmwkju762wap6DaZR2ggfF05qPhGg6uzrVGHzE4R2yx70Y
	 wIsVaknc99jJg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linus-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	snitzer@kernel.org
Subject: [RFC PATCH v2 1/8] NFSD: Relocate the fh_want_write() and fh_drop_write() helpers
Date: Tue,  8 Jul 2025 12:06:12 -0400
Message-ID: <20250708160619.64800-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250708160619.64800-1-snitzer@kernel.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: These helpers are part of the NFSD file handle API.
Relocate them to fs/nfsd/nfsfh.h.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/nfsfh.h | 37 +++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h   | 20 --------------------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 1cf979722521..6f5255d1c190 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -14,6 +14,8 @@
 #include <linux/exportfs.h>
 #include <linux/nfs4.h>
 
+#include "export.h"
+
 /*
  * The file handle starts with a sequence of four-byte words.
  * The first word contains a version number (1) and three descriptor bytes
@@ -271,6 +273,41 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
 	return true;
 }
 
+/**
+ * fh_want_write - Get write access to an export
+ * @fhp: File handle of file to be written
+ *
+ * Caller must invoke fh_drop_write() when its write operation
+ * is complete.
+ *
+ * Returns 0 if the file handle's export can be written to. Otherwise
+ * the export is not prepared for updates, and the returned negative
+ * errno value reflects the reason for the failure.
+ */
+static inline int fh_want_write(struct svc_fh *fhp)
+{
+	int ret;
+
+	if (fhp->fh_want_write)
+		return 0;
+	ret = mnt_want_write(fhp->fh_export->ex_path.mnt);
+	if (!ret)
+		fhp->fh_want_write = true;
+	return ret;
+}
+
+/**
+ * fh_drop_write - Release write access on an export
+ * @fhp: File handle of file on which fh_want_write() was previously called
+ */
+static inline void fh_drop_write(struct svc_fh *fhp)
+{
+	if (fhp->fh_want_write) {
+		fhp->fh_want_write = false;
+		mnt_drop_write(fhp->fh_export->ex_path.mnt);
+	}
+}
+
 /**
  * knfsd_fh_hash - calculate the crc32 hash for the filehandle
  * @fh - pointer to filehandle
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index eff04959606f..4007dcbbbfef 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -160,26 +160,6 @@ __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 void		nfsd_filp_close(struct file *fp);
 
-static inline int fh_want_write(struct svc_fh *fh)
-{
-	int ret;
-
-	if (fh->fh_want_write)
-		return 0;
-	ret = mnt_want_write(fh->fh_export->ex_path.mnt);
-	if (!ret)
-		fh->fh_want_write = true;
-	return ret;
-}
-
-static inline void fh_drop_write(struct svc_fh *fh)
-{
-	if (fh->fh_want_write) {
-		fh->fh_want_write = false;
-		mnt_drop_write(fh->fh_export->ex_path.mnt);
-	}
-}
-
 static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
 {
 	u32 request_mask = STATX_BASIC_STATS;
-- 
2.44.0


