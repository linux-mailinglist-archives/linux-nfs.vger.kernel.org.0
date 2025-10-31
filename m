Return-Path: <linux-nfs+bounces-15860-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D746C273A7
	for <lists+linux-nfs@lfdr.de>; Sat, 01 Nov 2025 00:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B9E74E05A2
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 23:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E29232F74E;
	Fri, 31 Oct 2025 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Lq4wiV9d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ym4MROb7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B348F32F773
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761954833; cv=none; b=Os07qdXLIEq2hhp+D+ETKzD6SVGJfrtuvo0PQO39PVDhDlkmf6ihOjvOBqulX4iqVkcljkIdRdbjQjqwUoYS6QaiyYE9dGXjbBGdxWspdD/y4BdrPJ1w6NvAUEBQJgNOCZ36lJr9J6wjB9meDzbbnJt0uMww1H/c3Bre7mC3wtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761954833; c=relaxed/simple;
	bh=+5HciXsdg+3hW6CYpuE+ssicQDba8REqLkmmuK7Kg6k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hf+bXsd4ZLq2nZTE43CxGTWcCPrLbFw1k3INQGJD7z8xwY2Kznc9JNwjmJ//fI12PFF/ObzkAhr5VgdeKpFWi74dEkMFhT975uf/FeRU3qAgPMC3gbBVzseqiV9aCijkNg7sennQ6cYKXuXkha0w6wv/XqNpCVdKZ1y6Wtvqm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Lq4wiV9d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ym4MROb7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC3CB1400184;
	Fri, 31 Oct 2025 19:53:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 31 Oct 2025 19:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761954830; x=1762041230; bh=o/1Zf2N/PlR6M1B8j+ESgfpdkuDdQMppJft
	2Tv4xqV0=; b=Lq4wiV9d3X2BD1G7aAK9L3prd+WUHv9oRR+kD6ndhg+AeLj9CvK
	PoemRXU3GB5k09o0rBaD0dkUK/VvgvqngZ9SMG7ANSeeiLo7zw7r6UwdzfUrHG56
	ItFGk2Nw9fEmZxbZwvzkScavW9zIaJBkxzILJ12rhpGsANdjW+UYCLghFeaZ7j4L
	axrxw6Yn8dIulL4fBkoSR2X9fu8B1Kqrw3KVRme6L5tawBeRL/vk1hajK7JzynsU
	EojS9wBVs0ls4QbG39Jkgu4Ax53IKoaPQBF7Mw2P2MufGPlGMjGc/11WW1JwEVpH
	D6jEJnCdvG5w6vFoKiE86wY6lVHSkKc8gGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761954830; x=
	1762041230; bh=o/1Zf2N/PlR6M1B8j+ESgfpdkuDdQMppJft2Tv4xqV0=; b=Y
	m4MROb7uELZCUrb3TvWIyORF1gmlWjP1m0dUc+K9Gb90I6pAAk732S7S7F+VfC8h
	pYJDB/WDu2BCYOyMulo7SI+09MLtzeTgzXAKXMdhZGRu3sqpUtgCFkl7MvpDqICy
	B1TUvPBHuCddz61taQBbEF3qjOSQCJCyg97rdt/Pa6drRgT1jO4fKfnDBmGHyP1f
	ZVX9c5CmmTicNgr533+9s3gMDOcYqQxX5ykvl9wNbWtK/4lPaUePQ75iVpmfRYiD
	NU3YQy141A9l8WxEEAZ2laXtAREsZfp5zTpsUSpNEUk7rVZ8hIz2NWxeXohZL35V
	Uwgpt9oQ8+vilLd6qgJNg==
X-ME-Sender: <xms:DkwFae577x2X28kOA_rXp-mKo4TZWETDFXSt_cvP_TEWkq_CAUb0MA>
    <xme:DkwFabnZKIO1OiFVoWtwI_Mhn3XnFsr8EZ9VojsPulyX7bFMBz5BJjnYi7e47N73_
    Ew0HZjaXuoPILbZkcRDhrEXOhXpZttl1gwQE9qEkD7aSeZ7Rg>
X-ME-Received: <xmr:DkwFaXREUPk-g-Ezw8QjegU60ia-oiL-vobs8biZz1E3A90_QyRpTQI7ZRIWvyy5O7HtILFadqmUoKOKUGTDJehqIBv0frQ96KRhDYxLjgrK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleehueeggfegteduieeggeetvedvheegvefhgffhgeejgeekffehgfevvdfhledvnecu
    ffhomhgrihhnpehophgrqhhuvgdrshhonecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmsehtrghlphgv
    hidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    uggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DkwFaSHNittTyS-nKV3ZfFO641nq_xOweV_UDwGrtwB71STossDGag>
    <xmx:DkwFaUHMRk0SmcGjgROeaxlrV-42wrXQSwjSHKhQ2Zxs52DNElxNwg>
    <xmx:DkwFaYR8w7sf68veumo5T3nb7jKAdYxpK-KbXEcOHjlbpPfmdlXg1A>
    <xmx:DkwFadIS0-OfTZbwpubVyGbGUh6JzCOdFMU9Co3OTFIOQv6SvtaV3w>
    <xmx:DkwFaYZCYoho1O9mXEMJf4L4QaVW0CR1cIgooG2fgeEOjWKTPTWof4OK>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 19:53:48 -0400 (EDT)
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
Subject: Re: [PATCH v4 01/10] nfsd: drop explicit tests for special stateids
 which would be invalid.
In-reply-to: <5a832485-1107-474d-b456-8a041f9c7189@oracle.com>
References: <20251031032524.2141840-1-neilb@ownmail.net>,
 <20251031032524.2141840-2-neilb@ownmail.net>,
 <5a832485-1107-474d-b456-8a041f9c7189@oracle.com>
Date: Sat, 01 Nov 2025 10:53:46 +1100
Message-id: <176195482682.1793333.18344678155397810773@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 01 Nov 2025, Chuck Lever wrote:
> On 10/30/25 11:16 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > In two places nfsd has code to test for special stateids and to report
> > nfserr_bad_stateid if they are found.
> > One is for handling TEST_STATEID ops which always forbid these stateids,
> > and one is for all other places that a stateid is used, and the code is
> > *after* any checks for special stateids which might be permitted.
> >=20
> > These tests add no value.  In each each there is a subsequent lookup for
> > the stateid which will return the same error code if the stateid is not
> > found, and special stateids never will be found.
> >=20
> > Special stateid have a si.opaque.so_id which is either 0 or UINT_MAX.
> > Stateids stored in the idr only have so_id ranging from 1 or INT_MAX.
> > So there is no possibility of a special stateid being found.
> >=20
> > Having the explicit test optimised the unexpected case where a special
> > stateid is incorrectly given, and add unnecessary comparisons to the
> > common case of a non-special stateid being given.
> >=20
> > In nfsd4_lookup_stateid(), simply removing the test would mean that
> > a special stateid could result in the incorrect nfserr_stale_stateid
> > error, as the validity of so_clid is checked before so_id.  So we
> > add extra checks to only return nfserr_stale_stateid if the stateid
> > looks like it might have been locally generated - so_id not
> > all zeroes or all ones.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/nfs4state.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 35004568d43e..83f8e8b40f34 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -7129,9 +7129,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_cl=
ient *cl, stateid_t *stateid)
> >  	struct nfs4_stid *s;
> >  	__be32 status =3D nfserr_bad_stateid;
> > =20
> > -	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> > -		CLOSE_STATEID(stateid))
> > -		return status;
> >  	spin_lock(&cl->cl_lock);
> >  	s =3D find_stateid_locked(cl, stateid);
> >  	if (!s)
> > @@ -7186,13 +7183,16 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state =
*cstate,
> > =20
> >  	statusmask |=3D SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
> > =20
> > -	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> > -		CLOSE_STATEID(stateid))
> > -		return nfserr_bad_stateid;
> >  	status =3D set_client(&stateid->si_opaque.so_clid, cstate, nn);
> >  	if (status =3D=3D nfserr_stale_clientid) {
> >  		if (cstate->session)
> >  			return nfserr_bad_stateid;
> > +		if (stateid->si_opaque.so_id + 1 <=3D 1)
> > +			/* so_id is zeroes or ones so most likely a
> > +			 * special stateid, certainly not one locally
> > +			 * generated.
> > +			 */
> > +			return nfserr_bad_stateid;
>=20
> I think this is checking for ZERO_STATEID or ONE_STATEID, but I'm
> not clever enough to be sure? It would be more self-documenting
> if this explicitly checked for both instead.

The key part of the comment is "certainly not one locally generated".
We only want to return nfserr_stale_stateid if the stateid looks like
one of ours but must be from an earlier instance.
nfsd only generated stateids with so_id from 1 to INT_MAX

maybe

static inline stateid_locally_generated(stateid_t *s)
{
	/* Our stateids have so_id from 1 to INT_MAX.
	 * So (so_id-1) must be less than INT_MAX.
	 * Special stateids have so_id of 0 or UINT_MAX
	 * so they do not appear locally generated.
	 */
	return s->si_opaque.so_id-1 < MAX_INT;
}
...

		if (!cstate->session &&
		    stateid_locally_generated(stateid))
			return nfserr_stale_stateid;
  		return nfserr_stale_stateid;

I'm not totally sold on "locally_generated" as the name, but other
options I think of are not better.

NeilBrown

