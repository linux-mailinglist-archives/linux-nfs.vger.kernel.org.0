Return-Path: <linux-nfs+bounces-12930-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C88AFD01D
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6483AE6BB
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4302E0B58;
	Tue,  8 Jul 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1lFqXgV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719F214228
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990799; cv=none; b=WHJj/FBQXvilzoRKlo68cP8uFtLGBzvke9YiqCRDstu3wJhOF8dj8S63iH5nC1URytZyJECszqrirZHcakUDdFd6bqeOePDggBTes8BpKJU5yR8+3NwjicShtgvK00C+V8x0UmzHR0JITE5pu+lBr1cQFWCJ5DWDBZMFJQyBoOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990799; c=relaxed/simple;
	bh=tsMCCgN6hj9WcxmYbGSE2VXS0hC23/ToUofbAjYSJlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdCFH8y8R1y1PQcI/E2d6tmCnOhd97aw9pQFgboFKRIh/qbNGVETdpoG3FmrLsOyvk1SBmpP4NLnnKa29iODjdqWpE08OpXtSEfDOzheXjGJ0Ilv0tgid0MBKS6ZzPh8JcnrOCdWbG0SG08Z+yNiFgE27V3FxQ9XnKFsgOjiZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1lFqXgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229C2C4CEED;
	Tue,  8 Jul 2025 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990799;
	bh=tsMCCgN6hj9WcxmYbGSE2VXS0hC23/ToUofbAjYSJlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1lFqXgVU84+W0OWC/X+HxUmapdV/58ccriteJWdLc4wnlE2GR2MZxjA9AXTlV6dJ
	 m68y5l3TTPLONolrFakyQryVKbtw/sEyWth//kAuIFoV3MKJYH4+HdlC33lP8qhrir
	 c7Z6/eimnQVLFvVylTnOOBv2emPSLycjOAb8zbeF1wVKOS6+bSYctuDQA/lB6YI6b9
	 sTJLxVkR9cLriXc3f2AbSkVyoo9e3mPaZ4vIaMdaN4V7Mb0zGolxFqSwtGOP7Y5kJQ
	 JyQZKXQROF57Sq5NxOoyTnUfO3DN2I2i0Mu0NgHPN7snosCjZf4G/7spHf+CIXtMnq
	 2K+l6s86c78VQ==
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
Subject: [RFC PATCH v2 2/8] NFSD: Move the fh_getattr() helper
Date: Tue,  8 Jul 2025 12:06:13 -0400
Message-ID: <20250708160619.64800-3-snitzer@kernel.org>
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

Clean up: The fh_getattr() function is part of NFSD's file handle
API, so relocate it.

I've made it an un-inlined function so that trace points and new
functionality can easily be introduced. That increases the size of
nfsd.ko by about a page on my x86_64 system (out of 26MB; compiled
with -O2).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/nfsfh.c | 23 +++++++++++++++++++++++
 fs/nfsd/nfsfh.h |  1 +
 fs/nfsd/vfs.h   | 13 -------------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 16e6b4428d55..f4a3cc9e31e0 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -663,6 +663,29 @@ fh_update(struct svc_fh *fhp)
 	return nfserr_serverfault;
 }
 
+/**
+ * fh_getattr - Retrieve attributes on a local file
+ * @fhp: File handle of target file
+ * @stat: Caller-supplied kstat buffer to be filled in
+ *
+ * Returns nfs_ok on success, otherwise an NFS status code is
+ * returned.
+ */
+__be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
+{
+	struct path p = {
+		.mnt		= fhp->fh_export->ex_path.mnt,
+		.dentry		= fhp->fh_dentry,
+	};
+	u32 request_mask = STATX_BASIC_STATS;
+
+	if (fhp->fh_maxsize == NFS4_FHSIZE)
+		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
+
+	return nfserrno(vfs_getattr(&p, stat, request_mask,
+				    AT_STATX_SYNC_AS_STAT));
+}
+
 /**
  * fh_fill_pre_attrs - Fill in pre-op attributes
  * @fhp: file handle to be updated
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 6f5255d1c190..5ef7191f8ad8 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -222,6 +222,7 @@ extern char * SVCFH_fmt(struct svc_fh *fhp);
 __be32	fh_verify(struct svc_rqst *, struct svc_fh *, umode_t, int);
 __be32	fh_verify_local(struct net *, struct svc_cred *, struct auth_domain *,
 			struct svc_fh *, umode_t, int);
+__be32	fh_getattr(const struct svc_fh *fhp, struct kstat *stat);
 __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
 __be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 4007dcbbbfef..0c0292611c6d 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -160,17 +160,4 @@ __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 void		nfsd_filp_close(struct file *fp);
 
-static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
-{
-	u32 request_mask = STATX_BASIC_STATS;
-	struct path p = {.mnt = fh->fh_export->ex_path.mnt,
-			 .dentry = fh->fh_dentry};
-
-	if (fh->fh_maxsize == NFS4_FHSIZE)
-		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
-
-	return nfserrno(vfs_getattr(&p, stat, request_mask,
-				    AT_STATX_SYNC_AS_STAT));
-}
-
 #endif /* LINUX_NFSD_VFS_H */
-- 
2.44.0


