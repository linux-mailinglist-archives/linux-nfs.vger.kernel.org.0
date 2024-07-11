Return-Path: <linux-nfs+bounces-4787-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FD92E0A3
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 09:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486C91F22376
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 07:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E012FF71;
	Thu, 11 Jul 2024 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ttxjb+uh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294FA770E6
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682231; cv=none; b=X+E5V/APN3oDG9354HAofgACcrQHP1haRcmXnzJbLN6YA1YkjtldWa0Ulg1pbvjGRsrcVKpSQrod3w2kfxAlXcLbvfcg0SFSLM7BmTE28rnf7s736s5AKi3Xz/ljCPDRUnJVJ7osAdXvGWQfyOLxvVd2ANgQA1hVtC8MJgkwMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682231; c=relaxed/simple;
	bh=3blsRq1CiYO3V5Ti2bsFnsuZ0M9CFI7EWxXX68OVCRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9J6rcgtWVQlL0VC4/s6vYAR3n85eNohb44gFSmFPzAmlWoIQooumKfvYDcP/zflEOUiDQqNmdp4KbrZnzDQAyq2qpk5/glscyFZ54V4Ge/p54U1OLgTP23MXmuzI+zip33dju2epvl74qK6TXQP9lpO8i+ExcHt+Gf45rabSwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ttxjb+uh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OeAbGG4uDiFVrxeq5hxYdHeUQgrppVqgh11wh4YpQfI=; b=Ttxjb+uhjHHf7tXJRp6w+gLwr6
	3YkKIeIN/8hDnl/K49GZK3vSgOI+JkaXec/uRYyg30se+CPl6apQ+z4e9k5DLU8v2RgIuEd2qb8SY
	QRpOHL3ci04bROS/9OJO4kSXy+rX3mXeR9C5n3WNT+aHbwiggOPgOfJQ2Vo3hE3O6vlV6rw7E9O8u
	basbRMW4GBfHfIaH7dZkyyI4IFnqg0h8oCYdPJUQ3OzniDQP2lR/PuqL/DNzHx8Ams7qvoQVDxMzz
	KEi9g9DKDEkmqeFc4x3Jvx4XQSM/3ZWFOkvWyOTjHWgq4Lp0knDDuLsyLuQvaztUQQdM7fDRflZzR
	+4g8MJlQ==;
Received: from 2a02-8389-2341-5b80-0976-dc3d-d348-fed7.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:976:dc3d:d348:fed7] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRo3B-0000000CzfF-0e1N;
	Thu, 11 Jul 2024 07:17:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: chuck.lever@oracle.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfs: split nfs_read_folio
Date: Thu, 11 Jul 2024 09:17:03 +0200
Message-ID: <20240711071703.65793-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240711071703.65793-1-hch@lst.de>
References: <20240711071703.65793-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

nfs_read_folio is a bit hard to follow because it mixes highlevel logic
with the actual data read.  Split the latter into a helper and update
the comments to be more accurate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/read.c | 69 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 571a5d654cf547..4b767d5a3524b3 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -325,18 +325,52 @@ int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
 }
 
 /*
- * Read a page over NFS.
- * We read the page synchronously in the following case:
- *  -	The error flag is set for this page. This happens only when a
- *	previous async read operation failed.
+ * Actually read a folio over the wire.
+ */
+static int nfs_do_read_folio(struct file *file, struct folio *folio)
+{
+	struct inode *inode = file_inode(file);
+	struct nfs_pageio_descriptor pgio;
+	struct nfs_open_context *ctx;
+	int ret;
+
+	ctx = get_nfs_open_context(nfs_file_open_context(file));
+
+	xchg(&ctx->error, 0);
+	nfs_pageio_init_read(&pgio, inode, false,
+			     &nfs_async_read_completion_ops);
+
+	ret = nfs_read_add_folio(&pgio, ctx, folio);
+	if (ret)
+		goto out_put;
+
+	nfs_pageio_complete_read(&pgio);
+	nfs_update_delegated_atime(inode);
+	if (pgio.pg_error < 0) {
+		ret = pgio.pg_error;
+		goto out_put;
+	}
+
+	ret = folio_wait_locked_killable(folio);
+	if (!folio_test_uptodate(folio) && !ret)
+		ret = xchg(&ctx->error, 0);
+
+out_put:
+	put_nfs_open_context(ctx);
+	return ret;
+}
+
+/*
+ * Synchronously read a folio.
+ *
+ * This is not heavily used as most users to try an asynchronous
+ * large read through ->readahead first.
  */
 int nfs_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *inode = file_inode(file);
 	loff_t pos = folio_file_pos(folio);
 	size_t len = folio_size(folio);
-	struct nfs_pageio_descriptor pgio;
-	struct nfs_open_context *ctx;
 	int ret;
 
 	trace_nfs_aop_readpage(inode, pos, len);
@@ -361,29 +395,8 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 		goto out_unlock;
 
 	ret = nfs_netfs_read_folio(file, folio);
-	if (!ret)
-		goto out;
-
-	ctx = get_nfs_open_context(nfs_file_open_context(file));
-
-	xchg(&ctx->error, 0);
-	nfs_pageio_init_read(&pgio, inode, false,
-			     &nfs_async_read_completion_ops);
-
-	ret = nfs_read_add_folio(&pgio, ctx, folio);
 	if (ret)
-		goto out_put;
-
-	nfs_pageio_complete_read(&pgio);
-	nfs_update_delegated_atime(inode);
-	ret = pgio.pg_error < 0 ? pgio.pg_error : 0;
-	if (!ret) {
-		ret = folio_wait_locked_killable(folio);
-		if (!folio_test_uptodate(folio) && !ret)
-			ret = xchg(&ctx->error, 0);
-	}
-out_put:
-	put_nfs_open_context(ctx);
+		ret = nfs_do_read_folio(file, folio);
 out:
 	trace_nfs_aop_readpage_done(inode, pos, len, ret);
 	return ret;
-- 
2.43.0


