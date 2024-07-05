Return-Path: <linux-nfs+bounces-4634-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D77F9289BD
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07DCAB261EE
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B9014B07D;
	Fri,  5 Jul 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PrtKmhK+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A313CFAA
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186386; cv=none; b=sTCFq5bCXg2L0OEYvDAB2IfHEWR9931bYNdf8SlFQY2djRSN3V9ZbKd3Swhan/ELpDuZnkwrjlEmVE0dCD01Ac9mBWbNZcf2l2cnxAmPeZ514TsYCAGZ2/0/RaPNsKo4WDM/1+xN54YHq+p8eNYLBZ5DVZROu+pBhFgWan6gW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186386; c=relaxed/simple;
	bh=z0nF4uQSaPpI35DCPfQjaayIXizpd+mWy3RmrmPu65I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBtyM5jopb2M5v3Bnzb3vGE39oEs74EfB4swraTZ21YiLR3y3jhZZf6mZ5u49zXuij8/82PxDgCXb6ZzA6PZRmaPULIdpk59bd3v4d3z2rBx3Rm3In/QZ4ZkKW7oZBpjvr55xE2eBOw0i9CU3+M9I7d9bGZY6P3y48N6cvZiRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PrtKmhK+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SxGdvZXuspcY07Llfu22KUlK23bFfpxWYNo69xzRP7c=; b=PrtKmhK+mBT9ylPTawumbCdIVx
	5+vSR/aSomjoVyH1uq9EbJIYTlViRlHUHQ4/7ECcJl/u/Isy+ovXlrjmoxkF85qXu1XiUnmQa22ny
	fdRg2rdv430b550qrMNn8s3k/xK1x680pqbtoN+bjntcQbxc7W4ahePKNxH/XTVSJsuHQD9pxLRdw
	yfM2tEUl5eNA0BfuV6vBNAFkR/tPt4Fo0BM8DPwHXkBaDKm6BRbbLVCSj0jqWgDZa4Vf3fCs846Sj
	tZOsYF3DutPaHhvU8+vUqM+uuDaPOX3bEiKFDAKznuw9638qcHXAHwPjCM/0erUrIeYctarKNcbpP
	jdFMRRsA==;
Received: from 2a02-8389-2341-5b80-e919-81a4-5d6c-0d5c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e919:81a4:5d6c:d5c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPj3f-0000000G4F2-28ZO;
	Fri, 05 Jul 2024 13:33:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: remove the unused max_deviceinfo_size field from struct pnfs_layoutdriver_type
Date: Fri,  5 Jul 2024 15:32:59 +0200
Message-ID: <20240705133259.2181984-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

max_deviceinfo_size is not set anywhere, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/pnfs.h     | 1 -
 fs/nfs/pnfs_dev.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 1fc40afcbf1f50..30d2613e912b88 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -133,7 +133,6 @@ struct pnfs_layoutdriver_type {
 	const char *name;
 	struct module *owner;
 	unsigned flags;
-	unsigned max_deviceinfo_size;
 	unsigned max_layoutget_response;
 
 	int (*set_layoutdriver) (struct nfs_server *, const struct nfs_fh *);
diff --git a/fs/nfs/pnfs_dev.c b/fs/nfs/pnfs_dev.c
index 178001c90156fd..bf0f2d67e96c15 100644
--- a/fs/nfs/pnfs_dev.c
+++ b/fs/nfs/pnfs_dev.c
@@ -110,9 +110,6 @@ nfs4_get_device_info(struct nfs_server *server,
 	 * GETDEVICEINFO's maxcount
 	 */
 	max_resp_sz = server->nfs_client->cl_session->fc_attrs.max_resp_sz;
-	if (server->pnfs_curr_ld->max_deviceinfo_size &&
-	    server->pnfs_curr_ld->max_deviceinfo_size < max_resp_sz)
-		max_resp_sz = server->pnfs_curr_ld->max_deviceinfo_size;
 	max_pages = nfs_page_array_len(0, max_resp_sz);
 	dprintk("%s: server %p max_resp_sz %u max_pages %d\n",
 		__func__, server, max_resp_sz, max_pages);
-- 
2.43.0


