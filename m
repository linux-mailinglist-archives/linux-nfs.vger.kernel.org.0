Return-Path: <linux-nfs+bounces-23070-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ycTlJhXlS2oZcQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23070-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 19:25:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AC3713D4C
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 19:25:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GipmAJN5;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23070-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23070-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 762BD34BA7E6
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924EE39B4BC;
	Mon,  6 Jul 2026 15:28:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB2393DE6
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 15:28:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351688; cv=none; b=J4kv6ckkrisfFIGjU4O2oXL0fuyX284tfiGbjqEiktINdPtaLuWY7oSQHvq0aNSli9NwFrrvRQ0pCv3q8PDeMhG3mp56Qpx8HZnP9doAAlOFPVfYEg2scZ82WFwHbFAgPpuDerWzJNtT1MCorMUqBvRyRc4EUQtEh7q9pD91qdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351688; c=relaxed/simple;
	bh=YMYMvTJqPQ4Fbs+w7z6WLF+d+XmNDtWZbfC0Bw3opCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMGRUzVbzKM4oaJGXBwyaRILAv8UJlzRSMvVm4C2ogLABi1+Mjd6dyy3GAx8A0kiEvAz74iOrn3fpmX6dV23wbjcVmrA6paNsbdTMCfZJGoTmpbSLlOEkat85ghbxfj9EDcMsPwww6ZkjI/0HgZnQqhnac2xw1KYpwDSeDKj5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GipmAJN5; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783351685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fJgudNbA+jqSC6IQkevTiVxycA2ilRQtfmBrSyeMALc=;
	b=GipmAJN5/RCBYOUZ1PWIWBIpUOkmhVCmiJyEviRchCv+1JJ8YoXw4XwGDFaCyWMNCzQw9l
	4iLWdx6Rqc2QX8T+7tueVSEV0iTwMvtSnR1t9r/xhUxPYTRDV6E3pw6vDhG3yT9Iaobv2W
	GAjk+NXaQhXfJhu2pcuwPXjayj5J/V4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-YRAe3HkUOwmkBnBwBxH6Pw-1; Mon,
 06 Jul 2026 11:28:01 -0400
X-MC-Unique: YRAe3HkUOwmkBnBwBxH6Pw-1
X-Mimecast-MFC-AGG-ID: YRAe3HkUOwmkBnBwBxH6Pw_1783351679
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A0A91955DC0;
	Mon,  6 Jul 2026 15:27:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB32D18005B7;
	Mon,  6 Jul 2026 15:27:46 +0000 (UTC)
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
	Stefan Metzmacher <metze@samba.org>,
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
Subject: [PATCH v5 00/21] netfs: Keep track of folios in a segmented bio_vec[] chain
Date: Mon,  6 Jul 2026 16:27:15 +0100
Message-ID: <20260706152737.1231312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
	TAGGED_FROM(0.00)[bounces-23070-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:metze@samba.org,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8AC3713D4C

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
		u16			nr_slots;
		u16			max_slots;
		enum bvecq_mem		mem_type:2;
		bool			inline_bv:1;
		bool			discontig:1;
		struct bio_vec		*bv;
		struct bio_vec		__bv[];
	};

The fields are:

 (1) next, prev - Link segments together in a list.  I want this to be
     NULL-terminated linear rather than circular to make it possible to
     arbitrarily glue bits on the front.

 (2) fpos, discontig - Note the current file position of the first byte of
     the segment and whether this bvecq is discontiguous with the previous.
     When accessing the pagecache to clear flags/locks, the fpos can be
     used to look up folios by file position rather than by finding those
     folios from the info stored in the bio_vecs.

     When the file position is relevant, the model I'm working with is that
     all the segments pointed to by a single bvecq must represent
     contiguous data, but adjacent bvecqs within a chain need not be
     contiguous.  This allows a bvecq chain to be used to provide bufferage
     for a sparse read or write RPC such as can be done with Ceph.

     If a bvecq segment is not contiguous with the previous one,
     ->discontig should be set (this is technically redundant if one keeps
     track of the fpos as a bvecq chain is processed).

     Note that the beginning and end file positions in a segment need not
     be aligned to any filesystem block size.

 (3) ref - Refcount.  Each bvecq keeps a ref on the next.  I'm not sure
     this is entirely necessary, but it makes sharing slices easier.

 (4) priv - Private data for the owner.  Dispensible; currently only used
     for storing a debug ID for tracing in a patch not included here.

 (5) max_slots, nr_slots.  The size of bv[] and the number of slots used.
     I've assumed a maximum of 65535 bio_vecs in the array (which would
     represent a ~1MiB allocation).

 (6) bv, __bv, inline_bv.  bv points to the bio_vec[] array handled by
     this segment.  This may begin at __bv and if it does inline_bv should
     be set (otherwise it's impossible to distinguish a separately
     allocated bio_vec[] that follows immediately by coincidence).

 (7) mem_type.  Indicates how the memory attached to the bio_vecs should be
     disposed of when the bvecq is destroyed.  It can be one of:

	BVECQ_MEM_EXTERNAL	- Externally tracked ref; don't put
	BVECQ_MEM_PAGECACHE	- Pagecache; must be put
	BVECQ_MEM_GUP		- Pinned by from GUP; needs unpin
	BVECQ_MEM_ALLOCED	- Plain alloc'd pages; can be mempooled

     [!] I'm not sure that this is a good name for this member or for the
     	 enum values.

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
     extracting ITER_FOLIOQ is removed.

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

Changes
=======
ver #5)
- Rebase on v7.2-rc2 as that has a bunch of outstanding netfs and afs
  bugfixes included.

ver #4)
- Fixed a number of bugs reported by Sashiko[3].
  - Added a patch to fix an underflow in iov_iter_extract_xarray_pages().
  - Added a patch to fix alloc failure in iov_iter_extract_bvec_pages().
  - Added a patch to remove an unused var in kunit code.
  - Added a patch to fix the folio offset in extract_xarray_to_sg().
  - Added a patch to fix the exclusion over writeback to make it cover
    collection too.
  - Fixed double fput() in cachefiles.
  - Fixed the collection of cache writes to handle cancellation better.
  - Fixed iterate_bvecq() to skip bvecq structs with nr_slots==0.
  - Add a comment into iterate_bvecq() that a slot with bv_len>0 must have a
    valid bv_page.
  - Fixed iov_iter_bvecq_advance(), iov_iter_bvecq_revert(),
    iter_count_bvecq_pages(), iov_iter_extract_bvecq_pages() and
    extract_bvecq_to_sg() to correctly handle empty bvecqs.
  - Fixed extract_bvecq_to_sg() to be limited by iter->count.
  - Fixed bvecq_expand_buffer() to take an unsigned size param.
  - Fixed bvecq_expand_buffer() to not mix memory types in alloc'd bvecqs.
  - Fixed bvecq_shorten_buffer() occasional retention of zero-length slots.
  - Fixed slot validity check polarity in bvecq_pos_advance(); also don't use
    inner loop otherwise break then exits the wrong loop.
  - Fixed bvecq_zero(), bvecq_slice() and bvecq_extract to use a barrier when
    checking bq->nr_slots.
  - Restructured bvecq_zero() to be similar to bvecq_pos_advance().
  - Fixed an off-by-one error in bvecq_pos_step() and added a missing slot
    reset.
  - Fixed a break in netfs_extract_iter() that should have been a goto.
  - Fixed netfs_extract_iter() to limit number of pages extracted to remnant
    of max_pages.
  - Fixed an uninit var in afs_do_read_symlink().
  - Fixed netfs_read_gaps() to fill a multipart bvecq chain correctly.
  - Fixed netfs_dispatch_unbuffered_reads() to initialise collect_cursor as
    netfs_rreq_assess_dio() uses it to flush the data read.
  - Fixed netfs_extract_iter() to init the slot counter outside the extract
    loop to avoid overwriting already loaded slots.
  - Fixed callers of bvecq_delete_spent() to update bvecq_pos::slot before
    calling.
  - Fixed netfs_reissue_write() to make sure subreq->content is unset before
    setting.
  - Altered netfs_extract_iter() to free any allocated bvecq chain if no pages
    were extracted and an error occurred  (and to initialise the return
    pointer to NULL).  Also, made it return an empty bvecq if nothing was
    extracted, but no error occurred.
  - Fixed ceph_netfs_issue_read() to just return if
    ceph_netfs_issue_op_inline() returns anything other than 1 to avoid a
    double termination.
  - Fixed ceph_netfs_issue_read() to do the size calculation in the right
    order to avoid the op expanding to larger than the buffer.
  - Fixed netfs_issue_read(), in the NETFS_FILL_WITH_ZEROES case, to deduct
    subreq->len from stream->buffered rather than just setting it to 0.
  - Fixed netfs_perform_write() to put the folio if netfs_advance_writethrough()
    fails.
  - Restored the old ->prepare_write op specifically for
    fscache_write_to_cache() which is still used by Ceph.
  - Fixed undefined return in netfs_pgpriv2_issue_stream().
  - Fixed netfs_collect_write_results() to try to make sure a request isn't
    left paused if there are no further server-bound subreqs.
  - Fixed netfs_queue_wb_folio() to redirty the folio before unlocking it if
    it can't allocate a bvecq.
  - Fixed netfs_writepages() to cancel the pagecache iteration after ENOMEM.
  - Fixed netfs_advance/end_writethrough() to advance the dispatch cursor.
  - Fixed netfs_retry_read_subrequests() to use barriers when walking
    stream->subrequests as the app may add another subreq before pausing.
  - Fixed netfs_prepare_write_retry_buffer() to use ->retry_start and
    ->retry_buffered rather than ->issue_from and ->buffered.
  - Fixed netfs_retry_write_stream() to use barriers when walking
    stream->subrequests as the app may add another subreq before pausing.
  - Fixed netfs_retry_write_stream() to check the correct length when adding
    additional subreqs.
  - Fixed nfs_netfs_issue_read() to set -ENOMEM, not 0, on alloc failure.
  - Fixed nfs_netfs_issue_read() to only terminate the subreq once.
  - Fixed cifs_issue_read() to release the credits if cifs_reopen_file()
    fails.
- Rebased on v7.1.

ver #3)
- Rebased to -rc7 as the patches wouldn't apply for Christian.
- Prepended a fix for a warning from generic/464 (the problem also exists
  upstream, just not the warning).
- Renamed kmap_local_bvec() to bvec_kmap_partial() as requested by
  Christoph.
- Adjusted smbdirect patch descriptions as requested by Stefan Metzmacher.

ver #2)
- Fixed a number of bugs reported by Sashiko[1].
- Split a bunch of fixes out and posted them separately[2].

[1] https://sashiko.dev/#/patchset/20260326104544.509518-1-dhowells%40redhat.com
[2] https://lore.kernel.org/linux-fsdevel/20260512-infozentrum-becher-7f86c47c96c8@brauner/T/#t
[3] https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40redhat.com

David Howells (21):
  mm: Make readahead store folio count in readahead_control
  netfs: Bulk load the readahead-provided folios up front
  Add a function to kmap one page of a multipage bio_vec
  iov_iter: Make iov_iter_get_pages*() wrap iov_iter_extract_pages()
  iov_iter: Add a segmented queue of bio_vec[]
  netfs: Add some tools for managing bvecq chains
  netfs: Add a function to extract from an iter into a bvecq
  afs: Use a bvecq to hold dir content rather than folioq
  cifs: Use a bvecq for buffering instead of a folioq
  smbdirect: Support ITER_BVECQ in smbdirect_map_sges_from_iter()
  cachefiles: Don't rely on backing fs storage map for most use cases
  netfs: Add the cache object ID to netfs_read/write tracepoints
  netfs: Switch to using bvecq rather than folio_queue and
    rolling_buffer
  smbdirect: Remove support for ITER_FOLIOQ from
    smbdirect_map_sges_from_iter()
  netfs: Remove netfs_alloc/free_folioq_buffer()
  netfs: Remove netfs_extract_user_iter()
  iov_iter: Remove ITER_FOLIOQ
  netfs: Remove folio_queue and rolling_buffer
  netfs: Check for too much data being read
  netfs: Limit the minimum trigger for progress reporting
  netfs: Combine prepare and issue ops and grab the buffers on request

 Documentation/core-api/folio_queue.rst      |  209 ----
 Documentation/core-api/index.rst            |    1 -
 Documentation/filesystems/netfs_library.rst |    2 +-
 fs/9p/vfs_addr.c                            |   59 +-
 fs/afs/dir.c                                |   40 +-
 fs/afs/dir_edit.c                           |   43 +-
 fs/afs/dir_search.c                         |   33 +-
 fs/afs/file.c                               |   28 +-
 fs/afs/fsclient.c                           |    8 +-
 fs/afs/inode.c                              |    2 +-
 fs/afs/internal.h                           |   12 +-
 fs/afs/symlink.c                            |   35 +-
 fs/afs/write.c                              |   32 +-
 fs/afs/yfsclient.c                          |    6 +-
 fs/cachefiles/interface.c                   |   82 +-
 fs/cachefiles/internal.h                    |   13 +-
 fs/cachefiles/io.c                          |  523 +++++++---
 fs/cachefiles/namei.c                       |   19 +-
 fs/cachefiles/xattr.c                       |   24 +-
 fs/ceph/Kconfig                             |    1 +
 fs/ceph/addr.c                              |  125 ++-
 fs/netfs/Kconfig                            |    3 +
 fs/netfs/Makefile                           |    4 +-
 fs/netfs/buffered_read.c                    |  514 +++++----
 fs/netfs/buffered_write.c                   |   31 +-
 fs/netfs/bvecq.c                            |  763 ++++++++++++++
 fs/netfs/direct_read.c                      |  108 +-
 fs/netfs/direct_write.c                     |  157 +--
 fs/netfs/fscache_io.c                       |    4 +-
 fs/netfs/internal.h                         |  112 +-
 fs/netfs/iterator.c                         |  391 +++----
 fs/netfs/misc.c                             |  168 +--
 fs/netfs/objects.c                          |   22 +-
 fs/netfs/read_collect.c                     |  160 +--
 fs/netfs/read_pgpriv2.c                     |  187 ++--
 fs/netfs/read_retry.c                       |  246 +++--
 fs/netfs/read_single.c                      |  169 +--
 fs/netfs/rolling_buffer.c                   |  222 ----
 fs/netfs/stats.c                            |    6 +-
 fs/netfs/write_collect.c                    |  240 +++--
 fs/netfs/write_issue.c                      | 1042 +++++++++++--------
 fs/netfs/write_retry.c                      |  150 +--
 fs/nfs/Kconfig                              |    1 +
 fs/nfs/fscache.c                            |   17 +-
 fs/smb/client/cifsglob.h                    |    2 +-
 fs/smb/client/cifssmb.c                     |   13 +-
 fs/smb/client/file.c                        |  139 +--
 fs/smb/client/smb2ops.c                     |   82 +-
 fs/smb/client/smb2pdu.c                     |   28 +-
 fs/smb/client/transport.c                   |   15 +-
 fs/smb/smbdirect/connection.c               |  134 ++-
 include/linux/bvec.h                        |   18 +
 include/linux/bvecq.h                       |  326 ++++++
 include/linux/folio_queue.h                 |  282 -----
 include/linux/fscache.h                     |   17 +
 include/linux/iov_iter.h                    |   87 +-
 include/linux/netfs.h                       |  165 +--
 include/linux/pagemap.h                     |   10 +
 include/linux/rolling_buffer.h              |   61 --
 include/linux/uio.h                         |   17 +-
 include/trace/events/cachefiles.h           |   17 +-
 include/trace/events/netfs.h                |  155 ++-
 kernel/bpf/btf.c                            |    2 -
 lib/iov_iter.c                              |  547 +++++-----
 lib/scatterlist.c                           |   82 +-
 lib/tests/kunit_iov_iter.c                  |  135 ++-
 mm/readahead.c                              |    5 +
 net/9p/client.c                             |    8 +-
 68 files changed, 4764 insertions(+), 3597 deletions(-)
 delete mode 100644 Documentation/core-api/folio_queue.rst
 create mode 100644 fs/netfs/bvecq.c
 delete mode 100644 fs/netfs/rolling_buffer.c
 create mode 100644 include/linux/bvecq.h
 delete mode 100644 include/linux/folio_queue.h
 delete mode 100644 include/linux/rolling_buffer.h


