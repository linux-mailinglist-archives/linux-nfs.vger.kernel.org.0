Return-Path: <linux-nfs+bounces-12868-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27E6AF664D
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 01:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FBC3B030A
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 23:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1032248A4;
	Wed,  2 Jul 2025 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ1l2XY2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F62DE708
	for <linux-nfs@vger.kernel.org>; Wed,  2 Jul 2025 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499230; cv=none; b=J+//53O3LFTsbnFMzOdMAkQRz9waYmK/XqKDzVNr+BeF2YfDPT/mBZFWVFQbDjVB46Kahklbva+l+HTOAZ1GEJkzNIKQ6myQSmC17pYTJgr+a6cffsNYm0npu9nxP9HJMwGM0jBlDbbNUwprPArk5EsJ/lOGCIdYxmdNtX9v2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499230; c=relaxed/simple;
	bh=cbhlsHwB43rV5qLT7qXZc2Nb8wC6T7on3BkvxzxmjmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQTAMgO50wIwVfVX0MNolCJsTPcEYHx3c82rctxwIW2yOZpzn033GTg5rpjIGUAv0+/FL6OZlKXH3Iz5YV7opmkAAaPeNlGX9nVL6nLcjKdEWFb74t4IWwOhAiQqIVui8LmHnRQeV4z2ZcH9gxQFB7C9tpmx4NHMvF+55V7NRQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ1l2XY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58D1C4CEEE;
	Wed,  2 Jul 2025 23:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751499229;
	bh=cbhlsHwB43rV5qLT7qXZc2Nb8wC6T7on3BkvxzxmjmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJ1l2XY2Mvg9MEo7LHvlgso1eYv6jY7kJK0WHJws9gDGX5f2sBmz+pO9Q8DaOICqv
	 XDSV7ULO5NxLa3/DhrPY4C9J7niTNChzQhX8PQqb0co3vn2BADYl2ZDHMO6Hx88FnD
	 wOWPe+qVikSAMfVa0dUAG2f0if3RHe6PCg2ZT+WsfDhDqtQ2XNaJY8HtwfPbhKmx7l
	 lI5ULzOo8cP41AVigawo4cYd0Hcm+PQBy0PdMnWvBYjjZUrNQe9eEw7fvUT2nJXog3
	 yih04pTqANNf+uLq/kbJPb/dAD9JwnJL6a5kP6stNWy2Wm6knRWX417iFg3N0asyk6
	 TCRl+vREcg7Ow==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/2] NFSD: Relocate the fh_want_write() and fh_drop_write() helpers
Date: Wed,  2 Jul 2025 19:33:44 -0400
Message-ID: <20250702233345.1128154-2-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702233345.1128154-1-cel@kernel.org>
References: <20250702233345.1128154-1-cel@kernel.org>
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
2.50.0


