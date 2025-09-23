Return-Path: <linux-nfs+bounces-14633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0867B97D1E
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 01:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A7F4A83FC
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Sep 2025 23:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C52FD7BD;
	Tue, 23 Sep 2025 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="G4MsTvCy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O5In4GZQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE92F657A
	for <linux-nfs@vger.kernel.org>; Tue, 23 Sep 2025 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758671332; cv=none; b=eXJVTCFanMlfc2aKfZaP6XDq+0Z+kfKceMA7AEUBseQ9uV52jUh1qhn6OWisL+nDjcnEJEYO/B+exfxlgg9+5LHjK8YQQl05UChKaBlU+8a/erulztH63vvqRGGwsYODtXBC0u9gcekC3iOe5F2leYba+7cak5GdjUsGCTlQ8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758671332; c=relaxed/simple;
	bh=Klipm6fJuj76VDVGc+fU2mQ3pVNxNQQ5X/tZ8kTxUMg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=b1crl7ZfRJrP9SsnY+i6Ay1APvis/SMJ2z5CtWUfTRN33FUU2xdkUyYBbfmJiWd3NnAgo0aV1I/b/FESRVvml1t3/4REm7t7m4xYoXAw2P0k4QdlFwltya5SO7odfZkS20SzPWOhhFrAosGmF6KGicf/45UchhQHt7VmDUZk+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=G4MsTvCy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O5In4GZQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E2471400082;
	Tue, 23 Sep 2025 19:48:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 23 Sep 2025 19:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758671329; x=1758757729; bh=fWEzUUWuswmL/LjVfBJZnfY6KBkaHZdWM4A
	k5zYM/jU=; b=G4MsTvCy0H470sOgVfxUmo52gavqKKRN6K3yeU0yZ0LucXO+7lF
	Kf58ZjJWz6F7Fpo9q12qBBR0tUb40F/SCX5I3nEu5X6qpkfZg37zTgogKH16Bp3E
	ckjhyIt/fN02lS3vNINjOxHhg7kzMH6sty1KgtGqnXlFUCxK5xhc0qoUtoE+R1sa
	8AiKjG5eb3MEQQh/e6Gw5sJM7xV/Hh/okGw3+9FZbsKhTixheA2n2aCWfMC5rnoR
	FQMDsfmMZjTbgE4Ek4emrDBGQoCUmFSa+7SJE/D8cYPbtFKD1bsBhHZcYScDecgP
	TRNMTrwEuqsr6l3tQ1z7cprYHpVRj7vd0GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758671329; x=
	1758757729; bh=fWEzUUWuswmL/LjVfBJZnfY6KBkaHZdWM4Ak5zYM/jU=; b=O
	5In4GZQlr08wkNhYtWy09pCvVO16mQ5URzYQbhbkQyrNW/S4dd2edmJijSyf1Eke
	Us/Z+uGmxinfVk31nmuz8JmFWhY/Pg2C7HG7QyxjiUnrGVAe62i2ATHVljJJ/GPm
	Rrnp+OHLrEfj9gG8SyrRh7Pe+ygm+NQ5mYZX4/pe4+mTqgsaupQoCGiMCkJf+r9Q
	8nrezpeES/2zLY1TGg37BDZZbQ4iy5MHYkaTlcAZsULwZP5nVnTutzXiGJGLgGpk
	xKHuDr9zmEcXRfH62W+usQKst9Mce238MoPSLC7X3fC4lw9hez/V2KFzoCrgpwxL
	vUNyuxdVozK2uqL+aKLfw==
X-ME-Sender: <xms:4DHTaN2JQLzqncajMKBg54-Z2-ag45dM5Z3SofyFH22-mQnuVCLlew>
    <xme:4DHTaDI8fG_rXDo3I2yOd5Rk6fl3_gliJSI2_HumUrY2OODLU24k6m8cY7D_jnZr6
    ikABgCt9rxT5V4p_8SxB6U4Rt6ibNVjw4wD5Jn3utzsk1iUdWk>
X-ME-Received: <xmr:4DHTaEFLn4PiSR5NEdB6eBPYiXw-FZffXr-KQbK2yzBOszMEfCkbXBt8gedL6DW3V1SSKyv4aOTFqxVhEg7PItDddAAA-kMhfUFdaQ_2gDKb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehsnhhithiivghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    grhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:4DHTaHWORFuNj1UCeWXtowOIERg6SfpVRo3604nGNFESPNO2xYmklQ>
    <xmx:4DHTaExUSGamKJ1WF2vjeREwKlH1wM7kL-J9DUFYtljyXIi7fgaldg>
    <xmx:4DHTaEQqUAdRP5k7l1l3gW-_HHfoBKBE02_WO0opAvKYRppPv09vQQ>
    <xmx:4DHTaIhnjpQpIoVFafPnfdfHa7IJzHsUKcMwEdCrws_IYQXZG2CJPQ>
    <xmx:4THTaIb0PDALRdcEIxOotxgdLBUbW0_YucjdxINV5rPeCq9xPNSaq31L>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 19:48:46 -0400 (EDT)
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
Cc: "Mike Snitzer" <snitzer@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
In-reply-to: <19eef754-57d9-4fe4-a6e6-a481dcec470e@kernel.org>
References: <20250922141137.632525-1-cel@kernel.org>,
 <20250922141137.632525-4-cel@kernel.org>, <aNMei7Ax5CbsR_Qz@kernel.org>,
 <19eef754-57d9-4fe4-a6e6-a481dcec470e@kernel.org>
Date: Wed, 24 Sep 2025 09:48:42 +1000
Message-id: <175867132212.1696783.15488731457039328170@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 24 Sep 2025, Chuck Lever wrote:
> On 9/23/25 3:26 PM, Mike Snitzer wrote:
> > On Mon, Sep 22, 2025 at 10:11:37AM -0400, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> Add an experimental option that forces NFS READ operations to use
> >> direct I/O instead of reading through the NFS server's page cache.
> >>
> >> There are already other layers of caching:
> >>  - The page cache on NFS clients
> >>  - The block device underlying the exported file system
> >>
> >> The server's page cache, in many cases, is unlikely to provide
> >> additional benefit. Some benchmarks have demonstrated that the
> >> server's page cache is actively detrimental for workloads whose
> >> working set is larger than the server's available physical memory.
> >>
> >> For instance, on small NFS servers, cached NFS file content can
> >> squeeze out local memory consumers. For large sequential workloads,
> >> an enormous amount of data flows into and out of the page cache
> >> and is consumed by NFS clients exactly once -- caching that data
> >> is expensive to do and totally valueless.
> >>
> >> For now this is a hidden option that can be enabled on test
> >> systems for benchmarking. In the longer term, this option might
> >> be enabled persistently or per-export. When the exported file
> >> system does not support direct I/O, NFSD falls back to using
> >> either DONTCACHE or buffered I/O to fulfill NFS READ requests.
> >>
> >> Suggested-by: Mike Snitzer <snitzer@kernel.org>
> >> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> >> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  fs/nfsd/debugfs.c |  2 ++
> >>  fs/nfsd/nfsd.h    |  1 +
> >>  fs/nfsd/trace.h   |  1 +
> >>  fs/nfsd/vfs.c     | 82 +++++++++++++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 86 insertions(+)
> >>
> >> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> >> index ed2b9e066206..00eb1ecef6ac 100644
> >> --- a/fs/nfsd/debugfs.c
> >> +++ b/fs/nfsd/debugfs.c
> >> @@ -44,6 +44,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, =
nfsd_dsr_set, "%llu\n");
> >>   * Contents:
> >>   *   %0: NFS READ will use buffered IO
> >>   *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> >> + *   %2: NFS READ will use direct IO
> >>   *
> >>   * This setting takes immediate effect for all NFS versions,
> >>   * all exports, and in all NFSD net namespaces.
> >> @@ -64,6 +65,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
> >>  		nfsd_io_cache_read =3D NFSD_IO_BUFFERED;
> >>  		break;
> >>  	case NFSD_IO_DONTCACHE:
> >> +	case NFSD_IO_DIRECT:
> >>  		/*
> >>  		 * Must disable splice_read when enabling
> >>  		 * NFSD_IO_DONTCACHE.
> >> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> >> index ea87b42894dd..bdb60ee1f1a4 100644
> >> --- a/fs/nfsd/nfsd.h
> >> +++ b/fs/nfsd/nfsd.h
> >> @@ -157,6 +157,7 @@ enum {
> >>  	/* Any new NFSD_IO enum value must be added at the end */
> >>  	NFSD_IO_BUFFERED,
> >>  	NFSD_IO_DONTCACHE,
> >> +	NFSD_IO_DIRECT,
> >>  };
> >> =20
> >>  extern u64 nfsd_io_cache_read __read_mostly;
> >> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> >> index 6e2c8e2aab10..bfd41236aff2 100644
> >> --- a/fs/nfsd/trace.h
> >> +++ b/fs/nfsd/trace.h
> >> @@ -464,6 +464,7 @@ DEFINE_EVENT(nfsd_io_class, nfsd_##name,	\
> >>  DEFINE_NFSD_IO_EVENT(read_start);
> >>  DEFINE_NFSD_IO_EVENT(read_splice);
> >>  DEFINE_NFSD_IO_EVENT(read_vector);
> >> +DEFINE_NFSD_IO_EVENT(read_direct);
> >>  DEFINE_NFSD_IO_EVENT(read_io_done);
> >>  DEFINE_NFSD_IO_EVENT(read_done);
> >>  DEFINE_NFSD_IO_EVENT(write_start);
> >> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >> index 35880d3f1326..ddcd812f0761 100644
> >> --- a/fs/nfsd/vfs.c
> >> +++ b/fs/nfsd/vfs.c
> >> @@ -1074,6 +1074,82 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, s=
truct svc_fh *fhp,
> >>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err=
);
> >>  }
> >> =20
> >> +/*
> >> + * The byte range of the client's READ request is expanded on both
> >> + * ends until it meets the underlying file system's direct I/O
> >> + * alignment requirements. After the internal read is complete, the
> >> + * byte range of the NFS READ payload is reduced to the byte range
> >> + * that was originally requested.
> >> + *
> >> + * Note that a direct read can be done only when the xdr_buf
> >> + * containing the NFS READ reply does not already have contents in
> >> + * its .pages array. This is due to potentially restrictive
> >> + * alignment requirements on the read buffer. When .page_len and
> >> + * @base are zero, the .pages array is guaranteed to be page-
> >> + * aligned.
> >> + */
> >=20
> > So this ^ comment (and the related conversation with Neil in a
> > different thread) says page_len should be 0 on entry to
> > nfsd_direct_read.
> >=20
> >> @@ -1106,6 +1182,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
> >>  	switch (nfsd_io_cache_read) {
> >>  	case NFSD_IO_BUFFERED:
> >>  		break;
> >> +	case NFSD_IO_DIRECT:
> >> +		if (nf->nf_dio_read_offset_align &&
> >> +		    rqstp->rq_res.page_len && !base)
> >> +			return nfsd_direct_read(rqstp, fhp, nf, offset,
> >> +						count, eof);
> >> +		fallthrough;
> >=20
> > Yet the nfsd_iter_read is only calling nfsd_direct_read() if
> > rqstp->rq_res.page_len is not zero, shouldn't it be
> > !rqstp->rq_res.page_len ?
>=20
> Oops, yes. I did this work last week, while out of range of my lab.
>=20
>=20
> > (testing confirms it should be !rqstp->rq_res.page_len)
> >=20
> > Hopefully with this fix you can have more confidence in staging this
> > in your nfsd-testing?
> I'm waiting only for Neil to send an R-b.

After noticing, like Mike, that the page_len test was inverted I went
looking to see where page_len was updated, to be sure that a second READ
request would not try to use DIRECT IO.
I can see that nfsd_splice_actor() updates page_len, but I cannot see
where it is updated when nfsd_iter_read() is used.

What am I missing?

NeilBrown

