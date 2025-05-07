Return-Path: <linux-nfs+bounces-11545-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B89FAAD49C
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 06:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1C37AAC6D
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 04:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2D1CCB4B;
	Wed,  7 May 2025 04:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hrh5tO1c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69C1F956
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 04:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593358; cv=none; b=b47DDVriOmqEjnS66dibNQXLVEbzj/bL3V/gMG5P0ntU2VWd3gdsKuOKbth23owFcCA5JjHJxBL7bNG5mf3gC9ZLbmQWm1SdMAiox5p856JeHe88FQ8r4LiB9c0AgkNmN9+8IlLbw0NvQBdYiujerySKMW7yPLzvI6QFfijCacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593358; c=relaxed/simple;
	bh=8cLvegnhEWoeErefkkiAzVr/eUPmRbWvRVqqd2+aPPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJHEK314Z97Q2G0xSm1Zfr/mt0YsYZT0yADk+0FQLDRLWK8XkC/xAwHY2FuQXuPgxzGX6RRzgg+7g4lDO2zg8eo22iCGuGSl5FHGyNVh28SCt2STGqNg2wHfEky6C1opUR0upC2lNHiQwHatSlXPPi7AT3yJfTPA968YKHfxr5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hrh5tO1c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=U5LideAoXAHCa+2892Z3gX8WOUQuBUPf+Y3ZWSqCAuw=; b=hrh5tO1cvjbggHNg4rNGtDoJji
	hJU1NXTOGuiUPDX07fA1xAhvvWiEJpt/nYarOWotuDRqcnnWbz/+pA2e5jC1Pp3uELQU1lc+WYyhu
	y22BCa3HX4s4JFLN4PJJhl5gZB9CkaVdPq/aK/gS9FlfqR4gRZrmaYeOvK2FOc+frUKU1vLblP+3s
	oaqaEXOIxEgnXkMd6u79TLS7jPeBY8jt6BMDhxVRssLvLiCFis84RQ2bpoWA0j/0n0sg65T+qTBM/
	/dSfTkn2xAqcYam71/73+v7LsSfJQbxFGyCqg/9HXsJpUtBWZYTiluYwaVl+Go/8Yv+5FK8h6F27C
	8RwTDH3g==;
Received: from 2a02-8389-2341-5b80-3ba7-83fe-7065-4f0b.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3ba7:83fe:7065:4f0b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCWiZ-0000000ECXZ-0aZW;
	Wed, 07 May 2025 04:49:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] nfs: fold nfs_page_async_flush into nfs_do_writepage
Date: Wed,  7 May 2025 06:48:51 +0200
Message-ID: <20250507044908.3891983-2-hch@lst.de>
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

Fold nfs_page_async_flush into its only caller to clean up the code a
bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/write.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 23df8b214474..148e773c3665 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -632,13 +632,14 @@ static void nfs_write_error(struct nfs_page *req, int error)
  * Find an associated nfs write request, and prepare to flush it out
  * May return an error if the user signalled nfs_wait_on_request().
  */
-static int nfs_page_async_flush(struct folio *folio,
-				struct writeback_control *wbc,
-				struct nfs_pageio_descriptor *pgio)
+static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
+		struct nfs_pageio_descriptor *pgio)
 {
 	struct nfs_page *req;
 	int ret = 0;
 
+	nfs_pageio_cond_complete(pgio, folio->index);
+
 	req = nfs_lock_and_join_requests(folio);
 	if (!req)
 		goto out;
@@ -677,13 +678,6 @@ static int nfs_page_async_flush(struct folio *folio,
 	return 0;
 }
 
-static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
-			    struct nfs_pageio_descriptor *pgio)
-{
-	nfs_pageio_cond_complete(pgio, folio->index);
-	return nfs_page_async_flush(folio, wbc, pgio);
-}
-
 /*
  * Write an mmapped page to the server.
  */
-- 
2.47.2


