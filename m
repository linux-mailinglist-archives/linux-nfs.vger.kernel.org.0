Return-Path: <linux-nfs+bounces-13288-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D01DB13C87
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 16:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA701188B0C9
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D426FD9D;
	Mon, 28 Jul 2025 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICvg4PML"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200E26E6F0
	for <linux-nfs@vger.kernel.org>; Mon, 28 Jul 2025 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711098; cv=none; b=cN7xhyMvoBTc3AfIWZRIsWAomQOt4TZvo6Akfbcd6z4IXcds0j+KGEgHaT2GV4iaQUEtyedRNrxAzSMSb2eIvqPlcfwbDSNe+628QaqpDrV+pK5MtuM3iL+F8CYoFE9L9d9ASbjFFJUF1bE7aRucACv1wV+CgWRv8IQYW00OJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711098; c=relaxed/simple;
	bh=zQQxhgbLynHf9rLiIdPaT1JQMrcftmKm/V01G0yhW5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OS8yvw3hxCWf/MGVC4xzwkyprLJd3hQr9bRR3+nz9tLqoT2l8ws2vC5FDFL8eHUTkcATlB6iqxmn5HEFVOeuSBonr4h70paUdQL63AYiKCRNYBJHmIK2RQc8YmiU1YXehXJ0/zah37OiaMbil3/GrhVn0rr5T1gVwVa1lGZmchs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICvg4PML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB9CC4CEE7;
	Mon, 28 Jul 2025 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753711098;
	bh=zQQxhgbLynHf9rLiIdPaT1JQMrcftmKm/V01G0yhW5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICvg4PMLj4FfY/WMQgB/265+h72LK3LknSOkcetKG6p/bAFaTmagP42r9SSOAOFOe
	 eERfJwJV903nxsbCvg5HlfpYIPPJgVYcYSylJDotVYKxOjN5wY/O1HsqCUajzUoI0D
	 cNhlkjQDgTCHfJMGAiQyuWR9Nf5xVGRYyDV86lMrwbWBoVixlZtTmxVntPwKdY0Ix8
	 ozg3RCwzN6jXmeBvViWlruq1nTsVeEEOuYmpma+6krK54sKasmW459MqQxo0Ze+ahw
	 GIAuecmoEXXu6QcLF4gkTn0FHYTGSEeC4XpUFZrcBNm75+Gsa3a1Iu26IiQh/lQyjn
	 c55ezyWAoPAVw==
Date: Mon, 28 Jul 2025 09:58:17 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: (subset) [PATCH v5 00/13] NFSD DIRECT and NFS DIRECT
Message-ID: <aIeB-V0w3Vz-Qq5u@kernel.org>
References: <20250724193102.65111-1-snitzer@kernel.org>
 <175363294101.59631.4885658207387773358.b4-ty@oracle.com>
 <aIeAZDBY0klVtGSv@kernel.org>
 <bc918269-2fa2-4524-8681-a965cce57e82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc918269-2fa2-4524-8681-a965cce57e82@kernel.org>

On Mon, Jul 28, 2025 at 09:53:45AM -0400, Chuck Lever wrote:
> On 7/28/25 9:51 AM, Mike Snitzer wrote:
> > On Sun, Jul 27, 2025 at 12:16:04PM -0400, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> On Thu, 24 Jul 2025 15:30:49 -0400, Mike Snitzer wrote:
> >>> Some workloads benefit from NFSD avoiding the page cache, particularly
> >>> those with a working set that is significantly larger than available
> >>> system memory.  This patchset introduces _optional_ support to
> >>> configure the use of O_DIRECT or DONTCACHE for NFSD's READ and WRITE
> >>> support.  The NFSD default to use page cache is left unchanged.
> >>>
> >>> The performance win associated with using NFSD DIRECT was previously
> >>> summarized here:
> >>> https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
> >>> This picture offers a nice summary of performance gains:
> >>> https://original.art/NFSD_direct_vs_buffered_IO.jpg
> >>>
> >>> [...]
> >>
> >> Applied to nfsd-testing, thanks!
> >>
> >> [01/13] NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
> >>         commit: af157e09634a113da83d8ac5fff541f9e06ad653
> > 
> >> [05/13] NFSD: filecache: only get DIO alignment attrs if NFSD_IO_DIRECT enabled
> >>         commit: af157e09634a113da83d8ac5fff541f9e06ad653
> > 
> > I noticed you folded these, unfortunately that isn't bisect safe
> > unless you pull these fs/nfsd/nfsd.h changes to the front too:
> > 
> > git diff f76b72e4908c556021d94bdeca86fffce430c791^..a45da44bb6bade1dfef569c792ae2ee6507f4724 -- fs/nfsd/nfsd.h
> > 
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 1cd0bed57bc2..fe935b4cda53 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -153,6 +153,16 @@ static inline void nfsd_debugfs_exit(void) {}
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
> > +extern u64 nfsd_io_cache_write __read_mostly;
> > +
> >  extern int nfsd_max_blksize;
> >  
> >  static inline int nfsd_v4client(struct svc_rqst *rq)
> > 
> >> [02/13] NFSD: pass nfsd_file to nfsd_iter_read()
> >>         commit: 63a534c8b18642dc27318e08b77952c4d7f55628
> >> [03/13] NFSD: add io_cache_read controls to debugfs interface
> >>         commit: f76b72e4908c556021d94bdeca86fffce430c791
> >> [04/13] NFSD: add io_cache_write controls to debugfs interface
> >>         commit: a45da44bb6bade1dfef569c792ae2ee6507f4724
> > 
> >> [06/13] NFSD: issue READs using O_DIRECT even if IO is misaligned
> >>         commit: 6d80efb3cb6f9817bedfa460e9ddf56a916caf2f
> > 
> > Thanks!
> > Mike
> 
> That's what I get for compile-testing first before squashing.

It happens, you also need this from vfs.c:

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9bbc97aebbea..a7a587736a22 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,6 +49,8 @@
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
 bool nfsd_disable_splice_read __read_mostly;
+u64 nfsd_io_cache_read __read_mostly;
+u64 nfsd_io_cache_write __read_mostly;
 
 /**

