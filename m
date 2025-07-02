Return-Path: <linux-nfs+bounces-12869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B94AF664E
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 01:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0116D3B6B08
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 23:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3CE248883;
	Wed,  2 Jul 2025 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTl50Il6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DAE2DE708
	for <linux-nfs@vger.kernel.org>; Wed,  2 Jul 2025 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499230; cv=none; b=b6CxsJu+jPOXAKkYPGEIJGB4nidAc6RGe6dJ6gzYr8XJD7Nop/nmDpmfKuk2exYq3NnOwnlj10N0H1XdcRBSA6StoHzYc8r844PMKRKUAS14kB6NSGAI3fINDzM1xZrRoRqvIcTvFqMBSkFkcrCGb/33931MIGCHOxLEBRq6yxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499230; c=relaxed/simple;
	bh=cviori8jwWZ6ibxw4p0o/S5kSHzIluCepsQNN5KpQ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INXeKz2EHNvUscOPRH/ShJKEXk1FTAL4k/1GC8QyFMR1DBiVJAJwc9IjD7MbwFy45+GS3JI9ve+TqzL7hahB3j87gPmtyIGTLM2q+kLjn1gT4ZUkEDq2I2Pl1HgKtbQfGGCGofcIU6dB7ONX+eSLIwvPhaCMnHL8j7SiebKS7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTl50Il6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD256C4CEE7;
	Wed,  2 Jul 2025 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751499230;
	bh=cviori8jwWZ6ibxw4p0o/S5kSHzIluCepsQNN5KpQ/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTl50Il6mCm4kzLSoTMbhFVwRuALSQKFWMvnG67QgX5AuvU2JBTUNZ1CsiMhCjj+L
	 VymzcjOz6Dn1yX4Xy/Ornx4gc6Ck/NLTKQmyH8YEg0LmyWiHkboVd++tJoNIp1uDhJ
	 1SxHHmC7W7+zAejaw40bRpQPOk68hKJictdRzt2z6smOww3S3hUo5SfmTC4zvQcbrA
	 X04gmRuWJJ3awlfxro0t26UueLIxGSFCKVZIUSMRvtH2YU1tbjxerZI+kGTWsC28ob
	 W7aUNFWly28H8ZSpMnEWgj0MJRIt2+wgxSP09pEKrAuy4VG+9PnBuqmvPTbZQMj0hK
	 2DmzzbsdmGYBg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/2] NFSD: Move the fh_getattr() helper
Date: Wed,  2 Jul 2025 19:33:45 -0400
Message-ID: <20250702233345.1128154-3-cel@kernel.org>
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

Clean up: The fh_getattr() function is part of NFSD's file handle
API, so relocate it.

I've made it an un-inlined function so that trace points and new
functionality can easily be introduced. That increases the size of
nfsd.ko by about a page on my x86_64 system (out of 26MB; compiled
with -O2).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.c | 23 +++++++++++++++++++++++
 fs/nfsd/nfsfh.h |  1 +
 fs/nfsd/vfs.h   | 13 -------------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 4565112d0324..6f59f957407f 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -662,6 +662,29 @@ fh_update(struct svc_fh *fhp)
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
2.50.0


