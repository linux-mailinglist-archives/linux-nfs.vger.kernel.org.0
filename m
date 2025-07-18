Return-Path: <linux-nfs+bounces-13148-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1977FB09D88
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 10:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A0CA87120
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 08:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526881F8AC5;
	Fri, 18 Jul 2025 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W/aPBI3y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD2145346
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826520; cv=none; b=T7hPvgnAfz1hjO1mhqlhfp/7orWDw/TVIHtoHJP5+YMkbJD3NEni6t2MgbNtqZUfy30snZWCp4MVPROcpV5M/K1W3y1gbLfgv4/T2O5AlH1omEIO1OOuGnM5pv6UfP2KZwacQsb4ztH/FNEHvaNshb4Mg2N3WrhmYTFGAPjnU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826520; c=relaxed/simple;
	bh=05zz0dIFsUSV4YiT/ZBqByc82d/diVcBhszS8BcHmFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXlkEgpt+IkGXKDniYjDWbpK5U8O2FMkMQ5Nyq8m+rWCfGBNDt0y/pp0J8lWuZNJOfreJY9sA0qZPNsYy8HDjO3qufjbWlxsVM/SfezjIbXw95z+qGFJftXUvnKjBwKxBLGE38iI973GzRvMM5nxuEslQFifo74SAP3Xpy6nlMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W/aPBI3y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oCn+VcW8MprDfpuRp+XvOMLYBG6YIoYzG5tG/I5jVbg=; b=W/aPBI3yC91be4se3hVYkRibpE
	HazLs+8xO1YoY09K72mmPXMB9LuU53KDWu1Eis4yIbC2PjqUs1sitb3VfLe1ZUD3Y7hhwtCfT6TsV
	tUZUM6fM6zdWxyFGA7fM3CVsLpyNHhoIQsLVkbDTndtPmSNrmicx574oqOX8uzZQeDl1VOyZfP4Zw
	qDRlNLIMc498pork/qMxn3w59Xl6jDWqd7nuB7wUbu/qndPfLLbakcon899uRqzzKk2rn+DnFB9J/
	4qxCDNYd0nNR5jYL3CYwhZUfZRYV1ldcwSkNABXf5RF0ksIebcUSwNZ7Bge3LTImUsrlQlSYn01M9
	ZQA6XPSA==;
Received: from [2001:4bb8:2dd:a44:6557:72e7:fc8:56bc] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucgFR-0000000Bztu-3OXP;
	Fri, 18 Jul 2025 08:15:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 2/5] NFS: cleanup nfs_inode_reclaim_delegation
Date: Fri, 18 Jul 2025 10:14:47 +0200
Message-ID: <20250718081509.2607553-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718081509.2607553-1-hch@lst.de>
References: <20250718081509.2607553-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Reduce a level of indentation for most of the code in this function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 6f136c47eed7..568d2e6d65fa 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -237,34 +237,34 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 
 	rcu_read_lock();
 	delegation = rcu_dereference(NFS_I(inode)->delegation);
-	if (delegation != NULL) {
-		spin_lock(&delegation->lock);
-		nfs4_stateid_copy(&delegation->stateid, stateid);
-		delegation->type = type;
-		delegation->pagemod_limit = pagemod_limit;
-		oldcred = delegation->cred;
-		delegation->cred = get_cred(cred);
-		switch (deleg_type) {
-		case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
-		case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
-			set_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags);
-			break;
-		default:
-			clear_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags);
-		}
-		clear_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags);
-		if (test_and_clear_bit(NFS_DELEGATION_REVOKED,
-				       &delegation->flags))
-			atomic_long_inc(&nfs_active_delegations);
-		spin_unlock(&delegation->lock);
-		rcu_read_unlock();
-		put_cred(oldcred);
-		trace_nfs4_reclaim_delegation(inode, type);
-	} else {
+	if (!delegation) {
 		rcu_read_unlock();
 		nfs_inode_set_delegation(inode, cred, type, stateid,
 					 pagemod_limit, deleg_type);
+		return;
+	}
+
+	spin_lock(&delegation->lock);
+	nfs4_stateid_copy(&delegation->stateid, stateid);
+	delegation->type = type;
+	delegation->pagemod_limit = pagemod_limit;
+	oldcred = delegation->cred;
+	delegation->cred = get_cred(cred);
+	switch (deleg_type) {
+	case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
+	case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
+		set_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags);
+		break;
+	default:
+		clear_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags);
 	}
+	clear_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags);
+	if (test_and_clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
+		atomic_long_inc(&nfs_active_delegations);
+	spin_unlock(&delegation->lock);
+	rcu_read_unlock();
+	put_cred(oldcred);
+	trace_nfs4_reclaim_delegation(inode, type);
 }
 
 static int nfs_do_return_delegation(struct inode *inode,
-- 
2.47.2


