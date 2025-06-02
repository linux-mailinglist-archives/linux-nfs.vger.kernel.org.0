Return-Path: <linux-nfs+bounces-12057-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F78ACB3F4
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 16:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DC63B3579
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4022288CB;
	Mon,  2 Jun 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bfM1xacb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477ED228CB8
	for <linux-nfs@vger.kernel.org>; Mon,  2 Jun 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874328; cv=none; b=rRP1FBzYcSpMI2MCaMa6LG0hwvb1G8TYWgVQAj6qe7P7aOGAIhqU0yESYMhvm+n8HEWDHukiyy8yWScnRTL7PtMHXrI87ssAO3nq/PSHyZwtibzbRjKsCaan8rwmNszNRGN3gE2BHCDw8rPdHgyP1O7geWS4O0mFV5702XBGH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874328; c=relaxed/simple;
	bh=cCTvY0QoK//UZe+CMho4nFEtnjGHIYiU9vlVfQYklq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAEAEseUR62Mm2+UI7S+cBlgiYHZb9yDbMlZJep6RJJy3Xy6cezCM1PaQlNit599d41sqM3QzzC0B1COYfP4F4Q/TMbBY0KMJo/TLyBskeLnqAO/J/ebyI51EYL+xEXnNkp/mp0AEjCv4M+r7TsbAYMkJSODeSG4/vUpcpP+ixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bfM1xacb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=p8OHEM7NOFI0XKZ8wSvamcl5GE7Y1UN7UJEaAe5rVTs=; b=bfM1xacb5u2doR46Z7Qvekzbjh
	yy7uQ1Y/jpgTbKULwk8AjLyjTLxhMjSumXre2gulur6LSqxJLDZ+VJTjNbf0M0kVb5IoPts6dRWbk
	6radv5DQvMBK4c4ZlNURHcA1lg1YwNZscKaqK4axrxewajywc291DgkP+RZvpwXnAFvWYyTVgJA+z
	8R/vng1d18BLHFxUEY1EeSDGaPtjnt79T8bryvWgMva0tYXRDGRNDqS9ue73ZskVuN48zIjuHT83C
	KCvQ0d/Gvq+IHf+apkSi8u40tNd3akr/WEu0qhbOwyZYzhVN2wcKOdFeH3dpQykPTgh6LL2CJkaUT
	Gt/bSdXA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM66Q-00000007cuC-1mcH;
	Mon, 02 Jun 2025 14:25:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] nfs: don't return AOP_WRITEPAGE_ACTIVATE from nfs_do_writepage
Date: Mon,  2 Jun 2025 16:24:50 +0200
Message-ID: <20250602142517.408443-3-hch@lst.de>
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


