Return-Path: <linux-nfs+bounces-17546-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CD6CFC61E
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5437C3009FFB
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2AD27A461;
	Wed,  7 Jan 2026 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xuayk93N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA0299947
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770937; cv=none; b=hmN2vpbqfMmqvwQ3Jbnhr9dtXguLdtitVeAxtusGGv1BF/sBB+kz1sb7uKnoz2fqSYoN5/1VoQShfmElAN4Di0YFns2kJFYTCOkyJFv05e3Qk+tUe5euoqN965YR1kylEUkLcw0q3Yd4oiFoIiOz9mvKKsx5jdUCxY6fOm3AnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770937; c=relaxed/simple;
	bh=sEmBWo21PvKN0z9Z2zRXJfG/83/r+c/8dCJ9IoqaLbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVf2rorT/b2vye1Z2bJwdFawkMlrvltY2KS78Zna8ZY4v5AKC44kCHRvcgWsT2XRKHVePSbz7DdG7H4oKdo1sEP77RnsYKGRqbdPMO1X022V4zNtK+HDyLm/AFEK30qqJD78ttuusOswvfR/fY7n4lSPcOWr97Oh3sZVkQD0urk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xuayk93N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WJdTKSSYQyzQpQY8QRaaoDvV75cJkFPIjnC7+iP+6PI=; b=Xuayk93NW2C3Ir69jGvWz10FSo
	Hyy9R6xYcNABMZw6/QBSuAFiWOYKJNRvNZAx83gZNR5uzVqKyqre5s9HnvzDquSa3yHsK/hYlZoHJ
	ay0TwGu+ZkAj5r/xTdILTugntzmKqHKtf4btwZd2PnTEO8q/ffDNbAFcfjQdv2kk2B0MdpnCqF3jW
	vvcbdHzP2gi/gsnbahfHmZYPOocjpdfpuYCa6KTvzYjkdXkG4Di5+B/Wd3k6f+s9yllaegpqa090J
	rIP7+gr59gEMFvS6cweF1xCAK0f89NSKWztCeOyPVLPxJsJI/bm3FJ7Mhcm22hH21sz9s7oeyokOo
	J6IS5i6A==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNyR-0000000EHvK-21ox;
	Wed, 07 Jan 2026 07:28:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 24/24] NFS: make nfs_mark_return_unreferenced_delegations less aggressive
Date: Wed,  7 Jan 2026 08:27:15 +0100
Message-ID: <20260107072720.1744129-25-hch@lst.de>
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

Currently nfs_mark_return_unreferenced_delegations marks all open but
not referenced delegations (i.e., those were found by a previous pass)
as return on close, which means that we'll return them on close without
a way out.

Replace this with only iterating delegations that are on the LRU list,
and avoid delegations that are in use by an open files to avoid this.

Delegations that were never referenced while open still are be prime
candidates for return from the LRU if the number of delegations is over
the watermark, or otherwise will be returned by the next
nfs_mark_return_unreferenced_delegations pass after they are closed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 0b256f461fe4..6497fdbd9516 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1124,15 +1124,21 @@ void nfs_remove_bad_delegation(struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(nfs_remove_bad_delegation);
 
-static void nfs_mark_return_unreferenced_delegations(struct nfs_server *server)
+static bool nfs_mark_return_unreferenced_delegations(struct nfs_server *server)
 {
-	struct nfs_delegation *delegation;
+	struct nfs_delegation *d, *n;
+	bool marked = false;
 
-	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
-		if (test_and_clear_bit(NFS_DELEGATION_REFERENCED, &delegation->flags))
+	spin_lock(&server->delegations_lock);
+	list_for_each_entry_safe(d, n, &server->delegations_lru, entry) {
+		if (test_and_clear_bit(NFS_DELEGATION_REFERENCED, &d->flags))
 			continue;
-		nfs_mark_return_if_closed_delegation(server, delegation);
+		list_move_tail(&d->entry, &server->delegations_return);
+		marked = true;
 	}
+	spin_unlock(&server->delegations_lock);
+
+	return marked;
 }
 
 /**
@@ -1143,13 +1149,17 @@ static void nfs_mark_return_unreferenced_delegations(struct nfs_server *server)
 void nfs_expire_unreferenced_delegations(struct nfs_client *clp)
 {
 	struct nfs_server *server;
+	bool marked = false;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link)
-		nfs_mark_return_unreferenced_delegations(server);
+		marked |= nfs_mark_return_unreferenced_delegations(server);
 	rcu_read_unlock();
 
-	nfs_delegation_run_state_manager(clp);
+	if (marked) {
+		set_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state);
+		nfs4_schedule_state_manager(clp);
+	}
 }
 
 /**
-- 
2.47.3


