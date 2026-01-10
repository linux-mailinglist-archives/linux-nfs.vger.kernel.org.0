Return-Path: <linux-nfs+bounces-17727-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F28D0DE2E
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jan 2026 22:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82BC73006E1B
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jan 2026 21:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579EA23C50A;
	Sat, 10 Jan 2026 21:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="cNFC/yg3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DZuO05fu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453F238C0A
	for <linux-nfs@vger.kernel.org>; Sat, 10 Jan 2026 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768081102; cv=none; b=Jd80I60uoNmWA9ZTTlAWjOOHcNswNWC/jChudr5NZ/+IJ5YrpT8EQMqBnIFkZRCVaMNnvM0RauDGW5fgsc4u8uZWwYKyRrpnFmrJEw9yePbFg1WPfY3R9XFKgMd6WC0R96zkriwYzID8bkqyUMRiYnzr/iKQ+CNm8810r9cmWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768081102; c=relaxed/simple;
	bh=Lqph7n1UckLGDCkEe2zO1VqGzm+J5N4Ytbi/Cg6IKDM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LrJlpAA+MekVk5DDf7fVlXyzWK/rUILUjtIe16X+MOh1f7LYdpHWQ2c8k5Aug1EebK6WkgDLPMJYUDrkEidiZA1XI1yYLAU+ds0HmoTbx9iIOZTBofCayWIkTzlAQAS6agYPq21WT5qSIfcQ0ZgJzYFueIwpB9QVFN98LtbCf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=cNFC/yg3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DZuO05fu; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7F91E1D00095;
	Sat, 10 Jan 2026 16:38:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 10 Jan 2026 16:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768081098; x=1768167498; bh=y6uOdliJgi7B42xKIoM0H3XaUQ7krZpqAYz
	SCMxtLbU=; b=cNFC/yg34gXNjOtntNChPqsM26EqkYB1j2uHs2hc8TO+RjgVVen
	HYujn9vUGrX28Y0l14W82U8laZ3V0WAdjvj2berVjRhqaSZXSJLFqy9nhAAfqCou
	1KYA8lKT1y6xg+F0szm2aWaYmuclbCkQTrGEbJUwDvJ3jwE/cSeFbsvekXBLDt6W
	R1tlAafZ7y9emMkBSFl4JcSqua9cd2RT7SU1zilsz/rpWl1bYfnym1SfG1d7HBkC
	oa1Wcwu/0aLfFACsq2MaA8yEHCbYStzPdrQm/LZq/rLwLiMW58Nm/EQHxSkf3137
	hKkjEqdPTwYOldY4TEaoyi7YKfw4ZeJ3Lxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768081098; x=
	1768167498; bh=y6uOdliJgi7B42xKIoM0H3XaUQ7krZpqAYzSCMxtLbU=; b=D
	ZuO05fuSw8F9yR8FfxVWfoYlCG7+PdotWC5bbkKZzeMWL75pNmZYco6UodqbJU+4
	BCnlJCnFllOvF2/m632CvrTpS3fZnWf5+zPlJNcM4VHpd4bzUtLWvpeN5bHGwj1e
	3xQGYs2KFcyYYeNAQXJbymKIgttRpmDUXOurD+VZlFytHP8LjlmRogMcgxZbTGjK
	22BGMyFMB6igpe/kJFoxHlOoeAZ3TA8p0fv86ZMs3bwNGEUKFTU/GT5PylIFmPmh
	w/mKs2DKHo70/Bez2QqdS/AyxADqXL4a9lKQx1PdPakxYgs+n6zEv2F2WI+2rpsz
	XyJ2s71CH0W+ltdIApMEA==
X-ME-Sender: <xms:ycZiaSO60vVXGoj146CkCclTxGO1Vktm7pkmGd5vR1x9mRidQZc8VA>
    <xme:ycZiaTiT7CJ8ODFKjib8uUag4xcVQuJKxHxHadYbUfPyPxnnGCn5mQu-Mr4nm03Qk
    OWMUKFMqxUTiHWhrUmmU9JiiL9ZgREd90dpSlaYO8HZpTMx4A>
X-ME-Received: <xmr:ycZiac7TvDlXJVPNfGiAK1SmwDuECgb7RE86I94oAow6ThT9zz23C6Ukk4JU10qF7aba7oeMBUMqdk-cEmikA_UcbFqJJY2SY-MDtBqqiLir>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddvjeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ycZiaS34JS8_u2RT0e4p8AzxHImzieM29ahQiWMRaXhfp_h2jJFP6g>
    <xmx:ycZiaftIH4FMXHoRCVXNZ6dxNyj1fM-_9mKg1CpfdgY_HMkYbkAEaQ>
    <xmx:ycZiaQ5L6RhmkmIP6NhhW2bXh_4hZk40nZj7C6wjhebligVMYkxqfA>
    <xmx:ycZiaTeFslI6ICnfwqajZpSwuOmifqSXQY0Kevm9Yrq8i4R9MfBdag>
    <xmx:ysZiaWBGZ3breQKcXHyM6tV2hXaotcGkzs7nJ2rmHRJ4J2xDsH0cJLFu>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 16:38:15 -0500 (EST)
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
In-reply-to: <63566a53-ed5a-4c0b-920d-22219c750354@app.fastmail.com>
References: <20260109215613.25250-1-cel@kernel.org>,
 <176802301025.16766.5819430775313248993@noble.neil.brown.name>,
 <63566a53-ed5a-4c0b-920d-22219c750354@app.fastmail.com>
Date: Sun, 11 Jan 2026 08:38:11 +1100
Message-id: <176808109160.2462021.5788018456330144196@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 11 Jan 2026, Chuck Lever wrote:
>=20
> On Sat, Jan 10, 2026, at 12:30 AM, NeilBrown wrote:
> > On Sat, 10 Jan 2026, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>=20
> >> When memory pressure occurs during buffered writes, the traditional
> >> approach is for balance_dirty_pages() to put the writing thread to
> >> sleep until dirty pages are flushed. For NFSD, this means server
> >> threads block waiting for I/O, reducing overall server throughput.
> >>=20
> >> Add asynchronous write throttling for UNSTABLE writes using the
> >> BDP_ASYNC flag to balance_dirty_pages_ratelimited_flags(). NFSD
> >> checks memory pressure before attempting a buffered write. If the
> >> call returns -EAGAIN (indicating memory exhaustion), NFSD returns
> >> NFS4ERR_DELAY (or NFSERR_JUKEBOX for NFSv3) to the client instead
> >> of blocking.
> >>=20
> >> Clients then wait and retry, rather than tying up server memory with
> >> a cached uncommitted write payload.
> >>=20
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  fs/nfsd/vfs.c | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>=20
> >> Compile tested only.
> >>=20
> >> Changes since RFC v1:
> >> - Remove the experimental debugfs setting
> >> - Enforce throttling specifically only for UNSTABLE WRITEs
> >>=20
> >>=20
> >> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >> index 168d3ccc8155..c4550105234e 100644
> >> --- a/fs/nfsd/vfs.c
> >> +++ b/fs/nfsd/vfs.c
> >> @@ -1458,6 +1458,30 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> >>  		}
> >>  	}
> >> =20
> >> +	/*
> >> +	 * Throttle buffered writes under memory pressure. When dirty
> >> +	 * page limits are exceeded, BDP_ASYNC causes -EAGAIN to be
> >> +	 * returned rather than blocking the thread. This -EAGAIN
> >> +	 * maps to nfserr_jukebox, signaling the client to back off
> >> +	 * and retry rather than tying up a server thread during
> >> +	 * writeback.
> >> +	 *
> >> +	 * NFSv2 writes commit to stable storage before reply; no
> >> +	 * dirty pages accumulate, so throttling is unnecessary.
> >> +	 * FILE_SYNC and DATA_SYNC writes flush immediately and do
> >> +	 * not leave uncommitted dirty pages behind.
> >> +	 * Direct I/O and DONTCACHE bypass the page cache entirely.
> >> +	 */
> >> +	if (rqstp->rq_vers > 2 &&
> >> +	    stable =3D=3D NFS_UNSTABLE &&
> >> +	    nfsd_io_cache_write =3D=3D NFSD_IO_BUFFERED) {
> >> +		host_err =3D
> >> +			balance_dirty_pages_ratelimited_flags(file->f_mapping,
> >> +							      BDP_ASYNC);
> >> +		if (host_err =3D=3D -EAGAIN)
> >> +			goto out_nfserr;
> >
> > I doubt that this will do what you want - at least not reliably.
> >
> > balance_dirty_pages_ratelimited_flags() assumes it will be called
> > repeatedly by the same task and it lets that task write for a while,
> > then blocks it, then lets it write some more.
> >
> > The way you have integrated it into nfsd could result in the write load
> > bouncing around among different threads and behaving inconsistently.
> >
> > Also the delay imposed is (for a Linux client) between 100ms and
> > 15seconds.
> > I suspect that is often longer than we would want.  The actual pause
> > imposed by page-writeback.c is variable based on the measured throughput
> > of the backing device.
>=20
> These are UNSTABLE WRITEs. I can understand delaying the COMMIT because
> that's where NFSD requests synchronous interaction with the backing
> device. But nothing delays an UNSTABLE WRITE if the backing device is
> slow.

That isn't correct.  If the "dirty threshold" is reached (e.g.  10% of
memory dirty) then balance_dirty_pages() will delay all writes to avoid
exceeding the dirty page limit.
It attempts to monitor the recent throughput of each backing device, and
to divide available memory among then in the same proportion as
throughput, then throttle writes to backing devices using more than
their share.

>=20
> But I can see there could be significant fairness issues with the bdp
> approach here.
>=20
>=20
> > What we really want, I think, is to be able to push back on the client
> > by limiting the number of bytes in unacknowledged writes, but I don't
> > think NFS has any mechanism for that.
> >
> > I cannot immediately think of any approach that really shows promise,
> > but I suspect that it will involves a deeper interaction with the
> > writeback code in a way that abstracts out the task state so that nfsd
> > can appear to be one-task-per-client (or similar).
> >
> > Possibly the best approach for throttling the client is to somehow delay
> > the reply (without tying up a thread) so that it sees a fairly precise
> > latency....
>=20
> Set aside my threading comments for a moment. What I'm trying to prevent
> is UNSTABLE WRITEs tying up server /memory/. When under memory pressure,
> NFSD needs to delay UNSTABLE WRITEs until there is adequate memory to cache
> the WRITE payloads, without having to evict something more critical that
> could cause the server significant heartburn or livelock.

The writeback code already does this. The numbers in=20
  /proc/sys/vm/dirty_ratio
and
  /proc/sys/vm/dirty_bytes

can be used to set how much memory can store dirty pages (including
UNSTABLE writes in write-back).  Writers are throttled to attempt to
mostly keep within that limit.

>=20
> I'm considering another idea where the svc threads in each thread pool
> are all members of cgroup. That way the amount of memory dedicated to
> NFSD in one container (let's say) can be constrained, preventing it
> from overrunning memory resources needed to keep the server system up
> and otherwise responsive.

I have no direct experience with mem-cgroups so there are doubtless
subtleties that I miss, but I suspect the primary effect of including
nfsd in a mem-cgroup would be to push file content out of the page-cache
more quickly.  I don't think it can control dirty pages separately from
clean pages, but I could easily be wrong.

And that might be exactly what you want to happen.

>=20
>=20
> > But maybe I'm seeing problems that don't exist.  Testing would help, but
> > finding a mix of loads that properly stress the system would be a
> > challenge.
> >
> > And maybe just allowing the thread pool to grow will make this a
> > non-problem?=20
>=20
> I think allowing the thread pool to grow could make the memory problem
> worse.

At 4(?) pages per thread?

What exactly is "the memory problem"?  Do you have specific symptoms you
are trying to address?  Have you had NFS server run out of memory and
grind to a halt?

Thanks,
NeilBrown

>=20
>=20
> --=20
> Chuck Lever
>=20
>=20


