Return-Path: <linux-nfs+bounces-22577-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zaJhMGMhMWrWcAUAu9opvQ
	(envelope-from <linux-nfs+bounces-22577-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:11:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 653B468E039
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:11:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IkoWK95w;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22577-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22577-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F902303C290
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E388842B728;
	Tue, 16 Jun 2026 10:09:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E3427A19
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 10:09:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604584; cv=none; b=hElD32cckNWHLk40nQ07GXcW1oDfcb1qVfdXbMEqAEzTIiM/MceDIqh6fd+thbzLzZW9psmKSLq839JnSJU+2ab+VoNKKhFzAuZyK1vyKsJBdd1IQm0CZwbQKClq8+fTC8KR6nh/OeLleoqXiySU1UAaKAFeSi0q/m1dFQOK9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604584; c=relaxed/simple;
	bh=csGxwfZizNW1/t4GkujfIIzUaSiVfhHpBwMguqwCbUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulUQDf7rR0ZBhjhKckXgpNbdiT25JC78ZBjGytyT/5gHVJ9b4kE4F3mqHncgdlvikVTbCia582iAGDUOa2GLSleowaysLa0gdAWfo5PTyxHuK6fOYNROckgCEuNWpzKRWHoF5lNp2mu8tTFji7bi/wZzZSn1GRJXnqAfOsCA3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkoWK95w; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781604582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3yqQnrBb5ZFXkKQ0iltvpy84r+/Zb1MStoMVvStufg=;
	b=IkoWK95wTortJGQ+E+n5onUqv40UX1DH7sCMt244PXn6NtCYiioZ9/v+CGm8Jb02cm9hse
	cI+bs0IIcnAmmpWYHu/Lace1Mtchl38r9Mk4DWNJ+Ejn3TNNl+FLPp48PcHdcYYUJzKmCN
	6B5fTPFYBV6HclFgtQ+dvdQ0Ha7wsRc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-Mp33TBgtMmuYFArmISakog-1; Tue,
 16 Jun 2026 06:09:36 -0400
X-MC-Unique: Mp33TBgtMmuYFArmISakog-1
X-Mimecast-MFC-AGG-ID: Mp33TBgtMmuYFArmISakog_1781604574
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB17E1955F07;
	Tue, 16 Jun 2026 10:09:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 840881954112;
	Tue, 16 Jun 2026 10:09:27 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/30] netfs: Replace wb_lock with a bit lock for asynchronicity
Date: Tue, 16 Jun 2026 11:07:56 +0100
Message-ID: <20260616100821.2062304-8-dhowells@redhat.com>
In-Reply-To: <20260616100821.2062304-1-dhowells@redhat.com>
References: <20260616100821.2062304-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-22577-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,manguebit.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 653B468E039

The netfs_inode::wb_lock mutex is used to prevent multiple simultaneous
writebacks from fighting each other (a writeback thread will write multiple
discontiguous regions within the same request).  The mutex, however, only
serialises the issuing of subrequests; it doesn't serialise the collection
of results, and, in particular, the updating of file size information and
fscache populatedness data.

Unfortunately, the mutex cannot be held around the entire process as it has
to be unlocked in the same thread in which it is locked - and we don't want
to hold up the allocator whilst we complete the writeback.

Fix this by replacing the mutex with a bit flag and a list of lock waiters
so that the lock can be dropped in the collector thread after collection is
complete.

Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/symlink.c         |  4 +-
 fs/netfs/locking.c       | 95 ++++++++++++++++++++++++++++++++++++++++
 fs/netfs/write_collect.c |  2 +
 fs/netfs/write_issue.c   | 36 ++++-----------
 include/linux/netfs.h    | 11 ++++-
 5 files changed, 116 insertions(+), 32 deletions(-)

diff --git a/fs/afs/symlink.c b/fs/afs/symlink.c
index ed5868369f37..16b4823cb7b7 100644
--- a/fs/afs/symlink.c
+++ b/fs/afs/symlink.c
@@ -255,11 +255,11 @@ int afs_symlink_writepages(struct address_space *mapping,
 	}
 
 	if (ret == 0) {
-		mutex_lock(&vnode->netfs.wb_lock);
+		netfs_wb_begin(&vnode->netfs, false);
 		netfs_free_folioq_buffer(vnode->directory);
 		vnode->directory = NULL;
 		vnode->directory_size = 0;
-		mutex_unlock(&vnode->netfs.wb_lock);
+		netfs_wb_end(&vnode->netfs);
 	} else if (ret == 1) {
 		ret = 0; /* Skipped write due to lock conflict. */
 	}
diff --git a/fs/netfs/locking.c b/fs/netfs/locking.c
index 2249ecd09d0a..4e3be2b81504 100644
--- a/fs/netfs/locking.c
+++ b/fs/netfs/locking.c
@@ -9,6 +9,11 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+struct netfs_wb_waiter {
+	struct list_head	link;		/* Link in ictx->wb_queue */
+	struct task_struct	*waiter;	/* Waiter task; cleared when lock granted */
+};
+
 /*
  * inode_dio_wait_interruptible - wait for outstanding DIO requests to finish
  * @inode: inode to wait for
@@ -203,3 +208,93 @@ void netfs_end_io_direct(struct inode *inode)
 	up_read(&inode->i_rwsem);
 }
 EXPORT_SYMBOL(netfs_end_io_direct);
+
+/*
+ * Wait to have exclusive access to writeback.
+ */
+static bool netfs_wb_begin_wait(struct netfs_inode *ictx)
+{
+	struct netfs_wb_waiter waiter = {};
+	struct task_struct *tsk = current;
+	bool got = false;
+
+	spin_lock(&ictx->lock);
+
+	if (test_and_set_bit_lock(NETFS_ICTX_WB_LOCK, &ictx->flags)) {
+		get_task_struct(tsk);
+		waiter.waiter = tsk;
+		list_add_tail(&waiter.link, &ictx->wb_queue);
+	} else {
+		got = true;
+	}
+	spin_unlock(&ictx->lock);
+
+	if (!got) {
+		for (;;) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			/* Read waiter before accessing inode state. */
+			if (smp_load_acquire(&waiter.waiter) == NULL)
+				break;
+			schedule();
+		}
+	}
+	__set_current_state(TASK_RUNNING);
+	return true;
+}
+
+/**
+ * netfs_wb_begin - Begin writeback, waiting if need be
+ * @ictx: The inode to get writeback access on
+ * @nowait: Return failure immediately rather than waiting if true
+ *
+ * Begin writeback to an inode, waiting for exclusive access if @nowait is
+ * false.  This prevents collection from being done out of order with respect
+ * to the issuance of write subrequests.
+ *
+ * Note that writeback may be ended in a different process (e.g. the collection
+ * function on a workqueue) than started it.
+ *
+ * Return: True if can proceed, false if denied.
+ */
+bool netfs_wb_begin(struct netfs_inode *ictx, bool nowait)
+{
+	if (!test_and_set_bit_lock(NETFS_ICTX_WB_LOCK, &ictx->flags))
+		return true;
+	if (nowait) {
+		netfs_stat(&netfs_n_wb_lock_skip);
+		return false;
+	}
+	netfs_stat(&netfs_n_wb_lock_wait);
+	return netfs_wb_begin_wait(ictx);
+}
+EXPORT_SYMBOL(netfs_wb_begin);
+
+/* netfs_wb_end - End writeback
+ * @ictx: The inode we have writeback access to
+ *
+ * End writeback access on an inode, waking up the next writeback request.
+ */
+void netfs_wb_end(struct netfs_inode *ictx)
+{
+	struct netfs_wb_waiter *waiter;
+	struct task_struct *tsk;
+
+	WARN_ON_ONCE(!test_bit(NETFS_ICTX_WB_LOCK, &ictx->flags));
+
+	spin_lock(&ictx->lock);
+
+	waiter = list_first_entry_or_null(&ictx->wb_queue, struct netfs_wb_waiter, link);
+	if (waiter) {
+		list_del(&waiter->link);
+		tsk = waiter->waiter;
+		/* Write inode state before clearing waiter. */
+		smp_store_release(&waiter->waiter, NULL);
+		wake_up_process(tsk);
+		put_task_struct(tsk);
+	} else {
+		clear_bit_unlock(NETFS_ICTX_WB_LOCK, &ictx->flags);
+	}
+
+	spin_unlock(&ictx->lock);
+}
+EXPORT_SYMBOL(netfs_wb_end);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 24fc2bb2f8a4..61e2d1e8891e 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -408,6 +408,8 @@ bool netfs_write_collection(struct netfs_io_request *wreq)
 	netfs_wake_rreq_flag(wreq, NETFS_RREQ_IN_PROGRESS, netfs_rreq_trace_wake_ip);
 	/* As we cleared NETFS_RREQ_IN_PROGRESS, we acquired its ref. */
 
+	netfs_wb_end(ictx);
+
 	if (wreq->iocb) {
 		size_t written = min(wreq->transferred, wreq->len);
 		wreq->iocb->ki_pos += written;
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index c03c7cc45e47..3454e8b0c248 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -551,14 +551,8 @@ int netfs_writepages(struct address_space *mapping,
 	struct folio *folio;
 	int error = 0;
 
-	if (!mutex_trylock(&ictx->wb_lock)) {
-		if (wbc->sync_mode == WB_SYNC_NONE) {
-			netfs_stat(&netfs_n_wb_lock_skip);
-			return 0;
-		}
-		netfs_stat(&netfs_n_wb_lock_wait);
-		mutex_lock(&ictx->wb_lock);
-	}
+	if (!netfs_wb_begin(ictx, wbc->sync_mode == WB_SYNC_NONE))
+		return 0;
 
 	/* Need the first folio to be able to set up the op. */
 	folio = writeback_iter(mapping, wbc, NULL, &error);
@@ -593,8 +587,6 @@ int netfs_writepages(struct address_space *mapping,
 	} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
 
 	netfs_end_issue_write(wreq);
-
-	mutex_unlock(&ictx->wb_lock);
 	netfs_wake_collector(wreq);
 
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
@@ -604,7 +596,7 @@ int netfs_writepages(struct address_space *mapping,
 couldnt_start:
 	netfs_kill_dirty_pages(mapping, wbc, folio);
 out:
-	mutex_unlock(&ictx->wb_lock);
+	netfs_wb_end(ictx);
 	_leave(" = %d", error);
 	return error;
 }
@@ -618,12 +610,12 @@ struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len
 	struct netfs_io_request *wreq = NULL;
 	struct netfs_inode *ictx = netfs_inode(file_inode(iocb->ki_filp));
 
-	mutex_lock(&ictx->wb_lock);
+	netfs_wb_begin(ictx, false);
 
 	wreq = netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_filp,
 				      iocb->ki_pos, NETFS_WRITETHROUGH);
 	if (IS_ERR(wreq)) {
-		mutex_unlock(&ictx->wb_lock);
+		netfs_wb_end(ictx);
 		return wreq;
 	}
 
@@ -685,7 +677,6 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
 ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
 			       struct folio *writethrough_cache)
 {
-	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	ssize_t ret;
 
 	_enter("R=%x", wreq->debug_id);
@@ -699,8 +690,6 @@ ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_c
 
 	netfs_end_issue_write(wreq);
 
-	mutex_unlock(&ictx->wb_lock);
-
 	if (wreq->iocb)
 		ret = -EIOCBQUEUED;
 	else
@@ -847,16 +836,8 @@ int netfs_writeback_single(struct address_space *mapping,
 	if (WARN_ON_ONCE(!iov_iter_is_folioq(iter)))
 		return -EIO;
 
-	if (!mutex_trylock(&ictx->wb_lock)) {
-		if (wbc->sync_mode == WB_SYNC_NONE) {
-			/* The VFS will have undirtied the inode. */
-			netfs_single_mark_inode_dirty(&ictx->inode);
-			netfs_stat(&netfs_n_wb_lock_skip);
-			return 1;
-		}
-		netfs_stat(&netfs_n_wb_lock_wait);
-		mutex_lock(&ictx->wb_lock);
-	}
+	if (!netfs_wb_begin(ictx, wbc->sync_mode == WB_SYNC_NONE))
+		return 1;
 
 	wreq = netfs_create_write_req(mapping, NULL, 0, NETFS_WRITEBACK_SINGLE);
 	if (IS_ERR(wreq)) {
@@ -893,7 +874,6 @@ int netfs_writeback_single(struct address_space *mapping,
 	smp_wmb(); /* Write lists before ALL_QUEUED. */
 	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
 
-	mutex_unlock(&ictx->wb_lock);
 	netfs_wake_collector(wreq);
 
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
@@ -901,7 +881,7 @@ int netfs_writeback_single(struct address_space *mapping,
 	return ret;
 
 couldnt_start:
-	mutex_unlock(&ictx->wb_lock);
+	netfs_wb_end(ictx);
 	_leave(" = %d", ret);
 	return ret;
 }
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 243c0f737938..06e6cceffaeb 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -61,14 +61,16 @@ struct netfs_inode {
 #if IS_ENABLED(CONFIG_FSCACHE)
 	struct fscache_cookie	*cache;
 #endif
-	struct mutex		wb_lock;	/* Writeback serialisation */
+	struct list_head	wb_queue;	/* Queue of processes wanting to do writeback */
 	loff_t			_remote_i_size;	/* Size of the remote file */
 	loff_t			_zero_point;	/* Size after which we assume there's no data
 						 * on the server */
+	spinlock_t		lock;		/* Lock covering wb_queue */
 	atomic_t		io_count;	/* Number of outstanding reqs */
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
+#define NETFS_ICTX_WB_LOCK	2		/* Writeback serialisation lock */
 #define NETFS_ICTX_MODIFIED_ATTR 3		/* Indicate change in mtime/ctime */
 #define NETFS_ICTX_SINGLE_NO_UPLOAD 4		/* Monolithic payload, cache but no upload */
 };
@@ -462,6 +464,10 @@ int netfs_alloc_folioq_buffer(struct address_space *mapping,
 			      size_t *_cur_size, ssize_t size, gfp_t gfp);
 void netfs_free_folioq_buffer(struct folio_queue *fq);
 
+/* Writeback exclusion API. */
+bool netfs_wb_begin(struct netfs_inode *ictx, bool nowait);
+void netfs_wb_end(struct netfs_inode *ictx);
+
 /**
  * netfs_inode - Get the netfs inode context from the inode
  * @inode: The inode to query
@@ -743,7 +749,8 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 #if IS_ENABLED(CONFIG_FSCACHE)
 	ctx->cache = NULL;
 #endif
-	mutex_init(&ctx->wb_lock);
+	INIT_LIST_HEAD(&ctx->wb_queue);
+	spin_lock_init(&ctx->lock);
 	/* ->releasepage() drives zero_point */
 	if (use_zero_point) {
 		ctx->_zero_point = ctx->_remote_i_size;


