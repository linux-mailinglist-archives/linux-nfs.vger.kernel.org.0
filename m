Return-Path: <linux-nfs+bounces-11505-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150CBAAC779
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528933AB6B5
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C33124E014;
	Tue,  6 May 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NGGMbIV2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5128151D
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540505; cv=none; b=UWPeUSNiiKnu3BOYgbEfdwKs0ORWbrQv4+yhcuLgBzNbWPFPVTUWPGiBI83hapI64CEcyWe/a2cauWeuRid6xmstMdfNu401XiFPdz9cm/VwF62e1ClnmPud52XJShmb5dIzGEtMKzkoWHS+ZGVoxLbDQHuqgqxNOarat9sjKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540505; c=relaxed/simple;
	bh=46tU6mW9HKSjNfIeVDlMdKk3FtTNHdYBmc6Dk59gRuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2Cwtme0PN9IPj84FoLy7pkFI/Kgy9HmtyD+cA042CcC0mfh/HatDaBMft0pNWrMPqj5Hbflm2PHJWv0N1u3At0iXAskS1sAff9a0cEw0bZJfdTriP7FHYNxas7p4LguvHkzMf1VRPmFWmkPco2YXQdzdRaMQM0SwEqw3KZYLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NGGMbIV2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sM/oZ3k3q1DB3YflV4tZq4hdY0V0jg4mXWeVEzIkv8s=; b=NGGMbIV2V+80tlelW05VRAS6ur
	8eqLUIESUKZSyx9BtWsWByhvx+h53Gk8RZXDaSHHKLzosvEYDB1LJJwnJjiGNzS9mtdLe9bQchhZB
	Jlj6UAR6eI1dybnVVwakR71hFOMhApqvk0Yb4n8Mo/eofa42t+31j0Dz3/C4n4+CDlD+yMS8+II5M
	zmzmS/pG/uUvuVFk/yN9VIK6O0yeNnZZDd/C84MvtsFycml/Z5gWy/mK3+x+m7uZwCabNps2AnoB1
	cQv/BE4l0lX44E/RTrlp3uoeXZCIS+x5uK8PL+UipIxtTg/wcrZZxatXq9lDrL8MsXQhKiC4O28sn
	WTX2aZjg==;
Received: from 2a02-8389-2341-5b80-3871-beb2-232f-7711.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3871:beb2:232f:7711] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIy6-0000000CG59-2KJp;
	Tue, 06 May 2025 14:08:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] nfs: fold nfs_page_async_flush into nfs_do_writepage
Date: Tue,  6 May 2025 16:07:47 +0200
Message-ID: <20250506140815.3761765-2-hch@lst.de>
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

Fold nfs_page_async_flush into its only caller to clean up the code a
bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/write.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 23df8b214474..048837a9b1ba 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -632,10 +632,10 @@ static void nfs_write_error(struct nfs_page *req, int error)
  * Find an associated nfs write request, and prepare to flush it out
  * May return an error if the user signalled nfs_wait_on_request().
  */
-static int nfs_page_async_flush(struct folio *folio,
-				struct writeback_control *wbc,
-				struct nfs_pageio_descriptor *pgio)
+static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
+		struct nfs_pageio_descriptor *pgio)
 {
+	nfs_pageio_cond_complete(pgio, folio->index);
 	struct nfs_page *req;
 	int ret = 0;
 
@@ -677,13 +677,6 @@ static int nfs_page_async_flush(struct folio *folio,
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


