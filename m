Return-Path: <linux-nfs+bounces-17157-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E85CCA628
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88D54305E239
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8449E27F017;
	Thu, 18 Dec 2025 05:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VUIQCr5p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049773126AF
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037434; cv=none; b=G8GgZP6diXIuDwgd1yvX8y1ta9vmWdIGJiQsMxHLUsXgpRORG+5o71+RkQl53YHiSnV+uLa1TwVTFUbe+OFIHD2tA2e9H4rTC8+ePQGh1Qw8wqXnR/eWOp78hxEF838MoiplgXXg3Hv0AWkVcCint0y+GJoRRRrQG9myCKkN7DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037434; c=relaxed/simple;
	bh=z5CguUKEVlaCjP77aqAJheVu/fQDsECq91bIO7bSOPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sms2jfQMZj14JAKE7nyuh2Woe4GYtPLJ3zzCFW51ndjNwEph2a85Rk9UjnjNyIPmCJd519oBjtGk/kcXfWzqcO68wf/5pncRQzAWW7U8Z71oGcWFjxOVCR+47Sa0X/5ZeBuq+vmSZw09eMNDL/pXgN658iJpTZ3yegZ1q8sV2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VUIQCr5p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AC8a/SzcY2tQYzusspUVutLoZAh59FJCcjxjDoNd3h8=; b=VUIQCr5p+KoJ9AFGdR9YUFTZZ3
	olPVFX/EgtLUOVuzA4FZQ6HSRHnCXDlHFe3z4/YM8AZ2gV0AmZaFRYd6s2qgBi1T6Ga3ZWTio9Adn
	TyI4oS5+8rOCeTA7aOLctQT+NvQjnWSlKSB58L15y9Vd1uBgcEyogUe5LwSRxfv+K1x3cjoPKOffF
	GmlE9NMZQMBCTz0XUZMdd/VohVBnyu0wEekwBr40OMKo/E3QBzEX7911coxwjw4eGMo67F6xESMDH
	e+CAu4WV6dLoAhcbo+LWO301BZTcIgGVEA4wlFhvwglyKTOG77xb2lewv5AcjKyBVkoNU3oiRPD4r
	kV4T+UNg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW70h-00000007rbE-3uj8;
	Thu, 18 Dec 2025 05:57:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 09/24] NFS: remove NFS_DELEGATION_INODE_FREEING
Date: Thu, 18 Dec 2025 06:56:13 +0100
Message-ID: <20251218055633.1532159-10-hch@lst.de>
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

This essentially reverts commit 6f9449be53f3 ("NFS: Fix a soft lockup in
the delegation recovery code") because the code walking the per-server
delegation list has been fixed to just skip inodes for which
nfs_delegation_grab_inode fails, instead of having to restart the entire
series in commit f92214e4c312 ("NFS: Avoid unnecessary rescanning of the
per-server delegation list").

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 13 ++-----------
 fs/nfs/delegation.h |  1 -
 fs/nfs/nfs4trace.h  |  1 -
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5049c65cc8e5..1ff496147b1e 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -308,8 +308,6 @@ static struct inode *nfs_delegation_grab_inode(struct nfs_delegation *delegation
 	spin_lock(&delegation->lock);
 	if (delegation->inode != NULL)
 		inode = igrab(delegation->inode);
-	if (!inode)
-		set_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags);
 	spin_unlock(&delegation->lock);
 	return inode;
 }
@@ -638,8 +636,6 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 	list_for_each_entry_from_rcu(delegation, &server->delegations, super_list) {
 		struct inode *to_put = NULL;
 
-		if (test_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags))
-			continue;
 		if (!nfs_delegation_need_return(delegation)) {
 			if (nfs4_is_valid_delegation(delegation, 0))
 				prev = delegation;
@@ -760,7 +756,6 @@ void nfs_inode_evict_delegation(struct inode *inode)
 		return;
 
 	set_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
-	set_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags);
 	nfs_do_return_delegation(inode, delegation, 1);
 	nfs_free_delegation(server, delegation);
 }
@@ -1248,9 +1243,7 @@ static int nfs_server_reap_unclaimed_delegations(struct nfs_server *server,
 restart:
 	rcu_read_lock();
 	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
-		if (test_bit(NFS_DELEGATION_INODE_FREEING,
-					&delegation->flags) ||
-		    test_bit(NFS_DELEGATION_RETURNING,
+		if (test_bit(NFS_DELEGATION_RETURNING,
 					&delegation->flags) ||
 		    test_bit(NFS_DELEGATION_NEED_RECLAIM,
 					&delegation->flags) == 0)
@@ -1385,9 +1378,7 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 restart:
 	rcu_read_lock();
 	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
-		if (test_bit(NFS_DELEGATION_INODE_FREEING,
-					&delegation->flags) ||
-		    test_bit(NFS_DELEGATION_RETURNING,
+		if (test_bit(NFS_DELEGATION_RETURNING,
 					&delegation->flags) ||
 		    test_bit(NFS_DELEGATION_TEST_EXPIRED,
 					&delegation->flags) == 0 ||
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 46d866adb5c2..fef1f4126e8f 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -37,7 +37,6 @@ enum {
 	NFS_DELEGATION_RETURNING,
 	NFS_DELEGATION_REVOKED,
 	NFS_DELEGATION_TEST_EXPIRED,
-	NFS_DELEGATION_INODE_FREEING,
 	NFS_DELEGATION_RETURN_DELAYED,
 	NFS_DELEGATION_DELEGTIME,
 };
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 6285128e631a..18d02b4715bb 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -996,7 +996,6 @@ DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_detach_delegation);
 		{ BIT(NFS_DELEGATION_RETURNING), "RETURNING" }, \
 		{ BIT(NFS_DELEGATION_REVOKED), "REVOKED" }, \
 		{ BIT(NFS_DELEGATION_TEST_EXPIRED), "TEST_EXPIRED" }, \
-		{ BIT(NFS_DELEGATION_INODE_FREEING), "INODE_FREEING" }, \
 		{ BIT(NFS_DELEGATION_RETURN_DELAYED), "RETURN_DELAYED" })
 
 DECLARE_EVENT_CLASS(nfs4_delegation_event,
-- 
2.47.3


