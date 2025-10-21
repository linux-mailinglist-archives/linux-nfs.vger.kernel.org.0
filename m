Return-Path: <linux-nfs+bounces-15448-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFE1BF6028
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 13:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B92E3A2F15
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CCF2F7467;
	Tue, 21 Oct 2025 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U058MkHL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B142F549B
	for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045885; cv=none; b=bUyTiXYDLBio1/UzTNarhNZUMkgHRPxBo2qVIkuNa9HTZjSaO3j4ErF/5ZEi9V+tjA2v6Wtf1oMYQ1+kul/KaDPc2+OdrBZTZ+ry+xApZZcm40NTdn+9bdu4VI5lYV5emsluCvnZXgQuAfPnNfUsZmHcGD6yPUp1xScN22CEdBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045885; c=relaxed/simple;
	bh=VpMPfzKLpW3/HM1ZlgN4q2Uli7kAn8mYCKhvfTB7mno=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jH/dApKH2B9xMaS2turw3Zj4iltFvzdq/k5467H8Rmkarrh8+toEHlLqpcAJkBZ3pD+fyxD2TPc3etaEO+8tedwSP6pjmQK3Lur5+R74hFGwKrNpgcUmjGUQ0pyVKmNcB/0GXEb7KXZ3tTQesHb8+X03A8DS23w/slN2G/JW4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U058MkHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C35C4CEF5;
	Tue, 21 Oct 2025 11:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761045884;
	bh=VpMPfzKLpW3/HM1ZlgN4q2Uli7kAn8mYCKhvfTB7mno=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U058MkHLXNE+uyxNxu/jBLLVT6rWD2waQ3YIC/fdUEZv54RCg86OZTlxU9CoJ1pKx
	 NwyRcWmlrwYX/EC2Z+eGXKuCWeLMOO7Al8uO6X285TQIbCOOMAXMUrpSPuVfAuudxj
	 kYUkOEJWGOgCRWvNDlRpRO7DvCLoBjYzMZQ3GOTs8gtNHCAYxN6711slDG9s9h633/
	 AXpqNtK0+wf1bC11c1ntoIcnOrlIEdc6u0Sc/62/WE64kV+nbDuDKw/fLbjYC3gH87
	 bF8J0pQoznG4ezbRG6BALECCXEMwDgQgjJ66MBvq/44uajoSu/wthkY2Zp6s2E++/l
	 +5xmkFly3bx4Q==
Message-ID: <a5f3911ae6b65c70e1fd897bdd4f3e651decb196.camel@kernel.org>
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
From: Jeff Layton <jlayton@kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Mike Snitzer	 <snitzer@kernel.org>
Date: Tue, 21 Oct 2025 07:24:42 -0400
In-Reply-To: <aPXihwGTiA7bqTsN@infradead.org>
References: <20251018005431.3403-1-cel@kernel.org>
	 <20251018005431.3403-3-cel@kernel.org> <aPXihwGTiA7bqTsN@infradead.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 00:19 -0700, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 08:54:30PM -0400, Chuck Lever wrote:
> > From: Mike Snitzer <snitzer@kernel.org>
> >=20
> > If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> > middle and end as needed. The large middle extent is DIO-aligned and
> > the start and/or end are misaligned. Synchronous buffered IO (with
> > preference towards using DONTCACHE) is used for the misaligned extents
> > and O_DIRECT is used for the middle DIO-aligned extent.
>=20
> Can you define synchronous better here?  The term is unfortunately
> overloaded between synchronous syscalls vs aio/io_uring and O_(D)SYNC
> style I/O.  As of now I don't understand which one you mean, especially
> with the DONTCACHE reference thrown in, but I guess I'll figure it out
> reading the patch.
>=20
> > If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
> > invalidate the page cache on behalf of the DIO WRITE, then
> > nfsd_issue_write_dio() will fall back to using buffered IO.
>=20
> Did you see -ENOTBLK leaking out of the file systems?  Because at
> least for iomap it is supposed to be an indication that the
> file system ->write_iter handler needs to retry using buffered
> I/O and never leak to the caller.
>=20
> > These changes served as the original starting point for the NFS
> > client's misaligned O_DIRECT support that landed with
> > commit c817248fc831 ("nfs/localio: add proper O_DIRECT support for
> > READ and WRITE"). But NFSD's support is simpler because it currently
> > doesn't use AIO completion.
>=20
> I don't understand this paragraph.  What does starting point mean
> here?  How does it matter for the patch description?
>=20
> > +struct nfsd_write_dio {
> > +     ssize_t start_len;      /* Length for misaligned first extent */
> > +     ssize_t middle_len;     /* Length for DIO-aligned middle extent *=
/
> > +     ssize_t end_len;        /* Length for misaligned last extent */
> > +};
>=20
> Looking at how the code is structured later on, it seems like it would
> work much better if each of these sections had it's own object with
> the len, iov_iter, flag if it's aligned, etc.  Otherwise we have this
> structure and lots of arrays of three items passed around.
>=20
> > +static bool
> > +nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr=
_mask,
> > +                        unsigned int len_mask)
>=20
> Wouldn't it make sense to track the alignment when building the bio_vec
> array instead of doing another walk here touching all cache lines?
>=20
> > +	if (unlikely(dio_blocksize > PAGE_SIZE))
> > +		return false;
>=20
> Why does this matter?  Can you add a comment explaining it?
>=20
> > +static int
> > +nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
> > +		    unsigned int nvecs, unsigned long *cnt,
> > +		    struct kiocb *kiocb)
> > +{
> > +	struct iov_iter iter;
> > +	int host_err;
> > +
> > +	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> > +	host_err =3D vfs_iocb_iter_write(file, kiocb, &iter);
> > +	if (host_err < 0)
> > +		return host_err;
> > +	*cnt =3D host_err;
> > +
> > +	return 0;
>=20
>=20
> Nothing really buffered here per se, it's just a small wrapper
> around vfs_iocb_iter_write.
>=20
> > +	/*
> > +	 * Any buffered IO issued here will be misaligned, use
> > +	 * sync IO to ensure it has completed before returning.
> > +	 * Also update @stable_how to avoid need for COMMIT.
> > +	 */
> > +	kiocb->ki_flags |=3D (IOCB_DSYNC | IOCB_SYNC);
>=20
> What do you mean with completed before returning?  I guess you
> mean writeback actually happening, right?  Why do you need that,
> why do you also force it for the direct I/O?
>=20
> Also IOCB_SYNC is wrong here, as the only thing it does over
> IOCB_DSYNC is also forcing back of metadata not needed to find
> data (aka timestamps), which I can't see any need for here.
>=20

Responding to a WRITE with NFS_FILE_SYNC flag set means that the data
the client wrote is now on stable storage (and hence the client doesn't
need to follow up with a COMMIT). This patch is using DIO for the
aligned middle section but any unaligned ends use buffered I/O. If we
want to return NFS_FILE_SYNC here then all of the data and metadata
need to be on disk when the reply goes out.

Don't we need IOCB_SYNC here in this case? Otherwise, the server could
crash while the metadata is still in memory. When it comes back up, the
client could see stale timestamps. Maybe that's not fatal, but it seems
pretty sketchy.


> > +	*stable_how =3D NFS_FILE_SYNC;
> > +
> > +	*cnt =3D 0;
> > +	for (int i =3D 0; i < n_iters; i++) {
> > +		if (iter_is_dio_aligned[i])
> > +			kiocb->ki_flags |=3D IOCB_DIRECT;
> > +		else
> > +			kiocb->ki_flags &=3D ~IOCB_DIRECT;
> > +
> > +		host_err =3D vfs_iocb_iter_write(file, kiocb, &iter[i]);
> > +		if (host_err < 0) {
> > +			/*
> > +			 * VFS will return -ENOTBLK if DIO WRITE fails to
> > +			 * invalidate the page cache. Retry using buffered IO.
> > +			 */
> > +			if (unlikely(host_err =3D=3D -ENOTBLK)) {
>=20
> The VFS certainly does not, and if it leaks out of a specific file
> system we need to fix that.
>=20
> > +			} else if (unlikely(host_err =3D=3D -EINVAL)) {
> > +				struct inode *inode =3D d_inode(fhp->fh_dentry);
> > +
> > +				pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%ld\=
n",
> > +						    inode->i_sb->s_id, inode->i_ino);
> > +				host_err =3D -ESERVERFAULT;
>=20
> -EINVAL can be lot more things than alignment failure.   And more
> importantly alignment failures should not happen with the proper
> checks in place.

--=20
Jeff Layton <jlayton@kernel.org>

