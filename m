Return-Path: <linux-nfs+bounces-13211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA0CB0F752
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 17:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA58F16EB78
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391FE1FDE19;
	Wed, 23 Jul 2025 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y197OPTg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625E1FFC5E
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285435; cv=none; b=c8eWUryqdWx9sdHQQr9DMhPIgEkqTWWcg0yf+YawNC55AajCXLFEJZLGL58ilC8B0AFpXXXM3YrAicoCxtCuFUBxAnyjue4cRVw8oH2S/XvCpo3gvtWRNegW/9H3L5jOS5AibK00TKMu69f8hZt9lrOqtI1v+Km/jBOR01SPoKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285435; c=relaxed/simple;
	bh=LpX+pvAOwGXWyAK/YM3OBWbpRZ+kjTo3PkJ912Lz8ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmkQoGSLjXLxgQ886PYB+bVeaaV2ITS8VFdCAgeMVwn8++ioarDqw89d4hGh3scEkjnyf16uvob65hGaMFWKpPiK/gnERXmKV6EWLF/brHFkZrA4tuP6vv7UTbTbTy3Ag1HKD7xa8L0zLd929eWLWColEVhK45vPePoY/CUN+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y197OPTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC69C4CEEF;
	Wed, 23 Jul 2025 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285434;
	bh=LpX+pvAOwGXWyAK/YM3OBWbpRZ+kjTo3PkJ912Lz8ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y197OPTgTGyD1Rt9x75QDRCO5y2r3KKDqcTWJi2fIbb6AIJTAmsmwKPWfVVH1uGZB
	 v1qaatIc53P3Bc6GR/lQJQawr/nIkJas1OFk5zQ5YyrTCJrn+8UnATubA8dnM4tZFB
	 n2UpjSBNDijWCeyEIDHOwiY6AapBCsiu2SBmsf6V48az/Wtgq/odqx5EKle1G9gn+v
	 YAmV91Y0RSsqMJ4KDDIBP6aoiYoIYTyhKmcWZ9Qy+q/gDA3WQixNqONo+ENJHfzC9Q
	 671gQnE1UzmpYwJH7njS3UadcF5nOiGvqNTis2nNz9TlIVEqia38f/7wh1z6/kX9Ue
	 BwZjHZwc6mAig==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/5] NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
Date: Wed, 23 Jul 2025 11:43:47 -0400
Message-ID: <20250723154351.59042-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250723154351.59042-1-snitzer@kernel.org>
References: <20250723154351.59042-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get and store DIO
alignment attributes from underlying filesystem in associated
nfsd_file.  This is done when the nfsd_file is first opened for
a regular file.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/filecache.c | 32 ++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h |  4 ++++
 fs/nfsd/nfsfh.c     |  4 ++++
 3 files changed, 40 insertions(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 8581c131338b..5447dba6c5da 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -231,6 +231,9 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
 	refcount_set(&nf->nf_ref, 1);
 	nf->nf_may = need;
 	nf->nf_mark = NULL;
+	nf->nf_dio_mem_align = 0;
+	nf->nf_dio_offset_align = 0;
+	nf->nf_dio_read_offset_align = 0;
 	return nf;
 }
 
@@ -1048,6 +1051,33 @@ nfsd_file_is_cached(struct inode *inode)
 	return ret;
 }
 
+static __be32
+nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
+{
+	struct inode *inode = file_inode(nf->nf_file);
+	struct kstat stat;
+	__be32 status;
+
+	/* Currently only need to get DIO alignment info for regular files */
+	if (!S_ISREG(inode->i_mode))
+		return nfs_ok;
+
+	status = fh_getattr(fhp, &stat);
+	if (status != nfs_ok)
+		return status;
+
+	if (stat.result_mask & STATX_DIOALIGN) {
+		nf->nf_dio_mem_align = stat.dio_mem_align;
+		nf->nf_dio_offset_align = stat.dio_offset_align;
+	}
+	if (stat.result_mask & STATX_DIO_READ_ALIGN)
+		nf->nf_dio_read_offset_align = stat.dio_read_offset_align;
+	else
+		nf->nf_dio_read_offset_align = nf->nf_dio_offset_align;
+
+	return status;
+}
+
 static __be32
 nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 		     struct svc_cred *cred,
@@ -1166,6 +1196,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 			}
 			status = nfserrno(ret);
 			trace_nfsd_file_open(nf, status);
+			if (status == nfs_ok)
+				status = nfsd_file_getattr(fhp, nf);
 		}
 	} else
 		status = nfserr_jukebox;
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 24ddf60e8434..e3d6ca2b6030 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -54,6 +54,10 @@ struct nfsd_file {
 	struct list_head	nf_gc;
 	struct rcu_head		nf_rcu;
 	ktime_t			nf_birthtime;
+
+	u32			nf_dio_mem_align;
+	u32			nf_dio_offset_align;
+	u32			nf_dio_read_offset_align;
 };
 
 int nfsd_file_cache_init(void);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index f4a3cc9e31e0..bdba2ba828a6 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -677,8 +677,12 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
 		.mnt		= fhp->fh_export->ex_path.mnt,
 		.dentry		= fhp->fh_dentry,
 	};
+	struct inode *inode = d_inode(p.dentry);
 	u32 request_mask = STATX_BASIC_STATS;
 
+	if (S_ISREG(inode->i_mode))
+		request_mask |= (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
+
 	if (fhp->fh_maxsize == NFS4_FHSIZE)
 		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
 
-- 
2.44.0


