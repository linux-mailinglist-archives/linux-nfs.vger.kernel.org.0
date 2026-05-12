Return-Path: <linux-nfs+bounces-21490-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mau0Jxy/AmoUwQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21490-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:48:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731151A68B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 019423024A80
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 05:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285503CD8AC;
	Tue, 12 May 2026 05:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LiH5UIQa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC93CF047;
	Tue, 12 May 2026 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564287; cv=none; b=u/DtLdbkHlf/JgHc6baQDQ0KZ8/B6O1lL18hyQB432brf20zqzIzvzM2jLxRQVqqbMlzmvydcS832HiJ5VOFKs2euRvajmp4Y5AIcRKyOSYmQqrI8vdW6LLiqeF3BSRhGdOsjbpKpje09qK8CHi31MDMMnb6RmmONsJpEhYFrxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564287; c=relaxed/simple;
	bh=EaE4U9agYy7CmpsRTLn+1lnOAW/tzgqIB4aZlGJmh1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIU6ptWBkpKEX+qcovPLYTNaUiIlQOFVsw7Aapi3nJJOiZF5g9YAzQ92eMxKxweQsjTUASdNgCwAMK4cdCMEXBLVHJCClP4o+wRqN1rVfOBO8cq1HID0zPa3OPOTgtoMnNZxBiN5AENbo4WBRJIAZ70vP7HR4Woiq+rLHWB+SrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LiH5UIQa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3njmnPYKfXyGxBuvKgaH5GivvgicyjwAkMmByhnmVfs=; b=LiH5UIQaX7gQOxBmNMmgiW2c9M
	Sw4TUVUPyiAW+otc+CLl1MH8cNxafrJTke/+5h9ekIgkCCE6wUvC0Wp/hsAmzQNABnrIxxB0la6W2
	K+LEhQeH/uU0PTzGQAOaFzioXzpzvrHVQb9T7pD4RjGUwIVj2SuL6wcODRIImWU8mDrJOyqjI519P
	iBAKU++IsFSrs/7KErD6eQrhXvg9hTd/dViywq3t2OWMC0EJF1+UjOFOKgyCW5nmJEynP6BjIbd8B
	EJroeuDhIKqm7kAp5yFSu5BfA2aMaik60jjBnsCTMAt7RoUPFZ2/yWx0pC0EtQgHohGzZbgEPGihn
	jJKGY1xg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfoa-0000000FfVQ-2Hu2;
	Tue, 12 May 2026 05:37:56 +0000
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
Subject: [PATCH 11/12] swap: move struct swap_extent to swapfile.c
Date: Tue, 12 May 2026 07:35:27 +0200
Message-ID: <20260512053625.2950900-12-hch@lst.de>
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
X-Rspamd-Queue-Id: 3731151A68B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21490-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim,lst.de:email,lst.de:mid]
X-Rspamd-Action: no action

struct swap_extent is only used inside of mm/swapfile.c, so move it
there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swap.h | 15 ---------------
 mm/swapfile.c        | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 916889738f08..95237ee065c2 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -178,21 +178,6 @@ struct sysinfo;
 struct writeback_control;
 struct zone;
 
-/*
- * A swap extent maps a range of a swapfile's PAGE_SIZE pages onto a range of
- * disk blocks.  A rbtree of swap extents maps the entire swapfile (Where the
- * term `swapfile' refers to either a blockdevice or an IS_REG file). Apart
- * from setup, they're handled identically.
- *
- * We always assume that blocks are of size PAGE_SIZE.
- */
-struct swap_extent {
-	struct rb_node rb_node;
-	pgoff_t start_page;
-	pgoff_t nr_pages;
-	sector_t start_block;
-};
-
 /*
  * Max bad pages in the new format..
  */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 26852c2ad36e..c0479533f9ef 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -260,6 +260,21 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	return ret;
 }
 
+/*
+ * A swap extent maps a range of a swapfile's PAGE_SIZE pages onto a range of
+ * disk blocks.  A rbtree of swap extents maps the entire swapfile (Where the
+ * term `swapfile' refers to either a blockdevice or an IS_REG file). Apart
+ * from setup, they're handled identically.
+ *
+ * We always assume that blocks are of size PAGE_SIZE.
+ */
+struct swap_extent {
+	struct rb_node rb_node;
+	pgoff_t start_page;
+	pgoff_t nr_pages;
+	sector_t start_block;
+};
+
 static inline struct swap_extent *first_se(struct swap_info_struct *sis)
 {
 	struct rb_node *rb = rb_first(&sis->swap_extent_root);
-- 
2.53.0


