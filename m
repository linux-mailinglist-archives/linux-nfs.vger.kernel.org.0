Return-Path: <linux-nfs+bounces-12058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4843ACB388
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 16:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A5D3B36D1
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 14:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90A228CB8;
	Mon,  2 Jun 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BDd1it/C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BEA229B16
	for <linux-nfs@vger.kernel.org>; Mon,  2 Jun 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874332; cv=none; b=KXRYgpeBeN+Qd3k1yG8T34svuW4J+9rpUv9C++TWdiu05oLKPPxsuccOYk8yHQDwE9T11Sg93c0FDWXn+bEkmIHw5Ec9dMOg4A9akuFhjuxgZPHQ6P7PIMdJJ7pV3J210pW/o8PN+5lMp1O+y3iFXLuwhPYzQfmH9GCMbqt9so4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874332; c=relaxed/simple;
	bh=2wOBszh2qi7SupY0Bb433bVn185bXeaW8j0pl4jmUbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozQeQCwYIYydp60PAPZgdD5jmLTJKOQ3Lnh/XTj825yOhsr8dVXvgF0bzbvRHKCNPPNQ6m4T0/AG4dTGz/gt0x477wASxIU40gDHkBOVjB27RT4o9alWMGL1+L1r5JJjPCbyIZaEkVnppVHl6PSnAujA4JwLE7w0PyTWGGOprOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BDd1it/C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lDUpzKlFrA94WIGsiuNXhU/O7MTA+ppZ4YzZpR6ymBQ=; b=BDd1it/CP9fgz11C+S1scPH7Vt
	3WGH36E/cOThxf2iVtCDTitqo7UgTK6HHFRBMqOv2eEiaSFF846DcGOMF5BC8ydnjdEgs1JbsRgn4
	QfpArho6eP/obqTHEykvXv1Ip7fxa/82wGZ59uzH134s4O8SN5AmuZLFLUWUOY9JekT+rIHG3JIr/
	nmyWbw84K0wHujFJL+3LAFzOI6cJ/OBchcuHtYWi0aKIRKhpvc3uFW5nX1ZoZXf8UOC52K9lcSCqK
	FlE0o/eqBB8f2x4Blk7MuhzS72xifGp4AxjqFvGfgMOS+a2PeIK0OeKVH6uoFuZyZ7wptW1tmiW9L
	ltXWDQ2A==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM66U-00000007cui-0K3H;
	Mon, 02 Jun 2025 14:25:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] nfs: refactor nfs_do_writepage
Date: Mon,  2 Jun 2025 16:24:51 +0200
Message-ID: <20250602142517.408443-4-hch@lst.de>
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


