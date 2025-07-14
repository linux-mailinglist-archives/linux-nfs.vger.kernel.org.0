Return-Path: <linux-nfs+bounces-13035-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A59B03D20
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 13:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938AE16E04D
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 11:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DA9244696;
	Mon, 14 Jul 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LuKBzz/v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8991DE892
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491822; cv=none; b=V8RaPOqdCvqy5Pd35BihaoQ/kLRkVa+w9QwewQActb1PuL15FadZ1pnwd1p3ut03TAoEF6dwLPab8QCwIG9xAjVnrYHsghxYjdo6iEXlvVoY4kNKivbh34F+ZLmh7DbcZ1QwQh9Sk1t+kzfYF8SFWtgMOkPBF1LOfYY55bGVbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491822; c=relaxed/simple;
	bh=cubgpjh8vd+ylzImej4eHntaYeb7cbQYRxfkqdfvdBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcQhflcsc68w0AWV+gT5hg11Dcd9HoGQnVmw5Ad4PEuZAdRTmKQx3ZIcJvaJpXhV6kLwwp6f6MZmJdqpDb44QwLdHEbN1lisIVTbReyee5oZhRBFT3UCne8TVPC02KLoK4thMZ7zNROVIb+ic2mtHYasIgY0XEJhFhq2JlOzKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LuKBzz/v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Er4QLD1ajtxIT6Dd3slUF7TkE2Kz7jOlTrG1/Woiyso=; b=LuKBzz/v6k+jlZMeD/YnZrLPSV
	chtBq/ADy2ZIsniVOFLEiSikXs55OQtC/ziu0RnPVTUlpXMwckDcmw32h34gLGOtopb3DXyCVpxH8
	ATW0hPQPt5vZl08Qcad534utDozKMZPushf6UrRUxR55/Nh3HTn/8z+vkHiRq1gRfS8mZxeNmuitT
	g5peelet55FiOeIcTtaDqhvealiQDJSY+MYmWZJ2XvZhSnFdCxnkzl3LuqHR85Y/rWnj90LpR3lk5
	wDbjSO333UkKhPjHjUY57TJ9fAIDq00i0Uzj0t/XA+WNcwA1yuHM8izNZnsj/abl4pcKH7l1hcBKK
	GjupYpog==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubHB5-000000020qx-3PLW;
	Mon, 14 Jul 2025 11:17:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] NFS: cleanup nfs_inode_reclaim_delegation
Date: Mon, 14 Jul 2025 13:16:28 +0200
Message-ID: <20250714111651.1565055-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714111651.1565055-1-hch@lst.de>
References: <20250714111651.1565055-1-hch@lst.de>
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
---
 fs/nfs/delegation.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 519bdc91112c..56bb2a7e1793 100644
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


