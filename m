Return-Path: <linux-nfs+bounces-17542-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A803DCFC5D3
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EBCD303A091
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511682848BB;
	Wed,  7 Jan 2026 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uioWkpCz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BC627F727
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770922; cv=none; b=cjw37iBfqVwnJfZyT6bfbZAtP7ZpJWkwEpIndCXJ2cMHi6BCScA/2HAA3jJaXjtwdVpzPBrlaDPBzvq0pMF7nq57pPT/mbK8GKsq2MUWzW3/ASWRbpP50gIzgBFokuzUhw8UQGJVR7rHfV0RnfP+T7t1ZRgqwWhLKiAJqNtVnpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770922; c=relaxed/simple;
	bh=r8C3UE6KMhb/eOhpoH6l+TVCmvaqvxXs2DYgEBU0YKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7CklO8kptnELnzDYs/Mj3OriOD07cM3T29JLGutydfMjtLm5E5IgoqmPVtOxKkYp9MXdnmtYgwiQoyWEDkisIHOFwKrf3rkly9eB3nmT2MI27WKc3eIfiK7FndkwePU/STBkv5CeuOK7YTaALnq4hNu6wIiMlbDK557cYg74E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uioWkpCz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GAAkH74hbo1RU14IbNFPzeXFNeS5ZGi0JELnYMWbV60=; b=uioWkpCzqBwsAq9B0mK2wLyikf
	43/o9775qGgtIQkBqb4+5dXVKNYR2vE9cfwLF8SJX4RsyHSKgGcIkH0H9p3nICmdju+xrVRCfzNra
	1ZkfWkOwt4LWmFmHeNtMv2wKbEaXTkMGg9eYfSg8zcXrY6p9JUoJdFnHqvLgyHPmrbVBQyFMumMUN
	aK8oLQRA1hEwDRiTfzEUrRSOkAy7V2Z6V76gs7eLM+IXroPcvDHbQJARHPNTgeS3KIR3eRcmG+rG0
	CsNPzIhvqItok6tMl1i/2btUkDa29+KIp+LxHftnN177DmF2a0S25r+LDnwinF5Ar04aL87TSSMvz
	29/f5enw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNyC-0000000EHsV-0emW;
	Wed, 07 Jan 2026 07:28:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 20/24] NFS: use a local RCU critical section in nfs_start_delegation_return
Date: Wed,  7 Jan 2026 08:27:11 +0100
Message-ID: <20260107072720.1744129-21-hch@lst.de>
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

Nested RCU critical sections are fine and very cheap.  Have a local one
in nfs_start_delegation_return so that the function is self-contained
and to prepare for simplifying the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5d9dba7ab430..2ac897f67b01 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -309,11 +309,13 @@ nfs_start_delegation_return(struct nfs_inode *nfsi)
 	struct nfs_delegation *delegation;
 	bool return_now = false;
 
-	lockdep_assert_in_rcu_read_lock();
-
+	rcu_read_lock();
 	delegation = rcu_dereference(nfsi->delegation);
-	if (!delegation || !refcount_inc_not_zero(&delegation->refcount))
+	if (!delegation || !refcount_inc_not_zero(&delegation->refcount)) {
+		rcu_read_unlock();
 		return NULL;
+	}
+	rcu_read_unlock();
 
 	spin_lock(&delegation->lock);
 	if (delegation->inode &&
@@ -762,10 +764,7 @@ int nfs4_inode_return_delegation(struct inode *inode)
 	struct nfs_delegation *delegation;
 	int err;
 
-	rcu_read_lock();
 	delegation = nfs_start_delegation_return(nfsi);
-	rcu_read_unlock();
-
 	if (!delegation)
 		return 0;
 
-- 
2.47.3


