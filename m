Return-Path: <linux-nfs+bounces-20406-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBc5Og8SxWkI6AQAu9opvQ
	(envelope-from <linux-nfs+bounces-20406-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:01:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE0C333EF2
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69F5630D3774
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4326733ADAE;
	Thu, 26 Mar 2026 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgaBtYYZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484D3C7DF7
	for <linux-nfs@vger.kernel.org>; Thu, 26 Mar 2026 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522051; cv=none; b=Ceq8iN/fxEezN1V7A0oLgJKE9YNz3y0SxKF9snAyfrGq6/zIUmhqzTjR07bnbstrBX7EOuMrjX4/rGQlFYAOPH5VUDH6bDnnI+9oz51AploRXFT94UqmiwqDjMBxUA/Sv7gw5K+6pV4m04OQxykWWt4M2ULTc9y4ipfggZX3ycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522051; c=relaxed/simple;
	bh=mSttHELtORA3TF+uaSywZfpmCBiron6A6GzGwHAVu9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9UZX27AlQuuZIpFzhTzjQs4FoPhnLpdAptfqe+KlcI3Gvp0LBfGZ/bPrm5AXfyKrkmmTEiz0pWerm9hOxrf4/+YBN5/cxkuQJiizG8vGtPYzBvBq6G7fRfG6BEu2T03yiUPUQ4PTnIqONf/5ApUR9ke7ivzI/CgDPjRmaOgeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgaBtYYZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLthSvn8qvWjKJAvzgNmkKxDSR01zA8txUKhM97kKV8=;
	b=TgaBtYYZ6NnROKdqfm2iBwLYyse8fUcwp7r5g3RQrkoqYoe6ItYYp26NGPmZcaIjxYW11R
	v9FHZ53DTAU4CDUGSEmaZm/Gx/dlbJiHqSrLPvaVonmUfUC/l11dQfiTE6wXp0Io5A/9vm
	MIW6cth2HVTNbuO8UCXNnAGM4X1scYM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-2RDWs7cwP920WiGnWDa5Tg-1; Thu,
 26 Mar 2026 06:47:20 -0400
X-MC-Unique: 2RDWs7cwP920WiGnWDa5Tg-1
X-Mimecast-MFC-AGG-ID: 2RDWs7cwP920WiGnWDa5Tg_1774522038
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF695180060D;
	Thu, 26 Mar 2026 10:47:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 095E31800673;
	Thu, 26 Mar 2026 10:47:10 +0000 (UTC)
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
Subject: [PATCH 08/26] cachefiles: Don't rely on backing fs storage map for most use cases
Date: Thu, 26 Mar 2026 10:45:23 +0000
Message-ID: <20260326104544.509518-9-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20406-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,manguebit.org:email,infradead.org:email]
X-Rspamd-Queue-Id: 6FE0C333EF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 fs/cachefiles/interface.c         |  82 ++-------
 fs/cachefiles/internal.h          |  10 +-
 fs/cachefiles/io.c                | 265 +++++++++++++++++++++++-------
 fs/cachefiles/namei.c             |  19 +--
 fs/cachefiles/xattr.c             |  20 ++-
 fs/netfs/buffered_read.c          | 185 +++++++++++++--------
 fs/netfs/buffered_write.c         |   3 -
 fs/netfs/internal.h               |   2 +
 fs/netfs/read_single.c            |  39 +++--
 fs/netfs/write_collect.c          |  49 +++++-
 fs/netfs/write_issue.c            |   3 +
 include/linux/fscache.h           |  17 ++
 include/linux/netfs.h             |  16 +-
 include/trace/events/cachefiles.h |  15 +-
 15 files changed, 466 insertions(+), 260 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index f609366fd2ac..424e0c98d67f 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -436,7 +436,6 @@ static void afs_update_i_size(struct inode *inode, loff_t new_i_size)
 		inode_set_bytes(&vnode->netfs.inode, new_i_size);
 	}
 	write_sequnlock(&vnode->cb_lock);
-	fscache_update_cookie(afs_vnode_cache(vnode), NULL, &new_i_size);
 }
 
 static void afs_netfs_invalidate_cache(struct netfs_io_request *wreq)
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
index b62cd3e9a18e..00482a13fc48 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -18,8 +18,6 @@
 #include <linux/xarray.h>
 #include <linux/cachefiles.h>
 
-#define CACHEFILES_DIO_BLOCK_SIZE 4096
-
 struct cachefiles_cache;
 struct cachefiles_object;
 
@@ -68,12 +66,16 @@ struct cachefiles_object {
 	struct list_head		cache_link;	/* Link in cache->*_list */
 	struct file			*file;		/* The file representing this object */
 	char				*d_name;	/* Backing file name */
+	unsigned long			flags;
+#define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
+	unsigned long long		object_size;	/* Size of the object stored
+							 * (independent of cookie->object_size for
+							 * coherency reasons)
+							 */
 	int				debug_id;
 	spinlock_t			lock;
 	refcount_t			ref;
 	enum cachefiles_content		content_info:8;	/* Info about content presence */
-	unsigned long			flags;
-#define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	struct cachefiles_ondemand_info	*ondemand;
 #endif
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index eaf47851c65f..b5ff75697b3e 100644
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
+	unsigned long long i_size;
+	loff_t ret;
+	int i;
 
 	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_READ))
 		return -ENOBUFS;
 
 	object = cachefiles_cres_object(cres);
 	file = cachefiles_cres_file(cres);
-	granularity = max_t(size_t, object->volume->cache->bsize, granularity);
+	inode = file_inode(file);
+	occ->granularity = object->volume->cache->bsize;
+
+	_enter("%pD,%li,%llx-%llx/%llx",
+	       file, inode->i_ino, occ->query_from, occ->query_to,
+	       i_size_read(inode));
+
+	if (i_size_read(inode) == 0)
+		goto done;
+
+	switch (object->content_info) {
+	case CACHEFILES_CONTENT_ALL:
+	case CACHEFILES_CONTENT_SINGLE:
+		i_size = i_size_read(inode);
+		if (i_size > occ->query_from) {
+			occ->cached_from[0] = 0;
+			occ->cached_to[0] = i_size;
+			occ->cached_type[0] = FSCACHE_EXTENT_DATA;
+			occ->query_from = ULLONG_MAX;
+		}
+		goto done;
+	default:
+		break;
+	}
 
-	_enter("%pD,%li,%llx,%zx/%llx",
-	       file, file_inode(file)->i_ino, start, len,
-	       i_size_read(file_inode(file)));
+	for (i = 0; i < ARRAY_SIZE(occ->cached_from); i++) {
+		ret = cachefiles_inject_read_error();
+		if (ret == 0)
+			ret = file->f_op->llseek(file, occ->query_from, SEEK_DATA);
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
+			ret = file->f_op->llseek(file, occ->query_from, SEEK_HOLE);
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
@@ -711,6 +722,134 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 			 netfs_write_subrequest_terminated, subreq);
 }
 
+/*
+ * Collect the result of buffered writeback to the cache.  This includes
+ * copying a read to the cache.  Netfslib collates the results, which might
+ * occur out of order, and delivers them to the cache so that it can update its
+ * content record.
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
+				     unsigned long long start, size_t len)
+{
+	struct netfs_cache_resources *cres = &wreq->cache_resources;
+	struct cachefiles_object *object = cachefiles_cres_object(cres);
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
+	struct file *file = cachefiles_cres_file(cres);
+	unsigned long long old_size = cres->cache_i_size;
+	unsigned long long new_size = i_size_read(file_inode(file));
+	unsigned long long data_to = cookie->object_size;
+	unsigned long long end = start + len;
+	int ret;
+
+	_enter("%llx,%zx,%x", start, len, cache->bsize);
+
+	if (WARN_ON(old_size	& (cache->bsize - 1)) ||
+	    WARN_ON(new_size	& (cache->bsize - 1)) ||
+	    WARN_ON(start	& (cache->bsize - 1)) ||
+	    WARN_ON(len		& (cache->bsize - 1))) {
+		trace_cachefiles_io_error(object, file_inode(file), -EIO,
+					  cachefiles_trace_alignment_error);
+		cachefiles_remove_object_xattr(cache, object, file->f_path.dentry);
+		return;
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
+	object->content_info = CACHEFILES_CONTENT_BACKFS_MAP;
+
+clear_gap:
+	/* We need to clear any partial padding that got jumped over.  It
+	 * *should* be all zeros, but shared-writable mmap exists...
+	 */
+	if (old_size > data_to) {
+		trace_cachefiles_trunc(object, file_inode(file), data_to, old_size,
+				       cachefiles_trunc_clear_padding);
+		ret = cachefiles_inject_write_error();
+		if (ret == 0)
+			ret = vfs_fallocate(file, FALLOC_FL_ZERO_RANGE,
+					    data_to, old_size - data_to);
+		if (ret < 0) {
+			trace_cachefiles_io_error(object, file_inode(file), ret,
+						  cachefiles_trace_fallocate_error);
+			cachefiles_io_error_obj(object, "fallocate zero pad failed %d", ret);
+			cachefiles_remove_object_xattr(cache, object, file->f_path.dentry);
+			return;
+		}
+	}
+
+update_sizes:
+	cres->cache_i_size = umax(old_size, end);
+	object->object_size = cookie->object_size;
+	return;
+}
+
 /*
  * Clean up an operation.
  */
@@ -728,11 +867,11 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
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
@@ -742,14 +881,18 @@ bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
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
index 20138309733f..38d730233658 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -449,7 +449,6 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
 	struct file *file;
 	const struct path parentpath = { .mnt = cache->mnt, .dentry = fan };
-	uint64_t ni_size;
 	long ret;
 
 
@@ -481,23 +480,6 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
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
@@ -507,6 +489,7 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	}
 out:
 	cachefiles_end_secure(cache, saved_cred);
+	object->content_info = CACHEFILES_CONTENT_ALL;
 	return file;
 
 err_unuse:
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 52383b1d0ba6..27f969c41eef 100644
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
@@ -106,6 +108,7 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 	unsigned int len = object->cookie->aux_len, tlen;
 	const void *p = fscache_get_aux(object->cookie);
 	enum cachefiles_coherency_trace why;
+	unsigned long long obj_size;
 	ssize_t xlen;
 	int ret = -ESTALE;
 
@@ -127,29 +130,33 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 			cachefiles_io_error_obj(
 				object,
 				"Failed to read aux with error %zd", xlen);
-		why = cachefiles_coherency_check_xattr;
+		trace_cachefiles_coherency(object, file_inode(file)->i_ino, 0, 0, 0,
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
 		why = cachefiles_coherency_check_ok;
 		ret = 0;
 	}
 
-out:
-	trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+	trace_cachefiles_coherency(object, file_inode(file)->i_ino, obj_size,
 				   be64_to_cpup((__be64 *)buf->data),
 				   buf->content, why);
+out:
 	kfree(buf);
 	return ret;
 }
@@ -163,6 +170,9 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 {
 	int ret;
 
+	trace_cachefiles_coherency(object, d_inode(dentry)->i_ino, 0, 0, 0,
+				   cachefiles_coherency_remove);
+
 	ret = cachefiles_inject_remove_error();
 	if (ret == 0) {
 		ret = mnt_want_write(cache->mnt);
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index a8c0d86118c5..aee59ccea257 100644
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
 static void netfs_queue_read(struct netfs_io_request *rreq,
 			     struct netfs_io_subrequest *subreq,
 			     bool last_subreq)
@@ -214,16 +212,55 @@ static void netfs_issue_read(struct netfs_io_request *rreq,
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
 	struct netfs_inode *ictx = netfs_inode(rreq->inode);
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
@@ -233,65 +270,81 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 		subreq->start	= start;
 		subreq->len	= size;
 
-		source = netfs_cache_prepare_read(rreq, subreq, rreq->i_size);
-		subreq->source = source;
-		if (source == NETFS_DOWNLOAD_FROM_SERVER) {
-			unsigned long long zp = umin(ictx->zero_point, rreq->i_size);
-			size_t len = subreq->len;
-
-			if (unlikely(rreq->origin == NETFS_READ_SINGLE))
-				zp = rreq->i_size;
-			if (subreq->start >= zp) {
-				subreq->source = source = NETFS_FILL_WITH_ZEROES;
-				goto fill_with_zeroes;
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
-				       subreq->start, ictx->zero_point, rreq->i_size);
-				break;
-			}
-			subreq->len = len;
-
-			netfs_stat(&netfs_n_rh_download);
-			if (rreq->netfs_ops->prepare_read) {
-				ret = rreq->netfs_ops->prepare_read(subreq);
-				if (ret < 0) {
-					subreq->error = ret;
-					/* Not queued - release both refs. */
-					netfs_put_subrequest(subreq,
-							     netfs_sreq_trace_put_cancel);
-					netfs_put_subrequest(subreq,
-							     netfs_sreq_trace_put_cancel);
-					break;
-				}
-				trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-			}
-			goto issue;
-		}
+			trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 
-	fill_with_zeroes:
-		if (source == NETFS_FILL_WITH_ZEROES) {
+		} else if ((subreq->start >= ictx->zero_point ||
+			    subreq->start >= rreq->i_size) &&
+			   size > 0) {
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
+			unsigned long long zlimit = umin(rreq->i_size, ictx->zero_point);
+			unsigned long long limit = min3(zlimit, start + size, hole_to);
+
+			_debug("limit %llx %llx", rreq->i_size, ictx->zero_point);
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
+			       subreq->start, ictx->zero_point, rreq->i_size);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_cancel);
+			/* Not queued - release both refs. */
+			netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
+			netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
+			break;
 		}
 
-		pr_err("Unexpected read source %u\n", source);
-		WARN_ON_ONCE(1);
-		break;
+		rreq->io_streams[0].sreq_max_len = MAX_RW_COUNT;
+		rreq->io_streams[0].sreq_max_segs = INT_MAX;
+
+		if (prepare_read) {
+			ret = prepare_read(subreq);
+			if (ret < 0) {
+				subreq->error = ret;
+				/* Not queued - release both refs. */
+				netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
+				netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
+				break;
+			}
+			trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
+		}
 
-	issue:
 		slice = netfs_prepare_read_iterator(subreq, ractl);
 		if (slice < 0) {
 			ret = slice;
@@ -305,6 +358,8 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 		size -= slice;
 		start += slice;
 
+		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+
 		netfs_queue_read(rreq, subreq, size <= 0);
 		netfs_issue_read(rreq, subreq);
 		cond_resched();
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 22a4d61631c9..bce3e7109ec1 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -73,9 +73,6 @@ void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
 	i_size = i_size_read(inode);
 	if (end > i_size) {
 		i_size_write(inode, end);
-#if IS_ENABLED(CONFIG_FSCACHE)
-		fscache_update_cookie(ctx->cache, NULL, &end);
-#endif
 
 		gap = SECTOR_SIZE - (i_size & (SECTOR_SIZE - 1));
 		if (copied > gap) {
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d436e20d3418..2fcf31de5f2c 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -23,6 +23,8 @@
 /*
  * buffered_read.c
  */
+int netfs_read_query_cache(struct netfs_io_request *rreq,
+			   struct fscache_occupancy *occ);
 void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error);
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len);
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index d0e23bc42445..d87a03859ebd 100644
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
@@ -90,6 +76,14 @@ static void netfs_single_read_cache(struct netfs_io_request *rreq,
 static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 {
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
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
 
@@ -97,11 +91,19 @@ static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 	if (!subreq)
 		return -ENOMEM;
 
-	subreq->source	= NETFS_SOURCE_UNKNOWN;
+	subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
 	subreq->start	= 0;
 	subreq->len	= rreq->len;
 	subreq->io_iter	= rreq->buffer.iter;
 
+	/* Try to use the cache if the cache content matches the size of the
+	 * remote file.
+	 */
+	netfs_read_query_cache(rreq, &occ);
+	if (occ.cached_from[0] == 0 &&
+	    occ.cached_to[0] == rreq->len)
+		subreq->source = NETFS_READ_FROM_CACHE;
+
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 
 	spin_lock(&rreq->lock);
@@ -111,7 +113,6 @@ static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 	smp_store_release(&stream->active, true);
 	spin_unlock(&rreq->lock);
 
-	netfs_single_cache_prepare_read(rreq, subreq);
 	switch (subreq->source) {
 	case NETFS_DOWNLOAD_FROM_SERVER:
 		netfs_stat(&netfs_n_rh_download);
@@ -125,6 +126,12 @@ static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 		rreq->submitted += subreq->len;
 		break;
 	case NETFS_READ_FROM_CACHE:
+		if (rreq->cache_resources.ops->prepare_read) {
+			ret = rreq->cache_resources.ops->prepare_read(subreq);
+			if (ret < 0)
+				goto cancel;
+		}
+
 		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 		netfs_single_read_cache(rreq, subreq);
 		rreq->submitted += subreq->len;
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index b194447f4b11..a839735d5675 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -185,6 +185,16 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 	wreq->buffer.first_tail_slot = slot;
 }
 
+static void netfs_cache_collect(struct netfs_io_request *wreq,
+				struct netfs_io_stream *stream)
+{
+	struct netfs_cache_resources *cres = &wreq->cache_resources;
+
+	if (cres->ops && cres->ops->collect_write)
+		cres->ops->collect_write(wreq, wreq->cache_coll_to,
+					 stream->collected_to - wreq->cache_coll_to);
+}
+
 /*
  * Collect and assess the results of various write subrequests.  We may need to
  * retry some of the results - or even do an RMW cycle for content crypto.
@@ -238,6 +248,11 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 			if (stream->collected_to < front->start) {
 				trace_netfs_collect_gap(wreq, stream, issued_to, 'F');
 				stream->collected_to = front->start;
+				if (stream->source == NETFS_WRITE_TO_CACHE) {
+					if (wreq->cache_coll_to < stream->collected_to)
+						netfs_cache_collect(wreq, stream);
+					wreq->cache_coll_to = stream->collected_to;
+				}
 			}
 
 			/* Stall if the front is still undergoing I/O. */
@@ -261,8 +276,19 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
 				stream->failed = true;
 				stream->error = front->error;
-				if (stream->source == NETFS_UPLOAD_TO_SERVER)
+				switch (stream->source) {
+				case NETFS_UPLOAD_TO_SERVER:
 					mapping_set_error(wreq->mapping, front->error);
+					break;
+				case NETFS_WRITE_TO_CACHE:
+					if (wreq->cache_coll_to < stream->collected_to)
+						netfs_cache_collect(wreq, stream);
+					wreq->cache_coll_to = stream->collected_to + front->len;
+					break;
+				default:
+					WARN_ON(1);
+					break;
+				}
 				notes |= NEED_REASSESS | SAW_FAILURE;
 				break;
 			}
@@ -355,6 +381,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
  */
 bool netfs_write_collection(struct netfs_io_request *wreq)
 {
+	struct netfs_io_stream *cstream = &wreq->io_streams[1];
 	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	size_t transferred;
 	bool transferred_valid = false;
@@ -390,13 +417,19 @@ bool netfs_write_collection(struct netfs_io_request *wreq)
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
+		if (cstream->failed) {
+			if (ictx->ops->invalidate_cache)
+				/* Cache write failure doesn't prevent
+				 * writeback completion unless we're in
+				 * disconnected mode.
+				 */
+				ictx->ops->invalidate_cache(wreq);
+		} else {
+			if (wreq->cache_coll_to < cstream->collected_to)
+				netfs_cache_collect(wreq, cstream);
+			wreq->cache_coll_to = cstream->collected_to;
+		}
 	}
 
 	_debug("finished");
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 2db688f94125..2de6b8621e11 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -112,6 +112,8 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 		goto nomem;
 
 	wreq->cleaned_to = wreq->start;
+	if (wreq->cache_resources.dio_size > 1)
+		wreq->cache_coll_to = round_down(wreq->start, wreq->cache_resources.dio_size);
 
 	wreq->io_streams[0].stream_nr		= 0;
 	wreq->io_streams[0].source		= NETFS_UPLOAD_TO_SERVER;
@@ -263,6 +265,7 @@ void netfs_issue_write(struct netfs_io_request *wreq,
 
 	if (!subreq)
 		return;
+
 	stream->construct = NULL;
 	subreq->io_iter.count = subreq->len;
 	netfs_do_issue_write(stream, subreq);
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
index ba17ac5bf356..77238bc4a712 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -22,6 +22,7 @@
 
 enum netfs_sreq_ref_trace;
 typedef struct mempool mempool_t;
+struct fscache_occupancy;
 struct folio_queue;
 
 /**
@@ -159,8 +160,10 @@ struct netfs_cache_resources {
 	const struct netfs_cache_ops	*ops;
 	void				*cache_priv;
 	void				*cache_priv2;
+	unsigned long long		cache_i_size;	/* Initial size of cache file */
 	unsigned int			debug_id;	/* Cookie debug ID */
 	unsigned int			inval_counter;	/* object->inval_counter at begin_op */
+	unsigned int			dio_size;	/* DIO block size */
 };
 
 /*
@@ -250,6 +253,7 @@ struct netfs_io_request {
 	unsigned long long	start;		/* Start position */
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
 	unsigned long long	collected_to;	/* Point we've collected to */
+	unsigned long long	cache_coll_to;	/* Point the cache has collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
 	unsigned long long	abandon_to;	/* Position to abandon folios to */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
@@ -354,8 +358,7 @@ struct netfs_cache_ops {
 	/* Prepare a read operation, shortening it to a cached/uncached
 	 * boundary as appropriate.
 	 */
-	enum netfs_io_source (*prepare_read)(struct netfs_io_subrequest *subreq,
-					     unsigned long long i_size);
+	int (*prepare_read)(struct netfs_io_subrequest *subreq);
 
 	/* Prepare a write subrequest, working out if we're allowed to do it
 	 * and finding out the maximum amount of data to gather before
@@ -383,8 +386,13 @@ struct netfs_cache_ops {
 	 * next chunk of data starts and how long it is.
 	 */
 	int (*query_occupancy)(struct netfs_cache_resources *cres,
-			       loff_t start, size_t len, size_t granularity,
-			       loff_t *_data_start, size_t *_data_len);
+			       struct fscache_occupancy *occ);
+
+	/* Collect the result of buffered writeback to the cache.
+	 * This includes copying a read to the cache.
+	 */
+	void (*collect_write)(struct netfs_io_request *wreq,
+			      unsigned long long start, size_t len);
 };
 
 /* High-level read API. */
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index a743b2a35ea7..4bba6fda1f8b 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -56,6 +56,7 @@ enum cachefiles_coherency_trace {
 	cachefiles_coherency_check_ok,
 	cachefiles_coherency_check_type,
 	cachefiles_coherency_check_xattr,
+	cachefiles_coherency_remove,
 	cachefiles_coherency_set_fail,
 	cachefiles_coherency_set_ok,
 	cachefiles_coherency_vol_check_cmp,
@@ -67,6 +68,7 @@ enum cachefiles_coherency_trace {
 };
 
 enum cachefiles_trunc_trace {
+	cachefiles_trunc_clear_padding,
 	cachefiles_trunc_dio_adjust,
 	cachefiles_trunc_expand_tmpfile,
 	cachefiles_trunc_shrink,
@@ -84,6 +86,7 @@ enum cachefiles_prepare_read_trace {
 };
 
 enum cachefiles_error_trace {
+	cachefiles_trace_alignment_error,
 	cachefiles_trace_fallocate_error,
 	cachefiles_trace_getxattr_error,
 	cachefiles_trace_link_error,
@@ -144,6 +147,7 @@ enum cachefiles_error_trace {
 	EM(cachefiles_coherency_check_ok,	"OK      ")		\
 	EM(cachefiles_coherency_check_type,	"BAD type")		\
 	EM(cachefiles_coherency_check_xattr,	"BAD xatt")		\
+	EM(cachefiles_coherency_remove,		"REMOVE  ")		\
 	EM(cachefiles_coherency_set_fail,	"SET fail")		\
 	EM(cachefiles_coherency_set_ok,		"SET ok  ")		\
 	EM(cachefiles_coherency_vol_check_cmp,	"VOL BAD cmp ")		\
@@ -154,6 +158,7 @@ enum cachefiles_error_trace {
 	E_(cachefiles_coherency_vol_set_ok,	"VOL SET ok  ")
 
 #define cachefiles_trunc_traces						\
+	EM(cachefiles_trunc_clear_padding,	"CLRPAD")		\
 	EM(cachefiles_trunc_dio_adjust,		"DIOADJ")		\
 	EM(cachefiles_trunc_expand_tmpfile,	"EXPTMP")		\
 	E_(cachefiles_trunc_shrink,		"SHRINK")
@@ -169,6 +174,7 @@ enum cachefiles_error_trace {
 	E_(cachefiles_trace_read_seek_nxio,	"seek-enxio")
 
 #define cachefiles_error_traces						\
+	EM(cachefiles_trace_alignment_error,	"align")		\
 	EM(cachefiles_trace_fallocate_error,	"fallocate")		\
 	EM(cachefiles_trace_getxattr_error,	"getxattr")		\
 	EM(cachefiles_trace_link_error,		"link")			\
@@ -379,12 +385,12 @@ TRACE_EVENT(cachefiles_rename,
 
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
@@ -392,6 +398,7 @@ TRACE_EVENT(cachefiles_coherency,
 		    __field(enum cachefiles_coherency_trace,	why)
 		    __field(enum cachefiles_content,		content)
 		    __field(u64,				ino)
+		    __field(u64,				obj_size)
 		    __field(u64,				aux)
 		    __field(u64,				disk_aux)
 			     ),
@@ -401,14 +408,16 @@ TRACE_EVENT(cachefiles_coherency,
 		    __entry->why	= why;
 		    __entry->content	= content;
 		    __entry->ino	= ino;
+		    __entry->obj_size	= obj_size,
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


