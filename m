Return-Path: <linux-nfs+bounces-17530-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2E8CFC58E
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78BEE3008F93
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1052F13AA2F;
	Wed,  7 Jan 2026 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NjdI/Ew4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A7279DC3
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770874; cv=none; b=Rlh8jSSB/O2qjBN7Ob/Xrr5Ed31nbnL2TK5oCfyyG7vNpuhOVQU91hjvfX+NOLrfy2Ig3UbhRaywSfAOj+p0gpXIf+2RFWDzRY7S+2snNSQoTil4MAYiAoxnF/ltAUqICOX9axH7veU6D5MkTo5uYehR0ME6+tHZrKRxMavkX/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770874; c=relaxed/simple;
	bh=W4QVs5bhk3oToeuKIOhGK+pn7BhJuTrwfESDkDoPX0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYZfZrB/+GT2mYIPRK1S1dAhvIShiYkjKyfDy+6l7Ql3N0L4hEha0A+HiQY6IIx0xqk7HtxBwdSQzSwi25Omc0AwkgNqNn5YG+SV0GI25pVB5aeOhuU5igg2Wy8LpIZd0nElLTeKrlrMeHtYHPYegtfzOHU9vDNpK1s4VCKRX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NjdI/Ew4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xlUxy+ujTslerA434mGbJ3FYFTrJ9mtmyMa3qWpi24Q=; b=NjdI/Ew4vxDVNPY2VoZfWG227f
	xmzKkYToY2RnuCv3F1Cq81QhritSfOirH1HV2jI4/4lWSs5nVpEAJBt0NHoN1a6RV1YzWqFPQJA2D
	robZgyFyONBHwUed5cSFM9DXzgIVusjsMfqsN0QGJliNjJRwVrPHxNdQOB80q4nerFX29J8/iMiGR
	5Cd6MuIcKqq12muP6ekd9hM0WPQVb3tDfojtt0jPF0Qz4IkE195eqFvfFPfGbtI1ts/bbhU4uIHLx
	PJqNRLp0TzsoNrK6wsmqUCnBxn3XIl2tQYGnvxU69cgA3lIDMA+oOg9tn4nZh1AoZ3Wg5ShliAhkC
	WGmUSg7w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNxP-0000000EHlD-2paF;
	Wed, 07 Jan 2026 07:27:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 08/24] NFS: drop the _locked postfix from nfs_start_delegation_return
Date: Wed,  7 Jan 2026 08:26:59 +0100
Message-ID: <20260107072720.1744129-9-hch@lst.de>
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

Now that nfs_start_delegation_return_locked is gone, and we have
RCU locking asserts, drop the extra postfix.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index a5a3ecac8a43..5049c65cc8e5 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -315,7 +315,7 @@ static struct inode *nfs_delegation_grab_inode(struct nfs_delegation *delegation
 }
 
 static struct nfs_delegation *
-nfs_start_delegation_return_locked(struct nfs_inode *nfsi)
+nfs_start_delegation_return(struct nfs_inode *nfsi)
 {
 	struct nfs_delegation *ret = NULL;
 	struct nfs_delegation *delegation;
@@ -583,7 +583,7 @@ static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation
 
 	err = nfs_do_return_delegation(inode, delegation, issync);
 out:
-	/* Refcount matched in nfs_start_delegation_return_locked() */
+	/* Refcount matched in nfs_start_delegation_return() */
 	nfs_put_delegation(delegation);
 	return err;
 }
@@ -658,7 +658,7 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 			}
 		}
 
-		delegation = nfs_start_delegation_return_locked(NFS_I(inode));
+		delegation = nfs_start_delegation_return(NFS_I(inode));
 		rcu_read_unlock();
 
 		iput(to_put);
@@ -781,7 +781,7 @@ int nfs4_inode_return_delegation(struct inode *inode)
 	struct nfs_delegation *delegation;
 
 	rcu_read_lock();
-	delegation = nfs_start_delegation_return_locked(nfsi);
+	delegation = nfs_start_delegation_return(nfsi);
 	rcu_read_unlock();
 
 	if (!delegation)
@@ -1258,13 +1258,13 @@ static int nfs_server_reap_unclaimed_delegations(struct nfs_server *server,
 		inode = nfs_delegation_grab_inode(delegation);
 		if (inode == NULL)
 			continue;
-		delegation = nfs_start_delegation_return_locked(NFS_I(inode));
+		delegation = nfs_start_delegation_return(NFS_I(inode));
 		rcu_read_unlock();
 		if (delegation != NULL) {
 			if (nfs_detach_delegation(NFS_I(inode), delegation,
 						server) != NULL)
 				nfs_free_delegation(server, delegation);
-			/* Match nfs_start_delegation_return_locked */
+			/* Match nfs_start_delegation_return */
 			nfs_put_delegation(delegation);
 		}
 		iput(inode);
-- 
2.47.3


