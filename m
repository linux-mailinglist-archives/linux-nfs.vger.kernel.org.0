Return-Path: <linux-nfs+bounces-14728-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC00BA20BA
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 02:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705051BC7969
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 00:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6303F2B2DA;
	Fri, 26 Sep 2025 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="H62xgSMe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6bMJBpG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D5B747F
	for <linux-nfs@vger.kernel.org>; Fri, 26 Sep 2025 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758845928; cv=none; b=MAm0lzE2RMFp8RA5tsMzcgLHy56Po+7YnYbzBAWqKKVUf4V63R0bAzm04hD/TWU+o99cNUmDOL1KVAg8mrlindBf4MER/mUgVjkBdbhSbw7XnLiGiKKDEAV3bxezXiUXXv6fRD5Eo7+PE93Ddp6ojFTZLy369Cx5Yl+4Qy1KpOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758845928; c=relaxed/simple;
	bh=FAxAt/Y9A4B/D8jSdzCXyFrlCmqhmk5p44hU3J1hpzs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gZRI47K8focv2X0aVq0WilKPlZBmK8aFaierGV3rtEEOvA1ntGv2ljrMV+Cpue51xrtGOIgrpiQq+WrjCQfcn9b40ELJ+83JWS1mfLFRyJ1XJatybJyp0MmxtDg2ckXWij/jWv+vebWB2QwfvWpUtZBDMvJp9cTEbkq0qRDMGgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=H62xgSMe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K6bMJBpG; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D17C140009B;
	Thu, 25 Sep 2025 20:18:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 25 Sep 2025 20:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758845925; x=1758932325; bh=ufzHrXfMzjftc+w8df2zjUmBcsb36/ZBbuZ
	eXmLItxc=; b=H62xgSMe/Ts8fa1e9D+XrJCVqae7lUibdqIrLCniQ2jQhbp73Ef
	OWzjTF8DAWD7CVC3B5LAY+ukvKW60nBwU6LM+0P5bGfFrr9zzVnM5DuoaRAL0230
	X4Zj7BQfCuIdxTP7EKb1C2ha+/OYDlqRAtIlWmajZ5jT5t4V1RNb3fPjNq4MKDRI
	CvASirbJ+2OGtWLBOfDKLpwMuyKbDT7lZRUA99CQ/dbMVO1/MVcoeWvdTabU1iQ2
	1+bUWnGCMjjOK7CWK7/lKxQq/I+AYBgxZaXj3sF5VNRptWyeZxLjilM0txtbYLv9
	2ku6ZiGlM6uOQdDgHCIvCKEX+k879ASfvdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758845925; x=
	1758932325; bh=ufzHrXfMzjftc+w8df2zjUmBcsb36/ZBbuZeXmLItxc=; b=K
	6bMJBpGX7RwlRTEP36cNR4L25Z9fex0FKHb/AZJYy2Q+LNfvD+pPRNAymdc+eU4g
	gab0TfgP0a/pLIKvpDFMR7XAurlySWZ8NX8WJOLnlQD2Gui8fsvMEoSSWtoI367P
	04rASB46Vtco6MUDE9fcyeDX4dOnXEaVviJsxg8xkRdoEwkzSdmyvJ57FIulqw1G
	mBjp2wmiXMuWKEW0UoZrYB/upwTl3LRDQJ2RhO2t9e0NTujVXyGarDJdD5O31Sc4
	Hbce0jIUS8flKrwmXX4nfM9VeKQHSYro1W+rBVhkhsgcx0rASZV1zSyY/PQT5BKY
	7dMna34z3YDw6I6uPr7sA==
X-ME-Sender: <xms:5NvVaEWm9VjnUENlLwPshWY_1iLqPn5Sx2BCwjBooEqRm7qZ-GKwew>
    <xme:5NvVaHrE_j8Rnt0tuSdJNTHHpOlWM7rCVnLtLaIKFc5dPUWIarGwWTBbn4Rv-n6Jm
    m6xtLEGq9w95H6PclV9WRkpENFbILahQjjZY-1RJsOioRum1A>
X-ME-Received: <xmr:5NvVaOkBBKR2hy2Y2JmVhJmNQMAp6Erd_siA2EKu-L-uZZFx3Pakl3RaMR3CQ5RCQOLBjA3eljcYbYR17-6oas29jaS-IkuPQD-9GpuTDImk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeeludcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:5dvVaP1DIbVjwVZ4gCRSDzgQjK3thi_6csJF9kDHgwGFp059lWC3Gw>
    <xmx:5dvVaDTPuT12XDieODCoRdODxKQeZ0i4BH09XiqbJdTgTn8rRk0GTA>
    <xmx:5dvVaAzv7TQgaDzz4tzlbusjeyDjdfricG3eKoi3fSak8JKRCUrPLg>
    <xmx:5dvVaLDg5pfT778dGjxRxtwSBViCxdv8Dpqbwsmt4IQkn9rzXnU18g>
    <xmx:5dvVaC6NgckWCz62Xp-sSyd5qvjvIowYTX21cfOdHzUAgtQyACZGSFZE>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 20:18:42 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
In-reply-to: <aNP8U48TjSFmRhbD@kernel.org>
References: <20250922141137.632525-1-cel@kernel.org>,
 <20250922141137.632525-4-cel@kernel.org>, <aNMei7Ax5CbsR_Qz@kernel.org>,
 <19eef754-57d9-4fe4-a6e6-a481dcec470e@kernel.org>,
 <175867132212.1696783.15488731457039328170@noble.neil.brown.name>,
 <60960803-80b3-4ca1-9fd3-16bc1bd1dbd4@kernel.org>,
 <175869903827.1696783.17181184352630252525@noble.neil.brown.name>,
 <aNP8U48TjSFmRhbD@kernel.org>
Date: Fri, 26 Sep 2025 10:18:40 +1000
Message-id: <175884592062.1696783.9463281013443874072@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 25 Sep 2025, Mike Snitzer wrote:
> On Wed, Sep 24, 2025 at 05:30:38PM +1000, NeilBrown wrote:
> > On Wed, 24 Sep 2025, Chuck Lever wrote:
> > > On 9/23/25 4:48 PM, NeilBrown wrote:
> > > > On Wed, 24 Sep 2025, Chuck Lever wrote:
> > > >> On 9/23/25 3:26 PM, Mike Snitzer wrote:
> > > >>> On Mon, Sep 22, 2025 at 10:11:37AM -0400, Chuck Lever wrote:
> > > >>>> From: Chuck Lever <chuck.lever@oracle.com>
> > > >>>>
> > > >>>> Add an experimental option that forces NFS READ operations to use
> > > >>>> direct I/O instead of reading through the NFS server's page cache.
> > > >>>>
> > > >>>> There are already other layers of caching:
> > > >>>>  - The page cache on NFS clients
> > > >>>>  - The block device underlying the exported file system
> > > >>>>
> > > >>>> The server's page cache, in many cases, is unlikely to provide
> > > >>>> additional benefit. Some benchmarks have demonstrated that the
> > > >>>> server's page cache is actively detrimental for workloads whose
> > > >>>> working set is larger than the server's available physical memory.
> > > >>>>
> > > >>>> For instance, on small NFS servers, cached NFS file content can
> > > >>>> squeeze out local memory consumers. For large sequential workloads,
> > > >>>> an enormous amount of data flows into and out of the page cache
> > > >>>> and is consumed by NFS clients exactly once -- caching that data
> > > >>>> is expensive to do and totally valueless.
> > > >>>>
> > > >>>> For now this is a hidden option that can be enabled on test
> > > >>>> systems for benchmarking. In the longer term, this option might
> > > >>>> be enabled persistently or per-export. When the exported file
> > > >>>> system does not support direct I/O, NFSD falls back to using
> > > >>>> either DONTCACHE or buffered I/O to fulfill NFS READ requests.
> > > >>>>
> > > >>>> Suggested-by: Mike Snitzer <snitzer@kernel.org>
> > > >>>> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> > > >>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > >>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > >>>> ---
> > > >>>>  fs/nfsd/debugfs.c |  2 ++
> > > >>>>  fs/nfsd/nfsd.h    |  1 +
> > > >>>>  fs/nfsd/trace.h   |  1 +
> > > >>>>  fs/nfsd/vfs.c     | 82 ++++++++++++++++++++++++++++++++++++++++++=
+++++
> > > >>>>  4 files changed, 86 insertions(+)
> > > >>>>
> > > >>>> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > > >>>> index ed2b9e066206..00eb1ecef6ac 100644
> > > >>>> --- a/fs/nfsd/debugfs.c
> > > >>>> +++ b/fs/nfsd/debugfs.c
> > > >>>> @@ -44,6 +44,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr=
_get, nfsd_dsr_set, "%llu\n");
> > > >>>>   * Contents:
> > > >>>>   *   %0: NFS READ will use buffered IO
> > > >>>>   *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> > > >>>> + *   %2: NFS READ will use direct IO
> > > >>>>   *
> > > >>>>   * This setting takes immediate effect for all NFS versions,
> > > >>>>   * all exports, and in all NFSD net namespaces.
> > > >>>> @@ -64,6 +65,7 @@ static int nfsd_io_cache_read_set(void *data, u6=
4 val)
> > > >>>>  		nfsd_io_cache_read =3D NFSD_IO_BUFFERED;
> > > >>>>  		break;
> > > >>>>  	case NFSD_IO_DONTCACHE:
> > > >>>> +	case NFSD_IO_DIRECT:
> > > >>>>  		/*
> > > >>>>  		 * Must disable splice_read when enabling
> > > >>>>  		 * NFSD_IO_DONTCACHE.
> > > >>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > >>>> index ea87b42894dd..bdb60ee1f1a4 100644
> > > >>>> --- a/fs/nfsd/nfsd.h
> > > >>>> +++ b/fs/nfsd/nfsd.h
> > > >>>> @@ -157,6 +157,7 @@ enum {
> > > >>>>  	/* Any new NFSD_IO enum value must be added at the end */
> > > >>>>  	NFSD_IO_BUFFERED,
> > > >>>>  	NFSD_IO_DONTCACHE,
> > > >>>> +	NFSD_IO_DIRECT,
> > > >>>>  };
> > > >>>> =20
> > > >>>>  extern u64 nfsd_io_cache_read __read_mostly;
> > > >>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > >>>> index 6e2c8e2aab10..bfd41236aff2 100644
> > > >>>> --- a/fs/nfsd/trace.h
> > > >>>> +++ b/fs/nfsd/trace.h
> > > >>>> @@ -464,6 +464,7 @@ DEFINE_EVENT(nfsd_io_class, nfsd_##name,	\
> > > >>>>  DEFINE_NFSD_IO_EVENT(read_start);
> > > >>>>  DEFINE_NFSD_IO_EVENT(read_splice);
> > > >>>>  DEFINE_NFSD_IO_EVENT(read_vector);
> > > >>>> +DEFINE_NFSD_IO_EVENT(read_direct);
> > > >>>>  DEFINE_NFSD_IO_EVENT(read_io_done);
> > > >>>>  DEFINE_NFSD_IO_EVENT(read_done);
> > > >>>>  DEFINE_NFSD_IO_EVENT(write_start);
> > > >>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > >>>> index 35880d3f1326..ddcd812f0761 100644
> > > >>>> --- a/fs/nfsd/vfs.c
> > > >>>> +++ b/fs/nfsd/vfs.c
> > > >>>> @@ -1074,6 +1074,82 @@ __be32 nfsd_splice_read(struct svc_rqst *rq=
stp, struct svc_fh *fhp,
> > > >>>>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, ho=
st_err);
> > > >>>>  }
> > > >>>> =20
> > > >>>> +/*
> > > >>>> + * The byte range of the client's READ request is expanded on both
> > > >>>> + * ends until it meets the underlying file system's direct I/O
> > > >>>> + * alignment requirements. After the internal read is complete, t=
he
> > > >>>> + * byte range of the NFS READ payload is reduced to the byte range
> > > >>>> + * that was originally requested.
> > > >>>> + *
> > > >>>> + * Note that a direct read can be done only when the xdr_buf
> > > >>>> + * containing the NFS READ reply does not already have contents in
> > > >>>> + * its .pages array. This is due to potentially restrictive
> > > >>>> + * alignment requirements on the read buffer. When .page_len and
> > > >>>> + * @base are zero, the .pages array is guaranteed to be page-
> > > >>>> + * aligned.
> > > >>>> + */
> > > >>>
> > > >>> So this ^ comment (and the related conversation with Neil in a
> > > >>> different thread) says page_len should be 0 on entry to
> > > >>> nfsd_direct_read.
> > > >>>
> > > >>>> @@ -1106,6 +1182,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqst=
p, struct svc_fh *fhp,
> > > >>>>  	switch (nfsd_io_cache_read) {
> > > >>>>  	case NFSD_IO_BUFFERED:
> > > >>>>  		break;
> > > >>>> +	case NFSD_IO_DIRECT:
> > > >>>> +		if (nf->nf_dio_read_offset_align &&
> > > >>>> +		    rqstp->rq_res.page_len && !base)
> > > >>>> +			return nfsd_direct_read(rqstp, fhp, nf, offset,
> > > >>>> +						count, eof);
> > > >>>> +		fallthrough;
> > > >>>
> > > >>> Yet the nfsd_iter_read is only calling nfsd_direct_read() if
> > > >>> rqstp->rq_res.page_len is not zero, shouldn't it be
> > > >>> !rqstp->rq_res.page_len ?
> > > >>
> > > >> Oops, yes. I did this work last week, while out of range of my lab.
> > > >>
> > > >>
> > > >>> (testing confirms it should be !rqstp->rq_res.page_len)
> > > >>>
> > > >>> Hopefully with this fix you can have more confidence in staging this
> > > >>> in your nfsd-testing?
> > > >> I'm waiting only for Neil to send an R-b.
> > > >=20
> > > > After noticing, like Mike, that the page_len test was inverted I went
> > > > looking to see where page_len was updated, to be sure that a second R=
EAD
> > > > request would not try to use DIRECT IO.
> > > > I can see that nfsd_splice_actor() updates page_len, but I cannot see
> > > > where it is updated when nfsd_iter_read() is used.
> > > >=20
> > > > What am I missing?
> > >=20
> > > It might be updated while the NFSv4 reply encoder is encoding a
> > > COMPOUND. If the size of the RPC reply so far is larger than the
> > > xdr_buf's .head, the xdr_stream will be positioned somewhere in the
> > > xdr_buf's .pages array.
> > >=20
> > > This is precisely why splice READ can be used only for the first
> > > NFSv4 READ operation in a COMPOUND. Subsequent READ operations
> > > must use nfsd_iter_read().
>=20
> Hi Neil,
> =20
> > Hmmmm...
> >=20
> > nfsd4_encode_readv() calls xdr_reserve_space_vec() passing maxcount from
> > the READ request.  The maxcount is passed to xdr_reserve_space()
> > repeatedly (one page at a time) where it is added to xdr->buf->page_len
> > (where xdr is ->rq_res_stream and xdr->buf is rq_res).
> >=20
> > So the result is often that rq_res.page_len will be maxcount.
> >=20
> > Then nfsd4_encode_readv() calls nfsd_iter_read() which, with this patch,
> > will test rq_res.page_len, which will always be non-zero.
> > So that isn't what we want.
>=20
> Not true. (And code inspection only review like this, that then makes
> incorrect yet strong assertions, is pretty disruptive).

What am I disrupting exactly?

I'm (implicitly?) asked to review the patch.  I do that by inspecting
the code.  I'm not NAKing the code, I'm saying that I cannot see how it
could work.  I'd be very happy for someone to explain how it does work.=20
We could then put that text in the commit message.

>=20
> That said, I did follow along with your code inspection, I see your
> concern (but you do gloss over some code in xdr_get_next_encode_buffer
> that would be cause for avoidng page_len +=3D nbytes).
>=20
> I'll add some tracing to pin this down.
>=20
> > (after the read, nfsd4_encode_readv() will call xdr_truncate_encode()
> >  which will reduce ->page_len based on how much was read).
> >=20
> > Then nfsd4_encode_readv() calls nfsd_iter_read().
> >=20
> > I don't think we can use ->page_len to determine if it is safe to use
> > nfsd_direct_read().  The conditions where nfsd_direct_read() is safe are
> > similar to the conditions where nfsd_splice_read() is safe.  Maybe we
> > should use similar code.
>=20
> Your takeaway from code inspection is clearly missing something
> because page_len is 0 on entry to nfsd_iter_read for both TCP and RDMA
> during my READ testing.

Great.  I'm glad it works.  But without understanding why it works, I
cannot give a Reviewed-By.  Maybe it just works by accident (I've seen
that happen before).  And if you or Chuck cannot explain why it works
then we clearly have work to do.

NeilBrown


>=20
> nfs_direct_read is being called when io_cache_read is configured to
> use NFSD_IO_DIRECT. So !page_len && !base isn't too limiting, it works.
>=20
> Mike
>=20


