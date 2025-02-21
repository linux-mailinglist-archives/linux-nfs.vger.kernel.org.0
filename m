Return-Path: <linux-nfs+bounces-10262-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB261A3F7F1
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 16:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BA21620FE
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB666208962;
	Fri, 21 Feb 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMphExus"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571F208960
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150134; cv=none; b=mgX1tvzD71tXbVQf5A83kU/gIum4yiZTU+JF7FhAh4OfGOy44GmkJkC4uLyFzh09uY6UcJOXUxW++W2ANy3Z1XIopwtIoyH8a7AyCNUpk9mC1VNff7F1SGNiH4QWLJLQmVtytP49mejDgJL26eKSA9ode218J1y3/H+aDlmoS2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150134; c=relaxed/simple;
	bh=BSgVNp0N3Ui1VueJuQlWrFtRuJcUkGhGKI1Syp+ouZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2PkcCQBEzyrn6OVGay+T/wAuhTCTP/dEPr9FlvXmrNkxKA6oaOTgb68KBpC9xqFSDWgZI7MbuuPtLEq6ld0SUe6ANrdf2LElasSzfIrWClPS4NgcmPErzvtC5ToIiEEjG1fS6e6vNW+V+tU/DR8CBbDNYfay9CBsrph32AmBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMphExus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F072BC4CED6;
	Fri, 21 Feb 2025 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740150134;
	bh=BSgVNp0N3Ui1VueJuQlWrFtRuJcUkGhGKI1Syp+ouZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMphExusq9IVInQwNAX6zgwFFzCoE8tk40tEhf36Uio1soOoyi/QJKHk71mtCupjc
	 6cBZOv18ygJNkw05ANIKuB2IKzdAw3ugA0QVZfxw46lhoVK88SgtvkvZpP8rnKY4BD
	 dclpIzhVTkRQ4eP8mWeH90gbkrXxelEayAVPQO3u8RyXiqWhL+3KN5tXbceC31JTV3
	 oNkeOYLu6mRcI0d1IPlZYOmxXlX82sgE8/D4eapvenUs+lkhAkpKtDmYjBnzLeoXjd
	 pAYajJAZ/XJ/GSrX/m4grPzv61vK8tkrwXb+MtaWACg2mMJcOr/DMH+Oqik05Tldiu
	 wudIF4xa8VYKg==
Date: Fri, 21 Feb 2025 10:02:12 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	axboe@kernel.dk
Subject: Re: nfsd: add the ability to enable use of RWF_DONTCACHE for all
 nfsd IO
Message-ID: <Z7iVdHcnGveg-gbg@kernel.org>
References: <20250220171205.12092-1-snitzer@kernel.org>
 <ce92e5f6-d7cb-47ef-ad96-d334212a51f1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce92e5f6-d7cb-47ef-ad96-d334212a51f1@oracle.com>

On Thu, Feb 20, 2025 at 01:17:42PM -0500, Chuck Lever wrote:
> [ Adding NFSD reviewers ... ]
> 
> On 2/20/25 12:12 PM, Mike Snitzer wrote:
> > Add nfsd 'nfsd_dontcache' modparam so that "Any data read or written
> > by nfsd will be removed from the page cache upon completion."
> > 
> > nfsd_dontcache is disabled by default.  It may be enabled with:
> >   echo Y > /sys/module/nfsd/parameters/nfsd_dontcache
> 
> A per-export setting like an export option would be nicer. Also, does
> it make sense to make it a separate control for READ and one for WRITE?
> My trick knee suggests caching read results is still going to add
> significant value, but write, not so much.

My intent was to make 6.14's DONTCACHE feature able to be tested in
the context of nfsd in a no-frills way.  I realize adding the
nfsd_dontcache knob skews toward too raw, lacks polish.  But I'm
inclined to expose such course-grained opt-in knobs to encourage
others' discovery (and answers to some of the questions you pose
below).  I also hope to enlist all NFSD reviewers' help in
categorizing/documenting where DONTCACHE helps/hurts. ;)

And I agree that ultimately per-export control is needed.  I'll take
the time to implement that, hopeful to have something more suitable in
time for LSF.

> However, to add any such administrative control, I'd like to see some
> performance numbers. I think we need to enumerate the cases (I/O types)
> that are most interesting to examine: small memory NFS servers; lots of
> small unaligned I/O; server-side CPU per byte; storage interrupt rates;
> any others?
> 
> And let's see some user/admin documentation (eg when should this setting
> be enabled? when would it be contra-indicated?)
> 
> The same arguments that applied to Cedric's request to make maximum RPC
> size a tunable setting apply here. Do we want to carry a manual setting
> for this mechanism for a long time, or do we expect that the setting can
> become automatic/uninteresting after a period of experimentation?
> 
> * It might be argued that putting these experimental tunables under /sys
>   eliminates the support longevity question, since there aren't strict
>   rules about removing files under /sys.

Right, I do think a sysfs knob (that defaults to disabled, requires
user opt-in) is a pretty useful and benign means to expose
experimental functionality.

And I agree with all you said needed above, I haven't had the time to
focus on DONTCACHE since ~Decemeber, I just picked up my old patches
from that time and decided to send the NFSD one since DONTCACHE has
been merged for 6.14.
 
> > FOP_DONTCACHE must be advertised as supported by the underlying
> > filesystem (e.g. XFS), otherwise if/when 'nfsd_dontcache' is enabled
> > all IO will fail with -EOPNOTSUPP.
> 
> It would be better all around if NFSD simply ignored the setting in the
> cases where the underlying file system doesn't implement DONTCACHE.

I'll work on making it so.

> 
> 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/vfs.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 29cb7b812d71..d7e49004e93d 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -955,6 +955,11 @@ nfsd_open_verified(struct svc_fh *fhp, int may_flags, struct file **filp)
> >  	return __nfsd_open(fhp, S_IFREG, may_flags, filp);
> >  }
> >  
> > +static bool nfsd_dontcache __read_mostly = false;
> > +module_param(nfsd_dontcache, bool, 0644);
> > +MODULE_PARM_DESC(nfsd_dontcache,
> > +		 "Any data read or written by nfsd will be removed from the page cache upon completion.");
> > +
> >  /*
> >   * Grab and keep cached pages associated with a file in the svc_rqst
> >   * so that they can be passed to the network sendmsg routines
> > @@ -1084,6 +1089,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	loff_t ppos = offset;
> >  	struct page *page;
> >  	ssize_t host_err;
> > +	rwf_t flags = 0;
> >  
> >  	v = 0;
> >  	total = *count;
> > @@ -1097,9 +1103,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	}
> >  	WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_vec));
> >  
> > +	if (nfsd_dontcache)
> > +		flags |= RWF_DONTCACHE;
> > +
> >  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> >  	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
> > -	host_err = vfs_iter_read(file, &iter, &ppos, 0);
> > +	host_err = vfs_iter_read(file, &iter, &ppos, flags);
> >  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
> >  }
> >  
> > @@ -1186,6 +1195,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
> >  	if (stable && !fhp->fh_use_wgather)
> >  		flags |= RWF_SYNC;
> >  
> > +	if (nfsd_dontcache)
> > +		flags |= RWF_DONTCACHE;
> > +
> >  	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
> >  	since = READ_ONCE(file->f_wb_err);
> >  	if (verf)
> > @@ -1237,6 +1249,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
> >   */
> >  bool nfsd_read_splice_ok(struct svc_rqst *rqstp)
> >  {
> > +	if (nfsd_dontcache) /* force the use of vfs_iter_read for reads */
> > +		return false;
> > +
> 
> Urgh.

Heh, yeah, bypassing splice was needed given dontcache hooks off vfs_iter_read.

> So I've been mulling over simply removing the splice read path.
> 
>  - Less code, less complexity, smaller test matrix
> 
>  - How much of a performance loss would result?
> 
>  - Would such a change make it easier to pass whole folios from
>    the file system directly to the network layer?

Good to know.

Thanks,
Mike

