Return-Path: <linux-nfs+bounces-17533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D993FCFC579
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E6D33008C6F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E121A275AFD;
	Wed,  7 Jan 2026 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VzA0UdYz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE127F727
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770886; cv=none; b=bWzeDY35oI2M2/9hJL6k6gaiL0KJR40kCYnbdfuJXX9r9KZpOiCuUto+ePNq4enuNGpVeJr+uNRah8eUrKz+DW3HKr/aTcDswRMRF3+m1vy59dKsogi+RGXaHvOMr8wRQOKFlPJpqgRhDIkZ5wPCY+NLblNF4Fl/3GVCRtxYwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770886; c=relaxed/simple;
	bh=YnP/GpA9Hjd9kxsjuSyAh3wm1LskCbjtJwbbfCAlD4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjNvLPojdZ69a6192a9Dn8+anFrKkq4ajp1nhOtedZKSRM/cEGJ37wRMvgDa3SdkO7C0hZgu/Mxdhf+V635mh/zcuETAlMgcmrLt4RtD6YonVIiVqensCrKK435YQAYlnLMsetafi+7fryRefd5THAMZI2qxUq9Nn5Uf9YScNqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VzA0UdYz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+X7JTByRyZqYCx8KdUhfrjcaLd1RKUSVHjbctAhECWU=; b=VzA0UdYzIP/c7+G++GNa7/kapn
	ZrQTjOH4d1aUavC1z40ujRKL07uSG9Y4eEgWiQjGCiQGv4J0siafEHF8dqCV5jKRpJOoBGc+FcnsZ
	TcTibkQ1eTPLAGMUx1R1rZkBhLfxsEBLpSHscgwLv9IfNjsGDnjVKSky7CNlCVOwC2j8urf4ak84K
	9fe5D/hAlH1moLZezXUTl8IX+EyW/oCGvsM1NyS44YNAm4AjK2uzlZcoCLqwIZgqkercDv99dJZ1V
	0zKTXlaQ6wpg6TeA4q8pRMpWF+z3YDi4MTxowyFBZTZDjwS51zlArVpBAO2J88dEMiXklSflJyXr5
	4jV9eKfQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNxc-0000000EHm9-2V2V;
	Wed, 07 Jan 2026 07:28:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 11/24] NFS: remove nfs_free_delegation
Date: Wed,  7 Jan 2026 08:27:02 +0100
Message-ID: <20260107072720.1744129-12-hch@lst.de>
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

Open code nfs_free_delegation in the callers, because having a "free"
function that wraps a revoke and put operation is a bit confusing,
especially when the __free version does the actual freeing triggered by
the last put.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 3c50a1467022..96812d599400 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -72,13 +72,6 @@ static void nfs_put_delegation(struct nfs_delegation *delegation)
 		__nfs_free_delegation(delegation);
 }
 
-static void nfs_free_delegation(struct nfs_server *server,
-		struct nfs_delegation *delegation)
-{
-	nfs_mark_delegation_revoked(server, delegation);
-	nfs_put_delegation(delegation);
-}
-
 /**
  * nfs_mark_delegation_referenced - set delegation's REFERENCED flag
  * @delegation: delegation to process
@@ -539,7 +532,8 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 		__nfs_free_delegation(delegation);
 	if (freeme != NULL) {
 		nfs_do_return_delegation(inode, freeme, 0);
-		nfs_free_delegation(server, freeme);
+		nfs_mark_delegation_revoked(server, freeme);
+		nfs_put_delegation(freeme);
 	}
 	return status;
 }
@@ -747,7 +741,8 @@ void nfs_inode_evict_delegation(struct inode *inode)
 
 	set_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
 	nfs_do_return_delegation(inode, delegation, 1);
-	nfs_free_delegation(server, delegation);
+	nfs_mark_delegation_revoked(server, delegation);
+	nfs_put_delegation(delegation);
 }
 
 /**
@@ -1245,8 +1240,10 @@ static int nfs_server_reap_unclaimed_delegations(struct nfs_server *server,
 		rcu_read_unlock();
 		if (delegation != NULL) {
 			if (nfs_detach_delegation(NFS_I(inode), delegation,
-						server) != NULL)
-				nfs_free_delegation(server, delegation);
+						server) != NULL) {
+				nfs_mark_delegation_revoked(server, delegation);
+				nfs_put_delegation(delegation);
+			}
 			/* Match nfs_start_delegation_return */
 			nfs_put_delegation(delegation);
 		}
-- 
2.47.3


