Return-Path: <linux-nfs+bounces-20404-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOm0EYQTxWmr6QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20404-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:07:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A51733340C8
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D02CB3133F5D
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 10:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD7938C2B5;
	Thu, 26 Mar 2026 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZLv6Syv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9E3E6DD2
	for <linux-nfs@vger.kernel.org>; Thu, 26 Mar 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522031; cv=none; b=orUJaQ5/E+wENuRHdDCQhWSUVz6ish21cM77THlGAmWxlq8Lccse1K7rSHLxHZ1pmzGiozxnp1TNFS7JQcItfSjpHSB8tAH3CAc28PEokwKaDarN8cPstznN7DQO0lIDNIuwjWTpFW/xdxJWgmVVS6bOzUdjUFZr/Ga47ManvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522031; c=relaxed/simple;
	bh=JSDeL6SwtVG7tcOuyPSqzZl0BvtjT+R1aGX/1tT+wNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtDQcNO978ZxCo+iNvB1BiT3lmoHNKqunugcx2iEGGIddyeyjSwhFN5pk7AIYGiqMw05L2zPbT4sM0W5PK4l8QOXSzGBSdMK5d8Gtr2zt8l+VpeYfcnpkunjEIP433WO+BoaTXKLi02HL4Ym24ihX9Zn/5f6ggA88ww5nwjFfQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZLv6Syv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tdvGHLBae6cwxkiV/xURdgZGIZUXmsfYZzZeOFw5ZU=;
	b=NZLv6Syv+6d/mRsMu24ch1CtmlR0b895r6hqzTbaR2a2Ei6OsvKntxoK/HtubDnEKLyp51
	G1zGrTreHhSKmkJ3OpBMMOotb4h1fqwrLOgOevzPngn8T0i+IZXs34bwiXbTQGTzawofOQ
	ko//rEVHzguQUMaAz3RJEmgG15rGpMI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-6Q1OkKBWMNewwDpzF46dXQ-1; Thu,
 26 Mar 2026 06:47:02 -0400
X-MC-Unique: 6Q1OkKBWMNewwDpzF46dXQ-1
X-Mimecast-MFC-AGG-ID: 6Q1OkKBWMNewwDpzF46dXQ_1774522020
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1A2819560B4;
	Thu, 26 Mar 2026 10:46:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42F741800673;
	Thu, 26 Mar 2026 10:46:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 06/26] netfs: Fix the handling of stream->front by removing it
Date: Thu, 26 Mar 2026 10:45:21 +0000
Message-ID: <20260326104544.509518-7-dhowells@redhat.com>
In-Reply-To: <20260326104544.509518-1-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20404-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,manguebit.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A51733340C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The netfs_io_stream::front member is meant to point to the subrequest
currently being collected on a stream, but it isn't actually used this way
by direct write (which mostly ignores it).  However, there's a tracepoint
which looks at it.  Further, stream->front is actually redundant with
stream->subrequests.next.

Fix the potential problem in the direct code by just removing the member
and using stream->subrequests.next instead, thereby also simplifying the
code.

Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Reported-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c     | 3 +--
 fs/netfs/direct_read.c       | 3 +--
 fs/netfs/direct_write.c      | 1 -
 fs/netfs/read_collect.c      | 4 ++--
 fs/netfs/read_single.c       | 1 -
 fs/netfs/write_collect.c     | 4 ++--
 fs/netfs/write_issue.c       | 3 +--
 include/linux/netfs.h        | 1 -
 include/trace/events/netfs.h | 8 ++++----
 9 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 88a0d801525f..a8c0d86118c5 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -171,9 +171,8 @@ static void netfs_queue_read(struct netfs_io_request *rreq,
 	spin_lock(&rreq->lock);
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-		stream->front = subreq;
 		if (!stream->active) {
-			stream->collected_to = stream->front->start;
+			stream->collected_to = subreq->start;
 			/* Store list pointers before active flag */
 			smp_store_release(&stream->active, true);
 		}
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index a498ee8d6674..f72e6da88cca 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -71,9 +71,8 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 		spin_lock(&rreq->lock);
 		list_add_tail(&subreq->rreq_link, &stream->subrequests);
 		if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-			stream->front = subreq;
 			if (!stream->active) {
-				stream->collected_to = stream->front->start;
+				stream->collected_to = subreq->start;
 				/* Store list pointers before active flag */
 				smp_store_release(&stream->active, true);
 			}
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 4d9760e36c11..f9ab69de3e29 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -111,7 +111,6 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 			netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred);
 			subreq = stream->construct;
 			stream->construct = NULL;
-			stream->front = NULL;
 		}
 
 		/* Check if (re-)preparation failed. */
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 137f0e28a44c..e5f6665b3341 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -205,7 +205,8 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 	 * in progress.  The issuer thread may be adding stuff to the tail
 	 * whilst we're doing this.
 	 */
-	front = READ_ONCE(stream->front);
+	front = list_first_entry_or_null(&stream->subrequests,
+					 struct netfs_io_subrequest, rreq_link);
 	while (front) {
 		size_t transferred;
 
@@ -301,7 +302,6 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 		list_del_init(&front->rreq_link);
 		front = list_first_entry_or_null(&stream->subrequests,
 						 struct netfs_io_subrequest, rreq_link);
-		stream->front = front;
 		spin_unlock(&rreq->lock);
 		netfs_put_subrequest(remove,
 				     notes & ABANDON_SREQ ?
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index 8e6264f62a8f..d0e23bc42445 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -107,7 +107,6 @@ static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 	spin_lock(&rreq->lock);
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-	stream->front = subreq;
 	/* Store list pointers before active flag */
 	smp_store_release(&stream->active, true);
 	spin_unlock(&rreq->lock);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 83eb3dc1adf8..b194447f4b11 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -228,7 +228,8 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 		if (!smp_load_acquire(&stream->active))
 			continue;
 
-		front = stream->front;
+		front = list_first_entry_or_null(&stream->subrequests,
+						 struct netfs_io_subrequest, rreq_link);
 		while (front) {
 			trace_netfs_collect_sreq(wreq, front);
 			//_debug("sreq [%x] %llx %zx/%zx",
@@ -279,7 +280,6 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 			list_del_init(&front->rreq_link);
 			front = list_first_entry_or_null(&stream->subrequests,
 							 struct netfs_io_subrequest, rreq_link);
-			stream->front = front;
 			spin_unlock(&wreq->lock);
 			netfs_put_subrequest(remove,
 					     notes & SAW_FAILURE ?
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 437268f65640..2db688f94125 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -206,9 +206,8 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 	spin_lock(&wreq->lock);
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-		stream->front = subreq;
 		if (!stream->active) {
-			stream->collected_to = stream->front->start;
+			stream->collected_to = subreq->start;
 			/* Write list pointers before active flag */
 			smp_store_release(&stream->active, true);
 		}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 72ee7d210a74..ba17ac5bf356 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -140,7 +140,6 @@ struct netfs_io_stream {
 	void (*issue_write)(struct netfs_io_subrequest *subreq);
 	/* Collection tracking */
 	struct list_head	subrequests;	/* Contributory I/O operations */
-	struct netfs_io_subrequest *front;	/* Op being collected */
 	unsigned long long	collected_to;	/* Position we've collected results to */
 	size_t			transferred;	/* The amount transferred from this stream */
 	unsigned short		error;		/* Aggregate error for the stream */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 2d366be46a1c..cbe28211106c 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -740,19 +740,19 @@ TRACE_EVENT(netfs_collect_stream,
 		    __field(unsigned int,	wreq)
 		    __field(unsigned char,	stream)
 		    __field(unsigned long long,	collected_to)
-		    __field(unsigned long long,	front)
+		    __field(unsigned long long,	issued_to)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->wreq	= wreq->debug_id;
 		    __entry->stream	= stream->stream_nr;
 		    __entry->collected_to = stream->collected_to;
-		    __entry->front	= stream->front ? stream->front->start : UINT_MAX;
+		    __entry->issued_to	= atomic64_read(&wreq->issued_to);
 			   ),
 
-	    TP_printk("R=%08x[%x:] cto=%llx frn=%llx",
+	    TP_printk("R=%08x[%x:] cto=%llx ito=%llx",
 		      __entry->wreq, __entry->stream,
-		      __entry->collected_to, __entry->front)
+		      __entry->collected_to, __entry->issued_to)
 	    );
 
 TRACE_EVENT(netfs_folioq,


