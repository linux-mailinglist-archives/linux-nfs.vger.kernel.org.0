Return-Path: <linux-nfs+bounces-13230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4275CB111BF
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 21:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749FF7B882B
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 19:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D02A2EE5EC;
	Thu, 24 Jul 2025 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/KKlcPJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F7264F85
	for <linux-nfs@vger.kernel.org>; Thu, 24 Jul 2025 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385465; cv=none; b=FOkNV8HbrXG6ASKOZljeahDTzgtQAkf2QrpD7BS4ekK/wdYz2j9YKzYAyBbc0PM6ttNlYtlfRH2e9TiMrMqGVDmtDzDS0B6SxGS0NBJU0nOf568cc4oTdkrWx3lRxxgIyVWfLfzqh5x1/JGy0N5wPoNwhpJVhSCC2Q6LoOZN7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385465; c=relaxed/simple;
	bh=wDHRgp4YvCz1BfE8D30T3+cFQPODWpwoi2tMHkmpkw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2wQiseuI3STjvYOLvGFD3wvZ28d8p12EwyVKUSOG69UGOpkbLd1ulsGCHRrorTjImDgNAjd+001LSgxIBv0bdeqSPCMpRQovqk9QrpR8cCEeqXbqEb/kajfWxzZqQaKA8CQzNyRZkPwim6GK/224AqH+kBoaMUi10pHpSAQQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/KKlcPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B694BC4CEED;
	Thu, 24 Jul 2025 19:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385465;
	bh=wDHRgp4YvCz1BfE8D30T3+cFQPODWpwoi2tMHkmpkw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/KKlcPJVNTmz0HqI0OL0zluOpUDzxjRQk/LQxdb77cVo2WUUBRMoTe5UDKC13efF
	 u84JrWYVJZZCNsM4g1DQoYr18NMPMTBSGinRB+A0bgE62kzvNsWWrPQWQH2HJKxk9X
	 /RKLAgUAjV4a7MwChUbeED8+adGjdy5uXNpMYOytrfRfqWwsWEqGpVLd3VR/muylmT
	 shVaddW11lT+jfPRVn0r96v3H7Z0Q8Ro3sqU4JoO1IV3Y3BVavAkL4lKDMMLktOmaE
	 KDD30RkftpBcYDuyX7DXYk1N3vlqPx9i+OVfHBAidzsj/xn7Cpgx4k0u0gx+Y/FKVd
	 86XzCycF1n1UQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 01/13] NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
Date: Thu, 24 Jul 2025 15:30:50 -0400
Message-ID: <20250724193102.65111-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250724193102.65111-1-snitzer@kernel.org>
References: <20250724193102.65111-1-snitzer@kernel.org>
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
index 75bc48031c07..aad5f924d101 100644
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
index f4c2fb3dd5d0..ff634b47c4df 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -676,8 +676,12 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
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


