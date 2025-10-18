Return-Path: <linux-nfs+bounces-15375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966BBBEDC59
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 00:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1AE428344
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE25354AC1;
	Sat, 18 Oct 2025 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WnceE5TX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P7GanyA5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96293BB5A
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760825194; cv=none; b=b4gtA9c0jhxHrk3OjL7Auye/nwkdh+xSbz9jAFoFul6vLCy/WaWXkBHY0n/Mr/wwHfhJXgl09TfQkAFZBea1Y+yeZKe86R2aJnkCFVZAUhOIV4qn5RDIeYadw2L/vXYN0f7QAGYAsYPUv5enuIbiClOl0ryyTuF75kUMLw3fZjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760825194; c=relaxed/simple;
	bh=csTkmy0kRWI7dVy9d3g2fg3cnGGbU0Hb3Pwxx97/7gM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ub25aSAzk8YO8e3r8hMnGIIjzSGQLyNoPytxr8hJDid5hes6R+Sl+35pnZrSx11TZsi/KXN6C8RsRG24Djs8c8zmTXASt8RTPo1vLkmOqNiQyCj3j4TlhX0AxtrXFi9IbliFBTf4NpSZiiGwXmeZay462DCmhQeowvHDc58Qx10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WnceE5TX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P7GanyA5; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D5D2E1D0012C;
	Sat, 18 Oct 2025 18:06:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 18 Oct 2025 18:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760825190; x=1760911590; bh=2HvUEKvZMZ3Tx7C2JFNqdpRvEB96BU61jAm
	77qYWyQM=; b=WnceE5TXydQ3OKyFFG800K7SZtWNCpFfi0DXyPkH8N8K3IkGTlz
	gTYJETVGu2jKCHPp8vvc9C5exj8p9J5r2fa1Hg+VRwHXo5U4Bo0jFfVs69m3HI9S
	NP8CTenvFnJ/Q2qzbtq8xcbpSLEsqugJUtPkzfFHwBV2+0TACF2INSWenqpiJZ+g
	GGSx19d8GD+1DAcq4jmcOxAGpxla59vuu0AWOgvVgWzh16oDRfgR/28VICuN+kzN
	3KzLU14pWVavBFJPMdF3sTAoPBRxjyKG46+P6lCdvHhgGdLsBGBgZac/Kyb1k3jZ
	x+VwGDz2Eq30nBidNYQhbgqT3wjSuZYbvrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760825190; x=
	1760911590; bh=2HvUEKvZMZ3Tx7C2JFNqdpRvEB96BU61jAm77qYWyQM=; b=P
	7GanyA5LATD4RJPV/V3DxGZ7Gn9LENXmBL+ZIkrFkzB3wOaxwZLd/jXlYDdL+E37
	vCxTlx3KmpHeDvKaBPNPoeG1/5lDEq0EKepoo1kcknj6ixrScE9qZHjLLvGx/HOO
	438FM36RSEq7OGECcX5sZzzy7yLZjYE/ReGXDUqbCZSjVEpGa/aUc2f91hzKnbis
	r3g0YyFNYtTBjk4cdcLyVXWqdgQJU8/rGbX3vC87qHZiXCJqdOunqrb+jkDy7Zyb
	vjJAjNawGCEttT7BxGUng09Oxj68AF+TDlPSuo3o0AQbHjMcEQHUNj4pAOtGMX6G
	udtI1r39OE9jVHXLKSd8w==
X-ME-Sender: <xms:Zg_0aHuiDrSxayK5DNSz6Tm_gTC6-JMn-4NMyD_EsyZMdlFT78QaZg>
    <xme:Zg_0aMLxCjuKtx22OfZPyjFxeYZGfiQGP6BshApYgTz8e76glOdPVit_k-sE5fMc1
    o4wHibR-_9K0OEM12kkzweHvwUqyXwqMBHWlk1Tlguas24PWQ>
X-ME-Received: <xmr:Zg_0aEmWeFyHE_HVf_ShudKOweENCTJq88v-0M1-QsdSUX1pHVYbgWoN3DoSXpx1UlWOYdxHjS55UXJNI-SIXTcXJv7AT9oBNdvpbYpQtwFh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeefvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvefhfeeuhfevffeviedujedtfedvleekgfelledtgfevvdefvdffheegueehiedvnecu
    ffhomhgrihhnpegsvghlohifrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmsehtrghlphgv
    hidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    uggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Zg_0aNICl3PuYTUVR9x7fEuyKXEtZ2EWrqU2dq4rRvEPdOWlk4Symg>
    <xmx:Zg_0aJ6u4v-9bBxECucbS2SFgHeMnohhGmXUSLafCucrdbAkeAVj2g>
    <xmx:Zg_0aB1sPinOqJhFunNNQfMBTcKFhAJrEw1QL3VV4f8MxLy_nTudBg>
    <xmx:Zg_0aPeMeoOEW3r5iH723zfrwg3DRx9BbGDPb75bptsgwf6Q_r74zQ>
    <xmx:Zg_0aFM70RUhpNHCEotdmUOtU7g3Ygko186-AqvW4rDpgIpQjWByBdqG>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 18:06:28 -0400 (EDT)
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
Subject: Re: [PATCH] sunrpc/cache: improve RCU safety in cache_list walking.
In-reply-to: <27844685-0132-4f65-b8cf-3ea058d783ae@oracle.com>
References: <176074628319.1793333.3387532760794075868@noble.neil.brown.name>,
 <27844685-0132-4f65-b8cf-3ea058d783ae@oracle.com>
Date: Sun, 19 Oct 2025 09:06:21 +1100
Message-id: <176082518104.1793333.5226398922398910122@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 19 Oct 2025, Chuck Lever wrote:
> On 10/17/25 8:11 PM, NeilBrown wrote:
> >=20
> > From: NeilBrown <neil@brown.name>
> >=20
> > 1/ consistently use hlist_add_head_rcu() when adding to
> >   the cachelist to reflect that fact that is can be concurrently
> >   walked using RCU.  In fact hlist_add_head() has all the needed
> >   barriers so this is no safety issue, primarily a clarity issue.
> >=20
> > 2/ call cache_get() *before* adding the list with hlist_add_head_rcu().
> >   It is generally safest to inc the refcount before publishing a
> >   reference.  In this case it doesn't have any behavioural effect
> >   as code which does an RCU walk does not depend on precision of
> >   the refcount, and it will always be at least one.  But it look
> >   more correct to use this order.
> >=20
> > 3/ avoid possible races between NULL tests and hlist_entry_safe()
> >    calls.  It is possible that a test will find that .next or .head
> >    is not NULL, but hlist_entry_safe() will find that it is NULL.
> >    This can lead to incorrect behaviour with the list-walk terminating
> >    early.
> >    It is safest to always call hlist_entry_safe() and test the result.
> >=20
> >    Also simplify the *ppos calculation be simply assigning the hash
> >    shifted 32, rather than masking out low bits and incrementing high
> >    bits.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >=20
> > I was looking at this code a while back while hunting for a bug that
> > turned out to be somewhere else.
> > I notice point 1 and 2 above and thought that while of little
> > significance, I may as well fix them.  While examining the code more
> > closely as part of preparing the patch I noticed point 3 which is a
> > little more significant - clearly a bug but not particularly serious (I
> > think).
> >=20
> > NeilBrown
>=20
> I wonder if this patch should be split for better bisectability.
> Are the changes to the *ppos calculations dependent on the RCU changes?

There is no dependency between the various changes.
Did you just want the *ppos split out, or did you want the 1, 2, 3 also
split apart.  I considered that but wasn't convinced it was worth it.

Thanks,
NeilBrown


>=20
> One more nit below.
>=20
>=20
> >  net/sunrpc/cache.c | 61 ++++++++++++++++++++++------------------------
> >  1 file changed, 29 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> > index 131090f31e6a..1dc84522de45 100644
> > --- a/net/sunrpc/cache.c
> > +++ b/net/sunrpc/cache.c
> > @@ -133,11 +133,11 @@ static struct cache_head *sunrpc_cache_add_entry(st=
ruct cache_detail *detail,
> >  		return tmp;
> >  	}
> > =20
> > +	cache_get(new);
> >  	hlist_add_head_rcu(&new->cache_list, head);
> >  	detail->entries++;
> >  	if (detail->nextcheck > new->expiry_time)
> >  		detail->nextcheck =3D new->expiry_time + 1;
> > -	cache_get(new);
> >  	spin_unlock(&detail->hash_lock);
> > =20
> >  	if (freeme)
> > @@ -232,9 +232,9 @@ struct cache_head *sunrpc_cache_update(struct cache_d=
etail *detail,
> > =20
> >  	spin_lock(&detail->hash_lock);
> >  	cache_entry_update(detail, tmp, new);
> > -	hlist_add_head(&tmp->cache_list, &detail->hash_table[hash]);
> > -	detail->entries++;
> >  	cache_get(tmp);
> > +	hlist_add_head_rcu(&tmp->cache_list, &detail->hash_table[hash]);
> > +	detail->entries++;
> >  	cache_fresh_locked(tmp, new->expiry_time, detail);
> >  	cache_fresh_locked(old, 0, detail);
> >  	spin_unlock(&detail->hash_lock);
> > @@ -1361,18 +1361,14 @@ static void *__cache_seq_start(struct seq_file *m=
, loff_t *pos)
> >  	hlist_for_each_entry_rcu(ch, &cd->hash_table[hash], cache_list)
> >  		if (!entry--)
> >  			return ch;
> > -	n &=3D ~((1LL<<32) - 1);
> > -	do {
> > -		hash++;
> > -		n +=3D 1LL<<32;
> > -	} while(hash < cd->hash_size &&
> > -		hlist_empty(&cd->hash_table[hash]));
> > -	if (hash >=3D cd->hash_size)
> > -		return NULL;
> > -	*pos =3D n+1;
> > -	return hlist_entry_safe(rcu_dereference_raw(
> > +	ch =3D NULL;
> > +	while (!ch && ++hash < cd->hash_size)
> > +		ch =3D hlist_entry_safe(rcu_dereference(
> >  				hlist_first_rcu(&cd->hash_table[hash])),
> >  				struct cache_head, cache_list);
> > +
> > +	*pos =3D ((long long)hash << 32) + 1;
> > +	return ch;
> >  }
> > =20
> >  static void *cache_seq_next(struct seq_file *m, void *p, loff_t *pos)
> > @@ -1381,29 +1377,30 @@ static void *cache_seq_next(struct seq_file *m, v=
oid *p, loff_t *pos)
> >  	int hash =3D (*pos >> 32);
> >  	struct cache_detail *cd =3D m->private;
> > =20
> > -	if (p =3D=3D SEQ_START_TOKEN)
> > +	if (p =3D=3D SEQ_START_TOKEN) {
> >  		hash =3D 0;
> > -	else if (ch->cache_list.next =3D=3D NULL) {
> > -		hash++;
> > -		*pos +=3D 1LL<<32;
> > -	} else {
> > -		++*pos;
> > -		return hlist_entry_safe(rcu_dereference_raw(
> > -					hlist_next_rcu(&ch->cache_list)),
> > -					struct cache_head, cache_list);
> > +		ch =3D NULL;
> >  	}
> > -	*pos &=3D ~((1LL<<32) - 1);
> > -	while (hash < cd->hash_size &&
> > -	       hlist_empty(&cd->hash_table[hash])) {
> > +	while (hash < cd->hash_size) {
> > +		if (ch)
> > +			ch =3D hlist_entry_safe(
> > +				rcu_dereference(
> > +					hlist_next_rcu(&ch->cache_list)),
> > +				struct cache_head, cache_list);
> > +		else
> > +
> > +			ch =3D hlist_entry_safe(
> > +				rcu_dereference(
> > +					hlist_first_rcu(&cd->hash_table[hash])),
> > +				struct cache_head, cache_list);
>=20
> Extraneous blank line added above.
>=20
>=20
> > +		if (ch) {
> > +			++*pos;
> > +			return ch;
> > +		}
> >  		hash++;
> > -		*pos +=3D 1LL<<32;
> > +		*pos =3D (long long)hash << 32;
> >  	}
> > -	if (hash >=3D cd->hash_size)
> > -		return NULL;
> > -	++*pos;
> > -	return hlist_entry_safe(rcu_dereference_raw(
> > -				hlist_first_rcu(&cd->hash_table[hash])),
> > -				struct cache_head, cache_list);
> > +	return NULL;
> >  }
> > =20
> >  void *cache_seq_start_rcu(struct seq_file *m, loff_t *pos)
>=20
>=20
> --=20
> Chuck Lever
>=20


