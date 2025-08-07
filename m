Return-Path: <linux-nfs+bounces-13478-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52966B1DB99
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 18:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01188189083D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B4426F469;
	Thu,  7 Aug 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZOStfmg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54BA25BEFE
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583947; cv=none; b=o5QHlrHFUq5hiN7CBZauvXGokJIwLnmbPyzq6XlsSbmTZrYx1yihEJqMm9h3XATmwo84vfgpvuB2WhvpN+UViM3S0jXoIqqBXpaxxKZPaErPUh4JDz5fniICe6e1CvX/r5i486SjqFnYi4F3ZKX2vmyvUcyxVUzIfmZNU03cYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583947; c=relaxed/simple;
	bh=O4kDPNrKi3J6ctBbPRcjOWV6nhE48IEEblOvgdoeq0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML2/4VM9W+BZR1xvJm3dgyFZXkBrjZJGZ6NGyjdjZe7tOMSqqyGrZbu481x3OhJNS4e7Lh9wbaNVGu4v9bIsxiKwcXNOpuGckwi+nPE/Qbdh8zab1ukKok8NPc0Fk/k+JvhH1bDD4iWTRhVRywwNvf6ftH/GMEWShm9fROduYOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZOStfmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7527AC4CEEB;
	Thu,  7 Aug 2025 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754583947;
	bh=O4kDPNrKi3J6ctBbPRcjOWV6nhE48IEEblOvgdoeq0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZOStfmgj2dP02CNOsKYVDH2FEsY2dGgPAuHbsZ9M5++zfC7kUgClf2jsB7kBeBoW
	 eGTNNu/pxZOxGeITu4TpRpHAxH643DLsZcKI4ztWv5CZ30L+QAtdjhbXd2rhK1Hc9i
	 zFVopvwy9TWLzotHcqwvpc0RCXAe5krrh66EubpA3WLA8QJN+1LKGkGBg9oVMicFcB
	 rvRxRm8w3AcLvHWPlcGRkv2sknMnY/fxw1c7K3D9sh+D0auTado+X4g39UjxOyAyJs
	 x49u4cu9IfYFODsdTD57d96/mfJK3D+MlPC8A+k60rICeWkUiddExV/XFSWdyQeypt
	 VXadSPWKzgAFw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 1/7] NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
Date: Thu,  7 Aug 2025 12:25:38 -0400
Message-ID: <20250807162544.17191-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250807162544.17191-1-snitzer@kernel.org>
References: <20250807162544.17191-1-snitzer@kernel.org>
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
index 8581c131338b8..5447dba6c5da0 100644
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
index 24ddf60e8434a..e3d6ca2b60308 100644
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
index f4a3cc9e31e05..bdba2ba828a6a 100644
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


