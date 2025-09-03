Return-Path: <linux-nfs+bounces-14013-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC356B42745
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D561BC2E13
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D012D47E5;
	Wed,  3 Sep 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEVykv4P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15928EA56
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918243; cv=none; b=RQ5yjoIMdpfYuvVxiMjiNwGl987gZB98N33kz82UtLfafMIfMlwYMJyLsTgal3LzawcjS8I9oAGwgZKULLXo94740xpag0E5AaXq6VIBeKVaZFCYlygQCb1sHPed5QtOOpj/8eEOxdvTSPCxLnQN+1QJReLxHP2qDVx2rP0eMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918243; c=relaxed/simple;
	bh=/nsmOGsanQI7k2Q0QfUZGLSnf9MK/mDKyhlk6eSQDPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5Nai7xB8XJTl+/8LlKYtNwoo6OZzi+Yet/i0X3pRnjvBAhoTyBSZ4KXlp8EwWfyzjYdV+rtoHEwU0cM/upApNwrZI7yzDOMscPglwtp4fZih1ltWlQcV3BxkoBYtYoMcJAjCV8nCiGQa8tMd7uj5Hm6xgR2kH0Ksy6RjuLQx80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEVykv4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6709C4CEE7;
	Wed,  3 Sep 2025 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756918242;
	bh=/nsmOGsanQI7k2Q0QfUZGLSnf9MK/mDKyhlk6eSQDPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEVykv4P00XVfaF/9tnzyXN6AiypeEe3RtuxdaCZYvInCAPV9cT17HcSEYm8VCG/M
	 HJzXbGI54SwE5+vuU4KrDxtr0ayGRnTvCXxBJD66/oiHjbHBeP1AnKIDgfN4kNreSC
	 2fgul4PDob1U0H5jOiO8U7nFkc5PX3qlaBfcVz2z9utg55LVKOkdlcR5ghZ3zJoi/w
	 3qWWInod/KyGYSJ9P7tVwpmLQlQoYtZxFJN6ZUMDT/T+A9ZZ9R+wboKsG1voRgy98z
	 tdvZ7QwkPC3IK5vHRF42U1ZzYEFVUpb1NDTC1mutuB6xhyulfw/Ph6YIiE+glvTLwK
	 xUa42abSeO3cQ==
Date: Wed, 3 Sep 2025 12:50:41 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v8 3/7] NFSD: add io_cache_read controls to debugfs
 interface
Message-ID: <aLhx4ZTOQqRetoH7@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-4-snitzer@kernel.org>
 <1c69b5dd-ec65-438f-9b9c-af8013619afa@oracle.com>
 <aLhZsfJMwsGu1eu3@kernel.org>
 <aLhmnwNasNnZIew1@kernel.org>
 <b514a3b1-ae0e-4803-81e3-ef2d1de18a6d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b514a3b1-ae0e-4803-81e3-ef2d1de18a6d@oracle.com>

On Wed, Sep 03, 2025 at 12:12:10PM -0400, Chuck Lever wrote:
> On 9/3/25 12:02 PM, Mike Snitzer wrote:
> > On Wed, Sep 03, 2025 at 11:07:29AM -0400, Mike Snitzer wrote:
> >> On Wed, Sep 03, 2025 at 10:38:45AM -0400, Chuck Lever wrote:
> > 
> >>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> >>>> index 1cd0bed57bc2f..6ef799405145f 100644
> >>>> --- a/fs/nfsd/nfsd.h
> >>>> +++ b/fs/nfsd/nfsd.h
> >>>> @@ -153,6 +153,15 @@ static inline void nfsd_debugfs_exit(void) {}
> >>>>  
> >>>>  extern bool nfsd_disable_splice_read __read_mostly;
> >>>>  
> >>>> +enum {
> >>>> +	NFSD_IO_UNSPECIFIED = 0,
> >>>> +	NFSD_IO_BUFFERED,
> >>>> +	NFSD_IO_DONTCACHE,
> >>>> +	NFSD_IO_DIRECT,
> >>>> +};
> >>>> +
> >>>> +extern u64 nfsd_io_cache_read __read_mostly;
> >>>
> >>> And then here, initialize nfsd_io_cache_read to reflect the default
> >>> behavior. That would be NFSD_IO_BUFFERED for now... then later we might
> >>> want to change it to NFSD_IO_DIRECT, for instance.
> >>>
> >>> Same suggestion for 4/7.
> >>
> >> Ah ok, I can see the way forward to default to NFSD_IO_BUFFERED but
> >> _not_ default to it when erroring (if the user specified some unknown
> >> value).
> >>
> >> I'll run with that (despite just asking Jeff's opinion above, I'm the
> >> one who came up with the awkward UNSPECIFIED state when honoring
> >> Jeff's early feedback).
> > 
> > Here is the incremental diff (these changes will be folded into
> > appropriate patches in v9):
> > 
> > diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > index 8878c3519b30c..173032a04cdec 100644
> > --- a/fs/nfsd/debugfs.c
> > +++ b/fs/nfsd/debugfs.c
> > @@ -43,11 +43,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
> >   * /sys/kernel/debug/nfsd/io_cache_read
> >   *
> >   * Contents:
> > - *   %1: NFS READ will use buffered IO
> > - *   %2: NFS READ will use dontcache (buffered IO w/ dropbehind)
> > - *   %3: NFS READ will use direct IO
> > + *   %0: NFS READ will use buffered IO
> > + *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> > + *   %2: NFS READ will use direct IO
> >   *
> > - * The default value of this setting is zero (UNSPECIFIED).
> >   * This setting takes immediate effect for all NFS versions,
> >   * all exports, and in all NFSD net namespaces.
> >   */
> > @@ -90,11 +89,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
> >   * /sys/kernel/debug/nfsd/io_cache_write
> >   *
> >   * Contents:
> > - *   %1: NFS WRITE will use buffered IO
> > - *   %2: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
> > - *   %3: NFS WRITE will use direct IO
> > + *   %0: NFS WRITE will use buffered IO
> > + *   %1: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
> > + *   %2: NFS WRITE will use direct IO
> >   *
> > - * The default value of this setting is zero (UNSPECIFIED).
> >   * This setting takes immediate effect for all NFS versions,
> >   * all exports, and in all NFSD net namespaces.
> >   */
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index fe935b4cda538..412a1e9a2a876 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -154,8 +154,7 @@ static inline void nfsd_debugfs_exit(void) {}
> >  extern bool nfsd_disable_splice_read __read_mostly;
> >  
> >  enum {
> > -	NFSD_IO_UNSPECIFIED = 0,
> > -	NFSD_IO_BUFFERED,
> > +	NFSD_IO_BUFFERED = 0,
> 
> Thanks, this LGTM. Two additional remarks:
> 
> 1. I think that the "= 0" is unneeded here because C enumerators always
> start at 0.

It does, I flip-flopped on removing the "= 0" and left it (thinking
was it'd help dissuade others from inserting new enum values at the
beginning).  But rather than do that I can just add a comment.
 
> 2. I'm wondering if this enum definition should be moved to a uapi
> header. Thoughts? This is experimental, and not a fixed API. So maybe
> it needs to stay in fs/nfsd/nfsd.h.
> 
> (I'm probably going over ground that has already been covered.)

Don't think this aspect was covered, yes my thinking was this is an
experimental interface that wasn't appropriate to expose in a uapi
header.

> 
> >  	NFSD_IO_DONTCACHE,
> >  	NFSD_IO_DIRECT,
> >  };
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 5e700a0d6b12e..403076443573f 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -50,8 +50,8 @@
> >  #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
> >  
> >  bool nfsd_disable_splice_read __read_mostly;
> > -u64 nfsd_io_cache_read __read_mostly;
> > -u64 nfsd_io_cache_write __read_mostly;
> > +u64 nfsd_io_cache_read __read_mostly = NFSD_IO_BUFFERED;
> > +u64 nfsd_io_cache_write __read_mostly = NFSD_IO_BUFFERED;
> >  
> >  /**
> >   * nfserrno - Map Linux errnos to NFS errnos
> > @@ -1272,8 +1272,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  		break;
> >  	case NFSD_IO_DONTCACHE:
> >  		kiocb.ki_flags = IOCB_DONTCACHE;
> > -		fallthrough;
> > -	case NFSD_IO_UNSPECIFIED:
> > +		break;
> >  	case NFSD_IO_BUFFERED:
> >  		break;
> >  	}
> > @@ -1605,8 +1604,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  		break;
> >  	case NFSD_IO_DONTCACHE:
> >  		kiocb.ki_flags |= IOCB_DONTCACHE;
> > -		fallthrough;
> > -	case NFSD_IO_UNSPECIFIED:
> > +		fallthrough; /* must call nfsd_issue_write_buffered */
> 
> Right. In this case, the NFSD_IO_BUFFERED arm is more than just a
> "break;" so, not as brittle as the nfsd_iter_read() switch statement.
> The comment is helpful, though; I'm not suggesting a change, just
> observing.

Sure.

Thanks,
Mike

