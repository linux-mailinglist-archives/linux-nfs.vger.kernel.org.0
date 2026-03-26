Return-Path: <linux-nfs+bounces-20398-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCJzEKcQxWkI6AQAu9opvQ
	(envelope-from <linux-nfs+bounces-20398-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 11:55:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 981F6333D61
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 11:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3105E3078C25
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAAC3890FD;
	Thu, 26 Mar 2026 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJd6hKCI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3B383C7C
	for <linux-nfs@vger.kernel.org>; Thu, 26 Mar 2026 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521974; cv=none; b=TbHnErjm13bVEhDMrc6NldV2BpeR6H+ufDBvIEPrMzXS+bKvelZIYEl6cVex0yA89clEJDMrDWTAGV9bGLpBFvgz4VYNYW+axWrkaFq1F1hrTKjC+yGGgqrAiGD4z5dTnEQvDIE2DxezksiwnOExQfgl70uClEjtrdlTIlrLRXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521974; c=relaxed/simple;
	bh=4HKk9ZJneo7yqa9sC78F9NzNtzyserlOTVs/NLobrIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/Ccqk8GcQ2/oUo7MOXyU7s023zlKqJOv+Rlo2cUBdmjzPjFERjhT5rAUCE6qmRN0LgRCaurUM2JD/va6gagOenSCQMaYZr5VmwQrLsyJU/3iLh3irgOXAmUDdiy7goSN56cuGDsiUlQr01PQI2Aj/Bl1DwAhJZInJL1QDl3qLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJd6hKCI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774521970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I/AwaHoW8Vm6LNELS+H4YAEvj2gOr1h8Aehnm4TULKw=;
	b=AJd6hKCIGjvv9QPjbRI/PPYSoLHkrXNpkx7SYC85bbrvopSdHFvoTJTD0tPHAUCvMsh5uR
	0qd3+h6rf3VkDPdsr9HXRH5eEqtmEm/ctjFcGMCQ2jB30hO1V7JwDKiVE72ahAG4a0GckP
	lAu7Tmj6QFx++jwzxK98ENU5msmuFNs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-TtKMj9N8PJSjl2tFmZuZHQ-1; Thu,
 26 Mar 2026 06:46:07 -0400
X-MC-Unique: TtKMj9N8PJSjl2tFmZuZHQ-1
X-Mimecast-MFC-AGG-ID: TtKMj9N8PJSjl2tFmZuZHQ_1774521964
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19D0119560AE;
	Thu, 26 Mar 2026 10:46:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00A7E19560B1;
	Thu, 26 Mar 2026 10:45:53 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/26] netfs: Keep track of folios in a segmented bio_vec[] chain
Date: Thu, 26 Mar 2026 10:45:15 +0000
Message-ID: <20260326104544.509518-1-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20398-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 981F6333D61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Christian,

Could you add these patches to the VFS tree for next?

The patches get rid of folio_queue, rolling_buffer and ITER_FOLIOQ,
replacing the folio queue construct used to manage buffers in netfslib with
one based around a segmented chain of bio_vec arrays instead.  There are
three main aims here:

 (1) The kernel file I/O subsystem seems to be moving towards consolidating
     on the use of bio_vec arrays, so embrace this by moving netfslib to
     keep track of its buffers for buffered I/O in bio_vec[] form.

 (2) Netfslib already uses a bio_vec[] to handle unbuffered/DIO, so the
     number of different buffering schemes used can be reduced to just a
     single one.

 (3) Always send an entire filesystem RPC request message to a TCP socket
     with single kernel_sendmsg() call as this is faster, more efficient
     and doesn't require the use of corking as it puts the entire
     transmission loop inside of a single tcp_sendmsg().

For the replacement of folio_queue, a segmented chain of bio_vec arrays
rather than a single monolithic array is provided:

	struct bvecq {
		struct bvecq		*next;
		struct bvecq		*prev;
		unsigned long long	fpos;
		refcount_t		ref;
		u32			priv;
		u16			nr_segs;
		u16			max_segs;
		bool			inline_bv:1;
		bool			free:1;
		bool			unpin:1;
		bool			discontig:1;
		struct bio_vec		*bv;
		struct bio_vec		__bv[];
	};

The fields are:

 (1) next, prev - Link segments together in a list.  I want this to be
     NULL-terminated linear rather than circular to make it possible to
     arbitrarily glue bits on the front.

 (2) fpos, discontig - Note the current file position of the first byte of
     the segment; all the bio_vecs in ->bv[] must be contiguous in the file
     space.  The fpos can be used to find the folio by file position rather
     then from the info in the bio_vec.

     If there's a discontiguity, this should break over into a new bvecq
     segment with the discontig flag set (though this is redundant if you
     keep track of the file position).  Note that the beginning and end
     file positions in a segment need not be aligned to any filesystem
     block size.

 (3) ref - Refcount.  Each bvecq keeps a ref on the next.  I'm not sure
     this is entirely necessary, but it makes sharing slices easier.

 (4) priv - Private data for the owner.  Dispensible; currently only used
     for storing a debug ID for tracing in a patch not included here.

 (5) max_segs, nr_segs.  The size of bv[] and the number of elements used.
     I've assumed a maximum of 65535 bio_vecs in the array (which would
     represent a ~1MiB allocation).

 (6) bv, __bv, inline_bv.  bv points to the bio_vec[] array handled by
     this segment.  This may begin at __bv and if it does inline_bv should
     be set (otherwise it's impossible to distinguish a separately
     allocated bio_vec[] that follows immediately by coincidence).

 (7) free, unpin.  free is set if the memory pointed to by the bio_vecs
     needs freeing in some way upon I/O completion.  unpin is set if this
     means using GUP unpinning rather than put_page().

I've also defined an iov_iter iterator type ITER_BVECQ to walk this sort of
construct so that it can be passed directly to sendmsg() or block-based DIO
(as cachefiles does).


This series makes the following changes to netfslib:

 (1) The folio_queue chain used to hold folios for buffered I/O is replaced
     with a bvecq chain.  Each bio_vec then holds (a portion of) one folio.
     Each bvecq holds a contiguous sequence of folios, but adjacent bvecqs
     in a chain may be discontiguous.

 (2) For unbuffered/DIO, the source iov_iter is extracted into a bvecq
     chain.

 (3) An abstract position representation ('bvecq_pos') is created that can
     used to hold a position in a bvecq chain.  For the moment, this takes
     a ref on the bvecq it points to, but that may be excessive.

 (4) Buffer tracking is managed with three cursors:  The load_cursor, at
     which new folios are added as we go; the dispatch_cursor, at which new
     subrequests' buffers start when they're created; and the
     collect_cursor, the point at which folios are being unlocked.

     Not all cursors are necessarily needed in all situations and during
     buffered writeback, we need a dispatch cursor per stream (one for the
     network filesystem and one for the cache).

 (5) ->prepare_read(), buffer setting up and ->issue_read() are merged, as
     are the write variants, with the filesystem calling back up to
     netfslib to prepare its buffer.  This simplifies the process of
     setting up a subrequest.  It may even make sense to have the
     filesystem allocate the subrequest.

 (6) Retry dispatch tracking is added to netfs_io_request so that the
     buffer preparation functions can find it.  Retry requires an
     additional buffer cursor.

 (7) Netfslib dispatches I/O by accumulating enough bufferage to dispatch
     at least one subrequest, then looping to generate as many as the
     filesystem wants to (they may be limited by other constraints,
     e.g. max RDMA segment count or negotiated max size).  This loop could
     be moved down into the filesystem.  A new method is provided by which
     netfslib can ask the filesystem to provide an estimate of the data
     that should be accumulated before dispatch begins.

 (8) Reading from the cache is now managed by querying the cache to provide
     a list of the next two data extents within the cache.

 (9) AFS directories are switched to using a bvecq rather than a
     folio_queue to hold their contents.

(10) CIFS is switch to using a bvecq rather than a folio_queue for holding
     a temporary encryption buffer.

(11) CIFS RDMA is given the ability to extract ITER_BVECQ and support for
     extracting ITER_FOLIOQ, ITER_BVEC and ITER_KVEC is removed.

(12) All the folio_queue and rolling_buffer code is removed.

Cachefiles is also modified:

 (1) The object type in the cachefiles file xattr is now correctly set to
     CACHEFILES_CONTENT_{SINGLE,ALL,BACKFS_MAP} rather than just being 0,
     to indicate whether we have a single monolithic blob, all the data up
     to cache i_size with no holes or a sparse file with the data mapped by
     the backing file system (as currently upstream).

 (2) For "ALL" type files, the cache's i_size is used to track how much
     data is saved in the cache and no longer bears any relation to the
     netfs i_size.  The actual object size is stored in the xattr.

 (3) For most typical files which are contiguous and written progressively,
     the object type is now set to "ALL".  For anything else, cachefiles
     uses SEEK_DATA/HOLE to find extent outlines at before (this is the
     current behaviour and needs to be fixed, but in a separate set of
     patches as it's not trivial).

Two further things that I'm working on (but not in this branch) are:

 (1) Make it so that a filesystem can be given a copy of a subchain which
     it can then tack header and trailer protocol elements upon to form a
     single message (I have this working for cifs) and even join copies
     together with intervening protocol elements to form compounds.

 (2) Make it so that a filesystem can 'splice' out the contents of the TCP
     receive queue into a bvecq chain.  This allows the socket lock to be
     dropped much more quickly and the copying of data read to the
     destination buffers to happen without the lock.  I have this working
     for cifs too.  Kernel recvmsg() doesn't then block kernel sendmsg()
     for anywhere near as long.

There are also some things I want to consider for the future:

 (1) Create one or more batched iteration functions to 'unlock' all the
     folios in a bio_vec[], where 'unlock' is the appropriate action for
     ending a read or a write.  Batching should hopefully also improve the
     efficiency of wrangling the marks on the xarray.  Very often these
     marks are going to be represented by contiguous bits, so there may be
     a way to change them in bulk.

 (2) Rather than walking the bvecq chain to get each individual folio out
     via bv_page, use the file position stored on the bvecq and the sum of
     bv_len to iterate over the appropriate range in i_pages.

 (3) Change iov_iter to store the initial starting point and for
     iov_iter_revert() to reset to that and advance.  This would (a) help
     prevent over-reversion and (b) dispense with the need for a prev
     pointer.

 (4) Use bvecq to replace scatterlist.  One problem with replacing
     scatterlist is that crypto drivers like to glue bits on the front of
     the scatterlists they're given (something trivial with that API) - and
     this is one way to achieve it.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-next

Thanks,
David

David Howells (22):
  netfs: Fix read abandonment during retry
  netfs: Fix the handling of stream->front by removing it
  cachefiles: Fix excess dput() after end_removing()
  cachefiles: Don't rely on backing fs storage map for most use cases
  mm: Make readahead store folio count in readahead_control
  netfs: Bulk load the readahead-provided folios up front
  Add a function to kmap one page of a multipage bio_vec
  iov_iter: Add a segmented queue of bio_vec[]
  netfs: Add some tools for managing bvecq chains
  netfs: Add a function to extract from an iter into a bvecq
  afs: Use a bvecq to hold dir content rather than folioq
  cifs: Use a bvecq for buffering instead of a folioq
  cifs: Support ITER_BVECQ in smb_extract_iter_to_rdma()
  netfs: Switch to using bvecq rather than folio_queue and
    rolling_buffer
  cifs: Remove support for ITER_KVEC/BVEC/FOLIOQ from
    smb_extract_iter_to_rdma()
  netfs: Remove netfs_alloc/free_folioq_buffer()
  netfs: Remove netfs_extract_user_iter()
  iov_iter: Remove ITER_FOLIOQ
  netfs: Remove folio_queue and rolling_buffer
  netfs: Check for too much data being read
  netfs: Limit the the minimum trigger for progress reporting
  netfs: Combine prepare and issue ops and grab the buffers on request

Deepanshu Kartikey (2):
  netfs: Fix NULL pointer dereference in netfs_unbuffered_write() on
    retry
  netfs: Fix kernel BUG in netfs_limit_iter() for ITER_KVEC iterators

Paulo Alcantara (1):
  netfs: fix error handling in netfs_extract_user_iter()

Viacheslav Dubeyko (1):
  netfs: fix VM_BUG_ON_FOLIO() issue in netfs_write_begin() call

 Documentation/core-api/folio_queue.rst | 209 ------
 Documentation/core-api/index.rst       |   1 -
 fs/9p/vfs_addr.c                       |  49 +-
 fs/afs/dir.c                           |  43 +-
 fs/afs/dir_edit.c                      |  43 +-
 fs/afs/dir_search.c                    |  33 +-
 fs/afs/file.c                          |  27 +-
 fs/afs/fsclient.c                      |   8 +-
 fs/afs/inode.c                         |  20 +-
 fs/afs/internal.h                      |  14 +-
 fs/afs/write.c                         |  35 +-
 fs/afs/yfsclient.c                     |   6 +-
 fs/cachefiles/interface.c              |  82 +-
 fs/cachefiles/internal.h               |  10 +-
 fs/cachefiles/io.c                     | 486 ++++++++----
 fs/cachefiles/namei.c                  |  55 +-
 fs/cachefiles/xattr.c                  |  20 +-
 fs/ceph/Kconfig                        |   1 +
 fs/ceph/addr.c                         | 127 ++--
 fs/netfs/Kconfig                       |   3 +
 fs/netfs/Makefile                      |   4 +-
 fs/netfs/buffered_read.c               | 524 ++++++++-----
 fs/netfs/buffered_write.c              |  30 +-
 fs/netfs/bvecq.c                       | 706 ++++++++++++++++++
 fs/netfs/direct_read.c                 | 119 ++-
 fs/netfs/direct_write.c                | 174 +++--
 fs/netfs/fscache_io.c                  |   6 -
 fs/netfs/internal.h                    |  89 ++-
 fs/netfs/iterator.c                    | 305 +++-----
 fs/netfs/misc.c                        | 147 +---
 fs/netfs/objects.c                     |  21 +-
 fs/netfs/read_collect.c                | 134 ++--
 fs/netfs/read_pgpriv2.c                | 168 +++--
 fs/netfs/read_retry.c                  | 227 +++---
 fs/netfs/read_single.c                 | 170 +++--
 fs/netfs/rolling_buffer.c              | 222 ------
 fs/netfs/stats.c                       |   6 +-
 fs/netfs/write_collect.c               | 126 +++-
 fs/netfs/write_issue.c                 | 987 ++++++++++++++-----------
 fs/netfs/write_retry.c                 | 135 ++--
 fs/nfs/Kconfig                         |   1 +
 fs/nfs/fscache.c                       |  24 +-
 fs/smb/client/cifsglob.h               |   2 +-
 fs/smb/client/cifssmb.c                |  13 +-
 fs/smb/client/file.c                   | 146 ++--
 fs/smb/client/smb2ops.c                |  78 +-
 fs/smb/client/smb2pdu.c                |  28 +-
 fs/smb/client/smbdirect.c              | 152 +---
 fs/smb/client/transport.c              |  15 +-
 include/linux/bvec.h                   |  21 +
 include/linux/bvecq.h                  | 205 +++++
 include/linux/folio_queue.h            | 282 -------
 include/linux/fscache.h                |  17 +
 include/linux/iov_iter.h               |  68 +-
 include/linux/netfs.h                  | 145 ++--
 include/linux/pagemap.h                |   1 +
 include/linux/rolling_buffer.h         |  61 --
 include/linux/uio.h                    |  17 +-
 include/trace/events/cachefiles.h      |  17 +-
 include/trace/events/netfs.h           | 123 ++-
 lib/iov_iter.c                         | 395 +++++-----
 lib/scatterlist.c                      |  57 +-
 lib/tests/kunit_iov_iter.c             | 185 ++---
 mm/readahead.c                         |   4 +
 net/9p/client.c                        |   8 +-
 65 files changed, 4144 insertions(+), 3493 deletions(-)
 delete mode 100644 Documentation/core-api/folio_queue.rst
 create mode 100644 fs/netfs/bvecq.c
 delete mode 100644 fs/netfs/rolling_buffer.c
 create mode 100644 include/linux/bvecq.h
 delete mode 100644 include/linux/folio_queue.h
 delete mode 100644 include/linux/rolling_buffer.h


