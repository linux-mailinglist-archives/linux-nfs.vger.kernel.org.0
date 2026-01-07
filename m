Return-Path: <linux-nfs+bounces-17543-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA4DCFC5F1
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60C2530D2670
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E441287517;
	Wed,  7 Jan 2026 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TJe9l/3C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52CA286405
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770925; cv=none; b=iyMGbcsIwTu/wasSxVk1nT1lUKaE+71u+CtodUpZUalBgNHKYz6hxT8zPPfSwHflBBLBz0pEhLZQSH/GSRWk3mvxUNbdqaYJPrPamm67t7jpj8CePwsjIKWzbPf67Dc08ihQ62DyspomVYGPz3Lcd2oepgrnBydp+g1baEPrXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770925; c=relaxed/simple;
	bh=8e2wPJ69MRFuxTv+VoP9aJg3ZUNFy97Ue107zvFagHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzyEDfkZeTeiAO2kRvUHJoAP2f+qjIsxxaZSfJISYWVVvC2OWVNDkFz/0gg+mmd6L17xMwMDoAm1prMid5l/ikRKN8E9Nt42gJ8o/d/kz176T7MYATdP9YEahadt51PBce0K7LSKvsgV2OcD4Rbo7Lou/DJZ9I+udkpkqnKeDp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TJe9l/3C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N6OsPW9fsqOZTRskFrNqn3icvTFqh2vMZbmfmQML7mI=; b=TJe9l/3C8TqsFjoVyYSb2aA3uo
	kVKRwBPlsESNhby59FamgEPUbs5RnGPbQCaEoWmmuBNnHc8A3FREbdwWuuKA0V8vwpqzvd/RhILyP
	F7XgHlZP9bsihONOfQdnoo7WxLsKXFjT+PN96wWFQ7pb+Sf11xbpc/tgn9VNJDWSpnNbuS5JclCrb
	V3DNdEE6hHNWV0HhFZ4xqQPUdoN9tCLjxhKY72aHk/UmM9CaXgQSGoPbG6K83aWHYuNLG956NXh9V
	whbzy7JjLIMcIXt/PvF9ghrxQQuvk9yWraa6ldME3Nhc2orfk2E5JAFGHMus/UlVYH5IepaN19kZC
	4oMPx9jg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNyF-0000000EHt1-0uUI;
	Wed, 07 Jan 2026 07:28:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 21/24] NFS: reformat nfs_mark_delegation_revoked
Date: Wed,  7 Jan 2026 08:27:12 +0100
Message-ID: <20260107072720.1744129-22-hch@lst.de>
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


