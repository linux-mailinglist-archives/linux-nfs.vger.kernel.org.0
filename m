Return-Path: <linux-nfs+bounces-13036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38526B03D27
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 13:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2E93B5F00
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB06246BB8;
	Mon, 14 Jul 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lu2C6WD8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FC9246797
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491826; cv=none; b=Gy+AtORg/DJHCROUn+XK5wkC9Iv1dgL3BalzHlT9OoDW2xdHsog2hFzM1AkTxkR6xnJonguSE3eIBRj6Zb/CHSakMYtJKTEznEqGZBVKDXCOxGAhU2Zbdj4y5nhf0cbvnkD9yjWgWE8BAJJyfZ70KV1sIOuS/I0L0W650hM1Jx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491826; c=relaxed/simple;
	bh=STrc5xKF6vsafjTHzxovfxDqOw+qkay2SX/tFSJvnA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7tyWWPBl+ANijK+bkce245TShWPc8/ZKAetgwSZWoX9wXiWDMSx9E5TDxfVFva6z3ARMsxl675iHPw7BcdduCT71BN3kYzb9lGukmFiuVW0WSQ+2pFN0aFyIePOS9uH0wVaQmYrAbRkjkXlr+5bWiqILQgE+HKoe+qiGniwCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lu2C6WD8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=duTadzERYzlMObC0rq0gQg3FiJeyasi64uDaTuIJxvA=; b=lu2C6WD8nL9VwpEj/hJjuYxbYQ
	JjmdBMMXK9afAUGa8pv5RbJ5NV77xS/omPPslLP5nAhBMa4Q2vvrn3LBbA11HpgYN9pYudWBz2Wwb
	yhj6xnT9ousL9LyxgXo7MBRAg6XcGQK913/dtOwl9mk/2eRP1PZyc8tF6Tf7CPRvL08/bse+j8RMT
	oyDYDcfdHYCh53Y8pyaYaS5GfBx/xuzvAlW7VpY8lnOCLZHT8JvnOQ4UFdOI951kbL7tp+R8C+7Zo
	y/DLozImtd9n/u5i3Ch8BtzTR8nF9VVwS2knGymDCAwSCPi7luZgajwBBKly+/vQC1Rn9N1sTgJy3
	uyOT4uDg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubHB9-000000020sL-2xJZ;
	Mon, 14 Jul 2025 11:17:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] NFS: move the delegation_watermark module parameter
Date: Mon, 14 Jul 2025 13:16:29 +0200
Message-ID: <20250714111651.1565055-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714111651.1565055-1-hch@lst.de>
References: <20250714111651.1565055-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Keep the module_param_named next to the variable declaration instead of
somewhere unrelated, following the best practice in the rest of the
kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 56bb2a7e1793..d036796dbe69 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -29,6 +29,7 @@
 
 static atomic_long_t nfs_active_delegations;
 static unsigned nfs_delegation_watermark = NFS_DEFAULT_DELEGATION_WATERMARK;
+module_param_named(delegation_watermark, nfs_delegation_watermark, uint, 0644);
 
 static void __nfs_free_delegation(struct nfs_delegation *delegation)
 {
@@ -1575,5 +1576,3 @@ bool nfs4_delegation_flush_on_close(const struct inode *inode)
 	rcu_read_unlock();
 	return ret;
 }
-
-module_param_named(delegation_watermark, nfs_delegation_watermark, uint, 0644);
-- 
2.47.2


