Return-Path: <linux-nfs+bounces-22353-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wbBAHr/gJmoKmQIAu9opvQ
	(envelope-from <linux-nfs+bounces-22353-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 17:33:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC93265821A
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 17:33:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gDnPg9Rr;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22353-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22353-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D13234699B7
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A83F86EC;
	Mon,  8 Jun 2026 14:55:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CE3F076E
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2026 14:55:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930524; cv=none; b=uFAUrydOX8+sJwSG/UpnrvfO6nK3ZSZkNQsrZPqqClcTLEOlvssxJq8+i0XYBPXdjUqE10HJ5ekXUfl77FhFxjOM67/d4C+Nu0fjW4pphiR4pk12fS5YK5H4AZ/duxdL9/GzkOeNSLbaENMyoeb1avTCamc/8P9phtzAWZwy3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930524; c=relaxed/simple;
	bh=2ahXizcyXLDjbtKYQ+ZGWVzVrnxjZJUtxCb7O3OnDlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtaWCawFACgj3dZAZrIDW55zTWXJFMhT4lGL9IiFIR813hktqOOHU7U3OjU8pSXQysWquSCqiN2c7hH/vC8m6BmKevsRLodUhKCyP4uV6spJGpeL3doG0mShY0i1v6h4RBRc64qnOPkEIBRuzavwuuMadSOH9NQBvlOfuItyd5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDnPg9Rr; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780930515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r+10wUz5cmnIBYpb4/p4mmtgC9S0CvoYK/oEIoggssw=;
	b=gDnPg9RrKQWO90ohbOIP+a1QJrc5p4insYbeEyBk72qWNJaeRKdOETiBpobIXMfe8Nhb7i
	ZqD2GBR81IY0VSzF16SM/e/v82pyuZQ1WCbkD8LvoI0GutSPp5VbOkpglwdzJC6wNZLY5/
	rTCFcOHlG1nfhrf2XR3oQnNrwYauhRw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-b34bw23iPd6OTe5CpdbNdg-1; Mon,
 08 Jun 2026 10:55:10 -0400
X-MC-Unique: b34bw23iPd6OTe5CpdbNdg-1
X-Mimecast-MFC-AGG-ID: b34bw23iPd6OTe5CpdbNdg_1780930507
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72BDB1956056;
	Mon,  8 Jun 2026 14:55:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4C8919541B0;
	Mon,  8 Jun 2026 14:54:59 +0000 (UTC)
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
Subject: [PATCH v3 02/22] cachefiles: Don't rely on backing fs storage map for most use cases
Date: Mon,  8 Jun 2026 15:54:10 +0100
Message-ID: <20260608145432.681865-3-dhowells@redhat.com>
In-Reply-To: <20260608145432.681865-1-dhowells@redhat.com>
References: <20260608145432.681865-1-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-22353-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,manguebit.org:email,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC93265821A

Cachefiles currently uses the backing filesystem's idea of what data is
held in a backing file and queries this by means of SEEK_DATA and
SEEK_HOLE.  However, this means it does two seek operations on the backing
file for each individual read call it wants to prepare (unless the first
returns -ENXIO).  Worse, the backing filesystem is at liberty to insert or
remove blocks of zeros in order to optimise its layout which may cause
false positives and false negatives.

The problem is that keeping track of what is dirty is tricky (if storing
info in xattrs, which may have limited capacity and must be read and
written as one piece) and expensive (in terms of diskspace at least) and is
basically duplicating what a filesystem does.

However, the most common write case, in which the application does {
open(O_TRUNC); write(); write(); ... write(); close(); } where each write
follows directly on from the previous and leaves no gaps in the file is
reasonably easy to detect and can be noted in the primary xattr as
CACHEFILES_CONTENT_ALL, indicating we have everything up to the object size
stored.

In this specific case, given that it is known that there are no holes in
the file, there's no need to call SEEK_DATA/HOLE or use any other mechanism
to track the contents.  That speeds things up enormously.

Even when it is necessary to use SEEK_DATA/HOLE, it may not be necessary to
call it for each cache read subrequest generated.

Implement this by adding support for the CACHEFILES_CONTENT_ALL content
type (which is defined, but currently unused), which requires a slight
adjustment in how backing files are managed.  Specifically, the driver
needs to know how much of the tail block is data and whether storing more
data will create a hole.

To this end, the way that the size of a backing file is managed is changed.
Currently, the backing file is expanded to strictly match the size of the
network file, but this can be changed to carry more useful information.
This makes two pieces of metadata available: xattr.object_size and the
backing file's i_size.  Apply the following schema:

  (a) i_size is always a multiple of the DIO block size.

  (b) i_size is only updated to the end of the highest write stored.  This
      is used to work out if we are following on without leaving a hole.

  (c) xattr.object_size is the size of the network filesystem file cached
      in this backing file.

  (d) xattr.object_size must point after the start of the last block
      (unless both are 0).

  (e) If xattr.object_size is at or after the block at the current end of
      the backing file (ie. i_size), then we have all the contents of the
      block (if xattr.content == CACHEFILES_CONTENT_ALL).

  (f) If xattr.object_size is somewhere in the middle of the last block,
      then the data following it is invalid and must be ignored.

  (g) If data is added to the last block, then that block must be fetched,
      modified and rewritten (it must be a buffered write through the
      pagecache and not DIO).

  (h) Writes to cache are rounded out to blocks on both sides and the
      folios used as sources must contain data for any lower gap and must
      have been cleared for any upper gap, and so will rewrite any
      non-data area in the tail block.

To implement this, the following changes are made:

 (1) cookie->object_size is no longer updated when writes are copied into
     the pagecache, but rather only updated when a write request completes.

     This prevents object size miscomparison when checking the xattr
     causing the backing file to be invalidated (opening and marking the
     backing file and modifying the pagecache run in parallel).

 (2) The cache's current idea of the amount of data that should be stored
     in the backing file is kept track of in object->object_size.

     Possibly this is redundant with cookie->object_size, but the latter
     gets updated in some addition circumstances.

 (3) The size of the backing file at the start of a request is now tracked
     in struct netfs_cache_resources so that the partial EOF block can be
     located and cleaned.

 (4) The cache block size is now used consistently rather than using
     CACHEFILES_DIO_BLOCK_SIZE (4096).

 (5) The backing file size is no longer adjusted when looking up an object.

 (6) When shortening a file, if the new size is not block aligned, the part
     beyond the new size is cleared.  If the file is truncated to zero, the
     content_info gets reset to CACHEFILES_CONTENT_NO_DATA.

 (7) A new struct, fscache_occupancy, is instituted to track the region
     being read.  Netfslib allocates it and fills in the start and end of
     the region to be read then calls the ->query_occupancy() method to
     find and fill in the extents.  It also indicates whether a recorded
     extent contains data or just contains a region that's all zeros
     (FSCACHE_EXTENT_DATA or FSCACHE_EXTENT_ZERO).

 (8) The ->prepare_read() cache method is changed such that, if given, it
     just limits the amount that can be read from the cache in one go.  It
     no longer indicates what source of read should be done; that
     information is now obtained from ->query_occupancy().

 (9) A new cache method, ->collect_write(), is added that is called when a
     contiguous series of writes have completed and a discontiguity or the
     end of the request has been hit.  It it supplied with the start and
     length of the write made to the backing file and can use this
     information to update the cache metadata.

(10) cachefiles_query_occupancy() is altered to find the next two "extents"
     of data stored in the backing file by doing SEEK_DATA/HOLE between the
     bounds set - unless it is known that there are no holes, in which case
     a whole-file first extent can be set.

(11) cachefiles_collect_write() is implemented to take the collated write
     completion information and use this to update the cache metadata, in
     particular working out whether there's now a hole in the backing file
     requiring future use of SEEK_DATA/HOLE instead of just assuming the
     data is all present.

     It also uses fallocate(FALLOC_FL_ZERO_RANGE) to clean the part of a
     partial block that extended beyond the old object size.  It might be
     better to perform a synchronous DIO write for this purpose, but that
     would mandate an RMW cycle.  Ideally, it should be all zeros anyway,
     but, unfortunately, shared-writable mmap can interfere.

(12) cachefiles_begin_operation() is updated to note the current backing
     file size and the cache DIO size.

(13) cachefiles_create_tmpfile() no longer expands the backing file when it
     creates it.

(14) cachefiles_set_object_xattr() is changed to use object->object_size
     rather than cookie->object_size.

(15) cachefiles_check_auxdata() is altered to actually store the content
     type and to also set object->object_size.  The cachefiles_coherency
     tracepoint is also modified to display xattr.object_size.

(16) netfs_read_to_pagecache() is reworked.  The cache ->prepare_read()
     method is replaced with ->query_occupancy() as the arbiter of what
     region of the file is read from where, and that retrieves up to two
     occupied extents of the backing file at once.

     The cache ->prepare_read() method is now repurposed to be the same as
     the equivalent network filesystem method and allows the cache to limit
     the size of the read before the iterator is prepared.

     netfs_single_dispatch_read() is similarly modified.

(17) netfs_update_i_size() and afs_update_i_size() no longer call
     fscache_update_cookie() to update cookie->object_size.

(18) Write collection now collates contiguous sequences of writes to the
     cache and calls the cache ->collect_write() method.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/file.c                     |   1 -
 fs/cachefiles/interface.c         |  82 +-------
 fs/cachefiles/internal.h          |  13 +-
 fs/cachefiles/io.c                | 300 +++++++++++++++++++++++-------
 fs/cachefiles/namei.c             |  19 +-
 fs/cachefiles/xattr.c             |  24 ++-
 fs/netfs/buffered_read.c          | 176 +++++++++++-------
 fs/netfs/buffered_write.c         |   3 -
 fs/netfs/internal.h               |   2 +
 fs/netfs/read_retry.c             |   2 +
 fs/netfs/read_single.c            |  39 ++--
 fs/netfs/write_collect.c          | 133 ++++++++++---
 fs/netfs/write_issue.c            |  18 ++
 fs/netfs/write_retry.c            |   3 +
 include/linux/fscache.h           |  17 ++
 include/linux/netfs.h             |  40 +++-
 include/trace/events/cachefiles.h |  17 +-
 include/trace/events/netfs.h      |   9 +-
 18 files changed, 614 insertions(+), 284 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 0467742bfeee..67f38e99ada7 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -448,7 +448,6 @@ void afs_set_i_size(struct afs_vnode *vnode, loff_t new_i_size)
 	}
 	spin_unlock(&inode->i_lock);
 	write_sequnlock(&vnode->cb_lock);
-	fscache_update_cookie(afs_vnode_cache(vnode), NULL, &new_i_size);
 }
 
 static void afs_update_i_size(struct inode *inode, loff_t new_i_size)
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index a08250d244ea..736bfcaa4e1d 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -105,73 +105,6 @@ void cachefiles_put_object(struct cachefiles_object *object,
 	_leave("");
 }
 
-/*
- * Adjust the size of a cache file if necessary to match the DIO size.  We keep
- * the EOF marker a multiple of DIO blocks so that we don't fall back to doing
- * non-DIO for a partial block straddling the EOF, but we also have to be
- * careful of someone expanding the file and accidentally accreting the
- * padding.
- */
-static int cachefiles_adjust_size(struct cachefiles_object *object)
-{
-	struct iattr newattrs;
-	struct file *file = object->file;
-	uint64_t ni_size;
-	loff_t oi_size;
-	int ret;
-
-	ni_size = object->cookie->object_size;
-	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
-
-	_enter("{OBJ%x},[%llu]",
-	       object->debug_id, (unsigned long long) ni_size);
-
-	if (!file)
-		return -ENOBUFS;
-
-	oi_size = i_size_read(file_inode(file));
-	if (oi_size == ni_size)
-		return 0;
-
-	inode_lock(file_inode(file));
-
-	/* if there's an extension to a partial page at the end of the backing
-	 * file, we need to discard the partial page so that we pick up new
-	 * data after it */
-	if (oi_size & ~PAGE_MASK && ni_size > oi_size) {
-		_debug("discard tail %llx", oi_size);
-		newattrs.ia_valid = ATTR_SIZE;
-		newattrs.ia_size = oi_size & PAGE_MASK;
-		ret = cachefiles_inject_remove_error();
-		if (ret == 0)
-			ret = notify_change(&nop_mnt_idmap, file->f_path.dentry,
-					    &newattrs, NULL);
-		if (ret < 0)
-			goto truncate_failed;
-	}
-
-	newattrs.ia_valid = ATTR_SIZE;
-	newattrs.ia_size = ni_size;
-	ret = cachefiles_inject_write_error();
-	if (ret == 0)
-		ret = notify_change(&nop_mnt_idmap, file->f_path.dentry,
-				    &newattrs, NULL);
-
-truncate_failed:
-	inode_unlock(file_inode(file));
-
-	if (ret < 0)
-		trace_cachefiles_io_error(NULL, file_inode(file), ret,
-					  cachefiles_trace_notify_change_error);
-	if (ret == -EIO) {
-		cachefiles_io_error_obj(object, "Size set failed");
-		ret = -ENOBUFS;
-	}
-
-	_leave(" = %d", ret);
-	return ret;
-}
-
 /*
  * Attempt to look up the nominated node in this cache
  */
@@ -204,7 +137,6 @@ static bool cachefiles_lookup_cookie(struct fscache_cookie *cookie)
 	spin_lock(&cache->object_list_lock);
 	list_add(&object->cache_link, &cache->object_list);
 	spin_unlock(&cache->object_list_lock);
-	cachefiles_adjust_size(object);
 
 	cachefiles_end_secure(cache, saved_cred);
 	_leave(" = t");
@@ -238,7 +170,7 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object,
 	loff_t i_size, dio_size;
 	int ret;
 
-	dio_size = round_up(new_size, CACHEFILES_DIO_BLOCK_SIZE);
+	dio_size = round_up(new_size, cache->bsize);
 	i_size = i_size_read(inode);
 
 	trace_cachefiles_trunc(object, inode, i_size, dio_size,
@@ -270,6 +202,7 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object,
 		}
 	}
 
+	object->object_size = new_size;
 	return true;
 }
 
@@ -284,15 +217,20 @@ static void cachefiles_resize_cookie(struct netfs_cache_resources *cres,
 	struct fscache_cookie *cookie = object->cookie;
 	const struct cred *saved_cred;
 	struct file *file = cachefiles_cres_file(cres);
-	loff_t old_size = cookie->object_size;
+	unsigned long long i_size = i_size_read(file_inode(file));
 
-	_enter("%llu->%llu", old_size, new_size);
+	_enter("%llu->%llu", i_size, new_size);
 
-	if (new_size < old_size) {
+	if (new_size < i_size) {
+		/* The file is being shrunk - we need to downsize the backing
+		 * file and clear the end of the final block.
+		 */
 		cachefiles_begin_secure(cache, &saved_cred);
 		cachefiles_shorten_object(object, file, new_size);
 		cachefiles_end_secure(cache, saved_cred);
 		object->cookie->object_size = new_size;
+		if (new_size == 0)
+			object->content_info = CACHEFILES_CONTENT_NO_DATA;
 		return;
 	}
 
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b62cd3e9a18e..fb1a92e45ca1 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -18,8 +18,6 @@
 #include <linux/xarray.h>
 #include <linux/cachefiles.h>
 
-#define CACHEFILES_DIO_BLOCK_SIZE 4096
-
 struct cachefiles_cache;
 struct cachefiles_object;
 
@@ -68,12 +66,17 @@ struct cachefiles_object {
 	struct list_head		cache_link;	/* Link in cache->*_list */
 	struct file			*file;		/* The file representing this object */
 	char				*d_name;	/* Backing file name */
+	unsigned long			flags;
+#define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
+	unsigned long long		object_size;	/* Size of the object stored
+							 * (independent of cookie->object_size for
+							 * coherency reasons)
+							 */
+	atomic64_t			read_limit;	/* Point beyond which uncommitted writes */
 	int				debug_id;
 	spinlock_t			lock;
 	refcount_t			ref;
-	enum cachefiles_content		content_info:8;	/* Info about content presence */
-	unsigned long			flags;
-#define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
+	enum cachefiles_content		content_info;	/* Info about content presence */
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	struct cachefiles_ondemand_info	*ondemand;
 #endif
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index d879b80a0bed..42265fdcc17e 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -32,6 +32,8 @@ struct cachefiles_kiocb {
 	u64			b_writing;
 };
 
+#define IS_ERR_VALUE_LL(x) unlikely((x) >= (unsigned long long)-MAX_ERRNO)
+
 static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
 {
 	if (refcount_dec_and_test(&ki->ki_refcnt)) {
@@ -193,60 +195,81 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 }
 
 /*
- * Query the occupancy of the cache in a region, returning where the next chunk
- * of data starts and how long it is.
+ * Query the occupancy of the cache in a region, returning the extent of the
+ * next two chunks of cached data and the next hole.
  */
 static int cachefiles_query_occupancy(struct netfs_cache_resources *cres,
-				      loff_t start, size_t len, size_t granularity,
-				      loff_t *_data_start, size_t *_data_len)
+				      struct fscache_occupancy *occ)
 {
 	struct cachefiles_object *object;
+	struct inode *inode;
 	struct file *file;
-	loff_t off, off2;
-
-	*_data_start = -1;
-	*_data_len = 0;
+	unsigned long long read_limit;
+	loff_t ret;
+	int i;
 
 	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_READ))
 		return -ENOBUFS;
 
 	object = cachefiles_cres_object(cres);
 	file = cachefiles_cres_file(cres);
-	granularity = max_t(size_t, object->volume->cache->bsize, granularity);
+	inode = file_inode(file);
+	occ->granularity = object->volume->cache->bsize;
+	/* Read read_limit before content_info. */
+	read_limit = atomic64_read_acquire(&object->read_limit);
+
+	_enter("%pD,%llu,%llx-%llx/%llx",
+	       file, inode->i_ino, occ->query_from, occ->query_to, read_limit);
+
+	if (read_limit == 0)
+		goto done;
+
+	switch (READ_ONCE(object->content_info)) {
+	case CACHEFILES_CONTENT_ALL:
+	case CACHEFILES_CONTENT_SINGLE:
+		if (read_limit > occ->query_from) {
+			occ->cached_from[0] = 0;
+			occ->cached_to[0] = read_limit;
+			occ->cached_type[0] = FSCACHE_EXTENT_DATA;
+			occ->query_from = ULLONG_MAX;
+		}
+		goto done;
+	default:
+		break;
+	}
 
-	_enter("%pD,%llu,%llx,%zx/%llx",
-	       file, file_inode(file)->i_ino, start, len,
-	       i_size_read(file_inode(file)));
+	for (i = 0; i < ARRAY_SIZE(occ->cached_from); i++) {
+		ret = cachefiles_inject_read_error();
+		if (ret == 0)
+			ret = vfs_llseek(file, occ->query_from, SEEK_DATA);
+		if (IS_ERR_VALUE_LL(ret)) {
+			if (ret != -ENXIO)
+				return ret;
+			occ->query_from = ULLONG_MAX;
+			goto done;
+		}
+		occ->cached_type[i] = FSCACHE_EXTENT_DATA;
+		occ->cached_from[i] = ret;
+		occ->query_from = ret;
+
+		ret = cachefiles_inject_read_error();
+		if (ret == 0)
+			ret = vfs_llseek(file, occ->query_from, SEEK_HOLE);
+		if (IS_ERR_VALUE_LL(ret)) {
+			if (ret != -ENXIO)
+				return ret;
+			occ->query_from = ULLONG_MAX;
+			goto done;
+		}
+		occ->cached_to[i] = ret;
+		occ->query_from = ret;
+		if (occ->query_from >= occ->query_to)
+			break;
+	}
 
-	off = cachefiles_inject_read_error();
-	if (off == 0)
-		off = vfs_llseek(file, start, SEEK_DATA);
-	if (off == -ENXIO)
-		return -ENODATA; /* Beyond EOF */
-	if (off < 0 && off >= (loff_t)-MAX_ERRNO)
-		return -ENOBUFS; /* Error. */
-	if (round_up(off, granularity) >= start + len)
-		return -ENODATA; /* No data in range */
-
-	off2 = cachefiles_inject_read_error();
-	if (off2 == 0)
-		off2 = vfs_llseek(file, off, SEEK_HOLE);
-	if (off2 == -ENXIO)
-		return -ENODATA; /* Beyond EOF */
-	if (off2 < 0 && off2 >= (loff_t)-MAX_ERRNO)
-		return -ENOBUFS; /* Error. */
-
-	/* Round away partial blocks */
-	off = round_up(off, granularity);
-	off2 = round_down(off2, granularity);
-	if (off2 <= off)
-		return -ENODATA;
-
-	*_data_start = off;
-	if (off2 > start + len)
-		*_data_len = len;
-	else
-		*_data_len = off2 - off;
+done:
+	_debug("query[0] %llx-%llx", occ->cached_from[0], occ->cached_to[0]);
+	_debug("query[1] %llx-%llx", occ->cached_from[1], occ->cached_to[1]);
 	return 0;
 }
 
@@ -489,18 +512,6 @@ cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
 	return ret;
 }
 
-/*
- * Prepare a read operation, shortening it to a cached/uncached
- * boundary as appropriate.
- */
-static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
-						    unsigned long long i_size)
-{
-	return cachefiles_do_prepare_read(&subreq->rreq->cache_resources,
-					  subreq->start, &subreq->len, i_size,
-					  &subreq->flags, subreq->rreq->inode->i_ino);
-}
-
 /*
  * Prepare an on-demand read operation, shortening it to a cached/uncached
  * boundary as appropriate.
@@ -527,7 +538,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	int ret;
 
 	/* Round to DIO size */
-	start = round_down(*_start, PAGE_SIZE);
+	start = round_down(*_start, cache->bsize);
 	if (start != *_start || *_len > upper_len) {
 		/* Probably asked to cache a streaming write written into the
 		 * pagecache when the cookie was temporarily out of service to
@@ -537,7 +548,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 		return -ENOBUFS;
 	}
 
-	*_len = round_up(len, PAGE_SIZE);
+	*_len = round_up(len, cache->bsize);
 
 	/* We need to work out whether there's sufficient disk space to perform
 	 * the write - but we can skip that check if we have space already
@@ -563,7 +574,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	 * space, we need to see if it's fully allocated.  If it's not, we may
 	 * want to cull it.
 	 */
-	if (cachefiles_has_space(cache, 0, *_len / PAGE_SIZE,
+	if (cachefiles_has_space(cache, 0, *_len / cache->bsize,
 				 cachefiles_has_space_check) == 0)
 		return 0; /* Enough space to simply overwrite the whole block */
 
@@ -595,7 +606,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	return ret;
 
 check_space:
-	return cachefiles_has_space(cache, 0, *_len / PAGE_SIZE,
+	return cachefiles_has_space(cache, 0, *_len / cache->bsize,
 				    cachefiles_has_space_for_write);
 }
 
@@ -658,9 +669,9 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 	       wreq->debug_id, subreq->debug_index, start, start + len - 1);
 
 	/* We need to start on the cache granularity boundary */
-	off = start & (CACHEFILES_DIO_BLOCK_SIZE - 1);
+	off = start & (cache->bsize - 1);
 	if (off) {
-		pre = CACHEFILES_DIO_BLOCK_SIZE - off;
+		pre = cache->bsize - off;
 		if (pre >= len) {
 			fscache_count_dio_misfit();
 			netfs_write_subrequest_terminated(subreq, len);
@@ -674,8 +685,8 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 
 	/* We also need to end on the cache granularity boundary */
 	if (start + len == wreq->i_size) {
-		size_t part = len % CACHEFILES_DIO_BLOCK_SIZE;
-		size_t need = CACHEFILES_DIO_BLOCK_SIZE - part;
+		size_t part = len & (cache->bsize - 1);
+		size_t need = cache->bsize - part;
 
 		if (part && stream->submit_extendable_to >= need) {
 			len += need;
@@ -684,7 +695,7 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 		}
 	}
 
-	post = len & (CACHEFILES_DIO_BLOCK_SIZE - 1);
+	post = len & (cache->bsize - 1);
 	if (post) {
 		len -= post;
 		if (len == 0) {
@@ -711,6 +722,161 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 			 netfs_write_subrequest_terminated, subreq);
 }
 
+/*
+ * Collect the result of buffered writeback to the cache.  This includes
+ * copying a read to the cache.  Netfslib collates the results, which might
+ * occur out of order, and delivers them to the cache so that it can update its
+ * content record.
+ *
+ * block_type is one of:
+ * - NETFS_CACHE_COLLECT_WRITE_DATA for a contiguous block of data
+ * - NETFS_CACHE_COLLECT_WRITE_GAP if a discontiguity was skipped
+ * - NETFS_CACHE_COLLECT_WRITE_CANCEL for a hole due to a failed/cancelled write
+ *
+ * The writes we made are all rounded out at both sides to the nearest DIO
+ * block boundary, so if the final block contains the EOF in the middle of it
+ * (rather than at the end), padding will have been written to the file.  The
+ * backing file's filesize will have been updated if the write extended the
+ * file; the filesize may still change due to outstanding subreqs.
+ *
+ * The metadata in the cache file xattr records the size of the object we have
+ * stored, but the cache file EOF only goes up to where we've cached data to
+ * and, furthermore, is rounded up to the nearest DIO block boundary.
+ */
+static void cachefiles_collect_write(struct netfs_io_request *wreq,
+				     unsigned long long start, size_t len,
+				     enum netfs_cache_collect block_type)
+{
+	struct netfs_cache_resources *cres = &wreq->cache_resources;
+	struct cachefiles_object *object = cachefiles_cres_object(cres);
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct file *file = cachefiles_cres_file(cres);
+	struct inode *inode = file_inode(file);
+	unsigned long long read_limit;
+	unsigned long long old_size = cres->cache_i_size;
+	unsigned long long new_size = i_size_read(inode);
+	unsigned long long data_to = object->object_size;
+	unsigned long long end = start + len;
+	int ret;
+
+	_enter("%llx,%zx,%x", start, len, cache->bsize);
+
+	if (WARN_ON(old_size	& (cache->bsize - 1)) ||
+	    WARN_ON(new_size	& (cache->bsize - 1)) ||
+	    WARN_ON(start	& (cache->bsize - 1)) ||
+	    WARN_ON(len		& (cache->bsize - 1))) {
+		trace_cachefiles_io_error(object, inode, -EIO,
+					  cachefiles_trace_alignment_error);
+		cachefiles_remove_object_xattr(cache, object, file->f_path.dentry);
+		return;
+	}
+
+	/* If this is recording a gap, due to discontiguous writes or lack of
+	 * cache space, then a hole may have been introduced into the backing
+	 * file.  Treat it as a zero-length data block.
+	 */
+	if (block_type == NETFS_CACHE_COLLECT_WRITE_GAP ||
+	    block_type == NETFS_CACHE_COLLECT_WRITE_CANCEL) {
+		start = end;
+		len = 0;
+	}
+
+	/* Zeroth case: Single monolithic files are handled specially.
+	 */
+	if (wreq->origin == NETFS_WRITEBACK_SINGLE) {
+		object->content_info = CACHEFILES_CONTENT_SINGLE;
+		goto update_sizes;
+	}
+
+	/* First case: The backing file was empty. */
+	if (old_size == 0) {
+		if (start == 0)
+			object->content_info = CACHEFILES_CONTENT_ALL;
+		else
+			object->content_info = CACHEFILES_CONTENT_BACKFS_MAP;
+		goto update_sizes;
+	}
+
+	/* Second case: The backing file is entirely within the old object size
+	 * and thus there can be no partial tail block to deal with in the
+	 * cache file.
+	 */
+	if (old_size <= data_to) {
+		if (start > old_size)
+			goto discontiguous;
+		goto update_sizes;
+	}
+
+	/* Third case: The write happened entirely within the bounds of the
+	 * current cache file's size.
+	 */
+	if (end <= old_size)
+		goto update_sizes;
+
+	/* Fourth case: The write overwrote the partial tail block and extended
+	 * the file.  We only need to update the object size because netfslib
+	 * rounds out/pads cache writes to whole disk blocks.
+	 */
+	if (start < old_size)
+		goto update_sizes;
+
+	/* Fifth case: The write started from the end of the whole tail block
+	 * and extended the file.  Just extend our notion of the filesize.
+	 */
+	if (start == old_size && old_size == data_to)
+		goto update_sizes;
+
+	/* Sixth case: The write continued on from the partial tail block and
+	 * extended the file.  Need to clear the gap.
+	 */
+	if (start == old_size && old_size > data_to)
+		goto clear_gap;
+
+discontiguous:
+	/* Seventh case: The write was beyond the EOF on the cache file, so now
+	 * there's a hole in the file and we can no longer say in the metadata
+	 * that we can assume we have it all.  We may also need to clear the
+	 * end of the partial tail block.
+	 */
+	/* TODO: For the moment, we will have to use SEEK_HOLE/SEEK_DATA. */
+	if (object->content_info != CACHEFILES_CONTENT_BACKFS_MAP) {
+		object->content_info = CACHEFILES_CONTENT_BACKFS_MAP;
+		trace_cachefiles_coherency(object, inode->i_ino, data_to,
+					   be64_to_cpup((__be64 *)object->cookie->inline_aux),
+					   CACHEFILES_CONTENT_BACKFS_MAP,
+					   cachefiles_coherency_discontiguous);
+	}
+
+clear_gap:
+	/* We need to clear any partial padding that got jumped over.  It
+	 * *should* be all zeros, but shared-writable mmap exists...
+	 */
+	if (old_size > data_to) {
+		trace_cachefiles_trunc(object, inode, data_to, old_size,
+				       cachefiles_trunc_clear_padding);
+		ret = cachefiles_inject_write_error();
+		if (ret == 0)
+			ret = vfs_fallocate(file, FALLOC_FL_ZERO_RANGE,
+					    data_to, old_size - data_to);
+		if (ret < 0) {
+			trace_cachefiles_io_error(object, inode, ret,
+						  cachefiles_trace_fallocate_error);
+			cachefiles_io_error_obj(object, "fallocate zero pad failed %d", ret);
+			cachefiles_remove_object_xattr(cache, object, file->f_path.dentry);
+			return;
+		}
+	}
+
+update_sizes:
+	read_limit = umax(old_size, end);
+	cres->cache_i_size = read_limit;
+	object->object_size = umin(read_limit, wreq->i_size);
+
+	/* Raise the limit at which reads can access the file. */
+	/* Update read_limit after content_info */
+	atomic64_set_release(&object->read_limit, read_limit);
+}
+
 /*
  * Clean up an operation.
  */
@@ -728,11 +894,11 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
 	.issue_write		= cachefiles_issue_write,
-	.prepare_read		= cachefiles_prepare_read,
 	.prepare_write		= cachefiles_prepare_write,
 	.prepare_write_subreq	= cachefiles_prepare_write_subreq,
 	.prepare_ondemand_read	= cachefiles_prepare_ondemand_read,
 	.query_occupancy	= cachefiles_query_occupancy,
+	.collect_write		= cachefiles_collect_write,
 };
 
 /*
@@ -742,14 +908,18 @@ bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
 				enum fscache_want_state want_state)
 {
 	struct cachefiles_object *object = cachefiles_cres_object(cres);
+	struct file *file;
 
 	if (!cachefiles_cres_file(cres)) {
 		cres->ops = &cachefiles_netfs_cache_ops;
 		if (object->file) {
 			spin_lock(&object->lock);
-			if (!cres->cache_priv2 && object->file)
-				cres->cache_priv2 = get_file(object->file);
+			file = object->file;
+			if (!cres->cache_priv2 && file)
+				cres->cache_priv2 = get_file(file);
 			spin_unlock(&object->lock);
+			cres->cache_i_size = i_size_read(file_inode(file));
+			cres->dio_size = object->volume->cache->bsize;
 		}
 	}
 
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 2937db690b40..71d249344c8a 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -415,7 +415,6 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
 	struct file *file;
 	const struct path parentpath = { .mnt = cache->mnt, .dentry = fan };
-	uint64_t ni_size;
 	long ret;
 
 
@@ -447,23 +446,6 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	if (ret < 0)
 		goto err_unuse;
 
-	ni_size = object->cookie->object_size;
-	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
-
-	if (ni_size > 0) {
-		trace_cachefiles_trunc(object, file_inode(file), 0, ni_size,
-				       cachefiles_trunc_expand_tmpfile);
-		ret = cachefiles_inject_write_error();
-		if (ret == 0)
-			ret = vfs_truncate(&file->f_path, ni_size);
-		if (ret < 0) {
-			trace_cachefiles_vfs_error(
-				object, file_inode(file), ret,
-				cachefiles_trace_trunc_error);
-			goto err_unuse;
-		}
-	}
-
 	ret = -EINVAL;
 	if (unlikely(!file->f_op->read_iter) ||
 	    unlikely(!file->f_op->write_iter)) {
@@ -473,6 +455,7 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	}
 out:
 	cachefiles_end_secure(cache, saved_cred);
+	object->content_info = CACHEFILES_CONTENT_ALL;
 	return file;
 
 err_unuse:
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index f8ae78b3f7b6..25f2a906f984 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -54,7 +54,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 	if (!buf)
 		return -ENOMEM;
 
-	buf->object_size	= cpu_to_be64(object->cookie->object_size);
+	buf->object_size	= cpu_to_be64(object->object_size);
 	buf->zero_point		= 0;
 	buf->type		= CACHEFILES_COOKIE_TYPE_DATA;
 	buf->content		= object->content_info;
@@ -77,6 +77,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
 					   cachefiles_trace_setxattr_error);
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+					   object->object_size,
 					   be64_to_cpup((__be64 *)buf->data),
 					   buf->content,
 					   cachefiles_coherency_set_fail);
@@ -86,6 +87,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 				"Failed to set xattr with error %d", ret);
 	} else {
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+					   object->object_size,
 					   be64_to_cpup((__be64 *)buf->data),
 					   buf->content,
 					   cachefiles_coherency_set_ok);
@@ -103,9 +105,11 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 {
 	struct cachefiles_xattr *buf;
 	struct dentry *dentry = file->f_path.dentry;
+	struct inode *inode = file_inode(file);
 	unsigned int len = object->cookie->aux_len, tlen;
 	const void *p = fscache_get_aux(object->cookie);
 	enum cachefiles_coherency_trace why;
+	unsigned long long obj_size;
 	ssize_t xlen;
 	int ret = -ESTALE;
 
@@ -120,36 +124,41 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 	if (xlen != tlen) {
 		if (xlen < 0) {
 			ret = xlen;
-			trace_cachefiles_vfs_error(object, file_inode(file), xlen,
+			trace_cachefiles_vfs_error(object, inode, xlen,
 						   cachefiles_trace_getxattr_error);
 		}
 		if (xlen == -EIO)
 			cachefiles_io_error_obj(
 				object,
 				"Failed to read aux with error %zd", xlen);
-		why = cachefiles_coherency_check_xattr;
+		trace_cachefiles_coherency(object, inode->i_ino, 0, 0, 0,
+					   cachefiles_coherency_check_xattr);
 		goto out;
 	}
 
+	obj_size = be64_to_cpu(buf->object_size);
 	if (buf->type != CACHEFILES_COOKIE_TYPE_DATA) {
 		why = cachefiles_coherency_check_type;
 	} else if (memcmp(buf->data, p, len) != 0) {
 		why = cachefiles_coherency_check_aux;
-	} else if (be64_to_cpu(buf->object_size) != object->cookie->object_size) {
+	} else if (obj_size != object->cookie->object_size) {
 		why = cachefiles_coherency_check_objsize;
 	} else if (buf->content == CACHEFILES_CONTENT_DIRTY) {
 		// TODO: Begin conflict resolution
 		pr_warn("Dirty object in cache\n");
 		why = cachefiles_coherency_check_dirty;
 	} else {
+		object->content_info = buf->content;
+		object->object_size = obj_size;
+		atomic64_set(&object->read_limit, i_size_read(inode));
 		why = cachefiles_coherency_check_ok;
 		ret = 0;
 	}
 
-out:
-	trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+	trace_cachefiles_coherency(object, inode->i_ino, obj_size,
 				   be64_to_cpup((__be64 *)buf->data),
 				   buf->content, why);
+out:
 	kfree(buf);
 	return ret;
 }
@@ -163,6 +172,9 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 {
 	int ret;
 
+	trace_cachefiles_coherency(object, d_inode(dentry)->i_ino, 0, 0, 0,
+				   cachefiles_coherency_remove);
+
 	ret = cachefiles_inject_remove_error();
 	if (ret == 0) {
 		ret = mnt_want_write(cache->mnt);
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 76d0f6a29aba..8f96bc0f6c03 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -127,21 +127,6 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq,
 	return subreq->len;
 }
 
-static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_request *rreq,
-						     struct netfs_io_subrequest *subreq,
-						     loff_t i_size)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-	enum netfs_io_source source;
-
-	if (!cres->ops)
-		return NETFS_DOWNLOAD_FROM_SERVER;
-	source = cres->ops->prepare_read(subreq, i_size);
-	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-	return source;
-
-}
-
 /*
  * Issue a read against the cache.
  * - Eats the caller's ref on subreq.
@@ -156,6 +141,19 @@ static void netfs_read_cache_to_pagecache(struct netfs_io_request *rreq,
 			netfs_cache_read_terminated, subreq);
 }
 
+int netfs_read_query_cache(struct netfs_io_request *rreq, struct fscache_occupancy *occ)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+
+	occ->granularity = PAGE_SIZE;
+	if (occ->query_from >= occ->query_to)
+		return 0;
+	if (!cres->ops)
+		return 0;
+	occ->query_from = round_up(occ->query_from, occ->granularity);
+	return cres->ops->query_occupancy(cres, occ);
+}
+
 void netfs_queue_read(struct netfs_io_request *rreq,
 		      struct netfs_io_subrequest *subreq)
 {
@@ -209,15 +207,54 @@ static void netfs_issue_read(struct netfs_io_request *rreq,
 static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 				    struct readahead_control *ractl)
 {
+	struct fscache_occupancy _occ = {
+		.query_from	= rreq->start,
+		.query_to	= rreq->start + rreq->len,
+		.cached_from[0]	= 0,
+		.cached_to[0]	= 0,
+		.cached_from[1]	= ULLONG_MAX,
+		.cached_to[1]	= ULLONG_MAX,
+	};
+	struct fscache_occupancy *occ = &_occ;
 	unsigned long long start = rreq->start;
 	ssize_t size = rreq->len;
 	int ret = 0;
 
 	do {
+		int (*prepare_read)(struct netfs_io_subrequest *subreq) = NULL;
 		struct netfs_io_subrequest *subreq;
-		enum netfs_io_source source = NETFS_SOURCE_UNKNOWN;
+		unsigned long long hole_to, cache_to;
 		ssize_t slice;
 
+		/* If we don't have any, find out the next couple of data
+		 * extents from the cache, containing of following the
+		 * specified start offset.  Holes have to be fetched from the
+		 * server; data regions from the cache.
+		 */
+		hole_to = occ->cached_from[0];
+		cache_to = occ->cached_to[0];
+		if (start >= cache_to) {
+			/* Extent exhausted; shuffle down. */
+			int i;
+
+			for (i = 0; i < ARRAY_SIZE(occ->cached_from) - 1; i++) {
+				occ->cached_from[i] = occ->cached_from[i + 1];
+				occ->cached_to[i]   = occ->cached_to[i + 1];
+				occ->cached_type[i] = occ->cached_type[i + 1];
+			}
+			occ->cached_from[i] = ULLONG_MAX;
+			occ->cached_to[i]   = ULLONG_MAX;
+
+			if (occ->cached_from[0] != ULLONG_MAX)
+				continue;
+
+			/* Get new extents */
+			ret = netfs_read_query_cache(rreq, occ);
+			if (ret < 0)
+				break;
+			continue;
+		}
+
 		subreq = netfs_alloc_subrequest(rreq);
 		if (!subreq) {
 			ret = -ENOMEM;
@@ -229,63 +266,75 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 
 		netfs_queue_read(rreq, subreq);
 
-		source = netfs_cache_prepare_read(rreq, subreq, rreq->i_size);
-		subreq->source = source;
-		if (source == NETFS_DOWNLOAD_FROM_SERVER) {
-			unsigned long long zero_point = netfs_read_zero_point(rreq->inode);
-			unsigned long long zp = umin(zero_point, rreq->i_size);
-			size_t len = subreq->len;
-
-			if (unlikely(rreq->origin == NETFS_READ_SINGLE))
-				zp = rreq->i_size;
-			if (subreq->start >= zp) {
-				subreq->source = source = NETFS_FILL_WITH_ZEROES;
-				goto fill_with_zeroes;
+		unsigned long long zero_point = netfs_read_zero_point(rreq->inode);
+		unsigned long long zlimit = umin(zero_point, rreq->i_size);
+
+		_debug("rsub %llx %llx-%llx", subreq->start, hole_to, cache_to);
+
+		if (start >= hole_to && start < cache_to) {
+			/* Overlap with a cached region, where the cache may
+			 * record a block of zeroes.
+			 */
+			_debug("cached s=%llx c=%llx l=%zx", start, cache_to, size);
+			subreq->len = umin(cache_to - start, size);
+			subreq->len = round_up(subreq->len, occ->granularity);
+			if (occ->cached_type[0] == FSCACHE_EXTENT_ZERO) {
+				subreq->source = NETFS_FILL_WITH_ZEROES;
+				netfs_stat(&netfs_n_rh_zero);
+			} else {
+				subreq->source = NETFS_READ_FROM_CACHE;
+				prepare_read = rreq->cache_resources.ops->prepare_read;
 			}
 
-			if (len > zp - subreq->start)
-				len = zp - subreq->start;
-			if (len == 0) {
-				pr_err("ZERO-LEN READ: R=%08x[%x] l=%zx/%zx s=%llx z=%llx i=%llx",
-				       rreq->debug_id, subreq->debug_index,
-				       subreq->len, size,
-				       subreq->start, zero_point, rreq->i_size);
-				netfs_cancel_read(subreq, ret);
-				break;
-			}
-			subreq->len = len;
-
-			netfs_stat(&netfs_n_rh_download);
-			if (rreq->netfs_ops->prepare_read) {
-				ret = rreq->netfs_ops->prepare_read(subreq);
-				if (ret < 0) {
-					netfs_cancel_read(subreq, ret);
-					break;
-				}
-				trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-			}
-			goto issue;
-		}
+			trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 
-	fill_with_zeroes:
-		if (source == NETFS_FILL_WITH_ZEROES) {
+		} else if (subreq->start >= zlimit && size > 0) {
+			/* If this range lies beyond the zero-point, that part
+			 * can just be cleared locally.
+			 */
+			_debug("zero %llx-%llx", start, start + size);
+			subreq->len = size;
 			subreq->source = NETFS_FILL_WITH_ZEROES;
-			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+			if (rreq->cache_resources.ops)
+				__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 			netfs_stat(&netfs_n_rh_zero);
-			goto issue;
+		} else {
+			/* Read a cache hole from the server.  If any part of
+			 * this range lies beyond the zero-point or the EOF,
+			 * that part can just be cleared locally.
+			 */
+			unsigned long long limit = min3(zlimit, start + size, hole_to);
+
+			_debug("limit %llx %llx", rreq->i_size, zero_point);
+			_debug("download %llx-%llx", start, start + size);
+			subreq->len = umin(limit - subreq->start, ULONG_MAX);
+			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
+			if (rreq->cache_resources.ops)
+				__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
+			netfs_stat(&netfs_n_rh_download);
 		}
 
-		if (source == NETFS_READ_FROM_CACHE) {
-			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-			goto issue;
+		if (size == 0) {
+			pr_err("ZERO-LEN READ: R=%08x[%x] l=%zx/%zx s=%llx z=%llx i=%llx",
+			       rreq->debug_id, subreq->debug_index,
+			       subreq->len, size,
+			       subreq->start, zero_point, rreq->i_size);
+			netfs_cancel_read(subreq, ret);
+			break;
 		}
 
-		pr_err("Unexpected read source %u\n", source);
-		WARN_ON_ONCE(1);
-		netfs_cancel_read(subreq, ret);
-		break;
+		rreq->io_streams[0].sreq_max_len = MAX_RW_COUNT;
+		rreq->io_streams[0].sreq_max_segs = INT_MAX;
+
+		if (prepare_read) {
+			ret = prepare_read(subreq);
+			if (ret < 0) {
+				netfs_cancel_read(subreq, ret);
+				break;
+			}
+			trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
+		}
 
-	issue:
 		slice = netfs_prepare_read_iterator(subreq, ractl);
 		if (slice < 0) {
 			ret = slice;
@@ -299,6 +348,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 			set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
 		}
 
+		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 		netfs_issue_read(rreq, subreq);
 
 		if (test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 2cdb68e6b16f..350eb43ecc00 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -54,9 +54,6 @@ void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
 	i_size = i_size_read(inode);
 	if (end > i_size) {
 		i_size_write(inode, end);
-#if IS_ENABLED(CONFIG_FSCACHE)
-		fscache_update_cookie(ctx->cache, NULL, &end);
-#endif
 
 		gap = SECTOR_SIZE - (i_size & (SECTOR_SIZE - 1));
 		if (copied > gap) {
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d889caa401dc..317fa9c1aac5 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -23,6 +23,8 @@
 /*
  * buffered_read.c
  */
+int netfs_read_query_cache(struct netfs_io_request *rreq,
+			   struct fscache_occupancy *occ);
 void netfs_queue_read(struct netfs_io_request *rreq,
 		      struct netfs_io_subrequest *subreq);
 void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error);
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index f59a70f3a086..bf45b1f5f3e0 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -267,6 +267,7 @@ void netfs_retry_reads(struct netfs_io_request *rreq)
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
 
 	netfs_stat(&netfs_n_rh_retry_read_req);
+	trace_netfs_rreq(rreq, netfs_rreq_trace_retry_begin);
 
 	/* Wait for all outstanding I/O to quiesce before performing retries as
 	 * we may need to renegotiate the I/O sizes.
@@ -277,6 +278,7 @@ void netfs_retry_reads(struct netfs_io_request *rreq)
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
 	netfs_retry_read_subrequests(rreq);
+	trace_netfs_rreq(rreq, netfs_rreq_trace_retry_end);
 }
 
 /*
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index 8833550d2eb6..af16c91947b5 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -58,20 +58,6 @@ static int netfs_single_begin_cache_read(struct netfs_io_request *rreq, struct n
 	return fscache_begin_read_operation(&rreq->cache_resources, netfs_i_cookie(ctx));
 }
 
-static void netfs_single_cache_prepare_read(struct netfs_io_request *rreq,
-					    struct netfs_io_subrequest *subreq)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-
-	if (!cres->ops) {
-		subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
-		return;
-	}
-	subreq->source = cres->ops->prepare_read(subreq, rreq->i_size);
-	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-
-}
-
 static void netfs_single_read_cache(struct netfs_io_request *rreq,
 				    struct netfs_io_subrequest *subreq)
 {
@@ -89,6 +75,14 @@ static void netfs_single_read_cache(struct netfs_io_request *rreq,
  */
 static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 {
+	struct fscache_occupancy occ = {
+		.query_from	= 0,
+		.query_to	= rreq->len,
+		.cached_from[0]	= ULLONG_MAX,
+		.cached_to[0]	= ULLONG_MAX,
+		.cached_from[1]	= ULLONG_MAX,
+		.cached_to[1]	= ULLONG_MAX,
+	};
 	struct netfs_io_subrequest *subreq;
 	int ret = 0;
 
@@ -96,14 +90,21 @@ static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 	if (!subreq)
 		return -ENOMEM;
 
-	subreq->source	= NETFS_SOURCE_UNKNOWN;
+	subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
 	subreq->start	= 0;
 	subreq->len	= rreq->len;
 	subreq->io_iter	= rreq->buffer.iter;
 
 	netfs_queue_read(rreq, subreq);
 
-	netfs_single_cache_prepare_read(rreq, subreq);
+	/* Try to use the cache if the cache content matches the size of the
+	 * remote file.
+	 */
+	netfs_read_query_cache(rreq, &occ);
+	if (occ.cached_from[0] == 0 &&
+	    occ.cached_to[0] == rreq->len)
+		subreq->source = NETFS_READ_FROM_CACHE;
+
 	switch (subreq->source) {
 	case NETFS_DOWNLOAD_FROM_SERVER:
 		netfs_stat(&netfs_n_rh_download);
@@ -119,6 +120,12 @@ static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 		rreq->submitted += subreq->len;
 		break;
 	case NETFS_READ_FROM_CACHE:
+		if (rreq->cache_resources.ops->prepare_read) {
+			ret = rreq->cache_resources.ops->prepare_read(subreq);
+			if (ret < 0)
+				goto cancel;
+		}
+
 		smp_wmb(); /* Write lists before ALL_QUEUED. */
 		set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
 		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 24fc2bb2f8a4..9e837cf0eb8f 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -188,6 +188,26 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 	wreq->buffer.first_tail_slot = slot;
 }
 
+/*
+ * Collect cache results.
+ */
+static void netfs_cache_collect(struct netfs_io_request *wreq,
+				struct netfs_io_stream *stream,
+				enum netfs_cache_collect block_type)
+{
+	struct netfs_cache_resources *cres = &wreq->cache_resources;
+
+	if (stream->source != NETFS_WRITE_TO_CACHE ||
+	    wreq->cache_coll_to >= stream->collected_to)
+		return;
+
+	if (cres->ops && cres->ops->collect_write)
+		cres->ops->collect_write(wreq, wreq->cache_coll_to,
+					 stream->collected_to - wreq->cache_coll_to,
+					 block_type);
+	wreq->cache_coll_to = stream->collected_to;
+}
+
 /*
  * Collect and assess the results of various write subrequests.  We may need to
  * retry some of the results - or even do an RMW cycle for content crypto.
@@ -236,13 +256,16 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 		/* Read first subreq pointer before IN_PROGRESS flag. */
 
 		while (front) {
+			bool cancelled;
 			trace_netfs_collect_sreq(wreq, front);
 			//_debug("sreq [%x] %llx %zx/%zx",
 			//       front->debug_index, front->start, front->transferred, front->len);
 
 			if (stream->collected_to < front->start) {
 				trace_netfs_collect_gap(wreq, stream, issued_to, 'F');
+				netfs_cache_collect(wreq, stream, NETFS_CACHE_COLLECT_WRITE_DATA);
 				stream->collected_to = front->start;
+				netfs_cache_collect(wreq, stream, NETFS_CACHE_COLLECT_WRITE_GAP);
 			}
 
 			/* Stall if the front is still undergoing I/O. */
@@ -250,7 +273,6 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 				notes |= HIT_PENDING;
 				break;
 			}
-			smp_rmb(); /* Read counters after I-P flag. */
 
 			if (stream->failed) {
 				stream->collected_to = front->start + front->len;
@@ -263,15 +285,45 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 				stream->transferred_valid = true;
 				notes |= MADE_PROGRESS;
 			}
-			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
-				stream->failed = true;
-				stream->error = front->error;
-				if (stream->source == NETFS_UPLOAD_TO_SERVER)
-					mapping_set_error(wreq->mapping, front->error);
-				notes |= NEED_REASSESS | SAW_FAILURE;
+
+			/* Handle failed or cancelled subreqs.  Failure of
+			 * cache writes are handled differently to upload
+			 * failures.  Cache writes aren't fatal, provided we're
+			 * not doing disconnected operation, and so we can kind
+			 * of treat them as if they had succeeded - except that
+			 * we need to log any holes they cause.
+			 */
+			switch (stream->source) {
+			case NETFS_UPLOAD_TO_SERVER:
+				if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
+					if (!stream->failed) {
+						stream->failed = true;
+						stream->error = front->error;
+						mapping_set_error(wreq->mapping, front->error);
+						break;
+					}
+					notes |= NEED_REASSESS | SAW_FAILURE;
+				}
+				break;
+
+			case NETFS_WRITE_TO_CACHE:
+				cancelled = test_bit(NETFS_SREQ_CANCELLED, &front->flags);
+				if (cancelled != stream->cancelled &&
+				    stream->collected_to < front->start) {
+					trace_netfs_rreq(wreq, netfs_rreq_trace_cache_fail_collect);
+					netfs_cache_collect(wreq, stream,
+							    cancelled ?
+							    NETFS_CACHE_COLLECT_WRITE_CANCEL :
+							    NETFS_CACHE_COLLECT_WRITE_DATA);
+					stream->cancelled = !stream->cancelled;
+				}
+				break;
+
+			default:
+				WARN_ON(1);
 				break;
 			}
-			if (front->transferred < front->len) {
+			if (test_bit(NETFS_SREQ_NEED_RETRY, &front->flags)) {
 				stream->need_retry = true;
 				notes |= NEED_RETRY | MADE_PROGRESS;
 				break;
@@ -360,6 +412,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
  */
 bool netfs_write_collection(struct netfs_io_request *wreq)
 {
+	struct netfs_io_stream *cstream = &wreq->io_streams[1];
 	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	size_t transferred;
 	bool transferred_valid = false;
@@ -395,13 +448,22 @@ bool netfs_write_collection(struct netfs_io_request *wreq)
 		wreq->transferred = transferred;
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 
-	if (wreq->io_streams[1].active &&
-	    wreq->io_streams[1].failed &&
-	    ictx->ops->invalidate_cache) {
-		/* Cache write failure doesn't prevent writeback completion
-		 * unless we're in disconnected mode.
-		 */
-		ictx->ops->invalidate_cache(wreq);
+	if (cstream->active) {
+		if (test_bit(NETFS_RREQ_CACHE_ERROR, &wreq->flags)) {
+			if (ictx->ops->invalidate_cache) {
+				/* Cache write failure doesn't prevent
+				 * writeback completion unless we're in
+				 * disconnected mode.
+				 */
+				trace_netfs_rreq(wreq, netfs_rreq_trace_inval_cache);
+				ictx->ops->invalidate_cache(wreq);
+			}
+		} else if (!cstream->failed) {
+			netfs_cache_collect(wreq, cstream,
+					    cstream->cancelled ?
+					    NETFS_CACHE_COLLECT_WRITE_CANCEL :
+					    NETFS_CACHE_COLLECT_WRITE_DATA);
+		}
 	}
 
 	_debug("finished");
@@ -476,24 +538,51 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error)
 
 	if (IS_ERR_VALUE(transferred_or_error)) {
 		subreq->error = transferred_or_error;
-		/* if need retry is set, error should not matter */
-		if (!test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
-			set_bit(NETFS_SREQ_FAILED, &subreq->flags);
-			trace_netfs_failure(wreq, subreq, transferred_or_error, netfs_fail_write);
-		}
 
 		switch (subreq->source) {
 		case NETFS_WRITE_TO_CACHE:
+			/* We don't mark a cache-write subreq as failed.
+			 * Instead we tell the issuer to produce dummy subreqs
+			 * instead and make a note if we need to invalidate the
+			 * cache at the end.  We also don't pause the loop that
+			 * grabs pages and launches upload subreqs.
+			 *
+			 * Note that we need to distinguish between -ENOBUFS
+			 * (no space available in the cache) and other errors.
+			 * In the former case, we can keep the data we have,
+			 * though we might have to change the way the on-disk
+			 * data is tracked.
+			 */
 			netfs_stat(&netfs_n_wh_write_failed);
+			if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
+				break;
+
+			trace_netfs_failure(wreq, subreq, transferred_or_error, netfs_fail_write);
+			__set_bit(NETFS_SREQ_CANCELLED, &subreq->flags);
+			set_bit(NETFS_RREQ_CACHE_STOP, &wreq->flags);
+			if (transferred_or_error == -ENOBUFS)
+				trace_netfs_rreq(wreq, netfs_rreq_trace_cache_no_space);
+			else if (!test_and_set_bit(NETFS_RREQ_CACHE_ERROR, &wreq->flags))
+				trace_netfs_rreq(wreq, netfs_rreq_trace_cache_failed);
+			subreq->transferred = subreq->len;
 			break;
+
 		case NETFS_UPLOAD_TO_SERVER:
+			/* If need_retry is set, error should not matter */
+			if (!test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+				set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+				trace_netfs_failure(wreq, subreq, transferred_or_error,
+						    netfs_fail_upload);
+			}
+
+			set_bit(NETFS_RREQ_PAUSE, &wreq->flags);
+			trace_netfs_rreq(wreq, netfs_rreq_trace_set_pause);
 			netfs_stat(&netfs_n_wh_upload_failed);
 			break;
+
 		default:
 			break;
 		}
-		trace_netfs_rreq(wreq, netfs_rreq_trace_set_pause);
-		set_bit(NETFS_RREQ_PAUSE, &wreq->flags);
 	} else {
 		if (WARN(transferred_or_error > subreq->len - subreq->transferred,
 			 "Subreq excess write: R=%x[%x] %zd > %zu - %zu",
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index c03c7cc45e47..7f38b6676002 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -112,6 +112,8 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 		goto nomem;
 
 	wreq->cleaned_to = wreq->start;
+	if (wreq->cache_resources.dio_size > 1)
+		wreq->cache_coll_to = round_down(wreq->start, wreq->cache_resources.dio_size);
 
 	wreq->io_streams[0].stream_nr		= 0;
 	wreq->io_streams[0].source		= NETFS_UPLOAD_TO_SERVER;
@@ -231,6 +233,21 @@ static void netfs_do_issue_write(struct netfs_io_stream *stream,
 
 	_enter("R=%x[%x],%zx", wreq->debug_id, subreq->debug_index, subreq->len);
 
+	if (stream->source == NETFS_WRITE_TO_CACHE &&
+	    unlikely(test_bit(NETFS_RREQ_CACHE_STOP, &wreq->flags))) {
+		size_t dio_size = wreq->cache_resources.dio_size;
+		size_t len, disp;
+
+		disp = subreq->start & (dio_size - 1);
+		len = round_up(subreq->len + disp, dio_size);
+
+		subreq->start -= disp;
+		subreq->len = len;
+
+		__set_bit(NETFS_SREQ_CANCELLED, &subreq->flags);
+		return netfs_write_subrequest_terminated(subreq, subreq->len);
+	}
+
 	if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 		return netfs_write_subrequest_terminated(subreq, subreq->error);
 
@@ -264,6 +281,7 @@ void netfs_issue_write(struct netfs_io_request *wreq,
 
 	if (!subreq)
 		return;
+
 	stream->construct = NULL;
 	subreq->io_iter.count = subreq->len;
 	netfs_do_issue_write(stream, subreq);
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 32735abfa03f..32e1058bf252 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -206,6 +206,7 @@ void netfs_retry_writes(struct netfs_io_request *wreq)
 	int s;
 
 	netfs_stat(&netfs_n_wh_retry_write_req);
+	trace_netfs_rreq(wreq, netfs_rreq_trace_retry_begin);
 
 	/* Wait for all outstanding I/O to quiesce before performing retries as
 	 * we may need to renegotiate the I/O sizes.
@@ -230,4 +231,6 @@ void netfs_retry_writes(struct netfs_io_request *wreq)
 			netfs_retry_write_stream(wreq, stream);
 		}
 	}
+
+	trace_netfs_rreq(wreq, netfs_rreq_trace_retry_end);
 }
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 58fdb9605425..850d20241075 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -147,6 +147,23 @@ struct fscache_cookie {
 	};
 };
 
+enum fscache_extent_type {
+	FSCACHE_EXTENT_DATA,
+	FSCACHE_EXTENT_ZERO,
+} __mode(byte);
+
+/*
+ * Cache occupancy information.
+ */
+struct fscache_occupancy {
+	unsigned long long	query_from;	/* Point to query from */
+	unsigned long long	query_to;	/* Point to query to */
+	unsigned long long	cached_from[2];	/* Point at which cache extents start */
+	unsigned long long	cached_to[2];	/* Point at which cache extents end */
+	unsigned int		granularity;	/* Granularity desired */
+	enum fscache_extent_type cached_type[2];	/* Type of cache extent */
+};
+
 /*
  * slow-path functions for when there is actually caching available, and the
  * netfs does actually have a valid token
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 243c0f737938..a83a4ea86e2b 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -22,6 +22,7 @@
 
 enum netfs_sreq_ref_trace;
 typedef struct mempool mempool_t;
+struct fscache_occupancy;
 struct folio_queue;
 
 /**
@@ -150,6 +151,7 @@ struct netfs_io_stream {
 	bool			need_retry;	/* T if this stream needs retrying */
 	bool			failed;		/* T if this stream failed */
 	bool			transferred_valid; /* T is ->transferred is valid */
+	bool			cancelled;	/* T if stream is cancelled */
 };
 
 /*
@@ -159,8 +161,10 @@ struct netfs_cache_resources {
 	const struct netfs_cache_ops	*ops;
 	void				*cache_priv;
 	void				*cache_priv2;
+	unsigned long long		cache_i_size;	/* Initial size of cache file */
 	unsigned int			debug_id;	/* Cookie debug ID */
 	unsigned int			inval_counter;	/* object->inval_counter at begin_op */
+	unsigned int			dio_size;	/* DIO block size */
 };
 
 /*
@@ -195,6 +199,7 @@ struct netfs_io_subrequest {
 #define NETFS_SREQ_IN_PROGRESS		8	/* Unlocked when the subrequest completes */
 #define NETFS_SREQ_NEED_RETRY		9	/* Set if the filesystem requests a retry */
 #define NETFS_SREQ_FAILED		10	/* Set if the subreq failed unretryably */
+#define NETFS_SREQ_CANCELLED		11	/* Set if the subreq was cancelled by netfslib */
 };
 
 enum netfs_io_origin {
@@ -250,6 +255,7 @@ struct netfs_io_request {
 	unsigned long long	start;		/* Start position */
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
 	unsigned long long	collected_to;	/* Point we've collected to */
+	unsigned long long	cache_coll_to;	/* Point the cache has collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
 	unsigned long long	abandon_to;	/* Position to abandon folios to */
 	const struct folio	*no_unlock_folio; /* Don't unlock this folio after read */
@@ -271,11 +277,13 @@ struct netfs_io_request {
 #define NETFS_RREQ_FAILED		3	/* The request failed */
 #define NETFS_RREQ_RETRYING		4	/* Set if we're in the retry path */
 #define NETFS_RREQ_SHORT_TRANSFER	5	/* Set if we have a short transfer */
-#define NETFS_RREQ_OFFLOAD_COLLECTION	8	/* Offload collection to workqueue */
-#define NETFS_RREQ_NO_UNLOCK_FOLIO	9	/* Don't unlock no_unlock_folio on completion */
-#define NETFS_RREQ_FOLIO_COPY_TO_CACHE	10	/* Copy current folio to cache from read */
-#define NETFS_RREQ_UPLOAD_TO_SERVER	11	/* Need to write to the server */
-#define NETFS_RREQ_USE_IO_ITER		12	/* Use ->io_iter rather than ->i_pages */
+#define NETFS_RREQ_CACHE_STOP		8	/* Set to stop caching (ENOBUFS or error) */
+#define NETFS_RREQ_CACHE_ERROR		9	/* Set if we got an error from the cache */
+#define NETFS_RREQ_OFFLOAD_COLLECTION	12	/* Offload collection to workqueue */
+#define NETFS_RREQ_NO_UNLOCK_FOLIO	13	/* Don't unlock no_unlock_folio on completion */
+#define NETFS_RREQ_FOLIO_COPY_TO_CACHE	14	/* Copy current folio to cache from read */
+#define NETFS_RREQ_UPLOAD_TO_SERVER	15	/* Need to write to the server */
+#define NETFS_RREQ_USE_IO_ITER		16	/* Use ->io_iter rather than ->i_pages */
 #define NETFS_RREQ_USE_PGPRIV2		31	/* [DEPRECATED] Use PG_private_2 to mark
 						 * write to cache on read */
 	const struct netfs_request_ops *netfs_ops;
@@ -320,6 +328,12 @@ enum netfs_read_from_hole {
 	NETFS_READ_HOLE_FAIL,
 };
 
+enum netfs_cache_collect {
+	NETFS_CACHE_COLLECT_WRITE_DATA,
+	NETFS_CACHE_COLLECT_WRITE_GAP,
+	NETFS_CACHE_COLLECT_WRITE_CANCEL,
+};
+
 /*
  * Table of operations for access to a cache.
  */
@@ -354,8 +368,7 @@ struct netfs_cache_ops {
 	/* Prepare a read operation, shortening it to a cached/uncached
 	 * boundary as appropriate.
 	 */
-	enum netfs_io_source (*prepare_read)(struct netfs_io_subrequest *subreq,
-					     unsigned long long i_size);
+	int (*prepare_read)(struct netfs_io_subrequest *subreq);
 
 	/* Prepare a write subrequest, working out if we're allowed to do it
 	 * and finding out the maximum amount of data to gather before
@@ -383,8 +396,17 @@ struct netfs_cache_ops {
 	 * next chunk of data starts and how long it is.
 	 */
 	int (*query_occupancy)(struct netfs_cache_resources *cres,
-			       loff_t start, size_t len, size_t granularity,
-			       loff_t *_data_start, size_t *_data_len);
+			       struct fscache_occupancy *occ);
+
+	/* Collect the result of buffered writeback to the cache.  This
+	 * includes copying a read to the cache.  block_type is one of:
+	 * - NETFS_CACHE_COLLECT_WRITE_DATA for a block of data
+	 * - NETFS_CACHE_COLLECT_WRITE_GAP if a discontiguity was skipped
+	 * - NETFS_CACHE_COLLECT_WRITE_CANCEL for a cancellation gap
+	 */
+	void (*collect_write)(struct netfs_io_request *wreq,
+			      unsigned long long start, size_t len,
+			      enum netfs_cache_collect block_type);
 };
 
 /* High-level read API. */
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 6e3b1424eea4..a03f085793f2 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -56,6 +56,8 @@ enum cachefiles_coherency_trace {
 	cachefiles_coherency_check_ok,
 	cachefiles_coherency_check_type,
 	cachefiles_coherency_check_xattr,
+	cachefiles_coherency_discontiguous,
+	cachefiles_coherency_remove,
 	cachefiles_coherency_set_fail,
 	cachefiles_coherency_set_ok,
 	cachefiles_coherency_vol_check_cmp,
@@ -67,6 +69,7 @@ enum cachefiles_coherency_trace {
 };
 
 enum cachefiles_trunc_trace {
+	cachefiles_trunc_clear_padding,
 	cachefiles_trunc_dio_adjust,
 	cachefiles_trunc_expand_tmpfile,
 	cachefiles_trunc_shrink,
@@ -84,6 +87,7 @@ enum cachefiles_prepare_read_trace {
 };
 
 enum cachefiles_error_trace {
+	cachefiles_trace_alignment_error,
 	cachefiles_trace_fallocate_error,
 	cachefiles_trace_getxattr_error,
 	cachefiles_trace_link_error,
@@ -144,6 +148,8 @@ enum cachefiles_error_trace {
 	EM(cachefiles_coherency_check_ok,	"OK      ")		\
 	EM(cachefiles_coherency_check_type,	"BAD type")		\
 	EM(cachefiles_coherency_check_xattr,	"BAD xatt")		\
+	EM(cachefiles_coherency_discontiguous,	"--- gap ")		\
+	EM(cachefiles_coherency_remove,		"REMOVE  ")		\
 	EM(cachefiles_coherency_set_fail,	"SET fail")		\
 	EM(cachefiles_coherency_set_ok,		"SET ok  ")		\
 	EM(cachefiles_coherency_vol_check_cmp,	"VOL BAD cmp ")		\
@@ -154,6 +160,7 @@ enum cachefiles_error_trace {
 	E_(cachefiles_coherency_vol_set_ok,	"VOL SET ok  ")
 
 #define cachefiles_trunc_traces						\
+	EM(cachefiles_trunc_clear_padding,	"CLRPAD")		\
 	EM(cachefiles_trunc_dio_adjust,		"DIOADJ")		\
 	EM(cachefiles_trunc_expand_tmpfile,	"EXPTMP")		\
 	E_(cachefiles_trunc_shrink,		"SHRINK")
@@ -169,6 +176,7 @@ enum cachefiles_error_trace {
 	E_(cachefiles_trace_read_seek_nxio,	"seek-enxio")
 
 #define cachefiles_error_traces						\
+	EM(cachefiles_trace_alignment_error,	"align")		\
 	EM(cachefiles_trace_fallocate_error,	"fallocate")		\
 	EM(cachefiles_trace_getxattr_error,	"getxattr")		\
 	EM(cachefiles_trace_link_error,		"link")			\
@@ -379,12 +387,12 @@ TRACE_EVENT(cachefiles_rename,
 
 TRACE_EVENT(cachefiles_coherency,
 	    TP_PROTO(struct cachefiles_object *obj,
-		     ino_t ino,
+		     ino_t ino, unsigned long long obj_size,
 		     u64 disk_aux,
 		     enum cachefiles_content content,
 		     enum cachefiles_coherency_trace why),
 
-	    TP_ARGS(obj, ino, disk_aux, content, why),
+	    TP_ARGS(obj, ino, obj_size, disk_aux, content, why),
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
@@ -392,6 +400,7 @@ TRACE_EVENT(cachefiles_coherency,
 		    __field(enum cachefiles_coherency_trace,	why)
 		    __field(enum cachefiles_content,		content)
 		    __field(u64,				ino)
+		    __field(u64,				obj_size)
 		    __field(u64,				aux)
 		    __field(u64,				disk_aux)
 			     ),
@@ -401,14 +410,16 @@ TRACE_EVENT(cachefiles_coherency,
 		    __entry->why	= why;
 		    __entry->content	= content;
 		    __entry->ino	= ino;
+		    __entry->obj_size	= obj_size;
 		    __entry->aux	= be64_to_cpup((__be64 *)obj->cookie->inline_aux);
 		    __entry->disk_aux	= disk_aux;
 			   ),
 
-	    TP_printk("o=%08x %s B=%llx c=%u aux=%llx dsk=%llx",
+	    TP_printk("o=%08x %s B=%llx oz=%llx c=%u aux=%llx dsk=%llx",
 		      __entry->obj,
 		      __print_symbolic(__entry->why, cachefiles_coherency_traces),
 		      __entry->ino,
+		      __entry->obj_size,
 		      __entry->content,
 		      __entry->aux,
 		      __entry->disk_aux)
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 082cb03c6131..83d161f8c726 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -50,6 +50,10 @@
 
 #define netfs_rreq_traces					\
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
+	EM(netfs_rreq_trace_cache_cancelled,	"CA-CNCL")	\
+	EM(netfs_rreq_trace_cache_failed,	"CA-FAIL")	\
+	EM(netfs_rreq_trace_cache_fail_collect,	"CA-F-CO")	\
+	EM(netfs_rreq_trace_cache_no_space,	"CA-NOSP")	\
 	EM(netfs_rreq_trace_collect,		"COLLECT")	\
 	EM(netfs_rreq_trace_complete,		"COMPLET")	\
 	EM(netfs_rreq_trace_copy,		"COPY   ")	\
@@ -58,10 +62,13 @@
 	EM(netfs_rreq_trace_end_copy_to_cache,	"END-C2C")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
 	EM(netfs_rreq_trace_intr,		"INTR   ")	\
+	EM(netfs_rreq_trace_inval_cache,	"INVL-CA")	\
 	EM(netfs_rreq_trace_ki_complete,	"KI-CMPL")	\
 	EM(netfs_rreq_trace_recollect,		"RECLLCT")	\
 	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
 	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
+	EM(netfs_rreq_trace_retry_begin,	"RETRY-BEGIN")	\
+	EM(netfs_rreq_trace_retry_end,		"RETRY-END")	\
 	EM(netfs_rreq_trace_set_abandon,	"S-ABNDN")	\
 	EM(netfs_rreq_trace_set_pause,		"PAUSE  ")	\
 	EM(netfs_rreq_trace_unlock,		"UNLOCK ")	\
@@ -131,12 +138,12 @@
 
 #define netfs_failures							\
 	EM(netfs_fail_check_write_begin,	"check-write-begin")	\
-	EM(netfs_fail_copy_to_cache,		"copy-to-cache")	\
 	EM(netfs_fail_dio_read_short,		"dio-read-short")	\
 	EM(netfs_fail_dio_read_zero,		"dio-read-zero")	\
 	EM(netfs_fail_read,			"read")			\
 	EM(netfs_fail_short_read,		"short-read")		\
 	EM(netfs_fail_prepare_write,		"prep-write")		\
+	EM(netfs_fail_upload,			"upload")		\
 	E_(netfs_fail_write,			"write")
 
 #define netfs_rreq_ref_traces					\


