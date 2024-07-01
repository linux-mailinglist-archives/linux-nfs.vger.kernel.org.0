Return-Path: <linux-nfs+bounces-4462-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2F891D76A
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 07:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECDE1C2226F
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 05:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74EE2BB0D;
	Mon,  1 Jul 2024 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BA2vFbxY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AEE1A269
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 05:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811638; cv=none; b=cf/++uadzEC4/FcmXXaLoIe8XI1V2GlpUJeWa4eOqLnMhDvS7c8PQp15SWMGd4azkZ2Frg6AWxWNhK7IwFHFfdDS7bkaSGAmgSG8EJahOv8d3+dIdrrh0Hfq+zW8ilRce1c/W9J7Nryq/yGdCV+ncJJzxbIVqeP+yFQGD96qByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811638; c=relaxed/simple;
	bh=k+Zrg5oje8aqlzb0pR5oJBHdYF3D5JuDZ7HXn4D2keA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6vdMsci+KObVU9b0Ez9PLDAVUn4ylcJDPWTzwjdtePvUyVgTusfGd6DFR+ObrWkVwM0yxzU1XWDODAkyfeBrkFjIJ29LBrvr9yI2m9UQZ+TrkpNnEA1MuiZULflHgqACxs2xMB9yNs02Uua16pKOJ6REsfHEuRhxySSS1RiJGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BA2vFbxY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dHDBGLhbMBMx5j8rsKvHlYHwZr7GSnZaTbze8Nf096w=; b=BA2vFbxY8+jlEu3G7nvdKoPcaf
	3eo9Dfz7jnd+l+nl3MlS5yzrGp/tH2TauOE/8xTYSa8zmX17dbI98qbGt/atzhq+JwGahuJgum2tu
	ml1tUTVTjWOMdMe/qmMRc5LEN9ZB9fuuU1ynmuCb8hpq0BBRsStvpCUb6TSGWo1JcUr9DanutRm0A
	eFG6ZtiSXthiQPB4i/wOvpYzA8BaiJDFj7zDtnpQ8GuLMHhMp7p1eJ2Vx88qznnAhqUqCbAgCOi5r
	rwV5QSAesjXOHjb1caDRg4DNGodajffwE5lXLUiKhOB/oHU+NhW1nhrtp2+e5+9262r4VFLhxO2UV
	IdxM37tA==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9ZM-00000001kAe-39U9;
	Mon, 01 Jul 2024 05:27:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/7] nfs: remove nfs_folio_private_request
Date: Mon,  1 Jul 2024 07:26:49 +0200
Message-ID: <20240701052707.1246254-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701052707.1246254-1-hch@lst.de>
References: <20240701052707.1246254-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

nfs_folio_private_request is a trivial wrapper around, which itself has
fallen out of favor and has been replaced with plain ->private
dereferences in recent folio conversions.  Do the same for nfs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/write.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 641bdddeaad331..5410c18a006937 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -169,11 +169,6 @@ nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
 	return 0;
 }
 
-static struct nfs_page *nfs_folio_private_request(struct folio *folio)
-{
-	return folio_get_private(folio);
-}
-
 /**
  * nfs_folio_find_head_request - find head request associated with a folio
  * @folio: pointer to folio
@@ -190,7 +185,7 @@ static struct nfs_page *nfs_folio_find_head_request(struct folio *folio)
 	if (!folio_test_private(folio))
 		return NULL;
 	spin_lock(&mapping->i_private_lock);
-	req = nfs_folio_private_request(folio);
+	req = folio->private;
 	if (req) {
 		WARN_ON_ONCE(req->wb_head != req);
 		kref_get(&req->wb_kref);
@@ -220,7 +215,7 @@ static struct nfs_page *nfs_folio_find_and_lock_request(struct folio *folio)
 			return ERR_PTR(ret);
 		}
 		/* Ensure that nobody removed the request before we locked it */
-		if (head == nfs_folio_private_request(folio))
+		if (head == folio->private)
 			break;
 		nfs_unlock_and_release_request(head);
 	}
-- 
2.43.0


