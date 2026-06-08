Return-Path: <linux-nfs+bounces-22354-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y4GqGqHeJmpjmAIAu9opvQ
	(envelope-from <linux-nfs+bounces-22354-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 17:24:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD2D657FEA
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 17:24:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=HHvOFupm;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22354-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22354-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE7363047BF8
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108AC3FCB0E;
	Mon,  8 Jun 2026 14:55:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208013F8239
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2026 14:55:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930526; cv=none; b=gIAfz5U3vZUQh8fw23c9Ye7mjSKU94JGd10v5Vo3HYfEd5GvYTT/k/4WzSd+zsbMb4LQAiQuvILQmq2+9GHNAeKFyfA+TreIMCFGH0WLm5InIbte3fO+4u57PdnRECONmsUoKEd464UCD1BLQWXgwB3X1cc16CsSGrseYF23IPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930526; c=relaxed/simple;
	bh=aFC/AfAts6RejXMeXjUtlrV6sVMEbFGujrlPfAy6yX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ej7jOHjFDMivX3Yz7+7OaBFNj16dw8qyW8k3dPDqdAjbsxqO429G4vpNRrbxPly04RYzHyEfhmP9GgZR1caFfNkaN1xeekbM7nstKDDb3YloxLX+Wb+Ic8KqbC8B8WUnoHwrdrQ/+uauwtIeo3R6LBaIcIq2FWsgTFxQrigqr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHvOFupm; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780930522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soBo8nUow0/Mt0ICicV5RVH+h1Do/YU51PNZLQVaIMs=;
	b=HHvOFupmJAZWgiuTJxVwaiaOP92qAsKLORQRgnBa53vMK4oF9pdBVRsA5ZnujIC6cxmZPJ
	vGwSWRUQXdLIYVyOLZy6XPIUI1VdPbnJZuLqAWCydXRTwguYrezN7oif/QyFbYpGLTcJww
	LZBrypueCuZbLX72JdFG6ZGcjVFfFJE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-2nccMlFlMvuk38VjUJ0jZA-1; Mon,
 08 Jun 2026 10:55:18 -0400
X-MC-Unique: 2nccMlFlMvuk38VjUJ0jZA-1
X-Mimecast-MFC-AGG-ID: 2nccMlFlMvuk38VjUJ0jZA_1780930516
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 578BA195609D;
	Mon,  8 Jun 2026 14:55:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 372E91955BC0;
	Mon,  8 Jun 2026 14:55:07 +0000 (UTC)
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
	Trond Myklebust <trondmy@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/22] netfs: Add the cache object ID to netfs_read/write tracepoints
Date: Mon,  8 Jun 2026 15:54:11 +0100
Message-ID: <20260608145432.681865-4-dhowells@redhat.com>
In-Reply-To: <20260608145432.681865-1-dhowells@redhat.com>
References: <20260608145432.681865-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-22354-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,manguebit.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDD2D657FEA

Add the cache object debug ID to netfs_read/write tracepoints to make
debugging easier as there's now a direct cross-reference with the
cachefiles tracepoints that only log that debug ID.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/io.c           |  1 +
 fs/netfs/fscache_io.c        |  2 +-
 include/linux/netfs.h        |  3 ++-
 include/trace/events/netfs.h | 27 +++++++++++++++------------
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 42265fdcc17e..7e32b1caf6fe 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -918,6 +918,7 @@ bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
 			if (!cres->cache_priv2 && file)
 				cres->cache_priv2 = get_file(file);
 			spin_unlock(&object->lock);
+			cres->object_id = object->debug_id;
 			cres->cache_i_size = i_size_read(file_inode(file));
 			cres->dio_size = object->volume->cache->bsize;
 		}
diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 37f05b4d3469..fafa8c6bec57 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -79,7 +79,7 @@ static int fscache_begin_operation(struct netfs_cache_resources *cres,
 	cres->ops		= NULL;
 	cres->cache_priv	= cookie;
 	cres->cache_priv2	= NULL;
-	cres->debug_id		= cookie->debug_id;
+	cres->cookie_id		= cookie->debug_id;
 	cres->inval_counter	= cookie->inval_counter;
 
 	if (!fscache_begin_cookie_access(cookie, why)) {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a83a4ea86e2b..d175c63ff659 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -162,7 +162,8 @@ struct netfs_cache_resources {
 	void				*cache_priv;
 	void				*cache_priv2;
 	unsigned long long		cache_i_size;	/* Initial size of cache file */
-	unsigned int			debug_id;	/* Cookie debug ID */
+	unsigned int			cookie_id;	/* Cache cookie debug ID */
+	unsigned int			object_id;	/* Cache object debug ID */
 	unsigned int			inval_counter;	/* object->inval_counter at begin_op */
 	unsigned int			dio_size;	/* DIO block size */
 };
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 83d161f8c726..63ed1d771bd8 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -311,6 +311,7 @@ TRACE_EVENT(netfs_read,
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		rreq)
 		    __field(unsigned int,		cookie)
+		    __field(unsigned int,		object)
 		    __field(loff_t,			i_size)
 		    __field(loff_t,			start)
 		    __field(size_t,			len)
@@ -320,7 +321,8 @@ TRACE_EVENT(netfs_read,
 
 	    TP_fast_assign(
 		    __entry->rreq	= rreq->debug_id;
-		    __entry->cookie	= rreq->cache_resources.debug_id;
+		    __entry->cookie	= rreq->cache_resources.cookie_id;
+		    __entry->object	= rreq->cache_resources.object_id;
 		    __entry->i_size	= rreq->i_size;
 		    __entry->start	= start;
 		    __entry->len	= len;
@@ -328,10 +330,10 @@ TRACE_EVENT(netfs_read,
 		    __entry->netfs_inode = rreq->inode->i_ino;
 			   ),
 
-	    TP_printk("R=%08x %s c=%08x ni=%llx s=%llx l=%zx sz=%llx",
+	    TP_printk("R=%08x %s c=%08x o=%08x ni=%llx s=%llx l=%zx sz=%llx",
 		      __entry->rreq,
 		      __print_symbolic(__entry->what, netfs_read_traces),
-		      __entry->cookie,
+		      __entry->cookie, __entry->object,
 		      __entry->netfs_inode,
 		      __entry->start, __entry->len, __entry->i_size)
 	    );
@@ -552,6 +554,7 @@ TRACE_EVENT(netfs_write,
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		wreq)
 		    __field(unsigned int,		cookie)
+		    __field(unsigned int,		object)
 		    __field(unsigned int,		ino)
 		    __field(enum netfs_write_trace,	what)
 		    __field(unsigned long long,		start)
@@ -559,20 +562,19 @@ TRACE_EVENT(netfs_write,
 			     ),
 
 	    TP_fast_assign(
-		    struct netfs_inode *__ctx = netfs_inode(wreq->inode);
-		    struct fscache_cookie *__cookie = netfs_i_cookie(__ctx);
 		    __entry->wreq	= wreq->debug_id;
-		    __entry->cookie	= __cookie ? __cookie->debug_id : 0;
+		    __entry->cookie	= wreq->cache_resources.cookie_id;
+		    __entry->object	= wreq->cache_resources.object_id;
 		    __entry->ino	= wreq->inode->i_ino;
 		    __entry->what	= what;
 		    __entry->start	= wreq->start;
 		    __entry->len	= wreq->len;
 			   ),
 
-	    TP_printk("R=%08x %s c=%08x i=%x by=%llx-%llx",
+	    TP_printk("R=%08x %s c=%08x o=%08x i=%x by=%llx-%llx",
 		      __entry->wreq,
 		      __print_symbolic(__entry->what, netfs_write_traces),
-		      __entry->cookie,
+		      __entry->cookie, __entry->object,
 		      __entry->ino,
 		      __entry->start, __entry->start + __entry->len - 1)
 	    );
@@ -587,22 +589,23 @@ TRACE_EVENT(netfs_copy2cache,
 		    __field(unsigned int,		rreq)
 		    __field(unsigned int,		creq)
 		    __field(unsigned int,		cookie)
+		    __field(unsigned int,		object)
 		    __field(unsigned int,		ino)
 			     ),
 
 	    TP_fast_assign(
-		    struct netfs_inode *__ctx = netfs_inode(rreq->inode);
-		    struct fscache_cookie *__cookie = netfs_i_cookie(__ctx);
 		    __entry->rreq	= rreq->debug_id;
 		    __entry->creq	= creq->debug_id;
-		    __entry->cookie	= __cookie ? __cookie->debug_id : 0;
+		    __entry->cookie	= rreq->cache_resources.cookie_id;
+		    __entry->object	= rreq->cache_resources.object_id;
 		    __entry->ino	= rreq->inode->i_ino;
 			   ),
 
-	    TP_printk("R=%08x CR=%08x c=%08x i=%x ",
+	    TP_printk("R=%08x CR=%08x c=%08x o=%08x i=%x ",
 		      __entry->rreq,
 		      __entry->creq,
 		      __entry->cookie,
+		      __entry->object,
 		      __entry->ino)
 	    );
 


