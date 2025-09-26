Return-Path: <linux-nfs+bounces-14730-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA862BA225F
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 03:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7749716CDF8
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 01:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A58919F43A;
	Fri, 26 Sep 2025 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvk5Vim/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE9126BF7
	for <linux-nfs@vger.kernel.org>; Fri, 26 Sep 2025 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758850225; cv=none; b=lXh5zQuaQ4tb3fTjBUETu+3A5TwEMnqjQtEzCXUbJvk7OtE4iOelLs2iZefjRfebWHXo9FahdJ3xiMjSEF+bfbGL71+bpR3Jo8hnnivy7XoGrVVxxhVa2JdswPLoMaUk1f0oshAB3B49KIUxPIP4AKLcW2nXSGySCdJ2S0gqDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758850225; c=relaxed/simple;
	bh=XuMWOCf/fHvlovMPzvFLxwEIQkNCBHxlZc+3npiD6WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmwvwXRYhhDN5c17g7KlZrPNJCTXl8XHc1ob6XTROICpwLcYXt7Zc36pJqlP73g+sCjZnqAlxIJh+IFPnxKn7NsXcbrW71PMe+TJQLsK83djz5EUIFTcylF5rT1CSjy6BDjuO34uVPgcqNUdJwWZ4C/TYTsq6X6blSiYRJ1er88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvk5Vim/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B93C4CEF0;
	Fri, 26 Sep 2025 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758850224;
	bh=XuMWOCf/fHvlovMPzvFLxwEIQkNCBHxlZc+3npiD6WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvk5Vim/RRlQhFaqU3tJSNL629aKYEjA4vdIUKxGnEyBh7typ7jl68DgTkse8WBfx
	 7xOSlswQ95CDGU3mFSfCwgAsGBoJgVLK0vynkeUsnRk0jYeRABjZx40VK+EeDexiWo
	 GkLDULmGrPabq1X++TwEOcIvm9m+v1P+96ydPjX4ORzaYBBxF3Vsccv3MfGJCnrxT2
	 1JqIdAhJIgahdstGbsFad67qeZevGS7bmf3C57+E8vtSq7SBmHf8TFs6uScOIsO5X4
	 qoCS6kVx7DhWG/V3SRWiEP42Jx4+h/Pnmr/1BPnirQtOX1RtJwJXynnmEBIVGk6uPc
	 d1UKFcr3EQ8kg==
Date: Thu, 25 Sep 2025 21:30:20 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Message-ID: <aNXsrPTVHA1sRbXQ@kernel.org>
References: <20250922141137.632525-1-cel@kernel.org>
 <20250922141137.632525-4-cel@kernel.org>
 <aNMei7Ax5CbsR_Qz@kernel.org>
 <19eef754-57d9-4fe4-a6e6-a481dcec470e@kernel.org>
 <175867132212.1696783.15488731457039328170@noble.neil.brown.name>
 <60960803-80b3-4ca1-9fd3-16bc1bd1dbd4@kernel.org>
 <175869903827.1696783.17181184352630252525@noble.neil.brown.name>
 <aNP8U48TjSFmRhbD@kernel.org>
 <175884592062.1696783.9463281013443874072@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175884592062.1696783.9463281013443874072@noble.neil.brown.name>



On Fri, Sep 26, 2025 at 10:18:40AM +1000, NeilBrown wrote:
> On Thu, 25 Sep 2025, Mike Snitzer wrote:
> > On Wed, Sep 24, 2025 at 05:30:38PM +1000, NeilBrown wrote:
> > > On Wed, 24 Sep 2025, Chuck Lever wrote:
> > > > On 9/23/25 4:48 PM, NeilBrown wrote:
> > > > > On Wed, 24 Sep 2025, Chuck Lever wrote:
> > > > >> On 9/23/25 3:26 PM, Mike Snitzer wrote:
> > > > >>> On Mon, Sep 22, 2025 at 10:11:37AM -0400, Chuck Lever wrote:
> > > > >>>> From: Chuck Lever <chuck.lever@oracle.com>
> > > > >>>>
> > > > >>>> Add an experimental option that forces NFS READ operations to use
> > > > >>>> direct I/O instead of reading through the NFS server's page cache.
> > > > >>>>
> > > > >>>> There are already other layers of caching:
> > > > >>>>  - The page cache on NFS clients
> > > > >>>>  - The block device underlying the exported file system
> > > > >>>>
> > > > >>>> The server's page cache, in many cases, is unlikely to provide
> > > > >>>> additional benefit. Some benchmarks have demonstrated that the
> > > > >>>> server's page cache is actively detrimental for workloads whose
> > > > >>>> working set is larger than the server's available physical memory.
> > > > >>>>
> > > > >>>> For instance, on small NFS servers, cached NFS file content can
> > > > >>>> squeeze out local memory consumers. For large sequential workloads,
> > > > >>>> an enormous amount of data flows into and out of the page cache
> > > > >>>> and is consumed by NFS clients exactly once -- caching that data
> > > > >>>> is expensive to do and totally valueless.
> > > > >>>>
> > > > >>>> For now this is a hidden option that can be enabled on test
> > > > >>>> systems for benchmarking. In the longer term, this option might
> > > > >>>> be enabled persistently or per-export. When the exported file
> > > > >>>> system does not support direct I/O, NFSD falls back to using
> > > > >>>> either DONTCACHE or buffered I/O to fulfill NFS READ requests.
> > > > >>>>
> > > > >>>> Suggested-by: Mike Snitzer <snitzer@kernel.org>
> > > > >>>> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> > > > >>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > >>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > >>>> ---
> > > > >>>>  fs/nfsd/debugfs.c |  2 ++
> > > > >>>>  fs/nfsd/nfsd.h    |  1 +
> > > > >>>>  fs/nfsd/trace.h   |  1 +
> > > > >>>>  fs/nfsd/vfs.c     | 82 +++++++++++++++++++++++++++++++++++++++++++++++
> > > > >>>>  4 files changed, 86 insertions(+)
> > > > >>>>
> > > > >>>> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > > > >>>> index ed2b9e066206..00eb1ecef6ac 100644
> > > > >>>> --- a/fs/nfsd/debugfs.c
> > > > >>>> +++ b/fs/nfsd/debugfs.c
> > > > >>>> @@ -44,6 +44,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
> > > > >>>>   * Contents:
> > > > >>>>   *   %0: NFS READ will use buffered IO
> > > > >>>>   *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> > > > >>>> + *   %2: NFS READ will use direct IO
> > > > >>>>   *
> > > > >>>>   * This setting takes immediate effect for all NFS versions,
> > > > >>>>   * all exports, and in all NFSD net namespaces.
> > > > >>>> @@ -64,6 +65,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
> > > > >>>>  		nfsd_io_cache_read = NFSD_IO_BUFFERED;
> > > > >>>>  		break;
> > > > >>>>  	case NFSD_IO_DONTCACHE:
> > > > >>>> +	case NFSD_IO_DIRECT:
> > > > >>>>  		/*
> > > > >>>>  		 * Must disable splice_read when enabling
> > > > >>>>  		 * NFSD_IO_DONTCACHE.
> > > > >>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > > >>>> index ea87b42894dd..bdb60ee1f1a4 100644
> > > > >>>> --- a/fs/nfsd/nfsd.h
> > > > >>>> +++ b/fs/nfsd/nfsd.h
> > > > >>>> @@ -157,6 +157,7 @@ enum {
> > > > >>>>  	/* Any new NFSD_IO enum value must be added at the end */
> > > > >>>>  	NFSD_IO_BUFFERED,
> > > > >>>>  	NFSD_IO_DONTCACHE,
> > > > >>>> +	NFSD_IO_DIRECT,
> > > > >>>>  };
> > > > >>>>  
> > > > >>>>  extern u64 nfsd_io_cache_read __read_mostly;
> > > > >>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > >>>> index 6e2c8e2aab10..bfd41236aff2 100644
> > > > >>>> --- a/fs/nfsd/trace.h
> > > > >>>> +++ b/fs/nfsd/trace.h
> > > > >>>> @@ -464,6 +464,7 @@ DEFINE_EVENT(nfsd_io_class, nfsd_##name,	\
> > > > >>>>  DEFINE_NFSD_IO_EVENT(read_start);
> > > > >>>>  DEFINE_NFSD_IO_EVENT(read_splice);
> > > > >>>>  DEFINE_NFSD_IO_EVENT(read_vector);
> > > > >>>> +DEFINE_NFSD_IO_EVENT(read_direct);
> > > > >>>>  DEFINE_NFSD_IO_EVENT(read_io_done);
> > > > >>>>  DEFINE_NFSD_IO_EVENT(read_done);
> > > > >>>>  DEFINE_NFSD_IO_EVENT(write_start);
> > > > >>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > >>>> index 35880d3f1326..ddcd812f0761 100644
> > > > >>>> --- a/fs/nfsd/vfs.c
> > > > >>>> +++ b/fs/nfsd/vfs.c
> > > > >>>> @@ -1074,6 +1074,82 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > > > >>>>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
> > > > >>>>  }
> > > > >>>>  
> > > > >>>> +/*
> > > > >>>> + * The byte range of the client's READ request is expanded on both
> > > > >>>> + * ends until it meets the underlying file system's direct I/O
> > > > >>>> + * alignment requirements. After the internal read is complete, the
> > > > >>>> + * byte range of the NFS READ payload is reduced to the byte range
> > > > >>>> + * that was originally requested.
> > > > >>>> + *
> > > > >>>> + * Note that a direct read can be done only when the xdr_buf
> > > > >>>> + * containing the NFS READ reply does not already have contents in
> > > > >>>> + * its .pages array. This is due to potentially restrictive
> > > > >>>> + * alignment requirements on the read buffer. When .page_len and
> > > > >>>> + * @base are zero, the .pages array is guaranteed to be page-
> > > > >>>> + * aligned.
> > > > >>>> + */
> > > > >>>
> > > > >>> So this ^ comment (and the related conversation with Neil in a
> > > > >>> different thread) says page_len should be 0 on entry to
> > > > >>> nfsd_direct_read.
> > > > >>>
> > > > >>>> @@ -1106,6 +1182,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > > > >>>>  	switch (nfsd_io_cache_read) {
> > > > >>>>  	case NFSD_IO_BUFFERED:
> > > > >>>>  		break;
> > > > >>>> +	case NFSD_IO_DIRECT:
> > > > >>>> +		if (nf->nf_dio_read_offset_align &&
> > > > >>>> +		    rqstp->rq_res.page_len && !base)
> > > > >>>> +			return nfsd_direct_read(rqstp, fhp, nf, offset,
> > > > >>>> +						count, eof);
> > > > >>>> +		fallthrough;
> > > > >>>
> > > > >>> Yet the nfsd_iter_read is only calling nfsd_direct_read() if
> > > > >>> rqstp->rq_res.page_len is not zero, shouldn't it be
> > > > >>> !rqstp->rq_res.page_len ?
> > > > >>
> > > > >> Oops, yes. I did this work last week, while out of range of my lab.
> > > > >>
> > > > >>
> > > > >>> (testing confirms it should be !rqstp->rq_res.page_len)
> > > > >>>
> > > > >>> Hopefully with this fix you can have more confidence in staging this
> > > > >>> in your nfsd-testing?
> > > > >> I'm waiting only for Neil to send an R-b.
> > > > > 
> > > > > After noticing, like Mike, that the page_len test was inverted I went
> > > > > looking to see where page_len was updated, to be sure that a second READ
> > > > > request would not try to use DIRECT IO.
> > > > > I can see that nfsd_splice_actor() updates page_len, but I cannot see
> > > > > where it is updated when nfsd_iter_read() is used.
> > > > > 
> > > > > What am I missing?
> > > > 
> > > > It might be updated while the NFSv4 reply encoder is encoding a
> > > > COMPOUND. If the size of the RPC reply so far is larger than the
> > > > xdr_buf's .head, the xdr_stream will be positioned somewhere in the
> > > > xdr_buf's .pages array.
> > > > 
> > > > This is precisely why splice READ can be used only for the first
> > > > NFSv4 READ operation in a COMPOUND. Subsequent READ operations
> > > > must use nfsd_iter_read().
> > 
> > Hi Neil,
> >  
> > > Hmmmm...
> > > 
> > > nfsd4_encode_readv() calls xdr_reserve_space_vec() passing maxcount from
> > > the READ request.  The maxcount is passed to xdr_reserve_space()
> > > repeatedly (one page at a time) where it is added to xdr->buf->page_len
> > > (where xdr is ->rq_res_stream and xdr->buf is rq_res).
> > > 
> > > So the result is often that rq_res.page_len will be maxcount.
> > > 
> > > Then nfsd4_encode_readv() calls nfsd_iter_read() which, with this patch,
> > > will test rq_res.page_len, which will always be non-zero.
> > > So that isn't what we want.
> > 
> > Not true. (And code inspection only review like this, that then makes
> > incorrect yet strong assertions, is pretty disruptive).
> 
> What am I disrupting exactly?
> 
> I'm (implicitly?) asked to review the patch.  I do that by inspecting
> the code.  I'm not NAKing the code, I'm saying that I cannot see how it
> could work.  I'd be very happy for someone to explain how it does work. 
> We could then put that text in the commit message.

Your review found that verifying page_len to be 0 is inadequate for NFS v4+.
I had been testing/using NFS v3.

Your review is always helpful! (I held it to be less than that in the
moment because it had to be missing something.. that something was v3
vs v4 usage. We both had partial info that left us each confused).

Anyway, apologies.

> > That said, I did follow along with your code inspection, I see your
> > concern (but you do gloss over some code in xdr_get_next_encode_buffer
> > that would be cause for avoidng page_len += nbytes).
> > 
> > I'll add some tracing to pin this down.
> > 
> > > (after the read, nfsd4_encode_readv() will call xdr_truncate_encode()
> > >  which will reduce ->page_len based on how much was read).
> > > 
> > > Then nfsd4_encode_readv() calls nfsd_iter_read().
> > > 
> > > I don't think we can use ->page_len to determine if it is safe to use
> > > nfsd_direct_read().  The conditions where nfsd_direct_read() is safe are
> > > similar to the conditions where nfsd_splice_read() is safe.  Maybe we
> > > should use similar code.
> > 
> > Your takeaway from code inspection is clearly missing something
> > because page_len is 0 on entry to nfsd_iter_read for both TCP and RDMA
> > during my READ testing.
> 
> Great.  I'm glad it works.  But without understanding why it works, I
> cannot give a Reviewed-By.  Maybe it just works by accident (I've seen
> that happen before).  And if you or Chuck cannot explain why it works
> then we clearly have work to do.

My follow-up replies clarified it worked because I was using NFSv3:
https://lore.kernel.org/linux-nfs/aNQ-1OSG9Ti5XbUm@kernel.org/

