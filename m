Return-Path: <linux-nfs+bounces-17158-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 659D4CCA619
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 140EF301CD18
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF3D314D00;
	Thu, 18 Dec 2025 05:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XFyEosxa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED23128D2
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037440; cv=none; b=J9KPdvbPT50P+DnHXpKkQWX2/EscvmMeZZ5nhWjTlzDYEbAsQ27qwqiGjyKqcRr12j2YvQ9Em9xh1a+F9ZHbTwN+iGVWVuP0BFh0ri7V2F7DHg0fNOaW6OEHGqpOGtY6LBHLCvdHoUHWeUmnfrivpR4FquK6ez92q4NsUrqRm6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037440; c=relaxed/simple;
	bh=/LvwrkOLcrb6zFr0suU7Zz2m8oUWSTZ1D50bmG0baxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c17U90hzDApuNusZL8kyncGiGhoz6kvSh9/KwQoAc+yLcVypSUGfGXVkklCG5cm+p4JcSUox7y5d1naCXleZglYZ7x0FaVUGLvfqyFMGc1/I5oet9I+i71G0mdf6o6z54gLS0QjQlXYWb1u52Xdw5P5o/kpYXFOTf0Gvpudf418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XFyEosxa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qfiiMPI+K2S+zq1Q6bmAkU1N3NIh8s2JLeWLvwV+jrI=; b=XFyEosxaPPY7w7M46+W1VNeVmD
	0/RfC+F7ysKsbdirs4CZPpnKxdMdwOV7RttBBCaPQT+QDqcD/K80Z1RnAP4BMGU3jVUOLEhM8wIA4
	nnj6z7pSEv1khy2Ru/nHm5DyL9DkLUjOqNnPn6v7Bxn9mws/brIJIbtwI3DFll+h4bmC9r2ZAXIBW
	nPWxxePghwtzMwEqIMfg1e/IaCgloEihP+OKb7DtpYmD2bFpovVKBp3DcrndZLxx9zq8RsHXyfnYx
	ls/tuHj5v/RCrGjzaQX7LGO5WtxG6VaBecry6fZn0aksqGD3a/mUQoRBR9dQ2qOTntUlkC182lapW
	t/7wAhwQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW70m-00000007rbz-1dWf;
	Thu, 18 Dec 2025 05:57:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 10/24] NFS: open code nfs_delegation_need_return
Date: Thu, 18 Dec 2025 06:56:14 +0100
Message-ID: <20251218055633.1532159-11-hch@lst.de>
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

There is only a single caller, and the function can be condensed into a
single if statement, making it more clear what is being tested there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 1ff496147b1e..3c50a1467022 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -586,22 +586,6 @@ static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation
 	return err;
 }
 
-static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
-{
-	bool ret = false;
-
-	trace_nfs_delegation_need_return(delegation);
-
-	if (test_and_clear_bit(NFS_DELEGATION_RETURN, &delegation->flags))
-		ret = true;
-	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags) ||
-	    test_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags) ||
-	    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
-		ret = false;
-
-	return ret;
-}
-
 static int nfs_server_return_marked_delegations(struct nfs_server *server,
 		void __always_unused *data)
 {
@@ -636,11 +620,17 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 	list_for_each_entry_from_rcu(delegation, &server->delegations, super_list) {
 		struct inode *to_put = NULL;
 
-		if (!nfs_delegation_need_return(delegation)) {
+		trace_nfs_delegation_need_return(delegation);
+
+		if (!test_and_clear_bit(NFS_DELEGATION_RETURN, &delegation->flags) ||
+		    test_bit(NFS_DELEGATION_RETURNING, &delegation->flags) ||
+		    test_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags) ||
+		    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
 			if (nfs4_is_valid_delegation(delegation, 0))
 				prev = delegation;
 			continue;
 		}
+
 		inode = nfs_delegation_grab_inode(delegation);
 		if (inode == NULL)
 			continue;
-- 
2.47.3


