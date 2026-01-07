Return-Path: <linux-nfs+bounces-17534-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF89CFC59A
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D680B307F036
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9B913AA2F;
	Wed,  7 Jan 2026 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lMocuGYl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C11A27FB2E
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770890; cv=none; b=f6MUyi6ObABQKmsjl7B2Oo+K+IJ4DKNTcA9rNkDJjlysQLP4hfPui4duZtGspFhVWOM3yjJfzwYjrcmwEeE/Q62jxlxOeL5C6edp67FO+jlQ+G/jn8gu2fbuPDWTG06flYDNDMA9/T1fsW4b1eGW0skaQOuWdbhCtW4VQeadWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770890; c=relaxed/simple;
	bh=vOd+YmNgk7qE9DSECLGzBDipzXVIv4z1UVoNB8WHT5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTDU9834KkFHP60uUzQVo2F8aFvM7lZ86GyCuCNBxow1gwQ36EtetHUPC2tqg1MAmBDWu++xsW0+jJsfmLW3AG+r5h47WjdMcyrwX3Xc5fKTDKzP8qxjzNaq05g0qdKTfdSGWCucgj6bJnsxKxOkpmXsJvpNWbxZG3lwnTXuJq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lMocuGYl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rrLsfy9zulB+E6+b5oXHuqsd7qXXxkMPJK9bOyHCZPE=; b=lMocuGYl4hodUks6pNJlVQMoAN
	4SGYxsleg040LzrkMXvDi8vTYtwtZHW6D6cXdePwki4cjNPPTp0VrRq+t80/IUWCH060UhHlgATB6
	o37extcrbhIf0LDsxRvZlerC4cqShj8HhGg2atxMn4s4nIJfRnQ4XoDCCc9R48bqF6W4+9Ak4rv8/
	9t5pHoiR6n56eVL1kWYWNRhHL8Bf2tnytLjy2NzdnNRWpsGyLkG0nxWWsLJcLM+7HQq7n9U+JAnFM
	QkvCbGUGgbWg+07u6hBhgxN0HVowKW4uSG/KHiWk2DVgEgfzJmONv6Qnhzv1nr7qnhb36oLRkdgp3
	pifjN+gA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNxg-0000000EHmR-1ryu;
	Wed, 07 Jan 2026 07:28:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 12/24] NFS: rewrite nfs_delegations_present in terms of nr_active_delegations
Date: Wed,  7 Jan 2026 08:27:03 +0100
Message-ID: <20260107072720.1744129-13-hch@lst.de>
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

Renewal only cares for active delegations and not revoked ones.  Replace
the list empty check with reading the active delegation counter to
implement this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 96812d599400..5141f6e5def1 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1448,7 +1448,7 @@ int nfs_delegations_present(struct nfs_client *clp)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link)
-		if (!list_empty(&server->delegations)) {
+		if (atomic_long_read(&server->nr_active_delegations) > 0) {
 			ret = 1;
 			break;
 		}
-- 
2.47.3


