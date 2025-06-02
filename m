Return-Path: <linux-nfs+bounces-12059-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EA1ACB3F8
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 16:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290AD940332
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F4F227E94;
	Mon,  2 Jun 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S7Vn90yG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5EC222562
	for <linux-nfs@vger.kernel.org>; Mon,  2 Jun 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874336; cv=none; b=Od5/3sZpw6jSs81ZQUbKtUWrcxiRC3/myNTBV2wRDiQXgTaPvSnBP97RHwWe2mWqLDE+sYTCZk6dpjEOohIRJn4wTxOhB6KSaoJo4OMCYr0SIz3I6Wzc5uLczzT9dkG6/yekMq1z3s4RwLmMrCr6kO30YZJqoYC0s/HT7rAWRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874336; c=relaxed/simple;
	bh=jlRDbU0fcwx4nYSYKKnRs8gI80wBH3ln+L8lNEM5FqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U01+hWdrlPUls0dR/Kdh4JGuDBTplXQhWOQ7LA6d+S3UMuf/25Z1aPbfsG366vjVO25v71SDVLnxnRqhJWh9lE2BPZjKw8OeEHCmwOGxP1YFxXk4c+XqZG1tHuDMuuv2KrDkdMPYu6d7JWxxo0ULeucZGZVwkYN9H/IZnz322Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S7Vn90yG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7BnQZytnr9lyaSZa4xj8MCesqLa2nxkm+PPuX/aJKis=; b=S7Vn90yG5cA07w74I5hmN5PVfr
	kIBS08/U5U17WMXERRva0QHe6XABxQLgIrcKA+PPYAJ1PUZb9FWxBeRn8pIDbTr5QeDCJDfcXg8i5
	8BRtwmd45f9hx7juT1m1Wwj2ujVrLwZE2kOaW57XG501rgyslcKzIVEVQqXdmdjeG5ohOPnuZAEuI
	iuVqybt1t4JY/uSPjcHLuDqUvVFrPjuHIF+kI/Xfs+fZA3LJcb13YQN9KC0oMtGlpLT5+ZYuS3gDH
	wiFHNq8z0ZRoyRoHs635MUOC5sT1xDDdnwfS9oerWhMC1Gyl1C2ot3gFmbnJ8sLyXI8cUYHxQzu/D
	IXMMwmXw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM66Y-00000007cvr-1aNZ;
	Mon, 02 Jun 2025 14:25:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] nfs: use writeback_iter directly
Date: Mon,  2 Jun 2025 16:24:52 +0200
Message-ID: <20250602142517.408443-5-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250602142517.408443-1-hch@lst.de>
References: <20250602142517.408443-1-hch@lst.de>
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


