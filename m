Return-Path: <linux-nfs+bounces-17301-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B43CDD866
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Dec 2025 09:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92CD6300DCB0
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Dec 2025 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B817B314A7B;
	Thu, 25 Dec 2025 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="BKwhAkJn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC193148AF;
	Thu, 25 Dec 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766652338; cv=none; b=nyuBg4CKBxMzGYFcuurYjHh9jN2D+ao5jakZZppI5dPOBul0U34Hcd4Xj9Er0xWasVGCpiyeWzDe4r48B4vWmC7/PDb/FEFL4yiZ7s9zs8nj2HL/bcKPE/74ZHFf5UuDTAQ1i2Cpn/0mEnmMrrJuXeVoY2vfTgG8H1auB7EEaE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766652338; c=relaxed/simple;
	bh=MSJwn6jPL/HsayrVKKC1fMYkfS3VJfsRt7IkdLX6Zqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KzbLleybCB/e64fMCAfgWfh52oivCPMwLDzFtzAnZiiw5isbRRzO8UzLb1nw4hkTtIClCjHVc7J7CNoTF5AqXV9adtO0x/CBRHmOn9mtKddS6NJOf0hwQIdAvsUfmFvyJfk2bQ6Gg5d3XCA8xHfB2cF5gxlDZcLJcw7ClqlQuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=BKwhAkJn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e8990129;
	Thu, 25 Dec 2025 16:45:29 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: trondmy@kernel.org
Cc: anna@kernel.org,
	sergeybashirov@gmail.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] pnfs/blocklayout: Fix memory leak in bl_parse_scsi()
Date: Thu, 25 Dec 2025 08:45:26 +0000
Message-Id: <20251225084526.903656-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b54af3d5703a1kunmdd8a46ab37d15
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTUJMVh9ISB5JGU1DGR8YSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=BKwhAkJnUTzB5uIZee+eEuA5WsJz6KCM6/ZSjafrcabRBCdvItGwSPhQ7Te928WIEApI2LdD3jqFEJwNhc8p+568r7kqvOZfShQq8xEvFiXoyL8fRCpoRkGQMMCYOJqGd9mAyO0qk01i/D7FMKaDyOReEEQ2n2TOlCbC6EFFp8M=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=AtrnAGjoccJO8ys8/FUGv0aMHO1ODfphpRKyMj1h3EA=;
	h=date:mime-version:subject:message-id:from;

In bl_parse_scsi(), if the block device length is zero, the function
returns immediately without releasing the file reference obtained via
bl_open_path(), leading to a memory leak.

Fix this by jumping to the out_blkdev_put label to ensure the file
reference is properly released.

Fixes: d76c769c8db4c ("pnfs/blocklayout: Don't add zero-length pnfs_block_dev")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/nfs/blocklayout/dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index ab76120705e2..134d7f760a33 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -417,8 +417,10 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	d->map = bl_map_simple;
 	d->pr_key = v->scsi.pr_key;
 
-	if (d->len == 0)
-		return -ENODEV;
+	if (d->len == 0) {
+		error = -ENODEV;
+		goto out_blkdev_put;
+	}
 
 	ops = bdev->bd_disk->fops->pr_ops;
 	if (!ops) {
-- 
2.34.1


