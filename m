Return-Path: <linux-nfs+bounces-14079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA95B4602C
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 19:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCB9A60D44
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B10C296BC9;
	Fri,  5 Sep 2025 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnl3OC4N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BEE4D599
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093535; cv=none; b=AlZbSjSLPQEIgxa9eM3OYeLQINH5KiybuUuTN94PlfWfmZ/bCnNUTk0LZdaxwCswupzYyDaOZMNyZ563Xm+AIHNLORvA7V57q4Cz8/ize5dLaon7YtK22K9oBngZWMD8a24DqsFQhT7WV/lhPKZdLCAA9/odvW6OAgHqPTrwIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093535; c=relaxed/simple;
	bh=mq1oU47e01auEHWg+bfhQsDmUMyhQ1lKxIxzEJXSSz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUylU+bNPvNCaqAnjwSBSwIDRG3+6b+xEuxHjTdTjU+jx4zUd1LOM1PEiIekNnVZB1iNDEEijIpGFp0l6OvmRgZvbcJ+OxoAGvstVq0mcr3QLj8Rl8z3DT8kpkVdWVGe7BS1XivyoaoyUTThdDEjFSwdKpjawMTPk17fdGhgJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnl3OC4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561F1C4CEF1;
	Fri,  5 Sep 2025 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757093534;
	bh=mq1oU47e01auEHWg+bfhQsDmUMyhQ1lKxIxzEJXSSz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mnl3OC4N0oSiFEnuuPRCLPuF9yuPaMchFHBhGFz5etnL1yX9mJcDrBVybxgBuN9By
	 ureiNTz2DhWlS6T2cf7LvgSkV3to/SLp9rQHWeoe+pDsqukQX1u9oeB/GCBYhymlLM
	 92Ot/plhyWo7qGuRal9iLE2bBLUs6oWAfE5IQB38/9+Sn1Bw3bAH6nnO1j49rKghK9
	 zwKT7zXyZeQB13uOClK8xbVOL4AAODX0sbcNzq39QB9DoCV2hvva/M+mZX7IUXIDbQ
	 VICqjalHqXWbpeC3mDHvFXRDR0QxgDylEPgSvba7suePQKDmuO7vCK+yAc157NTKPz
	 lhdFrgOlvkE8A==
Date: Fri, 5 Sep 2025 13:32:13 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: NFSD: Add io_cache_{read,write} controls to debugfs
Message-ID: <aLseneIE3Mubr5uV@kernel.org>
References: <20250905145509.8678-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905145509.8678-1-cel@kernel.org>

On Fri, Sep 05, 2025 at 10:55:09AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>

Aside from attribution, which I suspect you didn't intend to switch
these changes from being attributed to me, this looks good (one small
nit below).

> Add 'io_cache_read' to NFSD's debugfs interface so that any data
> read by NFSD will either be:
> - cached using page cache (NFSD_IO_BUFFERED=0)
> - cached but removed from the page cache upon completion
>   (NFSD_IO_DONTCACHE=1).
> 
> io_cache_read may be set by writing to:
>   /sys/kernel/debug/nfsd/io_cache_read
> 
> Add 'io_cache_write' to NFSD's debugfs interface so that any data
> written by NFSD will either be:
> - cached using page cache (NFSD_IO_BUFFERED=0)
> - cached but removed from the page cache upon completion
>   (NFSD_IO_DONTCACHE=1).
> 
> io_cache_write may be set by writing to:
>   /sys/kernel/debug/nfsd/io_cache_write
> 
> The default value for both settings is NFSD_IO_BUFFERED, which is
> NFSD's existing behavior for both read and write. Changes to these
> settings take immediate effect for all exports and NFS versions.
> 
> If NFSD_IO_DONTCACHE is specified, all exported filesystems must
> implement FOP_DONTCACHE, otherwise IO flagged with RWF_DONTCACHE
> will fail with -EOPNOTSUPP.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/debugfs.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsd.h    |  9 +++++
>  fs/nfsd/vfs.c     | 19 ++++++++++
>  3 files changed, 121 insertions(+)
> 
> Changes from Mike's v9:
> - Squashed the "io controls" patches together
> - Removed NFSD_IO_DIRECT for the moment
> - Addressed a few more checkpatch.pl nits
> 
> This gives a cleaner platform on which to build the direct I/O code
> paths, and does not expose partially implemented I/O modes to users.
>
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index 84b0c8b559dc..2b1bb716b608 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -44,4 +131,10 @@ void nfsd_debugfs_init(void)
>  
>  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
>  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
> +
> +	debugfs_create_file("io_cache_read", 0644, nfsd_top_dir, NULL,
> +			    &nfsd_io_cache_read_fops);
> +
> +	debugfs_create_file("io_cache_write", 0644, nfsd_top_dir, NULL,
> +			    &nfsd_io_cache_write_fops);
>  }

Relative to checkpatch warnings, this ^ code is what I'm aware of.
For consistency I stuck with "S_IWUSR | S_IRUG", whereas you honored
checkpatch's suggestion to use 0644.

Maybe update disable-splice-read to also use 0644 too? But your call!

Thanks,
Mike

