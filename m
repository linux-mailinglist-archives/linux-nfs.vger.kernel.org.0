Return-Path: <linux-nfs+bounces-17721-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C75DD0CFDD
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jan 2026 06:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61B5B3020498
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jan 2026 05:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07BE1DF736;
	Sat, 10 Jan 2026 05:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="cqnvERNT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FADzBS12"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899C248867
	for <linux-nfs@vger.kernel.org>; Sat, 10 Jan 2026 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768023019; cv=none; b=H0H/HXCnjJyT152655XDbt978J6dbe0EQGdwTKlfzoA2UyeT/I+RktR9BK6DhvaTh6AyuTKGO5ocvcjBKLIJDCM7HVww1ATvxrJIYv8wM4bhXxUA8eazd74b20MaiiR2Sq5O0Uw7gemWhkxZGCMlJhUVrOoR3ECF+lDyJdTkT8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768023019; c=relaxed/simple;
	bh=wVPyIUhzKPXUabt6OgFLtJB72HjfkCj3Jt4nB7JuR3I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=stdpgMSOfXF/z7g8KBHLYrRmPP1gbUqnexmWXCbm0iBvktY9xbD/rvCqtzu/lxKjMQx5XmBJlf5LcsxI9gTPswkz84EEblfMmExC24c1DDoCAncaL4ZhXD8a4fOvY27YlFMVALjdMS2XVtWTXY7PEnn7pEYQRojjVdQAZ8jpUKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=cqnvERNT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FADzBS12; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE11614000B3;
	Sat, 10 Jan 2026 00:30:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 10 Jan 2026 00:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768023016; x=1768109416; bh=spgHAZhdHMi1QNakbZeeBihuF6rmw61AB3r
	Vk0/XYP4=; b=cqnvERNT6X+4RGCwbVM85HvdBzfhbHQHT8mHyozRAatU04Nt5xx
	NCogImSmmw/LK4b4hDb4bf2pe7R1UT66vEloUHXxoZFly00Irb43KIc4lUg30PVY
	mlqeICBW/gBMTpKERJEflbMP+0b4lRjxnlRJqOJ889vxYDUcB1wr5HxCs/034Odm
	wCUzZCD0f8aFmTYa5lZBDbkRIdJ+zytHfQrJ5tqvAPrzcKHhjfNbnCWU4VcRQ0FJ
	NQm97gmXqPZZwvPTl+i00sjyQiFYQDuuW6HxtOV+P1YC0GGAmJPfpaG511V2IsIC
	J07PlUNf7iyakhBse8QwdNpGdc6ZHIZ0Ouw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768023016; x=
	1768109416; bh=spgHAZhdHMi1QNakbZeeBihuF6rmw61AB3rVk0/XYP4=; b=F
	ADzBS12bU1dDGyn1b1f0x4fNNxNQFvKpmgikKmOmLhrWkt1DpLw1SShgb7dROgGD
	OquaHKidMSyYrG1KuIv5t7NCEXgmJWZD/wGheDdbwtJt+VKlejlcZhdhQo/mSs7o
	7YK9EWCUn038ToYMvZ8pLp4QCRU2SNfBX4bKAjZQn/LaI+cA3Qu/duPtddft1++2
	hi8Mm1fgp+0Zg5MLqlX4asQ61Cu8orclzEJaCHybG1SytOwsvyJoEPZSq0idywup
	2mnwkhvFIwbBkJ+92ML/J2K8KBQ7Mc3v82lT2E4lA1jjG8S/QNQ5LJnnkwJjYeFN
	pSPS1OXY6gO6sM/7RCMoQ==
X-ME-Sender: <xms:6ONhafDRvYltIW4RkwMkvdlMv0qrSJtb5uaYGQt9wf5-JEBxGkR35w>
    <xme:6ONhaYHjYwzD9Fy2yPkmBSjqzp_W1kPiIP1R-dxQyw2b5RhZJSZ9J8ZBfAe7Z2F09
    s9C4JQMP37e-aHXq0XgG0wye2q0ZeNYk2EJX2eV28AkQr4heQ>
X-ME-Received: <xmr:6ONhaeOY9ySerDDVEOtOiyGoL0aueXFALJlGojFNKOycD9JVpS5WO7bkdSrzQgl_W0ifyynUiRzKVSEsBhCqZnlVypeLXCMpEmUZ4IqcWe1J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddtkeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:6ONhaR7AmAlhJAH-XL-DHb7kn-G-vVsfWDU-tWodYpDzLRPSkUlVcA>
    <xmx:6ONhaZjwzPOmZu3C4T7-TPyCBlwVa0ubryszKr6McKwvFe9-OLjg6A>
    <xmx:6ONhaee2LJxsiqbii6LaM5FREqwFJIDxrDeAdmOV_FsVR3ijQ4gWjA>
    <xmx:6ONhaZxmWGOp_lL9yKehh-NeJyqe7OSVWfi3wRSvvlwYc4uBjgGmbg>
    <xmx:6ONhacGuy9_oNNzkI9Caodx5CCWZB87D75T86PlJSp_g-XdafcQsgzxX>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 00:30:13 -0500 (EST)
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
In-reply-to: <20260109215613.25250-1-cel@kernel.org>
References: <20260109215613.25250-1-cel@kernel.org>
Date: Sat, 10 Jan 2026 16:30:10 +1100
Message-id: <176802301025.16766.5819430775313248993@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 10 Jan 2026, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> When memory pressure occurs during buffered writes, the traditional
> approach is for balance_dirty_pages() to put the writing thread to
> sleep until dirty pages are flushed. For NFSD, this means server
> threads block waiting for I/O, reducing overall server throughput.
>=20
> Add asynchronous write throttling for UNSTABLE writes using the
> BDP_ASYNC flag to balance_dirty_pages_ratelimited_flags(). NFSD
> checks memory pressure before attempting a buffered write. If the
> call returns -EAGAIN (indicating memory exhaustion), NFSD returns
> NFS4ERR_DELAY (or NFSERR_JUKEBOX for NFSv3) to the client instead
> of blocking.
>=20
> Clients then wait and retry, rather than tying up server memory with
> a cached uncommitted write payload.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> Compile tested only.
>=20
> Changes since RFC v1:
> - Remove the experimental debugfs setting
> - Enforce throttling specifically only for UNSTABLE WRITEs
>=20
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 168d3ccc8155..c4550105234e 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1458,6 +1458,30 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  		}
>  	}
> =20
> +	/*
> +	 * Throttle buffered writes under memory pressure. When dirty
> +	 * page limits are exceeded, BDP_ASYNC causes -EAGAIN to be
> +	 * returned rather than blocking the thread. This -EAGAIN
> +	 * maps to nfserr_jukebox, signaling the client to back off
> +	 * and retry rather than tying up a server thread during
> +	 * writeback.
> +	 *
> +	 * NFSv2 writes commit to stable storage before reply; no
> +	 * dirty pages accumulate, so throttling is unnecessary.
> +	 * FILE_SYNC and DATA_SYNC writes flush immediately and do
> +	 * not leave uncommitted dirty pages behind.
> +	 * Direct I/O and DONTCACHE bypass the page cache entirely.
> +	 */
> +	if (rqstp->rq_vers > 2 &&
> +	    stable =3D=3D NFS_UNSTABLE &&
> +	    nfsd_io_cache_write =3D=3D NFSD_IO_BUFFERED) {
> +		host_err =3D
> +			balance_dirty_pages_ratelimited_flags(file->f_mapping,
> +							      BDP_ASYNC);
> +		if (host_err =3D=3D -EAGAIN)
> +			goto out_nfserr;

I doubt that this will do what you want - at least not reliably.

balance_dirty_pages_ratelimited_flags() assumes it will be called
repeatedly by the same task and it lets that task write for a while,
then blocks it, then lets it write some more.

The way you have integrated it into nfsd could result in the write load
bouncing around among different threads and behaving inconsistently.

Also the delay imposed is (for a Linux client) between 100ms and
15seconds.
I suspect that is often longer than we would want.  The actual pause
imposed by page-writeback.c is variable based on the measured throughput
of the backing device.

What we really want, I think, is to be able to push back on the client
by limiting the number of bytes in unacknowledged writes, but I don't
think NFS has any mechanism for that.

I cannot immediately think of any approach that really shows promise,
but I suspect that it will involves a deeper interaction with the
writeback code in a way that abstracts out the task state so that nfsd
can appear to be one-task-per-client (or similar).

Possibly the best approach for throttling the client is to somehow delay
the reply (without tying up a thread) so that it sees a fairly precise
latency....=20


But maybe I'm seeing problems that don't exist.  Testing would help, but
finding a mix of loads that properly stress the system would be a
challenge.

And maybe just allowing the thread pool to grow will make this a
non-problem?=20

Thanks,
NeilBrown


> +	}
> +
>  	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> =20
>  	since =3D READ_ONCE(file->f_wb_err);
> --=20
> 2.52.0
>=20
>=20
>=20


