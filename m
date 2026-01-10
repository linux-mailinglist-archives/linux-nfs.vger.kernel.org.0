Return-Path: <linux-nfs+bounces-17726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F18D4D0DD61
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jan 2026 21:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D8A3301585C
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jan 2026 20:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783F527FD72;
	Sat, 10 Jan 2026 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXlDjwYt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550712135B8
	for <linux-nfs@vger.kernel.org>; Sat, 10 Jan 2026 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768076965; cv=none; b=dQNQ3/6UI5FAnbrslDF8/sqw79lWUmyh4b8hp0jRbz4psoNkwoYqW7lNml8u1worH6nuU775g8Q6d/WC4ofOXuZzTc0wnO89GHYyJMGcJzloEvudfo95Xp+0KmtPECTSmPE8N9bnsQ60nacKVNhrttssTe103v4f3NQqXawW1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768076965; c=relaxed/simple;
	bh=sZg4q8o81duKUEsX5qA6I1gIkLTG9G4sgXqcugh0U1M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QjEv2o7l58j3nvcVkhGZ16LJiD8A/2FKbQPwPYe3j5G+F82TdvhlAu9RJ/SRiqOcY8k77clO4xl/RS+qDZG+Yo4rtmnzyfBMPOLsIhVACywZ5hBHL8whYufEFLxx2goNX9Q7oOqqp8K7R7tiQndai9uKhG5pirzcE5kZyFweRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXlDjwYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE38C4CEF7;
	Sat, 10 Jan 2026 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768076964;
	bh=sZg4q8o81duKUEsX5qA6I1gIkLTG9G4sgXqcugh0U1M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tXlDjwYtugIDuZj23ZO1PjJrlwDh9LQzU0o43qk3PdRkrKCPzjvIoOLW0lGq8Socm
	 0+4+ymLh+afy+fZCMh1mJxv7RciU9YtWeHb+otQz4SFmzyJpjI6SREgTAHhG4VGsxe
	 w7kqFoJcTt3AHG+C//avNoIdh7ZkJA/xSlgaLnfwAeJ7SDB/v2v3Ijg2k+oq1S0y8A
	 KUExkW6dIiFVL9mOLTPEX51yIvvNCTE7AUrO4dixNYWc7DmrdimaXQX9SLQY1La+ga
	 yCxAhczrAcxio6tapJFCSEV81esqvbPrsbRho95QZfg5+Vj75hf9EMEQNvuOB92CnE
	 LxGUOKM+xRJDg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 997C5F40068;
	Sat, 10 Jan 2026 15:29:23 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 10 Jan 2026 15:29:23 -0500
X-ME-Sender: <xms:o7ZiaUbQ4YhIrTRN6YHmbr8H4omPefHfx9sd37IRSFCfvmzWKoK0Bg>
    <xme:o7ZiaaNlW7nTszExenNh5wR45dTrFcgWVzm7NpBjSWVLiXjnkBRckl01ZZucDnnZ8
    iRviZK2tUh95fEfQtuP9dQ6AGXjnma5O3kF2G90ttjtQH48SdAQnqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddvieeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:o7ZiafU5w5tc6TWGqJKYPnnZ8YFjgQ-Zr1H1Tvv3Ac06maAy8VEAqQ>
    <xmx:o7ZiaciAmqlimof8nqJJudiczrox_QJgy4Mddc1XZkcSblNdcqHeew>
    <xmx:o7Ziafq0XLBvHbZGoWAzqqvqKCU_H7WDYedpmviY_xyHV2NgOTg5cg>
    <xmx:o7ZiaaFgKxbGCv2EDb9nATUPrbDN5xB4njpA7a2ONf_pHITQrBO_pw>
    <xmx:o7Ziac7Gu-Sg09wejq8kksGpAbhD1MjkS2uKlALD48JetJHd10BYBLbr>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 77A7C780054; Sat, 10 Jan 2026 15:29:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1CkIJRtWFaZ
Date: Sat, 10 Jan 2026 15:28:51 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Mike Snitzer" <snitzer@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <63566a53-ed5a-4c0b-920d-22219c750354@app.fastmail.com>
In-Reply-To: <176802301025.16766.5819430775313248993@noble.neil.brown.name>
References: <20260109215613.25250-1-cel@kernel.org>
 <176802301025.16766.5819430775313248993@noble.neil.brown.name>
Subject: Re: [RFC PATCH v2] NFSD: Add asynchronous write throttling support for
 UNSTABLE WRITEs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Jan 10, 2026, at 12:30 AM, NeilBrown wrote:
> On Sat, 10 Jan 2026, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> When memory pressure occurs during buffered writes, the traditional
>> approach is for balance_dirty_pages() to put the writing thread to
>> sleep until dirty pages are flushed. For NFSD, this means server
>> threads block waiting for I/O, reducing overall server throughput.
>> 
>> Add asynchronous write throttling for UNSTABLE writes using the
>> BDP_ASYNC flag to balance_dirty_pages_ratelimited_flags(). NFSD
>> checks memory pressure before attempting a buffered write. If the
>> call returns -EAGAIN (indicating memory exhaustion), NFSD returns
>> NFS4ERR_DELAY (or NFSERR_JUKEBOX for NFSv3) to the client instead
>> of blocking.
>> 
>> Clients then wait and retry, rather than tying up server memory with
>> a cached uncommitted write payload.
>> 
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/vfs.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>> 
>> Compile tested only.
>> 
>> Changes since RFC v1:
>> - Remove the experimental debugfs setting
>> - Enforce throttling specifically only for UNSTABLE WRITEs
>> 
>> 
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 168d3ccc8155..c4550105234e 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1458,6 +1458,30 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  		}
>>  	}
>>  
>> +	/*
>> +	 * Throttle buffered writes under memory pressure. When dirty
>> +	 * page limits are exceeded, BDP_ASYNC causes -EAGAIN to be
>> +	 * returned rather than blocking the thread. This -EAGAIN
>> +	 * maps to nfserr_jukebox, signaling the client to back off
>> +	 * and retry rather than tying up a server thread during
>> +	 * writeback.
>> +	 *
>> +	 * NFSv2 writes commit to stable storage before reply; no
>> +	 * dirty pages accumulate, so throttling is unnecessary.
>> +	 * FILE_SYNC and DATA_SYNC writes flush immediately and do
>> +	 * not leave uncommitted dirty pages behind.
>> +	 * Direct I/O and DONTCACHE bypass the page cache entirely.
>> +	 */
>> +	if (rqstp->rq_vers > 2 &&
>> +	    stable == NFS_UNSTABLE &&
>> +	    nfsd_io_cache_write == NFSD_IO_BUFFERED) {
>> +		host_err =
>> +			balance_dirty_pages_ratelimited_flags(file->f_mapping,
>> +							      BDP_ASYNC);
>> +		if (host_err == -EAGAIN)
>> +			goto out_nfserr;
>
> I doubt that this will do what you want - at least not reliably.
>
> balance_dirty_pages_ratelimited_flags() assumes it will be called
> repeatedly by the same task and it lets that task write for a while,
> then blocks it, then lets it write some more.
>
> The way you have integrated it into nfsd could result in the write load
> bouncing around among different threads and behaving inconsistently.
>
> Also the delay imposed is (for a Linux client) between 100ms and
> 15seconds.
> I suspect that is often longer than we would want.  The actual pause
> imposed by page-writeback.c is variable based on the measured throughput
> of the backing device.

These are UNSTABLE WRITEs. I can understand delaying the COMMIT because
that's where NFSD requests synchronous interaction with the backing
device. But nothing delays an UNSTABLE WRITE if the backing device is
slow.

But I can see there could be significant fairness issues with the bdp
approach here.


> What we really want, I think, is to be able to push back on the client
> by limiting the number of bytes in unacknowledged writes, but I don't
> think NFS has any mechanism for that.
>
> I cannot immediately think of any approach that really shows promise,
> but I suspect that it will involves a deeper interaction with the
> writeback code in a way that abstracts out the task state so that nfsd
> can appear to be one-task-per-client (or similar).
>
> Possibly the best approach for throttling the client is to somehow delay
> the reply (without tying up a thread) so that it sees a fairly precise
> latency....

Set aside my threading comments for a moment. What I'm trying to prevent
is UNSTABLE WRITEs tying up server /memory/. When under memory pressure,
NFSD needs to delay UNSTABLE WRITEs until there is adequate memory to cache
the WRITE payloads, without having to evict something more critical that
could cause the server significant heartburn or livelock.

I'm considering another idea where the svc threads in each thread pool
are all members of cgroup. That way the amount of memory dedicated to
NFSD in one container (let's say) can be constrained, preventing it
from overrunning memory resources needed to keep the server system up
and otherwise responsive.


> But maybe I'm seeing problems that don't exist.  Testing would help, but
> finding a mix of loads that properly stress the system would be a
> challenge.
>
> And maybe just allowing the thread pool to grow will make this a
> non-problem? 

I think allowing the thread pool to grow could make the memory problem
worse.


-- 
Chuck Lever

