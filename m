Return-Path: <linux-nfs+bounces-17152-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B16ADCCA610
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DF35301C886
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20527243376;
	Thu, 18 Dec 2025 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4Ai/S6c1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED3212554
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037417; cv=none; b=rTJEUHYZ9sj+e3LBO/zoW/rUrdy92e8FgSFjt6EYwExza6Wb2eEvwHIwOEAItpE9dAyCkCP8Sp8Zmd979O0hpODs9QxAp4Va0B61Yc8quQRi2BU1ddyN6pVpIsKSfwKemwNjfwx8RxNnA03g2/oH3OAEKslOrs1IlWvVcOUhZ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037417; c=relaxed/simple;
	bh=PDBotapL6VFOCnyrOPEAWmwtZ37iE1ywwKECl9LVZ7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSl8B0rqdAV0uBTse3e6LCPtMZuwmDtyuoYHCGvOwsuk86OI91vm2QwvUAvqusVyVjiPqniFPLsbMONRFdrcFqY7U2gD1F9uuegiR63uKNgSpi+9QTnkqqarIVV36Cp51vxIbfIBcRz+H2CI3SqwAKjJssC8NU3mn0FWwqaciUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4Ai/S6c1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=43M3Mi8nX2MPTU+UtG/6MKitL/T+P8cuhAv5g8dQFbw=; b=4Ai/S6c1yHyCYDWzDbf5klxOAD
	wIz+YRw+4H2X1qnAup/x6sdVTsLzidFUEL/ygit4NhguxG9awAIUP6aP4YowqRM0U7BSlwVpFwdzg
	7z8oJc47l5GIG/9oVOV15EH4I4TAbhuohVEE2qFAioRN1ElF0eFydbX6wrmXSKQJxkSHIIXG1bjwj
	J2BpbWqwOeR1bam0Vdrke9dLmwsEWufG/O/QPBzxtXVMDf3W60RE12cT/SjTg8+j4Kb0WXrp9vlfJ
	SEcbmAbwVh5vZR73kv79UFvVUy6y1XOpvA6j14CaHcKhwDb+qXPOeMhncGHboC/YPKzU8fmloT4pk
	0EnAUdKA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW70Q-00000007rTp-2Evt;
	Thu, 18 Dec 2025 05:56:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 04/24] NFS: remove the NULL inode check in nfs4_inode_return_delegation_on_close
Date: Thu, 18 Dec 2025 06:56:08 +0100
Message-ID: <20251218055633.1532159-5-hch@lst.de>
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


