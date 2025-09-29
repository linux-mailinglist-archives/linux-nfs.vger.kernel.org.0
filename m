Return-Path: <linux-nfs+bounces-14770-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9960BA9E40
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 17:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645AD3BCF55
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83E230ACFF;
	Mon, 29 Sep 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClX4sVqn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D5309F03
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161409; cv=none; b=RYaD83yr24VmcX25dxYvr6qpwPdsTboBc1L1nrGKqADFPeZHGBkHs0PEqEItpPBdZCEAbSMa9qxX4o5WYDJrceYbmUmmCE5PNadbr+PKtZRdHg6CzfdSqYpdTHYprYfGTlUTxhXb4gwE1tOcBT2cU2Q6BldaBwsUI0xoFNLL8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161409; c=relaxed/simple;
	bh=nK0Xake/zpfLDtO72UZzlM3RrS4JEnSfHmELvZeiA8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgaymCVMb7us2towjd8r5wGXIyoSRQNLtzOK7hJBM1HDl4ULXjHoQEjn3ID6haoB1UQCHn08zAFhskbV0KDghpSGcxGwOTEivYJw6Rfxp2Eso/bd1uNWNs2tqIMvqMcoUVZpsFi1/2yR+grcGcTR4hbHsqyStl/X1F26U37Azyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClX4sVqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF7DC4CEF7;
	Mon, 29 Sep 2025 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161409;
	bh=nK0Xake/zpfLDtO72UZzlM3RrS4JEnSfHmELvZeiA8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ClX4sVqnPlxwc7VnlGxSZgc6UVqc9uQc/lQ6brFYWv71UjvLnCeZFfJ7A0p4x/6rQ
	 mWpupeGXe3L8b4pxcG7o8biWbg4xYO++OoIQU3prM8FMqcMp3gKxuy8fa32pU4F4ZF
	 l6DxMAaD6DvhP+cd6oCKTUyC29bLDf0as5K24PkkG+fZQyTBZF9hoKpnQ06vpxsyPc
	 p8tPekJOKEbaH5itu4/no58oIi6DBJpntM4KnJdDm3/NfbBHe1Abv0v6/vCyR5D5iS
	 UdqIIDssh1mkVPLDEpjiCCex3Syvv6bFjZkWA3j6A0NzUR1lNog9EX0zl+0ayaTd1C
	 5PiKkD+8f+H9A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v5 1/6] NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
Date: Mon, 29 Sep 2025 11:56:41 -0400
Message-ID: <20250929155646.4818-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929155646.4818-1-cel@kernel.org>
References: <20250929155646.4818-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@kernel.org>

Use STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get DIO alignment
attributes from the underlying filesystem and store them in the
associated nfsd_file. This is done when the nfsd_file is first
opened for each regular file.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c     | 34 ++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h     |  4 ++++
 fs/nfsd/nfsfh.c         |  4 ++++
 fs/nfsd/trace.h         | 27 +++++++++++++++++++++++++++
 include/trace/misc/fs.h | 22 ++++++++++++++++++++++
 5 files changed, 91 insertions(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 75bc48031c07..78cca0d751ac 100644
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
 
@@ -1048,6 +1051,35 @@ nfsd_file_is_cached(struct inode *inode)
 	return ret;
 }
 
+static __be32
+nfsd_file_get_dio_attrs(const struct svc_fh *fhp, struct nfsd_file *nf)
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
+	trace_nfsd_file_get_dio_attrs(inode, &stat);
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
+	return nfs_ok;
+}
+
 static __be32
 nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 		     struct svc_cred *cred,
@@ -1166,6 +1198,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 			}
 			status = nfserrno(ret);
 			trace_nfsd_file_open(nf, status);
+			if (status == nfs_ok)
+				status = nfsd_file_get_dio_attrs(fhp, nf);
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
index bd9acfdc7b01..ed85dd43da18 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -696,8 +696,12 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
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
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index a664fdf1161e..6e2c8e2aab10 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1133,6 +1133,33 @@ TRACE_EVENT(nfsd_file_alloc,
 	)
 );
 
+TRACE_EVENT(nfsd_file_get_dio_attrs,
+	TP_PROTO(
+		const struct inode *inode,
+		const struct kstat *stat
+	),
+	TP_ARGS(inode, stat),
+	TP_STRUCT__entry(
+		__field(const void *, inode)
+		__field(unsigned long, mask)
+		__field(u32, mem_align)
+		__field(u32, offset_align)
+		__field(u32, read_offset_align)
+	),
+	TP_fast_assign(
+		__entry->inode = inode;
+		__entry->mask = stat->result_mask;
+		__entry->mem_align = stat->dio_mem_align;
+		__entry->offset_align = stat->dio_offset_align;
+		__entry->read_offset_align = stat->dio_read_offset_align;
+	),
+	TP_printk("inode=%p flags=%s mem_align=%u offset_align=%u read_offset_align=%u",
+		__entry->inode, show_statx_mask(__entry->mask),
+		__entry->mem_align, __entry->offset_align,
+		__entry->read_offset_align
+	)
+);
+
 TRACE_EVENT(nfsd_file_acquire,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
index 0406ebe2a80a..7ead1c61f0cb 100644
--- a/include/trace/misc/fs.h
+++ b/include/trace/misc/fs.h
@@ -141,3 +141,25 @@
 		{ ATTR_TIMES_SET,	"TIMES_SET" },	\
 		{ ATTR_TOUCH,		"TOUCH"},	\
 		{ ATTR_DELEG,		"DELEG"})
+
+#define show_statx_mask(flags)					\
+	__print_flags(flags, "|",				\
+		{ STATX_TYPE,		"TYPE" },		\
+		{ STATX_MODE,		"MODE" },		\
+		{ STATX_NLINK,		"NLINK" },		\
+		{ STATX_UID,		"UID" },		\
+		{ STATX_GID,		"GID" },		\
+		{ STATX_ATIME,		"ATIME" },		\
+		{ STATX_MTIME,		"MTIME" },		\
+		{ STATX_CTIME,		"CTIME" },		\
+		{ STATX_INO,		"INO" },		\
+		{ STATX_SIZE,		"SIZE" },		\
+		{ STATX_BLOCKS,		"BLOCKS" },		\
+		{ STATX_BASIC_STATS,	"BASIC_STATS" },	\
+		{ STATX_BTIME,		"BTIME" },		\
+		{ STATX_MNT_ID,		"MNT_ID" },		\
+		{ STATX_DIOALIGN,	"DIOALIGN" },		\
+		{ STATX_MNT_ID_UNIQUE,	"MNT_ID_UNIQUE" },	\
+		{ STATX_SUBVOL,		"SUBVOL" },		\
+		{ STATX_WRITE_ATOMIC,	"WRITE_ATOMIC" },	\
+		{ STATX_DIO_READ_ALIGN,	"DIO_READ_ALIGN" })
-- 
2.51.0


