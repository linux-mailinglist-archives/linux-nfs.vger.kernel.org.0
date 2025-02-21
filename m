Return-Path: <linux-nfs+bounces-10265-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B204A3F8D7
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 16:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B056818966D1
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1606211479;
	Fri, 21 Feb 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptnd4uZg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9332211470
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151552; cv=none; b=Gr7eLfSxkU9TKe0rSN3HshCRZviryUj5cOnihwdVpaER3yLvFhkaT0FrAQEeh6gK/5LyV51WkA1IAnOV+a/M1BJZgiWci8Aj68+OEwewVhdDN2SKJzmaeVXkCQ8RuIn+5OdEbyL1UxhA94XkDL3cHU1LjJg9cbdkR43VIm1TS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151552; c=relaxed/simple;
	bh=feOgiAqzmL4d5jveyr+kNfvbZpal2SdNbmQWD18DH8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8j3G3ZOQ8E4+jmcqD9LRHmE5MvrKOcuIaOvu/eWRPFZQpqpm/zvqeI1FWIDk7Pdqe5eHxWCUL7zgKYLzzjms/SUIJA5fToIbUIEMdl46tX8Pn8201Vlxp6SPkD8xWuWf9VaVQsrylQOmuUCCweO7P9iyxviUevJhrfomp0gvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptnd4uZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056F8C4CED6;
	Fri, 21 Feb 2025 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740151552;
	bh=feOgiAqzmL4d5jveyr+kNfvbZpal2SdNbmQWD18DH8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ptnd4uZgmAOrqCa6FHRwkCxpI9Yl6LPLZ3Dz6qHHzy2Wg8rx5D2uAqefm0eKbB4VJ
	 1qcNhS0NQJHOWtTFx/o6W25K6nwAa2w/5zH68KajBE/OqJoHdPozaANf3S4m/WKTC3
	 d4Uw0l0dVjRsxD4qWTcW+HHw4nD9DKZIm/JGPWQLxzebLlurAM/cqAieIi/Q6UTh3r
	 IXyYZE1kxj4Zwhta8vkj9yFXT2Mw+EE+XtGe/zVn+BZZHd3u4ibsqC3AOU8lrdSa3j
	 P+i06Ud2poV+gbof97GgMsQNazoqqr2B7QXMrzdF8XoX24ti1w34M0pE0hPsB9OeyB
	 f4FMsDx1+zRMQ==
Date: Fri, 21 Feb 2025 10:25:50 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: nfsd: add the ability to enable use of RWF_DONTCACHE for all
 nfsd IO
Message-ID: <Z7ia_rXS-qk2FA3P@kernel.org>
References: <20250220171205.12092-1-snitzer@kernel.org>
 <0282e805b6cbd583acb9071862335aecd97e48bf.camel@kernel.org>
 <aa2a411a-1358-481f-b593-a3b288c45aae@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa2a411a-1358-481f-b593-a3b288c45aae@oracle.com>

On Thu, Feb 20, 2025 at 02:15:05PM -0500, Chuck Lever wrote:
> On 2/20/25 2:00 PM, Jeff Layton wrote:
> > On Thu, 2025-02-20 at 12:12 -0500, Mike Snitzer wrote:
> >> Add nfsd 'nfsd_dontcache' modparam so that "Any data read or written
> >> by nfsd will be removed from the page cache upon completion."
> >>
> >> nfsd_dontcache is disabled by default.  It may be enabled with:
> >>   echo Y > /sys/module/nfsd/parameters/nfsd_dontcache
> >>
> >> FOP_DONTCACHE must be advertised as supported by the underlying
> >> filesystem (e.g. XFS), otherwise if/when 'nfsd_dontcache' is enabled
> >> all IO will fail with -EOPNOTSUPP.
> >>
> > 
> > A little more explanation here would be good. What problem is this
> > solving? In general we don't go for tunables like this unless there is
> > just no alternative.
> > 
> > What might help me understand this is to add some documentation that
> > explains when an admin would want to enable this.
> 
> Agreed: I might know why this is interesting, since Mike and I discussed
> it during bake-a-thon. But other reviewers don't, so it would be helpful
> to provide a little more context in the patch description.

Buffered IO can bring about some serious inefficiencies due to page
reclaim -- we (at Hammerspace) have seen some really nasty pathological
cliffs (particularly with NFSD) due to buffered IO.  I agree that
all needs to be unpacked and detailed.  To be continued... ;)

But in general, Jens details the problem DONTCACHE solves in his various
commit headers associated with DONTCACHE, highlight v6.14-rc1 commits
include:

overview:
9ad6344568cc mm/filemap: change filemap_create_folio() to take a struct kiocb

read results:
8026e49bff9b mm/filemap: add read support for RWF_DONTCACHE

write results with XFS (not yet upstream):
https://git.kernel.dk/cgit/linux/commit/?h=buffered-uncached-fs.11&id=1facf34cb1b7101fa2226c1856dad651e47d916f

Mike


> 
> 
> >> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> >> ---
> >>  fs/nfsd/vfs.c | 17 ++++++++++++++++-
> >>  1 file changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >> index 29cb7b812d71..d7e49004e93d 100644
> >> --- a/fs/nfsd/vfs.c
> >> +++ b/fs/nfsd/vfs.c
> >> @@ -955,6 +955,11 @@ nfsd_open_verified(struct svc_fh *fhp, int may_flags, struct file **filp)
> >>  	return __nfsd_open(fhp, S_IFREG, may_flags, filp);
> >>  }
> >>  
> >> +static bool nfsd_dontcache __read_mostly = false;
> >> +module_param(nfsd_dontcache, bool, 0644);
> >> +MODULE_PARM_DESC(nfsd_dontcache,
> >> +		 "Any data read or written by nfsd will be removed from the page cache upon completion.");
> >> +
> >>  /*
> >>   * Grab and keep cached pages associated with a file in the svc_rqst
> >>   * so that they can be passed to the network sendmsg routines
> >> @@ -1084,6 +1089,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >>  	loff_t ppos = offset;
> >>  	struct page *page;
> >>  	ssize_t host_err;
> >> +	rwf_t flags = 0;
> >>  
> >>  	v = 0;
> >>  	total = *count;
> >> @@ -1097,9 +1103,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >>  	}
> >>  	WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_vec));
> >>  
> >> +	if (nfsd_dontcache)
> >> +		flags |= RWF_DONTCACHE;
> >> +
> >>  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> >>  	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
> >> -	host_err = vfs_iter_read(file, &iter, &ppos, 0);
> >> +	host_err = vfs_iter_read(file, &iter, &ppos, flags);
> >>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
> >>  }
> >>  
> >> @@ -1186,6 +1195,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
> >>  	if (stable && !fhp->fh_use_wgather)
> >>  		flags |= RWF_SYNC;
> >>  
> >> +	if (nfsd_dontcache)
> >> +		flags |= RWF_DONTCACHE;
> >> +
> >>  	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
> >>  	since = READ_ONCE(file->f_wb_err);
> >>  	if (verf)
> >> @@ -1237,6 +1249,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
> >>   */
> >>  bool nfsd_read_splice_ok(struct svc_rqst *rqstp)
> >>  {
> >> +	if (nfsd_dontcache) /* force the use of vfs_iter_read for reads */
> >> +		return false;
> >> +
> >>  	switch (svc_auth_flavor(rqstp)) {
> >>  	case RPC_AUTH_GSS_KRB5I:
> >>  	case RPC_AUTH_GSS_KRB5P:
> > 
> 
> 
> -- 
> Chuck Lever

