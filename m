Return-Path: <linux-nfs+bounces-12056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D302ACB380
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 16:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB451947CC7
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28018228CA3;
	Mon,  2 Jun 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zc6fwMF5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41588227E94
	for <linux-nfs@vger.kernel.org>; Mon,  2 Jun 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874326; cv=none; b=ZxMOWc9rTfua6alDgOwLrILhYlFHKoiu6IKAtNtPZk3R4Psotcq1W55Gw8meGADj4sIF2MT1iZEublXqkbeVeGcAOrqGfHcTbzMpwNjBIgK3+oPzssElRb8hSAnyFmopFhlCGaF6d9rE0tgapOPy7CZ/dWZp97n/0GOQItJMlIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874326; c=relaxed/simple;
	bh=8cLvegnhEWoeErefkkiAzVr/eUPmRbWvRVqqd2+aPPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmClKUFoNmJ6jxOw/awiwYEx5WXG2CeFOX5uszd/uQDzOV4tsLI5zPquFGeAh7LfiNIfEY6dTdajoUT/ZzVRG+p8n71nLjMHZwLtqXEiIMUB1xImuBm0Hf3lGGRbuRHvCy4e3Dj2gFrs7N/84L4ZrL5I9doA38Q1SSGIIRnpvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zc6fwMF5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=U5LideAoXAHCa+2892Z3gX8WOUQuBUPf+Y3ZWSqCAuw=; b=Zc6fwMF5iEuNVq+IEGGheqDS5O
	6iNZZlQjZlIKmbRnAxXws/D/mVkSI2mCyRNacuMIoy165EP/w5LOvYClx7FjrllJwJoq/9ORKuq+F
	qubABlmf2hOh1WZnP/hnDyWb9DHAjWdYww0IrUMnN6mWa0zx/qP82XxbtxOO6v6nXhvOq5RPlWPwv
	3QyfUaHooBd4uCFJxuMylW89HbzNwAc51TndQFoyf1rCyriGV6+MTJ/V/xd3Ozz3McrccV1oYXCX7
	utLEx7AWEypNE3D4IOPmwEuOUiIGjw4JttAK5gJ8ljSAzSMZfiWu8aC1IqlzcLbUhpL2EHg3Yb7/Q
	vBTbVwkw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM66N-00000007ctz-0lgV;
	Mon, 02 Jun 2025 14:25:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] nfs: fold nfs_page_async_flush into nfs_do_writepage
Date: Mon,  2 Jun 2025 16:24:49 +0200
Message-ID: <20250602142517.408443-2-hch@lst.de>
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


