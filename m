Return-Path: <linux-nfs+bounces-13106-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B3B076E7
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 15:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6718F7ABB19
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7CA1A8F6D;
	Wed, 16 Jul 2025 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OnPz+bcn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E961A5B96
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672429; cv=none; b=k2WCAMsw6MOiKdiifuYsEskqLeccIAH4pO70SNZUc+fJY1fDzuiYcA7ixOASJ8xgNeROvegI9LXFj+QF8F1Wy7Co/ab53JVuDD7HHMaZ0RkHBXOuTX39B7b/QnR4F2ev03hRjYzT+uAJLksiFNaUCtyUQefSXmFKZ43IYTbiWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672429; c=relaxed/simple;
	bh=eKUb7zLsii2CSITtn8+jonAtCjncDTPASXNIo3vwVzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDk3dj9Eh2SCisNzLWrku8ljlc0taedlM/fwIF1Q5pCVOFSjDsDMEFoMpz60x6f6qeOcCgsJzxnHXA1sbxh/txvMMqVtsMXK9JmvQ0B9RpN7bewZj0GK9M+BrZP+8cijPhF7sQkvqC/OgMLM86QhcE/CVDEHcgv0Uz4a0I1lTIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OnPz+bcn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hHS2Ne1IAPkd38Lgbrly8el+F2zNtIrp8wPB7D103e0=; b=OnPz+bcnGriHyiN6EpUIUjEJMj
	qOh9m48oWeNPHsWE9QmifW6JU98Vee5iC/MKakvv9badiFDBy0aRqJZEcE9Ccr7q6wYCc403P7g5H
	Q6M6Dh3MCZ96fi7onLhUN4zu2Kn3h9Z4uh64TmMn0+d0h5V/PDDh0AVMP/mHkGZeJUIKcqI6YDPmr
	+0mOnjNaH3WpQHMoWVEt6rbPvE8I4doCTO5onnIgxWmmiMyifEASQbJOMz1fD2sURHYVgNao00gqR
	xfEAyuNuuicWIGi2beJnQEx5KUgtrifM0uLRE1H8Ks3OzUXOegAPPUXPLbWnBL61MxuzjRg0LJgsd
	eNgo5LsA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2A7-00000007n8Z-17Sl;
	Wed, 16 Jul 2025 13:27:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 2/4] NFS: move the delegation_watermark module parameter
Date: Wed, 16 Jul 2025 15:26:32 +0200
Message-ID: <20250716132657.2167548-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716132657.2167548-1-hch@lst.de>
References: <20250716132657.2167548-1-hch@lst.de>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 568d2e6d65fa..5f85966d7709 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -29,6 +29,7 @@
 
 static atomic_long_t nfs_active_delegations;
 static unsigned nfs_delegation_watermark = NFS_DEFAULT_DELEGATION_WATERMARK;
+module_param_named(delegation_watermark, nfs_delegation_watermark, uint, 0644);
 
 static void __nfs_free_delegation(struct nfs_delegation *delegation)
 {
@@ -1573,5 +1574,3 @@ bool nfs4_delegation_flush_on_close(const struct inode *inode)
 	rcu_read_unlock();
 	return ret;
 }
-
-module_param_named(delegation_watermark, nfs_delegation_watermark, uint, 0644);
-- 
2.47.2


