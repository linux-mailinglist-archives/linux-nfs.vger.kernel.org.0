Return-Path: <linux-nfs+bounces-10182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1036A3AA92
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 22:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA521884BAC
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 21:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF591BEF74;
	Tue, 18 Feb 2025 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="zX4fDzmJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ADC286290
	for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913275; cv=none; b=T/EYW3+1+hBHQ1600fTJSGEOnNZKfk+utOIoPWE85llYTzWNZ5lG73RbmXhx+usdfalWUhqZPmHOQ016SD9joLYcROo0S19UcGYSAmKbWhCMl734B/INhYnpHkWJ67mre33/GYiV8mJlWwSs54LGbA4Y60Zbn/RqZ3QT0d9OESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913275; c=relaxed/simple;
	bh=oGy55IJcEGgdNiLxbkXY33fp8cTKqWt1BWnOffz4MJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ55od7QFwF2uaFItbXqMPtGiXEWxYKPaEEm2fwdHzk78BqPNvINaqsaXKB0r7t0QYQs9QEHN4Vd9rw0l0Tj9LKL4E8Zl0zWS/sl+ouYjIOFzTRQGcJn/nfiNcrFxOUpf+oOaCDwxBFcrkiK3mZq1yhO1vc07crntbEnJbh7Jsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=zX4fDzmJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2210d92292eso91661075ad.1
        for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 13:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739913273; x=1740518073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/TFjjFVKbDA3nMhW4Nd4g/ebT5hNi/7fITiKNmhUzM=;
        b=zX4fDzmJf8D3IULJy+9ORjlF9LToVRyBLuE84gl+G8m+Ts4ZSYvbYsLztE09+FfYhF
         MD8Dsj7cy4xJmTVNsO+dE2gXiDSbgO7tEoXIu7wQl7VW67l3dBAlQxmEO1KGLSNT+obn
         mgwF5SWNyovCACiopowquMcQAEbntciPJQpQmalkOLFH1mOFOajOXl+5VYNKjq2LM2xo
         ZhOpXI9tHP+0y2g9BLoFgpAuXgcOuqow8VX7Dy8/VHeu7WUgH1rs5jlQOj/5sbpGkeBt
         yfLmubUErFF//vGT+rOKzQaXkTTHQ1qVNyO0Yx47UosSny+hfW9O+PR4u6XWibPUvr8f
         1+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913273; x=1740518073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/TFjjFVKbDA3nMhW4Nd4g/ebT5hNi/7fITiKNmhUzM=;
        b=EWrNz1R6jreZUemc0vK15cYPJboLInoXNt8vvGyA9GyGv+D8ClGDCVZn5IHQoPK2UB
         ZmqtIthnPrwIjkCQQarMycRYRtlpFJ+uYPgbSrKflwjIe9kZb+oQ4/yJmWP2fVk+3kEJ
         EZuV54YqLUicQqN+L8maGPM0dCzgY7EQeA7DYfooRYzk5JHJkb7GMVhkTDa4/c1aMAx3
         Izr7949/UpbIAP3Y4ZJnSZJNU+kzOvy3+U0MzMYw5Os7lxAGrp5UlxUzU3ALxTkQSyq6
         GZROUE0Tjzi/uhwZdQHrEHwIq5C6EFY5G0X6KjsnlYQVz5R8zWUkWXIZqemWoJ95pXUM
         rPrw==
X-Forwarded-Encrypted: i=1; AJvYcCWxRnbpJ/PqyG9rwXfGpROXYvftdv2/LK0XqUfJlIw6F3LqHon04k55fwqrRTLsFj5t2S5u0ukXqhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+6Zts3DrssRBN6EuaGtGKZL+mnk/njpL3mKfyw6z1O8Wx0dG
	u8IYRxj6VYVXmwCa3MDXHSU0XqLaBjPSLRpy/ZO7Ezlf7cV21EyuXWuDKB4AGHM=
X-Gm-Gg: ASbGncvMJfXIvMOKCcabI63fC9sTmdS+JO7Opg17F42+vV27LowOuUVQ9a0ivIYG1Om
	jAka/8aUpLoihIn9i0FV1zSL8XXj5wd/JawjKnlC7gJongHDabCBbk8KUsM9sgZj6SHFuyHZplb
	NKEiqpRpFkllinydGcZnBu5aG02WEsti4O5tQXRh8XiX0T5zbI1vDgrFn2fcGTLDUZuL8IKLTeV
	1MWQ2E2NhZbB8WM/LHmw1n2IiYLKTWZCh6iO4NQdjQHg+rmklBIw4zFQX9A5Njf4rZ1F9OE8ymC
	MyUIUGVIYGpw3njadMVJPO+GVFYQQUkCzYAnquvMpioAhWbzYi4EE/wG7c7IUasQTns=
X-Google-Smtp-Source: AGHT+IE4cq05OkjYUSAgnZzqAzKf40dxIlYKr7v+HOFdczvTt57phu0weZ5JY1SWVHQCE16yV/OTUA==
X-Received: by 2002:a17:902:d50e:b0:221:337:4862 with SMTP id d9443c01a7336-2217086de01mr12977035ad.15.1739913273049;
        Tue, 18 Feb 2025 13:14:33 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f34sm93829725ad.10.2025.02.18.13.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:14:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkUvF-00000002xpK-2NTA;
	Wed, 19 Feb 2025 08:14:29 +1100
Date: Wed, 19 Feb 2025 08:14:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Luiz Capitulino <luizcap@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC] mm: alloc_pages_bulk: remove assumption of populating only
 NULL elements
Message-ID: <Z7T4NZAn4wD_DLTl@dread.disaster.area>
References: <20250217123127.3674033-1-linyunsheng@huawei.com>
 <Z7Oqy2j4xew7FW9Z@dread.disaster.area>
 <cf270a65-c9fa-453a-b7a0-01708063f73e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf270a65-c9fa-453a-b7a0-01708063f73e@huawei.com>

On Tue, Feb 18, 2025 at 05:21:27PM +0800, Yunsheng Lin wrote:
> On 2025/2/18 5:31, Dave Chinner wrote:
> 
> ...
> 
> > .....
> > 
> >> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> >> index 15bb790359f8..9e1ce0ab9c35 100644
> >> --- a/fs/xfs/xfs_buf.c
> >> +++ b/fs/xfs/xfs_buf.c
> >> @@ -377,16 +377,17 @@ xfs_buf_alloc_pages(
> >>  	 * least one extra page.
> >>  	 */
> >>  	for (;;) {
> >> -		long	last = filled;
> >> +		long	alloc;
> >>  
> >> -		filled = alloc_pages_bulk(gfp_mask, bp->b_page_count,
> >> -					  bp->b_pages);
> >> +		alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - refill,
> >> +					 bp->b_pages + refill);
> >> +		refill += alloc;
> >>  		if (filled == bp->b_page_count) {
> >>  			XFS_STATS_INC(bp->b_mount, xb_page_found);
> >>  			break;
> >>  		}
> >>  
> >> -		if (filled != last)
> >> +		if (alloc)
> >>  			continue;
> > 
> > You didn't even compile this code - refill is not defined
> > anywhere.
> > 
> > Even if it did complile, you clearly didn't test it. The logic is
> > broken (what updates filled?) and will result in the first
> > allocation attempt succeeding and then falling into an endless retry
> > loop.
> 
> Ah, the 'refill' is a typo, it should be 'filled' instead of 'refill'.
> The below should fix the compile error:
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -379,9 +379,9 @@ xfs_buf_alloc_pages(
>         for (;;) {
>                 long    alloc;
> 
> -               alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - refill,
> -                                        bp->b_pages + refill);
> -               refill += alloc;
> +               alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - filled,
> +                                        bp->b_pages + filled);
> +               filled += alloc;
>                 if (filled == bp->b_page_count) {
>                         XFS_STATS_INC(bp->b_mount, xb_page_found);
>                         break;
> 
> > 
> > i.e. you stepped on the API landmine of your own creation where
> > it is impossible to tell the difference between alloc_pages_bulk()
> > returning "memory allocation failed, you need to retry" and
> > it returning "array is full, nothing more to allocate". Both these
> > cases now return 0.
> 
> As my understanding, alloc_pages_bulk() will not be called when
> "array is full" as the above 'filled == bp->b_page_count' checking
> has ensured that if the array is not passed in with holes in the
> middle for xfs.

You miss the point entirely. Previously, alloc_pages_bulk() would
return a value that would tell us the array is full, even if we
call it with a full array to begin with.

Now it fails to tell us that the array is full, and we have to track
that precisely ourselves - it is impossible to tell the difference
between "array is full" and "allocation failed". Not being able to
determine from the allocation return value whether the array is
ready for use or whether another go-around to fill it is needed is a
very poor API choice, regardless of anything else.

You've already demonstrated this: tracking array usage in every
caller is error-prone and much harder to get right than just having
alloc_pages_bulk() do everything for us.

> > The existing code returns nr_populated in both cases, so it doesn't
> > matter why alloc_pages_bulk() returns with nr_populated != full, it
> > is very clear that we still need to allocate more memory to fill it.
> 
> I am not sure if the array will be passed in with holes in the
> middle for the xfs fs as mentioned above, if not, it seems to be
> a typical use case like the one in mempolicy.c as below:
> 
> https://elixir.bootlin.com/linux/v6.14-rc1/source/mm/mempolicy.c#L2525

That's not "typical" usage. That is implementing "try alloc" fast
path that avoids memory reclaim with a slow path fallback to fill
the rest of the array when the fast path fails.

No other users of alloc_pages_bulk() is trying to do this.

Indeed, it looks somewhat pointless to do this here (i.e. premature
optimisation!), because the only caller of
alloc_pages_bulk_mempolicy_noprof() has it's own fallback slowpath
for when alloc_pages_bulk() can't fill the entire request.

> > IOWs, you just demonstrated why the existing API is more desirable
> > than a highly constrained, slightly faster API that requires callers
> > to get every detail right. i.e. it's hard to get it wrong with the
> > existing API, yet it's so easy to make mistakes with the proposed
> > API that the patch proposing the change has serious bugs in it.
> 
> IMHO, if the API is about refilling pages for the only NULL elements,
> it seems better to add a API like refill_pages_bulk() for that, as
> the current API seems to be prone to error of not initializing the
> array to zero before calling alloc_pages_bulk().

How is requiring a well defined initial state for API parameters
"error prone"?  What code is failing to do the well known, defined
initialisation before calling alloc_pages_bulk()?

Allowing uninitialised structures in an API (i.e. unknown initial
conditions) means we cannot make assumptions about the structure
contents within the API implementation.  We cannot assume that all
variables are zero on the first use, nor can we assume that anything
that is zero has a valid state.

Again, this is poor API design - structures passed to interfaces
-should- have a well defined initial state, either set by a *_init()
function or by defining the initial state to be all zeros (i.e. via
memset, kzalloc, etc).

Performance and speed is not an excuse for writing fragile, easy to
break code and APIs.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

