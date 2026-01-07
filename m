Return-Path: <linux-nfs+bounces-17526-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECF8CFC57F
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00628303F36A
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FFA2765F8;
	Wed,  7 Jan 2026 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eMoNhIT7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5A27464F
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770859; cv=none; b=o3ofSR9POlNglIPvye6rjBMcMZpnhBWqu4WQwGuAsgQJN84Zu3bK6xX0LSYVKCW6D4cJUFiBf+dHe0Fb79a1baBa8lVA2Wmk/A5VkmATGrpQAEKc0LmKutPFgSmTjqLUVamtdwRC+PWnd3tmrjFknqNWn+otaXtPlo1AzowS6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770859; c=relaxed/simple;
	bh=PDBotapL6VFOCnyrOPEAWmwtZ37iE1ywwKECl9LVZ7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dcahlkj7r2IVqMlMl5OzbuJQRsOoCZsBGKftYtmHy+WUDt2EDLpi0DVCm4tGFYKBsd2D3pq6A1JT6YdI/foQoNLLPref2YdctHLwPrNJwcdSNBeGaJ+Bw1qxycu304FR0QMef/6h9zrLOMT7L+w9sG6xDCRU863pfirNQZlPkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eMoNhIT7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=43M3Mi8nX2MPTU+UtG/6MKitL/T+P8cuhAv5g8dQFbw=; b=eMoNhIT7ftJ/RwgNG7qRGuNmM/
	yzGT7xOPDTqstJsPIPr6FiCUM7MOQL/Zphn9wIycDGWOJLyz0lBg3ZCKAQxnOHnDidB/yXoV/Klmu
	m7i0dCNl7dIEEipr4AFuIyxejbnH4XJAulmwg/wMVPI+PEto7HEeO3EaS/05AyFDHGD9DldcpXlbL
	hvURr2sYpsMIA/GytR3vzx2wPdGFBgA6kAVhsHEyRimKT8PIPiPffdRog8RK4Yzu1h3ljV8dd/0Qz
	GiGElhVAC+GHvjnRrdD69bh9JDNthZYwi6uIgtvNvrOZK2Ic5QxgkGe35l9AHLmpFH1JIB2apBZZY
	HxBJg1hg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNxA-0000000EHkO-3pye;
	Wed, 07 Jan 2026 07:27:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 04/24] NFS: remove the NULL inode check in nfs4_inode_return_delegation_on_close
Date: Wed,  7 Jan 2026 08:26:55 +0100
Message-ID: <20260107072720.1744129-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107072720.1744129-1-hch@lst.de>
References: <20260107072720.1744129-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The only caller dereferences a field in the inode just before calling
nfs4_inode_return_delegation_on_close.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 2ef8fe01ef4a..b44e39a50499 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -855,8 +855,6 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
 	struct nfs_delegation *delegation;
 	struct nfs_delegation *ret = NULL;
 
-	if (!inode)
-		return;
 	rcu_read_lock();
 	delegation = nfs4_get_valid_delegation(inode);
 	if (!delegation)
-- 
2.47.3


