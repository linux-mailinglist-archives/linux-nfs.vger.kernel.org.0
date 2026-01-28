Return-Path: <linux-nfs+bounces-18555-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DVpCeqUeWmOxgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18555-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 405DD9D15D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92F7E3004DAE
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 04:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985F52264A8;
	Wed, 28 Jan 2026 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MYrM6amU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6A2F0C63
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 04:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575652; cv=none; b=m9G3WOqWarz1liKR7GTVFIYJHni/PaAQVeBm+so0+fNgHEFpEuOU1y47UIYDmba81tY6bOh6Di6e5/YqDRI24WryqU76q+uM0n82zhF5j0WA9ivIy4UdFpRSYPVTxVvVg+D+4lGpwADl4hoc5kE7kgdBe6htoPCH85jCM6qyHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575652; c=relaxed/simple;
	bh=SzXnPxGQIf4cpDQwIis/k49CeJ2ODOlERvr96VsNdRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euKkX9hdD57amybgGpvzYy4U8dUo35XFUE9t0yF03K2zHXhIBPCDfUYb+6uXeYeVakenhOOn5PfJ/5Go3uIC2FG20ct3dodJC6pt6RszN1UIKs9KVqQeGqvIav5ytoDq1xUWcEN3h/+OpWVsUDh/JuIA2DSY5nVS/VRqnjioNuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MYrM6amU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BSi9y6aQmkGa/PuQV11nNv8i712MXdi8MBZFoKzwld0=; b=MYrM6amUaSt76gtT2DqFk8+qTl
	EjleiRl0rhtlZtpD7xVa1mfodQxpqC1fWR8U3YcFos/iF59mLbqf+LkBRbqzCfVGNNhvN9CplKK7u
	u1VS5FM73dpIC6ZrtdOVLdn2YcH1KUh92tH2eAJsyGAKjZrRPlQcAm2LZSA8BOdRRCZyjDaWOa21m
	sPiA2bQVOZh4jQOv6X1oahMv3/UCQRNhizXtpyyT/dFOSCCqoxNZ8da86VC5ghCNqqxMSm6FNlIqt
	TZC1VzA87hEfFzAqmFKJ4Y1x7XPPIdEEzpY6oAwLHYXWnXD0Tr/qUKkp+B3tdh85zmMfnJKwWrQ+a
	apVoHIig==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkxSk-0000000FRHt-246m;
	Wed, 28 Jan 2026 04:47:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 5/7] NFS: fold nfs_abort_delegation_return into nfs_end_delegation_return
Date: Wed, 28 Jan 2026 05:46:07 +0100
Message-ID: <20260128044706.556046-6-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-18555-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 405DD9D15D
X-Rspamd-Action: no action

This will allow to simplify the error handling flow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 32803963b5d7..cf90aa7f922a 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -350,21 +350,6 @@ nfs_start_delegation_return(struct nfs_inode *nfsi)
 	return delegation;
 }
 
-static void nfs_abort_delegation_return(struct nfs_delegation *delegation,
-					struct nfs_server *server, int err)
-{
-	spin_lock(&delegation->lock);
-	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
-	if (err == -EAGAIN) {
-		set_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
-		set_bit(NFS4SERV_DELEGRETURN_DELAYED,
-			&server->delegation_flags);
-		set_bit(NFS4CLNT_DELEGRETURN_DELAYED,
-			&server->nfs_client->cl_state);
-	}
-	spin_unlock(&delegation->lock);
-}
-
 static bool
 nfs_detach_delegations_locked(struct nfs_inode *nfsi,
 		struct nfs_delegation *delegation,
@@ -593,13 +578,23 @@ static int nfs_end_delegation_return(struct inode *inode,
 		err = nfs4_wait_clnt_recover(server->nfs_client);
 	}
 
-	if (err) {
-		nfs_abort_delegation_return(delegation, server, err);
-		return err;
-	}
+	if (err)
+		goto abort;
 
 out_return:
 	return nfs_do_return_delegation(inode, delegation, issync);
+abort:
+	spin_lock(&delegation->lock);
+	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
+	if (err == -EAGAIN) {
+		set_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
+		set_bit(NFS4SERV_DELEGRETURN_DELAYED,
+			&server->delegation_flags);
+		set_bit(NFS4CLNT_DELEGRETURN_DELAYED,
+			&server->nfs_client->cl_state);
+	}
+	spin_unlock(&delegation->lock);
+	return err;
 }
 
 static int nfs_return_one_delegation(struct nfs_server *server)
-- 
2.47.3


