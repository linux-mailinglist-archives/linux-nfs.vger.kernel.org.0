Return-Path: <linux-nfs+bounces-4573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B13924C08
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 01:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E78C1F227E7
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 23:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC921DA33E;
	Tue,  2 Jul 2024 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="BeZ2Z3AJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231781DA310
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719962135; cv=none; b=ED+0IGs+2hc2WciX1gp5JWVnJWtizbxSa3RNkpJ0O8wXGSJ3OLlncW5uNBpBNhVt68x4ynfxASrTUF0fVEGZrIxBwzVaQcB4kvphpI5hz1Dvt4THak0mzEbt64PB8SYKI/gWDygcEyCenW25wJ51sP2MS5aiJrvaaS5OKVqAFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719962135; c=relaxed/simple;
	bh=CKjOFFunJqGNiZGXdI7kysYp9JZ60/5wkuh7Vdn0BoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlMZjtG4vP1bGx/V3oYmfXKVKb7cqdsKr0JceXwTvahkLPDZ+RhG1hXlqJR0Z5LexCM+RVsw6CCT0IwJstHoAMXCcolIxOO/6yTOO5pRnT7y3FjdxVIXvd9YIOgCVD2WC8zZl9D2K3kYh+ebFtCrXni8ufjxEVL8h4FhNx8AJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=BeZ2Z3AJ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-701fef57ac1so2606910a34.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jul 2024 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1719962133; x=1720566933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSBo+zf7ftD/pzZ2ox3TeKzd33ehLitXIebgTtcS6h4=;
        b=BeZ2Z3AJuIg2hxEASGddk+HusK9DaUTt2zQVzEiOfznjTxSfs7v+rALXKtgRERC57X
         12uqYOXgjHT8zLvAU0z0hR/nECoDhrn1/PpfNlUlR43hj2HOc/bSKrGgVdumh7vZAQ/P
         G2gAPiDWZFpuqe1ru7AnePlqisMHPA92zaYuA5M7ZLlMlUGGkFqrWNojNa801JpT2cYW
         6KL5m3TSd8QBM8h3aPxmPUXiR2tJpRQWPzamvqxNjrwVnNdGbKcRclWqRLG9Qy9bZwFY
         PlAA0Mx9SE2vkP9wm/l3WF9QvhVU2IdbX34YwN3kCcrBKg0flhUZ4Wegy4OuMRN/BzDf
         3SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719962133; x=1720566933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSBo+zf7ftD/pzZ2ox3TeKzd33ehLitXIebgTtcS6h4=;
        b=MhU5o6sosyf6ZA7lYkSQsR/dkUb9nUYM6vL34VjXSwlTgejrvz+0VTL6qC27ZF3dHX
         7RxO8F6irsIGxj4wqrKGeDYP6yu4a8JwBpVRSByAuUH0gfbHIbmBQ4VJN+AUlyYz7Y5S
         0nBLkIxUAMfDJMavqV9KhsJaqdjBBtW5QHShpYRECvFg1EsNSCYb6Lfb8xqIPSq81zkI
         GvfBt83AISOmum8DJ12cYNaDzFTwTEFprfzcwtPeEuom0PRpoXxb7c26tV8EJw8oVVR7
         IPU04Wnx0LPrwlaZRqKrGqNVrY/YkwxYsIOI+Nxv0tnMjHiKOER6OevN/xuzCjO7fg/W
         qz6g==
X-Forwarded-Encrypted: i=1; AJvYcCU8VaZeNbP81lUGopwx56W2PuhkPZQdGpw3q7ZGUAFtNIUKL/foIwLuaZC2PA+pEzL+kd7jL1yZ6Felogp5GemKeAbJNi5AYpZH
X-Gm-Message-State: AOJu0YwHGXZcAzVI2ZRV2vfqQj0l69ZdaPQ9w8kaRIluCEXEzoWVx75s
	mfb3gSe6nOpGuaCnyU5Q7GYQ48430imINHuBfJQSYzAPp2gfI43Rx1Kmi5tL5FZK7Z1KMIAT0xh
	A
X-Google-Smtp-Source: AGHT+IHz3JIxliXKvmYwNvZYCPHJCGpk8RQcl1jar1bw/R9bTzqBYeUNz8fXDcSR4s9IfYiQgNa9dg==
X-Received: by 2002:a05:6870:4195:b0:25c:b3c9:eccd with SMTP id 586e51a60fabf-25db35d90d3mr10470699fac.42.1719962133181;
        Tue, 02 Jul 2024 16:15:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802566511sm9121470b3a.75.2024.07.02.16.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 16:15:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sOmig-0021FG-0k;
	Wed, 03 Jul 2024 09:15:30 +1000
Date: Wed, 3 Jul 2024 09:15:30 +1000
From: Dave Chinner <david@fromorbit.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "bfoster@redhat.com" <bfoster@redhat.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <ZoSKEvqqy3B4uxm7@dread.disaster.area>
References: <Zn7icFF_NxqkoOHR@kernel.org>
 <ZoGJRSe98wZFDK36@kernel.org>
 <ZoHuXHMEuMrem73H@dread.disaster.area>
 <ZoK5fEz6HSU5iUSH@kernel.org>
 <f54618f78737bab3388a6bb747e8509311bf8d93.camel@hammerspace.com>
 <ZoP68e8Ib2wIRLRC@dread.disaster.area>
 <d1af795e3aa83477f90e4521af7ade3a7aed5d4b.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1af795e3aa83477f90e4521af7ade3a7aed5d4b.camel@hammerspace.com>

On Tue, Jul 02, 2024 at 02:00:46PM +0000, Trond Myklebust wrote:
> On Tue, 2024-07-02 at 23:04 +1000, Dave Chinner wrote:
> > On Tue, Jul 02, 2024 at 12:33:53PM +0000, Trond Myklebust wrote:
> > > On Mon, 2024-07-01 at 10:13 -0400, Mike Snitzer wrote:
> > > > On Mon, Jul 01, 2024 at 09:46:36AM +1000, Dave Chinner wrote:
> > > > > IMO, the only sane way to ensure this sort of nested "back-end
> > > > > page
> > > > > cleaning submits front-end IO filesystem IO" mechanism works is
> > > > > to
> > > > > do something similar to the loop device. You most definitely
> > > > > don't
> > > > > want to be doing buffered IO (double caching is almost always
> > > > > bad)
> > > > > and you want to be doing async direct IO so that the submission
> > > > > thread is not waiting on completion before the next IO is
> > > > > submitted.
> > > > 
> > > > Yes, follow-on work is for me to revive the directio path for
> > > > localio
> > > > that ultimately wasn't pursued (or properly wired up) because it
> > > > creates DIO alignment requirements on NFS client IO:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-6.11-testing&id=f6c9f51fca819a8af595a4eb94811c1f90051eab
> > 
> > I don't follow - this is page cache writeback. All the write IO from
> > the bdi flusher thread should be page aligned, right? So why does DIO
> > alignment matter here?
> > 
> 
> There is no guarantee in NFS that writes from the flusher thread are
> page aligned. If a page/folio is known to be up to date, we will
> usually align writes to the boundaries, but we won't guarantee to do a
> read-modify-write if that's not the case. Specifically, we will not do
> so if the file is open for write-only.

So perhaps if the localio mechanism is enabled, it should behave
like a local filesystem and do the page cache RMW cycle (because it
doesn't involve a network round trip) to make sure all the buffered
IO is page aligned. That means both buffered reads and writes are page
aligned, and both can be done using async direct IO. If the client
is doing aligned direct IO, then we can still do async direct IO to
the underlying file. If it's not aligned, then the localio flusher
thread can just do async buffered IO for those IOs instead.

Let's not reinvent the wheel: we know how to do loopback filesystem
IO very efficiently, and the whole point of localio is to do
loopback filesystem IO very efficiently.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

