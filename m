Return-Path: <linux-nfs+bounces-12950-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB50AFD955
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 23:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1C8586B77
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 21:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0C324290E;
	Tue,  8 Jul 2025 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laJ79rtp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE1201034;
	Tue,  8 Jul 2025 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009154; cv=none; b=ht92C6LlD9+W9GHhhE5iCjHL6oN5+1l6mRez8+GYjBdE1iCsHFKahrSgkZX9WdwjBgtVfy9zwpQOoLNuvt2YjoabxL3ixDBwEkhNo6v2SC7tf53nISSmNWNmrRIHBSLjVsJjemN6GNHQj9+gapsp6SzmTTC1rH/4ak7oAnCBQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009154; c=relaxed/simple;
	bh=mtlXLWmdcdJyUDwsBYWd4NHw+eVJqG7ze3bQVwJbF4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga9NfvsLpfFDTcOpLzlYm4zRoXdrh91EJqI81HtO0yt096DNU6VLmhrkEGS5XcbxTS7u8zeBxAOGvWVsM4ae5rY0/mEKqCW64ZRRYXO7wpFyM/Q8lRsh7nmQiYC8ttvRg3SIqd2xaY3yjJcpR2yBLF4uy7gEhpON2RrB3B0Oo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laJ79rtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE084C4CEED;
	Tue,  8 Jul 2025 21:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752009154;
	bh=mtlXLWmdcdJyUDwsBYWd4NHw+eVJqG7ze3bQVwJbF4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=laJ79rtpVtVLyM1FKSPNW+8UTb14IdVEf3pfT/40cQj/yuaRyQE1ORrSvTzc+rt2b
	 14eU2foI1SXzQPqf9Btm9RB6vrMgsmkATE4sYNlhf8Ueb98f4WJCnKOdEv0Rqz1XTp
	 oQhBr2cF+agrg5W8p7s/mtqML7yEAqdmUgapUUSSP5Sre+JytTBg9XqKMQXtiArhUJ
	 eVr2S0fkZuA4NkollCtJg2bkdbJdHQbCAPRZiTn+JK6JhO8XWm5xqeqjDUeju7v4oO
	 KBUBlK9wY2qJew7lrTR3vsxA1bwlgHiwYZdrxHH7AlYPM0QS6FV3BMT/X/Txx+fiFE
	 URIVDmkUIneeg==
Date: Tue, 8 Jul 2025 17:12:32 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] nfsd: call generic_fadvise after v3 READ, stable
 WRITE or COMMIT
Message-ID: <aG2JwM28-IOge4zF@kernel.org>
References: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
 <20250703-nfsd-testing-v1-2-cece54f36556@kernel.org>
 <520bd301-4526-4364-bbfa-5f591ab8f60a@oracle.com>
 <cda4542e4ae8b30a6f5628386388f813d3209558.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda4542e4ae8b30a6f5628386388f813d3209558.camel@kernel.org>

On Tue, Jul 08, 2025 at 10:34:15AM -0400, Jeff Layton wrote:
> On Thu, 2025-07-03 at 16:07 -0400, Chuck Lever wrote:
> > On 7/3/25 3:53 PM, Jeff Layton wrote:
> > > Recent testing has shown that keeping pagecache pages around for too
> > > long can be detrimental to performance with nfsd. Clients only rarely
> > > revisit the same data, so the pages tend to just hang around.
> > > 
> > > This patch changes the pc_release callbacks for NFSv3 READ, WRITE and
> > > COMMIT to call generic_fadvise(..., POSIX_FADV_DONTNEED) on the accessed
> > > range.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/debugfs.c  |  2 ++
> > >  fs/nfsd/nfs3proc.c | 59 +++++++++++++++++++++++++++++++++++++++++++++---------
> > >  fs/nfsd/nfsd.h     |  1 +
> > >  fs/nfsd/nfsproc.c  |  4 ++--
> > >  fs/nfsd/vfs.c      | 21 ++++++++++++++-----
> > >  fs/nfsd/vfs.h      |  5 +++--
> > >  fs/nfsd/xdr3.h     |  3 +++
> > >  7 files changed, 77 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > > index 84b0c8b559dc90bd5c2d9d5e15c8e0682c0d610c..b007718dd959bc081166ec84e06f577a8fc2b46b 100644
> > > --- a/fs/nfsd/debugfs.c
> > > +++ b/fs/nfsd/debugfs.c
> > > @@ -44,4 +44,6 @@ void nfsd_debugfs_init(void)
> > >  
> > >  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
> > >  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
> > > +	debugfs_create_bool("enable-fadvise-dontneed", 0644,
> > > +			    nfsd_top_dir, &nfsd_enable_fadvise_dontneed);
> > 
> > I prefer that this setting is folded into the new io_cache_read /
> > io_cache_write tune-ables that Mike's patch adds, rather than adding
> > a new boolean.
> > 
> > That might make a hybrid "DONTCACHE for READ and fadvise for WRITE"
> > pretty easy.
> > 
> 
> I ended up rebasing Mike's dontcache branch on top of v6.16-rc5 with
> all of Chuck's trees in. I then added the attached patch and did some
> testing with a couple of machines I checked out internally at Meta.
> This is the throughput results with the fio-seq-RW test with the file
> size set to 100G and the duration at 5 mins.
> 
> Note that:
> 
> read and writes buffered:
>    READ: bw=3024MiB/s (3171MB/s), 186MiB/s-191MiB/s (195MB/s-201MB/s), io=889GiB (954GB), run=300012-300966msec
>   WRITE: bw=2015MiB/s (2113MB/s), 124MiB/s-128MiB/s (131MB/s-134MB/s), io=592GiB (636GB), run=300012-300966msec
> 
>    READ: bw=2902MiB/s (3043MB/s), 177MiB/s-183MiB/s (186MB/s-192MB/s), io=851GiB (913GB), run=300027-300118msec
>   WRITE: bw=1934MiB/s (2027MB/s), 119MiB/s-122MiB/s (124MB/s-128MB/s), io=567GiB (608GB), run=300027-300118msec
> 
>    READ: bw=2897MiB/s (3037MB/s), 178MiB/s-183MiB/s (186MB/s-192MB/s), io=849GiB (911GB), run=300006-300078msec
>   WRITE: bw=1930MiB/s (2023MB/s), 119MiB/s-122MiB/s (125MB/s-128MB/s), io=565GiB (607GB), run=300006-300078msec
> 
> reads and writes RWF_DONTCACHE:
>    READ: bw=3090MiB/s (3240MB/s), 190MiB/s-195MiB/s (199MB/s-205MB/s), io=906GiB (972GB), run=300015-300113msec
>   WRITE: bw=2060MiB/s (2160MB/s), 126MiB/s-130MiB/s (132MB/s-137MB/s), io=604GiB (648GB), run=300015-300113msec
> 
>    READ: bw=3057MiB/s (3205MB/s), 188MiB/s-193MiB/s (198MB/s-203MB/s), io=897GiB (963GB), run=300329-300450msec
>   WRITE: bw=2037MiB/s (2136MB/s), 126MiB/s-129MiB/s (132MB/s-135MB/s), io=598GiB (642GB), run=300329-300450msec
> 
>    READ: bw=3166MiB/s (3320MB/s), 196MiB/s-200MiB/s (205MB/s-210MB/s), io=928GiB (996GB), run=300021-300090msec
>   WRITE: bw=2111MiB/s (2213MB/s), 131MiB/s-133MiB/s (137MB/s-140MB/s), io=619GiB (664GB), run=300021-300090msec
> 
> reads and writes witg O_DIRECT:
>    READ: bw=3115MiB/s (3267MB/s), 192MiB/s-198MiB/s (201MB/s-208MB/s), io=913GiB (980GB), run=300025-300078msec
>   WRITE: bw=2077MiB/s (2178MB/s), 128MiB/s-131MiB/s (134MB/s-138MB/s), io=609GiB (653GB), run=300025-300078msec
> 
>    READ: bw=3189MiB/s (3343MB/s), 197MiB/s-202MiB/s (207MB/s-211MB/s), io=934GiB (1003GB), run=300023-300096msec
>   WRITE: bw=2125MiB/s (2228MB/s), 132MiB/s-134MiB/s (138MB/s-140MB/s), io=623GiB (669GB), run=300023-300096msec
> 
>    READ: bw=3113MiB/s (3264MB/s), 191MiB/s-197MiB/s (200MB/s-207MB/s), io=912GiB (979GB), run=300020-300098msec
>   WRITE: bw=2075MiB/s (2175MB/s), 127MiB/s-131MiB/s (134MB/s-138MB/s), io=608GiB (653GB), run=300020-300098msec
> 
> RWF_DONTCACHE on reads and stable writes + fadvise DONTNEED after COMMIT:
>    READ: bw=2888MiB/s (3029MB/s), 178MiB/s-182MiB/s (187MB/s-191MB/s), io=846GiB (909GB), run=300012-300109msec
>   WRITE: bw=1924MiB/s (2017MB/s), 118MiB/s-121MiB/s (124MB/s-127MB/s), io=564GiB (605GB), run=300012-300109msec
> 
>    READ: bw=2899MiB/s (3040MB/s), 180MiB/s-183MiB/s (188MB/s-192MB/s), io=852GiB (915GB), run=300022-300940msec
>   WRITE: bw=1931MiB/s (2025MB/s), 119MiB/s-122MiB/s (125MB/s-128MB/s), io=567GiB (609GB), run=300022-300940msec
> 
>    READ: bw=2902MiB/s (3043MB/s), 179MiB/s-184MiB/s (188MB/s-193MB/s), io=853GiB (916GB), run=300913-301146msec
>   WRITE: bw=1933MiB/s (2027MB/s), 119MiB/s-122MiB/s (125MB/s-128MB/s), io=568GiB (610GB), run=300913-301146msec
> 
> 
> The fadvise case is clearly slower than the others. Interestingly it
> also slowed down read performance, which leads me to believe that maybe
> the fadvise calls were interfering with concurrent reads. Given the
> disappointing numbers, I'll probably drop the last patch.
> 
> There is probably a case to be made for patch #1, on the general
> principle of expediting sending the reply as much as possible. Chuck,
> let me know if you want me to submit that individually.
> -- 
> Jeff Layton <jlayton@kernel.org>

> From 14958516bf45f92a8609cb6ad504e92550b416d7 Mon Sep 17 00:00:00 2001
> From: Jeff Layton <jlayton@kernel.org>
> Date: Mon, 7 Jul 2025 11:00:34 -0400
> Subject: [PATCH] nfsd: add a NFSD_IO_FADVISE setting to io_cache_write
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Ah, you raced ahead and did what I suggested in my previous reply just
now.  Too bad the performance is lacking... but I applaud you're
trying out a new/interesting idea!

BTW, measuring CPU and memory use is also important to capture to get
full picture.

Mike

