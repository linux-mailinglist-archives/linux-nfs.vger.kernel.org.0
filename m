Return-Path: <linux-nfs+bounces-17300-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA0ECDD751
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Dec 2025 08:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B8CE300163A
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Dec 2025 07:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034892E6CDF;
	Thu, 25 Dec 2025 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Bo1TrAtZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF00523AB98;
	Thu, 25 Dec 2025 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766648480; cv=none; b=WI/GYmXkyGB7He/6RxGYL0vEX26/mWn5PR7DT+S2fszarF3o5+myy7IuL63HecO0+MnEQESkUDwBPKqPEtBfdOhQMULTg0qjLi/PI0oN0+Uj1PXoFEA+AdjaL8IKs+yHyhRjiVvQJIxNWBLUZlDBfmuaQc6Kl7m8qu3nDoneXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766648480; c=relaxed/simple;
	bh=XGPrbHaUaTSW4+70HOZs3oCsdijBz5W8l6Ll0/EXFtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jafd7DIQBwwFA0cYZiNRWSsMGVMIK9LHZfQpwQWWAy6Y3QbgtoWir6NAiInXtkXbA+DmmToaN/H8snVIdE8sQHpDEoktJUuHBh1thnywAo9lRjmLFr600KgaYpqDHLOwKpMrVHr2OoIXMkiRaWj5sBkWBgV1opR+1ZM8GhTofhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Bo1TrAtZ; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e86e0fe9;
	Thu, 25 Dec 2025 15:41:06 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: trondmy@kernel.org
Cc: anna@kernel.org,
	jcurley@purestorage.com,
	jlayton@kernel.org,
	tigran.mkrtchyan@desy.d,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_deviceid_node()
Date: Thu, 25 Dec 2025 07:41:03 +0000
Message-Id: <20251225074103.862493-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b54744ad203a1kunmf950885f343a0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGhlCVh0fTh1CGUxNSx5MHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=Bo1TrAtZyzxmvAESRCo2W6d9EFtSjFlR9VAVezyFCnqXWTWd7WYYu0oh4Ru7PL91v5/7hrgWlAJl81+FPT0ZRWSM/4nTzNuadlHewdkg5csGyxX6/B/nSdFMF8KP7ujXXZjRuJ/ukiKXMPwen5kYNE0Z1ddK5Ok/XoRg9Rv7hz8=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=6ek0Hr2EcbwtmmP43gb3ZGqduvyTEmRIE7YXgVoTyak=;
	h=date:mime-version:subject:message-id:from;

In nfs4_ff_alloc_deviceid_node(), if the allocation for ds_versions fails,
the function jumps to the out_scratch label without freeing the already
allocated dsaddrs list, leading to a memory leak.

Fix this by jumping to the out_err_drain_dsaddrs label, which properly
frees the dsaddrs list before cleaning up other resources.

Fixes: d67ae825a59d6 ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index c55ea8fa3bfa..c2d8a13a9dbd 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -103,7 +103,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 			      sizeof(struct nfs4_ff_ds_version),
 			      gfp_flags);
 	if (!ds_versions)
-		goto out_scratch;
+		goto out_err_drain_dsaddrs;
 
 	for (i = 0; i < version_count; i++) {
 		/* 20 = version(4) + minor_version(4) + rsize(4) + wsize(4) +
-- 
2.34.1


