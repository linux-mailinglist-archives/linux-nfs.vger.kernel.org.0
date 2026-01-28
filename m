Return-Path: <linux-nfs+bounces-18553-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NnsCOCUeWmOxgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18553-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B323D9D14F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6DC33005AE9
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 04:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B014E2FFDF8;
	Wed, 28 Jan 2026 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BILjb4Y8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6472264A8
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 04:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575645; cv=none; b=Yjj3scwdOxTRfCHUAAXun68wGsS6Rt0HW4zWIsBk/drAuPvXNolaDEY1OnVJtW4yMHJrC9o54HC/HS+3YPyu39YgI2mOXfK2ey/3OqHe61R/zwtB5QQWrsh7szaJi5kZmgAq5nC/qkkGQdmpIUR6XA4gUePxvK1rvj2Qt6lmuSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575645; c=relaxed/simple;
	bh=KMXEIrlTzOzhkmH3S2k0qSwqThU0t/O9QYEBwPWztN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D85kq+wKKJx17cAHeVBGWUCxTeZsDUDplKb6EAlIURG8WoLWoQY0RkZgBQg86qjNIWJZwdPOD1KzbcpB/afPNP7/l+tW8WZY5i80s4U700zLaIZhHu03XwX3s7ZGoa1/Qhs6f44Wg6RHMD90ju6f0HvfWICn5jnMsYNMq0mm2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BILjb4Y8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vjCd+HFZlaQIikLuqe3oOcTCGwkBp96J7qBD3W+EjZ8=; b=BILjb4Y8bWvKr1q/s9SxudbfHC
	Ro1RFsApwBENUFVUnzSLYIf/7ogdiiLZ1ivM7CsAEv6YucK0WJkhl+jtTBTu9FNfujswG4whBqM1J
	+v3zX8jFSKCQGd5ZCwZrd7bpfJR1q2dn+8IZMQPtxD626ijfWqqmQqQlCNOBQfIzAV6mrxZvTbzsX
	Plc0R8HXM6VJ0f4na2T0nI76ASN9EmlQEcc6+KVMBxmJQB+QNtyWDj37SO46B2bcyzq6YGELk60jv
	ZCoaygMNrbQmTkGnqFLArDT3KCYqtRznD0YEfq5UfmQJG7VW2Vcl74NVizEqYw+ulIkQdcNlW9Etg
	ZC/ModRg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkxSd-0000000FRH2-3jlg;
	Wed, 28 Jan 2026 04:47:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 3/7] NFS: use bool for the issync argument to nfs_end_delegation_return
Date: Wed, 28 Jan 2026 05:46:05 +0100
Message-ID: <20260128044706.556046-4-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18553-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,lst.de:mid,lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B323D9D14F
X-Rspamd-Action: no action

Replace the integer used as boolean with a bool type, and tidy up
the prototype and top of function comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index fe1f57ec326c..d95a6e9876f1 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -560,9 +560,12 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 }
 
 /*
- * Basic procedure for returning a delegation to the server
+ * Basic procedure for returning a delegation to the server.
+ * If @issync is set, wait until state recovery has finished.  Otherwise
+ * return -EAGAIN to the caller if we need more time.
  */
-static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation *delegation, int issync)
+static int nfs_end_delegation_return(struct inode *inode,
+		struct nfs_delegation *delegation, bool issync)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	unsigned int mode = O_WRONLY | O_RDWR;
@@ -635,7 +638,7 @@ static int nfs_return_one_delegation(struct nfs_server *server)
 
 	nfs_clear_verifier_delegated(inode);
 
-	err = nfs_end_delegation_return(inode, delegation, 0);
+	err = nfs_end_delegation_return(inode, delegation, false);
 	if (err) {
 		nfs_mark_return_delegation(server, delegation);
 		goto out_put_inode;
@@ -827,7 +830,7 @@ void nfs4_inode_return_delegation(struct inode *inode)
 	break_lease(inode, O_WRONLY | O_RDWR);
 	if (S_ISREG(inode->i_mode))
 		nfs_wb_all(inode);
-	nfs_end_delegation_return(inode, delegation, 1);
+	nfs_end_delegation_return(inode, delegation, true);
 	nfs_put_delegation(delegation);
 }
 
@@ -863,7 +866,7 @@ void nfs4_inode_set_return_delegation_on_close(struct inode *inode)
 	spin_unlock(&delegation->lock);
 	if (return_now) {
 		nfs_clear_verifier_delegated(inode);
-		nfs_end_delegation_return(inode, delegation, 0);
+		nfs_end_delegation_return(inode, delegation, false);
 	}
 	nfs_put_delegation(delegation);
 }
@@ -898,7 +901,7 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
 
 	if (return_now) {
 		nfs_clear_verifier_delegated(inode);
-		nfs_end_delegation_return(inode, delegation, 0);
+		nfs_end_delegation_return(inode, delegation, false);
 	} else {
 		nfs_delegation_add_lru(server, delegation);
 	}
-- 
2.47.3


