Return-Path: <linux-nfs+bounces-14638-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28791B988A9
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 09:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE23F17D7C5
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 07:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E02927A45C;
	Wed, 24 Sep 2025 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="diCunIhN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZwzEdNoB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81E26281
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699052; cv=none; b=Hhcb76gXiJ1pGTMAjFa3L06/Sxz90mBUo/z1R2PA1DXL71AZ+oTRLYEIqNxQ79XCQsMo4sxTPBXWubXIYW5sxnXRKjD557R2orbBepN4RwVnrDUUlZEXO+22iYHCHOrs+sHqnkEJHWNC1GXzMbekdlLB+fT7wiIkGeWCeZpwFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699052; c=relaxed/simple;
	bh=njBy16cp7w9iBMgmbjD1e6oQFXdCxrbEBDzV3WbDuBs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=mlRaA2P8DQDbaMK2iCdCRMGuIlxzN/AidozO0VPMR+8dNypmmj9AR3850G57vBm/JnqCitbI8hZPwU6wDVUrN3rNqEJ5L3gcQrMtF/xKhn6gL6F2T7cQXIvCW7lyTDWByz+5z1WhTDEzL0FBRcgSt8HNSZjT2tNA8FDJrVg55Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=diCunIhN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZwzEdNoB; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B446EEC0106;
	Wed, 24 Sep 2025 03:30:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 24 Sep 2025 03:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758699048; x=1758785448; bh=BydN9+69bHHTBE0Dvb+Vyj6EduCa6SuNlhy
	YINQQVo8=; b=diCunIhNWs1Z+uiDDOtcVG2XUUXaH11frPCtevIUyMZr09cJDks
	D76sNmovkUHkN1CcK6p6gRE4DTpRyW3IEQPtiiFYIPVZFtn/3mUODrSLnBNURS1i
	SQMrZTyYxBABEKsx+hf1iTdpPVI29mNbMt33j7HOTIcXQiSVmlVJW7E+ZKZOriAf
	8MLonf4FoFw3ku/GsO9Els0WKdIb12efk5u82qDQDeq5y0tlpdPvH/6ImLQmL6Ry
	LZk68Uo3b0irQMNsp4SvB2OhjWRLTkoMG666fRTqhZGo+tT8sVMD/7FDIWCqBr67
	X4Pr/bidKWooeuBCK/u4HEs9VqbMrcNeTkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758699048; x=
	1758785448; bh=BydN9+69bHHTBE0Dvb+Vyj6EduCa6SuNlhyYINQQVo8=; b=Z
	wzEdNoBCwtfxCz4jBikXGTCBm5s/gzl3JNwEy5OEQK+RiL7Qe7zEP7hnk/2ESG83
	gHNtpXLR1cu3fJKBhNcN2cqKwfQhF6THAfUcALBCTKSzcvW7AegUlsH3A4OCMa5Y
	s5pwHqvfg9nCFP6vhO1xLi8Wu9OT/gUkjqC2BYn227d8OULPD+Rxdkdw6KF6Sb+A
	XiSv6C5bxbHs0Iubwaf8QlsNbfyR+MsgJ1IL1Dvc2hp4JetG4ffTXlqKkX0W1Zvg
	6dzHtqQFhoEMBQNCWs2lgeD692qFly9SAU7hV0167V1mPRVHH2l34B1fwkYLX4vA
	UwGdvxIlMiUlNH6Q17XeA==
X-ME-Sender: <xms:KJ7TaHeDat_OQzcOry2RAWjzMImx6jiwKCtH-gjrCCIYJwHJ2F_m7g>
    <xme:KJ7TaMTek8QDTxSi3pyQuxRLhmURd0hcaCg0tarJh_T6fs9JqWR3fIMBSUVMiV9gD
    c033ro5vfyxLyL1lHo06bVnVfOovbJkX3-SdvMsUl3AZs2X>
X-ME-Received: <xmr:KJ7TaGuvVnVXAhcU6h9t6o2hetWYNSz8jMHGZbUIQxvLEHZFfeDbBkmU1AVs1OnMmFJ4DTg6sHWU90v3oe7gUJwlWriH91_bF1hSrVWm6S4->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifedtudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:KJ7TaFfwD82mCGAq7zZEhk9vqJL4esDbCqmPi5BoV9H6y8Ol7lfRgA>
    <xmx:KJ7TaIYNKszghEDGu2glYq-cL3YziKxTiF01QVKPm0dBG1Nz0kM5FQ>
    <xmx:KJ7TaPYjTkKBMe212HwuA_WqWPcKE7h_LLZH6VNetd9ODT6P-jQO1g>
    <xmx:KJ7TaFKkH23Faj_d0lun7PkUp4HaHnnHaZzM8TUivSm_-00hMYyrtg>
    <xmx:KJ7TaDBxIZlTKJtC78TRh_mC_HFW4ep6SCxLrXLEgiR863sKUDjNKTs8>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 03:30:45 -0400 (EDT)
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
In-reply-to: <60960803-80b3-4ca1-9fd3-16bc1bd1dbd4@kernel.org>
References: <20250922141137.632525-1-cel@kernel.org>,
 <20250922141137.632525-4-cel@kernel.org>, <aNMei7Ax5CbsR_Qz@kernel.org>,
 <19eef754-57d9-4fe4-a6e6-a481dcec470e@kernel.org>,
 <175867132212.1696783.15488731457039328170@noble.neil.brown.name>,
 <60960803-80b3-4ca1-9fd3-16bc1bd1dbd4@kernel.org>
Date: Wed, 24 Sep 2025 17:30:38 +1000
Message-id: <175869903827.1696783.17181184352630252525@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 24 Sep 2025, Chuck Lever wrote:
> On 9/23/25 4:48 PM, NeilBrown wrote:
> > On Wed, 24 Sep 2025, Chuck Lever wrote:
> >> On 9/23/25 3:26 PM, Mike Snitzer wrote:
> >>> On Mon, Sep 22, 2025 at 10:11:37AM -0400, Chuck Lever wrote:
> >>>> From: Chuck Lever <chuck.lever@oracle.com>
> >>>>
> >>>> Add an experimental option that forces NFS READ operations to use
> >>>> direct I/O instead of reading through the NFS server's page cache.
> >>>>
> >>>> There are already other layers of caching:
> >>>>  - The page cache on NFS clients
> >>>>  - The block device underlying the exported file system
> >>>>
> >>>> The server's page cache, in many cases, is unlikely to provide
> >>>> additional benefit. Some benchmarks have demonstrated that the
> >>>> server's page cache is actively detrimental for workloads whose
> >>>> working set is larger than the server's available physical memory.
> >>>>
> >>>> For instance, on small NFS servers, cached NFS file content can
> >>>> squeeze out local memory consumers. For large sequential workloads,
> >>>> an enormous amount of data flows into and out of the page cache
> >>>> and is consumed by NFS clients exactly once -- caching that data
> >>>> is expensive to do and totally valueless.
> >>>>
> >>>> For now this is a hidden option that can be enabled on test
> >>>> systems for benchmarking. In the longer term, this option might
> >>>> be enabled persistently or per-export. When the exported file
> >>>> system does not support direct I/O, NFSD falls back to using
> >>>> either DONTCACHE or buffered I/O to fulfill NFS READ requests.
> >>>>
> >>>> Suggested-by: Mike Snitzer <snitzer@kernel.org>
> >>>> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> >>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >>>> ---
> >>>>  fs/nfsd/debugfs.c |  2 ++
> >>>>  fs/nfsd/nfsd.h    |  1 +
> >>>>  fs/nfsd/trace.h   |  1 +
> >>>>  fs/nfsd/vfs.c     | 82 +++++++++++++++++++++++++++++++++++++++++++++++
> >>>>  4 files changed, 86 insertions(+)
> >>>>
> >>>> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> >>>> index ed2b9e066206..00eb1ecef6ac 100644
> >>>> --- a/fs/nfsd/debugfs.c
> >>>> +++ b/fs/nfsd/debugfs.c
> >>>> @@ -44,6 +44,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get=
, nfsd_dsr_set, "%llu\n");
> >>>>   * Contents:
> >>>>   *   %0: NFS READ will use buffered IO
> >>>>   *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> >>>> + *   %2: NFS READ will use direct IO
> >>>>   *
> >>>>   * This setting takes immediate effect for all NFS versions,
> >>>>   * all exports, and in all NFSD net namespaces.
> >>>> @@ -64,6 +65,7 @@ static int nfsd_io_cache_read_set(void *data, u64 va=
l)
> >>>>  		nfsd_io_cache_read =3D NFSD_IO_BUFFERED;
> >>>>  		break;
> >>>>  	case NFSD_IO_DONTCACHE:
> >>>> +	case NFSD_IO_DIRECT:
> >>>>  		/*
> >>>>  		 * Must disable splice_read when enabling
> >>>>  		 * NFSD_IO_DONTCACHE.
> >>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> >>>> index ea87b42894dd..bdb60ee1f1a4 100644
> >>>> --- a/fs/nfsd/nfsd.h
> >>>> +++ b/fs/nfsd/nfsd.h
> >>>> @@ -157,6 +157,7 @@ enum {
> >>>>  	/* Any new NFSD_IO enum value must be added at the end */
> >>>>  	NFSD_IO_BUFFERED,
> >>>>  	NFSD_IO_DONTCACHE,
> >>>> +	NFSD_IO_DIRECT,
> >>>>  };
> >>>> =20
> >>>>  extern u64 nfsd_io_cache_read __read_mostly;
> >>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> >>>> index 6e2c8e2aab10..bfd41236aff2 100644
> >>>> --- a/fs/nfsd/trace.h
> >>>> +++ b/fs/nfsd/trace.h
> >>>> @@ -464,6 +464,7 @@ DEFINE_EVENT(nfsd_io_class, nfsd_##name,	\
> >>>>  DEFINE_NFSD_IO_EVENT(read_start);
> >>>>  DEFINE_NFSD_IO_EVENT(read_splice);
> >>>>  DEFINE_NFSD_IO_EVENT(read_vector);
> >>>> +DEFINE_NFSD_IO_EVENT(read_direct);
> >>>>  DEFINE_NFSD_IO_EVENT(read_io_done);
> >>>>  DEFINE_NFSD_IO_EVENT(read_done);
> >>>>  DEFINE_NFSD_IO_EVENT(write_start);
> >>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >>>> index 35880d3f1326..ddcd812f0761 100644
> >>>> --- a/fs/nfsd/vfs.c
> >>>> +++ b/fs/nfsd/vfs.c
> >>>> @@ -1074,6 +1074,82 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp,=
 struct svc_fh *fhp,
> >>>>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_e=
rr);
> >>>>  }
> >>>> =20
> >>>> +/*
> >>>> + * The byte range of the client's READ request is expanded on both
> >>>> + * ends until it meets the underlying file system's direct I/O
> >>>> + * alignment requirements. After the internal read is complete, the
> >>>> + * byte range of the NFS READ payload is reduced to the byte range
> >>>> + * that was originally requested.
> >>>> + *
> >>>> + * Note that a direct read can be done only when the xdr_buf
> >>>> + * containing the NFS READ reply does not already have contents in
> >>>> + * its .pages array. This is due to potentially restrictive
> >>>> + * alignment requirements on the read buffer. When .page_len and
> >>>> + * @base are zero, the .pages array is guaranteed to be page-
> >>>> + * aligned.
> >>>> + */
> >>>
> >>> So this ^ comment (and the related conversation with Neil in a
> >>> different thread) says page_len should be 0 on entry to
> >>> nfsd_direct_read.
> >>>
> >>>> @@ -1106,6 +1182,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, s=
truct svc_fh *fhp,
> >>>>  	switch (nfsd_io_cache_read) {
> >>>>  	case NFSD_IO_BUFFERED:
> >>>>  		break;
> >>>> +	case NFSD_IO_DIRECT:
> >>>> +		if (nf->nf_dio_read_offset_align &&
> >>>> +		    rqstp->rq_res.page_len && !base)
> >>>> +			return nfsd_direct_read(rqstp, fhp, nf, offset,
> >>>> +						count, eof);
> >>>> +		fallthrough;
> >>>
> >>> Yet the nfsd_iter_read is only calling nfsd_direct_read() if
> >>> rqstp->rq_res.page_len is not zero, shouldn't it be
> >>> !rqstp->rq_res.page_len ?
> >>
> >> Oops, yes. I did this work last week, while out of range of my lab.
> >>
> >>
> >>> (testing confirms it should be !rqstp->rq_res.page_len)
> >>>
> >>> Hopefully with this fix you can have more confidence in staging this
> >>> in your nfsd-testing?
> >> I'm waiting only for Neil to send an R-b.
> >=20
> > After noticing, like Mike, that the page_len test was inverted I went
> > looking to see where page_len was updated, to be sure that a second READ
> > request would not try to use DIRECT IO.
> > I can see that nfsd_splice_actor() updates page_len, but I cannot see
> > where it is updated when nfsd_iter_read() is used.
> >=20
> > What am I missing?
>=20
> It might be updated while the NFSv4 reply encoder is encoding a
> COMPOUND. If the size of the RPC reply so far is larger than the
> xdr_buf's .head, the xdr_stream will be positioned somewhere in the
> xdr_buf's .pages array.
>=20
> This is precisely why splice READ can be used only for the first
> NFSv4 READ operation in a COMPOUND. Subsequent READ operations
> must use nfsd_iter_read().

Hmmmm...

nfsd4_encode_readv() calls xdr_reserve_space_vec() passing maxcount from
the READ request.  The maxcount is passed to xdr_reserve_space()
repeatedly (one page at a time) where it is added to xdr->buf->page_len
(where xdr is ->rq_res_stream and xdr->buf is rq_res).

So the result is often that rq_res.page_len will be maxcount.

Then nfsd4_encode_readv() calls nfsd_iter_read() which, with this patch,
will test rq_res.page_len, which will always be non-zero.
So that isn't what we want.

(after the read, nfsd4_encode_readv() will call xdr_truncate_encode()
 which will reduce ->page_len based on how much was read).

Then nfsd4_encode_readv() calls nfsd_iter_read().

I don't think we can use ->page_len to determine if it is safe to use
nfsd_direct_read().  The conditions where nfsd_direct_read() is safe are
similar to the conditions where nfsd_splice_read() is safe.  Maybe we
should use similar code.

Thanks,
NeilBrown

