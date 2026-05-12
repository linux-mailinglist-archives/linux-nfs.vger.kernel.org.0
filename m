Return-Path: <linux-nfs+bounces-21489-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKYgAW3BAmpZwQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21489-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:58:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4BC51A8AA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0D6130E34ED
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 05:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7DC402427;
	Tue, 12 May 2026 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ge+4D1DW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04843CAE6C;
	Tue, 12 May 2026 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564279; cv=none; b=p9dpd6A+uLMLSntH3afhsQycGs96ypsKoPgVFVz12K+6PmsdefIcOhx+WKBFnJhmBiev9WQxD8AZhNXApVWbpu30DTsrBzSfGzNPYI/l0sjUCVu+Nopgi768kA6MZ4xuW1N77BFd9BA5k8YCLemnvSky0XAyY0DL76N2H87cOI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564279; c=relaxed/simple;
	bh=2lHK6ic7b2tNskm1Cqad6h8SJi9qhMU8XfthU8y4S0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ7susiFhFNMh/7bb81fErFN5VLTDzaQyyH5UHWLqe+OPNH2Q/eUN10UJvXGCDQyhdpusbKh6Peh5mvSr2BFYghX7IszzR0XHVoXgnoVdZ9uh7h6kedP2qjhyTvypHILJSaX5hZgznnw8rgNtYwrN/I9neycuCyiRuLevniDf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ge+4D1DW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=M9+U2qOebilkGiCBYkyQkIQiqg6xsbq5mzyvOEMl2d0=; b=Ge+4D1DW2pmkX62K/Bv0iADaDG
	D9R7VZelwjKVRFhBQMh+fdN1xy3bTuTe0Q/vildGqQgQLb2afEaPyK1v8EjHjl8TnlRLR/yk3EOY3
	CpVRLT1IjABfASeE4xKUXId4njNbkiTLXbvLgvpTV9DskB9fVGLdpCqTkGu0rwCamvFqNjPrjYQlk
	YbHGYfjRwa7iH7D+9ACskU7jjidW0jq5xkwsjL3UJn+LvYQDv+evewZXQlDFu8MBYFt9cGvlHes4X
	x8utjRA/kzC2L5QS64m/B+xrrdAcsM9s1jEftrIQO9KN4bMqlXv1c7GOwxY0yHbsBHC6xopqolwXm
	jLuSKVEw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfoT-0000000FfTW-0JM3;
	Tue, 12 May 2026 05:37:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong " <djwong@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 10/12] swap: add a swap_activate_fs_ops helper
Date: Tue, 12 May 2026 07:35:26 +0200
Message-ID: <20260512053625.2950900-11-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 4E4BC51A8AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21489-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Action: no action

Add a helper abstracting away the low-level details of enabling
fs_ops-based swapping.  This prepares for taking swap_info_struct
private.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/file.c        | 4 +---
 fs/smb/client/file.c | 3 +--
 include/linux/swap.h | 5 +++++
 mm/swapfile.c        | 7 +++++++
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 10ab2a923835..ce4d860c4e7a 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -588,7 +588,7 @@ int nfs_swap_activate(struct file *file, struct swap_info_struct *sis)
 	ret = rpc_clnt_swap_activate(clnt);
 	if (ret)
 		return ret;
-	ret = add_swap_extent(sis, sis->max, NULL, 0);
+	ret = swap_activate_fs_ops(sis);
 	if (ret < 0) {
 		rpc_clnt_swap_deactivate(clnt);
 		return ret;
@@ -596,8 +596,6 @@ int nfs_swap_activate(struct file *file, struct swap_info_struct *sis)
 
 	if (cl->rpc_ops->enable_swap)
 		cl->rpc_ops->enable_swap(inode);
-
-	sis->flags |= SWP_FS_OPS;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_swap_activate);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index e1bbc65ce7f3..e11065be1e64 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3326,8 +3326,7 @@ int cifs_swap_activate(struct file *swap_file, struct swap_info_struct *sis)
 	 * from reading or writing the file
 	 */
 
-	sis->flags |= SWP_FS_OPS;
-	return add_swap_extent(sis, sis->max, NULL, 0);
+	return swap_activate_fs_ops(sis);
 }
 
 void cifs_swap_deactivate(struct file *file)
diff --git a/include/linux/swap.h b/include/linux/swap.h
index b1cbb67ddd8e..916889738f08 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -406,6 +406,7 @@ extern void __meminit kswapd_stop(int nid);
 int add_swap_extent(struct swap_info_struct *sis, unsigned long nr_pages,
 		struct block_device *bdev, sector_t start_block);
 int generic_swap_activate(struct file *swap_file, struct swap_info_struct *sis);
+int swap_activate_fs_ops(struct swap_info_struct *sis);
 
 static inline unsigned long total_swapcache_pages(void)
 {
@@ -532,6 +533,10 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 {
 	return -EINVAL;
 }
+static inline int swap_activate_fs_ops(struct swap_info_struct *sis)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_SWAP */
 #ifdef CONFIG_MEMCG
 static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2c9d2af736c4..26852c2ad36e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2757,6 +2757,13 @@ add_swap_extent(struct swap_info_struct *sis, unsigned long nr_pages,
 }
 EXPORT_SYMBOL_GPL(add_swap_extent);
 
+int swap_activate_fs_ops(struct swap_info_struct *sis)
+{
+	sis->flags |= SWP_FS_OPS;
+	return add_swap_extent(sis, sis->max, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(swap_activate_fs_ops);
+
 /*
  * A `swap extent' is a simple thing which maps a contiguous range of pages
  * onto a contiguous range of disk blocks.  A rbtree of swap extents is
-- 
2.53.0


