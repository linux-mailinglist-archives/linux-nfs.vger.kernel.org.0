Return-Path: <linux-nfs+bounces-11508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B96AAC77D
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AC74A0109
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890D6262D1D;
	Tue,  6 May 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cqTXV3lR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A23278745
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540513; cv=none; b=YPsQdpH28dBxRFPJQ/T4YG5J4p8s0HnhL0eb5ErF9A5RraWyr/XCYcaQXzHyUN9ITeGJK5qJ8ciZ8GiLxO0rjwEX0lBj/HJvt8S2GNoxM4dDCqzqXTkaoI+c1jcdu+YIfJoxC3X3YJjDcSD900Z3Knehmf+s6TQ/fPh/3Suheh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540513; c=relaxed/simple;
	bh=2wOBszh2qi7SupY0Bb433bVn185bXeaW8j0pl4jmUbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GY+gYaBwKiPDLkfT/xhbRl1erha9lsOsKGFyEuPKhjYzeOFj/Wk3rzAyptdAfqVFGJo4GtPzE4jHDFNUKbXHHxC8ogT4DMRFY0NwzatqkFOjx6FeVohkjiu+r8tqOJaGkT4LRnf0OEbV51vPidlUuqwsM8mutPgYCLvZFJKulEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cqTXV3lR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lDUpzKlFrA94WIGsiuNXhU/O7MTA+ppZ4YzZpR6ymBQ=; b=cqTXV3lRqoar6h13CzpL8Q0PSF
	y4DtjSp1755U3R7MPRxurXqJNEuVVWkd5Gv2f0UdA/YGT1x9PgZV7pBcETYit6cqLtiXrqBEER8G/
	YO4G0m0+We1GEXTWevijb0JEy9fliAiAi0R4FyngmZnAH5tsmxGLQRbcTAe+Sa3/1z058js2e+mtP
	cfCNkXmb4iTMAzzFKl6qvVK6CIz468QLCzQlNyO+RnJdrU+R4A6j+ZNZ7QvMqfwtOn7IkOcyNbcuv
	ifXHvA2YpZEr7vE8RDFSYYO1KTQfrE/NgqmEwLdB/sq67Ktwxb/11q2ir1JspOJFrNz2zzKRTtvtm
	pqvHZSAA==;
Received: from 2a02-8389-2341-5b80-3871-beb2-232f-7711.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3871:beb2:232f:7711] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIyE-0000000CG6r-2gGs;
	Tue, 06 May 2025 14:08:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] nfs: refactor nfs_do_writepage
Date: Tue,  6 May 2025 16:07:50 +0200
Message-ID: <20250506140815.3761765-5-hch@lst.de>
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

Use early returns wherever possible to simplify the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/write.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 4e1d57b63a85..68c5dc061abe 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -636,16 +636,15 @@ static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
 		struct nfs_pageio_descriptor *pgio)
 {
 	struct nfs_page *req;
-	int ret = 0;
+	int ret;
 
 	nfs_pageio_cond_complete(pgio, folio->index);
 
 	req = nfs_lock_and_join_requests(folio);
 	if (!req)
-		goto out;
-	ret = PTR_ERR(req);
+		return 0;
 	if (IS_ERR(req))
-		goto out;
+		return PTR_ERR(req);
 
 	nfs_folio_set_writeback(folio);
 	WARN_ON_ONCE(test_bit(PG_CLEAN, &req->wb_flags));
@@ -655,7 +654,6 @@ static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
 	if (nfs_error_is_fatal_on_server(ret))
 		goto out_launder;
 
-	ret = 0;
 	if (!nfs_pageio_add_request(pgio, req)) {
 		ret = pgio->pg_error;
 		/*
@@ -666,11 +664,12 @@ static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
 		folio_redirty_for_writepage(wbc, folio);
 		nfs_redirty_request(req);
 		pgio->pg_error = 0;
-	} else
-		nfs_add_stats(folio->mapping->host,
-			      NFSIOS_WRITEPAGES, 1);
-out:
-	return ret;
+		return ret;
+	}
+
+	nfs_add_stats(folio->mapping->host, NFSIOS_WRITEPAGES, 1);
+	return 0;
+
 out_launder:
 	nfs_write_error(req, ret);
 	return 0;
-- 
2.47.2


