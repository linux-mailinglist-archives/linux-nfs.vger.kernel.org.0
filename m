Return-Path: <linux-nfs+bounces-11509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75841AAC77E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7640E4A018A
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58837281371;
	Tue,  6 May 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BAxC/Pcj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E095424E014
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540516; cv=none; b=Qi6kVadbQYMkOZQLi1xzdS+Hn7RgSWbtt2TMy69AJq/DlBj57Y0kzypftpcwA8KY128Q49eOY1Y7sASsKhFVbJxmLcAXsHP+4NkzAzoeGUAq+UmmHlz1NKCIYVoQX/3Z2VBGWi6667qJ3w/Wk4cXqlgMdqryNbBAnlxUR9Bx1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540516; c=relaxed/simple;
	bh=jlRDbU0fcwx4nYSYKKnRs8gI80wBH3ln+L8lNEM5FqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPHhGbz1hcMbjKdl8B19ggx9fJdtskWFvDMVuh8tyL7uFko/wX39bLlakG5XPyPEg7vZsowj/TzU+VCwTGR2iP0OsKhKzPv+KF9tf8xpg4qMcN4u5rZa3mIcusVMuD/5jcZwMwoJvZG+aCYxUc+2/HvkQxfKRSRJ1s0/B1s69DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BAxC/Pcj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7BnQZytnr9lyaSZa4xj8MCesqLa2nxkm+PPuX/aJKis=; b=BAxC/PcjSf0VX4e8aa7vrcVKnQ
	7OKJcIjIqZrB8vT6/X2574rk8gCyl4mhXRwjggeGTBGlESOnE55GR+lh/EaP9q7cSmAWIHstoT0t9
	Ivn7ofqe4siEhKjVTxt4TVljVX+1hv3GzJUpDCCJ2mmZqwg3Cewaiyv+qT7t1gukkTmVG85jv1St0
	SOek+yZGKcFrrL/+xEck2rn/S8taC5ScEqyeu5xVO2nEU10SSBTPjZke7S62n/WjSqcI/2Eab+O9m
	vgRw4+j2yshJIDDs8A6ZvWBm8pZ8Ip+V6kAeq4AhDxAETXZ9ZkUO/BVIhm87RGDPNHjAsV0s5W2bx
	N4XdU/NQ==;
Received: from 2a02-8389-2341-5b80-3871-beb2-232f-7711.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3871:beb2:232f:7711] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIyI-0000000CG7D-0r3v;
	Tue, 06 May 2025 14:08:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] nfs: use writeback_iter directly
Date: Tue,  6 May 2025 16:07:51 +0200
Message-ID: <20250506140815.3761765-6-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250506140815.3761765-1-hch@lst.de>
References: <20250506140815.3761765-1-hch@lst.de>
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


