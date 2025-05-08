Return-Path: <linux-nfs+bounces-11595-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FF4AAF0F3
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 04:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9D43A4303
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 02:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F00E33FD;
	Thu,  8 May 2025 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="f54qKbKa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0494B1E6F
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746669942; cv=none; b=NMS8fiGrVIeYOUCUabFPMfLD/QlhqLmJcp5zhf20DW5iTvNl9rwiNu4DOl9aBuJr8spfY6Y03KiYvvFvlNOLdNg5b+SDvYPOY/V+z/q9nWULGITisblZDEcmgjb+MLfWvBMdmMtlWu6YdYOj6UvwsKVXqwmTjhIZpPO4AhDoH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746669942; c=relaxed/simple;
	bh=PgkVcTQKPElP9GJqTGMcJ8KpDjr23Hd3HRkX3B1UN7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtmw/r7B7wUKIq8cT/sMukUqPs2xC3gAsY1hsNaM04/LLxaTGyjqjRfjQbsdIH3DzODNxNR4PwePJVAky9IVIp7P50Mn+2eW4HX2OgpPSpXJ3YHUzeXxKLcziVwJf2/1wTUcbV+w4ezvNc0zSb1hMG+qnY6WLpGgS1KNA3GOhWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=f54qKbKa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7398d65476eso472024b3a.1
        for <linux-nfs@vger.kernel.org>; Wed, 07 May 2025 19:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746669940; x=1747274740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=saKZCDhFeW4DvmqrMwzpBcifdhBVTKscMDpwX3nn5IY=;
        b=f54qKbKaYm38GzywZI9sBT7w6yl81NWjwbf/N1P9UVTIvK6JdHOoc1QiSLleRcZPG8
         g+QBpUZ5ijDb1vxHmlbcm0JOoHy+gM/m2bOdjCIYvBWJuD/FTNCEgdU/fs6XK3Bylivd
         eF1Caf6iG1UyHwOdsxvCFtj//YyTIUGGyeytx3WmbMpvHBPlfbLy1Q3qVcztBrENix5M
         1+EiYPp8a6PPwKw3eicElTYco8+qcTFHq/uafGC5Yyys8o2NcgmCKgoL/FrNLCrObnO8
         iX2jv99+GWjqd7z7Ii6xXrg28CZ6X3dXvHedZJnUM7siAT18219HBjbGDpWTla8g8j1F
         shuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746669940; x=1747274740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saKZCDhFeW4DvmqrMwzpBcifdhBVTKscMDpwX3nn5IY=;
        b=WtvJ7GfZGPP6UfiQuie3F20rlEpmCyMIkvIdDdYhLygQKOU7YUagxUNfGzQtlAcovh
         AIFBAdKTiEX81wXo9ZAFnWqU4CXAIf64iRpyImoIcXyV/N+clJFnUV6lLoeTlOqXjwtP
         Pkrxw1LRPTTMjKosEbO8J0Kay4qwyi1UhR5l3XcjJSq+WCBwNJl4RJgEdv7ibrTyLECx
         CLCrJdmc+CcuZUL7WrxIIArxoIuckTJdtlDUzjTxDKsIyl++dXE/HGHo02zWrPzGWyLE
         /fTpD1sbx3zx1TsKMDLsWm32Uw9RiyM9Sa4pyX+jYZq92gozNBdF+Lp66bC+seRVmyu2
         ACIg==
X-Forwarded-Encrypted: i=1; AJvYcCWqB+RlRP/hEXMpHPM/Zp1mQowRnNyF0BCZxtpNXB8rUqooW4rE/sS/2n+7uB+nMBG5q/fTI76xanY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWtipXSfo7Eh/c+fZIIKw/lEw1boew89jCGCBEFavLHqQpHA2Q
	Jfvs32TNBc+hG/sGJyob0KtaFlI/lxYUxu+j5UNIvNeH7WWS2XJTNYG2XMuQe/s=
X-Gm-Gg: ASbGncsYWJ7Mcw2s443Adv+vokHFoZjU20zsi/d9yLDpP+Juw39ha313PlJZiNCz/DW
	DPZgDvQAMophc/TrHx+e6Ef+0NH4VqPwZHfaVhA4NGukDka/52JXcj7ind5RBSGbh4lBRxxbYyj
	smubsAFUknAqR3L0oxlahwhTDmDDwn0c+7scIiU3MtJXFnntxdCtDpTNcNGhgeLtqud4+vKaDKj
	2OKBtUZpQT750KvBNE1sLFC+VHpNnnVnhd+1sTY6coiqiNXsm/MzklcRpjLNeSuoMjQw2NZtc5Y
	AA13j9SXWvAj6MaO8RcYt+inTBYfr4qiVqCN36VCnkwRqJ1LNZBiqmmmiHywllzWKUT9pSb8WW4
	KvTo=
X-Google-Smtp-Source: AGHT+IF7ZFSapUdnHG4NuCUmRXMwGMb9VgvEbaWmVNT5vLVJcNqglMznHseVnFhOAn8WZhvEh1F++Q==
X-Received: by 2002:a05:6a20:ce48:b0:1e1:9e9f:ae4 with SMTP id adf61e73a8af0-2159a037634mr2368115637.13.1746669939869;
        Wed, 07 May 2025 19:05:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902104fsm11994415b3a.115.2025.05.07.19.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 19:05:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uCqdk-00000000kqB-31cX;
	Thu, 08 May 2025 12:05:36 +1000
Date: Thu, 8 May 2025 12:05:36 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@meta.com>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: performance r nfsd with RWF_DONTCACHE and larger wsizes
Message-ID: <aBwRcI26iGzBLnxa@dread.disaster.area>
References: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
 <aBqNtfPwFBvQCgeT@dread.disaster.area>
 <8039661b7a4c4f10452180372bd985c0440f1e1d.camel@kernel.org>
 <aBrKbOoj4dgUvz8f@dread.disaster.area>
 <aBvVltbDKdHXMtLL@kernel.org>
 <3c770b46f3dc5d4618d87b44158c4c5af00e3b3a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c770b46f3dc5d4618d87b44158c4c5af00e3b3a.camel@kernel.org>

On Wed, May 07, 2025 at 08:09:33PM -0400, Jeff Layton wrote:
> On Wed, 2025-05-07 at 17:50 -0400, Mike Snitzer wrote:
> > Hey Dave,
> > 
> > Thanks for providing your thoughts on all this.  More inlined below.
> > 
> > On Wed, May 07, 2025 at 12:50:20PM +1000, Dave Chinner wrote:
> > > Remember the bad old days of balance_dirty_pages() doing dirty
> > > throttling by submitting dirty pages for IO directly in the write()
> > > context? And how much better buffered write performance and write()
> > > submission latency became when we started deferring that IO to the
> > > writeback threads and waiting on completions?
> > > 
> > > We're essentially going back to the bad old days with buffered
> > > RWF_DONTCACHE writes. Instead of one nicely formed background
> > > writeback stream that can be throttled at the block layer without
> > > adversely affecting incoming write throughput, we end up with every
> > > write() context submitting IO synchronously and being randomly
> > > throttled by the block layer throttle....
> > > 
> > > There are a lot of reasons the current RWF_DONTCACHE implementation
> > > is sub-optimal for common workloads. This IO spraying and submission
> > > side throttling problem
> > > is one of the reasons why I suggested very early on that an async
> > > write-behind window (similar in concept to async readahead winodws)
> > > would likely be a much better generic solution for RWF_DONTCACHE
> > > writes. This would retain the "one nicely formed background
> > > writeback stream" behaviour that is desirable for buffered writes,
> > > but still allow in rapid reclaim of DONTCACHE folios as IO cleans
> > > them...
> > 
> > I recall you voicing this concern and nobody really seizing on it.
> > Could be that Jens is open changing the RWF_DONTCACHE implementation
> > if/when more proof is made for the need?
> 
> It does seem like using RWF_DONTCACHE currently leads to a lot of
> fragmented I/O. I suspect that doing filemap_fdatawrite_range_kick()
> after every DONTCACHE write is the main problem on the write side. We
> probably need to come up with a way to make it flush more optimally
> when there are streaming DONTCACHE writes.
> 
> An async writebehind window could be a solution. How would we implement
> that? Some sort of delay before we kick off writeback (and hopefully
> for larger ranges)?

My thoughts on this are as follows...

When we mark the inode dirty, we currently put it on the list of
dirty inodes for writeback. We could change how we mark an inode
dirty for RWF_DONTCACHE writes to say "dirty for write-through" and
put it on a new write-through inode list.  Then we can kick an expedited
write-through worker thread that writes back all the dirty
write-through inodes on it's list.

In this case, a delay of a few milliseconds is probably large enough
time to allow decent write-through IO sizes to build up without
causing excessive page cache memory usage for dirty DONTCACHE
folios...

The other thing that this could allow is throttling incoming
RWF_DONTCACHE IOs in balance_dirty_pages_ratelimited. e.g. if more
than 16MB of DONTCACHE folios are built up on a BDI, kick the
write-through worker and wait for the DONTCACHE folio count to drop.
This then gives some control (and potential admin control) of how
much dirty page cache is allowed to accrue for DONTCACHE write
IOs...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

