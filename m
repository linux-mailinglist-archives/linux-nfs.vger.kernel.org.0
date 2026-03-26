Return-Path: <linux-nfs+bounces-20424-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBwuAAgTxWmr6QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20424-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:05:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B809233402C
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 629A631D862E
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0FD382F13;
	Thu, 26 Mar 2026 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L52BRxyi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C760382F38
	for <linux-nfs@vger.kernel.org>; Thu, 26 Mar 2026 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522209; cv=none; b=PhSCskP3Akd2F8/tyITQByc7fjvtbjlh/cqq9lI4cElucePaKscHZT4et8VdV1I3Z+ycBEbtTDgI0v3r7PgZp3aCIh988HET9KFBcQ+D9bLuOGnORZTEvrbuX6jzZDF+ydb6ySQL/dGwbDiOw9HLvvA4PSQ8oBujZPes1YUW2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522209; c=relaxed/simple;
	bh=fTHmqyJdcoTyTInHKFwKiOwCExhN1eOyZ8RhtFwOg04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh4QF+iyMRK5FuEFSx2xTCldktO2ixFhpArAUdCtSIuSbRlOe4W6s2bOmhoYBYkosHtPzcZoQDYGkEq/F7tI9jkSarrYzYNuDZ00Wk/a7s7KYr3kJw/7II8FCIOkajT/YSiCX8e4Z3Ub4M02GCF2fzRkfIw6Iubb+ZNGQgM41GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L52BRxyi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+VF65Wqti8gLaqX/quu1u0c3WXc6fWf3Wezs9ZTxDc=;
	b=L52BRxyidaIC2sLqFrtfify4oLXX7HeTeo28HdetpP4rZvz1m3iIRcwW85FYPWoF5BaCbW
	Fs3TkAp4rjygG7/o9U2FZiPo9WyLBTgSBxnJpqzfiz6wu3BT906DsKn1IGnJO3E0GbnLEY
	svuA3adaF0G/74djWh+ngR5x//TzXt0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-89SjK45AMUe870Heb8Itmw-1; Thu,
 26 Mar 2026 06:49:53 -0400
X-MC-Unique: 89SjK45AMUe870Heb8Itmw-1
X-Mimecast-MFC-AGG-ID: 89SjK45AMUe870Heb8Itmw_1774522191
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C15E195608B;
	Thu, 26 Mar 2026 10:49:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BBBE19560B1;
	Thu, 26 Mar 2026 10:49:43 +0000 (UTC)
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
Subject: [PATCH 26/26] netfs: Combine prepare and issue ops and grab the buffers on request
Date: Thu, 26 Mar 2026 10:45:41 +0000
Message-ID: <20260326104544.509518-27-dhowells@redhat.com>
In-Reply-To: <20260326104544.509518-1-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20424-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,manguebit.org:email]
X-Rspamd-Queue-Id: B809233402C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Modify the way subrequests are generated in netfslib to try and simplify
the code.  The issue, primarily, is in writeback: the code has to create
multiple streams of write requests to disparate targets with different
properties (e.g. server and fscache), where not every folio needs to go to
every target (e.g. data just read from the server may only need writing to
the cache).

The current model in writeback, at least, is to go carefully through every
folio, preparing a subrequest for each stream when it was detected that
part of the current folio needed to go to that stream, and repeating this
within and across contiguous folios; then to issue subrequests as they
become full or hit boundaries after first setting up the buffer.  However,
this is quite difficult to follow - and makes it tricky to handle
discontiguous folios in a request.

This is changed such that netfs now accumulates buffers and attaches them
to each stream when they become valid for that stream, then flushes the
stream when a limit or a boundary is hit.  The issuing code in netfs then
loops around creating and issuing subrequests without calling a separate
prepare stage (though a function is provided to get an estimate of when
flushing should occur).  The filesystem (or cache) then gets to take a
slice of the master bvec chain as its I/O buffer for each subrequest,
including discontiguities if it can support a sparse/vectored RPC (as Ceph
can).

Similar-ish changes also apply to buffered read and unbuffered read and
write, though in each of those cases there is only a single contiguous
stream.  Though for buffered read this consists of interwoven requests from
multiple sources (server or cache).

To this end, netfslib is changed in the following ways:

 (1) ->prepare_xxx(), buffer selection and ->issue_xxx() are now collapsed
     together such that one ->issue_xxx() call is made with the subrequest
     defined to the maximum extent; the filesystem/cache then reduces the
     length of the subrequest and calls back to netfslib to grab a slice of
     the buffer, which may reduce the subrequest further if a maximum
     segment limit is set.  The filesystem/cache then dispatches the
     operation.

 (2) Retry buffer tracking is added to the netfs_io_request struct.  This
     is then selected by the subrequest retry counter being non-zero.

 (3) The use of iov_iter is pushed down to the filesystem.  Netfslib now
     provides the filesystem with a bvecq holding the buffer rather than an
     iov_iter.  The bvecq can be duplicated and headers/trailers attached
     to hold protocol and several bvecqs can be linked together to create a
     compound operation.

 (4) The ->issue_xxx() functions now return an error code that allows them
     to return an error without having to terminate the subrequest.
     Netfslib will handle the error immediately if it can but may request
     termination and punt responsibility to the result collector.

     ->issue_xxx() can return 0 if synchronously complete and -EIOCBQUEUED
     if the operation will complete (or already has completed)
     asynchronously.

 (5) During writeback, netfslib now builds up an accumulation of buffered
     data before issuing writes on each stream (one server, one cache).  It
     asks each stream for an estimate of how much data to accumulate before
     it next generates subrequests on the stream.  The filesystem or cache
     is not required to use up all the data accumulated on a stream at that
     time unless the end of the pagecache is hit.

 (6) During read-gaps, in which there are two gaps on either end of a dirty
     streaming write page that need to be filled, a buffer is constructed
     consisting of the two ends plus a sink page repeated to cover the
     middle portion.  This is passed to the server as a single write.  For
     something like Ceph, this should probably be done either as a
     vectored/sparse read or as two separate reads (if different Ceph
     objects are involved).

 (7) During unbuffered/DIO read/write, there is a single contiguous file
     region to be read or written as a single stream.  The dispatching
     function just creates subrequests and calls ->issue_xxx() repeatedly
     to eat through the bufferage.

 (8) At the start of buffered read, the entire set of folios allocated by
     VM readahead is loaded into a bvecq chain, rather than trying to do it
     piecemeal as-needed.  As the pages were already added and locked by
     the VM, this is slightly more efficient than loading piecemeal as only
     a single iteration of the xarray is required.

 (9) During buffered read, there is a single contiguous file region, to
     read as a single stream - however, this stream may be stitched
     together from subrequests to multiple sources.  Which sources are used
     where is now determined by querying the cache to find the next couple
     of extents in which it has data; netfslib uses this to direct the
     subrequests towards the appropriate sources.

     Each subrequest is given the maximum length in the current extent and
     then ->issue_read() is called.  The filesystem then limits the size
     and slices off a piece of the buffer for that extent.

(10) Cachefiles now provides an estimation function that indicates the
     standard maxima for doing DIO (MAX_RW_COUNT and BIO_MAX_VECS).

Note that sparse cachefiles still rely on the backing filesystem for
content mapping.  That will need to be addressed in a future patch and is
not trivial to fix.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c                  |  49 +-
 fs/afs/dir.c                      |   8 +-
 fs/afs/file.c                     |  26 +-
 fs/afs/fsclient.c                 |   8 +-
 fs/afs/internal.h                 |   8 +-
 fs/afs/write.c                    |  35 +-
 fs/afs/yfsclient.c                |   6 +-
 fs/cachefiles/io.c                | 237 ++++++---
 fs/ceph/Kconfig                   |   1 +
 fs/ceph/addr.c                    | 127 ++---
 fs/netfs/Kconfig                  |   3 +
 fs/netfs/Makefile                 |   2 +-
 fs/netfs/buffered_read.c          | 236 +++++----
 fs/netfs/buffered_write.c         |  27 +-
 fs/netfs/direct_read.c            |  91 ++--
 fs/netfs/direct_write.c           | 145 +++---
 fs/netfs/fscache_io.c             |   6 -
 fs/netfs/internal.h               |  78 ++-
 fs/netfs/iterator.c               |   6 +-
 fs/netfs/misc.c                   |  33 +-
 fs/netfs/objects.c                |   7 +-
 fs/netfs/read_collect.c           |  33 +-
 fs/netfs/read_pgpriv2.c           | 116 +++--
 fs/netfs/read_retry.c             | 207 ++++----
 fs/netfs/read_single.c            | 150 +++---
 fs/netfs/write_collect.c          |  41 +-
 fs/netfs/write_issue.c            | 805 ++++++++++++++++++------------
 fs/netfs/write_retry.c            | 136 +++--
 fs/nfs/Kconfig                    |   1 +
 fs/nfs/fscache.c                  |  24 +-
 fs/smb/client/cifssmb.c           |  13 +-
 fs/smb/client/file.c              | 146 +++---
 fs/smb/client/smb2ops.c           |   9 +-
 fs/smb/client/smb2pdu.c           |  28 +-
 fs/smb/client/transport.c         |  15 +-
 include/linux/netfs.h             |  96 ++--
 include/trace/events/cachefiles.h |   2 +
 include/trace/events/netfs.h      |  51 +-
 net/9p/client.c                   |   8 +-
 39 files changed, 1790 insertions(+), 1230 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 862164181bac..0db56cc00467 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -48,32 +48,71 @@ static void v9fs_begin_writeback(struct netfs_io_request *wreq)
 	wreq->io_streams[0].avail = true;
 }
 
+/*
+ * Estimate how much data should be accumulated before we start issuing
+ * write subrequests.
+ */
+static int v9fs_estimate_write(struct netfs_io_request *wreq,
+			       struct netfs_io_stream *stream,
+			       struct netfs_write_estimate *estimate)
+{
+	struct p9_fid *fid = wreq->netfs_priv;
+	unsigned long long limit = ULLONG_MAX - stream->issue_from;
+	unsigned long long max_len = fid->clnt->msize - P9_IOHDRSZ;
+
+	estimate->issue_at = stream->issue_from + umin(max_len, limit);
+	return 0;
+}
+
 /*
  * Issue a subrequest to write to the server.
  */
-static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
+static int v9fs_issue_write(struct netfs_io_subrequest *subreq)
 {
+	struct iov_iter iter;
 	struct p9_fid *fid = subreq->rreq->netfs_priv;
 	int err, len;
 
-	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
+	subreq->len = umin(subreq->len, fid->clnt->msize - P9_IOHDRSZ);
+
+	err = netfs_prepare_write_buffer(subreq, INT_MAX);
+	if (err < 0)
+		return err;
+
+	iov_iter_bvec_queue(&iter, ITER_SOURCE, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+
+	len = p9_client_write(fid, subreq->start, &iter, &err);
 	if (len > 0)
 		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	netfs_write_subrequest_terminated(subreq, len ?: err);
+	return err;
 }
 
 /**
  * v9fs_issue_read - Issue a read from 9P
  * @subreq: The read to make
+ * @rctx: Read generation context
  */
-static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
+static int v9fs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
+	struct iov_iter iter;
 	struct p9_fid *fid = rreq->netfs_priv;
 	unsigned long long pos = subreq->start + subreq->transferred;
 	int total, err;
 
-	total = p9_client_read(fid, pos, &subreq->io_iter, &err);
+	err = netfs_prepare_read_buffer(subreq, INT_MAX);
+	if (err < 0)
+		return err;
+
+	iov_iter_bvec_queue(&iter, ITER_DEST, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(subreq);
+
+	total = p9_client_read(fid, pos, &iter, &err);
 
 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
@@ -89,6 +128,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 
 	subreq->error = err;
 	netfs_read_subreq_terminated(subreq);
+	return -EIOCBQUEUED;
 }
 
 /**
@@ -154,6 +194,7 @@ const struct netfs_request_ops v9fs_req_ops = {
 	.free_request		= v9fs_free_request,
 	.issue_read		= v9fs_issue_read,
 	.begin_writeback	= v9fs_begin_writeback,
+	.estimate_write		= v9fs_estimate_write,
 	.issue_write		= v9fs_issue_write,
 };
 
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 6627a0d38e73..52ab84ab8c1f 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -255,7 +255,8 @@ static ssize_t afs_do_read_single(struct afs_vnode *dvnode, struct file *file)
 	if (dvnode->directory_size < i_size) {
 		size_t cur_size = dvnode->directory_size;
 
-		ret = bvecq_expand_buffer(&dvnode->directory, &cur_size, i_size,
+		ret = bvecq_expand_buffer(&dvnode->directory, &cur_size,
+					  round_up(i_size, PAGE_SIZE),
 					  mapping_gfp_mask(dvnode->netfs.inode.i_mapping));
 		dvnode->directory_size = cur_size;
 		if (ret < 0)
@@ -2210,9 +2211,10 @@ int afs_single_writepages(struct address_space *mapping,
 	if (is_dir ?
 	    test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) :
 	    atomic64_read(&dvnode->cb_expires_at) != AFS_NO_CB_PROMISE) {
+		size_t len = i_size_read(&dvnode->netfs.inode);
 		iov_iter_bvec_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0,
-				    i_size_read(&dvnode->netfs.inode));
-		ret = netfs_writeback_single(mapping, wbc, &iter);
+				    round_up(len, PAGE_SIZE));
+		ret = netfs_writeback_single(mapping, wbc, &iter, len);
 	}
 
 	up_read(&dvnode->validate_lock);
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 424e0c98d67f..42131fe450af 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -329,11 +329,12 @@ void afs_fetch_data_immediate_cancel(struct afs_call *call)
 /*
  * Fetch file data from the volume.
  */
-static void afs_issue_read(struct netfs_io_subrequest *subreq)
+static int afs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct afs_operation *op;
 	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
 	struct key *key = subreq->rreq->netfs_priv;
+	int ret;
 
 	_enter("%s{%llx:%llu.%u},%x,,,",
 	       vnode->volume->name,
@@ -342,19 +343,21 @@ static void afs_issue_read(struct netfs_io_subrequest *subreq)
 	       vnode->fid.unique,
 	       key_serial(key));
 
+	ret = netfs_prepare_read_buffer(subreq, INT_MAX);
+	if (ret < 0)
+		return ret;
+
 	op = afs_alloc_operation(key, vnode->volume);
-	if (IS_ERR(op)) {
-		subreq->error = PTR_ERR(op);
-		netfs_read_subreq_terminated(subreq);
-		return;
-	}
+	if (IS_ERR(op))
+		return PTR_ERR(op);
 
 	afs_op_set_vnode(op, 0, vnode);
 
 	op->fetch.subreq = subreq;
 	op->ops		= &afs_fetch_data_operation;
 
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(subreq);
 
 	if (subreq->rreq->origin == NETFS_READAHEAD ||
 	    subreq->rreq->iocb) {
@@ -363,18 +366,19 @@ static void afs_issue_read(struct netfs_io_subrequest *subreq)
 		if (!afs_begin_vnode_operation(op)) {
 			subreq->error = afs_put_operation(op);
 			netfs_read_subreq_terminated(subreq);
-			return;
+			return -EIOCBQUEUED;
 		}
 
 		if (!afs_select_fileserver(op)) {
-			afs_end_read(op);
-			return;
+			afs_end_read(op); /* Error recorded here. */
+			return -EIOCBQUEUED;
 		}
 
 		afs_issue_read_call(op);
 	} else {
 		afs_do_sync_operation(op);
 	}
+	return -EIOCBQUEUED;
 }
 
 static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
@@ -453,7 +457,7 @@ const struct netfs_request_ops afs_req_ops = {
 	.update_i_size		= afs_update_i_size,
 	.invalidate_cache	= afs_netfs_invalidate_cache,
 	.begin_writeback	= afs_begin_writeback,
-	.prepare_write		= afs_prepare_write,
+	.estimate_write		= afs_estimate_write,
 	.issue_write		= afs_issue_write,
 	.retry_request		= afs_retry_request,
 };
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 95494d5f2b8a..f59a9db4bb0e 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -339,7 +339,9 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		if (call->remaining == 0)
 			goto no_more_data;
 
-		call->iter = &subreq->io_iter;
+		iov_iter_bvec_queue(&call->def_iter, ITER_DEST, subreq->content.bvecq,
+				    subreq->content.slot, subreq->content.offset, subreq->len);
+
 		call->iov_len = umin(call->remaining, subreq->len - subreq->transferred);
 		call->unmarshall++;
 		fallthrough;
@@ -1085,7 +1087,7 @@ static void afs_fs_store_data64(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
-	call->write_iter = op->store.write_iter;
+	call->write_iter = &op->store.write_iter;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1139,7 +1141,7 @@ void afs_fs_store_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
-	call->write_iter = op->store.write_iter;
+	call->write_iter = &op->store.write_iter;
 
 	/* marshall the parameters */
 	bp = call->request;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 9bf5d2f1dbc4..a60df9357a4f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -906,7 +906,7 @@ struct afs_operation {
 			afs_lock_type_t type;
 		} lock;
 		struct {
-			struct iov_iter	*write_iter;
+			struct iov_iter	write_iter;
 			loff_t	pos;
 			loff_t	size;
 			loff_t	i_size;
@@ -1680,8 +1680,10 @@ extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
 /*
  * write.c
  */
-void afs_prepare_write(struct netfs_io_subrequest *subreq);
-void afs_issue_write(struct netfs_io_subrequest *subreq);
+int afs_estimate_write(struct netfs_io_request *wreq,
+		       struct netfs_io_stream *stream,
+		       struct netfs_write_estimate *estimate);
+int afs_issue_write(struct netfs_io_subrequest *subreq);
 void afs_begin_writeback(struct netfs_io_request *wreq);
 void afs_retry_request(struct netfs_io_request *wreq, struct netfs_io_stream *stream);
 extern int afs_writepages(struct address_space *, struct writeback_control *);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 93ad86ff3345..1f6045bfeecc 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -84,17 +84,20 @@ static const struct afs_operation_ops afs_store_data_operation = {
 };
 
 /*
- * Prepare a subrequest to write to the server.  This sets the max_len
- * parameter.
+ * Estimate the maximum size of a write we can send to the server.
  */
-void afs_prepare_write(struct netfs_io_subrequest *subreq)
+int afs_estimate_write(struct netfs_io_request *wreq,
+		       struct netfs_io_stream *stream,
+		       struct netfs_write_estimate *estimate)
 {
-	struct netfs_io_stream *stream = &subreq->rreq->io_streams[subreq->stream_nr];
+	unsigned long long limit = ULLONG_MAX - stream->issue_from;
+	unsigned long long max_len = 256 * 1024 * 1024;
 
 	//if (test_bit(NETFS_SREQ_RETRYING, &subreq->flags))
-	//	subreq->max_len = 512 * 1024;
-	//else
-	stream->sreq_max_len = 256 * 1024 * 1024;
+	//	max_len = 512 * 1024;
+
+	estimate->issue_at = stream->issue_from + umin(max_len, limit);
+	return 0;
 }
 
 /*
@@ -140,12 +143,15 @@ static void afs_issue_write_worker(struct work_struct *work)
 	op->flags		|= AFS_OPERATION_UNINTR;
 	op->ops			= &afs_store_data_operation;
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	afs_begin_vnode_operation(op);
 
-	op->store.write_iter	= &subreq->io_iter;
 	op->store.i_size	= umax(pos + len, vnode->netfs.remote_i_size);
 	op->mtime		= inode_get_mtime(&vnode->netfs.inode);
 
+	iov_iter_bvec_queue(&op->store.write_iter, ITER_SOURCE, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+
 	afs_wait_for_operation(op);
 	ret = afs_put_operation(op);
 	switch (ret) {
@@ -169,11 +175,20 @@ static void afs_issue_write_worker(struct work_struct *work)
 	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len);
 }
 
-void afs_issue_write(struct netfs_io_subrequest *subreq)
+int afs_issue_write(struct netfs_io_subrequest *subreq)
 {
+	int ret;
+
+	if (subreq->len > 256 * 1024 * 1024)
+		subreq->len = 256 * 1024 * 1024;
+	ret = netfs_prepare_write_buffer(subreq, INT_MAX);
+	if (ret < 0)
+		return ret;
+
 	subreq->work.func = afs_issue_write_worker;
 	if (!queue_work(system_dfl_wq, &subreq->work))
 		WARN_ON_ONCE(1);
+	return -EIOCBQUEUED;
 }
 
 /*
@@ -184,6 +199,8 @@ void afs_begin_writeback(struct netfs_io_request *wreq)
 {
 	if (S_ISREG(wreq->inode->i_mode))
 		afs_get_writeback_key(wreq);
+
+	wreq->io_streams[0].avail = true;
 }
 
 /*
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 24fb562ebd33..ffd1d4c87290 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -385,7 +385,9 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		if (call->remaining == 0)
 			goto no_more_data;
 
-		call->iter = &subreq->io_iter;
+		iov_iter_bvec_queue(&call->def_iter, ITER_DEST, subreq->content.bvecq,
+				    subreq->content.slot, subreq->content.offset, subreq->len);
+
 		call->iov_len = min(call->remaining, subreq->len - subreq->transferred);
 		call->unmarshall++;
 		fallthrough;
@@ -1357,7 +1359,7 @@ void yfs_fs_store_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
-	call->write_iter = op->store.write_iter;
+	call->write_iter = &op->store.write_iter;
 
 	/* marshall the parameters */
 	bp = call->request;
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 2af55a75b511..05a37b4bdf10 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -26,7 +26,10 @@ struct cachefiles_kiocb {
 	};
 	struct cachefiles_object *object;
 	netfs_io_terminated_t	term_func;
-	void			*term_func_priv;
+	union {
+		struct netfs_io_subrequest *subreq;
+		void			*term_func_priv;
+	};
 	bool			was_async;
 	unsigned int		inval_counter;	/* Copy of cookie->inval_counter */
 	u64			b_writing;
@@ -194,6 +197,125 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	return ret;
 }
 
+/*
+ * Handle completion of a read from the cache issued by netfslib.
+ */
+static void cachefiles_issue_read_complete(struct kiocb *iocb, long ret)
+{
+	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
+	struct netfs_io_subrequest *subreq = ki->subreq;
+	struct inode *inode = file_inode(ki->iocb.ki_filp);
+
+	_enter("%ld", ret);
+
+	if (ret < 0) {
+		subreq->error = -ESTALE;
+		trace_cachefiles_io_error(ki->object, inode, ret,
+					  cachefiles_trace_read_error);
+	}
+
+	if (ret >= 0) {
+		if (ki->object->cookie->inval_counter == ki->inval_counter) {
+			subreq->error = 0;
+			if (ret > 0) {
+				subreq->transferred += ret;
+				__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+			}
+		} else {
+			subreq->error = -ESTALE;
+		}
+	}
+
+	netfs_read_subreq_terminated(subreq);
+	cachefiles_put_kiocb(ki);
+}
+
+/*
+ * Issue a read operation to the cache.
+ */
+static int cachefiles_issue_read(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_cache_resources *cres = &subreq->rreq->cache_resources;
+	struct cachefiles_object *object;
+	struct cachefiles_kiocb *ki;
+	struct iov_iter iter;
+	struct file *file;
+	unsigned int old_nofs;
+	ssize_t ret = -ENOBUFS;
+
+	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_READ))
+		return -ENOBUFS;
+
+	fscache_count_read();
+	object = cachefiles_cres_object(cres);
+	file = cachefiles_cres_file(cres);
+
+	_enter("%pD,%li,%llx,%zx/%llx",
+	       file, file_inode(file)->i_ino, subreq->start, subreq->len,
+	       i_size_read(file_inode(file)));
+
+	if (subreq->len > MAX_RW_COUNT)
+		subreq->len = MAX_RW_COUNT;
+
+	ret = netfs_prepare_read_buffer(subreq, BIO_MAX_VECS);
+	if (ret < 0)
+		return ret;
+
+	iov_iter_bvec_queue(&iter, ITER_DEST, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+
+	ki = kzalloc_obj(struct cachefiles_kiocb);
+	if (!ki)
+		return -ENOMEM;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	ki->iocb.ki_filp	= file;
+	ki->iocb.ki_pos		= subreq->start;
+	ki->iocb.ki_flags	= IOCB_DIRECT;
+	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->iocb.ki_complete	= cachefiles_issue_read_complete;
+	ki->object		= object;
+	ki->inval_counter	= cres->inval_counter;
+	ki->subreq		= subreq;
+	ki->was_async		= true;
+
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(subreq);
+
+	get_file(ki->iocb.ki_filp);
+	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
+
+	trace_cachefiles_read(object, file_inode(file), ki->iocb.ki_pos, subreq->len);
+	old_nofs = memalloc_nofs_save();
+	ret = cachefiles_inject_read_error();
+	if (ret == 0)
+		ret = vfs_iocb_iter_read(file, &ki->iocb, &iter);
+	memalloc_nofs_restore(old_nofs);
+
+	switch (ret) {
+	case -EIOCBQUEUED:
+		break;
+
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/* There's no easy way to restart the syscall since other AIO's
+		 * may be already running. Just fail this IO with EINTR.
+		 */
+		ret = -EINTR;
+		fallthrough;
+	default:
+		ki->was_async = false;
+		cachefiles_issue_read_complete(&ki->iocb, ret);
+		break;
+	}
+
+	cachefiles_put_kiocb(ki);
+	_leave(" = %zd", ret);
+	return -EIOCBQUEUED;
+}
+
 /*
  * Query the occupancy of the cache in a region, returning the extent of the
  * next two chunks of cached data and the next hole.
@@ -610,104 +732,67 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 				    cachefiles_has_space_for_write);
 }
 
-static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
-				    loff_t *_start, size_t *_len, size_t upper_len,
-				    loff_t i_size, bool no_space_allocated_yet)
-{
-	struct cachefiles_object *object = cachefiles_cres_object(cres);
-	struct cachefiles_cache *cache = object->volume->cache;
-	const struct cred *saved_cred;
-	int ret;
-
-	if (!cachefiles_cres_file(cres)) {
-		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
-			return -ENOBUFS;
-		if (!cachefiles_cres_file(cres))
-			return -ENOBUFS;
-	}
-
-	cachefiles_begin_secure(cache, &saved_cred);
-	ret = __cachefiles_prepare_write(object, cachefiles_cres_file(cres),
-					 _start, _len, upper_len,
-					 no_space_allocated_yet);
-	cachefiles_end_secure(cache, saved_cred);
-	return ret;
-}
-
-static void cachefiles_prepare_write_subreq(struct netfs_io_subrequest *subreq)
+static int cachefiles_estimate_write(struct netfs_io_request *wreq,
+				     struct netfs_io_stream *stream,
+				     struct netfs_write_estimate *estimate)
 {
-	struct netfs_io_request *wreq = subreq->rreq;
-	struct netfs_cache_resources *cres = &wreq->cache_resources;
-	struct netfs_io_stream *stream = &wreq->io_streams[subreq->stream_nr];
-
-	_enter("W=%x[%x] %llx", wreq->debug_id, subreq->debug_index, subreq->start);
-
-	stream->sreq_max_len = MAX_RW_COUNT;
-	stream->sreq_max_segs = BIO_MAX_VECS;
-
-	if (!cachefiles_cres_file(cres)) {
-		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
-			return netfs_prepare_write_failed(subreq);
-		if (!cachefiles_cres_file(cres))
-			return netfs_prepare_write_failed(subreq);
-	}
+	estimate->issue_at = stream->issue_from + MAX_RW_COUNT;
+	estimate->max_segs = BIO_MAX_VECS;
+	return 0;
 }
 
-static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
+static int cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *wreq = subreq->rreq;
 	struct netfs_cache_resources *cres = &wreq->cache_resources;
 	struct cachefiles_object *object = cachefiles_cres_object(cres);
 	struct cachefiles_cache *cache = object->volume->cache;
+	struct iov_iter iter;
 	const struct cred *saved_cred;
-	size_t off, pre, post, len = subreq->len;
 	loff_t start = subreq->start;
+	size_t len = subreq->len;
 	int ret;
 
 	_enter("W=%x[%x] %llx-%llx",
 	       wreq->debug_id, subreq->debug_index, start, start + len - 1);
 
-	/* We need to start on the cache granularity boundary */
-	off = start & (cache->bsize - 1);
-	if (off) {
-		pre = cache->bsize - off;
-		if (pre >= len) {
-			fscache_count_dio_misfit();
-			netfs_write_subrequest_terminated(subreq, len);
-			return;
-		}
-		subreq->transferred += pre;
-		start += pre;
-		len -= pre;
-		iov_iter_advance(&subreq->io_iter, pre);
-	}
-
-	/* We also need to end on the cache granularity boundary */
-	post = len & (cache->bsize - 1);
-	if (post) {
-		len -= post;
-		if (len == 0) {
-			fscache_count_dio_misfit();
-			netfs_write_subrequest_terminated(subreq, post);
-			return;
-		}
-		iov_iter_truncate(&subreq->io_iter, len);
+	if (!cachefiles_cres_file(cres)) {
+		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
+			return -EINVAL;
+		if (!cachefiles_cres_file(cres))
+			return -EINVAL;
+	}
+
+	ret = netfs_prepare_write_buffer(subreq, BIO_MAX_VECS);
+	if (ret < 0)
+		return ret;
+
+	/* The buffer extraction func may round out start and end. */
+	start = subreq->start;
+	len = subreq->len;
+
+	/* We need to start and end on cache granularity boundaries. */
+	if (WARN_ON_ONCE(start & (cache->bsize - 1)) ||
+	    WARN_ON_ONCE(len   & (cache->bsize - 1))) {
+		fscache_count_dio_misfit();
+		return -EIO;
 	}
 
+	iov_iter_bvec_queue(&iter, ITER_SOURCE, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, len);
+
 	trace_netfs_sreq(subreq, netfs_sreq_trace_cache_prepare);
 	cachefiles_begin_secure(cache, &saved_cred);
 	ret = __cachefiles_prepare_write(object, cachefiles_cres_file(cres),
 					 &start, &len, len, true);
 	cachefiles_end_secure(cache, saved_cred);
-	if (ret < 0) {
-		netfs_write_subrequest_terminated(subreq, ret);
-		return;
-	}
+	if (ret < 0)
+		return ret;
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_cache_write);
-	cachefiles_write(&subreq->rreq->cache_resources,
-			 subreq->start, &subreq->io_iter,
+	cachefiles_write(&subreq->rreq->cache_resources, subreq->start, &iter,
 			 netfs_write_subrequest_terminated, subreq);
+	return -EIOCBQUEUED;
 }
 
 /*
@@ -854,9 +939,9 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.end_operation		= cachefiles_end_operation,
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
+	.issue_read		= cachefiles_issue_read,
 	.issue_write		= cachefiles_issue_write,
-	.prepare_write		= cachefiles_prepare_write,
-	.prepare_write_subreq	= cachefiles_prepare_write_subreq,
+	.estimate_write		= cachefiles_estimate_write,
 	.prepare_ondemand_read	= cachefiles_prepare_ondemand_read,
 	.query_occupancy	= cachefiles_query_occupancy,
 	.collect_write		= cachefiles_collect_write,
diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 3d64a316ca31..aa6ccd7794d2 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -4,6 +4,7 @@ config CEPH_FS
 	depends on INET
 	select CEPH_LIB
 	select NETFS_SUPPORT
+	select NETFS_PGPRIV2
 	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
 	default n
 	help
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e87b3bb94ee8..8aab4f7c516f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -269,7 +269,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
 }
 
-static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
+static int ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
@@ -278,7 +278,8 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	ssize_t err = 0;
+	struct iov_iter iter;
+	ssize_t err;
 	size_t len;
 	int mode;
 
@@ -287,21 +288,33 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 
-	if (subreq->start >= inode->i_size)
+	if (subreq->start >= inode->i_size) {
+		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
+		err = 0;
 		goto out;
+	}
+
+	err = netfs_prepare_read_buffer(subreq, INT_MAX);
+	if (err < 0)
+		return err;
+
+	iov_iter_bvec_queue(&iter, ITER_DEST, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset,
+			    subreq->len);
 
 	/* We need to fetch the inline data. */
 	mode = ceph_try_to_choose_auth_mds(inode, CEPH_STAT_CAP_INLINE_DATA);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR, mode);
-	if (IS_ERR(req)) {
-		err = PTR_ERR(req);
-		goto out;
-	}
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
 	req->r_ino1 = ci->i_vino;
 	req->r_args.getattr.mask = cpu_to_le32(CEPH_STAT_CAP_INLINE_DATA);
 	req->r_num_caps = 2;
 
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(subreq);
+
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	if (err < 0)
 		goto out;
@@ -311,11 +324,11 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	if (iinfo->inline_version == CEPH_INLINE_NONE) {
 		/* The data got uninlined */
 		ceph_mdsc_put_request(req);
-		return false;
+		return 1;
 	}
 
 	len = min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);
-	err = copy_to_iter(iinfo->inline_data + subreq->start, len, &subreq->io_iter);
+	err = copy_to_iter(iinfo->inline_data + subreq->start, len, &iter);
 	if (err == 0) {
 		err = -EFAULT;
 	} else {
@@ -328,26 +341,10 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	subreq->error = err;
 	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(subreq);
-	return true;
+	return -EIOCBQUEUED;
 }
 
-static int ceph_netfs_prepare_read(struct netfs_io_subrequest *subreq)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-	struct inode *inode = rreq->inode;
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
-	u64 objno, objoff;
-	u32 xlen;
-
-	/* Truncate the extent at the end of the current block */
-	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
-				      &objno, &objoff, &xlen);
-	rreq->io_streams[0].sreq_max_len = umin(xlen, fsc->mount_options->rsize);
-	return 0;
-}
-
-static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
+static int ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
@@ -356,48 +353,65 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_request *req = NULL;
 	struct ceph_vino vino = ceph_vino(inode);
+	struct iov_iter iter;
+	u64 objno, objoff, len, off = subreq->start;
+	u32 maxlen;
 	int err;
-	u64 len;
 	bool sparse = IS_ENCRYPTED(inode) || ceph_test_mount_opt(fsc, SPARSEREAD);
-	u64 off = subreq->start;
 	int extent_cnt;
 
-	if (ceph_inode_is_shutdown(inode)) {
-		err = -EIO;
-		goto out;
+	if (ceph_inode_is_shutdown(inode))
+		return -EIO;
+
+	if (ceph_has_inline_data(ci)) {
+		err = ceph_netfs_issue_op_inline(subreq);
+		if (err != 1)
+			return err;
 	}
 
-	if (ceph_has_inline_data(ci) && ceph_netfs_issue_op_inline(subreq))
-		return;
+	/* Truncate the extent at the end of the current block */
+	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
+				      &objno, &objoff, &maxlen);
+	maxlen = umin(maxlen, fsc->mount_options->rsize);
+	len = umin(subreq->len, maxlen);
+	subreq->len = len;
 
 	// TODO: This rounding here is slightly dodgy.  It *should* work, for
 	// now, as the cache only deals in blocks that are a multiple of
 	// PAGE_SIZE and fscrypt blocks are at most PAGE_SIZE.  What needs to
 	// happen is for the fscrypt driving to be moved into netfslib and the
 	// data in the cache also to be stored encrypted.
-	len = subreq->len;
 	ceph_fscrypt_adjust_off_and_len(inode, &off, &len);
 
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout, vino,
 			off, &len, 0, 1, sparse ? CEPH_OSD_OP_SPARSE_READ : CEPH_OSD_OP_READ,
 			CEPH_OSD_FLAG_READ, NULL, ci->i_truncate_seq,
 			ci->i_truncate_size, false);
-	if (IS_ERR(req)) {
-		err = PTR_ERR(req);
-		req = NULL;
-		goto out;
-	}
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	if (sparse) {
 		extent_cnt = __ceph_sparse_read_ext_count(inode, len);
 		err = ceph_alloc_sparse_ext_map(&req->r_ops[0], extent_cnt);
-		if (err)
-			goto out;
+		if (err) {
+			ceph_osdc_put_request(req);
+			return err;
+		}
 	}
 
 	doutc(cl, "%llx.%llx pos=%llu orig_len=%zu len=%llu\n",
 	      ceph_vinop(inode), subreq->start, subreq->len, len);
 
+	err = netfs_prepare_read_buffer(subreq, INT_MAX);
+	if (err < 0) {
+		ceph_osdc_put_request(req);
+		return err;
+	}
+
+	iov_iter_bvec_queue(&iter, ITER_DEST, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset,
+			    subreq->len);
+
 	/*
 	 * FIXME: For now, use CEPH_OSD_DATA_TYPE_PAGES instead of _ITER for
 	 * encrypted inodes. We'd need infrastructure that handles an iov_iter
@@ -416,13 +430,12 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		 * ceph_msg_data_cursor_init() triggers BUG_ON() in the case
 		 * if msg->sparse_read_total > msg->data_length.
 		 */
-		subreq->io_iter.count = len;
-
-		err = iov_iter_get_pages_alloc2(&subreq->io_iter, &pages, len, &page_off);
+		err = iov_iter_get_pages_alloc2(&iter, &pages, len, &page_off);
 		if (err < 0) {
 			doutc(cl, "%llx.%llx failed to allocate pages, %d\n",
 			      ceph_vinop(inode), err);
-			goto out;
+			ceph_osdc_put_request(req);
+			return -EIO;
 		}
 
 		/* should always give us a page-aligned read */
@@ -433,32 +446,28 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, false,
 						 false);
 	} else {
-		osd_req_op_extent_osd_iter(req, 0, &subreq->io_iter);
+		osd_req_op_extent_osd_iter(req, 0, &iter);
 	}
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
-		err = -EIO;
-		goto out;
+		ceph_osdc_put_request(req);
+		return -EIO;
 	}
 	req->r_callback = finish_netfs_read;
 	req->r_priv = subreq;
 	req->r_inode = inode;
 	ihold(inode);
 
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(subreq);
 	ceph_osdc_start_request(req->r_osdc, req);
-out:
 	ceph_osdc_put_request(req);
-	if (err) {
-		subreq->error = err;
-		netfs_read_subreq_terminated(subreq);
-	}
-	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
+	doutc(cl, "%llx.%llx result -EIOCBQUEUED\n", ceph_vinop(inode));
+	return -EIOCBQUEUED;
 }
 
 static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct inode *inode = rreq->inode;
-	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int got = 0, want = CEPH_CAP_FILE_CACHE;
 	struct ceph_netfs_request_data *priv;
@@ -510,7 +519,6 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 
 	priv->caps = got;
 	rreq->netfs_priv = priv;
-	rreq->io_streams[0].sreq_max_len = fsc->mount_options->rsize;
 
 out:
 	if (ret < 0) {
@@ -538,7 +546,6 @@ static void ceph_netfs_free_request(struct netfs_io_request *rreq)
 const struct netfs_request_ops ceph_netfs_ops = {
 	.init_request		= ceph_init_request,
 	.free_request		= ceph_netfs_free_request,
-	.prepare_read		= ceph_netfs_prepare_read,
 	.issue_read		= ceph_netfs_issue_read,
 	.expand_readahead	= ceph_netfs_expand_readahead,
 	.check_write_begin	= ceph_netfs_check_write_begin,
diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index 7701c037c328..d0e7b0971fa3 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -22,6 +22,9 @@ config NETFS_STATS
 	  between CPUs.  On the other hand, the stats are very useful for
 	  debugging purposes.  Saying 'Y' here is recommended.
 
+config NETFS_PGPRIV2
+	bool
+
 config NETFS_DEBUG
 	bool "Enable dynamic debugging netfslib and FS-Cache"
 	depends on NETFS_SUPPORT
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 0621e6870cbd..421dd0be413b 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -12,13 +12,13 @@ netfs-y := \
 	misc.o \
 	objects.o \
 	read_collect.o \
-	read_pgpriv2.o \
 	read_retry.o \
 	read_single.o \
 	write_collect.o \
 	write_issue.o \
 	write_retry.o
 
+netfs-$(CONFIG_NETFS_PGPRIV2) += read_pgpriv2.o
 netfs-$(CONFIG_NETFS_STATS) += stats.o
 
 netfs-$(CONFIG_FSCACHE) += \
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 2cfd33abfb80..81aa99910e5d 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -98,51 +98,68 @@ static int netfs_begin_cache_read(struct netfs_io_request *rreq, struct netfs_in
 }
 
 /*
- * netfs_prepare_read_iterator - Prepare the subreq iterator for I/O
- * @subreq: The subrequest to be set up
- *
- * Prepare the I/O iterator representing the read buffer on a subrequest for
- * the filesystem to use for I/O (it can be passed directly to a socket).  This
- * is intended to be called from the ->issue_read() method once the filesystem
- * has trimmed the request to the size it wants.
- *
- * Returns the limited size if successful and -ENOMEM if insufficient memory
- * available.
+ * Prepare the I/O buffer on a buffered read subrequest for the filesystem to
+ * use as a bvec queue.
  */
-static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
+static int netfs_prepare_buffered_read_buffer(struct netfs_io_subrequest *subreq,
+					      unsigned int max_segs)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
 	ssize_t extracted;
-	size_t rsize = subreq->len;
 
-	if (subreq->source == NETFS_DOWNLOAD_FROM_SERVER)
-		rsize = umin(rsize, stream->sreq_max_len);
+	_enter("R=%08x[%x] l=%zx s=%u",
+	       rreq->debug_id, subreq->debug_index, subreq->len, max_segs);
 
-	bvecq_pos_set(&subreq->dispatch_pos, &rreq->dispatch_cursor);
-	extracted = bvecq_slice(&rreq->dispatch_cursor, subreq->len,
-				stream->sreq_max_segs, &subreq->nr_segs);
-	if (extracted < rsize) {
+	bvecq_pos_set(&subreq->dispatch_pos, &stream->dispatch_cursor);
+	bvecq_pos_set(&subreq->content, &subreq->dispatch_pos);
+	extracted = bvecq_slice(&stream->dispatch_cursor, subreq->len,
+				max_segs, &subreq->nr_segs);
+
+	stream->buffered -= extracted;
+	if (extracted < subreq->len) {
 		subreq->len = extracted;
 		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
 	}
 
-	return subreq->len;
+	return 0;
 }
 
-/*
- * Issue a read against the cache.
- * - Eats the caller's ref on subreq.
+/**
+ * netfs_prepare_read_buffer - Get the buffer for a subrequest
+ * @subreq: The subrequest to get the buffer for
+ * @max_segs: Maximum number of segments in buffer (or INT_MAX)
+ *
+ * Extract a slice of buffer from the stream and attach it to the subrequest as
+ * a bio_vec queue.  The maximum amount of data attached is set by
+ * @subreq->len, but this may be shortened if @max_segs would be exceeded.
+ *
+ * [!] NOTE: This must be run in the same thread as ->issue_read() was called
+ * in as we access the readahead_control struct if there is one.
  */
-static void netfs_read_cache_to_pagecache(struct netfs_io_request *rreq,
-					  struct netfs_io_subrequest *subreq)
+int netfs_prepare_read_buffer(struct netfs_io_subrequest *subreq,
+			      unsigned int max_segs)
 {
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-
-	netfs_stat(&netfs_n_rh_read);
-	cres->ops->read(cres, subreq->start, &subreq->io_iter, NETFS_READ_HOLE_IGNORE,
-			netfs_cache_read_terminated, subreq);
+	switch (subreq->rreq->origin) {
+	case NETFS_READAHEAD:
+	case NETFS_READPAGE:
+	case NETFS_READ_FOR_WRITE:
+		if (subreq->retry_count)
+			return netfs_prepare_buffered_read_retry_buffer(subreq, max_segs);
+		return netfs_prepare_buffered_read_buffer(subreq, max_segs);
+
+	case NETFS_UNBUFFERED_READ:
+	case NETFS_DIO_READ:
+	case NETFS_READ_GAPS:
+		return netfs_prepare_unbuffered_read_buffer(subreq, max_segs);
+	case NETFS_READ_SINGLE:
+		return netfs_prepare_read_single_buffer(subreq, max_segs);
+	default:
+		WARN_ON_ONCE(1);
+		return -EIO;
+	}
 }
+EXPORT_SYMBOL(netfs_prepare_read_buffer);
 
 int netfs_read_query_cache(struct netfs_io_request *rreq, struct fscache_occupancy *occ)
 {
@@ -157,12 +174,22 @@ int netfs_read_query_cache(struct netfs_io_request *rreq, struct fscache_occupan
 	return cres->ops->query_occupancy(cres, occ);
 }
 
-static void netfs_queue_read(struct netfs_io_request *rreq,
-			     struct netfs_io_subrequest *subreq,
-			     bool last_subreq)
+/**
+ * netfs_mark_read_submission - Mark a read subrequest as being ready for submission
+ * @subreq: The subrequest to be marked
+ *
+ * Calling this marks a read subrequest as being ready for submission and makes
+ * it available to the collection thread.  After calling this, the filesystem's
+ * ->issue_read() method must invoke netfs_read_subreq_terminated() to end the
+ * subrequest and must return -EIOCBQUEUED.
+ */
+void netfs_mark_read_submission(struct netfs_io_subrequest *subreq)
 {
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
 
+	_enter("R=%08x[%x]", rreq->debug_id, subreq->debug_index);
+
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 
 	/* We add to the end of the list whilst the collector may be walking
@@ -170,45 +197,57 @@ static void netfs_queue_read(struct netfs_io_request *rreq,
 	 * remove entries off of the front.
 	 */
 	spin_lock(&rreq->lock);
-	list_add_tail(&subreq->rreq_link, &stream->subrequests);
-	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-		if (!stream->active) {
-			stream->collected_to = subreq->start;
-			/* Store list pointers before active flag */
-			smp_store_release(&stream->active, true);
+	if (list_empty(&subreq->rreq_link)) {
+		list_add_tail(&subreq->rreq_link, &stream->subrequests);
+		if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
+			if (!stream->active) {
+				stream->collected_to = subreq->start;
+				/* Store list pointers before active flag */
+				smp_store_release(&stream->active, true);
+			}
 		}
 	}
 
-	if (last_subreq) {
+	rreq->submitted += subreq->len;
+	stream->issue_from = subreq->start + subreq->len;
+	if (!stream->buffered) {
 		smp_wmb(); /* Write lists before ALL_QUEUED. */
 		set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
+		trace_netfs_rreq(rreq, netfs_rreq_trace_all_queued);
 	}
 
 	spin_unlock(&rreq->lock);
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 }
+EXPORT_SYMBOL(netfs_mark_read_submission);
 
-static void netfs_issue_read(struct netfs_io_request *rreq,
-			     struct netfs_io_subrequest *subreq)
+static int netfs_issue_read(struct netfs_io_request *rreq,
+			    struct netfs_io_subrequest *subreq)
 {
-	bvecq_pos_set(&subreq->content, &subreq->dispatch_pos);
-	iov_iter_bvec_queue(&subreq->io_iter, ITER_DEST, subreq->content.bvecq,
-			    subreq->content.slot, subreq->content.offset, subreq->len);
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
+
+	_enter("R=%08x[%x]", rreq->debug_id, subreq->debug_index);
 
 	switch (subreq->source) {
 	case NETFS_DOWNLOAD_FROM_SERVER:
-		rreq->netfs_ops->issue_read(subreq);
-		break;
-	case NETFS_READ_FROM_CACHE:
-		netfs_read_cache_to_pagecache(rreq, subreq);
-		break;
+		return rreq->netfs_ops->issue_read(subreq);
+	case NETFS_READ_FROM_CACHE: {
+		struct netfs_cache_resources *cres = &rreq->cache_resources;
+
+		netfs_stat(&netfs_n_rh_read);
+		cres->ops->issue_read(subreq);
+		return -EIOCBQUEUED;
+	}
 	default:
-		bvecq_zero(&rreq->dispatch_cursor, subreq->len);
+		stream->issue_from = subreq->start + subreq->len;
+		stream->buffered = 0;
+		netfs_mark_read_submission(subreq);
+		bvecq_zero(&stream->dispatch_cursor, subreq->len);
 		subreq->transferred = subreq->len;
 		subreq->error = 0;
-		iov_iter_zero(subreq->len, &subreq->io_iter);
-		subreq->transferred = subreq->len;
 		netfs_read_subreq_terminated(subreq);
-		break;
+		return 0;
 	}
 }
 
@@ -228,21 +267,18 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		.cached_to[1]	= ULLONG_MAX,
 	};
 	struct fscache_occupancy *occ = &_occ;
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
 	struct netfs_inode *ictx = netfs_inode(rreq->inode);
-	unsigned long long start = rreq->start;
-	ssize_t size = rreq->len;
 	int ret = 0;
 
 	_enter("R=%08x", rreq->debug_id);
 
-	bvecq_pos_set(&rreq->dispatch_cursor, &rreq->load_cursor);
-	bvecq_pos_set(&rreq->collect_cursor, &rreq->dispatch_cursor);
+	bvecq_pos_set(&stream->dispatch_cursor, &rreq->load_cursor);
+	bvecq_pos_set(&rreq->collect_cursor, &rreq->load_cursor);
 
 	do {
-		int (*prepare_read)(struct netfs_io_subrequest *subreq) = NULL;
 		struct netfs_io_subrequest *subreq;
-		unsigned long long hole_to, cache_to;
-		ssize_t slice;
+		unsigned long long hole_to, cache_to, stop;
 
 		/* If we don't have any, find out the next couple of data
 		 * extents from the cache, containing of following the
@@ -251,7 +287,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		 */
 		hole_to = occ->cached_from[0];
 		cache_to = occ->cached_to[0];
-		if (start >= cache_to) {
+		if (stream->issue_from >= cache_to) {
 			/* Extent exhausted; shuffle down. */
 			int i;
 
@@ -279,36 +315,33 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			break;
 		}
 
-		subreq->start	= start;
-		subreq->len	= size;
+		subreq->start = stream->issue_from;
+		stop = stream->issue_from + stream->buffered;
 
 		_debug("rsub %llx %llx-%llx", subreq->start, hole_to, cache_to);
 
-		if (start >= hole_to && start < cache_to) {
+		if (stream->issue_from >= hole_to && stream->issue_from < cache_to) {
 			/* Overlap with a cached region, where the cache may
 			 * record a block of zeroes.
 			 */
-			_debug("cached s=%llx c=%llx l=%zx", start, cache_to, size);
-			subreq->len = umin(cache_to - start, size);
+			_debug("cached s=%llx c=%llx l=%zx",
+			       stream->issue_from, cache_to, stream->buffered);
+			subreq->len = umin(cache_to - stream->issue_from, stream->buffered);
 			subreq->len = round_up(subreq->len, occ->granularity);
 			if (occ->cached_type[0] == FSCACHE_EXTENT_ZERO) {
 				subreq->source = NETFS_FILL_WITH_ZEROES;
 				netfs_stat(&netfs_n_rh_zero);
 			} else {
 				subreq->source = NETFS_READ_FROM_CACHE;
-				prepare_read = rreq->cache_resources.ops->prepare_read;
 			}
-
-			trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-
 		} else if ((subreq->start >= ictx->zero_point ||
 			    subreq->start >= rreq->i_size) &&
-			   size > 0) {
+			   subreq->start < stop) {
 			/* If this range lies beyond the zero-point, that part
 			 * can just be cleared locally.
 			 */
-			_debug("zero %llx-%llx", start, start + size);
-			subreq->len = size;
+			_debug("zero %llx-%llx", subreq->start, stop);
+			subreq->len = stream->buffered;
 			subreq->source = NETFS_FILL_WITH_ZEROES;
 			if (rreq->cache_resources.ops)
 				__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
@@ -319,10 +352,10 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			 * that part can just be cleared locally.
 			 */
 			unsigned long long zlimit = umin(rreq->i_size, ictx->zero_point);
-			unsigned long long limit = min3(zlimit, start + size, hole_to);
+			unsigned long long limit = min3(zlimit, stop, hole_to);
 
 			_debug("limit %llx %llx", rreq->i_size, ictx->zero_point);
-			_debug("download %llx-%llx", start, start + size);
+			_debug("download %llx-%llx", subreq->start, stop);
 			subreq->len = umin(limit - subreq->start, ULONG_MAX);
 			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
 			if (rreq->cache_resources.ops)
@@ -330,10 +363,10 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			netfs_stat(&netfs_n_rh_download);
 		}
 
-		if (size == 0) {
+		if (subreq->len == 0) {
 			pr_err("ZERO-LEN READ: R=%08x[%x] l=%zx/%zx s=%llx z=%llx i=%llx",
 			       rreq->debug_id, subreq->debug_index,
-			       subreq->len, size,
+			       subreq->len, stream->buffered,
 			       subreq->start, ictx->zero_point, rreq->i_size);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_cancel);
 			/* Not queued - release both refs. */
@@ -342,24 +375,8 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			break;
 		}
 
-		rreq->io_streams[0].sreq_max_len = MAX_RW_COUNT;
-		rreq->io_streams[0].sreq_max_segs = INT_MAX;
-
-		if (prepare_read) {
-			ret = prepare_read(subreq);
-			if (ret < 0) {
-				subreq->error = ret;
-				/* Not queued - release both refs. */
-				netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
-				netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
-				break;
-			}
-			trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-		}
-
-		slice = netfs_prepare_read_iterator(subreq);
-		if (slice < 0) {
-			ret = slice;
+		ret = netfs_issue_read(rreq, subreq);
+		if (ret != 0 && ret != -EIOCBQUEUED) {
 			subreq->error = ret;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_cancel);
 			/* Not queued - release both refs. */
@@ -367,18 +384,12 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
 			break;
 		}
-		size -= slice;
-		start += slice;
+		ret = 0;
 
-		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-
-		netfs_queue_read(rreq, subreq, size <= 0);
-		netfs_issue_read(rreq, subreq);
-		netfs_maybe_bulk_drop_ra_refs(rreq);
 		cond_resched();
-	} while (size > 0);
+	} while (stream->buffered > 0);
 
-	if (unlikely(size > 0)) {
+	if (unlikely(stream->buffered > 0)) {
 		smp_wmb(); /* Write lists before ALL_QUEUED. */
 		set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
 		netfs_wake_collector(rreq);
@@ -388,7 +399,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 	cmpxchg(&rreq->error, 0, ret);
 
 	bvecq_pos_unset(&rreq->load_cursor);
-	bvecq_pos_unset(&rreq->dispatch_cursor);
+	bvecq_pos_unset(&stream->dispatch_cursor);
 }
 
 /**
@@ -409,17 +420,22 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 void netfs_readahead(struct readahead_control *ractl)
 {
 	struct netfs_io_request *rreq;
+	struct netfs_io_stream *stream;
 	struct netfs_inode *ictx = netfs_inode(ractl->mapping->host);
 	unsigned long long start = readahead_pos(ractl);
 	ssize_t added;
 	size_t size = readahead_length(ractl);
 	int ret;
 
+	_enter("");
+
 	rreq = netfs_alloc_request(ractl->mapping, ractl->file, start, size,
 				   NETFS_READAHEAD);
 	if (IS_ERR(rreq))
 		return;
 
+	stream = &rreq->io_streams[0];
+
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags);
 
 	ret = netfs_begin_cache_read(rreq, ictx);
@@ -446,6 +462,8 @@ void netfs_readahead(struct readahead_control *ractl)
 	rreq->submitted = rreq->start + added;
 	rreq->cleaned_to = rreq->start;
 	rreq->front_folio_order = get_order(rreq->load_cursor.bvecq->bv[0].bv_len);
+	stream->issue_from = rreq->start;
+	stream->buffered = added;
 
 	netfs_read_to_pagecache(rreq);
 	netfs_maybe_bulk_drop_ra_refs(rreq);
@@ -461,6 +479,7 @@ EXPORT_SYMBOL(netfs_readahead);
  */
 static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct folio *folio)
 {
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
 	struct bvecq *bq;
 	size_t fsize = folio_size(folio);
 
@@ -470,6 +489,8 @@ static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct fo
 	bq = rreq->load_cursor.bvecq;
 	bvec_set_folio(&bq->bv[bq->nr_slots++], folio, fsize, 0);
 	rreq->submitted = rreq->start + fsize;
+	stream->issue_from = rreq->start;
+	stream->buffered = fsize;
 	return 0;
 }
 
@@ -479,6 +500,7 @@ static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct fo
 static int netfs_read_gaps(struct file *file, struct folio *folio)
 {
 	struct netfs_io_request *rreq;
+	struct netfs_io_stream *stream;
 	struct address_space *mapping = folio->mapping;
 	struct netfs_folio *finfo = netfs_folio_info(folio);
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
@@ -499,6 +521,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 		ret = PTR_ERR(rreq);
 		goto alloc_error;
 	}
+	stream = &rreq->io_streams[0];
 
 	ret = netfs_begin_cache_read(rreq, ctx);
 	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
@@ -546,6 +569,8 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 	}
 
 	rreq->submitted = rreq->start + flen;
+	stream->issue_from = rreq->start;
+	stream->buffered = flen;
 
 	netfs_read_to_pagecache(rreq);
 
@@ -618,6 +643,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 		goto discard;
 
 	netfs_read_to_pagecache(rreq);
+
 	ret = netfs_wait_for_read(rreq);
 	netfs_put_request(rreq, netfs_rreq_trace_put_return);
 	return ret < 0 ? ret : 0;
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index bce3e7109ec1..855c14118c53 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -114,8 +114,8 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		.range_start	= iocb->ki_pos,
 		.range_end	= iocb->ki_pos + iter->count,
 	};
-	struct netfs_io_request *wreq = NULL;
-	struct folio *folio = NULL, *writethrough = NULL;
+	struct netfs_writethrough *writethrough = NULL;
+	struct folio *folio = NULL;
 	unsigned int bdp_flags = (iocb->ki_flags & IOCB_NOWAIT) ? BDP_ASYNC : 0;
 	ssize_t written = 0, ret, ret2;
 	loff_t pos = iocb->ki_pos;
@@ -132,15 +132,13 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 			goto out;
 		}
 
-		wreq = netfs_begin_writethrough(iocb, iter->count);
-		if (IS_ERR(wreq)) {
+		writethrough = netfs_begin_writethrough(iocb, iter->count);
+		if (IS_ERR(writethrough)) {
 			wbc_detach_inode(&wbc);
-			ret = PTR_ERR(wreq);
-			wreq = NULL;
+			ret = PTR_ERR(writethrough);
+			writethrough = NULL;
 			goto out;
 		}
-		if (!is_sync_kiocb(iocb))
-			wreq->iocb = iocb;
 		netfs_stat(&netfs_n_wh_writethrough);
 	} else {
 		netfs_stat(&netfs_n_wh_buffered_write);
@@ -264,7 +262,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		 * a file that's open for reading as ->read_folio() then has to
 		 * be able to flush it.
 		 */
-		if ((file->f_mode & FMODE_READ) ||
+		if (//(file->f_mode & FMODE_READ) ||
 		    netfs_is_cache_enabled(ctx)) {
 			if (finfo) {
 				netfs_stat(&netfs_n_wh_wstream_conflict);
@@ -355,13 +353,12 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		pos += copied;
 		written += copied;
 
-		if (likely(!wreq)) {
+		if (likely(!writethrough)) {
 			folio_mark_dirty(folio);
 			folio_unlock(folio);
 		} else {
-			netfs_advance_writethrough(wreq, &wbc, folio, copied,
-						   offset + copied == flen,
-						   &writethrough);
+			netfs_advance_writethrough(writethrough, &wbc, folio, copied,
+						   offset + copied == flen);
 			/* Folio unlocked */
 		}
 	retry:
@@ -385,8 +382,8 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 			ctx->ops->post_modify(inode);
 	}
 
-	if (unlikely(wreq)) {
-		ret2 = netfs_end_writethrough(wreq, &wbc, writethrough);
+	if (unlikely(writethrough)) {
+		ret2 = netfs_end_writethrough(writethrough, &wbc);
 		wbc_detach_inode(&wbc);
 		if (ret2 == -EIOCBQUEUED)
 			return ret2;
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 05d09ba3d0d0..872e44227368 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -16,6 +16,28 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+int netfs_prepare_unbuffered_read_buffer(struct netfs_io_subrequest *subreq,
+					 unsigned int max_segs)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
+	size_t len;
+
+	bvecq_pos_set(&subreq->dispatch_pos, &stream->dispatch_cursor);
+	bvecq_pos_set(&subreq->content, &stream->dispatch_cursor);
+	len = bvecq_slice(&stream->dispatch_cursor, subreq->len, max_segs,
+			  &subreq->nr_segs);
+
+	if (len < subreq->len) {
+		subreq->len = len;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+	}
+
+	stream->buffered   -= subreq->len;
+	stream->issue_from += subreq->len;
+	return 0;
+}
+
 /*
  * Perform a read to a buffer from the server, slicing up the region to be read
  * according to the network rsize.
@@ -23,11 +45,9 @@
 static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 {
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
-	unsigned long long start = rreq->start;
-	ssize_t size = rreq->len;
 	int ret = 0;
 
-	bvecq_pos_set(&rreq->dispatch_cursor, &rreq->load_cursor);
+	bvecq_pos_transfer(&stream->dispatch_cursor, &rreq->load_cursor);
 
 	do {
 		struct netfs_io_subrequest *subreq;
@@ -39,66 +59,36 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 		}
 
 		subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
-		subreq->start	= start;
-		subreq->len	= size;
-
-		__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-
-		spin_lock(&rreq->lock);
-		list_add_tail(&subreq->rreq_link, &stream->subrequests);
-		if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-			if (!stream->active) {
-				stream->collected_to = subreq->start;
-				/* Store list pointers before active flag */
-				smp_store_release(&stream->active, true);
-			}
-		}
-		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-		spin_unlock(&rreq->lock);
+		subreq->start	= stream->issue_from;
+		subreq->len	= stream->buffered;
 
 		netfs_stat(&netfs_n_rh_download);
-		if (rreq->netfs_ops->prepare_read) {
-			ret = rreq->netfs_ops->prepare_read(subreq);
-			if (ret < 0) {
-				netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
-				break;
-			}
-		}
 
-		bvecq_pos_set(&subreq->dispatch_pos, &rreq->dispatch_cursor);
-		bvecq_pos_set(&subreq->content, &rreq->dispatch_cursor);
-		subreq->len = bvecq_slice(&rreq->dispatch_cursor,
-					  umin(size, stream->sreq_max_len),
-					  stream->sreq_max_segs,
-					  &subreq->nr_segs);
-
-		size -= subreq->len;
-		start += subreq->len;
-		rreq->submitted += subreq->len;
-		if (size <= 0) {
-			smp_wmb(); /* Write lists before ALL_QUEUED. */
-			set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
+		ret = rreq->netfs_ops->issue_read(subreq);
+		if (ret != 0 && ret != -EIOCBQUEUED) {
+			subreq->error = ret;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_cancel);
+			/* Not queued - release both refs. */
+			netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
+			netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
+			break;
 		}
 
-		iov_iter_bvec_queue(&subreq->io_iter, ITER_DEST, subreq->content.bvecq,
-				    subreq->content.slot, subreq->content.offset, subreq->len);
-
-		rreq->netfs_ops->issue_read(subreq);
-
+		ret = 0;
 		if (test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
 			netfs_wait_for_paused_read(rreq);
 		if (test_bit(NETFS_RREQ_FAILED, &rreq->flags))
 			break;
 		cond_resched();
-	} while (size > 0);
+	} while (stream->buffered > 0);
 
-	if (unlikely(size > 0)) {
+	if (unlikely(stream->buffered > 0)) {
 		smp_wmb(); /* Write lists before ALL_QUEUED. */
 		set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
 		netfs_wake_collector(rreq);
 	}
 
-	bvecq_pos_unset(&rreq->dispatch_cursor);
+	bvecq_pos_unset(&stream->dispatch_cursor);
 	return ret;
 }
 
@@ -154,6 +144,7 @@ static ssize_t netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
 ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct netfs_io_request *rreq;
+	struct netfs_io_stream *stream;
 	ssize_t ret;
 	size_t orig_count = iov_iter_count(iter);
 	bool sync = is_sync_kiocb(iocb);
@@ -178,6 +169,8 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 	netfs_stat(&netfs_n_rh_dio_read);
 	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_dio_read);
 
+	stream = &rreq->io_streams[0];
+
 	/* If this is an async op, we have to keep track of the destination
 	 * buffer for ourselves as the caller's iterator will be trashed when
 	 * we return.
@@ -192,6 +185,10 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 	if (ret < 0)
 		goto error_put;
 
+	rreq->len = ret;
+	stream->buffered = ret;
+	stream->issue_from = rreq->start;
+
 	// TODO: Set up bounce buffer if needed
 
 	if (!sync) {
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index a61c6d6fd17f..b04b16d35c38 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -9,6 +9,32 @@
 #include <linux/uio.h>
 #include "internal.h"
 
+/*
+ * Prepare the buffer for an unbuffered/DIO write.
+ */
+int netfs_prepare_unbuffered_write_buffer(struct netfs_io_subrequest *subreq,
+					  unsigned int max_segs)
+{
+	struct netfs_io_stream *stream = &subreq->rreq->io_streams[subreq->stream_nr];
+	size_t len;
+
+	bvecq_pos_set(&subreq->dispatch_pos, &stream->dispatch_cursor);
+	bvecq_pos_set(&subreq->content, &stream->dispatch_cursor);
+	len = bvecq_slice(&stream->dispatch_cursor, subreq->len, max_segs,
+			  &subreq->nr_segs);
+
+	if (len < subreq->len) {
+		subreq->len = len;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+	}
+
+	// TODO: Wait here for completion of prev subreq
+
+	stream->issue_from += subreq->len;
+	stream->buffered   -= subreq->len;
+	return 0;
+}
+
 /*
  * Perform the cleanup rituals after an unbuffered write is complete.
  */
@@ -74,9 +100,9 @@ static void netfs_unbuffered_write_collect(struct netfs_io_request *wreq,
 
 	wreq->transferred += subreq->transferred;
 	if (subreq->transferred < subreq->len) {
-		bvecq_pos_unset(&wreq->dispatch_cursor);
-		bvecq_pos_transfer(&wreq->dispatch_cursor, &subreq->dispatch_pos);
-		bvecq_pos_advance(&wreq->dispatch_cursor, subreq->transferred);
+		bvecq_pos_unset(&stream->dispatch_cursor);
+		bvecq_pos_transfer(&stream->dispatch_cursor, &subreq->dispatch_pos);
+		bvecq_pos_advance(&stream->dispatch_cursor, subreq->transferred);
 	}
 
 	stream->collected_to = subreq->start + subreq->transferred;
@@ -85,6 +111,7 @@ static void netfs_unbuffered_write_collect(struct netfs_io_request *wreq,
 
 	trace_netfs_collect_stream(wreq, stream);
 	trace_netfs_collect_state(wreq, wreq->collected_to, 0);
+	/* TODO: Progressively clean up wreq->direct_bq */
 }
 
 /*
@@ -103,60 +130,60 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 
 	_enter("%llx", wreq->len);
 
-	bvecq_pos_set(&wreq->dispatch_cursor, &wreq->load_cursor);
-	bvecq_pos_set(&wreq->collect_cursor, &wreq->dispatch_cursor);
+	stream->issue_from = wreq->start;
+	stream->buffered = wreq->len;
+	bvecq_pos_set(&stream->dispatch_cursor, &wreq->load_cursor);
+	bvecq_pos_set(&wreq->collect_cursor, &stream->dispatch_cursor);
 
 	if (wreq->origin == NETFS_DIO_WRITE)
 		inode_dio_begin(wreq->inode);
 
-	stream->collected_to = wreq->start;
-
 	for (;;) {
 		bool retry = false;
 
 		if (!subreq) {
-			netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred);
-			subreq = stream->construct;
-			stream->construct = NULL;
-		} else {
-			bvecq_pos_set(&subreq->dispatch_pos, &wreq->dispatch_cursor);
+			subreq = netfs_alloc_write_subreq(wreq, stream);
+			if (!subreq)
+				return -ENOMEM;
 		}
 
-		/* Check if (re-)preparation failed. */
-		if (unlikely(test_bit(NETFS_SREQ_FAILED, &subreq->flags))) {
-			netfs_write_subrequest_terminated(subreq, subreq->error);
-			wreq->error = subreq->error;
+		ret = stream->issue_write(subreq);
+		switch (ret) {
+		case 0:
+			/* Already completed synchronously. */
 			break;
-		}
-
-		subreq->len = bvecq_slice(&wreq->dispatch_cursor, stream->sreq_max_len,
-					  stream->sreq_max_segs, &subreq->nr_segs);
-		bvecq_pos_set(&subreq->content, &subreq->dispatch_pos);
-
-		iov_iter_bvec_queue(&subreq->io_iter, ITER_SOURCE,
-				    subreq->content.bvecq, subreq->content.slot,
-				    subreq->content.offset,
-				    subreq->len);
-
-		if (!iov_iter_count(&subreq->io_iter))
+		case -EIOCBQUEUED:
+			/* Async, need to wait. */
+			ret = netfs_wait_for_in_progress_subreq(wreq, subreq);
+			if (ret < 0) {
+				if (ret == -EAGAIN) {
+					retry = true;
+					break;
+				}
+
+				list_del_init(&subreq->rreq_link);
+				ret = subreq->error;
+				netfs_put_subrequest(subreq, netfs_sreq_trace_put_failed);
+				subreq = NULL;
+				goto failed;
+			}
 			break;
-
-		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-		stream->issue_write(subreq);
-
-		/* Async, need to wait. */
-		netfs_wait_for_in_progress_stream(wreq, stream);
-
-		if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+		case -EAGAIN:
+			/* Need to retry. */
+			__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 			retry = true;
-		} else if (test_bit(NETFS_SREQ_FAILED, &subreq->flags)) {
-			ret = subreq->error;
+			break;
+		default:
+			/* Probably failed before dispatch. */
+			subreq->error = ret;
 			wreq->error = ret;
-			netfs_see_subrequest(subreq, netfs_sreq_trace_see_failed);
+			__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_cancel);
+			list_del_init(&subreq->rreq_link);
+			netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
 			subreq = NULL;
-			break;
+			goto failed;
 		}
-		ret = 0;
 
 		if (!retry) {
 			netfs_unbuffered_write_collect(wreq, stream, subreq);
@@ -171,20 +198,21 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 			continue;
 		}
 
-		/* We need to retry the last subrequest, so first reset the
-		 * iterator, taking into account what, if anything, we managed
-		 * to transfer.
+		/* We need to retry the last subrequest, so first wind back the
+		 * buffer position.
 		 */
 		subreq->error = -EAGAIN;
 		trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
 		bvecq_pos_unset(&subreq->content);
-		bvecq_pos_unset(&wreq->dispatch_cursor);
-		bvecq_pos_transfer(&wreq->dispatch_cursor, &subreq->dispatch_pos);
+		bvecq_pos_unset(&stream->dispatch_cursor);
+		bvecq_pos_transfer(&stream->dispatch_cursor, &subreq->dispatch_pos);
 
 		if (subreq->transferred > 0) {
-			wreq->transferred += subreq->transferred;
-			bvecq_pos_advance(&wreq->dispatch_cursor, subreq->transferred);
+			wreq->transferred  += subreq->transferred;
+			stream->issue_from -= subreq->len - subreq->transferred;
+			stream->buffered   += subreq->len - subreq->transferred;
+			bvecq_pos_advance(&stream->dispatch_cursor, subreq->transferred);
 		}
 
 		if (stream->source == NETFS_UPLOAD_TO_SERVER &&
@@ -192,25 +220,21 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 			wreq->netfs_ops->retry_request(wreq, stream);
 
 		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-		__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
 		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
-		subreq->start		= wreq->start + wreq->transferred;
-		subreq->len		= wreq->len   - wreq->transferred;
+		__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+		subreq->start		= stream->issue_from;
+		subreq->len		= stream->buffered;
 		subreq->transferred	= 0;
 		subreq->retry_count	+= 1;
-		stream->sreq_max_len	= UINT_MAX;
-		stream->sreq_max_segs	= INT_MAX;
 
 		netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 
-		if (stream->prepare_write)
-			stream->prepare_write(subreq);
 		__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 		netfs_stat(&netfs_n_wh_retry_write_subreq);
 	}
 
-	bvecq_pos_unset(&wreq->dispatch_cursor);
-	bvecq_pos_unset(&wreq->load_cursor);
+failed:
+	bvecq_pos_unset(&stream->dispatch_cursor);
 	netfs_unbuffered_write_done(wreq);
 	_leave(" = %d", ret);
 	return ret;
@@ -254,6 +278,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 	if (IS_ERR(wreq))
 		return PTR_ERR(wreq);
 
+	wreq->len = iov_iter_count(iter);
 	wreq->io_streams[0].avail = true;
 	trace_netfs_write(wreq, (iocb->ki_flags & IOCB_DIRECT ?
 				 netfs_write_trace_dio_write :
@@ -264,9 +289,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		 * we have to save the source buffer as the iterator is only
 		 * good until we return.  In such a case, extract an iterator
 		 * to represent as much of the the output buffer as we can
-		 * manage.  Note that the extraction might not be able to
-		 * allocate a sufficiently large bvec array and may shorten the
-		 * request.
+		 * manage.  Note that the extraction may shorten the request.
 		 */
 		ssize_t n = netfs_extract_iter(iter, len, INT_MAX, iocb->ki_pos,
 					       &wreq->load_cursor.bvecq, 0);
@@ -281,8 +304,6 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		       wreq->load_cursor.bvecq->max_slots);
 	}
 
-	__set_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags);
-
 	/* Copy the data into the bounce buffer and encrypt it. */
 	// TODO
 
diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 37f05b4d3469..70b10ac23a27 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -239,10 +239,6 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 				    fscache_access_io_write) < 0)
 		goto abandon_free;
 
-	ret = cres->ops->prepare_write(cres, &start, &len, len, i_size, false);
-	if (ret < 0)
-		goto abandon_end;
-
 	/* TODO: Consider clearing page bits now for space the write isn't
 	 * covering.  This is more complicated than it appears when THPs are
 	 * taken into account.
@@ -252,8 +248,6 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 	fscache_write(cres, start, &iter, fscache_wreq_done, wreq);
 	return;
 
-abandon_end:
-	return fscache_wreq_done(wreq, ret);
 abandon_free:
 	kfree(wreq);
 abandon:
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index ddae82f94ce0..ecf7cd5b5ca1 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -34,6 +34,18 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
 			 loff_t pos, size_t copied);
 
+/*
+ * direct_read.c
+ */
+int netfs_prepare_unbuffered_read_buffer(struct netfs_io_subrequest *subreq,
+					 unsigned int max_segs);
+
+/*
+ * direct_write.c
+ */
+int netfs_prepare_unbuffered_write_buffer(struct netfs_io_subrequest *subreq,
+					  unsigned int max_segs);
+
 /*
  * main.c
  */
@@ -70,6 +82,8 @@ struct bvecq *netfs_buffer_make_space(struct netfs_io_request *rreq,
 				      enum netfs_bvecq_trace trace);
 void netfs_wake_collector(struct netfs_io_request *rreq);
 void netfs_subreq_clear_in_progress(struct netfs_io_subrequest *subreq);
+int netfs_wait_for_in_progress_subreq(struct netfs_io_request *rreq,
+				      struct netfs_io_subrequest *subreq);
 void netfs_wait_for_in_progress_stream(struct netfs_io_request *rreq,
 				       struct netfs_io_stream *stream);
 ssize_t netfs_wait_for_read(struct netfs_io_request *rreq);
@@ -113,16 +127,53 @@ void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error);
 /*
  * read_pgpriv2.c
  */
+#ifdef CONFIG_NETFS_PGPRIV2
+int netfs_prepare_pgpriv2_write_buffer(struct netfs_io_subrequest *subreq,
+				       unsigned int max_segs);
 void netfs_pgpriv2_copy_to_cache(struct netfs_io_request *rreq, struct folio *folio);
 void netfs_pgpriv2_end_copy_to_cache(struct netfs_io_request *rreq);
 bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq);
+static inline bool netfs_using_pgpriv2(const struct netfs_io_request *rreq)
+{
+	return test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);
+}
+#else
+static inline int netfs_prepare_pgpriv2_write_buffer(struct netfs_io_subrequest *subreq,
+						     unsigned int max_segs)
+{
+	return -EIO;
+}
+static inline void netfs_pgpriv2_copy_to_cache(struct netfs_io_request *rreq, struct folio *folio)
+{
+}
+static inline void netfs_pgpriv2_end_copy_to_cache(struct netfs_io_request *rreq)
+{
+}
+static inline bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq)
+{
+	return true;
+}
+static inline bool netfs_using_pgpriv2(const struct netfs_io_request *rreq)
+{
+	return false;
+}
+#endif
 
 /*
  * read_retry.c
  */
+int netfs_prepare_buffered_read_retry_buffer(struct netfs_io_subrequest *subreq,
+					     unsigned int max_segs);
+int netfs_reset_for_read_retry(struct netfs_io_subrequest *subreq);
 void netfs_retry_reads(struct netfs_io_request *rreq);
 void netfs_unlock_abandoned_read_pages(struct netfs_io_request *rreq);
 
+/*
+ * read_single.c
+ */
+int netfs_prepare_read_single_buffer(struct netfs_io_subrequest *subreq,
+				     unsigned int max_segs);
+
 /*
  * stats.c
  */
@@ -194,30 +245,25 @@ void netfs_write_collection_worker(struct work_struct *work);
 /*
  * write_issue.c
  */
+struct netfs_writethrough;
 struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 						struct file *file,
 						loff_t start,
 						enum netfs_io_origin origin);
-void netfs_prepare_write(struct netfs_io_request *wreq,
-			 struct netfs_io_stream *stream,
-			 loff_t start);
-void netfs_reissue_write(struct netfs_io_stream *stream,
-			 struct netfs_io_subrequest *subreq);
-void netfs_issue_write(struct netfs_io_request *wreq,
-		       struct netfs_io_stream *stream);
-size_t netfs_advance_write(struct netfs_io_request *wreq,
-			   struct netfs_io_stream *stream,
-			   loff_t start, size_t len, bool to_eof);
-struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
-int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
-			       struct folio *folio, size_t copied, bool to_page_end,
-			       struct folio **writethrough_cache);
-ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
-			       struct folio *writethrough_cache);
+struct netfs_io_subrequest *netfs_alloc_write_subreq(struct netfs_io_request *wreq,
+						     struct netfs_io_stream *stream);
+struct netfs_writethrough *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
+int netfs_advance_writethrough(struct netfs_writethrough *wthru,
+			       struct writeback_control *wbc,
+			       struct folio *folio, size_t copied, bool to_page_end);
+ssize_t netfs_end_writethrough(struct netfs_writethrough *wthru,
+			       struct writeback_control *wbc);
 
 /*
  * write_retry.c
  */
+int netfs_prepare_write_retry_buffer(struct netfs_io_subrequest *subreq,
+				     unsigned int max_segs);
 void netfs_retry_writes(struct netfs_io_request *wreq);
 
 /*
diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 7969c0b1f9a9..69164e8b8e57 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -102,14 +102,14 @@ ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_se
 			}
 
 			if (got == 0) {
-				pr_err("extract_pages gave nothing from %zu, %zu\n",
+				pr_err("extract_pages gave nothing from %zx, %zx\n",
 				       extracted, orig_len);
 				ret = -EIO;
 				goto out;
 			}
 
-			if (got > orig_len - extracted) {
-				pr_err("extract_pages rc=%zd more than %zu\n",
+			if (got > orig_len) {
+				pr_err("extract_pages rc=%zx more than %zx\n",
 				       got, orig_len);
 				goto out;
 			}
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index a19724389147..796dc227c2b2 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -232,6 +232,37 @@ void netfs_subreq_clear_in_progress(struct netfs_io_subrequest *subreq)
 		netfs_wake_collector(rreq);
 }
 
+/*
+ * Wait for a subrequest to come to completion.
+ */
+int netfs_wait_for_in_progress_subreq(struct netfs_io_request *rreq,
+				      struct netfs_io_subrequest *subreq)
+{
+	if (netfs_check_subreq_in_progress(subreq)) {
+		DEFINE_WAIT(myself);
+
+		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_quiesce);
+		for (;;) {
+			prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
+
+			if (!netfs_check_subreq_in_progress(subreq))
+				break;
+
+			trace_netfs_sreq(subreq, netfs_sreq_trace_wait_for);
+			schedule();
+		}
+
+		trace_netfs_rreq(rreq, netfs_rreq_trace_waited_quiesce);
+		finish_wait(&rreq->waitq, &myself);
+	}
+
+	if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
+		return -EAGAIN;
+	if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
+		return subreq->error;
+	return 0;
+}
+
 /*
  * Wait for all outstanding I/O in a stream to quiesce.
  */
@@ -361,7 +392,7 @@ static ssize_t netfs_wait_for_in_progress(struct netfs_io_request *rreq,
 		case NETFS_UNBUFFERED_WRITE:
 			break;
 		default:
-			if (rreq->submitted < rreq->len) {
+			if (rreq->transferred < rreq->len) {
 				trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
 				ret = -EIO;
 			}
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index eff431cd7d6a..3db79943762d 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -46,8 +46,6 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	rreq->i_size	= i_size_read(inode);
 	rreq->debug_id	= atomic_inc_return(&debug_ids);
 	rreq->wsize	= INT_MAX;
-	rreq->io_streams[0].sreq_max_len = ULONG_MAX;
-	rreq->io_streams[0].sreq_max_segs = 0;
 	spin_lock_init(&rreq->lock);
 	INIT_LIST_HEAD(&rreq->io_streams[0].subrequests);
 	INIT_LIST_HEAD(&rreq->io_streams[1].subrequests);
@@ -134,8 +132,10 @@ static void netfs_deinit_request(struct netfs_io_request *rreq)
 	if (rreq->cache_resources.ops)
 		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
 	bvecq_pos_unset(&rreq->load_cursor);
-	bvecq_pos_unset(&rreq->dispatch_cursor);
 	bvecq_pos_unset(&rreq->collect_cursor);
+	bvecq_pos_unset(&rreq->retry_cursor);
+	for (int i = 0; i < NR_IO_STREAMS; i++)
+		bvecq_pos_unset(&rreq->io_streams[i].dispatch_cursor);
 
 	if (atomic_dec_and_test(&ictx->io_count))
 		wake_up_var(&ictx->io_count);
@@ -226,6 +226,7 @@ static void netfs_free_subrequest(struct netfs_io_subrequest *subreq)
 	struct netfs_io_request *rreq = subreq->rreq;
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
+	WARN_ON_ONCE(!list_empty(&subreq->rreq_link));
 	if (rreq->netfs_ops->free_subrequest)
 		rreq->netfs_ops->free_subrequest(subreq);
 	bvecq_pos_unset(&subreq->dispatch_pos);
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 6d49f9a6b1f0..fbb0425ecb89 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -36,6 +36,7 @@ static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
 
 	if (subreq->start + subreq->transferred >= subreq->rreq->i_size)
 		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
+	trace_netfs_rreq(subreq->rreq, netfs_rreq_trace_zero_unread);
 }
 
 /*
@@ -58,7 +59,7 @@ static void netfs_unlock_read_folio(struct netfs_io_request *rreq,
 	flush_dcache_folio(folio);
 	folio_mark_uptodate(folio);
 
-	if (!test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags)) {
+	if (!netfs_using_pgpriv2(rreq)) {
 		finfo = netfs_folio_info(folio);
 		if (finfo) {
 			trace_netfs_folio(folio, netfs_folio_trace_filled_gaps);
@@ -264,8 +265,7 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 				transferred = front->len;
 				trace_netfs_rreq(rreq, netfs_rreq_trace_set_abandon);
 			}
-			if (front->start + transferred >= rreq->cleaned_to + fsize ||
-			    test_bit(NETFS_SREQ_HIT_EOF, &front->flags))
+			if (front->start + transferred >= rreq->cleaned_to + fsize)
 				netfs_read_unlock_folios(rreq, &notes);
 		} else {
 			stream->collected_to = front->start + transferred;
@@ -381,31 +381,6 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 		inode_dio_end(rreq->inode);
 }
 
-/*
- * Do processing after reading a monolithic single object.
- */
-static void netfs_rreq_assess_single(struct netfs_io_request *rreq)
-{
-	struct netfs_io_stream *stream = &rreq->io_streams[0];
-
-	if (!rreq->error && stream->source == NETFS_DOWNLOAD_FROM_SERVER &&
-	    fscache_resources_valid(&rreq->cache_resources)) {
-		trace_netfs_rreq(rreq, netfs_rreq_trace_dirty);
-		netfs_single_mark_inode_dirty(rreq->inode);
-	}
-
-	if (rreq->iocb) {
-		rreq->iocb->ki_pos += rreq->transferred;
-		if (rreq->iocb->ki_complete) {
-			trace_netfs_rreq(rreq, netfs_rreq_trace_ki_complete);
-			rreq->iocb->ki_complete(
-				rreq->iocb, rreq->error ? rreq->error : rreq->transferred);
-		}
-	}
-	if (rreq->netfs_ops->done)
-		rreq->netfs_ops->done(rreq);
-}
-
 /*
  * Perform the collection of subrequests and folios.
  *
@@ -441,7 +416,7 @@ bool netfs_read_collection(struct netfs_io_request *rreq)
 		netfs_rreq_assess_dio(rreq);
 		break;
 	case NETFS_READ_SINGLE:
-		netfs_rreq_assess_single(rreq);
+		WARN_ON_ONCE(1);
 		break;
 	default:
 		break;
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index fb783318318e..5f4d1a21afc5 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -13,8 +13,39 @@
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 
+int netfs_prepare_pgpriv2_write_buffer(struct netfs_io_subrequest *subreq,
+				       unsigned int max_segs)
+{
+	struct netfs_io_request *creq = subreq->rreq;
+	struct netfs_io_stream *stream = &creq->io_streams[1];
+	size_t len;
+
+	bvecq_pos_set(&subreq->dispatch_pos, &stream->dispatch_cursor);
+	bvecq_pos_set(&subreq->content, &stream->dispatch_cursor);
+	len = bvecq_slice(&stream->dispatch_cursor, subreq->len, max_segs,
+			  &subreq->nr_segs);
+
+	if (len < subreq->len) {
+		subreq->len = len;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+	}
+
+	// TODO: Wait here for completion of prev subreq
+
+	stream->issue_from += subreq->len;
+	stream->buffered   -= subreq->len;
+	if (stream->buffered == 0) {
+		smp_wmb(); /* Write lists before ALL_QUEUED. */
+		set_bit(NETFS_RREQ_ALL_QUEUED, &creq->flags);
+	}
+	return 0;
+}
+
 /*
- * [DEPRECATED] Copy a folio to the cache with PG_private_2 set.
+ * [DEPRECATED] Copy a folio to the cache with PG_private_2 set.  Note that the
+ * folio won't necessarily be contiguous with the previous one as there might
+ * be a mixture of folios read from the cache and downloaded from the server
+ * (or just zeroed).
  */
 static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio *folio)
 {
@@ -24,7 +55,6 @@ static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio
 	size_t dio_size = PAGE_SIZE;
 	size_t fsize = folio_size(folio), flen = fsize;
 	loff_t fpos = folio_pos(folio), i_size;
-	bool to_eof = false;
 
 	_enter("");
 
@@ -44,12 +74,8 @@ static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio
 	if (fpos + fsize > creq->i_size)
 		creq->i_size = i_size;
 
-	if (flen > i_size - fpos) {
+	if (flen > i_size - fpos)
 		flen = i_size - fpos;
-		to_eof = true;
-	} else if (flen == i_size - fpos) {
-		to_eof = true;
-	}
 
 	flen = round_up(flen, dio_size);
 
@@ -57,7 +83,6 @@ static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio
 
 	trace_netfs_folio(folio, netfs_folio_trace_store_copy);
 
-
 	/* Institute a new bvec queue segment if the current one is full or if
 	 * we encounter a discontiguity.  The discontiguity break is important
 	 * when it comes to bulk unlocking folios by file range.
@@ -79,40 +104,13 @@ static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio
 	/* Attach the folio to the rolling buffer. */
 	slot = queue->nr_slots;
 	bvec_set_folio(&queue->bv[slot], folio, fsize, 0);
-	/* Order incrementing the slot counter after the slot is filled. */
-	smp_store_release(&queue->nr_slots, slot + 1);
+	queue->nr_slots = slot + 1;
 	creq->load_cursor.slot = slot + 1;
 	creq->load_cursor.offset = 0;
 	trace_netfs_bv_slot(queue, slot);
+	trace_netfs_wback(creq, folio, 0);
 
-	cache->submit_off = 0;
-	cache->submit_len = flen;
-
-	/* Attach the folio to one or more subrequests.  For a big folio, we
-	 * could end up with thousands of subrequests if the wsize is small -
-	 * but we might need to wait during the creation of subrequests for
-	 * network resources (eg. SMB credits).
-	 */
-	do {
-		ssize_t part;
-
-		creq->dispatch_cursor.offset = cache->submit_off;
-
-		atomic64_set(&creq->issued_to, fpos + cache->submit_off);
-		part = netfs_advance_write(creq, cache, fpos + cache->submit_off,
-					   cache->submit_len, to_eof);
-		cache->submit_off += part;
-		if (part > cache->submit_len)
-			cache->submit_len = 0;
-		else
-			cache->submit_len -= part;
-	} while (cache->submit_len > 0);
-
-	bvecq_pos_step(&creq->dispatch_cursor);
-	atomic64_set(&creq->issued_to, fpos + fsize);
-
-	if (flen < fsize)
-		netfs_issue_write(creq, cache);
+	cache->buffered += flen;
 }
 
 /*
@@ -122,6 +120,7 @@ static struct netfs_io_request *netfs_pgpriv2_begin_copy_to_cache(
 	struct netfs_io_request *rreq, struct folio *folio)
 {
 	struct netfs_io_request *creq;
+	struct netfs_io_stream *cache;
 
 	if (!fscache_resources_valid(&rreq->cache_resources))
 		goto cancel;
@@ -131,12 +130,15 @@ static struct netfs_io_request *netfs_pgpriv2_begin_copy_to_cache(
 	if (IS_ERR(creq))
 		goto cancel;
 
-	if (!creq->io_streams[1].avail)
+	cache = &creq->io_streams[1];
+	if (!cache->avail)
+		goto cancel_put;
+
+	if (bvecq_buffer_init(&creq->load_cursor, GFP_KERNEL) < 0)
 		goto cancel_put;
 
-	bvecq_buffer_init(&creq->load_cursor, GFP_KERNEL);
-	bvecq_pos_set(&creq->dispatch_cursor, &creq->load_cursor);
-	bvecq_pos_set(&creq->collect_cursor, &creq->dispatch_cursor);
+	bvecq_pos_set(&cache->dispatch_cursor, &creq->load_cursor);
+	bvecq_pos_set(&creq->collect_cursor, &creq->load_cursor);
 
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &creq->flags);
 	trace_netfs_copy2cache(rreq, creq);
@@ -171,19 +173,43 @@ void netfs_pgpriv2_copy_to_cache(struct netfs_io_request *rreq, struct folio *fo
 	netfs_pgpriv2_copy_folio(creq, folio);
 }
 
+/*
+ * Issue all pending writes on the cache stream.
+ */
+static int netfs_pgpriv2_issue_stream(struct netfs_io_request *wreq,
+				      struct netfs_io_stream *stream)
+{
+	int ret;
+
+	atomic64_set_release(&stream->issued_to, wreq->start);
+
+	do {
+		struct netfs_io_subrequest *subreq;
+
+		subreq = netfs_alloc_write_subreq(wreq, stream);
+		if (!subreq)
+			return -ENOMEM;
+
+		ret = stream->issue_write(subreq);
+		if (ret < 0 && ret != -EIOCBQUEUED)
+			break;
+	} while (stream->buffered > 0);
+
+	return ret;
+}
+
 /*
  * [DEPRECATED] End writing to the cache, flushing out any outstanding writes.
  */
 void netfs_pgpriv2_end_copy_to_cache(struct netfs_io_request *rreq)
 {
 	struct netfs_io_request *creq = rreq->copy_to_cache;
+	struct netfs_io_stream *stream = &creq->io_streams[1];
 
 	if (IS_ERR_OR_NULL(creq))
 		return;
 
-	netfs_issue_write(creq, &creq->io_streams[1]);
-	smp_wmb(); /* Write lists before ALL_QUEUED. */
-	set_bit(NETFS_RREQ_ALL_QUEUED, &creq->flags);
+	netfs_pgpriv2_issue_stream(creq, stream);
 	trace_netfs_rreq(rreq, netfs_rreq_trace_end_copy_to_cache);
 	if (list_empty_careful(&creq->io_streams[1].subrequests))
 		netfs_wake_collector(creq);
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 6f2eb14aac72..b3bc924ffe8e 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -9,19 +9,55 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-static void netfs_reissue_read(struct netfs_io_request *rreq,
-			       struct netfs_io_subrequest *subreq)
+/*
+ * Prepare the I/O buffer on a buffered read subrequest for the filesystem to
+ * use as a bvec queue.
+ */
+int netfs_prepare_buffered_read_retry_buffer(struct netfs_io_subrequest *subreq,
+					     unsigned int max_segs)
 {
+	struct netfs_io_request *rreq = subreq->rreq;
+	size_t len;
+
+	bvecq_pos_set(&subreq->dispatch_pos, &rreq->retry_cursor);
 	bvecq_pos_set(&subreq->content, &subreq->dispatch_pos);
-	iov_iter_bvec_queue(&subreq->io_iter, ITER_DEST, subreq->content.bvecq,
-			    subreq->content.slot, subreq->content.offset, subreq->len);
-	iov_iter_advance(&subreq->io_iter, subreq->transferred);
+	len = bvecq_slice(&rreq->retry_cursor, subreq->len, max_segs,
+			  &subreq->nr_segs);
+	if (len < subreq->len) {
+		subreq->len = len;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+	}
+	rreq->retry_buffered -= subreq->len;
+	rreq->retry_start    += subreq->len;
+	return 0;
+}
 
-	subreq->error = 0;
+/*
+ * Reset the state of the subrequest and discard any buffering so that we can
+ * retry (where this may include sending it to the server instead of the
+ * cache).
+ */
+int netfs_reset_for_read_retry(struct netfs_io_subrequest *subreq)
+{
+	trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+
+	if (subreq->retry_count > 3) {
+		trace_netfs_sreq(subreq, netfs_sreq_trace_too_many_retries);
+		return subreq->error;
+	}
+
+	subreq->retry_count++;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+	__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+	__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-	netfs_stat(&netfs_n_rh_retry_read_subreq);
-	subreq->rreq->netfs_ops->issue_read(subreq);
+	bvecq_pos_unset(&subreq->content);
+	bvecq_pos_unset(&subreq->dispatch_pos);
+	subreq->error = 0;
+	subreq->transferred = 0;
+	netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+	netfs_stat(&netfs_n_wh_retry_write_subreq);
+	return 0;
 }
 
 /*
@@ -32,8 +68,8 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 {
 	struct netfs_io_subrequest *subreq;
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
-	struct bvecq_pos dispatch_cursor = {};
 	struct list_head *next;
+	int ret;
 
 	_enter("R=%x", rreq->debug_id);
 
@@ -43,47 +79,19 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 	if (rreq->netfs_ops->retry_request)
 		rreq->netfs_ops->retry_request(rreq, NULL);
 
-	/* If there's no renegotiation to do, just resend each retryable subreq
-	 * up to the first permanently failed one.
-	 */
-	if (!rreq->netfs_ops->prepare_read &&
-	    !rreq->cache_resources.ops) {
-		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
-			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
-				break;
-			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
-				__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
-				subreq->retry_count++;
-				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-				netfs_reissue_read(rreq, subreq);
-			}
-		}
-		return;
-	}
-
 	/* Okay, we need to renegotiate all the download requests and flip any
 	 * failed cache reads over to being download requests and negotiate
-	 * those also.  All fully successful subreqs have been removed from the
-	 * list and any spare data from those has been donated.
-	 *
-	 * What we do is decant the list and rebuild it one subreq at a time so
-	 * that we don't end up with donations jumping over a gap we're busy
-	 * populating with smaller subrequests.  In the event that the subreq
-	 * we just launched finishes before we insert the next subreq, it'll
-	 * fill in rreq->prev_donated instead.
-	 *
-	 * Note: Alternatively, we could split the tail subrequest right before
-	 * we reissue it and fix up the donations under lock.
+	 * those also.
 	 */
 	next = stream->subrequests.next;
 
 	do {
 		struct netfs_io_subrequest *from, *to, *tmp;
-		unsigned long long start, len;
-		size_t part;
-		bool boundary = false, subreq_superfluous = false;
+		unsigned long long start;
+		size_t len;
+		bool subreq_superfluous = false;
 
-		bvecq_pos_unset(&dispatch_cursor);
+		bvecq_pos_unset(&rreq->retry_cursor);
 
 		/* Go through the subreqs and find the next span of contiguous
 		 * buffer that we then rejig (cifs, for example, needs the
@@ -98,8 +106,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		       rreq->debug_id, from->debug_index,
 		       from->start, from->transferred, from->len);
 
-		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
-		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags)) {
+		if (!test_bit(NETFS_SREQ_NEED_RETRY, &from->flags)) {
 			subreq = from;
 			goto abandon;
 		}
@@ -107,68 +114,53 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		list_for_each_continue(next, &stream->subrequests) {
 			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
 			if (subreq->start + subreq->transferred != start + len ||
-			    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||
 			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
 				break;
 			to = subreq;
 			len += to->len;
 		}
 
-		_debug(" - range: %llx-%llx %llx", start, start + len - 1, len);
+		_debug(" - range: %llx-%llx %zx", start, start + len - 1, len);
 
 		/* Determine the set of buffers we're going to use.  Each
-		 * subreq gets a subset of a single overall contiguous buffer.
+		 * subreq takes a subset of a single overall contiguous buffer.
 		 */
-		bvecq_pos_transfer(&dispatch_cursor, &from->dispatch_pos);
-		bvecq_pos_advance(&dispatch_cursor, from->transferred);
+		bvecq_pos_transfer(&rreq->retry_cursor, &from->dispatch_pos);
+		bvecq_pos_advance(&rreq->retry_cursor, from->transferred);
+		rreq->retry_start = start;
+		rreq->retry_buffered = len;
 
 		/* Work through the sublist. */
 		subreq = from;
 		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
-			if (!len) {
+			if (rreq->retry_buffered == 0) {
 				subreq_superfluous = true;
 				break;
 			}
 			subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
-			subreq->start	= start - subreq->transferred;
-			subreq->len	= len   + subreq->transferred;
-			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-			__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
-			subreq->retry_count++;
+			subreq->start	= rreq->retry_start;
+			subreq->len	= rreq->retry_buffered;
 
-			bvecq_pos_unset(&subreq->dispatch_pos);
-			bvecq_pos_unset(&subreq->content);
-
-			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
-
-			/* Renegotiate max_len (rsize) */
-			stream->sreq_max_len = subreq->len;
-			stream->sreq_max_segs = INT_MAX;
-			if (rreq->netfs_ops->prepare_read &&
-			    rreq->netfs_ops->prepare_read(subreq) < 0) {
-				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
+			ret = netfs_reset_for_read_retry(subreq);
+			if (ret < 0) {
 				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+				rreq->error = ret;
 				goto abandon;
 			}
 
-			bvecq_pos_set(&subreq->dispatch_pos, &dispatch_cursor);
-			part = bvecq_slice(&dispatch_cursor,
-					   umin(len, stream->sreq_max_len),
-					   stream->sreq_max_segs,
-					   &subreq->nr_segs);
-			subreq->len = subreq->transferred + part;
-
-			len -= part;
-			start += part;
-			if (!len) {
-				if (boundary)
-					__set_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
-			} else {
-				__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
+			netfs_stat(&netfs_n_rh_download);
+			ret = rreq->netfs_ops->issue_read(subreq);
+			if (ret < 0 && ret != -EIOCBQUEUED) {
+				if (ret == -ENOMEM)
+					goto abandon;
+				subreq->error = ret;
+				if (ret != -EAGAIN) {
+					__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+					goto abandon_after;
+				}
+				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+				netfs_read_subreq_terminated(subreq);
 			}
-
-			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-			netfs_reissue_read(rreq, subreq);
 			if (subreq == to) {
 				subreq_superfluous = false;
 				break;
@@ -178,7 +170,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		/* If we managed to use fewer subreqs, we can discard the
 		 * excess; if we used the same number, then we're done.
 		 */
-		if (!len) {
+		if (rreq->retry_buffered == 0) {
 			if (!subreq_superfluous)
 				continue;
 			list_for_each_entry_safe_from(subreq, tmp,
@@ -194,7 +186,8 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		}
 
 		/* We ran out of subrequests, so we need to allocate some more
-		 * and insert them after.
+		 * and insert them after.  They must start with being marked
+		 * for retry to switch to the retry cursor.
 		 */
 		do {
 			subreq = netfs_alloc_subrequest(rreq);
@@ -203,8 +196,8 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 				goto abandon_after;
 			}
 			subreq->source		= NETFS_DOWNLOAD_FROM_SERVER;
-			subreq->start		= start;
-			subreq->len		= len;
+			subreq->start		= rreq->retry_start;
+			subreq->len		= rreq->retry_buffered;
 			subreq->stream_nr	= stream->stream_nr;
 			subreq->retry_count	= 1;
 
@@ -216,37 +209,26 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			to = list_next_entry(to, rreq_link);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
-			stream->sreq_max_len	= umin(len, rreq->rsize);
-			stream->sreq_max_segs	= INT_MAX;
-
 			netfs_stat(&netfs_n_rh_download);
-			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
-				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
-				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
-				goto abandon;
+			ret = rreq->netfs_ops->issue_read(subreq);
+			if (ret < 0 && ret != -EIOCBQUEUED) {
+				if (ret == -ENOMEM)
+					goto abandon;
+				subreq->error = ret;
+				if (ret != -EAGAIN) {
+					__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+					goto abandon_after;
+				}
+				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+				netfs_read_subreq_terminated(subreq);
 			}
 
-			bvecq_pos_set(&subreq->dispatch_pos, &dispatch_cursor);
-			part = bvecq_slice(&dispatch_cursor,
-					   umin(len, stream->sreq_max_len),
-					   stream->sreq_max_segs,
-					   &subreq->nr_segs);
-			subreq->len = subreq->transferred + part;
-
-			len -= part;
-			start += part;
-			if (!len && boundary) {
-				__set_bit(NETFS_SREQ_BOUNDARY, &to->flags);
-				boundary = false;
-			}
-
-			netfs_reissue_read(rreq, subreq);
-		} while (len);
+		} while (rreq->retry_buffered > 0);
 
 	} while (!list_is_head(next, &stream->subrequests));
 
 out:
-	bvecq_pos_unset(&dispatch_cursor);
+	bvecq_pos_unset(&rreq->retry_cursor);
 	return;
 
 	/* If we hit an error, fail all remaining incomplete subrequests */
@@ -295,8 +277,6 @@ void netfs_unlock_abandoned_read_pages(struct netfs_io_request *rreq)
 	struct bvecq *p;
 
 	for (p = rreq->collect_cursor.bvecq; p; p = p->next) {
-		if (!p->free)
-			continue;
 		for (int slot = 0; slot < p->nr_slots; slot++) {
 			if (!p->bv[slot].bv_page)
 				continue;
@@ -310,6 +290,7 @@ void netfs_unlock_abandoned_read_pages(struct netfs_io_request *rreq)
 			}
 			trace_netfs_folio(folio, netfs_folio_trace_abandon);
 			folio_unlock(folio);
+			p->bv[slot].bv_page = NULL;
 		}
 	}
 }
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index b386cae77ece..52b9e12a820a 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -16,6 +16,19 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+int netfs_prepare_read_single_buffer(struct netfs_io_subrequest *subreq,
+				     unsigned int max_segs)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
+
+	bvecq_pos_set(&subreq->dispatch_pos, &rreq->load_cursor);
+	bvecq_pos_set(&subreq->content, &subreq->dispatch_pos);
+
+	stream->issue_from += subreq->len;
+	return 0;
+}
+
 /**
  * netfs_single_mark_inode_dirty - Mark a single, monolithic object inode dirty
  * @inode: The inode to mark
@@ -58,24 +71,12 @@ static int netfs_single_begin_cache_read(struct netfs_io_request *rreq, struct n
 	return fscache_begin_read_operation(&rreq->cache_resources, netfs_i_cookie(ctx));
 }
 
-static void netfs_single_read_cache(struct netfs_io_request *rreq,
-				    struct netfs_io_subrequest *subreq)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-
-	_enter("R=%08x[%x]", rreq->debug_id, subreq->debug_index);
-	netfs_stat(&netfs_n_rh_read);
-	cres->ops->read(cres, subreq->start, &subreq->io_iter, NETFS_READ_HOLE_FAIL,
-			netfs_cache_read_terminated, subreq);
-}
-
 /*
  * Perform a read to a buffer from the cache or the server.  Only a single
  * subreq is permitted as the object must be fetched in a single transaction.
  */
 static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 {
-	struct netfs_io_stream *stream = &rreq->io_streams[0];
 	struct fscache_occupancy occ = {
 		.query_from	= 0,
 		.query_to	= rreq->len,
@@ -85,76 +86,79 @@ static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 		.cached_to[1]	= ULLONG_MAX,
 	};
 	struct netfs_io_subrequest *subreq;
-	int ret = 0;
+	int ret;
+
+	ret = netfs_read_query_cache(rreq, &occ);
+	if (ret < 0)
+		return ret;
 
 	subreq = netfs_alloc_subrequest(rreq);
 	if (!subreq)
 		return -ENOMEM;
 
-	subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
 	subreq->start	= 0;
 	subreq->len	= rreq->len;
 
-	bvecq_pos_set(&subreq->dispatch_pos, &rreq->dispatch_cursor);
-	bvecq_pos_set(&subreq->content, &rreq->dispatch_cursor);
-
-	iov_iter_bvec_queue(&subreq->io_iter, ITER_DEST, subreq->content.bvecq,
-			    subreq->content.slot, subreq->content.offset, subreq->len);
+	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 
 	/* Try to use the cache if the cache content matches the size of the
 	 * remote file.
 	 */
-	netfs_read_query_cache(rreq, &occ);
 	if (occ.cached_from[0] == 0 &&
-	    occ.cached_to[0] == rreq->len)
-		subreq->source = NETFS_READ_FROM_CACHE;
+	    occ.cached_to[0] == rreq->len) {
+		struct netfs_cache_resources *cres = &rreq->cache_resources;
 
-	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+		subreq->source = NETFS_READ_FROM_CACHE;
+		netfs_stat(&netfs_n_rh_read);
+		ret = cres->ops->issue_read(subreq);
+		if (ret == -EIOCBQUEUED)
+			ret = netfs_wait_for_in_progress_subreq(rreq, subreq);
+		if (ret == -ENOMEM)
+			goto cancel;
+		if (ret == 0)
+			goto success;
+
+		/* Didn't manage to retrieve from the cache, so toss it to the
+		 * server instead.
+		 */
+		if (netfs_reset_for_read_retry(subreq) < 0)
+			goto cancel;
+	}
 
-	spin_lock(&rreq->lock);
-	list_add_tail(&subreq->rreq_link, &stream->subrequests);
-	trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-	/* Store list pointers before active flag */
-	smp_store_release(&stream->active, true);
-	spin_unlock(&rreq->lock);
+	__set_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
 
-	switch (subreq->source) {
-	case NETFS_DOWNLOAD_FROM_SERVER:
+	/* Try to send it to the cache. */
+	for (;;) {
+		subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
 		netfs_stat(&netfs_n_rh_download);
-		if (rreq->netfs_ops->prepare_read) {
-			ret = rreq->netfs_ops->prepare_read(subreq);
-			if (ret < 0)
-				goto cancel;
-		}
-
-		rreq->netfs_ops->issue_read(subreq);
-		rreq->submitted += subreq->len;
-		break;
-	case NETFS_READ_FROM_CACHE:
-		if (rreq->cache_resources.ops->prepare_read) {
-			ret = rreq->cache_resources.ops->prepare_read(subreq);
-			if (ret < 0)
-				goto cancel;
-		}
-
-		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-		netfs_single_read_cache(rreq, subreq);
-		rreq->submitted += subreq->len;
-		ret = 0;
-		break;
-	default:
-		pr_warn("Unexpected single-read source %u\n", subreq->source);
-		WARN_ON_ONCE(true);
-		ret = -EIO;
-		break;
+		ret = rreq->netfs_ops->issue_read(subreq);
+		if (ret == -EIOCBQUEUED)
+			ret = netfs_wait_for_in_progress_subreq(rreq, subreq);
+		if (ret == 0)
+			goto success;
+		if (ret == -ENOMEM)
+			goto cancel;
+		if (ret != -EAGAIN)
+			goto failed;
+		if (netfs_reset_for_read_retry(subreq) < 0)
+			goto cancel;
 	}
 
-	smp_wmb(); /* Write lists before ALL_QUEUED. */
-	set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
-	return ret;
+success:
+	rreq->transferred = subreq->transferred;
+	list_del_init(&subreq->rreq_link);
+	netfs_put_subrequest(subreq, netfs_sreq_trace_put_consumed);
+	return 0;
 cancel:
+	rreq->error = ret;
+	list_del_init(&subreq->rreq_link);
 	netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
 	return ret;
+failed:
+	rreq->error = ret;
+	list_del_init(&subreq->rreq_link);
+	netfs_put_subrequest(subreq, netfs_sreq_trace_put_failed);
+	return ret;
 }
 
 /**
@@ -185,7 +189,7 @@ ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_ite
 	if (IS_ERR(rreq))
 		return PTR_ERR(rreq);
 
-	ret = netfs_extract_iter(iter, rreq->len, INT_MAX, 0, &rreq->dispatch_cursor.bvecq, 0);
+	ret = netfs_extract_iter(iter, rreq->len, INT_MAX, 0, &rreq->load_cursor.bvecq, 0);
 	if (ret < 0)
 		goto cleanup_free;
 
@@ -196,9 +200,29 @@ ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_ite
 	netfs_stat(&netfs_n_rh_read_single);
 	trace_netfs_read(rreq, 0, rreq->len, netfs_read_trace_read_single);
 
-	netfs_single_dispatch_read(rreq);
+	ret = netfs_single_dispatch_read(rreq);
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_complete);
+	if (ret == 0) {
+		task_io_account_read(rreq->transferred);
+
+		if (test_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags) &&
+		    fscache_resources_valid(&rreq->cache_resources)) {
+			trace_netfs_rreq(rreq, netfs_rreq_trace_dirty);
+			netfs_single_mark_inode_dirty(rreq->inode);
+		}
+		ret = rreq->transferred;
+	}
+
+	if (rreq->netfs_ops->done)
+		rreq->netfs_ops->done(rreq);
+
+	netfs_wake_rreq_flag(rreq, NETFS_RREQ_IN_PROGRESS, netfs_rreq_trace_wake_ip);
+	/* As we cleared NETFS_RREQ_IN_PROGRESS, we acquired its ref. */
+	netfs_put_request(rreq, netfs_rreq_trace_put_work_ip);
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 
-	ret = netfs_wait_for_read(rreq);
 	netfs_put_request(rreq, netfs_rreq_trace_put_return);
 	return ret;
 
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index fb8daf50c86d..bfca6d48361f 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -28,8 +28,8 @@ static void netfs_dump_request(const struct netfs_io_request *rreq)
 	       rreq->origin, rreq->error);
 	pr_err("  st=%llx tsl=%zx/%llx/%llx\n",
 	       rreq->start, rreq->transferred, rreq->submitted, rreq->len);
-	pr_err("  cci=%llx/%llx/%llx\n",
-	       rreq->cleaned_to, rreq->collected_to, atomic64_read(&rreq->issued_to));
+	pr_err("  cci=%llx/%llx\n",
+	       rreq->cleaned_to, rreq->collected_to);
 	pr_err("  iw=%pSR\n", rreq->netfs_ops->issue_write);
 	for (int i = 0; i < NR_IO_STREAMS; i++) {
 		const struct netfs_io_subrequest *sreq;
@@ -38,8 +38,9 @@ static void netfs_dump_request(const struct netfs_io_request *rreq)
 		pr_err("  str[%x] s=%x e=%d acnf=%u,%u,%u,%u\n",
 		       s->stream_nr, s->source, s->error,
 		       s->avail, s->active, s->need_retry, s->failed);
-		pr_err("  str[%x] ct=%llx t=%zx\n",
-		       s->stream_nr, s->collected_to, s->transferred);
+		pr_err("  str[%x] it=%llx ct=%llx t=%zx\n",
+		       s->stream_nr, atomic64_read(&s->issued_to),
+		       s->collected_to, s->transferred);
 		list_for_each_entry(sreq, &s->subrequests, rreq_link) {
 			pr_err("  sreq[%x:%x] sc=%u s=%llx t=%zx/%zx r=%d f=%lx\n",
 			       sreq->stream_nr, sreq->debug_index, sreq->source,
@@ -56,7 +57,7 @@ static void netfs_dump_request(const struct netfs_io_request *rreq)
  */
 int netfs_folio_written_back(struct folio *folio)
 {
-	enum netfs_folio_trace why = netfs_folio_trace_clear;
+	enum netfs_folio_trace why = netfs_folio_trace_endwb;
 	struct netfs_inode *ictx = netfs_inode(folio->mapping->host);
 	struct netfs_folio *finfo;
 	struct netfs_group *group = NULL;
@@ -76,13 +77,13 @@ int netfs_folio_written_back(struct folio *folio)
 		group = finfo->netfs_group;
 		gcount++;
 		kfree(finfo);
-		why = netfs_folio_trace_clear_s;
+		why = netfs_folio_trace_endwb_s;
 		goto end_wb;
 	}
 
 	if ((group = netfs_folio_group(folio))) {
 		if (group == NETFS_FOLIO_COPY_TO_CACHE) {
-			why = netfs_folio_trace_clear_cc;
+			why = netfs_folio_trace_endwb_cc;
 			folio_detach_private(folio);
 			goto end_wb;
 		}
@@ -95,7 +96,7 @@ int netfs_folio_written_back(struct folio *folio)
 		if (!folio_test_dirty(folio)) {
 			folio_detach_private(folio);
 			gcount++;
-			why = netfs_folio_trace_clear_g;
+			why = netfs_folio_trace_endwb_g;
 		}
 	}
 
@@ -222,9 +223,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 	trace_netfs_rreq(wreq, netfs_rreq_trace_collect);
 
 reassess_streams:
-	/* Order reading the issued_to point before reading the queue it refers to. */
-	issued_to = atomic64_read_acquire(&wreq->issued_to);
-	smp_rmb();
+	issued_to = ULLONG_MAX;
 	collected_to = ULLONG_MAX;
 	if (wreq->origin == NETFS_WRITEBACK ||
 	    wreq->origin == NETFS_WRITETHROUGH ||
@@ -239,14 +238,26 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 	 * to the tail whilst we're doing this.
 	 */
 	for (s = 0; s < NR_IO_STREAMS; s++) {
+		unsigned long long s_issued_to;
+
 		stream = &wreq->io_streams[s];
-		/* Read active flag before list pointers */
+		/* Read active flag before issued_to */
 		if (!smp_load_acquire(&stream->active))
 			continue;
 
-		front = list_first_entry_or_null(&stream->subrequests,
-						 struct netfs_io_subrequest, rreq_link);
-		while (front) {
+		for (;;) {
+			/* Order reading the issued_to point before reading the
+			 * queue it refers to.
+			 */
+			s_issued_to = atomic64_read_acquire(&stream->issued_to);
+			if (s_issued_to < issued_to)
+				issued_to = s_issued_to;
+
+			front = list_first_entry_or_null(&stream->subrequests,
+							 struct netfs_io_subrequest, rreq_link);
+			if (!front)
+				break;
+
 			trace_netfs_collect_sreq(wreq, front);
 			//_debug("sreq [%x] %llx %zx/%zx",
 			//       front->debug_index, front->start, front->transferred, front->len);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index d4c4bee4299e..ec84d2bcabeb 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -36,6 +36,39 @@
 #include <linux/pagemap.h>
 #include "internal.h"
 
+#define NOTE_UPLOAD_AVAIL	0x001	/* Upload is available */
+#define NOTE_CACHE_AVAIL	0x002	/* Local cache is available */
+#define NOTE_CACHE_COPY		0x004	/* Copy folio to cache */
+#define NOTE_UPLOAD		0x008	/* Upload folio to server */
+#define NOTE_UPLOAD_STARTED	0x010	/* Upload started */
+#define NOTE_STREAMW		0x020	/* Folio is from a streaming write */
+#define NOTE_DISCONTIG_BEFORE	0x040	/* Folio discontiguous with the previous folio */
+#define NOTE_DISCONTIG_AFTER	0x080	/* Folio discontiguous with the next folio */
+#define NOTE_TO_EOF		0x100	/* Data in folio ends at EOF */
+#define NOTE_FLUSH_ANYWAY	0x200	/* Flush data, even if not hit estimated limit */
+
+#define NOTES__KEEP_MASK (NOTE_UPLOAD_AVAIL | NOTE_CACHE_AVAIL | NOTE_UPLOAD_STARTED)
+
+struct netfs_wb_params {
+	unsigned long long	last_end;	/* End file pos of previous folio */
+	unsigned long long	folio_start;	/* File pos of folio */
+	unsigned int		folio_len;	/* Length of folio */
+	unsigned int		dirty_offset;	/* Offset of dirty region in folio */
+	unsigned int		dirty_len;	/* Length of dirty region in folio */
+	unsigned int		notes;		/* Notes on applicability */
+	struct bvecq_pos	dispatch_cursor; /* Folio queue anchor for issue_at */
+	struct netfs_write_estimate estimates[2];
+};
+
+struct netfs_writethrough {
+	struct netfs_wb_params	params;
+	struct netfs_io_request	*wreq;
+	struct folio		*in_progress;
+};
+
+static int netfs_prepare_write_single_buffer(struct netfs_io_subrequest *subreq,
+					     unsigned int max_segs);
+
 /*
  * Kill all dirty folios in the event of an unrecoverable error, starting with
  * a locked folio we've already obtained from writeback_iter().
@@ -115,65 +148,48 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 
 	wreq->io_streams[0].stream_nr		= 0;
 	wreq->io_streams[0].source		= NETFS_UPLOAD_TO_SERVER;
-	wreq->io_streams[0].prepare_write	= ictx->ops->prepare_write;
+	wreq->io_streams[0].applicable		= NOTE_UPLOAD;
+	wreq->io_streams[0].estimate_write	= ictx->ops->estimate_write;
 	wreq->io_streams[0].issue_write		= ictx->ops->issue_write;
 	wreq->io_streams[0].collected_to	= start;
 	wreq->io_streams[0].transferred		= 0;
 
 	wreq->io_streams[1].stream_nr		= 1;
 	wreq->io_streams[1].source		= NETFS_WRITE_TO_CACHE;
+	wreq->io_streams[1].applicable		= NOTE_CACHE_COPY;
 	wreq->io_streams[1].collected_to	= start;
 	wreq->io_streams[1].transferred		= 0;
 	if (fscache_resources_valid(&wreq->cache_resources)) {
 		wreq->io_streams[1].avail	= true;
 		wreq->io_streams[1].active	= true;
-		wreq->io_streams[1].prepare_write = wreq->cache_resources.ops->prepare_write_subreq;
+		wreq->io_streams[1].estimate_write = wreq->cache_resources.ops->estimate_write;
 		wreq->io_streams[1].issue_write = wreq->cache_resources.ops->issue_write;
 	}
 
 	return wreq;
 }
 
-/**
- * netfs_prepare_write_failed - Note write preparation failed
- * @subreq: The subrequest to mark
- *
- * Mark a subrequest to note that preparation for write failed.
- */
-void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq)
-{
-	__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
-	trace_netfs_sreq(subreq, netfs_sreq_trace_prep_failed);
-}
-EXPORT_SYMBOL(netfs_prepare_write_failed);
-
 /*
- * Prepare a write subrequest.  We need to allocate a new subrequest
- * if we don't have one.
+ * Allocate and prepare a write subrequest.
  */
-void netfs_prepare_write(struct netfs_io_request *wreq,
-			 struct netfs_io_stream *stream,
-			 loff_t start)
+struct netfs_io_subrequest *netfs_alloc_write_subreq(struct netfs_io_request *wreq,
+						     struct netfs_io_stream *stream)
 {
 	struct netfs_io_subrequest *subreq;
 
 	subreq = netfs_alloc_subrequest(wreq);
 	subreq->source		= stream->source;
-	subreq->start		= start;
+	subreq->start		= stream->issue_from;
+	subreq->len		= stream->buffered;
 	subreq->stream_nr	= stream->stream_nr;
 
-	bvecq_pos_set(&subreq->dispatch_pos, &wreq->dispatch_cursor);
-
 	_enter("R=%x[%x]", wreq->debug_id, subreq->debug_index);
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 
-	stream->sreq_max_len	= UINT_MAX;
-	stream->sreq_max_segs	= INT_MAX;
 	switch (stream->source) {
 	case NETFS_UPLOAD_TO_SERVER:
 		netfs_stat(&netfs_n_wh_upload);
-		stream->sreq_max_len = wreq->wsize;
 		break;
 	case NETFS_WRITE_TO_CACHE:
 		netfs_stat(&netfs_n_wh_write);
@@ -183,9 +199,6 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 		break;
 	}
 
-	if (stream->prepare_write)
-		stream->prepare_write(subreq);
-
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 
 	/* We add to the end of the list whilst the collector may be walking
@@ -194,84 +207,46 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 	 */
 	spin_lock(&wreq->lock);
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
-	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-		if (!stream->active) {
-			stream->collected_to = subreq->start;
-			/* Write list pointers before active flag */
-			smp_store_release(&stream->active, true);
-		}
-	}
+	if (list_is_first(&subreq->rreq_link, &stream->subrequests) &&
+	    stream->collected_to == 0)
+		stream->collected_to = subreq->start;
 
 	spin_unlock(&wreq->lock);
-
-	stream->construct = subreq;
+	return subreq;
 }
 
 /*
- * Set the I/O iterator for the filesystem/cache to use and dispatch the I/O
- * operation.  The operation may be asynchronous and should call
- * netfs_write_subrequest_terminated() when complete.
+ * Prepare the buffer for a buffered write.
  */
-static void netfs_do_issue_write(struct netfs_io_stream *stream,
-				 struct netfs_io_subrequest *subreq)
+static int netfs_prepare_buffered_write_buffer(struct netfs_io_subrequest *subreq,
+					       unsigned int max_segs)
 {
 	struct netfs_io_request *wreq = subreq->rreq;
+	struct netfs_io_stream *stream = &wreq->io_streams[subreq->stream_nr];
+	ssize_t len;
 
-	_enter("R=%x[%x],%zx", wreq->debug_id, subreq->debug_index, subreq->len);
-
-	if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
-		return netfs_write_subrequest_terminated(subreq, subreq->error);
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	stream->issue_write(subreq);
-}
-
-void netfs_reissue_write(struct netfs_io_stream *stream,
-			 struct netfs_io_subrequest *subreq)
-{
-	// TODO: Use encrypted buffer
-	bvecq_pos_set(&subreq->content, &subreq->dispatch_pos);
-	iov_iter_bvec_queue(&subreq->io_iter, ITER_SOURCE,
-			    subreq->content.bvecq, subreq->content.slot,
-			    subreq->content.offset,
-			    subreq->len);
-	iov_iter_advance(&subreq->io_iter, subreq->transferred);
-
-	subreq->retry_count++;
-	subreq->error = 0;
-	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
-	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-	netfs_stat(&netfs_n_wh_retry_write_subreq);
-	netfs_do_issue_write(stream, subreq);
-}
-
-void netfs_issue_write(struct netfs_io_request *wreq,
-		       struct netfs_io_stream *stream)
-{
-	struct netfs_io_subrequest *subreq = stream->construct;
+	_enter("%zx,{,%u,%u},%u",
+	       subreq->len, stream->dispatch_cursor.slot, stream->dispatch_cursor.offset, max_segs);
 
-	if (!subreq)
-		return;
+	bvecq_pos_set(&subreq->dispatch_pos, &stream->dispatch_cursor);
 
 	/* If we have a write to the cache, we need to round out the first and
 	 * last entries (only those as the data will be on virtually contiguous
 	 * folios) to cache DIO boundaries.
 	 */
 	if (subreq->source == NETFS_WRITE_TO_CACHE) {
-		struct bvecq_pos tmp_pos;
 		struct bio_vec *bv;
 		struct bvecq *bq;
 		size_t dio_size = wreq->cache_resources.dio_size;
-		size_t disp, len;
-		int ret;
+		size_t disp, dlen;
 
-		bvecq_pos_set(&tmp_pos, &subreq->dispatch_pos);
-		ret = bvecq_extract(&tmp_pos, subreq->len, INT_MAX, &subreq->content.bvecq);
-		bvecq_pos_unset(&tmp_pos);
-		if (ret < 0) {
-			netfs_write_subrequest_terminated(subreq, -ENOMEM);
-			return;
-		}
+		len = bvecq_extract(&stream->dispatch_cursor, subreq->len, max_segs,
+				    &subreq->content.bvecq);
+		if (len < 0)
+			return -ENOMEM;
+
+		_debug("extract %zx/%zx", len, subreq->len);
+		subreq->len = len;
 
 		/* Round the first entry down. */
 		bq = subreq->content.bvecq;
@@ -289,96 +264,276 @@ void netfs_issue_write(struct netfs_io_request *wreq,
 		while (bq->next)
 			bq = bq->next;
 		bv = &bq->bv[bq->nr_slots - 1];
-		len = round_up(bv->bv_len, dio_size);
-		if (len > bv->bv_len) {
-			subreq->len += len - bv->bv_len;
-			bv->bv_len = len;
+		dlen = round_up(bv->bv_len, dio_size);
+		if (dlen > bv->bv_len) {
+			subreq->len += dlen - bv->bv_len;
+			bv->bv_len = dlen;
 		}
 	} else {
-		bvecq_pos_set(&subreq->content, &subreq->dispatch_pos);
+		bvecq_pos_set(&subreq->content, &stream->dispatch_cursor);
+		len = bvecq_slice(&stream->dispatch_cursor, subreq->len, max_segs,
+				  &subreq->nr_segs);
+
+		if (len < subreq->len) {
+			subreq->len = len;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+		}
 	}
 
-	iov_iter_bvec_queue(&subreq->io_iter, ITER_SOURCE,
-			    subreq->content.bvecq, subreq->content.slot,
-			    subreq->content.offset,
-			    subreq->len);
+	stream->issue_from += len;
+	stream->buffered   -= len;
+	if (stream->buffered == 0) {
+		stream->buffering = false;
+		bvecq_pos_unset(&stream->dispatch_cursor);
+	}
+	/* Order loading the queue before updating the issue_to point */
+	atomic64_set_release(&stream->issued_to, stream->issue_from);
+	return 0;
+}
+
+/**
+ * netfs_prepare_write_buffer - Get the buffer for a subrequest
+ * @subreq: The subrequest to get the buffer for
+ * @max_segs: Maximum number of segments in buffer (or INT_MAX)
+ *
+ * Extract a slice of buffer from the stream and attach it to the subrequest as
+ * a bio_vec queue.  The maximum amount of data attached is set by
+ * @subreq->len, but this may be shortened if @max_segs would be exceeded.
+ */
+int netfs_prepare_write_buffer(struct netfs_io_subrequest *subreq,
+			       unsigned int max_segs)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+
+	switch (rreq->origin) {
+	case NETFS_WRITEBACK:
+	case NETFS_WRITETHROUGH:
+		if (test_bit(NETFS_RREQ_RETRYING, &rreq->flags))
+			return netfs_prepare_write_retry_buffer(subreq, max_segs);
+		return netfs_prepare_buffered_write_buffer(subreq, max_segs);
+
+	case NETFS_UNBUFFERED_WRITE:
+	case NETFS_DIO_WRITE:
+		return netfs_prepare_unbuffered_write_buffer(subreq, max_segs);
 
-	stream->construct = NULL;
-	netfs_do_issue_write(stream, subreq);
+	case NETFS_WRITEBACK_SINGLE:
+		return netfs_prepare_write_single_buffer(subreq, max_segs);
+
+	case NETFS_PGPRIV2_COPY_TO_CACHE:
+		return netfs_prepare_pgpriv2_write_buffer(subreq, max_segs);
+
+	default:
+		WARN_ON_ONCE(1);
+		return -EIO;
+	}
 }
+EXPORT_SYMBOL(netfs_prepare_write_buffer);
 
 /*
- * Add data to the write subrequest, dispatching each as we fill it up or if it
- * is discontiguous with the previous.  We only fill one part at a time so that
- * we can avoid overrunning the credits obtained (cifs) and try to parallelise
- * content-crypto preparation with network writes.
+ * Issue writes for a stream.
  */
-size_t netfs_advance_write(struct netfs_io_request *wreq,
-			   struct netfs_io_stream *stream,
-			   loff_t start, size_t len, bool to_eof)
+static int netfs_issue_writes(struct netfs_io_request *wreq,
+			      struct netfs_io_stream *stream,
+			      struct netfs_wb_params *params)
 {
-	struct netfs_io_subrequest *subreq = stream->construct;
-	size_t part;
+	struct netfs_write_estimate *estimate = &params->estimates[stream->stream_nr];
+
+	for (;;) {
+		struct netfs_io_subrequest *subreq;
+		int ret;
+
+		subreq = netfs_alloc_write_subreq(wreq, stream);
+		if (!subreq)
+			return -ENOMEM;
 
-	if (!stream->avail) {
-		_leave("no write");
-		return len;
+		ret = stream->issue_write(subreq);
+		if (ret < 0 && ret != -EIOCBQUEUED)
+			return ret;
+
+		if (stream->buffered == 0) {
+			if (stream->stream_nr == 0)
+				params->notes &= ~NOTE_UPLOAD_STARTED;
+			return 0;
+		}
+
+		if (!(params->notes & NOTE_FLUSH_ANYWAY)) {
+			estimate->issue_at = ULLONG_MAX;
+			estimate->max_segs = INT_MAX;
+			stream->estimate_write(wreq, stream, estimate);
+			if (stream->issue_from + stream->buffered < estimate->issue_at &&
+			    estimate->max_segs > 0)
+				return 0;
+		}
+	}
+}
+
+/*
+ * Issue pending writes on a stream.
+ */
+static int netfs_issue_stream(struct netfs_io_request *wreq,
+			      struct netfs_wb_params *params, int s)
+{
+	struct netfs_write_estimate *estimate = &params->estimates[s];
+	struct netfs_io_stream *stream = &wreq->io_streams[s];
+	unsigned long long dirty_start;
+	bool discontig_before = params->notes & NOTE_DISCONTIG_BEFORE;
+	int ret;
+
+	_enter("%x", params->notes);
+
+	/* If the current folio doesn't contribute to this stream, see if we
+	 * need to flush it.
+	 */
+	if (!(params->notes & stream->applicable)) {
+		if (!stream->buffering) {
+			atomic64_set_release(&stream->issued_to,
+					     params->folio_start + params->folio_len);
+			return 0;
+		}
+		discontig_before = true;
+	}
+
+	/* Issue writes if we meet a discontiguity before the current folio.
+	 * Even if the filesystem can do sparse/vectored writes, we still
+	 * generate a subreq per contiguous region rather than generating
+	 * separate extent lists.
+	 */
+	if (stream->buffering && discontig_before) {
+		params->notes |= NOTE_FLUSH_ANYWAY;
+		ret = netfs_issue_writes(wreq, stream, params);
+		if (ret < 0)
+			return ret;
+		stream->buffering = false;
+		params->notes &= ~NOTE_FLUSH_ANYWAY;
+	}
+
+	if (!(params->notes & stream->applicable)) {
+		atomic64_set_release(&stream->issued_to,
+				     params->folio_start + params->folio_len);
+		return 0;
+	}
+
+	/* If we're not currently buffering on this stream, we need to get an
+	 * estimate of when we need to issue a write.  It might be within the
+	 * starting folio.
+	 */
+	dirty_start = params->folio_start + params->dirty_offset;
+	if (!stream->buffering) {
+		stream->buffering = true;
+		stream->issue_from = dirty_start;
+		bvecq_pos_set(&stream->dispatch_cursor, &params->dispatch_cursor);
+		estimate->issue_at = ULLONG_MAX;
+		estimate->max_segs = INT_MAX;
+		stream->estimate_write(wreq, stream, estimate);
+	}
+
+	stream->buffered += params->dirty_len;
+	estimate->max_segs--;
+
+	/* Poke the filesystem to issue writes when we hit the limit it set or
+	 * if the data ends before the end of the page.
+	 */
+	if (params->notes & NOTE_DISCONTIG_AFTER)
+		params->notes |= NOTE_FLUSH_ANYWAY;
+	_debug("[%u] %llx + %zx >= %llx, %u %x",
+	       s, stream->issue_from, stream->buffered, estimate->issue_at,
+	       estimate->max_segs, params->notes);
+	if (stream->issue_from + stream->buffered >= estimate->issue_at ||
+	    estimate->max_segs <= 0 ||
+	    (params->notes & NOTE_FLUSH_ANYWAY)) {
+		ret = netfs_issue_writes(wreq, stream, params);
+		if (ret < 0)
+			return ret;
 	}
 
-	_enter("R=%x[%x]", wreq->debug_id, subreq ? subreq->debug_index : 0);
+	return 0;
+}
+
+/*
+ * See which streams need writes issuing and issue them.
+ */
+static int netfs_issue_streams(struct netfs_io_request *wreq,
+			       struct netfs_wb_params *params)
+{
+	int ret = 0, ret2;
+
+	_enter("%x", params->notes);
 
-	if (subreq && start != subreq->start + subreq->len) {
-		netfs_issue_write(wreq, stream);
-		subreq = NULL;
+	for (int s = 0; s < NR_IO_STREAMS; s++) {
+		ret2 = netfs_issue_stream(wreq, params, s);
+		if (ret2 < 0)
+			ret = ret2;
 	}
+	return ret;
+}
 
-	if (!stream->construct)
-		netfs_prepare_write(wreq, stream, start);
-	subreq = stream->construct;
+/*
+ * End the issuing of writes, let the collector know we're done.
+ */
+static void netfs_end_issue_write(struct netfs_io_request *wreq,
+				  struct netfs_wb_params *params)
+{
+	bool needs_poke = true;
 
-	part = umin(stream->sreq_max_len - subreq->len, len);
-	_debug("part %zx/%zx %zx/%zx", subreq->len, stream->sreq_max_len, part, len);
-	subreq->len += part;
-	subreq->nr_segs++;
+	params->notes |= NOTE_FLUSH_ANYWAY;
+
+	for (int s = 0; s < NR_IO_STREAMS; s++) {
+		struct netfs_io_stream *stream = &wreq->io_streams[s];
+		int ret;
+
+		if (stream->buffering) {
+			ret = netfs_issue_writes(wreq, stream, params);
+			if (ret < 0) {
+				/* Leave the error somewhere the completion
+				 * path can pick it up if there isn't already
+				 * another error logged.
+				 */
+				cmpxchg(&wreq->error, 0, ret);
+			}
+			stream->buffering = false;
+		}
+	}
+
+	smp_wmb(); /* Write subreq lists before ALL_QUEUED. */
+	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
+
+	for (int s = 0; s < NR_IO_STREAMS; s++) {
+		struct netfs_io_stream *stream = &wreq->io_streams[s];
 
-	if (subreq->len >= stream->sreq_max_len ||
-	    subreq->nr_segs >= stream->sreq_max_segs ||
-	    to_eof) {
-		netfs_issue_write(wreq, stream);
-		subreq = NULL;
+		if (!stream->active)
+			continue;
+		if (!list_empty(&stream->subrequests))
+			needs_poke = false;
 	}
 
-	return part;
+	if (needs_poke)
+		netfs_wake_collector(wreq);
 }
 
 /*
- * Write some of a pending folio data back to the server.
+ * Queue a folio for writeback.
  */
-static int netfs_write_folio(struct netfs_io_request *wreq,
-			     struct writeback_control *wbc,
-			     struct folio *folio)
+static int netfs_queue_wb_folio(struct netfs_io_request *wreq,
+				struct writeback_control *wbc,
+				struct folio *folio,
+				struct netfs_wb_params *params)
 {
-	struct netfs_io_stream *upload = &wreq->io_streams[0];
-	struct netfs_io_stream *cache  = &wreq->io_streams[1];
-	struct netfs_io_stream *stream;
 	struct netfs_group *fgroup; /* TODO: Use this with ceph */
 	struct netfs_folio *finfo;
 	struct bvecq *queue = wreq->load_cursor.bvecq;
 	unsigned int slot;
 	size_t fsize = folio_size(folio), flen = fsize, foff = 0;
 	loff_t fpos = folio_pos(folio), i_size;
-	bool to_eof = false, streamw = false;
-	bool debug = false;
 	int ret;
 
-	_enter("");
+	_enter("%x", params->notes);
 
 	/* Institute a new bvec queue segment if the current one is full or if
 	 * we encounter a discontiguity.  The discontiguity break is important
 	 * when it comes to bulk unlocking folios by file range.
 	 */
 	if (bvecq_is_full(queue) ||
-	    (fpos != wreq->last_end && wreq->last_end > 0)) {
+	    (fpos != params->last_end && params->last_end > 0)) {
 		ret = bvecq_buffer_make_space(&wreq->load_cursor, GFP_NOFS);
 		if (ret < 0) {
 			folio_unlock(folio);
@@ -387,10 +542,10 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 
 		queue = wreq->load_cursor.bvecq;
 		queue->fpos = fpos;
-		if (fpos != wreq->last_end)
+		if (fpos != params->last_end)
 			queue->discontig = true;
-		bvecq_pos_move(&wreq->dispatch_cursor, queue);
-		wreq->dispatch_cursor.slot = 0;
+		bvecq_pos_move(&params->dispatch_cursor, queue);
+		params->dispatch_cursor.slot = 0;
 	}
 
 	/* netfs_perform_write() may shift i_size around the page or from out
@@ -418,23 +573,36 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	if (finfo) {
 		foff = finfo->dirty_offset;
 		flen = foff + finfo->dirty_len;
-		streamw = true;
+		params->notes |= NOTE_STREAMW;
+		if (foff > 0)
+			params->notes |= NOTE_DISCONTIG_BEFORE;
+		if (flen < fsize)
+			params->notes |= NOTE_DISCONTIG_AFTER;
 	}
 
+	if (params->last_end && fpos != params->last_end)
+		params->notes |= NOTE_DISCONTIG_BEFORE;
+	params->last_end = fpos + fsize;
+
 	if (wreq->origin == NETFS_WRITETHROUGH) {
-		to_eof = false;
 		if (flen > i_size - fpos)
 			flen = i_size - fpos;
+		/* EOF may be changing. */
 	} else if (flen > i_size - fpos) {
 		flen = i_size - fpos;
-		if (!streamw)
+		if (!(params->notes & NOTE_STREAMW))
 			folio_zero_segment(folio, flen, fsize);
-		to_eof = true;
+		params->notes |= NOTE_TO_EOF;
 	} else if (flen == i_size - fpos) {
-		to_eof = true;
+		params->notes |= NOTE_TO_EOF;
 	}
 	flen -= foff;
 
+	params->folio_start	= fpos;
+	params->folio_len	= fsize;
+	params->dirty_offset	= foff;
+	params->dirty_len	= flen;
+
 	_debug("folio %zx %zx %zx", foff, flen, fsize);
 
 	/* Deal with discontinuities in the stream of dirty pages.  These can
@@ -454,22 +622,31 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	 *     write-back group.
 	 */
 	if (fgroup == NETFS_FOLIO_COPY_TO_CACHE) {
-		netfs_issue_write(wreq, upload);
+		if (!(params->notes & NOTE_CACHE_AVAIL)) {
+			trace_netfs_folio(folio, netfs_folio_trace_cancel_copy);
+			goto cancel_folio;
+		}
+		params->notes |= NOTE_CACHE_COPY;
+		trace_netfs_folio(folio, netfs_folio_trace_store_copy);
 	} else if (fgroup != wreq->group) {
 		/* We can't write this page to the server yet. */
 		kdebug("wrong group");
-		folio_redirty_for_writepage(wbc, folio);
-		folio_unlock(folio);
-		netfs_issue_write(wreq, upload);
-		netfs_issue_write(wreq, cache);
-		return 0;
+		goto skip_folio;
+	} else if (!(params->notes & (NOTE_UPLOAD_AVAIL | NOTE_CACHE_AVAIL))) {
+		trace_netfs_folio(folio, netfs_folio_trace_cancel_store);
+		goto cancel_folio_discard;
+	} else {
+		if (params->notes & NOTE_UPLOAD_STARTED) {
+			params->notes |= NOTE_UPLOAD;
+			trace_netfs_folio(folio, netfs_folio_trace_store_plus);
+		} else {
+			params->notes |= NOTE_UPLOAD | NOTE_UPLOAD_STARTED;
+			trace_netfs_folio(folio, netfs_folio_trace_store);
+		}
+		if (params->notes & NOTE_CACHE_AVAIL)
+			params->notes |= NOTE_CACHE_COPY;
 	}
 
-	if (foff > 0)
-		netfs_issue_write(wreq, upload);
-	if (streamw)
-		netfs_issue_write(wreq, cache);
-
 	/* Flip the page to the writeback state and unlock.  If we're called
 	 * from write-through, then the page has already been put into the wb
 	 * state.
@@ -478,129 +655,37 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 		folio_start_writeback(folio);
 	folio_unlock(folio);
 
-	if (fgroup == NETFS_FOLIO_COPY_TO_CACHE) {
-		if (!cache->avail) {
-			trace_netfs_folio(folio, netfs_folio_trace_cancel_copy);
-			netfs_issue_write(wreq, upload);
-			netfs_folio_written_back(folio);
-			return 0;
-		}
-		trace_netfs_folio(folio, netfs_folio_trace_store_copy);
-	} else if (!upload->avail && !cache->avail) {
-		trace_netfs_folio(folio, netfs_folio_trace_cancel_store);
-		netfs_folio_written_back(folio);
-		return 0;
-	} else if (!upload->construct) {
-		trace_netfs_folio(folio, netfs_folio_trace_store);
-	} else {
-		trace_netfs_folio(folio, netfs_folio_trace_store_plus);
-	}
-
 	/* Attach the folio to the rolling buffer. */
 	slot = queue->nr_slots;
-	bvec_set_folio(&queue->bv[slot], folio, flen, 0);
+	bvec_set_folio(&queue->bv[slot], folio, flen, foff);
 	queue->nr_slots = slot + 1;
 	wreq->load_cursor.slot = slot + 1;
 	wreq->load_cursor.offset = 0;
-	wreq->last_end = fpos + foff + flen;
 	trace_netfs_bv_slot(queue, slot);
+	trace_netfs_wback(wreq, folio, params->notes);
 
-	/* Move the submission point forward to allow for write-streaming data
-	 * not starting at the front of the page.  We don't do write-streaming
-	 * with the cache as the cache requires DIO alignment.
-	 *
-	 * Also skip uploading for data that's been read and just needs copying
-	 * to the cache.
-	 */
-	for (int s = 0; s < NR_IO_STREAMS; s++) {
-		stream = &wreq->io_streams[s];
-		stream->submit_off = 0;
-		stream->submit_len = flen;
-		if (!stream->avail ||
-		    (stream->source == NETFS_WRITE_TO_CACHE && streamw) ||
-		    (stream->source == NETFS_UPLOAD_TO_SERVER &&
-		     fgroup == NETFS_FOLIO_COPY_TO_CACHE)) {
-			stream->submit_off = UINT_MAX;
-			stream->submit_len = 0;
-		}
-	}
-
-	/* Attach the folio to one or more subrequests.  For a big folio, we
-	 * could end up with thousands of subrequests if the wsize is small -
-	 * but we might need to wait during the creation of subrequests for
-	 * network resources (eg. SMB credits).
-	 */
-	for (;;) {
-		ssize_t part;
-		size_t lowest_off = ULONG_MAX;
-		int choose_s = -1;
-
-		/* Always add to the lowest-submitted stream first. */
-		for (int s = 0; s < NR_IO_STREAMS; s++) {
-			stream = &wreq->io_streams[s];
-			if (stream->submit_len > 0 &&
-			    stream->submit_off < lowest_off) {
-				lowest_off = stream->submit_off;
-				choose_s = s;
-			}
-		}
-
-		if (choose_s < 0)
-			break;
-		stream = &wreq->io_streams[choose_s];
-
-		/* Advance the cursor. */
-		wreq->dispatch_cursor.offset = stream->submit_off;
-
-		atomic64_set(&wreq->issued_to, fpos + foff + stream->submit_off);
-		part = netfs_advance_write(wreq, stream, fpos + foff + stream->submit_off,
-					   stream->submit_len, to_eof);
-		stream->submit_off += part;
-		if (part > stream->submit_len)
-			stream->submit_len = 0;
-		else
-			stream->submit_len -= part;
-		if (part > 0)
-			debug = true;
-	}
-
-	bvecq_pos_step(&wreq->dispatch_cursor);
-	/* Order loading the queue before updating the issue_to point */
-	atomic64_set_release(&wreq->issued_to, fpos + fsize);
-
-	if (!debug)
-		kdebug("R=%x: No submit", wreq->debug_id);
-
-	if (foff + flen < fsize)
-		for (int s = 0; s < NR_IO_STREAMS; s++)
-			netfs_issue_write(wreq, &wreq->io_streams[s]);
-
-	_leave(" = 0");
+out:
+	_leave(" = %x", params->notes);
 	return 0;
-}
 
-/*
- * End the issuing of writes, letting the collector know we're done.
- */
-static void netfs_end_issue_write(struct netfs_io_request *wreq)
-{
-	bool needs_poke = true;
-
-	smp_wmb(); /* Write subreq lists before ALL_QUEUED. */
-	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
-
-	for (int s = 0; s < NR_IO_STREAMS; s++) {
-		struct netfs_io_stream *stream = &wreq->io_streams[s];
-
-		if (!stream->active)
-			continue;
-		if (!list_empty(&stream->subrequests))
-			needs_poke = false;
-		netfs_issue_write(wreq, stream);
-	}
-
-	if (needs_poke)
-		netfs_wake_collector(wreq);
+skip_folio:
+	ret = folio_redirty_for_writepage(wbc, folio);
+	folio_unlock(folio);
+	if (ret < 0)
+		return ret;
+	params->notes |= NOTE_DISCONTIG_BEFORE;
+	goto out;
+cancel_folio_discard:
+	netfs_put_group(fgroup);
+cancel_folio:
+	folio_detach_private(folio);
+	kfree(finfo);
+	folio_unlock(folio);
+	folio_cancel_dirty(folio);
+	if (wreq->origin == NETFS_WRITETHROUGH)
+		folio_end_writeback(folio);
+	params->notes |= NOTE_DISCONTIG_BEFORE;
+	goto out;
 }
 
 /*
@@ -611,6 +696,7 @@ int netfs_writepages(struct address_space *mapping,
 {
 	struct netfs_inode *ictx = netfs_inode(mapping->host);
 	struct netfs_io_request *wreq = NULL;
+	struct netfs_wb_params params = {};
 	struct folio *folio;
 	int error = 0;
 
@@ -636,35 +722,48 @@ int netfs_writepages(struct address_space *mapping,
 
 	if (bvecq_buffer_init(&wreq->load_cursor, GFP_NOFS) < 0)
 		goto nomem;
-	bvecq_pos_set(&wreq->dispatch_cursor, &wreq->load_cursor);
-	bvecq_pos_set(&wreq->collect_cursor, &wreq->dispatch_cursor);
+	bvecq_pos_set(&params.dispatch_cursor, &wreq->load_cursor);
+	bvecq_pos_set(&wreq->collect_cursor, &wreq->load_cursor);
 
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
-	do {
-		_debug("wbiter %lx %llx", folio->index, atomic64_read(&wreq->issued_to));
+	if (wreq->io_streams[1].avail)
+		params.notes |= NOTE_CACHE_AVAIL;
 
-		/* It appears we don't have to handle cyclic writeback wrapping. */
-		WARN_ON_ONCE(wreq && folio_pos(folio) < atomic64_read(&wreq->issued_to));
+	do {
+		_debug("wbiter %lx", folio->index);
 
 		if (netfs_folio_group(folio) != NETFS_FOLIO_COPY_TO_CACHE &&
 		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
 			set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
 			wreq->netfs_ops->begin_writeback(wreq);
+			if (wreq->io_streams[0].avail) {
+				params.notes |= NOTE_UPLOAD_AVAIL;
+				/* Order setting the active flag after other fields. */
+				smp_store_release(&wreq->io_streams[0].active, true);
+			}
 		}
 
-		error = netfs_write_folio(wreq, wbc, folio);
+		params.notes &= NOTES__KEEP_MASK;
+		error = netfs_queue_wb_folio(wreq, wbc, folio, &params);
+		if (error < 0)
+			break;
+		error = netfs_issue_streams(wreq, &params);
 		if (error < 0)
 			break;
+
+		bvecq_pos_step(&params.dispatch_cursor);
 	} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
 
-	netfs_end_issue_write(wreq);
+	netfs_end_issue_write(wreq, &params);
 
 	mutex_unlock(&ictx->wb_lock);
 	bvecq_pos_unset(&wreq->load_cursor);
-	bvecq_pos_unset(&wreq->dispatch_cursor);
+	bvecq_pos_unset(&params.dispatch_cursor);
+	for (int i = 0; i < NR_IO_STREAMS; i++)
+		bvecq_pos_unset(&wreq->io_streams[i].dispatch_cursor);
 	netfs_wake_collector(wreq);
 
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
@@ -686,32 +785,55 @@ EXPORT_SYMBOL(netfs_writepages);
 /*
  * Begin a write operation for writing through the pagecache.
  */
-struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len)
+struct netfs_writethrough *netfs_begin_writethrough(struct kiocb *iocb, size_t len)
 {
+	struct netfs_writethrough *wthru = NULL;
 	struct netfs_io_request *wreq = NULL;
 	struct netfs_inode *ictx = netfs_inode(file_inode(iocb->ki_filp));
 
+	wthru = kzalloc_obj(struct netfs_writethrough);
+	if (!wthru)
+		return ERR_PTR(-ENOMEM);
+
 	mutex_lock(&ictx->wb_lock);
 
 	wreq = netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_filp,
 				      iocb->ki_pos, NETFS_WRITETHROUGH);
 	if (IS_ERR(wreq)) {
 		mutex_unlock(&ictx->wb_lock);
-		return wreq;
+		kfree(wthru);
+		return ERR_CAST(wreq);
 	}
+	wthru->wreq = wreq;
 
 	if (bvecq_buffer_init(&wreq->load_cursor, GFP_NOFS) < 0) {
 		netfs_put_failed_request(wreq);
 		mutex_unlock(&ictx->wb_lock);
+		kfree(wthru);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	bvecq_pos_set(&wreq->dispatch_cursor, &wreq->load_cursor);
-	bvecq_pos_set(&wreq->collect_cursor, &wreq->dispatch_cursor);
+	bvecq_pos_set(&wthru->params.dispatch_cursor, &wreq->load_cursor);
+	bvecq_pos_set(&wreq->collect_cursor, &wreq->load_cursor);
+
+	if (wreq->io_streams[1].avail)
+		wthru->params.notes |= NOTE_CACHE_AVAIL;
 
 	wreq->io_streams[0].avail = true;
 	trace_netfs_write(wreq, netfs_write_trace_writethrough);
-	return wreq;
+	if (!is_sync_kiocb(iocb))
+		wreq->iocb = iocb;
+
+	if (unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
+		set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
+		/* Don't call ->begin_writeback() as ->init_request() gets file*. */
+		if (wreq->io_streams[0].avail) {
+			wthru->params.notes |= NOTE_UPLOAD_AVAIL;
+			/* Order setting the active flag after other fields. */
+			smp_store_release(&wreq->io_streams[0].active, true);
+		}
+	}
+	return wthru;
 }
 
 /*
@@ -720,14 +842,17 @@ struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len
  * to the request.  If we've added more than wsize then we need to create a new
  * subrequest.
  */
-int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
-			       struct folio *folio, size_t copied, bool to_page_end,
-			       struct folio **writethrough_cache)
+int netfs_advance_writethrough(struct netfs_writethrough *wthru,
+			       struct writeback_control *wbc,
+			       struct folio *folio, size_t copied, bool to_page_end)
 {
+	struct netfs_io_request *wreq = wthru->wreq;
+	int ret;
+
 	_enter("R=%x ws=%u cp=%zu tp=%u",
 	       wreq->debug_id, wreq->wsize, copied, to_page_end);
 
-	if (!*writethrough_cache) {
+	if (!wthru->in_progress) {
 		if (folio_test_dirty(folio))
 			/* Sigh.  mmap. */
 			folio_clear_dirty_for_io(folio);
@@ -738,63 +863,113 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
 			trace_netfs_folio(folio, netfs_folio_trace_wthru);
 		else
 			trace_netfs_folio(folio, netfs_folio_trace_wthru_plus);
-		*writethrough_cache = folio;
+		wthru->in_progress = folio;
 	}
 
 	wreq->len += copied;
 	if (!to_page_end)
 		return 0;
 
-	*writethrough_cache = NULL;
-	return netfs_write_folio(wreq, wbc, folio);
+	wthru->in_progress = NULL;
+	wthru->params.notes &= NOTES__KEEP_MASK;
+	ret = netfs_queue_wb_folio(wreq, wbc, folio, &wthru->params);
+	if (ret < 0)
+		return ret;
+	return netfs_issue_streams(wreq, &wthru->params);
 }
 
 /*
  * End a write operation used when writing through the pagecache.
  */
-ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
-			       struct folio *writethrough_cache)
+ssize_t netfs_end_writethrough(struct netfs_writethrough *wthru,
+			       struct writeback_control *wbc)
 {
+	struct netfs_io_request *wreq = wthru->wreq;
 	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	ssize_t ret;
 
 	_enter("R=%x", wreq->debug_id);
 
-	if (writethrough_cache)
-		netfs_write_folio(wreq, wbc, writethrough_cache);
+	if (wthru->in_progress) {
+		wthru->params.notes &= NOTES__KEEP_MASK;
+		ret = netfs_queue_wb_folio(wreq, wbc, wthru->in_progress, &wthru->params);
+		if (ret == 0)
+			ret = netfs_issue_streams(wreq, &wthru->params);
+		wthru->in_progress = NULL;
+	}
 
-	netfs_end_issue_write(wreq);
+	netfs_end_issue_write(wreq, &wthru->params);
 
 	mutex_unlock(&ictx->wb_lock);
 
 	bvecq_pos_unset(&wreq->load_cursor);
-	bvecq_pos_unset(&wreq->dispatch_cursor);
+	bvecq_pos_unset(&wthru->params.dispatch_cursor);
+	for (int i = 0; i < NR_IO_STREAMS; i++)
+		bvecq_pos_unset(&wreq->io_streams[i].dispatch_cursor);
 
 	if (wreq->iocb)
 		ret = -EIOCBQUEUED;
 	else
 		ret = netfs_wait_for_write(wreq);
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
+	kfree(wthru);
 	return ret;
 }
 
+/*
+ * Prepare a buffer for a single monolithic write.
+ */
+static int netfs_prepare_write_single_buffer(struct netfs_io_subrequest *subreq,
+					     unsigned int max_segs)
+{
+	struct netfs_io_request *wreq = subreq->rreq;
+	struct netfs_io_stream *stream = &wreq->io_streams[subreq->stream_nr];
+	struct bio_vec *bv;
+	struct bvecq *bq;
+	size_t dio_size = wreq->cache_resources.dio_size;
+	size_t dlen;
+
+	bvecq_pos_set(&subreq->dispatch_pos, &stream->dispatch_cursor);
+	bvecq_pos_set(&subreq->content, &subreq->dispatch_pos);
+
+	/* Round the end of the last entry up. */
+	bq = subreq->content.bvecq;
+	while (bq->next)
+		bq = bq->next;
+	bv = &bq->bv[bq->nr_slots - 1];
+	dlen = round_up(bv->bv_len, dio_size);
+	if (dlen > bv->bv_len) {
+		subreq->len += dlen - bv->bv_len;
+		bv->bv_len = dlen;
+	}
+
+	stream->buffered   = 0;
+	stream->issue_from = subreq->len;
+	wreq->submitted    = subreq->len;
+	return 0;
+}
+
 /**
  * netfs_writeback_single - Write back a monolithic payload
  * @mapping: The mapping to write from
  * @wbc: Hints from the VM
- * @iter: Data to write.
+ * @iter: Data to write
+ * @len: Amount of data to write
  *
  * Write a monolithic, non-pagecache object back to the server and/or
  * the cache.  There's a maximum of one subrequest per stream.
  */
 int netfs_writeback_single(struct address_space *mapping,
 			   struct writeback_control *wbc,
-			   struct iov_iter *iter)
+			   struct iov_iter *iter,
+			   size_t len)
 {
 	struct netfs_io_request *wreq;
 	struct netfs_inode *ictx = netfs_inode(mapping->host);
 	int ret;
 
+	_enter("%zx,%zx", iov_iter_count(iter), len);
+
 	if (!mutex_trylock(&ictx->wb_lock)) {
 		if (wbc->sync_mode == WB_SYNC_NONE) {
 			netfs_stat(&netfs_n_wb_lock_skip);
@@ -809,23 +984,24 @@ int netfs_writeback_single(struct address_space *mapping,
 		ret = PTR_ERR(wreq);
 		goto couldnt_start;
 	}
-	wreq->len = iov_iter_count(iter);
 
-	ret = netfs_extract_iter(iter, wreq->len, INT_MAX, 0, &wreq->dispatch_cursor.bvecq, 0);
+	wreq->len = len;
+
+	ret = netfs_extract_iter(iter, len, INT_MAX, 0, &wreq->load_cursor.bvecq, 0);
 	if (ret < 0)
 		goto cleanup_free;
-	if (ret < wreq->len) {
+	if (ret < len) {
 		ret = -EIO;
 		goto cleanup_free;
 	}
 
-	bvecq_pos_set(&wreq->collect_cursor, &wreq->dispatch_cursor);
+	bvecq_pos_set(&wreq->collect_cursor, &wreq->load_cursor);
 
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
 	trace_netfs_write(wreq, netfs_write_trace_writeback_single);
 	netfs_stat(&netfs_n_wh_writepages);
 
-	if (__test_and_set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
+	if (test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
 		wreq->netfs_ops->begin_writeback(wreq);
 
 	for (int s = 0; s < NR_IO_STREAMS; s++) {
@@ -835,13 +1011,22 @@ int netfs_writeback_single(struct address_space *mapping,
 		if (!stream->avail)
 			continue;
 
-		netfs_prepare_write(wreq, stream, 0);
+		stream->issue_from = 0;
+		stream->buffered   = len;
+
+		subreq = netfs_alloc_write_subreq(wreq, stream);
+		if (!subreq) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		bvecq_pos_set(&stream->dispatch_cursor, &wreq->load_cursor);
 
-		subreq = stream->construct;
-		subreq->len = wreq->len;
-		stream->submit_len = subreq->len;
+		ret = stream->issue_write(subreq);
+		if (ret < 0 && ret != -EIOCBQUEUED)
+			netfs_write_subrequest_terminated(subreq, ret);
 
-		netfs_issue_write(wreq, stream);
+		bvecq_pos_unset(&stream->dispatch_cursor);
 	}
 
 	wreq->submitted = wreq->len;
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 5df5c34d4610..096ddf7a2e5c 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -12,12 +12,43 @@
 #include "internal.h"
 
 /*
- * Perform retries on the streams that need it.
+ * Prepare the write buffer for a retry.  We can't necessarily reuse the write
+ * buffer from the previous run of a subrequest because the filesystem is
+ * permitted to modify it (add headers/trailers, encrypt it).  Further, the
+ * subrequest may now be a different size (e.g. cifs has to negotiate for
+ * maximum transfer size).  Also, we can't look at *stream as that may still
+ * refer to the source material being broken up into original subrequests.
+ */
+int netfs_prepare_write_retry_buffer(struct netfs_io_subrequest *subreq,
+				     unsigned int max_segs)
+{
+	struct netfs_io_request *wreq = subreq->rreq;
+	struct netfs_io_stream *stream = &wreq->io_streams[subreq->stream_nr];
+	size_t len;
+
+	bvecq_pos_set(&subreq->dispatch_pos, &wreq->retry_cursor);
+	bvecq_pos_set(&subreq->content, &wreq->retry_cursor);
+	len = bvecq_slice(&wreq->retry_cursor, subreq->len, max_segs, &subreq->nr_segs);
+
+	if (len < subreq->len) {
+		subreq->len = len;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+	}
+
+	stream->issue_from += len;
+	stream->buffered   -= len;
+	if (stream->buffered == 0)
+		bvecq_pos_unset(&wreq->retry_cursor);
+	return 0;
+}
+
+/*
+ * Perform retries on the streams that need it.  This only has to deal with
+ * buffered writes; unbuffered write retry is handled in direct_write.c.
  */
 static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 				     struct netfs_io_stream *stream)
 {
-	struct bvecq_pos dispatch_cursor = {};
 	struct list_head *next;
 
 	_enter("R=%x[%x:]", wreq->debug_id, stream->stream_nr);
@@ -32,30 +63,14 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 	if (unlikely(stream->failed))
 		return;
 
-	/* If there's no renegotiation to do, just resend each failed subreq. */
-	if (!stream->prepare_write) {
-		struct netfs_io_subrequest *subreq;
-
-		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
-			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
-				break;
-			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
-				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-				netfs_reissue_write(stream, subreq);
-			}
-		}
-		return;
-	}
-
 	next = stream->subrequests.next;
 
 	do {
 		struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
 		unsigned long long start, len;
-		size_t part;
-		bool boundary = false;
+		int ret;
 
-		bvecq_pos_unset(&dispatch_cursor);
+		bvecq_pos_unset(&wreq->retry_cursor);
 
 		/* Go through the stream and find the next span of contiguous
 		 * data that we then rejig (cifs, for example, needs the wsize
@@ -73,7 +88,6 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 		list_for_each_continue(next, &stream->subrequests) {
 			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
 			if (subreq->start + subreq->transferred != start + len ||
-			    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||
 			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
 				break;
 			to = subreq;
@@ -83,43 +97,40 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 		/* Determine the set of buffers we're going to use.  Each
 		 * subreq gets a subset of a single overall contiguous buffer.
 		 */
-		bvecq_pos_transfer(&dispatch_cursor, &from->dispatch_pos);
-		bvecq_pos_advance(&dispatch_cursor, from->transferred);
+		bvecq_pos_transfer(&wreq->retry_cursor, &from->dispatch_pos);
+		bvecq_pos_advance(&wreq->retry_cursor, from->transferred);
+		wreq->retry_start = start;
+		wreq->retry_buffered = len;
 
 		/* Work through the sublist. */
 		subreq = from;
 		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
-			if (!len)
+			if (!wreq->retry_buffered)
 				break;
 
-			subreq->start	= start;
-			subreq->len	= len;
-			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
-
 			bvecq_pos_unset(&subreq->dispatch_pos);
 			bvecq_pos_unset(&subreq->content);
+			subreq->content.bvecq = NULL;
+			subreq->content.slot = 0;
+			subreq->content.offset = 0;
 
-			/* Renegotiate max_len (wsize) */
-			stream->sreq_max_len = len;
-			stream->sreq_max_segs = INT_MAX;
-			stream->prepare_write(subreq);
-
-			bvecq_pos_set(&subreq->dispatch_pos, &dispatch_cursor);
-			part = bvecq_slice(&dispatch_cursor,
-					   umin(len, stream->sreq_max_len),
-					   stream->sreq_max_segs,
-					   &subreq->nr_segs);
-			subreq->len = subreq->transferred + part;
-			subreq->transferred = 0;
-			len -= part;
-			start += part;
-			if (len && subreq == to &&
-			    __test_and_clear_bit(NETFS_SREQ_BOUNDARY, &to->flags))
-				boundary = true;
-
+			__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+			__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
+			__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+			subreq->start		= wreq->retry_start;
+			subreq->len		= wreq->retry_buffered;
+			subreq->transferred	= 0;
+			subreq->retry_count	+= 1;
+			subreq->error		= 0;
+
+			netfs_stat(&netfs_n_wh_retry_write_subreq);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-			netfs_reissue_write(stream, subreq);
+			ret = stream->issue_write(subreq);
+			if (ret < 0 && ret != -EIOCBQUEUED)
+				netfs_write_subrequest_terminated(subreq, ret);
+
 			if (subreq == to)
 				break;
 		}
@@ -160,12 +171,9 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			to = list_next_entry(to, rreq_link);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
-			stream->sreq_max_len	= len;
-			stream->sreq_max_segs	= INT_MAX;
 			switch (stream->source) {
 			case NETFS_UPLOAD_TO_SERVER:
 				netfs_stat(&netfs_n_wh_upload);
-				stream->sreq_max_len = umin(len, wreq->wsize);
 				break;
 			case NETFS_WRITE_TO_CACHE:
 				netfs_stat(&netfs_n_wh_write);
@@ -174,32 +182,16 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 				WARN_ON_ONCE(1);
 			}
 
-			stream->prepare_write(subreq);
-
-			bvecq_pos_set(&subreq->dispatch_pos, &dispatch_cursor);
-			part = bvecq_slice(&dispatch_cursor,
-					   umin(len, stream->sreq_max_len),
-					   stream->sreq_max_segs,
-					   &subreq->nr_segs);
-			subreq->len = subreq->transferred + part;
-
-			len -= part;
-			start += part;
-			if (!len && boundary) {
-				__set_bit(NETFS_SREQ_BOUNDARY, &to->flags);
-				boundary = false;
-			}
-
-			netfs_reissue_write(stream, subreq);
-			if (!len)
-				break;
+			ret = stream->issue_write(subreq);
+			if (ret < 0 && ret != -EIOCBQUEUED)
+				netfs_write_subrequest_terminated(subreq, ret);
 
 		} while (len);
 
 	} while (!list_is_head(next, &stream->subrequests));
 
 out:
-	bvecq_pos_unset(&dispatch_cursor);
+	bvecq_pos_unset(&wreq->retry_cursor);
 }
 
 /*
@@ -237,4 +229,6 @@ void netfs_retry_writes(struct netfs_io_request *wreq)
 			netfs_retry_write_stream(wreq, stream);
 		}
 	}
+
+	pr_notice("Retrying\n");
 }
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 12cb0ca738af..ae463867cf01 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -173,6 +173,7 @@ config NFS_FSCACHE
 	bool "Provide NFS client caching support"
 	depends on NFS_FS
 	select NETFS_SUPPORT
+	select NETFS_PGPRIV2
 	select FSCACHE
 	help
 	  Say Y here if you want NFS data to be cached locally on disc through
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 9b7fdad4a920..bc82821d77a3 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -273,8 +273,6 @@ static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct file *fi
 	rreq->debug_id = atomic_inc_return(&nfs_netfs_debug_id);
 	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cache. */
 	__set_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);
-	rreq->io_streams[0].sreq_max_len = NFS_SB(rreq->inode->i_sb)->rsize;
-
 	return 0;
 }
 
@@ -296,8 +294,9 @@ static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subrequest *sre
 	return netfs;
 }
 
-static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
+static int nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 {
+	struct netfs_io_request		*rreq = sreq->rreq;
 	struct nfs_netfs_io_data	*netfs;
 	struct nfs_pageio_descriptor	pgio;
 	struct inode *inode = sreq->rreq->inode;
@@ -307,6 +306,13 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 	pgoff_t start, last;
 	int err;
 
+	if (sreq->len > NFS_SB(rreq->inode->i_sb)->rsize)
+		sreq->len = NFS_SB(rreq->inode->i_sb)->rsize;
+
+	err = netfs_prepare_read_buffer(sreq, INT_MAX);
+	if (err < 0)
+		return err;
+
 	start = (sreq->start + sreq->transferred) >> PAGE_SHIFT;
 	last = ((sreq->start + sreq->len - sreq->transferred - 1) >> PAGE_SHIFT);
 
@@ -314,14 +320,15 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 			     &nfs_async_read_completion_ops);
 
 	netfs = nfs_netfs_alloc(sreq);
-	if (!netfs) {
-		sreq->error = -ENOMEM;
-		return netfs_read_subreq_terminated(sreq);
-	}
+	if (!netfs)
+		return -ENOMEM;
+
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(sreq);
 
 	pgio.pg_netfs = netfs; /* used in completion */
 
-	xa_for_each_range(&sreq->rreq->mapping->i_pages, idx, page, start, last) {
+	xa_for_each_range(&rreq->mapping->i_pages, idx, page, start, last) {
 		/* nfs_read_add_folio() may schedule() due to pNFS layout and other RPCs  */
 		err = nfs_read_add_folio(&pgio, ctx, page_folio(page));
 		if (err < 0) {
@@ -332,6 +339,7 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 out:
 	nfs_pageio_complete_read(&pgio);
 	nfs_netfs_put(netfs);
+	return -EIOCBQUEUED;
 }
 
 void nfs_netfs_initiate_read(struct nfs_pgio_header *hdr)
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 3990a9012264..dc9120802edb 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1466,8 +1466,7 @@ cifs_readv_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
-				 .rq_nvec = 1,
-				 .rq_iter = rdata->subreq.io_iter };
+				 .rq_nvec = 1};
 	struct cifs_credits credits = {
 		.value = 1,
 		.instance = 0,
@@ -1481,6 +1480,11 @@ cifs_readv_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		 __func__, mid->mid, mid->mid_state, rdata->result,
 		 rdata->subreq.len);
 
+	if (rdata->got_bytes)
+		iov_iter_bvec_queue(&rqst.rq_iter, ITER_DEST,
+				    rdata->subreq.content.bvecq, rdata->subreq.content.slot,
+				    rdata->subreq.content.offset, rdata->subreq.len);
+
 	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
 		/* result already set, check signature */
@@ -2002,7 +2006,10 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 1;
-	rqst.rq_iter = wdata->subreq.io_iter;
+
+	iov_iter_bvec_queue(&rqst.rq_iter, ITER_SOURCE,
+			    wdata->subreq.content.bvecq, wdata->subreq.content.slot,
+			    wdata->subreq.content.offset, wdata->subreq.len);
 
 	cifs_dbg(FYI, "async write at %llu %zu bytes\n",
 		 wdata->subreq.start, wdata->subreq.len);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index cffcf82c1b69..a933c12b39ea 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -44,18 +44,34 @@ static int cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush);
  * Prepare a subrequest to upload to the server.  We need to allocate credits
  * so that we know the maximum amount of data that we can include in it.
  */
-static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
+static int cifs_estimate_write(struct netfs_io_request *wreq,
+			       struct netfs_io_stream *stream,
+			       struct netfs_write_estimate *estimate)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(wreq->inode->i_sb);
+
+	estimate->issue_at = stream->issue_from + cifs_sb->ctx->wsize;
+	return 0;
+}
+
+/*
+ * Issue a subrequest to upload to the server.
+ */
+static int cifs_issue_write(struct netfs_io_subrequest *subreq)
 {
 	struct cifs_io_subrequest *wdata =
 		container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = wdata->req;
-	struct netfs_io_stream *stream = &req->rreq.io_streams[subreq->stream_nr];
 	struct TCP_Server_Info *server;
 	struct cifsFileInfo *open_file = req->cfile;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(wdata->rreq->inode->i_sb);
-	size_t wsize = req->rreq.wsize;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(subreq->rreq->inode->i_sb);
+	unsigned int max_segs = INT_MAX;
+	size_t len;
 	int rc;
 
+	if (cifs_forced_shutdown(cifs_sb))
+		return smb_EIO(smb_eio_trace_forced_shutdown);
+
 	if (!wdata->have_xid) {
 		wdata->xid = get_xid();
 		wdata->have_xid = true;
@@ -74,18 +90,16 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 		if (rc < 0) {
 			if (rc == -EAGAIN)
 				goto retry;
-			subreq->error = rc;
-			return netfs_prepare_write_failed(subreq);
+			return rc;
 		}
 	}
 
-	rc = server->ops->wait_mtu_credits(server, wsize, &stream->sreq_max_len,
-					   &wdata->credits);
-	if (rc < 0) {
-		subreq->error = rc;
-		return netfs_prepare_write_failed(subreq);
-	}
+	len = umin(subreq->len, cifs_sb->ctx->wsize);
+	rc = server->ops->wait_mtu_credits(server, len, &len, &wdata->credits);
+	if (rc < 0)
+		return rc;
 
+	subreq->len = len;
 	wdata->credits.rreq_debug_id = subreq->rreq->debug_id;
 	wdata->credits.rreq_debug_index = subreq->debug_index;
 	wdata->credits.in_flight_check = 1;
@@ -101,39 +115,29 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 		const struct smbdirect_socket_parameters *sp =
 			smbd_get_parameters(server->smbd_conn);
 
-		stream->sreq_max_segs = sp->max_frmr_depth;
+		max_segs = sp->max_frmr_depth;
 	}
 #endif
-}
-
-/*
- * Issue a subrequest to upload to the server.
- */
-static void cifs_issue_write(struct netfs_io_subrequest *subreq)
-{
-	struct cifs_io_subrequest *wdata =
-		container_of(subreq, struct cifs_io_subrequest, subreq);
-	struct cifs_sb_info *sbi = CIFS_SB(subreq->rreq->inode->i_sb);
-	int rc;
 
-	if (cifs_forced_shutdown(sbi)) {
-		rc = smb_EIO(smb_eio_trace_forced_shutdown);
-		goto fail;
+	rc = netfs_prepare_write_buffer(subreq, max_segs);
+	if (rc < 0) {
+		add_credits_and_wake_if(wdata->server, &wdata->credits, 0);
+		return rc;
 	}
 
-	rc = adjust_credits(wdata->server, wdata, cifs_trace_rw_credits_issue_write_adjust);
+	rc = adjust_credits(server, wdata, cifs_trace_rw_credits_issue_write_adjust);
 	if (rc)
-		goto fail;
+		goto fail_with_credits;
 
 	rc = -EAGAIN;
 	if (wdata->req->cfile->invalidHandle)
-		goto fail;
+		goto fail_with_credits;
 
 	wdata->server->ops->async_writev(wdata);
 out:
-	return;
+	return -EIOCBQUEUED;
 
-fail:
+fail_with_credits:
 	if (rc == -EAGAIN)
 		trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 	else
@@ -149,17 +153,25 @@ static void cifs_netfs_invalidate_cache(struct netfs_io_request *wreq)
 }
 
 /*
- * Negotiate the size of a read operation on behalf of the netfs library.
+ * Issue a read operation on behalf of the netfs helper functions.  We're asked
+ * to make a read of a certain size at a point in the file.  We are permitted
+ * to only read a portion of that, but as long as we read something, the netfs
+ * helper will call us again so that we can issue another read.
  */
-static int cifs_prepare_read(struct netfs_io_subrequest *subreq)
+static int cifs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
-	struct TCP_Server_Info *server;
+	struct TCP_Server_Info *server = rdata->server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
-	size_t size;
-	int rc = 0;
+	unsigned int max_segs = INT_MAX;
+	size_t len;
+	int rc;
+
+	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
+		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
+		 subreq->transferred, subreq->len);
 
 	if (!rdata->have_xid) {
 		rdata->xid = get_xid();
@@ -173,17 +185,15 @@ static int cifs_prepare_read(struct netfs_io_subrequest *subreq)
 		cifs_negotiate_rsize(server, cifs_sb->ctx,
 				     tlink_tcon(req->cfile->tlink));
 
-	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
-					   &size, &rdata->credits);
+	len = umin(subreq->len, cifs_sb->ctx->rsize);
+	rc = server->ops->wait_mtu_credits(server, len, &len, &rdata->credits);
 	if (rc)
 		return rc;
 
-	rreq->io_streams[0].sreq_max_len = size;
-
-	rdata->credits.in_flight_check = 1;
+	subreq->len = len;
 	rdata->credits.rreq_debug_id = rreq->debug_id;
 	rdata->credits.rreq_debug_index = subreq->debug_index;
-
+	rdata->credits.in_flight_check = 1;
 	trace_smb3_rw_credits(rdata->rreq->debug_id,
 			      rdata->subreq.debug_index,
 			      rdata->credits.value,
@@ -195,33 +205,17 @@ static int cifs_prepare_read(struct netfs_io_subrequest *subreq)
 		const struct smbdirect_socket_parameters *sp =
 			smbd_get_parameters(server->smbd_conn);
 
-		rreq->io_streams[0].sreq_max_segs = sp->max_frmr_depth;
+		max_segs = sp->max_frmr_depth;
 	}
 #endif
-	return 0;
-}
-
-/*
- * Issue a read operation on behalf of the netfs helper functions.  We're asked
- * to make a read of a certain size at a point in the file.  We are permitted
- * to only read a portion of that, but as long as we read something, the netfs
- * helper will call us again so that we can issue another read.
- */
-static void cifs_issue_read(struct netfs_io_subrequest *subreq)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
-	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
-	struct TCP_Server_Info *server = rdata->server;
-	int rc = 0;
 
-	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
-		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
-		 subreq->transferred, subreq->len);
+	rc = netfs_prepare_read_buffer(subreq, max_segs);
+	if (rc < 0)
+		goto fail_with_credits;
 
 	rc = adjust_credits(server, rdata, cifs_trace_rw_credits_issue_read_adjust);
 	if (rc)
-		goto failed;
+		goto fail_with_credits;
 
 	if (req->cfile->invalidHandle) {
 		do {
@@ -235,15 +229,24 @@ static void cifs_issue_read(struct netfs_io_subrequest *subreq)
 	    subreq->rreq->origin != NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(subreq);
+
 	rc = rdata->server->ops->async_readv(rdata);
-	if (rc)
-		goto failed;
-	return;
+	if (rc) {
+		subreq->error = rc;
+		netfs_read_subreq_terminated(subreq);
+	}
+	return -EIOCBQUEUED;
 
+fail_with_credits:
+	if (rc == -EAGAIN)
+		trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+	else
+		trace_netfs_sreq(subreq, netfs_sreq_trace_fail);
+	add_credits_and_wake_if(rdata->server, &rdata->credits, 0);
 failed:
-	subreq->error = rc;
-	netfs_read_subreq_terminated(subreq);
+	return rc;
 }
 
 /*
@@ -353,11 +356,10 @@ const struct netfs_request_ops cifs_req_ops = {
 	.init_request		= cifs_init_request,
 	.free_request		= cifs_free_request,
 	.free_subrequest	= cifs_free_subrequest,
-	.prepare_read		= cifs_prepare_read,
 	.issue_read		= cifs_issue_read,
 	.done			= cifs_rreq_done,
 	.begin_writeback	= cifs_begin_writeback,
-	.prepare_write		= cifs_prepare_write,
+	.estimate_write		= cifs_estimate_write,
 	.issue_write		= cifs_issue_write,
 	.invalidate_cache	= cifs_netfs_invalidate_cache,
 };
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 0d19c8fc4c3d..d15f196df1e7 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4705,6 +4705,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	unsigned int cur_page_idx;
 	unsigned int pad_len;
 	struct cifs_io_subrequest *rdata = mid->callback_data;
+	struct iov_iter iter;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
 	size_t copied;
 	bool use_rdma_mr = false;
@@ -4777,6 +4778,10 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 
 	pad_len = data_offset - server->vals->read_rsp_size;
 
+	iov_iter_bvec_queue(&iter, ITER_DEST,
+			    rdata->subreq.content.bvecq, rdata->subreq.content.slot,
+			    rdata->subreq.content.offset, rdata->subreq.len);
+
 	if (buf_len <= data_offset) {
 		/* read response payload is in pages */
 		cur_page_idx = pad_len / PAGE_SIZE;
@@ -4806,7 +4811,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 
 		/* Copy the data to the output I/O iterator. */
 		rdata->result = cifs_copy_bvecq_to_iter(buffer, buffer_len,
-							cur_off, &rdata->subreq.io_iter);
+							cur_off, &iter);
 		if (rdata->result != 0) {
 			if (is_offloaded)
 				mid->mid_state = MID_RESPONSE_MALFORMED;
@@ -4819,7 +4824,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	} else if (buf_len >= data_offset + data_len) {
 		/* read response payload is in buf */
 		WARN_ONCE(buffer, "read data can be either in buf or in buffer");
-		copied = copy_to_iter(buf + data_offset, data_len, &rdata->subreq.io_iter);
+		copied = copy_to_iter(buf + data_offset, data_len, &iter);
 		if (copied == 0)
 			return smb_EIO2(smb_eio_trace_rx_copy_to_iter, copied, data_len);
 		rdata->got_bytes = copied;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index c43ca74e8704..717d65d32dd3 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4539,9 +4539,13 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	 */
 	if (rdata && smb3_use_rdma_offload(io_parms)) {
 		struct smbdirect_buffer_descriptor_v1 *v1;
+		struct iov_iter iter;
 		bool need_invalidate = server->dialect == SMB30_PROT_ID;
 
-		rdata->mr = smbd_register_mr(server->smbd_conn, &rdata->subreq.io_iter,
+		iov_iter_bvec_queue(&iter, ITER_DEST,
+				    rdata->subreq.content.bvecq, rdata->subreq.content.slot,
+				    rdata->subreq.content.offset, rdata->subreq.len);
+		rdata->mr = smbd_register_mr(server->smbd_conn, &iter,
 					     true, need_invalidate);
 		if (!rdata->mr)
 			return -EAGAIN;
@@ -4606,9 +4610,10 @@ smb2_readv_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	unsigned int rreq_debug_id = rdata->rreq->debug_id;
 	unsigned int subreq_debug_index = rdata->subreq.debug_index;
 
-	if (rdata->got_bytes) {
-		rqst.rq_iter	  = rdata->subreq.io_iter;
-	}
+	if (rdata->got_bytes)
+		iov_iter_bvec_queue(&rqst.rq_iter, ITER_DEST,
+				    rdata->subreq.content.bvecq, rdata->subreq.content.slot,
+				    rdata->subreq.content.offset, rdata->subreq.len);
 
 	WARN_ONCE(rdata->server != server,
 		  "rdata server %p != mid server %p",
@@ -5096,7 +5101,9 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 		goto out;
 
 	rqst.rq_iov = iov;
-	rqst.rq_iter = wdata->subreq.io_iter;
+	iov_iter_bvec_queue(&rqst.rq_iter, ITER_SOURCE,
+			    wdata->subreq.content.bvecq, wdata->subreq.content.slot,
+			    wdata->subreq.content.offset, wdata->subreq.len);
 
 	rqst.rq_iov[0].iov_len = total_len - 1;
 	rqst.rq_iov[0].iov_base = (char *)req;
@@ -5135,9 +5142,14 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	 */
 	if (smb3_use_rdma_offload(io_parms)) {
 		struct smbdirect_buffer_descriptor_v1 *v1;
+		struct iov_iter iter;
 		bool need_invalidate = server->dialect == SMB30_PROT_ID;
 
-		wdata->mr = smbd_register_mr(server->smbd_conn, &wdata->subreq.io_iter,
+		iov_iter_bvec_queue(&iter, ITER_SOURCE,
+				    wdata->subreq.content.bvecq, wdata->subreq.content.slot,
+				    wdata->subreq.content.offset, wdata->subreq.len);
+
+		wdata->mr = smbd_register_mr(server->smbd_conn, &iter,
 					     false, need_invalidate);
 		if (!wdata->mr) {
 			rc = -EAGAIN;
@@ -5176,8 +5188,8 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 		smb2_set_replay(server, &rqst);
 	}
 
-	cifs_dbg(FYI, "async write at %llu %u bytes iter=%zx\n",
-		 io_parms->offset, io_parms->length, iov_iter_count(&wdata->subreq.io_iter));
+	cifs_dbg(FYI, "async write at %llu %u bytes len=%zx\n",
+		 io_parms->offset, io_parms->length, wdata->subreq.len);
 
 	if (wdata->credits.value > 0) {
 		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(wdata->subreq.len,
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 05f8099047e1..dd1313736fcb 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1264,12 +1264,19 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	}
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
-	if (rdata->mr)
+	if (rdata->mr) {
 		length = data_len; /* An RDMA read is already done. */
-	else
+	} else {
+#endif
+		struct iov_iter iter;
+
+		iov_iter_bvec_queue(&iter, ITER_DEST, rdata->subreq.content.bvecq,
+				    rdata->subreq.content.slot, rdata->subreq.content.offset,
+				    data_len);
+		length = cifs_read_iter_from_socket(server, &iter, data_len);
+#ifdef CONFIG_CIFS_SMB_DIRECT
+	}
 #endif
-		length = cifs_read_iter_from_socket(server, &rdata->subreq.io_iter,
-						    data_len);
 	if (length > 0)
 		rdata->got_bytes += length;
 	server->total_read += length;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 65e39f9b0c10..51c021975f0d 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -66,7 +66,7 @@ struct netfs_inode {
 #endif
 	struct mutex		wb_lock;	/* Writeback serialisation */
 	loff_t			remote_i_size;	/* Size of the remote file */
-	loff_t			zero_point;	/* Size after which we assume there's no data
+	unsigned long long	zero_point;	/* Size after which we assume there's no data
 						 * on the server */
 	atomic_t		io_count;	/* Number of outstanding reqs */
 	unsigned long		flags;
@@ -126,25 +126,39 @@ static inline struct netfs_group *netfs_folio_group(struct folio *folio)
 	return priv;
 }
 
+/*
+ * Estimate of maximum write subrequest for writeback.  The filesystem is
+ * responsible for filling this in when called from ->estimate_write(), though
+ * netfslib will preset infinite defaults.
+ */
+struct netfs_write_estimate {
+	unsigned long long	issue_at;	/* Point at which we must submit */
+	int			max_segs;	/* Max number of segments in a single RPC */
+};
+
 /*
  * Stream of I/O subrequests going to a particular destination, such as the
  * server or the local cache.  This is mainly intended for writing where we may
  * have to write to multiple destinations concurrently.
  */
 struct netfs_io_stream {
-	/* Submission tracking */
-	struct netfs_io_subrequest *construct;	/* Op being constructed */
-	size_t			sreq_max_len;	/* Maximum size of a subrequest */
-	unsigned int		sreq_max_segs;	/* 0 or max number of segments in an iterator */
-	unsigned int		submit_off;	/* Folio offset we're submitting from */
-	unsigned int		submit_len;	/* Amount of data left to submit */
-	void (*prepare_write)(struct netfs_io_subrequest *subreq);
-	void (*issue_write)(struct netfs_io_subrequest *subreq);
+	/* Submission tracking (main dispatch only; not retry) */
+	struct bvecq_pos	dispatch_cursor; /* Point from which buffers are dispatched */
+	unsigned long long	issue_from;	/* Current issue point */
+	size_t			buffered;	/* Amount in buffer */
+	u8			applicable;	/* What sources are applicable (NOTE_* mask) */
+	bool			buffering;	/* T if buffering on this stream */
+	int (*estimate_write)(struct netfs_io_request *wreq,
+			      struct netfs_io_stream *stream,
+			      struct netfs_write_estimate *estimate);
+	int (*issue_write)(struct netfs_io_subrequest *subreq);
+	atomic64_t		issued_to;	/* Point to which can be considered issued */
+
 	/* Collection tracking */
 	struct list_head	subrequests;	/* Contributory I/O operations */
 	unsigned long long	collected_to;	/* Position we've collected results to */
 	size_t			transferred;	/* The amount transferred from this stream */
-	unsigned short		error;		/* Aggregate error for the stream */
+	short			error;		/* Aggregate error for the stream */
 	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned char		stream_nr;	/* Index of stream in parent table */
 	bool			avail;		/* T if stream is available */
@@ -180,14 +194,13 @@ struct netfs_io_subrequest {
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
 	struct bvecq_pos	dispatch_pos;	/* Bookmark in the combined queue of the start */
 	struct bvecq_pos	content;	/* The (copied) content of the subrequest */
-	struct iov_iter		io_iter;	/* Iterator for this subrequest */
 	unsigned long long	start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
 	size_t			transferred;	/* Amount of data transferred */
+	unsigned int		nr_segs;	/* Number of segments in content */
 	refcount_t		ref;
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
-	unsigned int		nr_segs;	/* Number of segs in io_iter */
 	u8			retry_count;	/* The number of retries (0 on initial pass) */
 	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned char		stream_nr;	/* I/O stream this belongs to */
@@ -196,7 +209,6 @@ struct netfs_io_subrequest {
 #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
 #define NETFS_SREQ_MADE_PROGRESS	4	/* Set if we transferred at least some data */
 #define NETFS_SREQ_ONDEMAND		5	/* Set if it's from on-demand read mode */
-#define NETFS_SREQ_BOUNDARY		6	/* Set if ends on hard boundary (eg. ceph object) */
 #define NETFS_SREQ_HIT_EOF		7	/* Set if short due to EOF */
 #define NETFS_SREQ_IN_PROGRESS		8	/* Unlocked when the subrequest completes */
 #define NETFS_SREQ_NEED_RETRY		9	/* Set if the filesystem requests a retry */
@@ -243,22 +255,25 @@ struct netfs_io_request {
 	struct netfs_group	*group;		/* Writeback group being written back */
 	struct bvecq_pos	collect_cursor;	/* Clear-up point of I/O buffer */
 	struct bvecq_pos	load_cursor;	/* Point at which new folios are loaded in */
-	struct bvecq_pos	dispatch_cursor; /* Point from which buffers are dispatched */
+	struct bvecq_pos	retry_cursor;	/* Point from which retries are dispatched */
 	wait_queue_head_t	waitq;		/* Processor waiter */
 	void			*netfs_priv;	/* Private data for the netfs */
 	void			*netfs_priv2;	/* Private data for the netfs */
-	unsigned long long	last_end;	/* End pos of last folio submitted */
 	unsigned long long	submitted;	/* Amount submitted for I/O so far */
 	unsigned long long	len;		/* Length of the request */
 	size_t			transferred;	/* Amount to be indicated as transferred */
 	long			error;		/* 0 or error that occurred */
 	unsigned long long	i_size;		/* Size of the file */
 	unsigned long long	start;		/* Start position */
-	atomic64_t		issued_to;	/* Write issuer folio cursor */
 	unsigned long long	collected_to;	/* Point we've collected to */
 	unsigned long long	cache_coll_to;	/* Point the cache has collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
 	unsigned long long	abandon_to;	/* Position to abandon folios to */
+#ifdef CONFIG_NETFS_PGPRIV2
+	unsigned long long	last_end;	/* End of last folio added */
+#endif
+	unsigned long long	retry_start;	/* Position to retry from */
+	size_t			retry_buffered;	/* Amount of data to retry */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
 	unsigned int		debug_id;
 	unsigned int		rsize;		/* Maximum read size (0 for none) */
@@ -282,8 +297,10 @@ struct netfs_io_request {
 #define NETFS_RREQ_UPLOAD_TO_SERVER	11	/* Need to write to the server */
 #define NETFS_RREQ_USE_IO_ITER		12	/* Use ->io_iter rather than ->i_pages */
 #define NETFS_RREQ_NEED_PUT_RA_REFS	13	/* Need to put the folio refs RA gave us */
+#ifdef CONFIG_NETFS_PGPRIV2
 #define NETFS_RREQ_USE_PGPRIV2		31	/* [DEPRECATED] Use PG_private_2 to mark
 						 * write to cache on read */
+#endif
 	const struct netfs_request_ops *netfs_ops;
 };
 
@@ -299,8 +316,7 @@ struct netfs_request_ops {
 
 	/* Read request handling */
 	void (*expand_readahead)(struct netfs_io_request *rreq);
-	int (*prepare_read)(struct netfs_io_subrequest *subreq);
-	void (*issue_read)(struct netfs_io_subrequest *subreq);
+	int (*issue_read)(struct netfs_io_subrequest *subreq);
 	bool (*is_still_valid)(struct netfs_io_request *rreq);
 	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
 				 struct folio **foliop, void **_fsdata);
@@ -312,8 +328,10 @@ struct netfs_request_ops {
 
 	/* Write request handling */
 	void (*begin_writeback)(struct netfs_io_request *wreq);
-	void (*prepare_write)(struct netfs_io_subrequest *subreq);
-	void (*issue_write)(struct netfs_io_subrequest *subreq);
+	int (*estimate_write)(struct netfs_io_request *wreq,
+			      struct netfs_io_stream *stream,
+			      struct netfs_write_estimate *estimate);
+	int (*issue_write)(struct netfs_io_subrequest *subreq);
 	void (*retry_request)(struct netfs_io_request *wreq, struct netfs_io_stream *stream);
 	void (*invalidate_cache)(struct netfs_io_request *wreq);
 };
@@ -348,8 +366,16 @@ struct netfs_cache_ops {
 		     netfs_io_terminated_t term_func,
 		     void *term_func_priv);
 
+	/* Estimate the amount of data that can be written in an op. */
+	int (*estimate_write)(struct netfs_io_request *wreq,
+			      struct netfs_io_stream *stream,
+			      struct netfs_write_estimate *estimate);
+
+	/* Read data from the cache for a netfs subrequest. */
+	int (*issue_read)(struct netfs_io_subrequest *subreq);
+
 	/* Write data to the cache from a netfs subrequest. */
-	void (*issue_write)(struct netfs_io_subrequest *subreq);
+	int (*issue_write)(struct netfs_io_subrequest *subreq);
 
 	/* Expand readahead request */
 	void (*expand_readahead)(struct netfs_cache_resources *cres,
@@ -357,25 +383,6 @@ struct netfs_cache_ops {
 				 unsigned long long *_len,
 				 unsigned long long i_size);
 
-	/* Prepare a read operation, shortening it to a cached/uncached
-	 * boundary as appropriate.
-	 */
-	int (*prepare_read)(struct netfs_io_subrequest *subreq);
-
-	/* Prepare a write subrequest, working out if we're allowed to do it
-	 * and finding out the maximum amount of data to gather before
-	 * attempting to submit.  If we're not permitted to do it, the
-	 * subrequest should be marked failed.
-	 */
-	void (*prepare_write_subreq)(struct netfs_io_subrequest *subreq);
-
-	/* Prepare a write operation, working out what part of the write we can
-	 * actually do.
-	 */
-	int (*prepare_write)(struct netfs_cache_resources *cres,
-			     loff_t *_start, size_t *_len, size_t upper_len,
-			     loff_t i_size, bool no_space_allocated_yet);
-
 	/* Prepare an on-demand read operation, shortening it to a cached/uncached
 	 * boundary as appropriate.
 	 */
@@ -418,10 +425,9 @@ void netfs_single_mark_inode_dirty(struct inode *inode);
 ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_iter *iter);
 int netfs_writeback_single(struct address_space *mapping,
 			   struct writeback_control *wbc,
-			   struct iov_iter *iter);
+			   struct iov_iter *iter, size_t len);
 
 /* Address operations API */
-struct readahead_control;
 void netfs_readahead(struct readahead_control *);
 int netfs_read_folio(struct file *, struct folio *);
 int netfs_write_begin(struct netfs_inode *, struct file *,
@@ -439,6 +445,7 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
 
 /* (Sub)request management API. */
+void netfs_mark_read_submission(struct netfs_io_subrequest *subreq);
 void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq);
 void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
@@ -448,9 +455,8 @@ void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_segs,
 			   unsigned long long fpos, struct bvecq **_bvecq_head,
 			   iov_iter_extraction_t extraction_flags);
-size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
-			size_t max_size, size_t max_segs);
-void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq);
+int netfs_prepare_read_buffer(struct netfs_io_subrequest *subreq, unsigned int max_segs);
+int netfs_prepare_write_buffer(struct netfs_io_subrequest *subreq, unsigned int max_segs);
 void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error);
 
 int netfs_start_io_read(struct inode *inode);
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 4bba6fda1f8b..c080167451ab 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -70,6 +70,7 @@ enum cachefiles_coherency_trace {
 enum cachefiles_trunc_trace {
 	cachefiles_trunc_clear_padding,
 	cachefiles_trunc_dio_adjust,
+	cachefiles_trunc_discard_tail,
 	cachefiles_trunc_expand_tmpfile,
 	cachefiles_trunc_shrink,
 };
@@ -160,6 +161,7 @@ enum cachefiles_error_trace {
 #define cachefiles_trunc_traces						\
 	EM(cachefiles_trunc_clear_padding,	"CLRPAD")		\
 	EM(cachefiles_trunc_dio_adjust,		"DIOADJ")		\
+	EM(cachefiles_trunc_discard_tail,	"DSCDTL")		\
 	EM(cachefiles_trunc_expand_tmpfile,	"EXPTMP")		\
 	E_(cachefiles_trunc_shrink,		"SHRINK")
 
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index eeb8386e0709..ba38cc102bd7 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -49,6 +49,7 @@
 	E_(NETFS_PGPRIV2_COPY_TO_CACHE,		"2C")
 
 #define netfs_rreq_traces					\
+	EM(netfs_rreq_trace_all_queued,		"ALL-Q  ")	\
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
 	EM(netfs_rreq_trace_collect,		"COLLECT")	\
 	EM(netfs_rreq_trace_complete,		"COMPLET")	\
@@ -77,7 +78,8 @@
 	EM(netfs_rreq_trace_waited_quiesce,	"DONE-QUIESCE")	\
 	EM(netfs_rreq_trace_wake_ip,		"WAKE-IP")	\
 	EM(netfs_rreq_trace_wake_queue,		"WAKE-Q ")	\
-	E_(netfs_rreq_trace_write_done,		"WR-DONE")
+	EM(netfs_rreq_trace_write_done,		"WR-DONE")	\
+	E_(netfs_rreq_trace_zero_unread,	"ZERO-UR")
 
 #define netfs_sreq_sources					\
 	EM(NETFS_SOURCE_UNKNOWN,		"----")		\
@@ -126,6 +128,7 @@
 	EM(netfs_sreq_trace_superfluous,	"SPRFL")	\
 	EM(netfs_sreq_trace_terminated,		"TERM ")	\
 	EM(netfs_sreq_trace_too_much,		"!TOOM")	\
+	EM(netfs_sreq_trace_too_many_retries,	"!RETR")	\
 	EM(netfs_sreq_trace_wait_for,		"_WAIT")	\
 	EM(netfs_sreq_trace_write,		"WRITE")	\
 	EM(netfs_sreq_trace_write_skip,		"SKIP ")	\
@@ -189,12 +192,12 @@
 	EM(netfs_folio_trace_alloc_buffer,	"alloc-buf")	\
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
 	EM(netfs_folio_trace_cancel_store,	"cancel-store")	\
-	EM(netfs_folio_trace_clear,		"clear")	\
-	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\
-	EM(netfs_folio_trace_clear_g,		"clear-g")	\
-	EM(netfs_folio_trace_clear_s,		"clear-s")	\
 	EM(netfs_folio_trace_copy_to_cache,	"mark-copy")	\
 	EM(netfs_folio_trace_end_copy,		"end-copy")	\
+	EM(netfs_folio_trace_endwb,		"endwb")	\
+	EM(netfs_folio_trace_endwb_cc,		"endwb-cc")	\
+	EM(netfs_folio_trace_endwb_g,		"endwb-g")	\
+	EM(netfs_folio_trace_endwb_s,		"endwb-s")	\
 	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_kill,		"kill")		\
 	EM(netfs_folio_trace_kill_cc,		"kill-cc")	\
@@ -381,10 +384,10 @@ TRACE_EVENT(netfs_sreq,
 		    __entry->len	= sreq->len;
 		    __entry->transferred = sreq->transferred;
 		    __entry->start	= sreq->start;
-		    __entry->slot	= sreq->dispatch_pos.slot;
+		    __entry->slot	= sreq->content.slot;
 			   ),
 
-	    TP_printk("R=%08x[%x] %s %s f=%03x s=%llx %zx/%zx qs=%u e=%d",
+	    TP_printk("R=%08x[%x] %s %s f=%03x s=%llx %zx/%zx bv=%u e=%d",
 		      __entry->rreq, __entry->index,
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __print_symbolic(__entry->what, netfs_sreq_traces),
@@ -492,6 +495,7 @@ TRACE_EVENT(netfs_folio,
 	    TP_STRUCT__entry(
 		    __field(ino_t,			ino)
 		    __field(pgoff_t,			index)
+		    __field(unsigned long,		pfn)
 		    __field(unsigned int,		nr)
 		    __field(enum netfs_folio_trace,	why)
 			     ),
@@ -502,13 +506,40 @@ TRACE_EVENT(netfs_folio,
 		    __entry->why = why;
 		    __entry->index = folio->index;
 		    __entry->nr = folio_nr_pages(folio);
+		    __entry->pfn = folio_pfn(folio);
 			   ),
 
-	    TP_printk("i=%05lx ix=%05lx-%05lx %s",
+	    TP_printk("p=%lx i=%05lx ix=%05lx-%05lx %s",
+		      __entry->pfn,
 		      __entry->ino, __entry->index, __entry->index + __entry->nr - 1,
 		      __print_symbolic(__entry->why, netfs_folio_traces))
 	    );
 
+TRACE_EVENT(netfs_wback,
+	    TP_PROTO(struct netfs_io_request *wreq, struct folio *folio, unsigned int notes),
+
+	    TP_ARGS(wreq, folio, notes),
+
+	    TP_STRUCT__entry(
+		    __field(pgoff_t,			index)
+		    __field(unsigned int,		wreq)
+		    __field(unsigned int,		nr)
+		    __field(unsigned int,		notes)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->wreq = wreq->debug_id;
+		    __entry->notes = notes;
+		    __entry->index = folio->index;
+		    __entry->nr = folio_nr_pages(folio);
+			   ),
+
+	    TP_printk("R=%08x ix=%05lx-%05lx n=%02x",
+		      __entry->wreq,
+		      __entry->index, __entry->index + __entry->nr - 1,
+		      __entry->notes)
+	    );
+
 TRACE_EVENT(netfs_write_iter,
 	    TP_PROTO(const struct kiocb *iocb, const struct iov_iter *from),
 
@@ -751,7 +782,7 @@ TRACE_EVENT(netfs_collect_stream,
 		    __entry->wreq	= wreq->debug_id;
 		    __entry->stream	= stream->stream_nr;
 		    __entry->collected_to = stream->collected_to;
-		    __entry->issued_to	= atomic64_read(&wreq->issued_to);
+		    __entry->issued_to	= atomic64_read(&stream->issued_to);
 			   ),
 
 	    TP_printk("R=%08x[%x:] cto=%llx ito=%llx",
@@ -775,7 +806,7 @@ TRACE_EVENT(netfs_bvecq,
 		    __entry->trace	= trace;
 			   ),
 
-	    TP_printk("fq=%x %s",
+	    TP_printk("bq=%x %s",
 		      __entry->id,
 		      __print_symbolic(__entry->trace, netfs_bvecq_traces))
 	    );
diff --git a/net/9p/client.c b/net/9p/client.c
index f0dcf252af7e..8d365c000553 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1561,6 +1561,7 @@ void
 p9_client_write_subreq(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *wreq = subreq->rreq;
+	struct iov_iter iter;
 	struct p9_fid *fid = wreq->netfs_priv;
 	struct p9_client *clnt = fid->clnt;
 	struct p9_req_t *req;
@@ -1571,14 +1572,17 @@ p9_client_write_subreq(struct netfs_io_subrequest *subreq)
 	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu len %d\n",
 		 fid->fid, start, len);
 
+	iov_iter_bvec_queue(&iter, ITER_SOURCE, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+
 	/* Don't bother zerocopy for small IO (< 1024) */
 	if (clnt->trans_mod->zc_request && len > 1024) {
-		req = p9_client_zc_rpc(clnt, P9_TWRITE, NULL, &subreq->io_iter,
+		req = p9_client_zc_rpc(clnt, P9_TWRITE, NULL, &iter,
 				       0, wreq->len, P9_ZC_HDR_SZ, "dqd",
 				       fid->fid, start, len);
 	} else {
 		req = p9_client_rpc(clnt, P9_TWRITE, "dqV", fid->fid,
-				    start, len, &subreq->io_iter);
+				    start, len, &iter);
 	}
 	if (IS_ERR(req)) {
 		netfs_write_subrequest_terminated(subreq, PTR_ERR(req));


