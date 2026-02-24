Return-Path: <linux-nfs+bounces-19161-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCf5HiBNnWmhOQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19161-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 08:02:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF67F182B2E
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 08:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B37C2302A064
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 07:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059DD2DF6E6;
	Tue, 24 Feb 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="eo+DsL1Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9772D0C8F;
	Tue, 24 Feb 2026 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916564; cv=none; b=VmmyRHuDX1x0abCo9sScjEQLXkC9WU31OmeNHphZoHuwoUwbAh/AAg1y4xBM4pFE6c0Zf9TpGaLS9ARUtm3A5m+SvkNVsdDL0WPZFthdmB6Ng90rVGrg9RQa2EHq+dfT05jfQyaMLYZ+Ur5EXQvgA7ZiaFEkm62tRa4zHg/YU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916564; c=relaxed/simple;
	bh=W7Mdx21Opm8573GRR+2OYCEgOPcEg+ja0JmHL6Z7+oo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lnJ+LZrSyp0A/oA23hJkNBaXnx0JSBvBMZgvLx9LwTDRkV3rBWASL3JG4kg4pYh7MVgjbzuVZ5R0uNMBuZ4g9sAE6OqSBBpHVnOr5jSDmWhM/cxVTq3Q/x0DmG6M72VmlQ25ws8GMpW5VcbJh01Pc6WbmvzYUiJg/WZGgHvFfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=eo+DsL1Z; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=eo+DsL1ZZtlZJfcRz3Z3k/w+RDnXg0YqICfEI+j4P3DSgdtjYXbet1p6bbUrxcXrtZDLTlPrNEX9b
	 KlvIMwSbMz37NqD4Hhr0cuFQxczwKZZuEKIr5W8Sl5HeonyNB1yuiPWvbmZPZiIGS5PVNUMThD6k0t
	 LFdY0j1PV9uSzsAE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-16-12015 (RichMail) with SMTP id 2eef699d4d095c7-0260c;
	Tue, 24 Feb 2026 15:02:38 +0800 (CST)
X-RM-TRANSID:2eef699d4d095c7-0260c
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	wangzhaolong@huaweicloud.com
Subject: [PATCH 6.6.y 2/2] NFS: Fix a deadlock involving nfs_release_folio()
Date: Tue, 24 Feb 2026 15:02:37 +0800
Message-Id: <20260224070237.2933965-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19161-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[139.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[139.com:-];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,139.com:mid,139.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF67F182B2E
X-Rspamd-Action: no action

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit cce0be6eb4971456b703aaeafd571650d314bcca ]

Wang Zhaolong reports a deadlock involving NFSv4.1 state recovery
waiting on kthreadd, which is attempting to reclaim memory by calling
nfs_release_folio(). The latter cannot make progress due to state
recovery being needed.

It seems that the only safe thing to do here is to kick off a writeback
of the folio, without waiting for completion, or else kicking off an
asynchronous commit.

Reported-by: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Fixes: 96780ca55e3c ("NFS: fix up nfs_release_folio() to try to release the page")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
[ Minor conflict resolved. ]
Signed-off-by: Li hongliang <1468888505@139.com>
---
 fs/nfs/file.c          |  3 ++-
 fs/nfs/nfstrace.h      |  3 +++
 fs/nfs/write.c         | 33 +++++++++++++++++++++++++++++++++
 include/linux/nfs_fs.h |  1 +
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 9b6f4cc4d582..cf16ee710d42 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -459,7 +459,8 @@ static bool nfs_release_folio(struct folio *folio, gfp_t gfp)
 		if ((current_gfp_context(gfp) & GFP_KERNEL) != GFP_KERNEL ||
 		    current_is_kswapd() || current_is_kcompactd())
 			return false;
-		if (nfs_wb_folio(folio_file_mapping(folio)->host, folio) < 0)
+		if (nfs_wb_folio_reclaim(folio_file_mapping(folio)->host, folio) < 0 ||
+		    folio_test_private(folio))
 			return false;
 	}
 	return nfs_fscache_release_folio(folio, gfp);
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 004c25f0782b..85224e9369e7 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1033,6 +1033,9 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 DEFINE_NFS_FOLIO_EVENT(nfs_aop_readpage);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_aop_readpage_done);
 
+DEFINE_NFS_FOLIO_EVENT(nfs_writeback_folio_reclaim);
+DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_reclaim_done);
+
 DEFINE_NFS_FOLIO_EVENT(nfs_writeback_folio);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_done);
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 7b225ef1a284..dc57e67cefcd 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2121,6 +2121,39 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
 	return ret;
 }
 
+/**
+ * nfs_wb_folio_reclaim - Write back all requests on one page
+ * @inode: pointer to page
+ * @folio: pointer to folio
+ *
+ * Assumes that the folio has been locked by the caller
+ */
+int nfs_wb_folio_reclaim(struct inode *inode, struct folio *folio)
+{
+	loff_t range_start = folio_pos(folio);
+	size_t len = folio_size(folio);
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL,
+		.nr_to_write = 0,
+		.range_start = range_start,
+		.range_end = range_start + len - 1,
+		.for_sync = 1,
+	};
+	int ret;
+
+	if (folio_test_writeback(folio))
+		return -EBUSY;
+	if (folio_clear_dirty_for_io(folio)) {
+		trace_nfs_writeback_folio_reclaim(inode, range_start, len);
+		ret = nfs_writepage_locked(folio, &wbc);
+		trace_nfs_writeback_folio_reclaim_done(inode, range_start, len,
+						       ret);
+		return ret;
+	}
+	nfs_commit_inode(inode, 0);
+	return 0;
+}
+
 /**
  * nfs_wb_folio - Write back all requests on one page
  * @inode: pointer to page
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 832b7e354b4e..86d589070b23 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -608,6 +608,7 @@ extern int  nfs_update_folio(struct file *file, struct folio *folio,
 extern int nfs_sync_inode(struct inode *inode);
 extern int nfs_wb_all(struct inode *inode);
 extern int nfs_wb_folio(struct inode *inode, struct folio *folio);
+extern int nfs_wb_folio_reclaim(struct inode *inode, struct folio *folio);
 int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(void);
-- 
2.34.1



