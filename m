Return-Path: <linux-nfs+bounces-4633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A33928179
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 07:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0331F250AD
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 05:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE76613AA3C;
	Fri,  5 Jul 2024 05:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OMmPAWN7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146D73445
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720158176; cv=none; b=l8zLKgLYumspileegbWRuRSx/ajbv0+QxuWYRbul1pYo61WfXj8AmmOgx8cHctRcrwocqWRI3T4jTl5/EOvcQmG2ebONCIBvQy+4N5oQuIhBVFwjEG0n+6qWVBcMGNAIgL5kgDB7vfZZfQHX0KFP4EIVMGK9vSyn9aG9Rl9mh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720158176; c=relaxed/simple;
	bh=hm2G4/POeKwjsm2Py9L6tzdWTrLfX0hiC5ntJD3zjOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JA1GPU74OFBEJAPTfSB92dAtVOwFVrvRXYeouv5eapcCQ+HzUe17q1osbQsKLV1GQOsgkjjZU6KtI/Ym7BebNCv4vny388mtAc/NcwlimHSWXOQXYHy5VIutqVxVul7fx6HiywquNtmOcePVkTslz+vu/W61nsLfA3EqZrwvglY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OMmPAWN7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=GilV3SQ9EhKyQ0DkiqF0goyN6yn8hCrERQV8yGvPWew=; b=OMmPAWN7wtcAw4SA9H/LMHbN9t
	bklhWiGDSQkAp5krTxXOZ2o3ozK7bm6nyfHVd1B92YOOlduUN8MMkMK5B6N7jbDY3MyqMLxW8MNB4
	HTSLuXq7IcmvOCrHdp3R00JxVNQscQQpW6tqIpsAGnJvULFKKftIkZvx+bhWNmI9Yu8e9XNGGDN2M
	pMhtz9iYHmg+QfMsFu/vmFuQU/6KZnmywGVUWD+926QHGzv0MT+E8k04JV8nebTQTE0M9WJnxTcA0
	k7mpa1dPstNhEPwq7s+6Q2CG7RQhEM/1xEAZVFCFHKaGlXVLrxZnxvqzTu6BiGolJPtdJD8J+IUlw
	bCAumK9w==;
Received: from 2a02-8389-2341-5b80-7f6c-d254-a41c-2a9c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7f6c:d254:a41c:2a9c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPbif-0000000ExS2-3wQv;
	Fri, 05 Jul 2024 05:42:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: do not extent writes to the entire folio
Date: Fri,  5 Jul 2024 07:42:51 +0200
Message-ID: <20240705054251.2043864-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

nfs_update_folio has code to extend a write to the entire page under
certain conditions.  With the support for large folios this now
suddenly extents to the variable sized and potentially much larger folio.
Add code to limit the extension to the page boundaries of the start and
end of the write, which matches the historic expecation and the code
comments.

Fixes: b73fe2dd6cd5 ("nfs: add support for large folios")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/write.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f3b556ff35f9d2..4e81325f95d740 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1294,8 +1294,12 @@ int nfs_update_folio(struct file *file, struct folio *folio,
 		goto out;
 
 	if (nfs_can_extend_write(file, folio, pagelen)) {
-		count = max(count + offset, pagelen);
-		offset = 0;
+		unsigned int end = count + offset;
+
+		offset = round_down(offset, PAGE_SIZE);
+		if (end < pagelen)
+			end = min(round_up(end, PAGE_SIZE), pagelen);
+		count = end - offset;
 	}
 
 	status = nfs_writepage_setup(ctx, folio, offset, count);
-- 
2.43.0


