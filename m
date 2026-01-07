Return-Path: <linux-nfs+bounces-17532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C58CFC573
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D14B6302E84F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7C27FB3E;
	Wed,  7 Jan 2026 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lns+r4lf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066AD230BCC
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770883; cv=none; b=T83rzPMkUctzY23sRAxnk8pUTfBqKiuv13U3oUCqkHM/1AA14nuFzH0RKeoMSwIlb3wa45j5QOK4WUNtCk19XyOcjyRA3uzpWIdGJ1/RbS5HlquVL6/3q45pZzw+tMa8MbLxctHVIB/qRh+NCzwgLIgwMUB8+feYDnJ54OqDtbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770883; c=relaxed/simple;
	bh=/LvwrkOLcrb6zFr0suU7Zz2m8oUWSTZ1D50bmG0baxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOiglZ7fWP45zW1/rSuzdwjYxnZF/DzyBeeafDEx7zHzva1jjztIZpCZo9sm69sXy1iOHwR3FL7ElttEdyZOnpUyyga8zeMIBUv6gq9FREQjC6j1SAv4YgGRSyzSDkIr9FYL7aTz0VDLbmxJhr51XQeJzzJEyZCJhjzQZ1Bf2qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lns+r4lf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qfiiMPI+K2S+zq1Q6bmAkU1N3NIh8s2JLeWLvwV+jrI=; b=Lns+r4lf+PdpNBqgVWrQF5M2um
	emcmBwud38nD13xsjrt8B6niXMihULog+flYfMY93dR0rr/qwbvKFMkTmA17UNnZHJEh8sEpSonNk
	GilDQjyPaGEjX569T+GsvIIASqvQhxSU5SXZ/w3aeR7Cn1KMEQfjVDUttvF6BSuBdryweINLjOIra
	AVF9juUDYcQVAyNECm5osik6gJFQ7ujo58Yvj4yCe0mu2nrmfFRDIYzLxVgbSivCpUUv3vloyWew7
	6NCp0IQ5VupacNI85eZKLvsWvHoT7p4+7ZAHmaVjaLApftaYZ0IAMUazrIWo8AAAgBm1NJ56KyS7t
	FWaiqd1A==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNxZ-0000000EHlv-0X5M;
	Wed, 07 Jan 2026 07:28:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 10/24] NFS: open code nfs_delegation_need_return
Date: Wed,  7 Jan 2026 08:27:01 +0100
Message-ID: <20260107072720.1744129-11-hch@lst.de>
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


