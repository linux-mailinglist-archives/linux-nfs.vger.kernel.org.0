Return-Path: <linux-nfs+bounces-17169-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 718B8CCA652
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 07:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 838DE3079285
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D0E319857;
	Thu, 18 Dec 2025 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BvRDW0AZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE453112D0
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037491; cv=none; b=L/9TQyR97iRe17gL+nJOgDIsr3BrieaR7cLnAJ0+eAJr2utfDWB2N6MHa2ZbUTcs6n8+tCHkiDME9BHIzMmvgzNHqWZJCbmfYx3Do55xupN+2uUC3MVAKxuu9EhFm8NqUSwuBCjTUnRWKRDzrWv4KyxYoZYGiLQkdv3bAkHhrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037491; c=relaxed/simple;
	bh=8e2wPJ69MRFuxTv+VoP9aJg3ZUNFy97Ue107zvFagHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klbICX2Is0eGVzIqDO21FfKjQbDLKwEnnHpOOsxn6ML0a6h5ci+iMkPQy7A0Av/Y96PY41IHSP4zziuTBoGnbW3I8ZTICUBMmZhIiXaEVgfbZHSq0MHVu3WfVD4Gy3sigo9Teayajra5Dk8Tb/jI5e6v2vdGKIRZXDavgFUd1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BvRDW0AZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N6OsPW9fsqOZTRskFrNqn3icvTFqh2vMZbmfmQML7mI=; b=BvRDW0AZCZLIdeXNKSSSfuUYy7
	mW8JZMdRtruVqXNhNF1myT+aG8+2QvP1Ahz1tZ2Ay+WVe2N7vSp2JzZ5gR8NiSSHE9NmqV/U/bw0q
	sbvyJuL2OAKV60+WqIhIpc5KvXMaF7Xcz+vf/fr7Uxpde5qJH0js4pXeBNiCOFviDBbAFlmVSSe/h
	0i8n3e1DHMQTkFccDOwEQfHEeefId5hjHZqE5WPP2ll9LqJfz58tA9/INVr95Mz78+2U0znxDhxKz
	HF9hW86oVu8yT2I2pVlzXb9MeAhMcg2rDRSZlD5DO4kvT6ZL5A0qpFhb71aslKAX6IKLTkcAtCLgf
	4l469bOA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW71d-00000007roL-2fpz;
	Thu, 18 Dec 2025 05:58:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 21/24] NFS: reformat nfs_mark_delegation_revoked
Date: Thu, 18 Dec 2025 06:56:25 +0100
Message-ID: <20251218055633.1532159-22-hch@lst.de>
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

Remove a level of indentation for the main code path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 2ac897f67b01..f46799448a0a 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -52,12 +52,13 @@ static void __nfs_free_delegation(struct nfs_delegation *delegation)
 static void nfs_mark_delegation_revoked(struct nfs_server *server,
 		struct nfs_delegation *delegation)
 {
-	if (!test_and_set_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
-		delegation->stateid.type = NFS4_INVALID_STATEID_TYPE;
-		atomic_long_dec(&server->nr_active_delegations);
-		if (!test_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
-			nfs_clear_verifier_delegated(delegation->inode);
-	}
+	if (test_and_set_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
+		return;
+
+	delegation->stateid.type = NFS4_INVALID_STATEID_TYPE;
+	atomic_long_dec(&server->nr_active_delegations);
+	if (!test_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
+		nfs_clear_verifier_delegated(delegation->inode);
 }
 
 void nfs_put_delegation(struct nfs_delegation *delegation)
-- 
2.47.3


