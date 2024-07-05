Return-Path: <linux-nfs+bounces-4632-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D710928171
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 07:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C19285BEC
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 05:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C9132127;
	Fri,  5 Jul 2024 05:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bKipfFwo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357527452
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720157923; cv=none; b=sK7lS4VcZJxcY4Ggt8C5+gDcBMkW+sDdYbW5EsVr8OU1/sUvPWkwq05j5nR2oiROZE88DvkylXc2SdoPP+V0MsYDV0EHPaShutvVEo2rIuivc4vyJqFcscGGUfE8jITadne3JE58yVYwiZAl+LN3JiRbHD5wsJJ698NrteVhieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720157923; c=relaxed/simple;
	bh=vPYby6DL+Xz/AYEJXoa+L0G7DELeDfCPLzlwoXfwYcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rm9CmBbKh4wADRhJJ8kKeAA7WzLTGSiw68yX+exnjQ0ggAttLWfd/ClPq5Z6cEjchdOo8TG5L9QrNJi8lw0E8/83JghBKClx61OUtLF2xMblZNuoTtB9uHS4Urt76F6hiRdmhvQgZ2q3hPI6UlP4OHkAKOk0G6CtaCYt+h2oDfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bKipfFwo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YRV2UD/blrBIFuh8Fy31AIbE7Ge0XAmgcgMAoE0B0Ns=; b=bKipfFwo1dKxQDHLLAfE0WoATY
	gAC78yrt6kiE/66YNIMoemxvafTPVS+LcPGswtrjyz4FEA7VHNFTjQJcgqK0rC0AsWo6PYZq8Ja35
	y/pwSxY1sW5l1RYRuRMSUCpCNLqeisI3jkzVFyGsgbMjH8V0wCPAROEKAxsN86U0SCIq9oOwPgMkr
	5JO/R2wwOqYJPH9PVqq9oP9ADKG+wn2RJypRs5WBN2OxvQYRDv/BCHJSB5BOPKVF4bcJfs33cX6IG
	f8AuQxBLd26TvwLOZ5Hf8edmLRs0A0HWBr/LmyXkmaZLyLeb5vEbbmVLddaxgxyRpZuc6m91/SzR8
	S3++sa1A==;
Received: from 2a02-8389-2341-5b80-7f6c-d254-a41c-2a9c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7f6c:d254:a41c:2a9c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPbeb-0000000EwtT-0xYa;
	Fri, 05 Jul 2024 05:38:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: remove nfs_page_length
Date: Fri,  5 Jul 2024 07:38:38 +0200
Message-ID: <20240705053838.2043203-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The nfs_page_length is not used anywhere, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/internal.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 87ebc4608c316a..5902a9beca1f3f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -797,25 +797,6 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
 	}
 }
 
-/*
- * Determine the number of bytes of data the page contains
- */
-static inline
-unsigned int nfs_page_length(struct page *page)
-{
-	loff_t i_size = i_size_read(page->mapping->host);
-
-	if (i_size > 0) {
-		pgoff_t index = page_index(page);
-		pgoff_t end_index = (i_size - 1) >> PAGE_SHIFT;
-		if (index < end_index)
-			return PAGE_SIZE;
-		if (index == end_index)
-			return ((i_size - 1) & ~PAGE_MASK) + 1;
-	}
-	return 0;
-}
-
 /*
  * Determine the number of bytes of data the page contains
  */
-- 
2.43.0


