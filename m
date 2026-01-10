Return-Path: <linux-nfs+bounces-17731-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF372D0DF4C
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Jan 2026 00:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D549301F274
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jan 2026 23:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3537625A659;
	Sat, 10 Jan 2026 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXoft1+5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215550095C
	for <linux-nfs@vger.kernel.org>; Sat, 10 Jan 2026 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768088099; cv=none; b=oShSmpCkaKbip3BWnoENUtHBHVvCSwWgHJDnqRJod9xjHgMi8FHTIzLdDjsgFVLws/Ft+LviuyA9CPcxPLatecjJn3cDYZ90GQ6GPMLSB86DLYf8YcFfplSqPPf75uYmGjJBmrYcUt+Y0VKSz3LkWg3S6zuQLgtjzOScupO2zrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768088099; c=relaxed/simple;
	bh=Jqg9249WAhbP+z8PF0JaQL66dZSlUPQZESYtp3r39hs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iI1Ww5PuLegCRWxbKoZvpvUgzM+pA1DWP4GmOx2aoB8QETMHF1VYHvWu1IU9WJbP+BRaO/w3JhCGQnShOsHWyBgQKPN+jHSCsbsP73M6XEra/xZtncGcr+BgzGfjuA9LXMw4VljH396+Zy+WCT+XbPInA3pELCrm/Eh6LeLpsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXoft1+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95395C116C6;
	Sat, 10 Jan 2026 23:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768088098;
	bh=Jqg9249WAhbP+z8PF0JaQL66dZSlUPQZESYtp3r39hs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rXoft1+5ZurLhpyr15JTuo6rbQH/XUFO19+eM+q22LB5XlzN+WH7Y+kKx7v7yhftZ
	 JJBGYvaxL4l5j1tbL6kc/mAGVTth1Y4dazRo3OPN9M6LWzWENZ0dHiF5l2X3SYR+5U
	 20wYQHwmNygOdXUpSByQErm4pXOYDwopjWGl6KvaJ/rbndJbgeEUytataTkZVSh5C3
	 4W5+hPP+H8etVGoYndLg6QJU+Qvu0DXaTTJhz4FQJLQKeQfyhGb3GwFUC4iEgr3Ziv
	 xHNW8aKoiswdVlzJyT4s0FYmR8kppuDpVUWDYAUMAuxLXPoacoz0JkZQWHT1NX80R+
	 JlMaERqXwyM7g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A3AD7F40068;
	Sat, 10 Jan 2026 18:34:57 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 10 Jan 2026 18:34:57 -0500
X-ME-Sender: <xms:IeJiaQ32jxGa9HH-GZoYDCYr_ArRhKVIQd4k_QDXVhd8Lc0ql0gC3Q>
    <xme:IeJiaV5F5sbg9JMlH-ZFgcHzsFJR0_W3784WianI_gzEDuKarcK0Umtv0hhNRtzxC
    q2ei7S1iPpAXv_ZlIAIsChDHpoSWhUusGasXX3AgjyH-4Essyyc7hk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeftdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsnhhithiivghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopegthhhutghkrdhlvg
    hvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghl
    vgdrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IeJiabS8EdElriH6xveTmqLdtjw_u_fixJgbA8GqaZFBEQqc8ISYNA>
    <xmx:IeJiaRvGkw8tKKwi7booVgT0Prhs-dgTYC8r0AHete8QQ5dH524Gzw>
    <xmx:IeJiaVHLS_KrnyF_Vi-pmsDeOCOEwy1mduUJJsfM6YcIDRrVXlrvHA>
    <xmx:IeJiaawNPgG4Xh-i0JSR31xN5A3-aNOLgCn5bNLH-b3Fq8amxN7dVg>
    <xmx:IeJiaX1WS9Mnv73H88-Rqw5VbWI8h0VG7vBViXj4a3I9h9diPXbDvbfA>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7DB01780054; Sat, 10 Jan 2026 18:34:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1CkIJRtWFaZ
Date: Sat, 10 Jan 2026 18:33:59 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Mike Snitzer" <snitzer@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <eaac3112-eafc-4bc5-974f-752edf868788@app.fastmail.com>
In-Reply-To: <176808109160.2462021.5788018456330144196@noble.neil.brown.name>
References: <20260109215613.25250-1-cel@kernel.org>
 <176802301025.16766.5819430775313248993@noble.neil.brown.name>
 <63566a53-ed5a-4c0b-920d-22219c750354@app.fastmail.com>
 <176808109160.2462021.5788018456330144196@noble.neil.brown.name>
Subject: Re: [RFC PATCH v2] NFSD: Add asynchronous write throttling support for
 UNSTABLE WRITEs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Jan 10, 2026, at 4:38 PM, NeilBrown wrote:
> On Sun, 11 Jan 2026, Chuck Lever wrote:
>> 
>> On Sat, Jan 10, 2026, at 12:30 AM, NeilBrown wrote:
>> > On Sat, 10 Jan 2026, Chuck Lever wrote:
>> >> From: Chuck Lever <chuck.lever@oracle.com>
>> >> 
>> >> When memory pressure occurs during buffered writes, the traditional
>> >> approach is for balance_dirty_pages() to put the writing thread to
>> >> sleep until dirty pages are flushed. For NFSD, this means server
>> >> threads block waiting for I/O, reducing overall server throughput.
>> >> 
>> >> Add asynchronous write throttling for UNSTABLE writes using the
>> >> BDP_ASYNC flag to balance_dirty_pages_ratelimited_flags(). NFSD
>> >> checks memory pressure before attempting a buffered write. If the
>> >> call returns -EAGAIN (indicating memory exhaustion), NFSD returns
>> >> NFS4ERR_DELAY (or NFSERR_JUKEBOX for NFSv3) to the client instead
>> >> of blocking.
>> >> 
>> >> Clients then wait and retry, rather than tying up server memory with
>> >> a cached uncommitted write payload.
>> >> 
>> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> >> ---
>> >>  fs/nfsd/vfs.c | 24 ++++++++++++++++++++++++
>> >>  1 file changed, 24 insertions(+)
>> >> 
>> >> Compile tested only.
>> >> 
>> >> Changes since RFC v1:
>> >> - Remove the experimental debugfs setting
>> >> - Enforce throttling specifically only for UNSTABLE WRITEs
>> >> 
>> >> 
>> >> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> >> index 168d3ccc8155..c4550105234e 100644
>> >> --- a/fs/nfsd/vfs.c
>> >> +++ b/fs/nfsd/vfs.c
>> >> @@ -1458,6 +1458,30 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> >>  		}
>> >>  	}
>> >>  
>> >> +	/*
>> >> +	 * Throttle buffered writes under memory pressure. When dirty
>> >> +	 * page limits are exceeded, BDP_ASYNC causes -EAGAIN to be
>> >> +	 * returned rather than blocking the thread. This -EAGAIN
>> >> +	 * maps to nfserr_jukebox, signaling the client to back off
>> >> +	 * and retry rather than tying up a server thread during
>> >> +	 * writeback.
>> >> +	 *
>> >> +	 * NFSv2 writes commit to stable storage before reply; no
>> >> +	 * dirty pages accumulate, so throttling is unnecessary.
>> >> +	 * FILE_SYNC and DATA_SYNC writes flush immediately and do
>> >> +	 * not leave uncommitted dirty pages behind.
>> >> +	 * Direct I/O and DONTCACHE bypass the page cache entirely.
>> >> +	 */
>> >> +	if (rqstp->rq_vers > 2 &&
>> >> +	    stable == NFS_UNSTABLE &&
>> >> +	    nfsd_io_cache_write == NFSD_IO_BUFFERED) {
>> >> +		host_err =
>> >> +			balance_dirty_pages_ratelimited_flags(file->f_mapping,
>> >> +							      BDP_ASYNC);
>> >> +		if (host_err == -EAGAIN)
>> >> +			goto out_nfserr;
>> >
>> > I doubt that this will do what you want - at least not reliably.
>> >
>> > balance_dirty_pages_ratelimited_flags() assumes it will be called
>> > repeatedly by the same task and it lets that task write for a while,
>> > then blocks it, then lets it write some more.
>> >
>> > The way you have integrated it into nfsd could result in the write load
>> > bouncing around among different threads and behaving inconsistently.
>> >
>> > Also the delay imposed is (for a Linux client) between 100ms and
>> > 15seconds.
>> > I suspect that is often longer than we would want.  The actual pause
>> > imposed by page-writeback.c is variable based on the measured throughput
>> > of the backing device.
>> 
>> These are UNSTABLE WRITEs. I can understand delaying the COMMIT because
>> that's where NFSD requests synchronous interaction with the backing
>> device. But nothing delays an UNSTABLE WRITE if the backing device is
>> slow.
>
> That isn't correct.  If the "dirty threshold" is reached (e.g.  10% of
> memory dirty) then balance_dirty_pages() will delay all writes to avoid
> exceeding the dirty page limit.

That doesn't seem to be happening in some cases. Or perhaps, it is
happening, but the added delay is not aggressive enough.


>> > But maybe I'm seeing problems that don't exist.  Testing would help, but
>> > finding a mix of loads that properly stress the system would be a
>> > challenge.
>> >
>> > And maybe just allowing the thread pool to grow will make this a
>> > non-problem? 
>> 
>> I think allowing the thread pool to grow could make the memory problem
>> worse.
>
> At 4(?) pages per thread?

I'm talking about the WRITE payloads, not the thread footprint.

More threads means capacity to handle a higher rate of ingress UNSTABLE
WRITE traffic. I think we need a way for NFSD to complete those requests
quickly (with NFS4ERR_DELAY, for example) when the server is under duress
so that WRITE payloads pending on the transport queue or waiting to be
committed do not consume server memory until the server has the resources
to process the WRITEs.

Flow control, essentially.


> What exactly is "the memory problem"?  Do you have specific symptoms you
> are trying to address?  Have you had NFS server run out of memory and
> grind to a halt?

Review the past 9 months of Mike's work on direct I/O, published on
this mailing list. Hammerspace has measured this misbehavior and
experienced server melt-down. Their solution is to avoid using the
page cache entirely.

But even so there still seems to be an effective denial-of-service
vector by overloading NFSD with UNSTABLE WRITE traffic faster than
it can push it to persistence.

Perhaps we need better observability first.


-- 
Chuck Lever

