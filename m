Return-Path: <linux-nfs+bounces-15525-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A56BFDB3D
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BE71A60FA0
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3412A2E9ED1;
	Wed, 22 Oct 2025 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/BlwPEg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B58D2E9EAA
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155195; cv=none; b=kTRFH8K13lsVAjHVnC8Me0MYw9x+oZ0KdGlK0rBIAu6vIUYRgLW67MjpwlMsGUdtQwOxjaKtGzPjOd7LQmXAD8dqhtD/1jnUaHP5uV3ukzIMhRvipHmshi6QkRldt46XUwmjGflBB2frNfIgTPVaSUa3BwpqsR+VKj+1sqzEpK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155195; c=relaxed/simple;
	bh=ZyjHty/Ho74lRBzvcIt6IsW1iviJsu8txswe9k91Vx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkfmMaLRdQQDeKlfE1rgYUYOPfmj1To2VBznjsa292+VN3Fc9A5XPtpDjcnbF16G/QAO+r9kCXtCTVFqePmHGusic5SH/DjKs4awaNZIt0SCanrY70YmzNYBXomx86uofQA4OVN3lcvXZRHOOn8ik9IEasab1vvWPSDP2mK3SMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/BlwPEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E44C4CEE7;
	Wed, 22 Oct 2025 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761155194;
	bh=ZyjHty/Ho74lRBzvcIt6IsW1iviJsu8txswe9k91Vx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/BlwPEg9HMBx9IE7K4mGPa8qxKKEQdujqjdXDiGK1xRVhAOveMFU73MpfvRQ7YtT
	 7gut1j5Hpjyi3WdijL+apZ+c4/RpYlH9m6Lioj3hDibLpXiQHj6N8wvbuQ5hTbw18b
	 PrsgqrbTzQpRwgQhqJ0ip9UwZe77gse3jCGR2QtnuchYDa4Zm+OGdMor25w5JQOYRd
	 GJrdC7+HvAhycPpw8JLrr6Ldg9JcgMh03prqnZ2cpEis5poUH0ehlOs5Ii+lilDaKo
	 GIeAUH/OM7jqswMNrqXZHRDzBRMidZDziQgAVVKnI76ioYRSn8ii/DIDF8zezmFR76
	 S+he+j1EGvt3g==
Date: Wed, 22 Oct 2025 13:46:33 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Tom Talpey <tom@talpey.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Make FILE_SYNC WRITEs comply with spec
Message-ID: <aPkYedLyruWyCO0o@kernel.org>
References: <20251022162237.26727-1-cel@kernel.org>
 <63c79d16-fec8-47f2-ace3-0b8fd4f41528@talpey.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63c79d16-fec8-47f2-ace3-0b8fd4f41528@talpey.com>

On Wed, Oct 22, 2025 at 01:22:52PM -0400, Tom Talpey wrote:
> There needs to be some statement of the performance consequences of
> removing this "optimization". I'm going to predict it's significant
> on rotating media, and should not go unmeasured.

I agree that rotational storage will likely see an impact.  But
Linux's more recent (now like 14 years ago) FLUSH+FUA rework really
helped improve things -- that was a major undertaking where Christoph,
Jens and others really did a fantastic job of breathing new life into
Linux performance on modern rotational storage.

Related blast from the past: https://lwn.net/Articles/457667/

My point: may not be as grim as we think...
but there is a difference between SATA rotational storage and
"enterprise" rotational storage (e.g. NetApp or EMC fronted by
elaborate caching that is configured to report wbc=0 because they have
battery backed cache)

Mike

ps: I don't have any rotational storage to test, not it!

> The commit message needs to more bluntly state the fact that the
> server has been violating the quoted MUST. See previous paragraph.
> 
> Tom.
> 
> On 10/22/2025 12:22 PM, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Mike noted that when NFSD responds to an NFS_FILE_SYNC WRITE, it
> > does not also persist file time stamps. To wit, Section 18.32.3
> > of RFC 8881 mandates:
> > 
> > > The client specifies with the stable parameter the method of how
> > > the data is to be processed by the server. If stable is
> > > FILE_SYNC4, the server MUST commit the data written plus all file
> > > system metadata to stable storage before returning results. This
> > > corresponds to the NFSv2 protocol semantics. Any other behavior
> > > constitutes a protocol violation. If stable is DATA_SYNC4, then
> > > the server MUST commit all of the data to stable storage and
> > > enough of the metadata to retrieve the data before returning.
> > 
> > For many years, NFSD has used a "data sync only" optimization for
> > FILE_SYNC WRITEs, so file time stamps haven't been persisted as the
> > mandate above requires.
> > 
> > Reported-by: Mike Snitzer <snitzer@kernel.org>
> > Closes: https://lore.kernel.org/linux-nfs/20251018005431.3403-1-cel@kernel.org/T/#t
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >   fs/nfsd/vfs.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > This would need to be applied to nfsd-testing before the DIRECT
> > WRITE patches. I'm guessing a Cc: stable would be needed as well.
> > 
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index f537a7b4ee01..2c5d38f38454 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1315,7 +1315,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >   	init_sync_kiocb(&kiocb, file);
> >   	kiocb.ki_pos = offset;
> >   	if (stable && !fhp->fh_use_wgather)
> > -		kiocb.ki_flags |= IOCB_DSYNC;
> > +		kiocb.ki_flags |=
> > +			(stable == NFS_FILE_SYNC ? IOCB_SYNC : IOCB_DSYNC);
> >   	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> >   	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> 

