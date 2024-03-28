Return-Path: <linux-nfs+bounces-2524-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C0189058C
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 17:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C13C1C20C98
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF57131BDC;
	Thu, 28 Mar 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ke2fbFY6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506113175F
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643775; cv=none; b=gJ6KzGqxVOH8zEsurYHFXk9Y19Dw+rxCVfM/D5faN1fNgrQNqXKMUpVblPZx7qA3U8ZiaqZVDMTnxDoh3gdQXqV+81pMhNfMHhwE0rwq/Wa+3ZChxsEBvMD/vj6LCvnyaMDEbx5sMkYVl87kImU/EYUt+t0cxOi5x77/6FCo00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643775; c=relaxed/simple;
	bh=yhZ/ri6I8ikSOKkUYV9FWFpbnNBbG645GwnJKAI1h8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljfstO48YO2HlZar+CJ0wViRuBfeGiAK9qeQf/5lOFdEPHoKMBttEoo2tmXTLcLpw/ZULKq1XZ/VD2L6T49oJr1Qyxy+386HIiq9Xeqq3qIeac4rK73hvUEcIiZb6ms8NHK+VAmE1EqKV0zJcPIke/mR8IKTY+dkK8YwUhawm9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ke2fbFY6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tuMbXEALtXVN+9DP0lH6KC10UuXzf4Wno0E4exLjO4=;
	b=Ke2fbFY6eJw6E3Cfygtm3WWkF6iJR34JyPKc3FVi/NobJusJNRV4ZsCgfRsZvusViKtDyl
	mhBBo2cp3ZaBzgNz+VkGQB9lCIfskY/EHuKzEZRtGQChky5Ma2oUNxZCs52sI9xtmpgdK0
	g01ZRq7T0fJUH8avMYrbbKidngO082g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-v2ftP5-mM6aZgPoIv__47A-1; Thu, 28 Mar 2024 12:36:05 -0400
X-MC-Unique: v2ftP5-mM6aZgPoIv__47A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DCD0185A784;
	Thu, 28 Mar 2024 16:36:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 83BEC2166B31;
	Thu, 28 Mar 2024 16:36:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/26] netfs: Remove deprecated use of PG_private_2 as a second writeback flag
Date: Thu, 28 Mar 2024 16:33:58 +0000
Message-ID: <20240328163424.2781320-7-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Remove the deprecated use of PG_private_2 in netfslib.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/ceph/addr.c           |  19 +-----
 fs/netfs/buffered_read.c |   8 +--
 fs/netfs/io.c            | 144 ---------------------------------------
 3 files changed, 2 insertions(+), 169 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 75690f969ebc..2d0f13537c85 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -498,11 +498,6 @@ const struct netfs_request_ops ceph_netfs_ops = {
 };
 
 #ifdef CONFIG_CEPH_FSCACHE
-static void ceph_set_page_fscache(struct page *page)
-{
-	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
-}
-
 static void ceph_fscache_write_terminated(void *priv, ssize_t error, bool was_async)
 {
 	struct inode *inode = priv;
@@ -520,10 +515,6 @@ static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, b
 			       ceph_fscache_write_terminated, inode, true, caching);
 }
 #else
-static inline void ceph_set_page_fscache(struct page *page)
-{
-}
-
 static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, bool caching)
 {
 }
@@ -715,8 +706,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		len = wlen;
 
 	set_page_writeback(page);
-	if (caching)
-		ceph_set_page_fscache(page);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
@@ -798,8 +787,6 @@ static int ceph_writepage(struct page *page, struct writeback_control *wbc)
 	    ceph_inode_to_fs_client(inode)->write_congested)
 		return AOP_WRITEPAGE_ACTIVATE;
 
-	folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
-
 	err = writepage_nounlock(page, wbc);
 	if (err == -ERESTARTSYS) {
 		/* direct memory reclaimer was killed by SIGKILL. return 0
@@ -1073,8 +1060,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				unlock_page(page);
 				break;
 			}
-			if (PageWriteback(page) ||
-			    PagePrivate2(page) /* [DEPRECATED] */) {
+			if (PageWriteback(page)) {
 				if (wbc->sync_mode == WB_SYNC_NONE) {
 					doutc(cl, "%p under writeback\n", page);
 					unlock_page(page);
@@ -1082,7 +1068,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 				}
 				doutc(cl, "waiting on writeback %p\n", page);
 				wait_on_page_writeback(page);
-				folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
 			}
 
 			if (!clear_page_dirty_for_io(page)) {
@@ -1267,8 +1252,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 			}
 
 			set_page_writeback(page);
-			if (caching)
-				ceph_set_page_fscache(page);
 			len += thp_size(page);
 		}
 		ceph_fscache_write_to_cache(inode, offset, len, caching);
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index b3fd6e1fa322..1622cce535a3 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -464,7 +464,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	if (!netfs_is_cache_enabled(ctx) &&
 	    netfs_skip_folio_read(folio, pos, len, false)) {
 		netfs_stat(&netfs_n_rh_write_zskip);
-		goto have_folio_no_wait;
+		goto have_folio;
 	}
 
 	rreq = netfs_alloc_request(mapping, file,
@@ -505,12 +505,6 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 
 have_folio:
-	if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags)) {
-		ret = folio_wait_private_2_killable(folio);
-		if (ret < 0)
-			goto error;
-	}
-have_folio_no_wait:
 	*_folio = folio;
 	_leave(" = 0");
 	return 0;
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 60a19f96e0ce..2641238aae82 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -98,146 +98,6 @@ static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
 	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_complete);
 }
 
-/*
- * [DEPRECATED] Deal with the completion of writing the data to the cache.  We
- * have to clear the PG_fscache bits on the folios involved and release the
- * caller's ref.
- *
- * May be called in softirq mode and we inherit a ref from the caller.
- */
-static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
-					  bool was_async)
-{
-	struct netfs_io_subrequest *subreq;
-	struct folio *folio;
-	pgoff_t unlocked = 0;
-	bool have_unlocked = false;
-
-	rcu_read_lock();
-
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		XA_STATE(xas, &rreq->mapping->i_pages, subreq->start / PAGE_SIZE);
-
-		xas_for_each(&xas, folio, (subreq->start + subreq->len - 1) / PAGE_SIZE) {
-			if (xas_retry(&xas, folio))
-				continue;
-
-			/* We might have multiple writes from the same huge
-			 * folio, but we mustn't unlock a folio more than once.
-			 */
-			if (have_unlocked && folio->index <= unlocked)
-				continue;
-			unlocked = folio_next_index(folio) - 1;
-			trace_netfs_folio(folio, netfs_folio_trace_end_copy);
-			folio_end_private_2(folio);
-			have_unlocked = true;
-		}
-	}
-
-	rcu_read_unlock();
-	netfs_rreq_completed(rreq, was_async);
-}
-
-static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
-				       bool was_async) /* [DEPRECATED] */
-{
-	struct netfs_io_subrequest *subreq = priv;
-	struct netfs_io_request *rreq = subreq->rreq;
-
-	if (IS_ERR_VALUE(transferred_or_error)) {
-		netfs_stat(&netfs_n_rh_write_failed);
-		trace_netfs_failure(rreq, subreq, transferred_or_error,
-				    netfs_fail_copy_to_cache);
-	} else {
-		netfs_stat(&netfs_n_rh_write_done);
-	}
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
-
-	/* If we decrement nr_copy_ops to 0, the ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_copy_ops))
-		netfs_rreq_unmark_after_write(rreq, was_async);
-
-	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
-}
-
-/*
- * [DEPRECATED] Perform any outstanding writes to the cache.  We inherit a ref
- * from the caller.
- */
-static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-	struct netfs_io_subrequest *subreq, *next, *p;
-	struct iov_iter iter;
-	int ret;
-
-	trace_netfs_rreq(rreq, netfs_rreq_trace_copy);
-
-	/* We don't want terminating writes trying to wake us up whilst we're
-	 * still going through the list.
-	 */
-	atomic_inc(&rreq->nr_copy_ops);
-
-	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
-		if (!test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
-			list_del_init(&subreq->rreq_link);
-			netfs_put_subrequest(subreq, false,
-					     netfs_sreq_trace_put_no_copy);
-		}
-	}
-
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		/* Amalgamate adjacent writes */
-		while (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
-			next = list_next_entry(subreq, rreq_link);
-			if (next->start != subreq->start + subreq->len)
-				break;
-			subreq->len += next->len;
-			list_del_init(&next->rreq_link);
-			netfs_put_subrequest(next, false,
-					     netfs_sreq_trace_put_merged);
-		}
-
-		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
-					       subreq->len, rreq->i_size, true);
-		if (ret < 0) {
-			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
-			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
-			continue;
-		}
-
-		iov_iter_xarray(&iter, ITER_SOURCE, &rreq->mapping->i_pages,
-				subreq->start, subreq->len);
-
-		atomic_inc(&rreq->nr_copy_ops);
-		netfs_stat(&netfs_n_rh_write);
-		netfs_get_subrequest(subreq, netfs_sreq_trace_get_copy_to_cache);
-		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
-		cres->ops->write(cres, subreq->start, &iter,
-				 netfs_rreq_copy_terminated, subreq);
-	}
-
-	/* If we decrement nr_copy_ops to 0, the usage ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_copy_ops))
-		netfs_rreq_unmark_after_write(rreq, false);
-}
-
-static void netfs_rreq_write_to_cache_work(struct work_struct *work) /* [DEPRECATED] */
-{
-	struct netfs_io_request *rreq =
-		container_of(work, struct netfs_io_request, work);
-
-	netfs_rreq_do_write_to_cache(rreq);
-}
-
-static void netfs_rreq_write_to_cache(struct netfs_io_request *rreq) /* [DEPRECATED] */
-{
-	rreq->work.func = netfs_rreq_write_to_cache_work;
-	if (!queue_work(system_unbound_wq, &rreq->work))
-		BUG();
-}
-
 /*
  * Handle a short read.
  */
@@ -410,10 +270,6 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
 
-	if (test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags) &&
-	    test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags))
-		return netfs_rreq_write_to_cache(rreq);
-
 	netfs_rreq_completed(rreq, was_async);
 }
 


