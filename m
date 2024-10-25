Return-Path: <linux-nfs+bounces-7476-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C369B100D
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 22:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654A81F210A9
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C410B217473;
	Fri, 25 Oct 2024 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVwaldMl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760E1215C49
	for <linux-nfs@vger.kernel.org>; Fri, 25 Oct 2024 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888845; cv=none; b=CFmn+nTQXa2LTwTqT/FQp9dT7i37V0HD4RW9raZLchLVcApvAF+KwMCdeslH1E6psfAEErVFL+KokJt+lFusvSyc/BQC8jLMItC2zFALlJC1ftbw6PubLHfM3TeFQbGxNt+HdrLBdbrcGKu+WNjc41j8ROxEagothxDxqU78uaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888845; c=relaxed/simple;
	bh=IB2Hra3PbQqimrEPUTwV6xl6xpFuitl8Oqr5TkFFgbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDhTE/AgmFIIc7iAZ/0yQdF9p5ePF7n6r2n3iRWeHMHkUzcWeFwe0Xaj4PRqaYF3tW0+7XW1Jn+S5sUBl2RTiNqzZPJAdpzy8KrBHva7LEzm0dV7y0vlq9QE9sYTAsFZkouyvS2XdhgyDdEDc8v5a9tJIhjtlmSSEx+WBzzMGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVwaldMl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729888842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRktXy0njOtGduc146rNPLaeznRZ8wjmjmNrqe7WMw8=;
	b=YVwaldMlJ1mV5AGQdq7sSR8aFLUopK9lnMRXXCDLiMO97vG8HIJZHnQDI/mAjftBpoOd1F
	SHi33qEUDCYm3ghyNMco/ysJ9d1d0U31S9XE9WTviIlee8oZCawOXq/glwEQjmwOTr4ZVs
	pF9ax3VJA+9bm5LqE5Z6xpLXzSyyM5M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-I-woFilEPvO9_HXQVgfWRQ-1; Fri,
 25 Oct 2024 16:40:39 -0400
X-MC-Unique: I-woFilEPvO9_HXQVgfWRQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 873CC1955D9D;
	Fri, 25 Oct 2024 20:40:35 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 304551956088;
	Fri, 25 Oct 2024 20:40:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 02/31] netfs: Fix a few minor bugs in netfs_page_mkwrite()
Date: Fri, 25 Oct 2024 21:39:29 +0100
Message-ID: <20241025204008.4076565-3-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

We can't return with VM_FAULT_SIGBUS | VM_FAULT_LOCKED; the core
code will not unlock the folio in this instance.  Introduce a new
"unlock" error exit to handle this case.  Use it to handle
the "folio is truncated" check, and change the "writeback interrupted
by a fatal signal" to do a NOPAGE exit instead of letting the core
code install the folio currently under writeback before killing the
process.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20241005182307.3190401-3-willy@infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/netfs/buffered_write.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index b3910dfcb56d..ff2814da88b1 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -491,7 +491,9 @@ EXPORT_SYMBOL(netfs_file_write_iter);
 
 /*
  * Notification that a previously read-only page is about to become writable.
- * Note that the caller indicates a single page of a multipage folio.
+ * The caller indicates the precise page that needs to be written to, but
+ * we only track group on a per-folio basis, so we block more often than
+ * we might otherwise.
  */
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group)
 {
@@ -501,7 +503,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = file_inode(file);
 	struct netfs_inode *ictx = netfs_inode(inode);
-	vm_fault_t ret = VM_FAULT_RETRY;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
 	int err;
 
 	_enter("%lx", folio->index);
@@ -510,21 +512,15 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 
 	if (folio_lock_killable(folio) < 0)
 		goto out;
-	if (folio->mapping != mapping) {
-		folio_unlock(folio);
-		ret = VM_FAULT_NOPAGE;
-		goto out;
-	}
-
-	if (folio_wait_writeback_killable(folio)) {
-		ret = VM_FAULT_LOCKED;
-		goto out;
-	}
+	if (folio->mapping != mapping)
+		goto unlock;
+	if (folio_wait_writeback_killable(folio) < 0)
+		goto unlock;
 
 	/* Can we see a streaming write here? */
 	if (WARN_ON(!folio_test_uptodate(folio))) {
-		ret = VM_FAULT_SIGBUS | VM_FAULT_LOCKED;
-		goto out;
+		ret = VM_FAULT_SIGBUS;
+		goto unlock;
 	}
 
 	group = netfs_folio_group(folio);
@@ -559,5 +555,8 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 out:
 	sb_end_pagefault(inode->i_sb);
 	return ret;
+unlock:
+	folio_unlock(folio);
+	goto out;
 }
 EXPORT_SYMBOL(netfs_page_mkwrite);


