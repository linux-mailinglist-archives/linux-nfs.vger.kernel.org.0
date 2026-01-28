Return-Path: <linux-nfs+bounces-18552-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOlvMt6UeWmOxgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18552-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DCB9D147
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E99A3005144
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 04:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8CF2264A8;
	Wed, 28 Jan 2026 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xLYAFTuS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AB285C80
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 04:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575641; cv=none; b=D1NMI7IAgbcDKPlCUFYmeo/nz8HQOjbfenLjn5JYSpkVfmz3sb6+2NvYIrJ3MCOg9XlGBLY4sLbBKDZxvbYmgsHuzyM3zgYaR59gGnS25YozGbldxEAmlNX/2hLJgFOW3Tki64B6Ij/BFwxmNAD5P9DSFktI7zA6yYdJzWKWco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575641; c=relaxed/simple;
	bh=wCEd2WnBtpL/zFhKrhMQe2fyAxUc0o5280PxNSvWpxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ok5jQ8sdHmZHr5/8BOB388YPq7AlNIHz9tgrdRAfX8P7y1Cs8sKpmJcjTZhVivSksasJVFlKuFd1hLcGyMgcIHKrqIjhg9MDUABvitu1UFDoHzZVJk4QFb+J2wmzCKKSk4fPWTMJtc/pQc5IbfHrR5RG2+zQvy2kTeRdvyYYaSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xLYAFTuS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jDlfh6ILL9h+0rSOoODDn0tesLQH7hMX45Mjgx3U97M=; b=xLYAFTuS1tzhpnWUh1wtgMSAdO
	FqLebZqoQB/3tB+da3D6IkoRqhEcz6SyKu85Z6LOP/uoYmd2hlkqmc8Tu9JxzLapqBrPhczXQ9YoQ
	Vr8BwG9k/FzTRIokeVLUmWLu4oaP/1UE3MB4hGbBsnDlr/tn7aIGBRLe5qHj/OvneNCxQ6eUtB2rN
	0He+myAcXrvUbW6lY9RLVPIORxLSEzkGlN8+nTqDlVlmQdx0/mwXGlnAe+vLdYKVaTRpcEd1C+4SL
	68WGNjkhG1Q7oSi7kt2FcbTW8P1lllmxdTJVG/3ctZGk1vs2e2dFyNJO2r/9eSpvePIRmIL53uTVi
	Yjs+fZEw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkxSZ-0000000FRGt-1M1o;
	Wed, 28 Jan 2026 04:47:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/7] NFS: return void from ->return_delegation
Date: Wed, 28 Jan 2026 05:46:04 +0100
Message-ID: <20260128044706.556046-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128044706.556046-1-hch@lst.de>
References: <20260128044706.556046-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18552-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: D6DCB9D147
X-Rspamd-Action: no action

The caller doesn't check the return value, so drop it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c     | 8 +++-----
 fs/nfs/delegation.h     | 2 +-
 fs/nfs/nfs3proc.c       | 3 +--
 fs/nfs/proc.c           | 3 +--
 include/linux/nfs_xdr.h | 2 +-
 5 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index c77c7b2d5877..fe1f57ec326c 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -814,23 +814,21 @@ void nfs_inode_evict_delegation(struct inode *inode)
  *
  * Returns zero on success, or a negative errno value.
  */
-int nfs4_inode_return_delegation(struct inode *inode)
+void nfs4_inode_return_delegation(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
-	int err;
 
 	delegation = nfs_start_delegation_return(nfsi);
 	if (!delegation)
-		return 0;
+		return;
 
 	/* Synchronous recall of any application leases */
 	break_lease(inode, O_WRONLY | O_RDWR);
 	if (S_ISREG(inode->i_mode))
 		nfs_wb_all(inode);
-	err = nfs_end_delegation_return(inode, delegation, 1);
+	nfs_end_delegation_return(inode, delegation, 1);
 	nfs_put_delegation(delegation);
-	return err;
 }
 
 /**
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index d30f19a28077..eda39fcb032b 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -47,7 +47,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 				  fmode_t type, const nfs4_stateid *stateid,
 				  unsigned long pagemod_limit, u32 deleg_type);
-int nfs4_inode_return_delegation(struct inode *inode);
+void nfs4_inode_return_delegation(struct inode *inode);
 void nfs4_inode_return_delegation_on_close(struct inode *inode);
 void nfs4_inode_set_return_delegation_on_close(struct inode *inode);
 int nfs_async_inode_return_delegation(struct inode *inode, const nfs4_stateid *stateid);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1181f9cc6dbd..d3d2fbeba89d 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -1027,11 +1027,10 @@ static int nfs3_have_delegation(struct inode *inode, fmode_t type, int flags)
 	return 0;
 }
 
-static int nfs3_return_delegation(struct inode *inode)
+static void nfs3_return_delegation(struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
 		nfs_wb_all(inode);
-	return 0;
 }
 
 static const struct inode_operations nfs3_dir_inode_operations = {
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 39df80e4ae6f..0e440ebf5335 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -697,11 +697,10 @@ static int nfs_have_delegation(struct inode *inode, fmode_t type, int flags)
 	return 0;
 }
 
-static int nfs_return_delegation(struct inode *inode)
+static void nfs_return_delegation(struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
 		nfs_wb_all(inode);
-	return 0;
 }
 
 static const struct inode_operations nfs_dir_inode_operations = {
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 79fe2dfb470f..1c121f6f64c3 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1849,7 +1849,7 @@ struct nfs_rpc_ops {
 				struct iattr *iattr,
 				int *);
 	int (*have_delegation)(struct inode *, fmode_t, int);
-	int (*return_delegation)(struct inode *);
+	void (*return_delegation)(struct inode *);
 	struct nfs_client *(*alloc_client) (const struct nfs_client_initdata *);
 	struct nfs_client *(*init_client) (struct nfs_client *,
 				const struct nfs_client_initdata *);
-- 
2.47.3


