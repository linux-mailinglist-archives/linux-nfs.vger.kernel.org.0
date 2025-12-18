Return-Path: <linux-nfs+bounces-17164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C13CCA63A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3899B3066DDF
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9243112D0;
	Thu, 18 Dec 2025 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HNXxBA+x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C06C27F017
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037467; cv=none; b=TwQYVAV2TV2FHV7H06WMfhPodtvzDZECfJd/pa+9u3GK39M9BZcdqNYyJtME/iefhlGzvpW0ljlt+yfW4FINLI8/P6AWlW1fuyJorpXwezGKOe8HSuc6ME2qxv+YPlet4xVkJMw2GGUpuRWzk94QiLqafe+nsGpQDnVp0I9JJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037467; c=relaxed/simple;
	bh=j5TTbgych4uzqvaeUtg74LhZuWJntanbrap2RhKGE6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDeUBcUzpRDjsTzA/PBQl3gNvjCeC0wCQEQLDfqDv7irD27/mUyuiaSgKHX3nIuB2quKwsFL9dgmlhiA0w0jV6y5phVE+QnsBWvpmxl4FvD6tdI+Sb+V/N00u+awLccU1wuTDC9Lacti9x0D8Z9kMYG++eYYEirkTM7eWbPEUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HNXxBA+x; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tVui0HbTAMsKbNBgDLvlcTn6JzwXyHPRSBDbBnk1exw=; b=HNXxBA+xMeZWt8xDbV7Y79HUE/
	UCKgo9+owMbIcKv0WJ/HO0TLHwFydEtZrOOAatILkgZU9YrwJgWnfa+Q1ykbyGwCfrGcRNnyRfClS
	YiLI4bSRMUTHa8Kc5VMCPIKOWpo1n3FVRoz4yDaANL+iPIeUEVEvN1ygySqoH1boFMlX3KnTmeDap
	jZ8mcxMD/sCM8/bjP4O0Ds0gu/oTjv+PmR25AbPYhITf2KXG0q2/PELWwL65etLhUMhduUBB3QGW6
	BEYZTfhld5EkktEfUqHLkyS4g6t/BF3pGfifIw9cOqmgI5+MD4yGgWGelJE5rZkZyk7pjVILCLNhm
	MSZcL84g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW71F-00000007rjy-1y0a;
	Thu, 18 Dec 2025 05:57:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 16/24] NFS: simplify the detached delegation check in update_open_stateid
Date: Thu, 18 Dec 2025 06:56:20 +0100
Message-ID: <20251218055633.1532159-17-hch@lst.de>
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

When nfs_detach_delegation_locked detaches a delegation from an inode,
it clears both nfsi->delegation and delegation->inode.  Use the later
in update_open_stateid to check for a detached inode, as that avoids
an extra local variable, and removes the need for a RCU derefernence
as we already hold the lock in the delegation.  This prepares for
removing the surrounding RCU critical section.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/nfs4proc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d5948b8060f2..03b1f98eb989 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1907,7 +1907,6 @@ int update_open_stateid(struct nfs4_state *state,
 {
 	struct nfs_server *server = NFS_SERVER(state->inode);
 	struct nfs_client *clp = server->nfs_client;
-	struct nfs_inode *nfsi = NFS_I(state->inode);
 	struct nfs_delegation *deleg_cur;
 	nfs4_stateid freeme = { };
 	int ret = 0;
@@ -1926,7 +1925,7 @@ int update_open_stateid(struct nfs4_state *state,
 		goto no_delegation;
 
 	spin_lock(&deleg_cur->lock);
-	if (rcu_dereference(nfsi->delegation) != deleg_cur ||
+	if (!deleg_cur->inode ||
 	   test_bit(NFS_DELEGATION_RETURNING, &deleg_cur->flags) ||
 	    (deleg_cur->type & fmode) != fmode)
 		goto no_delegation_unlock;
-- 
2.47.3


