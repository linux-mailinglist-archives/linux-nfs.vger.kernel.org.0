Return-Path: <linux-nfs+bounces-18556-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKGuC+qUeWmOxgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18556-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F8B9D15E
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8EC330086D6
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 04:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1F2264A8;
	Wed, 28 Jan 2026 04:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u/iOjR34"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAAB2D839B
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 04:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575655; cv=none; b=N++4xYGHTpBG/bfdse7M0rA2cHIgPjD1JC1qqqpUscA/hhks0S18bSGoLbi2/HRgaxeEJ68Y4/Wne/hxVTr7l8FB01tNOqoH8Oqcw5QyahB9YxJTKocF9gjF2xKet/Gihjd5p8B/UD9oaqZLE1L4MFX4aGKMpzD8d0L9gBsNnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575655; c=relaxed/simple;
	bh=0Quj+/QdQrtqpeHBVOgpPF9xccT5eIU84SVbAcrZNUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW+0eye3unasgTVvf6FfX2kPv6U4g6XcstbrhlLF3iXTncdKBi3WH4vgJfes9K1qCMLRH7JFKJj/GDU8XgXE7G4L1jXmzTnVV6oDlYue4+AUqQ+qi1n4K+HD7IA3d/jtN7GjYGNeCEFcZ7fG0C44HPvw7dU4l0GyDqMrSL4E0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u/iOjR34; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=I2OibnmEHlKgpnjtTtbC5PxiHYoYZNplLsTRxDo1ao0=; b=u/iOjR34roPzPtGXzQJ0YFzM0I
	SMA06m5LqZnOHvzqJW7qLgAU+NqL1co/F1pRTpDlmDABt3MUxaJA9zcMjKygYukfqQJLA1SXqCuNC
	Zyg2m5XG0Jh9aJe8bRu4lfcE5jUvLj1PQp9EwxWy8B+yicMhvbKhlmzfmm0ppGCE+T8ZNtTBALWPW
	0m0lSchWNXKSw/G5UY+c8gQACqlGYlFtxKJ3hqL7qgDzreGB7NRBx1JA1ZHO/9PxaBVoeHgEKyncr
	vpZe4tGgRGlrVhy+9ILWtdR4CFzbk6Li7dky2A1b/MWlrAOI2bm/0grM3vd3i/OkuVL7ByyDMgAM7
	Mh1oI+Nw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkxSn-0000000FRIC-1odJ;
	Wed, 28 Jan 2026 04:47:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 6/7] NFS: simplify error handling in nfs_end_delegation_return
Date: Wed, 28 Jan 2026 05:46:08 +0100
Message-ID: <20260128044706.556046-7-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18556-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: A9F8B9D15E
X-Rspamd-Action: no action

Drop the pointless delegation->lock held over setting multiple
atomic bits in different structures, and use separate labels
for the delay vs abort cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index cf90aa7f922a..cff49a934c9e 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -570,30 +570,27 @@ static int nfs_end_delegation_return(struct inode *inode,
 			break;
 		err = nfs_delegation_claim_opens(inode, &delegation->stateid,
 				delegation->type);
-		if (!issync || err != -EAGAIN)
+		if (!err)
 			break;
+		if (err != -EAGAIN)
+			goto abort;
+		if (!issync)
+			goto delay;
+
 		/*
 		 * Guard against state recovery
 		 */
 		err = nfs4_wait_clnt_recover(server->nfs_client);
 	}
 
-	if (err)
-		goto abort;
-
 out_return:
 	return nfs_do_return_delegation(inode, delegation, issync);
+delay:
+	set_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
+	set_bit(NFS4SERV_DELEGRETURN_DELAYED, &server->delegation_flags);
+	set_bit(NFS4CLNT_DELEGRETURN_DELAYED, &server->nfs_client->cl_state);
 abort:
-	spin_lock(&delegation->lock);
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
-	if (err == -EAGAIN) {
-		set_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
-		set_bit(NFS4SERV_DELEGRETURN_DELAYED,
-			&server->delegation_flags);
-		set_bit(NFS4CLNT_DELEGRETURN_DELAYED,
-			&server->nfs_client->cl_state);
-	}
-	spin_unlock(&delegation->lock);
 	return err;
 }
 
-- 
2.47.3


