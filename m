Return-Path: <linux-nfs+bounces-15339-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F92BE91E7
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 16:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D861AA2268
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D406032C95E;
	Fri, 17 Oct 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKX4jLwz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F532C95B
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710396; cv=none; b=VqXbEMefIYroo/BGfHpHaRoEu7BGo+m+onuhlFMMX+adbOog4q02S+Ci8iI8EYlWhBPrvbFxWGPs5OJ1scraxBF80aLLhieoHAVo50XPBKGEbe19DVxmR3gorzAR0jP/e1MaiB08fSbn2EZy5qjrMnsFbi1D/rruW0xXN5pwn08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710396; c=relaxed/simple;
	bh=W+iyA5FZQD5GYKoFFozDRGTQSrz6ZHuX1yyoKkCLyrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frhlHGQ2bxIx5gTRYSbojkGJ24uPeZYCIQKWqvWX9GkqpaSdKxAdnYc6IceFHkAfxAmJ04fzzVr14rM53rEjUHgI7czJBM7IJsY0jBmzqYJPV1wsScqArOMywc3B5kML65CH5VwnFGANZycj/8eaWOiP2qV+1Fg1E+rs25nfrKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKX4jLwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4757C4CEF9;
	Fri, 17 Oct 2025 14:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760710396;
	bh=W+iyA5FZQD5GYKoFFozDRGTQSrz6ZHuX1yyoKkCLyrc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FKX4jLwz3o2DHbprQ6Qa4BADznSKzc/BzBU3uRPR51wUVLwyQKk5cMGlSwzF1odj7
	 MOlECgBLnaQLCYq1/Hrn3eUOMFoBaH+gTzJag+IYqR849qEfTM/k/ckmhAEx31r35D
	 Vx9q8m77iSKOGBg3IJYiYyhBBuwbo5WA77gzdXl4B+1wi+CdWJO6dOAnd09xfHpbpF
	 KW15VxF+8RO/ZFVJ+0Nq163pVVK5fdqTYnz2UlbaMc6+YRTtVlwPbFZ24QaTsnNgkU
	 t5/qT95yIa3LNvvQ5ksQ6zrrytBup+pI+xLBn+2WajDuMMJ7NTtA4Lj7c+oBthg3yY
	 0THPWJwiR9n6Q==
Message-ID: <2e353615-bb40-437b-83ea-e541493f026c@kernel.org>
Date: Fri, 17 Oct 2025 10:13:14 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251013190113.252097-1-cel@kernel.org>
 <aPAci7O_XK1ljaum@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPAci7O_XK1ljaum@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/25 6:13 PM, Mike Snitzer wrote:
> If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> middle and end as needed. The large middle extent is DIO-aligned and
> the start and/or end are misaligned. Synchronous buffered IO (with
> preference towards using DONTCACHE) is used for the misaligned extents
> and O_DIRECT is used for the middle DIO-aligned extent.
> 
> nfsd_issue_write_dio() promotes @stable_how to NFS_FILE_SYNC, which
> allows the client to drop its dirty data and avoid needing an extra
> COMMIT operation.
> 
> If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
> invalidate the page cache on behalf of the DIO WRITE, then
> nfsd_issue_write_dio() will fall back to using buffered IO.
> 
> These changes served as the original starting point for the NFS
> client's misaligned O_DIRECT support that landed with commit
> c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and
> WRITE"). But NFSD's support is simpler because it currently doesn't
> use AIO completion.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>

Handful of nits, and one interesting question. Please send a v4 to
address the two comment issues below.

Question: How is NFSD supposed to act if the administrator sets the
async export option and NFSD_IO_DIRECT at the same time?

- Direct I/O dispatched but not waited for ?

- Fall back to DONTCACHE ?

- Ignore the async setting (that's what it appears to do now) ?

- Something else ?

IMO async + DIRECT seems like a disaster waiting to happen. It should
be pretty easy to push the NFS server over a cliff because there is no
connection between clients submitting writes and data getting persisted.
Dirty data will just pile up in the server's memory because it can't get
flushed fast enough.

Synchronous direct I/O has a very strong connection between how fast
persistent storage can go and how fast clients can push more writes.


> ---
>  fs/nfsd/debugfs.c |   1 +
>  fs/nfsd/trace.h   |   1 +
>  fs/nfsd/vfs.c     | 218 ++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 215 insertions(+), 5 deletions(-)
> 
> Changes since v2:
> - rebased ontop of "[PATCH v1] NFSD: Enable return of an updated stable_how to NFS clients"
> - set both IOCB_DSYNC and IOCB_SYNC (rather than just IOCB_SYNC) in nfsd_issue_write_dio()
> - update nfsd_issue_write_dio() to promote @stable_how to NFS_FILE_SYNC
> - push call to trace_nfsd_write_direct down from nfsd_direct_write to nfsd_issue_write_dio 
> - fix comment block style to have naked '/*' on first line
> 
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index 00eb1ecef6ac..7f44689e0a53 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -108,6 +108,7 @@ static int nfsd_io_cache_write_set(void *data, u64 val)
>  	switch (val) {
>  	case NFSD_IO_BUFFERED:
>  	case NFSD_IO_DONTCACHE:
> +	case NFSD_IO_DIRECT:
>  		nfsd_io_cache_write = val;
>  		break;
>  	default:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index bfd41236aff2..ad74439d0105 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -469,6 +469,7 @@ DEFINE_NFSD_IO_EVENT(read_io_done);
>  DEFINE_NFSD_IO_EVENT(read_done);
>  DEFINE_NFSD_IO_EVENT(write_start);
>  DEFINE_NFSD_IO_EVENT(write_opened);
> +DEFINE_NFSD_IO_EVENT(write_direct);
>  DEFINE_NFSD_IO_EVENT(write_io_done);
>  DEFINE_NFSD_IO_EVENT(write_done);
>  DEFINE_NFSD_IO_EVENT(commit_start);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index a3dee33a7233..ba7cb698ac68 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1253,6 +1253,210 @@ static int wait_for_concurrent_writes(struct file *file)
>  	return err;
>  }
>  
> +struct nfsd_write_dio {
> +	ssize_t	start_len;	/* Length for misaligned first extent */
> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> +	ssize_t	end_len;	/* Length for misaligned last extent */
> +};
> +
> +static bool
> +nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
> +		       struct nfsd_file *nf, struct nfsd_write_dio *write_dio)
> +{
> +	const u32 dio_blocksize = nf->nf_dio_offset_align;
> +	loff_t start_end, orig_end, middle_end;
> +
> +	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
> +		return false;
> +	if (unlikely(dio_blocksize > PAGE_SIZE))
> +		return false;
> +	if (unlikely(len < dio_blocksize))
> +		return false;
> +
> +	start_end = round_up(offset, dio_blocksize);
> +	orig_end = offset + len;
> +	middle_end = round_down(orig_end, dio_blocksize);
> +
> +	write_dio->start_len = start_end - offset;
> +	write_dio->middle_len = middle_end - start_end;
> +	write_dio->end_len = orig_end - middle_end;
> +
> +	return true;
> +}
> +
> +static bool nfsd_iov_iter_aligned_bvec(const struct iov_iter *i,
> +		unsigned int addr_mask, unsigned int len_mask)

IIRC you had mentioned that there is possibly a generic utility
function that does this that we could adopt here. If we are going
to keep this one in spite of having a generic, it needs a comment
explaining why we're not using the generic version.


> +{
> +	const struct bio_vec *bvec = i->bvec;
> +	size_t skip = i->iov_offset;
> +	size_t size = i->count;
> +
> +	if (size & len_mask)
> +		return false;
> +	do {
> +		size_t len = bvec->bv_len;
> +
> +		if (len > size)
> +			len = size;
> +		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> +			return false;
> +		bvec++;
> +		size -= len;
> +		skip = 0;
> +	} while (size);
> +
> +	return true;
> +}
> +
> +/*
> + * Setup as many as 3 iov_iter based on extents described by @write_dio.
> + * Returns the number of iov_iter that were setup.
> + */
> +static int
> +nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
> +			   struct bio_vec *rq_bvec, unsigned int nvecs,
> +			   unsigned long cnt, struct nfsd_write_dio *write_dio,
> +			   struct nfsd_file *nf)
> +{
> +	int n_iters = 0;
> +	struct iov_iter *iters = *iterp;
> +
> +	/* Setup misaligned start? */
> +	if (write_dio->start_len) {
> +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> +		iters[n_iters].count = write_dio->start_len;
> +		iter_is_dio_aligned[n_iters] = false;
> +		++n_iters;
> +	}
> +
> +	/* Setup DIO-aligned middle */
> +	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> +	if (write_dio->start_len)
> +		iov_iter_advance(&iters[n_iters], write_dio->start_len);
> +	iters[n_iters].count -= write_dio->end_len;
> +	iter_is_dio_aligned[n_iters] =
> +		nfsd_iov_iter_aligned_bvec(&iters[n_iters],
> +				nf->nf_dio_mem_align-1, nf->nf_dio_offset_align-1);
> +	if (unlikely(!iter_is_dio_aligned[n_iters]))
> +		return 0; /* no DIO-aligned IO possible */
> +	++n_iters;
> +
> +	/* Setup misaligned end? */
> +	if (write_dio->end_len) {
> +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> +		iov_iter_advance(&iters[n_iters],
> +				 write_dio->start_len + write_dio->middle_len);
> +		iter_is_dio_aligned[n_iters] = false;
> +		++n_iters;
> +	}
> +
> +	return n_iters;
> +}
> +
> +static int
> +nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
> +		    unsigned int nvecs, unsigned long *cnt,
> +		    struct kiocb *kiocb)
> +{
> +	struct iov_iter iter;
> +	int host_err;
> +
> +	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> +	host_err = vfs_iocb_iter_write(file, kiocb, &iter);
> +	if (host_err < 0)
> +		return host_err;
> +	*cnt = host_err;
> +
> +	return 0;
> +}
> +
> +static int
> +nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
> +		     u32 *stable_how, unsigned int nvecs, unsigned long *cnt,
> +		     struct kiocb *kiocb, struct nfsd_write_dio *write_dio)
> +{
> +	struct file *file = nf->nf_file;
> +	bool iter_is_dio_aligned[3];
> +	struct iov_iter iter_stack[3];
> +	struct iov_iter *iter = iter_stack;
> +	unsigned int n_iters = 0;
> +	unsigned long in_count = *cnt;
> +	loff_t in_offset = kiocb->ki_pos;
> +	ssize_t host_err;
> +
> +	n_iters = nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
> +				rqstp->rq_bvec, nvecs, *cnt, write_dio, nf);
> +	if (unlikely(!n_iters))
> +		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
> +
> +	trace_nfsd_write_direct(rqstp, fhp, in_offset, in_count);
> +
> +	/*
> +	 * Any buffered IO issued here will be misaligned, use
> +	 * sync IO to ensure it has completed before returning.
> +	 * Also update @stable_how to avoid need for COMMIT.
> +	 */
> +	kiocb->ki_flags |= (IOCB_DSYNC|IOCB_SYNC);
> +	*stable_how = NFS_FILE_SYNC;
> +
> +	*cnt = 0;
> +	for (int i = 0; i < n_iters; i++) {
> +		if (iter_is_dio_aligned[i])
> +			kiocb->ki_flags |= IOCB_DIRECT;
> +		else
> +			kiocb->ki_flags &= ~IOCB_DIRECT;
> +
> +		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
> +		if (host_err < 0) {
> +			/*
> +			 * VFS will return -ENOTBLK if DIO WRITE fails to
> +			 * invalidate the page cache. Retry using buffered IO.
> +			 */

I'm debating with myself whether, now that NFSD is using DIO, nfserrno
should get a mapping from ENOTBLK to nfserr_serverfault or nfserr_io,
simply as a defensive measure.

I kind of like the idea that we get a warning in nfserrno: "hey, I
didn't expect ENOTBLK here" so I'm leaning towards leaving it as is
for now.


> +			if (unlikely(host_err == -ENOTBLK)) {
> +				kiocb->ki_flags &= ~IOCB_DIRECT;
> +				*cnt = in_count;
> +				kiocb->ki_pos = in_offset;
> +				return nfsd_buffered_write(rqstp, file,
> +							   nvecs, cnt, kiocb);
> +			} else if (unlikely(host_err == -EINVAL)) {
> +				struct inode *inode = d_inode(fhp->fh_dentry);
> +
> +				pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%ld\n",
> +						    inode->i_sb->s_id, inode->i_ino);
> +				host_err = -ESERVERFAULT;
> +			}
> +			return host_err;
> +		}
> +		*cnt += host_err;
> +		if (host_err < iter[i].count) /* partial write? */
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
> +static noinline_for_stack int
> +nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		  struct nfsd_file *nf, u32 *stable_how, unsigned int nvecs,
> +		  unsigned long *cnt, struct kiocb *kiocb)
> +{
> +	struct nfsd_write_dio write_dio;
> +
> +	/*
> +	 * Check if IOCB_DONTCACHE can be used when issuing buffered IO;
> +	 * if so, set it to preserve intent of NFSD_IO_DIRECT (it will
> +	 * be ignored for any DIO issued here).
> +	 */
> +	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> +		kiocb->ki_flags |= IOCB_DONTCACHE;
> +
> +	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, nf, &write_dio))
> +		return nfsd_issue_write_dio(rqstp, fhp, nf, stable_how, nvecs,
> +					    cnt, kiocb, &write_dio);
> +
> +	return nfsd_buffered_write(rqstp, nf->nf_file, nvecs, cnt, kiocb);
> +}
> +
>  /**
>   * nfsd_vfs_write - write data to an already-open file
>   * @rqstp: RPC execution context
> @@ -1281,7 +1485,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	u32			stable = *stable_how;
>  	struct kiocb		kiocb;
>  	struct svc_export	*exp;
> -	struct iov_iter		iter;
>  	errseq_t		since;
>  	__be32			nfserr;
>  	int			host_err;
> @@ -1318,25 +1521,30 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		kiocb.ki_flags |= IOCB_DSYNC;
>  
>  	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> -	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> +
>  	since = READ_ONCE(file->f_wb_err);
>  	if (verf)
>  		nfsd_copy_write_verifier(verf, nn);
>  
>  	switch (nfsd_io_cache_write) {
> -	case NFSD_IO_BUFFERED:
> +	case NFSD_IO_DIRECT:
> +		host_err = nfsd_direct_write(rqstp, fhp, nf, stable_how,
> +					     nvecs, cnt, &kiocb);
> +		stable = *stable_how;
>  		break;
>  	case NFSD_IO_DONTCACHE:
>  		if (file->f_op->fop_flags & FOP_DONTCACHE)
>  			kiocb.ki_flags |= IOCB_DONTCACHE;
> +		fallthrough; /* must call nfsd_buffered_write */

I'm not clear what purpose this comment serves. The fallthrough
already states what's going to happen next.


> +	case NFSD_IO_BUFFERED:
> +		host_err = nfsd_buffered_write(rqstp, file,
> +					       nvecs, cnt, &kiocb);
>  		break;
>  	}
> -	host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
>  	if (host_err < 0) {
>  		commit_reset_write_verifier(nn, rqstp, host_err);
>  		goto out_nfserr;
>  	}
> -	*cnt = host_err;
>  	nfsd_stats_io_write_add(nn, exp, *cnt);
>  	fsnotify_modify(file);
>  	host_err = filemap_check_wb_err(file->f_mapping, since);


-- 
Chuck Lever

