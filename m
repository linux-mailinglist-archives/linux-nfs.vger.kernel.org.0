Return-Path: <linux-nfs+bounces-13519-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADB5B1EE3F
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 20:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA76E7B3630
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 18:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468F1F2361;
	Fri,  8 Aug 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9BVrmvH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705111DA3D
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676643; cv=none; b=LSyJ9o9x9KGWFGsLhxFbEuc/q6xOl/xKbJ8G75QNY65EdQQfWe5dwJprfzLUxY3hrh4uQf05gc6H+kNrLAo4wTZN6GPM93huE7DDDbcWV9iNkIKOtftoEOcYE6Apku9VQwjhTZTtPhIaHiQTsw1LOKphQgbLIbvhM0XIlcSOh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676643; c=relaxed/simple;
	bh=rlKMUqwKdvElYnaBdFOe1xyDSyCR9idzeor4i9Ur4JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcfAFhYaFjZYa4nr1tHAa6AnCwRqrJMunEQ8zWp9PKUUy4wadT6lFcAh2RaHnPVWbFMDQmd/m4nyTMcLPgGQsuPAPbogcMYdrUIo6YD/JPzZj3kXNfFr5MFC5Sfgacfdy+JguRLBtH5Io+v063x8D3O2Lctzz+vhgqQLlvlELTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9BVrmvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58E0C4CEED;
	Fri,  8 Aug 2025 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754676643;
	bh=rlKMUqwKdvElYnaBdFOe1xyDSyCR9idzeor4i9Ur4JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i9BVrmvHTqDOH509pyfqTyWhN8sM/2e01iCvw3WOfMKi7Li54/wvPFM5zHyo+q4yK
	 3fbES/doQT1BJvjkqWPI0xqlLS6tLqHICsRliWSVoeNQwTRFB4imqdk0buxtHA3eOD
	 y+rd1YNXysD0m6FryDWQkHhGosPDoHWcjBB4/e+5WdnzER7HSmO+a5xW+JSNQfoy7G
	 vSsgjp9fy1jlmfeiQ2GB08KV/NRGg0qRBGik3aUFwxuDF2xhJbKoq+efLB5YMRgJaV
	 4mEavBX/Vx0vN6GDXdhPniDCihMtAEHHBzaQqcgdK0Fx/0/C2bQ20Pt70wKTuxbSv3
	 ty60qaP7DyYhg==
Date: Fri, 8 Aug 2025 14:10:41 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 4/7] NFSD: add io_cache_write controls to debugfs
 interface
Message-ID: <aJY9oX8Xo6vJ1lRj@kernel.org>
References: <20250807162544.17191-1-snitzer@kernel.org>
 <20250807162544.17191-5-snitzer@kernel.org>
 <bd8f7924-7d5b-431f-b90c-49f73f70619c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd8f7924-7d5b-431f-b90c-49f73f70619c@oracle.com>

On Fri, Aug 08, 2025 at 01:58:54PM -0400, Chuck Lever wrote:
> On 8/7/25 12:25 PM, Mike Snitzer wrote:
> > Add 'io_cache_write' to NFSD's debugfs interface so that: Any data
> > written by NFSD will either be:
> > - cached using page cache (NFSD_IO_BUFFERED=1)
> > - cached but removed from the page cache upon completion
> >   (NFSD_IO_DONTCACHE=2).
> > - not cached (NFSD_IO_DIRECT=3)
> > 
> > io_cache_write may be set by writing to:
> >   /sys/kernel/debug/nfsd/io_cache_write
> > 
> > If NFSD_IO_DONTCACHE is specified using 2, FOP_DONTCACHE must be
> > advertised as supported by the underlying filesystem (e.g. XFS),
> > otherwise all IO flagged with RWF_DONTCACHE will fail with
> > -EOPNOTSUPP.
> > 
> > If NFSD_IO_DIRECT is specified using 3, the IO must be aligned
> > relative to the underlying block device's logical_block_size. Also the
> > memory buffer used to store the WRITE payload must be aligned relative
> > to the underlying block device's dma_alignment.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/debugfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/nfsd.h    |  1 +
> >  fs/nfsd/vfs.c     | 16 ++++++++++++++++
> >  3 files changed, 61 insertions(+)
> > 
> > diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > index c07f71d4e84f4..872de65f0e9ac 100644
> > --- a/fs/nfsd/debugfs.c
> > +++ b/fs/nfsd/debugfs.c
> > @@ -87,6 +87,47 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
> >  DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
> >  			 nfsd_io_cache_read_set, "%llu\n");
> >  
> > +/*
> > + * /sys/kernel/debug/nfsd/io_cache_write
> > + *
> > + * Contents:
> > + *   %1: NFS WRITE will use buffered IO
> > + *   %2: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
> > + *   %3: NFS WRITE will use direct IO
> > + *
> > + * The default value of this setting is zero (UNSPECIFIED).
> > + * This setting takes immediate effect for all NFS versions,
> > + * all exports, and in all NFSD net namespaces.
> > + */
> > +
> > +static int nfsd_io_cache_write_get(void *data, u64 *val)
> > +{
> > +	*val = nfsd_io_cache_write;
> > +	return 0;
> > +}
> > +
> > +static int nfsd_io_cache_write_set(void *data, u64 val)
> > +{
> > +	int ret = 0;
> > +
> > +	switch (val) {
> > +	case NFSD_IO_BUFFERED:
> > +	case NFSD_IO_DONTCACHE:
> > +	case NFSD_IO_DIRECT:
> > +		nfsd_io_cache_write = val;
> > +		break;
> > +	default:
> > +		nfsd_io_cache_write = NFSD_IO_UNSPECIFIED;
> > +		ret = -EINVAL;
> 
> I might be wrong, but an error return should leave the setting
> untouched, IMO. Likewise for the read setting.

OK, we should get the NFSD_IO_UNSPECIFIED by default as a side-effect
of it being 0.

So _not_ explicitly setting NFSD_IO_UNSPECIFIED as
catch-all/default/error makes sense.

Will fix, thanks.

