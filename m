Return-Path: <linux-nfs+bounces-11506-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12666AAC77A
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED933A56CD
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2C278745;
	Tue,  6 May 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oagtkj7/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA027B501
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540507; cv=none; b=iUxX3jTYaO91w54stHEaefGgy5sHf8tG7kXKrR4iTVdUMxtp8QpyhyD6lGkGEtrp7fY++YDymWNoeperjNR/jusXNCwx5xR4BdXcAzUrdcyMGZpqaIjkVX2NiBCnGZ8kQnBLVwnIDMbNIqXHh0GqUwoUVcP2qbY1naeTthekL3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540507; c=relaxed/simple;
	bh=yza8oWcmLUORhc+nheVPyzqYVDNiN2eXk5FFIWTPUik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfLkmFc731quCXjB2b4A6C2Qj54bsvoXfcw71/52GCKfpnc58ex2HzrRnV7qlHjhRh1w/DIQcnHoJ8FE6aua6qQkJWERh8hMnFglyp2gQI2PB876AqCbYrkLNJ2etU/Fw6+tZNu/OsFGI/BaqjN1mhLbCaH9QHu95mlVUd3dgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oagtkj7/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hqTBs+dDnkE9iiSwZKqwx5mk/WnT9A69b+o9Incw3jI=; b=oagtkj7/K6UB/nCJ1YjNdAlCek
	TG5MTvHLL4i0DVV9u6FLjIkzZKYAuIRb073i0d4qqn3aB274Ni3MoN/ObfWfXtex8D/j4mAVdFl+e
	rr9FxXfmgkt9tytG8pjN2qmuD9cAXMLprM8rcrp5ac+h7wYt5+jGLGe1hCQpzX9m4qsyLgkk7TN0q
	3Bt7x2hU55/d959jwgYrONgMBpDsZ5F342K0ViT8YzEJRV+jXNyj5Cvlu+nFPgsckv9MKePxTv5Ef
	H0wRt22y3EYuJ2aMsXqPcweET8i1+XophwB5P2w0/nzhn0JNkvPiigwVEkEyGDH1LzHytifhWUspl
	U+tc5UXA==;
Received: from 2a02-8389-2341-5b80-3871-beb2-232f-7711.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3871:beb2:232f:7711] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIy9-0000000CG5V-01OC;
	Tue, 06 May 2025 14:08:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] nfs: don't return AOP_WRITEPAGE_ACTIVATE from nfs_do_writepage
Date: Tue,  6 May 2025 16:07:48 +0200
Message-ID: <20250506140815.3761765-3-hch@lst.de>
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

nfs_do_writepage is a successful return that requires the caller to
unlock the folio.  Using it here requires special casing both in
nfs_do_writepage and nfs_writepages_callback and leaves a land mine in
nfs_wb_folio in case it ever set the flag.  Remove it and just
unconditionally unlock in nfs_writepages_callback.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/write.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 048837a9b1ba..3e873c5b1041 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -662,8 +662,6 @@ static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
 		 */
 		if (nfs_error_is_fatal_on_server(ret))
 			goto out_launder;
-		if (wbc->sync_mode == WB_SYNC_NONE)
-			ret = AOP_WRITEPAGE_ACTIVATE;
 		folio_redirty_for_writepage(wbc, folio);
 		nfs_redirty_request(req);
 		pgio->pg_error = 0;
@@ -702,8 +700,7 @@ static int nfs_writepages_callback(struct folio *folio,
 	int ret;
 
 	ret = nfs_do_writepage(folio, wbc, data);
-	if (ret != AOP_WRITEPAGE_ACTIVATE)
-		folio_unlock(folio);
+	folio_unlock(folio);
 	return ret;
 }
 
-- 
2.47.2


