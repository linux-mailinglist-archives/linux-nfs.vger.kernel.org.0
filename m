Return-Path: <linux-nfs+bounces-17525-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1746FCFC567
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21BDF3004EC3
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B955627991E;
	Wed,  7 Jan 2026 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hBNOMbO6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12AE27FB2E
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770856; cv=none; b=SjXN+3FvovDNYSIGSLDG9DuhidYJsx3fTUL2T+ONpuB14ljGEOfKgGhjjnqtRmvRePNEiUolh9umg8KsMpnLBblIeCxdvDaH+TKxzxascqdkqWDAeM2lECWeImMNmIYKSVrWO7sFao2xaRWrHzOOiMgue0RCeEGM0DEne5r3c6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770856; c=relaxed/simple;
	bh=EUYkJ8X3brZmyvzYY4WIoIAfsfKpOVUohMtT+A22F0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh9H/XimlWzuxDjYsf+DdMUT2KxMEiWWxzM0E0z5s7wTXdDCiSOjICQhGbLJDRxfZo8HnhCUBhX9U4BQ4pJKChgYBFzajjJ1ZBGhI33eXSlVzH2ieX/mcapxW60Cc1Mf9Q9YnD2crFESaQWKYMsqgnGIOrxmF8935E3omXck27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hBNOMbO6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gmXvVERKt1MkiyUv5Pp3EA8BiG/lR/18RXjEfmSm+lM=; b=hBNOMbO6NEr/dxLtG0eJ/G04ju
	WELOe5fv+Lxv1rPnhv0sM9XJZOBBc/BWOfeEUTCQExv5HA4Bn+Gp/OQbYJjWe4LNQGUjbeVbqHReU
	6/gbpNsfAu97bo7mnKqCmcWwO5OEIKPVYZRkIrjgryG5bvOCCSB4QVTvL2ODvAuKur7cZunnIXSRL
	21MrK4tIL9/tY9jUT8DNU/r5ZBYLIWC8zg9dXMD1RX2Pt2bVAqB5aqriYRY/IXp/5QqaUh12+SkT+
	SK+Sp9fRDdjlkOfZyy7fNqj/dkEYM0AriitFuSfhhDM7oO9LhIXwnWlScr04fS5AhxgINoJqeu0WB
	1lZdu6zg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNx8-0000000EHk4-0G9Q;
	Wed, 07 Jan 2026 07:27:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 03/24] NFS: remove nfs_client_mark_return_all_delegations
Date: Wed,  7 Jan 2026 08:26:54 +0100
Message-ID: <20260107072720.1744129-4-hch@lst.de>
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

Fold nfs_client_mark_return_all_delegations into
nfs_expire_all_delegations, which is the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5648f1f0943b..2ef8fe01ef4a 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -938,16 +938,6 @@ static bool nfs_server_mark_return_all_delegations(struct nfs_server *server)
 	return ret;
 }
 
-static void nfs_client_mark_return_all_delegations(struct nfs_client *clp)
-{
-	struct nfs_server *server;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link)
-		nfs_server_mark_return_all_delegations(server);
-	rcu_read_unlock();
-}
-
 static void nfs_delegation_run_state_manager(struct nfs_client *clp)
 {
 	if (test_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state))
@@ -961,7 +951,13 @@ static void nfs_delegation_run_state_manager(struct nfs_client *clp)
  */
 void nfs_expire_all_delegations(struct nfs_client *clp)
 {
-	nfs_client_mark_return_all_delegations(clp);
+	struct nfs_server *server;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link)
+		nfs_server_mark_return_all_delegations(server);
+	rcu_read_unlock();
+
 	nfs_delegation_run_state_manager(clp);
 }
 
-- 
2.47.3


