Return-Path: <linux-nfs+bounces-16587-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC65C712F6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 22:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E93442950A
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 21:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58690307481;
	Wed, 19 Nov 2025 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Cwexs4PB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zIof/Vmt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A45303A1B
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588848; cv=none; b=jcruNysCnBAq8est7zw36bOso8NQ7PTdll9I2bwRV9wpB/cOtqDU2dXvFem/8beuIpNB1dnNwuw6JiNRaRHbFB3bpQXvZs9TRNcSYdqKqRHgRCuz9kat/WQEK3vvw7d+VQc5qY3Wu+SMr5hdClYRP2oJoGmxAMb5kkX1i4lkS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588848; c=relaxed/simple;
	bh=Astg7UGi99B0j12Sa2JpTcQxZDrJiy1CvD+70xPeKDs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ArJ8fPeg6Ml1Ehz74HyrT6z/UULoIIkwdca6yD3KUprtt9Z9E8oq3SJ1AxsNf1vZ1pOsmPnp595lJ8ycNTUdwECT5dDWy++mzAcMGWj/wyaiCBIsk0mOqHJsZ52zbGEjF0t7DaJbtD4ryBR2hfsTBmhngy83ucOqWMmvM0Y3RQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Cwexs4PB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zIof/Vmt; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 84BA5EC01BF;
	Wed, 19 Nov 2025 16:47:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 19 Nov 2025 16:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763588845; x=1763675245; bh=W4ZJ75xv2Fu8JcQCPkAGqyG+Qc2ECEDsR2m
	ihrEzvrI=; b=Cwexs4PBmQQkR09MmmiyJW2/mRk+IYGD7Lp1XA+w0eGKOHdZQAY
	hRfU1VqpYWLD+6LkSzGPiCLfv86v7YF8W/kjPy7drK2gQQbW/XoeCLnhXzES5KHy
	ATqoJEz8q8PUB8o52ZZCdtiGyKIZ0kAX50/7vIky2XTtOh4WsPHxEYp8zEGvxHEJ
	UUFwsuKLLCHf9xLpFYCZxVNKGaN1b2WKDWZXCH3h83diZ84M/BGtDbzxB/sHpApa
	BzIwnm1W3zwtIQHbx0KK3pwtQyUKr02Leyf0o2VJT4NO6oOBT4kaRY74KR1USQgG
	ToVNA0PkZrDem0RaiKf2UalDts59nG+yCww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763588845; x=
	1763675245; bh=W4ZJ75xv2Fu8JcQCPkAGqyG+Qc2ECEDsR2mihrEzvrI=; b=z
	Iof/VmtJlRcXTaBECoeZjjiT7XXm5oi4EPSPthZdKYR01Yprot52ILtwHGqGyxvH
	LBikufb62KnB+dh2/VbLD5P8oB5kbUjlEXWKmClrrVd4KqI6jL4tCOjXjwy8uMuw
	0N18IEu5d09E9mhudrZQJhC4NAtD5PfIfhksSMJRarG7rXhj/h8L2PXdlMbRdQcn
	d49Dca2RE2i+WIY9U1ZsNpIDvywhf+OLyWi7B+reQSic98EOEZ3lcnh5F/4iC8jE
	OWG3U1hLnIVNB+RT2+Ac9DrjFmk42Sa7D3FeV4xtLNpUzghOkWp5gqqOf0l+L5Jz
	I9PlXZQ0SR2u/oebf6a3Q==
X-ME-Sender: <xms:7ToeaR3VndZK2BO-A-3ewnpLZ998LOIBKbnFF_3fhWMY1N2rI01cFA>
    <xme:7ToeabwM2cJrp3YtHAd_Q12UgmA_Y_oqIr3aM0-6qr6UP0EaAq7jTN2vj-q2VUZZX
    NQCr0fXO8ruJ3v1XNMwZyCK0UcqJkazNvgK_8uC6hJpXfwQXg>
X-ME-Received: <xmr:7Toeabuu7gVbWE8C4qvz4Bsw2rFtVMd383npMUnGraKiqLNHYgACSOAlBowJkmK55OhHLRoQRFwSBmMg7uTUHpR6QMnc0j6ZyoT5LUzRxz_4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7ToeaVzX7RnEKhvUGUx941383SqKX3ByOr1c23KIk8O4YjB9-wqFHw>
    <xmx:7ToeaWApB3HWHYgUe3a-qpEh0zg3AyU95c0Q4GqNea962d9odgBtJw>
    <xmx:7Toeabf86IIRthp9IZYfu7EnUl7HybDw8e2r2tCIyxUm8pIJD5XNMg>
    <xmx:7ToeaYl6_MgTcB2rVlnGG0122ljemfTwkDHyHFki_E5A6dyAzCRlgA>
    <xmx:7ToeaXVMe3QmhAxPgDkr8dkiLZQvwFfArWyyvPxTPOJd1gQOIAn9-6L3>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 16:47:23 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 06/11] nfsd: revise names of special stateid, and
 predicate functions.
In-reply-to: <803d3e56-ed6c-450f-b609-6dbfdd1e4d14@oracle.com>
References: <20251119033204.360415-1-neilb@ownmail.net>,
 <20251119033204.360415-7-neilb@ownmail.net>,
 <803d3e56-ed6c-450f-b609-6dbfdd1e4d14@oracle.com>
Date: Thu, 20 Nov 2025 08:47:21 +1100
Message-id: <176358884158.634289.2155109158356141626@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 20 Nov 2025, Chuck Lever wrote:
> On 11/18/25 10:28 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > When I see "CURRENT_STATEID(foo)" in the code it is not clear that this
> > is testing the stateid to see if it is a special stateid.  I find that
> > IS_CURRENT_STATEID(foo) is clearer.  But an inline function is even
> > better, so is_current_stateid().
> >=20
> > There are other special stateids which are described in RFC 8881 Section
> > 8.2.3 as "anonymous", "READ bypass", and "invalid".  The nfsd code
> > currently names them "zero", "one" and "close" which doesn't help with
> > comparing the code to the RFC.
> >=20
> > So this patch changes the names of those special stateids and adds
> > "is_" to the front of the predicates.
> >=20
> > As CLOSE_STATEID() was not needed, it is discarded rather than replacing
> > with is_invalid_stateid().
> >=20
> > I felt that is_read_bypass_stateid() was a little too verbose, so I made
> > it is_bypass_stateid().
> >=20
> > For consistency, invalid_stateid is changed to use ~0 rather than
> > 0xffffffffU for the generation number.  (RFC 8881 say to use
> > "NFS4_UINT32_MAX" for the generation number here, and "all ones" for the
> > generation and opaque of anon_stateid).
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++-----------------
> >  1 file changed, 23 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index ea931e606f40..f92b01bdb4dd 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -60,18 +60,18 @@
> >  #define NFSDDBG_FACILITY                NFSDDBG_PROC
> > =20
> >  #define all_ones {{ ~0, ~0}, ~0}
> > -static const stateid_t one_stateid =3D {
> > +static const stateid_t read_bypass_stateid =3D {
> >  	.si_generation =3D ~0,
> >  	.si_opaque =3D all_ones,
> >  };
> > -static const stateid_t zero_stateid =3D {
> > +static const stateid_t anon_stateid =3D {
> >  	/* all fields zero */
> >  };
> > -static const stateid_t currentstateid =3D {
> > +static const stateid_t current_stateid =3D {
> >  	.si_generation =3D 1,
> >  };
> > -static const stateid_t close_stateid =3D {
> > -	.si_generation =3D 0xffffffffU,
> > +static const stateid_t invalid_stateid =3D {
> > +	.si_generation =3D ~0,
> >  };
> > =20
> >  /*
> > @@ -93,10 +93,16 @@ static inline bool stateid_well_formed(stateid_t *sti=
d)
> > =20
> >  static u64 current_sessionid =3D 1;
> > =20
> > -#define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(=
stateid_t)))
> > -#define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(s=
tateid_t)))
> > -#define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, si=
zeof(stateid_t)))
> > -#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, size=
of(stateid_t)))
> > +/* These special stateid are defined in RFC 8881 Section 8.2.3 */
> > +static inline bool is_anon_stateid(stateid_t *stateid) {
> > +	return memcmp(stateid, &anon_stateid, sizeof(stateid_t));
> > +}
> > +static inline bool is_bypass_stateid(stateid_t *stateid) {
> > +	return memcmp(stateid, &read_bypass_stateid, sizeof(stateid_t));
> > +}
> > +static inline bool is_current_stateid(stateid_t *stateid) {
> > +	return memcmp(stateid, &current_stateid, sizeof(stateid_t));
> > +}
>=20
> The new static inline functions appear to invert the logic -- the macros
> use "!memcmp" but the new functions omit the "!". memcmp() returns an
> int, so there is an implicit type conversion here as well. So maybe you
> want "memcmp(stateid, ... ) =3D=3D 0" ?

I must have been asleep ?  Thanks.
(I really don't like "!memcmp" or "!strcmp" so I definitely intended to
change it.  I have now).

>=20
> And now we can use "sizeof(*stateid)" here which is slightly less
> brittle.

Good idea.

Thanks,
NeilBrown

