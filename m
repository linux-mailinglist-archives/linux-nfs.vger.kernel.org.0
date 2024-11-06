Return-Path: <linux-nfs+bounces-7696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361B99BEA4A
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 13:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5AB2832B3
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF241F81BF;
	Wed,  6 Nov 2024 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jk+n5r7l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E621E9096
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896673; cv=none; b=q4P+TgTiT4wyErsmvxfaBzXx7e/Enxes/2JcVSwZhGSkfuufaroQOv+s0blJzhBSBm0xeWQ3LL3HrqbB2HxSMLTsmtOxQ7UeDKffW59xipNb3iw+NjA34vJMsRpJ85Exu1qZQDdCTxNKgtinNoCdRNrRPDCG0JjKVuL8E3kNEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896673; c=relaxed/simple;
	bh=XSUYCsMsgwi1gQYDUg7XDOQ/HEYXd2QU0fHMI91b11c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUot/YAEfss99BYHwPyESvLT9f+j6cd+NENjCCloG+5g2EFHpLliPczJwjGcHac0vl9fKc/TmeDcJxK6GFoMD1i1e3v29ohCBX7KWfc6nZ/oLuebaKtPWOshfd34GO8dE+vbLeco3wqo13ea+atB5jdFHu1hoaAlTIX72I1wiu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jk+n5r7l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gu5E8tyC96H9fpVehZhchYQCXTYRja375CBx48Z0WNk=;
	b=Jk+n5r7lxsEFfIOo0PH59VADyhOMAMTcNpLJXE580LTWD4Uc8K5uGSUtsZwjgOhr31g42p
	LpIpNWP4JCRMQSPwe1HQDcp4MjrPxogMCqU7aRF2ouP/FM+3y/z7eLJX5ctg89katd/nJ5
	YiakzPS0qGB99FdixviDNb6QQwnhpnQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-35pXC0kaN6G_f6fe5nn40A-1; Wed,
 06 Nov 2024 07:37:46 -0500
X-MC-Unique: 35pXC0kaN6G_f6fe5nn40A-1
X-Mimecast-MFC-AGG-ID: 35pXC0kaN6G_f6fe5nn40A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACA81195608C;
	Wed,  6 Nov 2024 12:37:43 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7463B19541A5;
	Wed,  6 Nov 2024 12:37:37 +0000 (UTC)
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
	linux-cachefs@redhat.com
Subject: [PATCH v3 12/33] netfs: Don't use bh spinlock
Date: Wed,  6 Nov 2024 12:35:36 +0000
Message-ID: <20241106123559.724888-13-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

All the accessing of the subrequest lists is now done in process context,
possibly in a workqueue, but not now in a BH context, so we don't need the
lock against BH interference when taking the netfs_io_request::lock
spinlock.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_read.c |  4 ++--
 fs/netfs/direct_read.c   |  4 ++--
 fs/netfs/read_collect.c  | 20 ++++++++++----------
 fs/netfs/read_retry.c    |  8 ++++----
 fs/netfs/write_collect.c |  4 ++--
 fs/netfs/write_issue.c   |  4 ++--
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 6fd4f3bef3b4..4a48b79b8807 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -200,12 +200,12 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		subreq->len	= size;
 
 		atomic_inc(&rreq->nr_outstanding);
-		spin_lock_bh(&rreq->lock);
+		spin_lock(&rreq->lock);
 		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 		subreq->prev_donated = rreq->prev_donated;
 		rreq->prev_donated = 0;
 		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-		spin_unlock_bh(&rreq->lock);
+		spin_unlock(&rreq->lock);
 
 		source = netfs_cache_prepare_read(rreq, subreq, rreq->i_size);
 		subreq->source = source;
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 54027fd14904..1a20cc3979c7 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -68,12 +68,12 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 		subreq->len	= size;
 
 		atomic_inc(&rreq->nr_outstanding);
-		spin_lock_bh(&rreq->lock);
+		spin_lock(&rreq->lock);
 		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 		subreq->prev_donated = rreq->prev_donated;
 		rreq->prev_donated = 0;
 		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-		spin_unlock_bh(&rreq->lock);
+		spin_unlock(&rreq->lock);
 
 		netfs_stat(&netfs_n_rh_download);
 		if (rreq->netfs_ops->prepare_read) {
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 146abb2e399a..53ef7e0f3e9c 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -142,7 +142,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 	prev_donated = READ_ONCE(subreq->prev_donated);
 	next_donated =  READ_ONCE(subreq->next_donated);
 	if (prev_donated || next_donated) {
-		spin_lock_bh(&rreq->lock);
+		spin_lock(&rreq->lock);
 		prev_donated = subreq->prev_donated;
 		next_donated =  subreq->next_donated;
 		subreq->start -= prev_donated;
@@ -155,7 +155,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 			next_donated = subreq->next_donated = 0;
 		}
 		trace_netfs_sreq(subreq, netfs_sreq_trace_add_donations);
-		spin_unlock_bh(&rreq->lock);
+		spin_unlock(&rreq->lock);
 	}
 
 	avail = subreq->transferred;
@@ -184,18 +184,18 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 		} else if (fpos < start) {
 			excess = fend - subreq->start;
 
-			spin_lock_bh(&rreq->lock);
+			spin_lock(&rreq->lock);
 			/* If we complete first on a folio split with the
 			 * preceding subreq, donate to that subreq - otherwise
 			 * we get the responsibility.
 			 */
 			if (subreq->prev_donated != prev_donated) {
-				spin_unlock_bh(&rreq->lock);
+				spin_unlock(&rreq->lock);
 				goto donation_changed;
 			}
 
 			if (list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
-				spin_unlock_bh(&rreq->lock);
+				spin_unlock(&rreq->lock);
 				pr_err("Can't donate prior to front\n");
 				goto bad;
 			}
@@ -211,7 +211,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 
 			if (subreq->consumed >= subreq->len)
 				goto remove_subreq_locked;
-			spin_unlock_bh(&rreq->lock);
+			spin_unlock(&rreq->lock);
 		} else {
 			pr_err("fpos > start\n");
 			goto bad;
@@ -239,11 +239,11 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 	/* Donate the remaining downloaded data to one of the neighbouring
 	 * subrequests.  Note that we may race with them doing the same thing.
 	 */
-	spin_lock_bh(&rreq->lock);
+	spin_lock(&rreq->lock);
 
 	if (subreq->prev_donated != prev_donated ||
 	    subreq->next_donated != next_donated) {
-		spin_unlock_bh(&rreq->lock);
+		spin_unlock(&rreq->lock);
 		cond_resched();
 		goto donation_changed;
 	}
@@ -293,11 +293,11 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 	goto remove_subreq_locked;
 
 remove_subreq:
-	spin_lock_bh(&rreq->lock);
+	spin_lock(&rreq->lock);
 remove_subreq_locked:
 	subreq->consumed = subreq->len;
 	list_del(&subreq->rreq_link);
-	spin_unlock_bh(&rreq->lock);
+	spin_unlock(&rreq->lock);
 	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_consumed);
 	return true;
 
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index d1986cec3db7..264f3cb6a7dc 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -139,12 +139,12 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 
-			spin_lock_bh(&rreq->lock);
+			spin_lock(&rreq->lock);
 			list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 			subreq->prev_donated += rreq->prev_donated;
 			rreq->prev_donated = 0;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
-			spin_unlock_bh(&rreq->lock);
+			spin_unlock(&rreq->lock);
 
 			BUG_ON(!len);
 
@@ -215,9 +215,9 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 		__clear_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 	}
-	spin_lock_bh(&rreq->lock);
+	spin_lock(&rreq->lock);
 	list_splice_tail_init(&queue, &rreq->subrequests);
-	spin_unlock_bh(&rreq->lock);
+	spin_unlock(&rreq->lock);
 }
 
 /*
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 85e8e94da90a..d291b31dd074 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -238,14 +238,14 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 
 		cancel:
 			/* Remove if completely consumed. */
-			spin_lock_bh(&wreq->lock);
+			spin_lock(&wreq->lock);
 
 			remove = front;
 			list_del_init(&front->rreq_link);
 			front = list_first_entry_or_null(&stream->subrequests,
 							 struct netfs_io_subrequest, rreq_link);
 			stream->front = front;
-			spin_unlock_bh(&wreq->lock);
+			spin_unlock(&wreq->lock);
 			netfs_put_subrequest(remove, false,
 					     notes & SAW_FAILURE ?
 					     netfs_sreq_trace_put_cancel :
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index c186221b45c0..10b5300b9448 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -203,7 +203,7 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
 	 * the list.  The collector only goes nextwards and uses the lock to
 	 * remove entries off of the front.
 	 */
-	spin_lock_bh(&wreq->lock);
+	spin_lock(&wreq->lock);
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
 		stream->front = subreq;
@@ -214,7 +214,7 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
 		}
 	}
 
-	spin_unlock_bh(&wreq->lock);
+	spin_unlock(&wreq->lock);
 
 	stream->construct = subreq;
 }


