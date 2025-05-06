Return-Path: <linux-nfs+bounces-11507-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BC8AAC77B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D023A8FFD
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B4A27F75D;
	Tue,  6 May 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qPdYoVVs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A0262D1D
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540509; cv=none; b=EPqo/GRpLTsKQrEli7y1Xu0tpKhm6snKUP8fsPWDjVk5zRa1fM2zvs5RcFBJk1Agotj9gxFLhfBGTKKLJXMKsq2WwuoHdUhKUw6A9xsHpo/wtAmJy9JaD1Fzled+Dw0zLmtvck9wpnjKesMsDvUI8xhXHGOIVHomqhhRCCDLlfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540509; c=relaxed/simple;
	bh=qivWZFJKfAMmPC78fAhn6bFhQqYp2FYSh42VgCvxcsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUys3ZtpiE27TbXP+PloNPUlWPGnl67PD02kTqEbOq/0a0od05oXYxr8O9rzkvTdMbBRqntMFEA0ZN1LECDZddCVsFq24sKaJ2xqmryTdevJep9XgNSN/rtpILk7rmKh1DlMkf07z+52RhhyHH82qCawdNRMv/jVSSbStBIavMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qPdYoVVs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fFeYL4CB6/TWJb4XeFZ6gsZ0p39SFSA3h93ToALGJkM=; b=qPdYoVVsmfvbX+YBJPsleSAqfa
	6t+xyb/oPoEg3MQFhad4ZLQYqU7p0E2Hur8ClMs9a1U+EtFkRm8mU2W/9Mi+MuT3BMBezC8lQK9Yo
	R1XgYgnmwhvNk/rPbfpVPJ8cs9QtAOSnUvtZdzf1rJDdhWrhcG9we33KGUFRcEtqDSo0AHx5eK5Ie
	kfUBpn4rVk0eTPKc/UStpUHLQneDcwZLah6nDX3BuB7JDClN4HD1UDYhRi4ux45Th4mSWsVIhx6F2
	Sg60kwpy0aYj7/9inxPrJ0KlELe5GguCGJP081lXJzWMvSKFQxkJDeNTY3OAYzGq+9hFO7hZpmZhG
	UuwtgD3Q==;
Received: from 2a02-8389-2341-5b80-3871-beb2-232f-7711.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3871:beb2:232f:7711] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIyB-0000000CG5o-1lpV;
	Tue, 06 May 2025 14:08:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] nfs: move the call to nfs_pageio_cond_complete in nfs_do_writepage
Date: Tue,  6 May 2025 16:07:49 +0200
Message-ID: <20250506140815.3761765-4-hch@lst.de>
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

Calling a function before the main variable declaration is extremely
confusing, so don't do that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/write.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 3e873c5b1041..4e1d57b63a85 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -635,10 +635,11 @@ static void nfs_write_error(struct nfs_page *req, int error)
 static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
 		struct nfs_pageio_descriptor *pgio)
 {
-	nfs_pageio_cond_complete(pgio, folio->index);
 	struct nfs_page *req;
 	int ret = 0;
 
+	nfs_pageio_cond_complete(pgio, folio->index);
+
 	req = nfs_lock_and_join_requests(folio);
 	if (!req)
 		goto out;
-- 
2.47.2


