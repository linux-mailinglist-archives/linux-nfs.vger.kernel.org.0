Return-Path: <linux-nfs+bounces-17737-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA28D108CF
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 05:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7907E301FF4E
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 04:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DC21A0B15;
	Mon, 12 Jan 2026 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="FBrQhBvX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="seo3a1YO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E821CC71
	for <linux-nfs@vger.kernel.org>; Mon, 12 Jan 2026 04:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768191326; cv=none; b=S/JyFKG//vUWrBfuYFj38UjPJXFp0rz4hFzJqbAtUX/2FkxUXACNBuby3HUne47Fkxnk8ALVDLB/0gYHQffHPRMUIl6/gLCN4SG9KDo6kEJf0CpZa+gfmxuxSybkysnGnrtm70Njf5Yq7zBiI50btBi3PNd+ytYfD9MzaZXzgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768191326; c=relaxed/simple;
	bh=wNEGWef3dIRxBXsfBV757Xr7Kdt5hYB5IunPAfNnw5c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=iIqsGXyMsyUjB5t1L4FGp8l2wK8wzH3+jRiyQY+eiT4wUPXQJ9Y/XG/Wh9NpDpuL10blDC/TUJWEWMn8oO6zW9qu98MxEgXhgziviojYm/MPKy44hr6ZskdJdaAFxnw3PPtelAmukZI/vO/AG6Q+85KtxfzqcxmVokHkBsYoQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=FBrQhBvX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=seo3a1YO; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B2687A0060;
	Sun, 11 Jan 2026 23:15:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 11 Jan 2026 23:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768191323; x=1768277723; bh=SAU7uY0XP1CmGdEUBCRJigeey+ASyzpziST
	p21/wszc=; b=FBrQhBvXmwogUT34UIuKjqD1ymRnryXDI7q7jtcDk7pf5c0yN2i
	fWk8Y2+3fPoVCOI9vkF+dnDFAsOPSH0MDHgQtoN0a8NUj7pHIKeLncnzV7UmTgGC
	Ky5udylxrG2fQD8qumAeabUwlbTa/g0aRf9uIT2R3Nnl4KEuLGNjehvdCA0OFKs4
	2D3JsAVxzpTd5Y2OrUd6yBfgpMCixDMJ+fOJjtRVQEgXHWZRTMi+iWMYUc8Li7We
	3oVlggGYKI4Ir8M0HstOpnwbVypibq2HmqMXBevOkdNsZmbIQs4ZE7vaA6l1k9PC
	ad0CadfIoheZAArINRbIjHLDfxZEX/76yCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768191323; x=
	1768277723; bh=SAU7uY0XP1CmGdEUBCRJigeey+ASyzpziSTp21/wszc=; b=s
	eo3a1YOuxB5+rjFdG2UH+pKYAwVRTP7g+8g5DZkDQh5TIjYdc7TKSzKdsYH0HQRF
	SPyzcchV57itt3Au2cwbHAI4b+AU00LtuR3AQwMdFQ5yDyFqbiGbk3alzT3/WogG
	97izP/8M/2hnEiq909wSrvsPRAlh0RDwNBs8FGOcuTqu+GufaMlHH/Vy1tCulFgx
	xhr6XoNnWQsVed4nZ8aedTXX1J7FH00FcpRi43KmHDwXkQkfl5SL9B79wtXbGOI0
	Cm8QPQZMiZpM2aHnh6gJaWS+rYwtwwMupOW4y3K9PUcmdsX/wKDrDJ/NuQgCEfQS
	Z7nA9kNo8LDdmM32heyqw==
X-ME-Sender: <xms:W3Vkadzsvrc_-oRwUFOkuWB9_wlCmEcmsUe9icdY81OmbrabJ5g0GQ>
    <xme:W3Vkaf1hnBopzmVsjJWAQDEqB4KwWZzVvO6GCshgD6ZqbhY_z4aI2FtklDlLjt4Ip
    Xk5bTadiWiS3uYxYJ_Bj_5YKy_hoe4A-EA7X9jRv5AG5DCV>
X-ME-Received: <xmr:W3Vkaa_b-BZX6xB1WxM8PKfpMRnv1papka30QByKz4qGtJPvkLouNzG71_fjmsH38BP7VGeQ2kcg9H144_y8vThsqsVqrQpIn716mggHVLoe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeigeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepshhnihhtiigvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:W3Vkafp4NbIweUiDnq_45x1OWFLMEoJ6eYQCesSgnk9gL_mCdU9oZA>
    <xmx:W3VkaURObb-N-z7sCqkusdPMXsZpgrkC_cCCZIIUGfXjQgRZDqhxOQ>
    <xmx:W3VkaSMhLebZkEMT8Vd8_uP7lWw3Xkp_uIq918ak8iGj4rhn1Cp2og>
    <xmx:W3VkaSiKRzzIxSM4cko74WswF9ShXyan6cr0k02HIvRB9-eYbwO4XA>
    <xmx:W3Vkad0Lt6_OvjpFaTumOZvXczFJOHfl7SA977QxXJr6ZT0wYH13nEYX>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 23:15:20 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Mike Snitzer" <snitzer@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH v2] NFSD: Add asynchronous write throttling support
 for UNSTABLE WRITEs
In-reply-to: <eaac3112-eafc-4bc5-974f-752edf868788@app.fastmail.com>
References: <20260109215613.25250-1-cel@kernel.org>,
 <176802301025.16766.5819430775313248993@noble.neil.brown.name>,
 <63566a53-ed5a-4c0b-920d-22219c750354@app.fastmail.com>,
 <176808109160.2462021.5788018456330144196@noble.neil.brown.name>,
 <eaac3112-eafc-4bc5-974f-752edf868788@app.fastmail.com>
Date: Mon, 12 Jan 2026 15:15:19 +1100
Message-id: <176819131921.16766.16091990973366244227@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 11 Jan 2026, Chuck Lever wrote:
>=20
> On Sat, Jan 10, 2026, at 4:38 PM, NeilBrown wrote:
> > On Sun, 11 Jan 2026, Chuck Lever wrote:
> >>=20
> >> On Sat, Jan 10, 2026, at 12:30 AM, NeilBrown wrote:
> >> > On Sat, 10 Jan 2026, Chuck Lever wrote:
> >> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> >>=20
> >> >> When memory pressure occurs during buffered writes, the traditional
> >> >> approach is for balance_dirty_pages() to put the writing thread to
> >> >> sleep until dirty pages are flushed. For NFSD, this means server
> >> >> threads block waiting for I/O, reducing overall server throughput.
> >> >>=20
> >> >> Add asynchronous write throttling for UNSTABLE writes using the
> >> >> BDP_ASYNC flag to balance_dirty_pages_ratelimited_flags(). NFSD
> >> >> checks memory pressure before attempting a buffered write. If the
> >> >> call returns -EAGAIN (indicating memory exhaustion), NFSD returns
> >> >> NFS4ERR_DELAY (or NFSERR_JUKEBOX for NFSv3) to the client instead
> >> >> of blocking.
> >> >>=20
> >> >> Clients then wait and retry, rather than tying up server memory with
> >> >> a cached uncommitted write payload.
> >> >>=20
> >> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> >> ---
> >> >>  fs/nfsd/vfs.c | 24 ++++++++++++++++++++++++
> >> >>  1 file changed, 24 insertions(+)
> >> >>=20
> >> >> Compile tested only.
> >> >>=20
> >> >> Changes since RFC v1:
> >> >> - Remove the experimental debugfs setting
> >> >> - Enforce throttling specifically only for UNSTABLE WRITEs
> >> >>=20
> >> >>=20
> >> >> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >> >> index 168d3ccc8155..c4550105234e 100644
> >> >> --- a/fs/nfsd/vfs.c
> >> >> +++ b/fs/nfsd/vfs.c
> >> >> @@ -1458,6 +1458,30 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> >> >>  		}
> >> >>  	}
> >> >> =20
> >> >> +	/*
> >> >> +	 * Throttle buffered writes under memory pressure. When dirty
> >> >> +	 * page limits are exceeded, BDP_ASYNC causes -EAGAIN to be
> >> >> +	 * returned rather than blocking the thread. This -EAGAIN
> >> >> +	 * maps to nfserr_jukebox, signaling the client to back off
> >> >> +	 * and retry rather than tying up a server thread during
> >> >> +	 * writeback.
> >> >> +	 *
> >> >> +	 * NFSv2 writes commit to stable storage before reply; no
> >> >> +	 * dirty pages accumulate, so throttling is unnecessary.
> >> >> +	 * FILE_SYNC and DATA_SYNC writes flush immediately and do
> >> >> +	 * not leave uncommitted dirty pages behind.
> >> >> +	 * Direct I/O and DONTCACHE bypass the page cache entirely.
> >> >> +	 */
> >> >> +	if (rqstp->rq_vers > 2 &&
> >> >> +	    stable =3D=3D NFS_UNSTABLE &&
> >> >> +	    nfsd_io_cache_write =3D=3D NFSD_IO_BUFFERED) {
> >> >> +		host_err =3D
> >> >> +			balance_dirty_pages_ratelimited_flags(file->f_mapping,
> >> >> +							      BDP_ASYNC);
> >> >> +		if (host_err =3D=3D -EAGAIN)
> >> >> +			goto out_nfserr;
> >> >
> >> > I doubt that this will do what you want - at least not reliably.
> >> >
> >> > balance_dirty_pages_ratelimited_flags() assumes it will be called
> >> > repeatedly by the same task and it lets that task write for a while,
> >> > then blocks it, then lets it write some more.
> >> >
> >> > The way you have integrated it into nfsd could result in the write load
> >> > bouncing around among different threads and behaving inconsistently.
> >> >
> >> > Also the delay imposed is (for a Linux client) between 100ms and
> >> > 15seconds.
> >> > I suspect that is often longer than we would want.  The actual pause
> >> > imposed by page-writeback.c is variable based on the measured throughp=
ut
> >> > of the backing device.
> >>=20
> >> These are UNSTABLE WRITEs. I can understand delaying the COMMIT because
> >> that's where NFSD requests synchronous interaction with the backing
> >> device. But nothing delays an UNSTABLE WRITE if the backing device is
> >> slow.
> >
> > That isn't correct.  If the "dirty threshold" is reached (e.g.  10% of
> > memory dirty) then balance_dirty_pages() will delay all writes to avoid
> > exceeding the dirty page limit.
>=20
> That doesn't seem to be happening in some cases. Or perhaps, it is
> happening, but the added delay is not aggressive enough.

I would be surprised if that actual count of dirty pages
   grep Dirty /proc/meminfo

grows much above the dirty page limit.  There is some elasticity so the
threads don't need to check global variables on every page - only every
1024 pages or something like that - so the nominal limit can be exceeded
briefly.  But there should still be bounds and if nfsd is being allowed
to dirty significantly more pages then it should, then that is a problem
well beyond nfsd.

>=20
>=20
> >> > But maybe I'm seeing problems that don't exist.  Testing would help, b=
ut
> >> > finding a mix of loads that properly stress the system would be a
> >> > challenge.
> >> >
> >> > And maybe just allowing the thread pool to grow will make this a
> >> > non-problem?=20
> >>=20
> >> I think allowing the thread pool to grow could make the memory problem
> >> worse.
> >
> > At 4(?) pages per thread?
>=20
> I'm talking about the WRITE payloads, not the thread footprint.

hmmmm..
My footprint calculation was extemely wrong.  I didn't allow for the
rq_pages allocation - so add 1MB or more per thread.

But the write payload cannot get beyond the thread footprint without
creating dirty pages, which are limited.

>=20
> More threads means capacity to handle a higher rate of ingress UNSTABLE
> WRITE traffic. I think we need a way for NFSD to complete those requests
> quickly (with NFS4ERR_DELAY, for example) when the server is under duress
> so that WRITE payloads pending on the transport queue or waiting to be
> committed do not consume server memory until the server has the resources
> to process the WRITEs.
>=20
> Flow control, essentially.

The transport queue already has flow control (for TCP).   And the threads
allocate a large rq_pages whether they are serving WRITEs or not.

So when the server is under memory duress, the threads will block in
bdp, which will push back on the transport queue once all threads are
blocked...=20

>=20
>=20
> > What exactly is "the memory problem"?  Do you have specific symptoms you
> > are trying to address?  Have you had NFS server run out of memory and
> > grind to a halt?
>=20
> Review the past 9 months of Mike's work on direct I/O, published on
> this mailing list. Hammerspace has measured this misbehavior and
> experienced server melt-down. Their solution is to avoid using the
> page cache entirely.

I didn't pay very close attention but I thought the assessment was that
adding lots of single-use pages to the page cache, and then having to
clean them out later, caused a lot of unnecessary work that was best
avoided, and that drop-behind addressed this.

Are you trying to find another way to address the same problem?

>=20
> But even so there still seems to be an effective denial-of-service
> vector by overloading NFSD with UNSTABLE WRITE traffic faster than
> it can push it to persistence.
>=20
> Perhaps we need better observability first.

It would definitely be helpful to have numbers to categorise the
problem.
I think there *is* flow control in place.  A NFS server can certainly
consume all the bandwidth to storage, but I don't see how it is able to
consume all of memory (providing the number of threads is "appropriate"
for the total amount of memory).

Thanks,
NeilBrown

