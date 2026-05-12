Return-Path: <linux-nfs+bounces-21480-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK8nIdzCAmp7wQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21480-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 08:04:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF4651AA23
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 08:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 778AF3193835
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 05:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0E73C7E1D;
	Tue, 12 May 2026 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WpIBIsdB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD23D6CD3;
	Tue, 12 May 2026 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564214; cv=none; b=oHbB5bGuKoYT9dyqDfeSi4Fw7vX0nh+Fq1SK5jSQzV4bbGEtOREQfiMY6OURVJnlxzmYKdKsoJ8ClK0z0Ivf5STVqlwVkx6dkjHP1ky3wVxKJ9uU+lorvt00UUl5kfLiYwC1N703lq70ziYqweyzp/gz6ww4vfeiIhNGNP2+elQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564214; c=relaxed/simple;
	bh=UQI14b/u9YE48xHSRJ/amUWqDHRSPMknTalbgqmZDLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5r1ECRZ67kGwXKx0y8IiXclraG5ACn7x1UwW0gL+2hY5NtIKsrAI5RYJ89SCwXbS5imDme+PTq6dci1uaJT+60es3XULvioP6m6QHOvZrMIA2EBVcUJwsCBIBNhv9QhH9Y2neZgPB9VODju+ORfN1FRBpdj4N7mOstuRMCbKyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WpIBIsdB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=n899WPhwIZ+KymzRJYJT56SoCbIK1OLetz93e2eg8Xs=; b=WpIBIsdBq0sBt+PNrgh3yLlis7
	6qDcTGTooMfAWemyiheQrD2xqLTMjj9shCEExwkg8sQgrypWxqhtXB8NtwvKzCDQGLh7arQSgqpRS
	vp6OO9kpk5BFFrHwqKH1Aq14wFz9j/vt9QTrmrWM0n4dMrCEk29dM2vGLGoosLHWnkBGEe9RJodgS
	L0ZAgsUHOLJSoH4Ls+ioKqJlrBZzoHbAPhWU8PgVPfiV57u10K8gCsAriG2aj5XIquIS/COy+I0+w
	6sdAMS4yE6R/qIihIut2DLnwPcK/zKF4yCW9j30M1/q5xrO+zrpDcmTnG0PoO2MhHGS5rQ+OSAcBD
	i4G4GVUA==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfnN-0000000FfF1-0DCt;
	Tue, 12 May 2026 05:36:41 +0000
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
Subject: [PATCH 01/12] swap: remove the maxpages variable in sys_swapon
Date: Tue, 12 May 2026 07:35:17 +0200
Message-ID: <20260512053625.2950900-2-hch@lst.de>
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
X-Rspamd-Queue-Id: 1DF4651AA23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21480-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Action: no action

Always use si->max which is updated setup_swap_extents instead of copying
into and out of maxpages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/swapfile.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9174f1eeffb0..f7ebd97e28a3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3350,10 +3350,9 @@ static unsigned long read_swap_header(struct swap_info_struct *si,
 }
 
 static int setup_swap_clusters_info(struct swap_info_struct *si,
-				    union swap_header *swap_header,
-				    unsigned long maxpages)
+				    union swap_header *swap_header)
 {
-	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
+	unsigned long nr_clusters = DIV_ROUND_UP(si->max, SWAPFILE_CLUSTER);
 	struct swap_cluster_info *cluster_info;
 	int err = -ENOMEM;
 	unsigned long i;
@@ -3395,7 +3394,7 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
 		if (err)
 			goto err;
 	}
-	for (i = maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i++) {
+	for (i = si->max; i < round_up(si->max, SWAPFILE_CLUSTER); i++) {
 		err = swap_cluster_setup_bad_slot(si, cluster_info, i, true);
 		if (err)
 			goto err;
@@ -3425,7 +3424,7 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
 	si->cluster_info = cluster_info;
 	return 0;
 err:
-	free_swap_cluster_info(cluster_info, maxpages);
+	free_swap_cluster_info(cluster_info, si->max);
 	return err;
 }
 
@@ -3440,7 +3439,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	union swap_header *swap_header;
 	int nr_extents;
 	sector_t span;
-	unsigned long maxpages;
 	struct folio *folio = NULL;
 	struct inode *inode = NULL;
 	bool inced_nr_rotate_swap = false;
@@ -3512,14 +3510,13 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	}
 	swap_header = kmap_local_folio(folio, 0);
 
-	maxpages = read_swap_header(si, swap_header, inode);
-	if (unlikely(!maxpages)) {
+	si->max = read_swap_header(si, swap_header, inode);
+	if (unlikely(!si->max)) {
 		error = -EINVAL;
 		goto bad_swap_unlock_inode;
 	}
 
-	si->max = maxpages;
-	si->pages = maxpages - 1;
+	si->pages = si->max - 1;
 	nr_extents = setup_swap_extents(si, swap_file, &span);
 	if (nr_extents < 0) {
 		error = nr_extents;
@@ -3531,14 +3528,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
-	maxpages = si->max;
-
 	/* Set up the swap cluster info */
-	error = setup_swap_clusters_info(si, swap_header, maxpages);
+	error = setup_swap_clusters_info(si, swap_header);
 	if (error)
 		goto bad_swap_unlock_inode;
 
-	error = swap_cgroup_swapon(si->type, maxpages);
+	error = swap_cgroup_swapon(si->type, si->max);
 	if (error)
 		goto bad_swap_unlock_inode;
 
@@ -3546,7 +3541,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
 	 * be above MAX_PAGE_ORDER incase of a large swap file.
 	 */
-	si->zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(long),
+	si->zeromap = kvmalloc_array(BITS_TO_LONGS(si->max), sizeof(long),
 				     GFP_KERNEL | __GFP_ZERO);
 	if (!si->zeromap) {
 		error = -ENOMEM;
@@ -3597,7 +3592,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		}
 	}
 
-	error = zswap_swapon(si->type, maxpages);
+	error = zswap_swapon(si->type, si->max);
 	if (error)
 		goto bad_swap_unlock_inode;
 
-- 
2.53.0


