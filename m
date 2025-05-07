Return-Path: <linux-nfs+bounces-11547-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B94AAD49E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 06:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEA81BA7192
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 04:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6757115A85E;
	Wed,  7 May 2025 04:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QDHAdO7R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32061F956
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 04:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593364; cv=none; b=q8Dt87zZ37QbCSGbwtMH1Rp1Ks7p+Ha6kMAQXSxAAun4FN2qXPfEo+6CobOOcoOD7F2J2a8XD5LiZ2GGTF8YvlczhL0n/cBlPQknfIndn3ZYM/BKA1SdMaXnm8GtBrkUgpxpQhN20MT6YtvoVBlVUBetsANmNVoMtnNdknavPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593364; c=relaxed/simple;
	bh=2wOBszh2qi7SupY0Bb433bVn185bXeaW8j0pl4jmUbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAnIDlvM3jvkp7HVLiKmEzzu1Eo2CeLcIlw75U1/vd/+1i75lDbUxFzcwbcFMpyB9kI6g21ijPkCvnRL3NM65w7Fok9+5V2/gu5RWRW0nXUqRQmAqqbuxVTIYs8KrBhC1jnSkocvBMWv+lh7Miq85aUehMDcyt1bMM6FQ+BQMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QDHAdO7R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lDUpzKlFrA94WIGsiuNXhU/O7MTA+ppZ4YzZpR6ymBQ=; b=QDHAdO7RNWoRZrDIyV6EHisT6y
	cPn4Pig1ZQBVRC7ccUAZgL6/m14eAIMvpnQdpn8UtI+1SSQjdDTY+ZO9usfewujn0iog5C1aa2jdG
	ehTqbz15M+ZxTjupOovP0+lD6FuL6/Au+K8b2x3/eyRLQjc1k8oIdspKZF2DOL4hbsn2Saxs8zDwF
	fOne7ozk9tBSLcc9MSrgAFbOqveLSCmT4Ss6OwL/cJfUZNhe6Sy6u41uzWNkkXih8A7hJy3BOGIHd
	KjhWE+4J42641pvW9abFOQuy93E1l4kxr5q8sVvr42ndtmUOhMuwqDjBZqKkhiOT1iKLohnKrVs/p
	IR5Dq3Jg==;
Received: from 2a02-8389-2341-5b80-3ba7-83fe-7065-4f0b.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3ba7:83fe:7065:4f0b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCWif-0000000ECY8-3cmr;
	Wed, 07 May 2025 04:49:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] nfs: refactor nfs_do_writepage
Date: Wed,  7 May 2025 06:48:53 +0200
Message-ID: <20250507044908.3891983-4-hch@lst.de>
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


