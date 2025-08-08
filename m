Return-Path: <linux-nfs+bounces-13521-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6E7B1EE4E
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 20:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705325A3529
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99985280A3B;
	Fri,  8 Aug 2025 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwuDJU02"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A612206AF
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754677180; cv=none; b=Qw896xzjMk610QgYwuL8SHPpRsn6mKnDtcT1/6fX/kmysr/JNlfUW2QO0tdl2H3W1tq/p+uVtfSe5iGv4NbcJ73QLnrgxuCQ75mW6zyAuRc7GSfq/vtUqI4lNFtyXWIZqoyEG/QWQrcIg8UGxuvavIKrBNqlYQ8E57fihWjXX3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754677180; c=relaxed/simple;
	bh=pIoADvmtG47qgGnf1CYrNNnK87Ms5J4mH4XIDEWcsTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXQmuvf0Kg7O3dQsuAOmDi0cYK8QBa52bkk5HL7Y7HNnwrE6dyxtOhsjSCciV3Rl/HhJUH43DH4JIuPCSU1aKa3jazKTX6I/NNWYwVu/AWunPN8UgJStFzg645Rba6nhb0SCjm3Q+RrWYJMHwGEWP8NY7rVj9d3OQ6IGCyXTCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwuDJU02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB00C4CEED;
	Fri,  8 Aug 2025 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754677180;
	bh=pIoADvmtG47qgGnf1CYrNNnK87Ms5J4mH4XIDEWcsTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwuDJU02NT8J9U0cJMX607wKIOd77+Udq+uCekmAMUyNwHyGkR6397bYHYWo7Ta78
	 zQK1tETwApHxmuwgeoeoFDTujYBDOTAGq1gvN6Boq9W9T1egFPKyOb1QSzeL62TxnP
	 8rMZ18qyq8h8fb4O7+Jumk+mY+2oSLscHdEdNVz07M3ptDI2p8LkYVI1s6UbzXK1vP
	 mI/pSqUr2zlCCMzVWCcO4HIwQnYlX9ycMMLOu5SYJZV7oNI0PbyOa0TaiJ+Uf4M2J5
	 b/W3ap1dsSEd5evpP8ZNgwDwyk0j/axJFiGgTD1feD0WmjY+kG3o7qWROwh8T9MgUW
	 +XAL3/zrwrr3g==
Date: Fri, 8 Aug 2025 14:19:38 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 6/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
Message-ID: <aJY_unu7uL7h3Q4z@kernel.org>
References: <20250807162544.17191-1-snitzer@kernel.org>
 <20250807162544.17191-7-snitzer@kernel.org>
 <9df6001e-8930-4618-841a-14e1831b720d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df6001e-8930-4618-841a-14e1831b720d@oracle.com>

On Fri, Aug 08, 2025 at 01:59:47PM -0400, Chuck Lever wrote:
> On 8/7/25 12:25 PM, Mike Snitzer wrote:
> > If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
> > DIO-aligned block (on either end of the READ). The expanded READ is
> > verified to have proper offset/len (logical_block_size) and
> > dma_alignment checking.
> > 
> > Must allocate and use a bounce-buffer page (called 'start_extra_page')
> > if/when expanding the misaligned READ requires reading extra partial
> > page at the start of the READ so that its DIO-aligned. Otherwise that
> > extra page at the start will make its way back to the NFS client and
> > corruption will occur. As found, and then this fix of using an extra
> > page verified, using the 'dt' utility:
> >   dt of=/mnt/share1/dt_a.test passes=1 bs=47008 count=2 \
> >      iotype=sequential pattern=iot onerr=abort oncerr=abort
> > see: https://github.com/RobinTMiller/dt.git
> > 
> > Any misaligned READ that is less than 32K won't be expanded to be
> > DIO-aligned (this heuristic just avoids excess work, like allocating
> > start_extra_page, for smaller IO that can generally already perform
> > well using buffered IO).
> > 
> > Also add EVENT_CLASS nfsd_analyze_dio_class and use it to create
> > nfsd_analyze_read_dio and nfsd_analyze_write_dio trace events. This
> > prepares for nfsd_vfs_write() to also make use of it when handling
> > misaligned WRITEs.
> > 
> > This combination of trace events is useful:
> > 
> >  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
> >  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_read_dio/enable
> >  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
> >  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
> > 
> > Which for this dd command:
> > 
> >  dd if=/mnt/share1/test of=/dev/null bs=47008 count=2 iflag=direct
> > 
> > Results in:
> > 
> >   nfsd-23908   [010] ..... 10375.141640: nfsd_analyze_read_dio: xid=0x82c5923b fh_hash=0x857ca4fc offset=0 len=47008 start=0+0 middle=0+47008 end=47008+96
> >   nfsd-23908   [010] ..... 10375.141642: nfsd_read_vector: xid=0x82c5923b fh_hash=0x857ca4fc offset=0 len=47104
> >   nfsd-23908   [010] ..... 10375.141643: xfs_file_direct_read: dev 259:2 ino 0xc00116 disize 0x226e0 pos 0x0 bytecount 0xb800
> >   nfsd-23908   [010] ..... 10375.141773: nfsd_read_io_done: xid=0x82c5923b fh_hash=0x857ca4fc offset=0 len=47008
> > 
> >   nfsd-23908   [010] ..... 10375.142063: nfsd_analyze_read_dio: xid=0x83c5923b fh_hash=0x857ca4fc offset=47008 len=47008 start=46592+416 middle=47008+47008 end=94016+192
> >   nfsd-23908   [010] ..... 10375.142064: nfsd_read_vector: xid=0x83c5923b fh_hash=0x857ca4fc offset=46592 len=47616
> >   nfsd-23908   [010] ..... 10375.142065: xfs_file_direct_read: dev 259:2 ino 0xc00116 disize 0x226e0 pos 0xb600 bytecount 0xba00
> >   nfsd-23908   [010] ..... 10375.142103: nfsd_read_io_done: xid=0x83c5923b fh_hash=0x857ca4fc offset=47008 len=47008
> > 
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/trace.h            |  61 ++++++++++++++
> >  fs/nfsd/vfs.c              | 167 ++++++++++++++++++++++++++++++++++---
> >  include/linux/sunrpc/svc.h |   5 +-
> >  3 files changed, 221 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index a664fdf1161e9..4173bd9344b6b 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -473,6 +473,67 @@ DEFINE_NFSD_IO_EVENT(write_done);
> >  DEFINE_NFSD_IO_EVENT(commit_start);
> >  DEFINE_NFSD_IO_EVENT(commit_done);
> >  
> > +DECLARE_EVENT_CLASS(nfsd_analyze_dio_class,
> > +	TP_PROTO(struct svc_rqst *rqstp,
> > +		 struct svc_fh	*fhp,
> > +		 u64		offset,
> > +		 u32		len,
> > +		 loff_t		start,
> > +		 ssize_t	start_len,
> > +		 loff_t		middle,
> > +		 ssize_t	middle_len,
> > +		 loff_t		end,
> > +		 ssize_t	end_len),
> > +	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, end, end_len),
> > +	TP_STRUCT__entry(
> > +		__field(u32, xid)
> > +		__field(u32, fh_hash)
> > +		__field(u64, offset)
> > +		__field(u32, len)
> > +		__field(loff_t, start)
> > +		__field(ssize_t, start_len)
> > +		__field(loff_t, middle)
> > +		__field(ssize_t, middle_len)
> > +		__field(loff_t, end)
> > +		__field(ssize_t, end_len)
> > +	),
> > +	TP_fast_assign(
> > +		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> > +		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
> > +		__entry->offset = offset;
> > +		__entry->len = len;
> > +		__entry->start = start;
> > +		__entry->start_len = start_len;
> > +		__entry->middle = middle;
> > +		__entry->middle_len = middle_len;
> > +		__entry->end = end;
> > +		__entry->end_len = end_len;
> > +	),
> > +	TP_printk("xid=0x%08x fh_hash=0x%08x offset=%llu len=%u start=%llu+%lu middle=%llu+%lu end=%llu+%lu",
> > +		  __entry->xid, __entry->fh_hash,
> > +		  __entry->offset, __entry->len,
> > +		  __entry->start, __entry->start_len,
> > +		  __entry->middle, __entry->middle_len,
> > +		  __entry->end, __entry->end_len)
> > +)
> > +
> > +#define DEFINE_NFSD_ANALYZE_DIO_EVENT(name)			\
> > +DEFINE_EVENT(nfsd_analyze_dio_class, nfsd_analyze_##name##_dio,	\
> > +	TP_PROTO(struct svc_rqst *rqstp,			\
> > +		 struct svc_fh	*fhp,				\
> > +		 u64		offset,				\
> > +		 u32		len,				\
> > +		 loff_t		start,				\
> > +		 ssize_t	start_len,			\
> > +		 loff_t		middle,				\
> > +		 ssize_t	middle_len,			\
> > +		 loff_t		end,				\
> > +		 ssize_t	end_len),			\
> > +	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, end, end_len))
> > +
> > +DEFINE_NFSD_ANALYZE_DIO_EVENT(read);
> > +DEFINE_NFSD_ANALYZE_DIO_EVENT(write);
> > +
> 
> Just a random thought: usually I add new trace points at the end of
> the series to keep the deeper patches smaller.

OK, will do.

> >  DECLARE_EVENT_CLASS(nfsd_err_class,
> >  	TP_PROTO(struct svc_rqst *rqstp,
> >  		 struct svc_fh	*fhp,
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 5768244c7a3c3..be083a8812717 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/splice.h>
> >  #include <linux/falloc.h>
> >  #include <linux/fcntl.h>
> > +#include <linux/math.h>
> >  #include <linux/namei.h>
> >  #include <linux/delay.h>
> >  #include <linux/fsnotify.h>
> > @@ -1073,6 +1074,116 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
> >  }
> >  
> > +struct nfsd_read_dio {
> > +	loff_t start;
> > +	loff_t end;
> > +	unsigned long start_extra;
> > +	unsigned long end_extra;
> > +	struct page *start_extra_page;
> > +};
> > +
> > +static void init_nfsd_read_dio(struct nfsd_read_dio *read_dio)
> > +{
> > +	memset(read_dio, 0, sizeof(*read_dio));
> > +	read_dio->start_extra_page = NULL;
> > +}
> > +
> > +static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > +				  struct nfsd_file *nf, loff_t offset,
> > +				  unsigned long len, unsigned int base,
> > +				  struct nfsd_read_dio *read_dio)
> > +{
> > +	const u32 dio_blocksize = nf->nf_dio_read_offset_align;
> > +	loff_t middle_end, orig_end = offset + len;
> > +
> > +	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
> > +		      "%s: underlying filesystem has not provided DIO alignment info\n",
> > +		      __func__))
> > +		return false;
> > +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
> > +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
> > +		      __func__, dio_blocksize, PAGE_SIZE))
> > +		return false;
> > +
> > +	/* Return early if IO is irreparably misaligned
> > +	 * (len < PAGE_SIZE, or base not aligned).
> > +	 */
> > +	if (unlikely(len < dio_blocksize) ||
> > +	    ((base & (nf->nf_dio_mem_align-1)) != 0))
> > +		return false;
> > +
> > +	read_dio->start = round_down(offset, dio_blocksize);
> > +	read_dio->end = round_up(orig_end, dio_blocksize);
> > +	read_dio->start_extra = offset - read_dio->start;
> > +	read_dio->end_extra = read_dio->end - orig_end;
> > +
> > +	/* don't expand READ for IO less than 32K */
> 
> The code already says "don't expand READ for IO less than 32K". The
> comment needs to explain why. Move the rationale from the patch
> description to this comment, maybe?
> 
> 
> > +	if ((read_dio->start_extra || read_dio->end_extra) && (len < (32 << 10))) {
> > +		init_nfsd_read_dio(read_dio);
> > +		return false;
> > +	}
> 
> Nit: Let's replace the raw integer with a symbolic constant. But let's
> resist the urge to expose this as a tunable for now ;-)

Ack to both.

> > +
> > +	if (read_dio->start_extra) {
> > +		read_dio->start_extra_page = alloc_page(GFP_KERNEL);
> > +		if (WARN_ONCE(read_dio->start_extra_page == NULL,
> > +			      "%s: Unable to allocate start_extra_page\n", __func__)) {
> > +			init_nfsd_read_dio(read_dio);
> > +			return false;
> > +		}
> > +	}
> > +
> > +	/* Show original offset and count, and how it was expanded for DIO */
> > +	middle_end = read_dio->end - read_dio->end_extra;
> > +	trace_nfsd_analyze_read_dio(rqstp, fhp, offset, len,
> > +				    read_dio->start, read_dio->start_extra,
> > +				    offset, (middle_end - offset),
> > +				    middle_end, read_dio->end_extra);
> > +	return true;
> > +}
> > +
> > +static ssize_t nfsd_complete_misaligned_read_dio(struct svc_rqst *rqstp,
> > +						 struct nfsd_read_dio *read_dio,
> > +						 ssize_t bytes_read,
> > +						 unsigned long bytes_expected,
> > +						 loff_t *offset,
> > +						 unsigned long *rq_bvec_numpages)
> > +{
> > +	ssize_t host_err = bytes_read;
> > +	loff_t v;
> > +
> > +	/* If nfsd_analyze_read_dio() allocated a start_extra_page it must
> > +	 * be removed from rqstp->rq_bvec[] to avoid returning unwanted data.
> > +	 */
> > +	if (read_dio->start_extra_page) {
> > +		__free_page(read_dio->start_extra_page);
> > +		*rq_bvec_numpages -= 1;
> > +		v = *rq_bvec_numpages;
> > +		memmove(rqstp->rq_bvec, rqstp->rq_bvec + 1,
> > +			v * sizeof(struct bio_vec));
> > +	}
> > +	/* Eliminate any end_extra bytes from the last page */
> > +	v = *rq_bvec_numpages;
> > +	rqstp->rq_bvec[v].bv_len -= read_dio->end_extra;
> > +
> > +	if (host_err < 0)
> > +		return host_err;
> > +
> > +	/* nfsd_analyze_read_dio() may have expanded the start and end,
> > +	 * if so adjust returned read size to reflect original extent.
> > +	 */
> > +	*offset += read_dio->start_extra;
> > +	if (likely(host_err >= read_dio->start_extra)) {
> > +		host_err -= read_dio->start_extra;
> > +		if (host_err > bytes_expected)
> > +			host_err = bytes_expected;
> > +	} else {
> > +		/* Short read that didn't read any of requested data */
> > +		host_err = 0;
> > +	}
> > +
> > +	return host_err;
> > +}
> > +
> >  /**
> >   * nfsd_iter_read - Perform a VFS read using an iterator
> >   * @rqstp: RPC transaction context
> > @@ -1094,26 +1205,49 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  		      unsigned int base, u32 *eof)
> >  {
> >  	struct file *file = nf->nf_file;
> > -	unsigned long v, total;
> > +	unsigned long v, total, in_count = *count;
> > +	struct nfsd_read_dio read_dio;
> >  	struct iov_iter iter;
> >  	struct kiocb kiocb;
> > -	ssize_t host_err;
> > +	ssize_t host_err = 0;
> >  	size_t len;
> >  
> > +	init_nfsd_read_dio(&read_dio);
> 
> Initialize only if direct I/O is in use. I think all this new read code
> needs the same treatment as the write path: move the handling of the
> esoteric I/O types out of the hot (buffered) path.

Will try to pull that off, but the read path needs a bit more
branching, etc.  As you mentioned, splice is already the default so
nfsd_iter_read() theoretically afforded some additional lattitude
_but_ I don't disagree with the ideal of being as light as possible.

Took me a solid day to refactor the WRITE side, so this will slip
until next week.

Thanks,
Mike

