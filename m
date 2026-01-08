Return-Path: <linux-nfs+bounces-17670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE40D06561
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 22:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 873AB303F4BB
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 21:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CED33D4E3;
	Thu,  8 Jan 2026 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJKGRbue"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE233D4F6
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907996; cv=none; b=b4hHPy1qiy3P5YhZ/2GVhB7XQ5PK2B9sJxkPn95quhuM55dYWAmY3TvV1v4VDFSoMzrB85+U07DH3yyoGOibMeOmUUvaZFBW4sZMZpZkGR6r7u3eU/8uO39TBDgvfUEvbUc2xh33gLwJe1Ki4yIALW+/1zGA720DKEVzHKCtqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907996; c=relaxed/simple;
	bh=gswua7H0wJtAB95PRBRgb+NCeLhc33UUh+kpx4SNvHE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pyew2yZu8T5WQNjuFU+d8eGqiY6K3fo9rzRTziVTKJJU+QV+d9XxbnEsJRVqkZ/sUE5T9VuPphFD+q8VzZ41lxwFET4S8BjEfjJ3CuUR/Ir9yoaCXfYSOgTATINkhcR2/TqxDlNLp6/DXV4L9ob995QRVWc/Zh8P9sjJF54/wCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJKGRbue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21418C116C6
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 21:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767907996;
	bh=gswua7H0wJtAB95PRBRgb+NCeLhc33UUh+kpx4SNvHE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iJKGRbuelyn4oFYBXl4nbFY0S3Jn8xI9Dmq6ULnEHZf6U7uOjokKQRlLGWclrV2Mb
	 QPQZddIrk1yOXxOx/ialtAA3FV9VS6oC56mfuxcrukXr2RrGVwMlMmopvEnziqXzi4
	 udqKHETMBrzcSyqSbQ8cv6WcQ+0ZE0h05W/MNY/X7oAIUej5EizyueFT9yhFghqhB0
	 CNo/RqQYPZNbHGTUSIhVqU+WtRv9n2i6lxYUKJPHRQXjmyt21vp8Xss2aZCdUgOIfD
	 MePhWMOqDyt+wrL2QCpu5MYYktHOA5U0WrppoMGuvA0h5xz8GtxgZdfB1S03eU1cJK
	 XdapgllnpspvA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 321BFF40069;
	Thu,  8 Jan 2026 16:33:15 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 08 Jan 2026 16:33:15 -0500
X-ME-Sender: <xms:myJgaTzq49qGMxJ5yGYs23qOHxmFpM40hOGsZ4nUo7JR8edOpgViCg>
    <xme:myJgaWF3W8ooY5oWwtdN96zAGKh8mOAUGpUADdxN_aGbw5v1tQ5JO_R7fsuJdKr3S
    JBHGYOB5fxAmiwxqU6hPY6nItshle4w3qASbyUdK--EyNgE9lmCLx91>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejvefhudehleetvdejhfejvefghfelgeejvedvgfduuefffeegtdejuefhiedukeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghirhgvsegunhgvghdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:myJgaWdYLfpLvboeoyIFafspQeSIIvXo0qdV87RiWdBREtMC2HcbTw>
    <xmx:myJgaeJ2iTtuNg71wyNtHwk2w5oTL2TjS7-pcERH52SmcjToBZq7Wg>
    <xmx:myJgafEndVi-w7W20aqhKIw8qfbDQjKQSOY9pCogOBdbTFy96G-Rbw>
    <xmx:myJgaQpziFl-qYh2aYdHSB4JLsCrZ15lSyQ5WkQaCZKfGdfoHob-Ug>
    <xmx:myJgaQSqQEstYfQwZYeB9gHACCiHqWIfoWTbmiJGn7WA20DvXoxkLBGq>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 12543780054; Thu,  8 Jan 2026 16:33:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9aTQCeeGJYs
Date: Thu, 08 Jan 2026 16:32:54 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Daire Byrne" <daire@dneg.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-Id: <dcba5f89-7603-4abb-821f-f5322e964c40@app.fastmail.com>
In-Reply-To: <89582fe2-2ee0-452a-9226-063f4b20ef5a@app.fastmail.com>
References: 
 <CAPt2mGPafo29KgjW9Rb17OhBDLnB-3fZn18zFQEhYk7Eitf6BA@mail.gmail.com>
 <f760b3a2-6e53-4143-9bb4-e56b030c6bba@app.fastmail.com>
 <CAPt2mGOy+ThM7tJDddrWRqFPq5Ljt1hhu==ydArdT7RYK82OBw@mail.gmail.com>
 <CAPt2mGO_gSfO4He7XeeENKuWD_+rbxa_z+hRJxNgQ8eC0XzZWw@mail.gmail.com>
 <89582fe2-2ee0-452a-9226-063f4b20ef5a@app.fastmail.com>
Subject: Re: refcount_t underflow (nfsd4_sequence_done?) with v6.18 re-export
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Jan 8, 2026, at 2:40 PM, Chuck Lever wrote:
> On Thu, Jan 8, 2026, at 12:59 PM, Daire Byrne wrote:
>> Hi,
>>
>> So I have had a couple more of these, but I'm not entirely sure what
>> to do with the ftrace buffer output - it's somewhat larger (8MB of
>> text) than I anticipated.
>>
>> Also, I presume it's the end of the buffer that would be most
>> interesting here? But it seems that after around 9 minutes of dumping
>> to the console, the VM resets itself before it gets to the end:
>>
>> [373929.678198] Dumping ftrace buffer:
>> [373929.680009] ---------------------------------
>> [373929.683722] CPU:9 [LOST 4084645 EVENTS]
>> [373929.683722]     nfsd-5995      9...1. 369589930108us :
>> nfsd_slot_seqid_sequence: addr=10.25.251.103:0 client
>> 694c76e1:df8970b5 idx=0 seqid=38846 slot_seqid=38845
>> flags=CACHETHIS|INITIALIZED|CACHED
>> [373929.693526]     nfsd-5995      9...1. 369589935540us :
>> nfsd_slot_seqid_sequence: addr=10.25.255.193:0 client
>> 694c76e1:df89721f idx=0 seqid=25008 slot_seqid=25007
>> flags=CACHETHIS|INITIALIZED|CACHED
>> [373929.701570]     nfsd-6048      9...1. 369589944806us :
>> nfsd_slot_seqid_sequence: addr=10.25.251.103:0 client
>> 694c76e1:df8970b5 idx=0 seqid=38874 slot_seqid=38873 flags=INITIALIZED
>> ..
>> ..
>> 8MB of same stuff...
>> ..
>> ..
>> [374235.603197]     nfsd-5502     47...1. 371173457457us :
>> nfsd_slot_seqid_sequence: addr=10.25.252.35:0 client 694c76e1:df896f53
>> idx=0 seqid=49997 slot_seqid=49996 flags=CACHETHIS|INITIALIZED|CACHED
>> [374235.610319]     nfsd-5636     27...1. 371173457503us :
>> nfsd_slot_seqid_sequence: addr=10.25.243.158:0 client
>> 694c76e1:df896f81 idx=0 seqid=51589 slot_seqid=51588 flags=INITIALIZED
>> [374235.616973]     nfsd-6011     19...1. 371173457522us :
>> nfsd_slot_seqid_sequence: addr=10.25.250.68:0 client 694c76e1:df896e6b
>> idx=0 seqid=76242 slot_seqid=76241 flags=CACHETHIS|INITIALIZED|CACHED
>> [374235.623915]     nfsd-5534      6.N.1. 371173457616us :
>> nfsd_slot_seqid_sequence: addr=10.25.244.14:0 client 694c76e1:df8971f3
>> idx=0 seqid=58885 slot_seqid=58884 flags=CACHETHIS|INITIALIZED|CACHED
>> [374235.631177]     nfsd-5502     47...1. 371173457623us :
>> nfsd_slot_seqid_sequence: addr=10.25.245.95:0 client 694c76e1:df896d75
>> idx=0 seqid=79933 slot_seqid=79932 flags=CACHETHIS|INITIALIZED|CACHED
>> [374235.638289]     nfsd-5184     28...1. 371173457705us :
>> nfsd_slot_seqid_sequence: addr=10.25.245.31:0 client 694c76e1:df896ef1
>> idx=0 seqid=70061 slot_seqid=70060 flags=CACHETHIS|INITIALIZED|CACHED
>> [374235.645342]     nfsd-6031      6...1. 371173457731us :
>> nfsd_slot_seqid_sequence: addr=10.25.240.198:0 client
>> 694c76e1:df897179 idx=0 seqid=38040 slot_seqid=38039
>> flags=CACHETHIS|INITIALIZED|CACHED
>> [374235.652425]     nfsd-5957     37...1. 371173457767us :
>> nfsd_slot_seqid_sequence: addr=10.25.244.86:0 client 694c76e1:df896fe7
>> idx=0 seqid=30158 slot_seqid=30157 flags=CACHETHIS|INITIALIZED|CACHED
>> [374235.659511]     nfsd-6028     55...1. 371173457829us :
>> nfsd_slot_seqid_sequence: addr=10.25.255.66:0 client 694c76e1:df8970a1
>> idx=0 seqid=25932 slot_seqid=25931 flags=CACHETHIS|INITIALIZED|CACHED
>> [374235.666430]     nfsd-5541     57...1. 371173457905us :
>> nfsd_slot_seqid_sequence: addr=10.25.254.129:0 client 694c76e1:df8
>>
>> REBOOT
>>
>> Any more pointers on how I can compress this down to something more
>> useful for debugging?
>>
>> Maybe there is useful info in there so I'm happy to compress and
>> upload the entire log somewhere if that is useful?
>
> The "LOST 4084645 EVENTS" message strongly suggests the trace data
> is incomplete -- the events immediately preceding the crash were
> likely among those lost. The nfsd_slot_seqid_sequence tracepoint
> fires on every NFSv4.1+ compound, which at 50 Gbps throughput
> will saturate any reasonably-sized buffer.
>
> Here are some suggestions for capturing useful data on the next
> occurrence. Try one or all of these:
>
> 1. Increase buffer size and filter out the noisy tracepoint:
>
> # Allocate much larger buffers (200MB per CPU)
> echo 200000 > /sys/kernel/debug/tracing/buffer_size_kb
>
> # Disable the high-volume tracepoint
> echo 0 > /sys/kernel/tracing/events/nfsd/nfsd_slot_seqid_sequence/enable
>
> # Keep only client lifecycle events
> echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_clid_expired/enable
> echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_clid_destroyed/enable
>
> 2. Dump only the triggering CPU's buffer:
>
> echo orig_cpu > /proc/sys/kernel/ftrace_dump_on_oops
>
> This avoids the multi-gigabyte dump that caused the reboot timeout.
>
> 3. Add a kprobe to catch the refcount underflow directly:
>
> echo 'p:kprobes/refcount_warn refcount_warn_saturate' \
>     > /sys/kernel/debug/tracing/kprobe_events
> echo 1 > /sys/kernel/debug/tracing/events/kprobes/refcount_warn/enable
>
> 4. Extend panic timeout:
>
> echo 300 > /proc/sys/kernel/panic
>
> ---
>
> I'm trying to hold off on a bisect, as that seems like a lot of time
> and work. But regarding the session slot rework: the major changes
> landed in the v6.13/v6.14 timeframe:
>
> - 0b6e14242630 ("nfsd: use an xarray to store v4.1 session slots")
> - 60aa6564317d ("nfsd: allocate new session-based DRC slots on demand")
> - fc8738c68d0b ("nfsd: add support for freeing unused session-DRC 
> slots")
> - 35e34642b599 ("nfsd: add shrinker to reduce number of slots allocated 
> per session")
>
> If bisection becomes necessary, I would start with the slot freeing
> and shrinker commits (fc8738c68d0b and 35e34642b599) as the most likely
> candidates given they add the most complexity to slot lifecycle
> management.
>
> If you haven't already, I recommend upgrading to the latest stable
> release of v6.18 (which is ... v6.18.4, I think?)

This fix:

  cbfd91d22776 ("nfsd: never defer requests during idmap lookup")

has the possibility of being highly relevant. It's in the nfsd-testing
branch of:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


-- 
Chuck Lever

