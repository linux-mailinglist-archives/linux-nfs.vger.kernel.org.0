Return-Path: <linux-nfs+bounces-11546-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C94AAD49D
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 06:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BCD1BA71E6
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 04:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857F51A2C3A;
	Wed,  7 May 2025 04:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="16LjzjYz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B941F956
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 04:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593361; cv=none; b=fY3QhhUGscKgzbhJczZqxc4QzDv64bIwU2Yvcx4vl4bxecWLJQCJFNbyech81jhNNMdOfAnr3hj1QDjr2z0Yzqxg5XhewNH3TROdXu0Tsq6SkE9tD2qZIb6ZbXb60wZnnHX5F15GmKafkMCe20s9fJbLs11v2MfoH1N2HIBC2A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593361; c=relaxed/simple;
	bh=cCTvY0QoK//UZe+CMho4nFEtnjGHIYiU9vlVfQYklq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5Mh44dRS93g79jJlNNXV6dzN+tDXKj3iThCLIUoJ909dOwpboRyZtx6Aj3MV1VKog+RwO2GqquWRa5N6vpb7AkDcJPcURSjSG+zSeTrDyl7OhD99P9+/CIe6HzUESD7gi4DxN/O8sEfjKG3AzOyRaxJrDui0uK3LzEvW8AyRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=16LjzjYz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=p8OHEM7NOFI0XKZ8wSvamcl5GE7Y1UN7UJEaAe5rVTs=; b=16LjzjYz7C2KlTHVnc0oHHzEBw
	6ItT8rSWCXHYIuJauRPoAunRG6YTdYZUjN7bo+DBvYuqEzb1yWaDCWDaDtfTFkE/I4cgsQIOkOCZx
	S2Hk7UcW17MxjaK9+GHbmmTEJ2a2v+jUzOPzMlml9O1w4jF21eihMH2pMMZAc1DwIJo/4EPX6Kb3t
	IR15TfLBssZR5xVQsyOI85TU5GeK6fQCHIq95ztTAg1Eo8TOs2q5lnTovja+NPHI1+WiGTSHhg3sJ
	QvBiVV/GQmTu31lxKOkanFDtuvpvuJijrymbveQzqKzH9YayaG8zD1oFP6VKuZqB+wWtcsZkqH5Hv
	xz4+4zOg==;
Received: from 2a02-8389-2341-5b80-3ba7-83fe-7065-4f0b.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3ba7:83fe:7065:4f0b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCWic-0000000ECXq-1QGk;
	Wed, 07 May 2025 04:49:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] nfs: don't return AOP_WRITEPAGE_ACTIVATE from nfs_do_writepage
Date: Wed,  7 May 2025 06:48:52 +0200
Message-ID: <20250507044908.3891983-3-hch@lst.de>
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
index 148e773c3665..4e1d57b63a85 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -663,8 +663,6 @@ static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
 		 */
 		if (nfs_error_is_fatal_on_server(ret))
 			goto out_launder;
-		if (wbc->sync_mode == WB_SYNC_NONE)
-			ret = AOP_WRITEPAGE_ACTIVATE;
 		folio_redirty_for_writepage(wbc, folio);
 		nfs_redirty_request(req);
 		pgio->pg_error = 0;
@@ -703,8 +701,7 @@ static int nfs_writepages_callback(struct folio *folio,
 	int ret;
 
 	ret = nfs_do_writepage(folio, wbc, data);
-	if (ret != AOP_WRITEPAGE_ACTIVATE)
-		folio_unlock(folio);
+	folio_unlock(folio);
 	return ret;
 }
 
-- 
2.47.2


