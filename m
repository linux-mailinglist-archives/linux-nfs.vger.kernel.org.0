Return-Path: <linux-nfs+bounces-14176-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DB2B5193F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9C3487583
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C27322DD4;
	Wed, 10 Sep 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrXqik6R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B8322A3F
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514236; cv=none; b=aKn0wa9XBhym2+YZOCwfMWtjWyXeAnVgwD8KqaU+m+EebNbw/nNMwAxuv1BXFtP8QRtrtVU0+wOHiLrvW5mFKnw8tpIF0iE/Xb77IzYWvwlMov60y5apCCevIQaVNtf6Uqml0InFtw8XmEx/rsYc7JriMPZE0jX91MzbEuTftos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514236; c=relaxed/simple;
	bh=jePPFUgSbSbKafxLc718DiauDX7TggBWe+Q1HmJfDpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8S8bblZbsfwcBDSoMuDzpT2dsa8PwzyFYPwXUvcVvm/kQI4cc9Mcm5/I1Q+Zn6IwddoJ84TN/nhY3eQZkbboEz7r+kEFnKj8gN83NZoaXUhpELUA5fVRSW5h3DTrmxr5if6C0MZxl3gD9fJk3X9znzZOZKZ7Pmml/ogjd0yF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrXqik6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4A6C4CEF0;
	Wed, 10 Sep 2025 14:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757514236;
	bh=jePPFUgSbSbKafxLc718DiauDX7TggBWe+Q1HmJfDpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QrXqik6RgTncwCo7+MZpE2xu8qF86EhrtBpL/D5QeXD0BnuXZWWCspI07gHGTh+2L
	 7vECTJgyjiJopOsUQ8WPz0LtdcvhY1+8wcIfR4sqXKh0RD4y0QrSn1bNl0zm+wrVkO
	 YlPLw3PoYs1sa5dJK84H2fXTwsW72tKahIGIzbm6vRc0YGML5jWH+GKxKo8eNjNThI
	 8//fmMHoCNksZcRaEz8DUAHN+/1/5Fu84DVr51Tf0uvSICjTAqm6N1B42hGrJMMBDt
	 A+gb2GpEXLCDhSwwT3Az36p/HMrMQmQH4zLPin5xsifletdatMKyH2ASKSOA5tGfg/
	 EQsoUiXJSs5EQ==
Message-ID: <7d340996-9671-46fa-8ad1-8b656b6fe2e2@kernel.org>
Date: Wed, 10 Sep 2025 10:23:54 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>
References: <> <bb2c9e28-fc38-4990-b881-b652bcccd405@kernel.org>
 <175746915802.2850467.11582824964664652427@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175746915802.2850467.11582824964664652427@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 9:52 PM, NeilBrown wrote:
>>>> +	v = 0;
>>>> +	total = dio_end - dio_start;
>>>> +	while (total) {
>>>> +		len = min_t(size_t, total, PAGE_SIZE);
>>>> +		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
>>>> +			      len, 0);
>>>> +		total -= len;
>>>> +		++v;
>>>> +	}
>>>> +	WARN_ON_ONCE(v > rqstp->rq_maxpages);
>>> I would rather we had an early test rather than a late warn-on.
>>> e.g.
>>>   if (total > (rqstp->rq_maxpages >> PAGE_SHIFT))
>>>      return -EINVAL /* or whatever */;
>>>
>>> Otherwise it seems to be making unstated assumptions about how big the
>>> alignment requirements could be.
>> This is the same warn-on test that nfsd_iter_read does for buffered and
>> dontcache reads. It's done late because the final value of v is computed
>> here, not known before the loop.
> True, but in this case "total" could be larger than "*count" which was
> size-checked in e.g.  nfsd4_encode_read.  So it could now be larger than
> the available space.

Expanding the byte range is constrained to the alignment parameters,
meaning the most the range can increase is by a single page (assuming
the needed alignment is always less than or equal to a page size, or
that we stipulate larger alignments are not yet supported).

Both rq_bvec and rq_pages have that extra page already.


>> I think we might be able to turn this into a short read, for all I/O
>> modes?
> Yes, that could be a clean way to handle the unlikely case that the
> reads doesn't fit any more.

It's probably best to not have the WARN_ON at all. Either convert the
failure to a short read, or prove formally that the condition cannot
happen and simply remove the WARN_ON. I have never seen it fire.

That should be done to nfsd_iter_read() /before/ this series. Then 3/3
can "copy" and use the improved loop logic.


-- 
Chuck Lever

