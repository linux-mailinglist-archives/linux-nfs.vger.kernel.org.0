Return-Path: <linux-nfs+bounces-17149-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3877BCCA5F5
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38DD4301BCC1
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775DC31329B;
	Thu, 18 Dec 2025 05:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xxTubuha"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8533312834
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037403; cv=none; b=MPQZ5fFlxilca89PL7JOSymgsE0MqCIrLdoyuPwkS7fMjww474k7XgmJ0SacAlXFahUwkWmjM/8Ys/+zMHT5inusIu9eqMByWlkeTqJEKRZYvdRiRLjID4UvExST49zb26YeG1jOJT6uTuIWcuVwfmBoTLDsprhx2TxNgB99RGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037403; c=relaxed/simple;
	bh=MT2iBYwLKjIg6hDX9tpEPMMHIU8Ykk2qnvwu0iMVLgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGY1KMldcVWiBFMU+m3P+jQhv6oN9KImw6gzKhjE1VCm/tyipqjZhUF4FiszyFIDL2uPx/gUeyykmF0JTKy7Q6Z0FnpqA0bNsFKcNXGUaSO5PnGjenhbxA/wAXi2mSCoVdKfbCPDXlNvAxj7V8Qj+T2NDQJhDvab3yDOko0WZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xxTubuha; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5isRKaWe289S4zVSb4xK2swSwkQ8/XnRp1x/4IqeVYA=; b=xxTubuha1+Ufev3R5KYU1lPnFe
	lE2x9ALHGemPawCXQNZX+daiYmepDb+7NIYqXBCIxmkhGKYbhtLMWgIVVtGBR022zJpmP2azkI8M/
	ylVmsb5/v6dsG4mbUF2hUiqmIwOFUMYHSn/RwIQ/mOBsRx1+L5yTgichqOeMG3RTjJJw5RW5wX5xq
	dnXxSGEdSwfc1qbqjSjllbCbKIPAy5FCdS4bLGxJ6bV6YPB6AWe6FEkbOu+CePIk+N762B8VIxfHu
	u7ZHGLX61kCXkirT2MMEkeBBBDg6jNeQ/rPYrKk0OxYkEcNDb/NXBIsYfufSFXnMSKsBkw+xpE/6A
	mGKGsRvg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW70C-00000007rPH-3dUc;
	Thu, 18 Dec 2025 05:56:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 01/24] NFS: remove __nfs_client_for_each_server
Date: Thu, 18 Dec 2025 06:56:05 +0100
Message-ID: <20251218055633.1532159-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218055633.1532159-1-hch@lst.de>
References: <20251218055633.1532159-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

__nfs_client_for_each_server is only called by
nfs_client_for_each_server, so merge the two.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/super.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 57d372db03b9..e74164d9c081 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -212,15 +212,14 @@ void nfs_sb_deactive(struct super_block *sb)
 }
 EXPORT_SYMBOL_GPL(nfs_sb_deactive);
 
-static int __nfs_list_for_each_server(struct list_head *head,
-		int (*fn)(struct nfs_server *, void *),
-		void *data)
+int nfs_client_for_each_server(struct nfs_client *clp,
+		int (*fn)(struct nfs_server *server, void *data), void *data)
 {
 	struct nfs_server *server, *last = NULL;
 	int ret = 0;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(server, head, client_link) {
+	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		if (!(server->super && nfs_sb_active(server->super)))
 			continue;
 		rcu_read_unlock();
@@ -239,13 +238,6 @@ static int __nfs_list_for_each_server(struct list_head *head,
 		nfs_sb_deactive(last->super);
 	return ret;
 }
-
-int nfs_client_for_each_server(struct nfs_client *clp,
-		int (*fn)(struct nfs_server *, void *),
-		void *data)
-{
-	return __nfs_list_for_each_server(&clp->cl_superblocks, fn, data);
-}
 EXPORT_SYMBOL_GPL(nfs_client_for_each_server);
 
 /*
-- 
2.47.3


