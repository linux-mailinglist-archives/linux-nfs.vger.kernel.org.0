Return-Path: <linux-nfs+bounces-17160-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D63CCA61C
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 938E930452A7
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9C3164D6;
	Thu, 18 Dec 2025 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D/3uHsH8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E22475CF
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037451; cv=none; b=SQWQEzg1HCy1adVMvgnICbtRF6IxhqeNOM41O7OERzXtYDd649WUxPxhDN6qjG9Gsxc6uKf7/Pf+uC0oByXJsbkjuaQoBPwpZT75XpzEb9GPObuvZZhgPBre4MxLvT3XCuG2x9OVb0kgSP9l40RMvkgjpZ+qiIZ6KTOG+3uPyac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037451; c=relaxed/simple;
	bh=vOd+YmNgk7qE9DSECLGzBDipzXVIv4z1UVoNB8WHT5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gt7IkPf3SCc4SiFMPcV/kCDmr7wMXGUGrcb6jsq38UTrNXOwMaa8trWR6rUsqXX2JzdSIuHNUbr/q+kGYoAfwWGbjLKMmhYiCey9p9x+kHsDloFvFM4oGHc3s3uN8inNCGQ+4IJJWF2hst9Hb9wiRA0/HpLu2UC6Zbf6Piu3DI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D/3uHsH8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rrLsfy9zulB+E6+b5oXHuqsd7qXXxkMPJK9bOyHCZPE=; b=D/3uHsH8rVToh1nULrsCYZmPSu
	EBW0jpxns/2+bHy18aOTxFZUSOcNG7clbgLFhUc9moD35ase4OFhCsP5RgGgaCzPUAnMNSzAiFCNq
	6P+sX6mdsMvPMDAZfSgTEOUgSVtfqB9WZ8nECycmMemQ52Hq6qAqvcgfoGQSeX0csMMlxF4tSFVMH
	GAwZsD+WUnEWgsijlRjkob3c9Nidk5Kekxmi7R2caewTIWc9CyJ6LvC+OX/yRsohnVNyASvl64zSq
	36x2vCrozI4GwjWPpaJUSdVgnwWy9DwclMbx50RdpMhggM1ZMQ0rvE5Y83t/eJ2/fgwOOrFHa69cF
	1HY2H75Q==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW70w-00000007rel-1moH;
	Thu, 18 Dec 2025 05:57:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 12/24] NFS: rewrite nfs_delegations_present in terms of nr_active_delegations
Date: Thu, 18 Dec 2025 06:56:16 +0100
Message-ID: <20251218055633.1532159-13-hch@lst.de>
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


