Return-Path: <linux-nfs+bounces-11594-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6950AAAF0BF
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 03:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76EB91C00555
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 01:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183BE15687D;
	Thu,  8 May 2025 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MRQ1IyOp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E728F4
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746669054; cv=none; b=oALKT4wvLIycmnSjRFGB+7su31PL2k/IdwH3fv5gPlL0aWw5CgpyDW+QeigI9vY8Jn16joQ9LA7hnlfdsZhevNUeEeZ5Ay7fY+2lX9mMkuTSbecPkn9ATXZ2qtk7ykCAd8a+YwrrNwVaZuq1pFa0tpeBkXHAjD0mz/Khe3v0BnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746669054; c=relaxed/simple;
	bh=GAr+xAjVqMCTT3nP6Y6WGlb8Kargwr6G2YhC7E1fv5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4+mL1j6yNiyDFnaKVm8t6enkQ0XgOZI/BBXC4KT1N/ClPoPP1z7tcV/yeEjHhrdOx9hOLQgBxw0ewuB4bTJBIdfvYHMaFd3ce9s3/V0FqTbA2CNVE6wvFb/MgkWz87IIMO4LyxSv7bmh5n0T/uPzhfTZ+chDXDEsMTmZU4L9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=MRQ1IyOp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so523916a91.1
        for <linux-nfs@vger.kernel.org>; Wed, 07 May 2025 18:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746669051; x=1747273851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfpAEmYfYIc7AtnRvwJbXO85quh0S5H3KLAKIFlkzjs=;
        b=MRQ1IyOpbMqzcPFwHTdse93CFdhx7V3dlrkDQrPwYkUzwQs300Hum7lKdLii7PO/K7
         yzEeNIw1ogKnnP3ery0e1tamm/fcLMRZLlwAGNEsgA5IEoYI4li3zpbvDi/GBB50IohW
         5Sxc3soONErytW4IPJTGa1Whk9neVG5oJmENou/2y0m9OW3OLJel4vnFiPINx1BFOnPf
         nYVC2gLgDSP9G47BMUA4jDGXSLyhcipkOLcr+gkOEal5OkxfR4J2YuhTrEhZ23wJMlwG
         z4HAHa5daWnrVXEe3z7UiPj8y+twQo2e/195tF801QfqPyMnivxmNAqfEYWnlLHnGLsx
         AapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746669051; x=1747273851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfpAEmYfYIc7AtnRvwJbXO85quh0S5H3KLAKIFlkzjs=;
        b=ZeNWGQEhHATyM/2+2wUzGfmrej+RVZtjaepl4mvo/IBLWBh7X6Sal5JfnYrkIJxU5F
         YIg6qs0T5vqgcD68VzHOnirkiugy+NRMBYdZF18CET8NJRkzS0KPJ4F/GL2tvvAysCWc
         YKM7LDJOvWm6BtIHH/6G3sd60nn5+hdT5exj6iD/6zTaoRVK1MqRbGWbGTgdklmwgU15
         5vPScjU0XPKXcfsr/Qh90pWBZVHSVoXtD0IS6aj8wjKdc5pc/BP9xk2iJ25MUnX2WlPD
         ptKSVIx1wpF74OINv0r2kt+dGfUe1S21qiyqCHbmU4pXzHJlpzAqFM7BELra0ToJhfH+
         0pgA==
X-Forwarded-Encrypted: i=1; AJvYcCWiQvdkC1C0GXIWTRj+tASAKQ2ZpA9fcCdWrFH9Z9+20UN8kRTtWut4QxURRhpGiJdkC4r8X9dVzGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQk/aeTYW5AalET2dShZ2gCkVHMHo88dxks5Qn9YwxcBS8Tb6
	CaPeP3X1vDGFWaDEh8aYp5FqGnSWlXSESFfEmoO7KQd+wb/GnFDDYqfZARBRBxo=
X-Gm-Gg: ASbGncsd4ZsAGCLCPOAg/e7zLZrCQtetzXl4TNErJQnh5W9XWcrn+nCg93TXGwO2vYM
	fzpjyHwv0Th7884fIrktRcXLWsx3rG5Ob8o3BHDJnvSo7/twDuodgaVQRgcEK/+HzzY5CaVMA+O
	MYb778PgLJrgfoNbBa9wGVnpcB5ASS+WQA4Ef1QJG/PRA63yBcPH/yLMI2oebAFaJWwQzKBUkpE
	dVRC33MvLaMgKu7zYNBfPJDBvvRKWZjJPliInmeRKE+uTtaau629vg/0qqyNcRcL/YQn6+X6KbD
	a89kT6SOXlCPBC9sP3U7sEpWiZggaRW+Wb3JXasJv1xGoWlcFVh95u1539y06ZAdo85V/7HVVpa
	k2tLcH1lOsr5iGkXCO9vL2lZR
X-Google-Smtp-Source: AGHT+IF+bbkMxlz1VcogJpzRGuR+rHH4uhWm8E6xaXb7FZHjS4o/dYV+UAcTlCURGVrDaYivlIcTbQ==
X-Received: by 2002:a17:90b:4c10:b0:2fe:7f40:420a with SMTP id 98e67ed59e1d1-30b3a674f85mr2180792a91.17.1746669051555;
        Wed, 07 May 2025 18:50:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4d54febsm958269a91.23.2025.05.07.18.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 18:50:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uCqPQ-00000000kT1-0mb3;
	Thu, 08 May 2025 11:50:48 +1000
Date: Thu, 8 May 2025 11:50:48 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@meta.com>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: performance r nfsd with RWF_DONTCACHE and larger wsizes
Message-ID: <aBwN-Iz3hJTAKpzS@dread.disaster.area>
References: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
 <aBqNtfPwFBvQCgeT@dread.disaster.area>
 <8039661b7a4c4f10452180372bd985c0440f1e1d.camel@kernel.org>
 <aBrKbOoj4dgUvz8f@dread.disaster.area>
 <aBvVltbDKdHXMtLL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBvVltbDKdHXMtLL@kernel.org>

On Wed, May 07, 2025 at 05:50:14PM -0400, Mike Snitzer wrote:
> Hey Dave,
> 
> Thanks for providing your thoughts on all this.  More inlined below.
> 
> On Wed, May 07, 2025 at 12:50:20PM +1000, Dave Chinner wrote:
> > On Tue, May 06, 2025 at 08:06:51PM -0400, Jeff Layton wrote:
> > > On Wed, 2025-05-07 at 08:31 +1000, Dave Chinner wrote:
> > > > What are the fio control parameters of the IO you are doing? (e.g.
> > > > is this single threaded IO, does it use the psync, libaio or iouring
> > > > engine, etc)
> > > > 
> > > 
> > > 
> > > ; fio-seq-write.job for fiotest
> > > 
> > > [global]
> > > name=fio-seq-write
> > > filename=fio-seq-write
> > > rw=write
> > > bs=256K
> > > direct=0
> > > numjobs=1
> > > time_based
> > > runtime=900
> > > 
> > > [file1]
> > > size=10G
> > > ioengine=libaio
> > > iodepth=16
> >
> > Ok, so we are doing AIO writes on the client side, so we have ~16
> > writes on the wire from the client at any given time.
> 
> Jeff's workload is really underwhelming given he is operating well
> within available memory (so avoiding reclaim, etc).  As such this test
> is really not testing what RWF_DONTCACHE is meant to address (and to
> answer Chuck's question of "what do you hope to get from
> RWF_DONTCACHE?"): the ability to reach steady state where even if
> memory is oversubscribed the network pipes and NVMe devices are as
> close to 100% utilization as possible.

Right.

However, one of the things that has to be kept in mind is that we
don't have 100% of the CPU dedicated to servicing RWF_DONTCACHE IO
like the fio microbenchmarks have.

Applications are going to take a chunk of CPU time to
create/marshall/process the data that we we are doing IO on, so any
time we spend on doing IO is less time that the applications have to
do their work. If you can saturate the storage without saturating
CPUs, then RWF_DONTCACHE should allow that steady state to be
maintained indefinitely.

However, RWF_DONTCACHE does not remove the data copy overhead of
buffered IO, whilst it adds IO submission overhead to each IO. Hence
it will require more CPU time to saturate the storage devices than
normal buffered IO. If you've got CPU to spare, great. If you don't,
then overall performance will be reduced.

> > This also means they are likely not being received by the NFS server
> > in sequential order, and the NFS server is going to be processing
> > roughly 16 write RPCs to the same file concurrently using
> > RWF_DONTCACHE IO.
> > 
> > These are not going to be exactly sequential - the server side IO
> > pattern to the filesystem is quasi-sequential, with random IOs being
> > out of order and leaving temporary holes in the file until the OO
> > write is processed.
> > 
> > XFS should handle this fine via the speculative preallocation beyond
> > EOF that is triggered by extending writes (it was designed to
> > mitigate the fragmentation this NFS behaviour causes). However, we
> > should always keep in mind that while client side IO is sequential,
> > what the server is doing to the underlying filesystem needs to be
> > treated as "concurrent IO to a single file" rather than "sequential
> > IO".
> 
> Hammerspace has definitely seen that 1MB IO coming off the wire is
> fragmented by the time it XFS issues it to underlying storage; so much
> so that IOPs bound devices (e.g. AWS devices that are capped at ~10K
> IOPs) are choking due to all the small IO.

That should not happen in the general case. Can you start a separate
thread to triage the issue so we can try to understand why that is
happening?

> So yeah, minimizing the fragmentation is critical (and largely *not*
> solved at this point... hacks like sync mount from NFS client or using
> O_DIRECT at the client, which sets sync bit, helps reduce the
> fragmentation but as soon as you go full buffered the N=16+ IOs on the
> wire will fragment each other).

Fragmentation mitigation for NFS server IO is generally only
addressable at the filesystem level - it's not really something you
can mitigate at the NFS server or client.

> Do you recommend any particular tuning to help XFS's speculative
> preallocation work for many competing "sequential" IO threads?

I can suggest lots of things, but without knowing the IO pattern,
the fragmentation pattern, the filesystem state, what triggers the
fragmentation, etc, I'd just be guessing as to which knob might make
the problem go away (hence the request to separate that out).

-Dave.
-- 
Dave Chinner
david@fromorbit.com

