Return-Path: <linux-nfs+bounces-11548-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670FAAD49F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 06:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67C37AB2B4
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 04:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADC21F956;
	Wed,  7 May 2025 04:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bu/J4a6W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA78D1D47AD
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593368; cv=none; b=FGRmA4ZN5N6ATTcyOLhet2WD0lm9bHMZCqPFm01yzTHf3LxueQ/lQsSUP71+wfvHrSxuTnhQFJ5hZUyyar1If59i+MohZ/OXwQBJa9jMeYh5mJrl/shL2q9/ICOcO2tHJn5HzffCNXV8t1MRDah2NolqEGtDEw6DGpRGSQ+yyNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593368; c=relaxed/simple;
	bh=jlRDbU0fcwx4nYSYKKnRs8gI80wBH3ln+L8lNEM5FqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2lqEbQe+1WlFLok1nxyKbEarp4Lry4Ld1dsHSkGj6HHjsjI/QXK+XRlkt2To6lvz/HBuqI0nE66LQhaKYjdh3NZUWFE1VkNIeIiNnz6qQjw3O/c5R1UnFVRVntBEg/EfYuyTAj1V+kd5eEtfH0oSWc5Evvdyhx3ULASgmqfA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bu/J4a6W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7BnQZytnr9lyaSZa4xj8MCesqLa2nxkm+PPuX/aJKis=; b=bu/J4a6WG9v9x4IiuK9kVIq57I
	ImyduLUdLntmz8T45bJkYFUdI7ibUfUWIi5h3CK6c1w/US2p663XNBHJc+Tb0YumlrexUSdgDO/ZV
	RYChDFBzV22h2HPryfjGkoIklCncFqqXPeSNtrL7fpKHPBgNBfcEKCNiKj+UXP8/BbPnRUb8mCs88
	V7P85xvGU+F2p08Xa82PmHMOPypyBpT+2sf/znDKRhacnaIwmNPmUHep7gADnLt75zUTcRH3bpTcU
	4256FeC/ErBujx8TKyf6f1JICUO253ysQk6g10pYAGd8q11Qdp8VCNr0oAr8z4vCTDGoAjZ98Aeqk
	aPSwB6xw==;
Received: from 2a02-8389-2341-5b80-3ba7-83fe-7065-4f0b.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3ba7:83fe:7065:4f0b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCWij-0000000ECZI-40Tm;
	Wed, 07 May 2025 04:49:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] nfs: use writeback_iter directly
Date: Wed,  7 May 2025 06:48:54 +0200
Message-ID: <20250507044908.3891983-5-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507044908.3891983-1-hch@lst.de>
References: <20250507044908.3891983-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Stop using write_cache_pages and use writeback_iter directly.  This
removes an indirect call per written folio and makes the code easier
to follow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/write.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 68c5dc061abe..374fc6b34c79 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -694,16 +694,6 @@ static int nfs_writepage_locked(struct folio *folio,
 	return err;
 }
 
-static int nfs_writepages_callback(struct folio *folio,
-				   struct writeback_control *wbc, void *data)
-{
-	int ret;
-
-	ret = nfs_do_writepage(folio, wbc, data);
-	folio_unlock(folio);
-	return ret;
-}
-
 static void nfs_io_completion_commit(void *inode)
 {
 	nfs_commit_inode(inode, 0);
@@ -739,11 +729,15 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	}
 
 	do {
+		struct folio *folio = NULL;
+
 		nfs_pageio_init_write(&pgio, inode, priority, false,
 				      &nfs_async_write_completion_ops);
 		pgio.pg_io_completion = ioc;
-		err = write_cache_pages(mapping, wbc, nfs_writepages_callback,
-					&pgio);
+		while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
+			err = nfs_do_writepage(folio, wbc, &pgio);
+			folio_unlock(folio);
+		}
 		pgio.pg_error = 0;
 		nfs_pageio_complete(&pgio);
 		if (err == -EAGAIN && mntflags & NFS_MOUNT_SOFTERR)
-- 
2.47.2


