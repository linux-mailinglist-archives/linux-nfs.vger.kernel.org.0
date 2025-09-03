Return-Path: <linux-nfs+bounces-14008-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C05CB42467
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 17:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3D394E45E2
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93E020408A;
	Wed,  3 Sep 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejzOxO9r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D81E3DF8
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912050; cv=none; b=hUA3IdtNEw+W+W2aKXxZ22+L1EJgVZpmNHPW6UTuru7ZpKvlUHTGATuvH8n8x4hNzhgsKaauv7KAhi5gZOJRjCrP/13z3gjue0lvmN0lJASY0P128zpoySkt4Qu/u1hPsyIwVuEJHLNE9hvBOANzMVwRhKXoG+Lxj0/B09+b+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912050; c=relaxed/simple;
	bh=pbTRCcZA3a3itNlRULDzCzaLuQYMchAg4WiPRG6S79A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjwkCXs1H5iswHVEXh2OwGy7b6Q9wvDTUuLXGMKsnKHgvmfGmKwb1lcahGoyC0v6PhGwIjnzwiLqYf3Y7Z/Ap8MhoC928g87zdl41H1Aot5oQZTY1SQ6Ln3slgzqP9zk0rSV75U9Yl6cbuDCTBrpw7VBS1dUFDDNRNO6jkgw12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejzOxO9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8ACC4CEE7;
	Wed,  3 Sep 2025 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756912050;
	bh=pbTRCcZA3a3itNlRULDzCzaLuQYMchAg4WiPRG6S79A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejzOxO9rLfzBsiIXlAlxx3LmAVKwjC9BmVbE4KTUOg/0b14sqjsRVffggjGBa6nVe
	 I2gEQFmerJTpKlwlNL+75R5dyHY1bM3ZW4BB1OGcAEjI2IsTeqRDuN7FGTYgt8wCM/
	 udVlI9dly8sQouJx1+qjmVGxMkZX+ocvqggk0ibYVpEjS9+1vgqVC9XRZaCCjsZqjl
	 APy/UFVvPuRBUlwbKUZrvUsAyMLTac+c9L7AO/3t6flzB9KGQ/kLrN8Sd0eW84Dfv2
	 3d/XdL5i71odaznkxc5OOEtHbVg6/c0io8OVov3eMEUPW5yfGdBW6ewpyind9Dv2lU
	 x+QZkch1zyTxw==
Date: Wed, 3 Sep 2025 11:07:29 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v8 3/7] NFSD: add io_cache_read controls to debugfs
 interface
Message-ID: <aLhZsfJMwsGu1eu3@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-4-snitzer@kernel.org>
 <1c69b5dd-ec65-438f-9b9c-af8013619afa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c69b5dd-ec65-438f-9b9c-af8013619afa@oracle.com>

On Wed, Sep 03, 2025 at 10:38:45AM -0400, Chuck Lever wrote:
> On 8/26/25 2:57 PM, Mike Snitzer wrote:
> > Add 'io_cache_read' to NFSD's debugfs interface so that: Any data
> > read by NFSD will either be:
> > - cached using page cache (NFSD_IO_BUFFERED=1)
> > - cached but removed from the page cache upon completion
> >   (NFSD_IO_DONTCACHE=2).
> > - not cached (NFSD_IO_DIRECT=3)
> > 
> > io_cache_read may be set by writing to:
> >   /sys/kernel/debug/nfsd/io_cache_read
> > 
> > If NFSD_IO_DONTCACHE is specified using 2, FOP_DONTCACHE must be
> > advertised as supported by the underlying filesystem (e.g. XFS),
> > otherwise all IO flagged with RWF_DONTCACHE will fail with
> > -EOPNOTSUPP.
> > 
> > If NFSD_IO_DIRECT is specified using 3, the IO must be aligned
> > relative to the underlying block device's logical_block_size. Also the
> > memory buffer used to store the read must be aligned relative to the
> > underlying block device's dma_alignment.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/debugfs.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/nfsd.h    |  9 ++++++++
> >  fs/nfsd/vfs.c     | 18 +++++++++++++++
> >  3 files changed, 84 insertions(+)
> > 
> > diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > index 84b0c8b559dc9..3cadd45868b48 100644
> > --- a/fs/nfsd/debugfs.c
> > +++ b/fs/nfsd/debugfs.c
> > @@ -27,11 +27,65 @@ static int nfsd_dsr_get(void *data, u64 *val)
> >  static int nfsd_dsr_set(void *data, u64 val)
> >  {
> >  	nfsd_disable_splice_read = (val > 0) ? true : false;
> > +	if (!nfsd_disable_splice_read) {
> > +		/*
> > +		 * Cannot use NFSD_IO_DONTCACHE or NFSD_IO_DIRECT
> > +		 * if splice_read is enabled.
> > +		 */
> > +		nfsd_io_cache_read = NFSD_IO_BUFFERED;
> > +	}
> >  	return 0;
> >  }
> >  
> >  DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
> >  
> > +/*
> > + * /sys/kernel/debug/nfsd/io_cache_read
> > + *
> > + * Contents:
> > + *   %1: NFS READ will use buffered IO
> > + *   %2: NFS READ will use dontcache (buffered IO w/ dropbehind)
> > + *   %3: NFS READ will use direct IO
> > + *
> > + * The default value of this setting is zero (UNSPECIFIED).
> 
> Hi Mike -
> 
> I can't remember why we have the UNSPECIFIED setting? IME a debug
> file reflects the current setting, so if our default behavior is
> "buffered" then the first "cat io_cache_read" should reflect that
> rather than "I haven't been changed yet". This doesn't seem like the
> usual semantics of a /sys/kernel/debug file, IME.

Jeff had convincing justification for his request, from:
https://lore.kernel.org/linux-nfs/e5a0d1e435196c55acbdc491b43b6380cbef5599.camel@kernel.org/

"I think the default case should leave nfsd_io_cache_read alone and
return an error. If we add new values later, and someone tries to use
them on an old kernel, it's better to make that attempt error out.

Ditto for the write side controls."

> For example, a user space application may want to read io_cache_read
> to find out what the current behavior is. If it gets 0 (UNSPECIFIED)
> then it has found out nothing.

Right, that is a negative user experience until/unless user is
informed.  Having Documentation file may ease that though?
 
> However, if there is a good reason to keep UNSPECIFIED, then you
> need to add a "  %0: NFS READ uses the default behavior" to the
> documenting comment for nfsd_io_cache_{read,write}.
> 
> My preference is to remove NFSD_IO_UNSPECIFIED from this patch
> and her sister (4/7).

I don't have a strong preference, when I first implemented it I had it
how you'd prefer.  But Jeff's kernel downgrade scenario still seems
like a prophetic nice catch.

Jeff, what is your thinking at this point?

> > + * This setting takes immediate effect for all NFS versions,
> > + * all exports, and in all NFSD net namespaces.
> > + */
> > +
> > +static int nfsd_io_cache_read_get(void *data, u64 *val)
> > +{
> > +	*val = nfsd_io_cache_read;
> > +	return 0;
> > +}
> > +
> > +static int nfsd_io_cache_read_set(void *data, u64 val)
> > +{
> > +	int ret = 0;
> > +
> > +	switch (val) {
> > +	case NFSD_IO_BUFFERED:
> > +		nfsd_io_cache_read = NFSD_IO_BUFFERED;
> > +		break;
> > +	case NFSD_IO_DONTCACHE:
> > +	case NFSD_IO_DIRECT:
> > +		/*
> > +		 * Must disable splice_read when enabling
> > +		 * NFSD_IO_DONTCACHE or NFSD_IO_DIRECT.
> > +		 */
> > +		nfsd_disable_splice_read = true;
> > +		nfsd_io_cache_read = val;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
> > +			 nfsd_io_cache_read_set, "%llu\n");
> > +
> >  void nfsd_debugfs_exit(void)
> >  {
> >  	debugfs_remove_recursive(nfsd_top_dir);
> > @@ -44,4 +98,7 @@ void nfsd_debugfs_init(void)
> >  
> >  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
> >  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
> > +
> > +	debugfs_create_file("io_cache_read", S_IWUSR | S_IRUGO,
> > +			    nfsd_top_dir, NULL, &nfsd_io_cache_read_fops);
> >  }
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 1cd0bed57bc2f..6ef799405145f 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -153,6 +153,15 @@ static inline void nfsd_debugfs_exit(void) {}
> >  
> >  extern bool nfsd_disable_splice_read __read_mostly;
> >  
> > +enum {
> > +	NFSD_IO_UNSPECIFIED = 0,
> > +	NFSD_IO_BUFFERED,
> > +	NFSD_IO_DONTCACHE,
> > +	NFSD_IO_DIRECT,
> > +};
> > +
> > +extern u64 nfsd_io_cache_read __read_mostly;
> 
> And then here, initialize nfsd_io_cache_read to reflect the default
> behavior. That would be NFSD_IO_BUFFERED for now... then later we might
> want to change it to NFSD_IO_DIRECT, for instance.
> 
> Same suggestion for 4/7.

Ah ok, I can see the way forward to default to NFSD_IO_BUFFERED but
_not_ default to it when erroring (if the user specified some unknown
value).

I'll run with that (despite just asking Jeff's opinion above, I'm the
one who came up with the awkward UNSPECIFIED state when honoring
Jeff's early feedback).

> > +
> >  extern int nfsd_max_blksize;
> >  
> >  static inline int nfsd_v4client(struct svc_rqst *rq)
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 79439ad93880a..8ea8b80097195 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -49,6 +49,7 @@
> >  #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
> >  
> >  bool nfsd_disable_splice_read __read_mostly;
> > +u64 nfsd_io_cache_read __read_mostly;
> >  
> >  /**
> >   * nfserrno - Map Linux errnos to NFS errnos
> > @@ -1099,6 +1100,23 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	size_t len;
> >  
> >  	init_sync_kiocb(&kiocb, file);
> > +
> > +	switch (nfsd_io_cache_read) {
> > +	case NFSD_IO_DIRECT:
> > +		/* Verify ondisk and memory DIO alignment */
> > +		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
> > +		    (((offset | *count) & (nf->nf_dio_read_offset_align - 1)) == 0) &&
> > +		    (base & (nf->nf_dio_mem_align - 1)) == 0)
> > +			kiocb.ki_flags = IOCB_DIRECT;
> > +		break;
> > +	case NFSD_IO_DONTCACHE:
> > +		kiocb.ki_flags = IOCB_DONTCACHE;
> > +		fallthrough;
> 
> Nit: Make this "break;". This is brittle: if someone adds something to
> the NFSD_IO_BUFFERED arm but happens to miss that the DONTCACHE arm
> above it is "fallthrough" then we have a latent bug.
> 
> Same suggestion for 4/7.

Sure, but just FYI, the misaligned DIO WRITE patch does need
fallthrough from NFSD_IO_DONTCACHE to NFSD_IO_BUFFERED:

        case NFSD_IO_DONTCACHE:
                kiocb.ki_flags |= IOCB_DONTCACHE;
                fallthrough;
        case NFSD_IO_UNSPECIFIED:
        case NFSD_IO_BUFFERED:
+               host_err = nfsd_issue_write_buffered(rqstp, file,
+                                               nvecs, cnt, &kiocb);
                break;
        }

But rather than preemptively lay the foundation for that in 4/7 I'll
just be explicit in that 6/7 patch.


