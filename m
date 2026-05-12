Return-Path: <linux-nfs+bounces-21485-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKBsOPTAAmpJwQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21485-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:56:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8219351A838
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F8E3099B67
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 05:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF483F65EC;
	Tue, 12 May 2026 05:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y18jNN6I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021B3F20F3;
	Tue, 12 May 2026 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564252; cv=none; b=NSpN6TY71YlObO0nFUP7Aro79qFdwoH2xvf5soKxFsJfRKjNF4uKxDJRuJH4Oqq8lB2fUhNMdPaSlqw1RfTwbXSrcLhXBrW1DRblyqwd2neHX5Chq4JO/jLCbX+6wwAwskPwELOhlVxtRP32WXNga7B07opy9JU8fXCC+xocfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564252; c=relaxed/simple;
	bh=Q0mPYoFNxcTHRoOPyGfRfh4p40MFVyVOeVVG0ccSiCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByidNt18NKSVS2PtgPEQy7JKNsR+ouEi5aA9M1PSKEeqQvS72MVi1aFCAWJM8cmye9jKei06LiCZOMlyIkJ41TFuwPti3p1DwrEAePzimB4xbbOByUOXoBLeGWChdCO42B0Lcqzlvg3jLtNUtr/6C5Ep4cuw1iRwNUlYtdRgiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y18jNN6I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/e1E43Aw8DTZbb0PWgWlLEg76+pOp+WQ5laY13dT/AY=; b=y18jNN6IPZlAJzD9Y2fqbDV5I5
	t70jJrjHcSzL6K2knltP7wGbdjaIIuebiXhzNNCkcG+TLWtCjasTBkVdIyDBJPH7qVtppi1Fon0/0
	D3YfBN/M4uLOPTU6ZZ/Acm4ajvvztkJ12cvkz9SgK99YpZkHkU8u7N0mI63biJ5dye+9DgbDNQ5DC
	dagBVq3ZLbxhntKH6bFTm/9bdWz4oWSJNz8PFJpzqmFN+krxQpbSd4hNsgM3ardXVB8DmstwokTGd
	c9RKK2S6TJNMY4e0fhrn8HP1lGValwj8cZabS4qvNOPa3s8r3rd4r/Vdf2NtDTYPDX4p53/9swG+5
	RMk1SW8A==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfnz-0000000FfNY-1SOX;
	Tue, 12 May 2026 05:37:19 +0000
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
Subject: [PATCH 06/12] swap,block: move the block device swapon code into block/fops.c
Date: Tue, 12 May 2026 07:35:22 +0200
Message-ID: <20260512053625.2950900-7-hch@lst.de>
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
X-Rspamd-Queue-Id: 8219351A838
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
	TAGGED_FROM(0.00)[bounces-21485-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email,lst.de:mid,infradead.org:dkim]
X-Rspamd-Action: no action

Make use of the abstractions we have.  This is a preparation for
moving more special casing down into block/.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c  | 6 ++++++
 mm/swapfile.c | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index bb6642b45937..453141801684 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -949,6 +949,11 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 	return generic_file_mmap_prepare(desc);
 }
 
+static int blkdev_swap_activate(struct file *file, struct swap_info_struct *sis)
+{
+	return add_swap_extent(sis, sis->max, 0);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -965,6 +970,7 @@ const struct file_operations def_blk_fops = {
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.swap_activate	= blkdev_swap_activate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC,
 };
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1b7fc03612f4..fbf11c8c5c69 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2781,13 +2781,8 @@ EXPORT_SYMBOL_GPL(add_swap_extent);
 static int setup_swap_extents(struct swap_info_struct *sis,
 			      struct file *swap_file)
 {
-	struct address_space *mapping = swap_file->f_mapping;
-	struct inode *inode = mapping->host;
 	int ret, error = 0;
 
-	if (S_ISBLK(inode->i_mode))
-		return add_swap_extent(sis, sis->max, 0);
-
 	if (swap_file->f_op->swap_activate)
 		ret = swap_file->f_op->swap_activate(swap_file, sis);
 	else
-- 
2.53.0


