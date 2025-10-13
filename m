Return-Path: <linux-nfs+bounces-15206-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9F5BD6C0E
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 01:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2853A90BC
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 23:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5AE22F74A;
	Mon, 13 Oct 2025 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BNW4IgvS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qEmVs5w4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3CD20D4FC
	for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760398767; cv=none; b=nPCUoUhRzix1TNUzhyThYHwgQiOapj5KqP7hfZ7xkq+3uAdNOaOeBbDpoCq73+Zn3voDKPqx0rxhYItq1OeQLhClh/paDGtpe4xEm7AvZM0KyutpMH5u7Dcar8uCzNI3KFm9h+8+b00fyhnyJdjIz4s0D/8WHnGK6iyPP+mUjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760398767; c=relaxed/simple;
	bh=WJHs7sHfR6EgwzsRmHUYPgmsc4AaCks2eyHJNMxwY+o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=lkyBaKc+31R6u+RlyWmmAw5pc9QRA+PXG8X0dghh/IlU/DYZ7scsLDFmuoMdDIJpOI8X64/rBM1bCiwc+xE1uCnVb5retxztUeMedxlV3JaQI1+a8cZR7X8ISMy+ynZqj1+4eDeTFMZnjv0iE4hFpHeSov/qR8OyefM+CNGP3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BNW4IgvS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qEmVs5w4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C3D1140019E;
	Mon, 13 Oct 2025 19:39:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 13 Oct 2025 19:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760398764; x=1760485164; bh=kNjfZLe/9Ub5WpAlUbhcO2/jDd1WFpOyoUa
	bud6c9dY=; b=BNW4IgvSo0YzQbBndUZ3yM5P1g6FEFoCZVW7MpJtAl5mvK09Yym
	pM+tqbbuhDMtfRme3whIH7o1/xmr0tDmYFuIamTbJsADdmWy0WKdQTrLBzsDVjXt
	MjEV5L6GGiN7ebcrfFN3zpdjj6JwPo7iD5I1gSyX1Qngm9mfluKDY4Dferb2XFKp
	M7Q6JERLGfOVCpcKW2o0vQ6J5DHvqemIMefA37KegjG9Kx9Kthr/GGm5fFk+6998
	z3y3WYVadIGk6T7iCj5Lj96TuniydsQXqcW4Vnzp/rtuz0tqnT3dob2gQsDRIv/g
	QMtgVGCNuSC5aXhW+/Nd85RI8OOA30HNoBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760398764; x=
	1760485164; bh=kNjfZLe/9Ub5WpAlUbhcO2/jDd1WFpOyoUabud6c9dY=; b=q
	EmVs5w4h5kpABFsQVqu8l+89k84ziR0Vbw8Dt4goxa5C4fDQMJZVvdWRo+Rl5AdE
	kf3iMt05huQfI2NfMMRQ0LhF3Qf0pp+Lk4BCKEj7c6sUtzX7YZqsKQsAS5gulpAM
	cuEyBNxTIDS2lSRYRXS7hyp9C5kpF259QFnXpiVQ9zqm0C1Dl0asEKt/WUzO9SuS
	aG62LiF9LFElR2Rnm7WoPNg97JutdPXERwDp4vvdeWtLVU08Zphu11vAVpAfXY9J
	TyHorfRrL+R1bA7s5mRakPLv5cp+ufnMfOvg04xzfh5wo2L2JwlSJ6qFdZgzIjfy
	Fp36G/c/r2sJdtUe9Vn8A==
X-ME-Sender: <xms:rI3taDHKDmWUsYMy9OzQddmBHjMEFriTpkxIMWuZ_IzLuDRtkWH1uQ>
    <xme:rI3taN74Yx_Q4Df0sP2nCX5rGMP6Y4-gH55nvVoquTpxFD7JSImYuU4kXTpUyoyPJ
    rSx-TSZ2dKP6yEh1kQpD-IQHIb8sxjVF1QPyRSbVCJ1ag>
X-ME-Received: <xmr:rI3taLnYf66BSXVNnYieZnTexeiRrklonUN10luAb0N-mulcSIPELHwjkViS6qYbtV4uMM5A9-NIC1s7OnYm64zT4irU4cXxQpC4eAcClgL0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    gvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rI3taCpRZqm4JwRtyWR74gPjXbC5VOsNZArqGNzUEXgvxFTRM4QYew>
    <xmx:rI3taKuqgZ4QB0maXeAnL8xbDgPTd16oy8ksyoPGHNEDK5ik4WRBJQ>
    <xmx:rI3taHGoCRAOlZT0DQiSmYZskj6TbV8U3z8zcQLBMKRRgm3gApvOKA>
    <xmx:rI3taDY5B1boXNqeJykjD6Mpg_ORUDcT9gdI_aEpQPJcyw1sGD945w>
    <xmx:rI3taDY68ssDPcTwrbTYFAzrC1mA8Z_ohnmsrkLI0b5JrCRAT6lf2Bx_>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 19:39:21 -0400 (EDT)
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
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 3/4] NFSD: Fix the "is this a solo SEQUENCE" predicate
In-reply-to: <c67cb4e6-11c9-4a4a-99c5-a1721ca7542e@kernel.org>
References: <20251012170746.9381-1-cel@kernel.org>,
 <20251012170746.9381-4-cel@kernel.org>,
 <176033061350.1793333.14824740301723157290@noble.neil.brown.name>,
 <c67cb4e6-11c9-4a4a-99c5-a1721ca7542e@kernel.org>
Date: Tue, 14 Oct 2025 10:39:15 +1100
Message-id: <176039875543.1793333.6732168627174102241@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 14 Oct 2025, Chuck Lever wrote:
> On 10/13/25 12:43 AM, NeilBrown wrote:
> > On Mon, 13 Oct 2025, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> The logic in nfsd4_is_solo_sequence() is incorrect: it checks the
> >> current operation index, not the total count of operations in the
> >> COMPOUND. If the SEQUENCE operation, which is always operation 1,
> >> fails in a multi-operation compound, resp->opcnt is always 1. Thus
> >> when a SEQUENCE operation fails, nfsd4_is_solo_sequence() always
> >> returns true.
> >>
> >> Note that, because nfsd4_is_solo_sequence() is called only by
> >> nfsd4_store_cache_entry(), it is assured that the first operation
> >> in the COMPOUND being checked is a SEQUENCE op. Thus the opnum
> >> check is redundant.
> >=20
> > It is also assured that the SEQUENCE op didn't fail, so the distinction
> > between resp->opcnt and args->opcnt is moot.
> >=20
> > I don't think nfsd4_is_solo_sequence() serves any useful purpose.
> > The only case were the result has any effect, the effect is to set
> > NFSD4_SLOT_CACHED, and to set sl_datalen to zero.
> >=20
> > I would prefer that the code didn't pretend that solo sequence requests
> > were cached - they aren't.  They are simply performed again when needed.
> > But that can be for another day.
>=20
> One wonders why the comments take such pains to call out "caching solo
> sequence" operations if these operations aren't actually cached. Perhaps
> I should replace this patch with one that removes
> nfsd4_is_solo_sequence() .
>=20
> Here's why this is relevant:
>=20
>  941 static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
>=20
>  942 {
>=20
>  943         return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)
>=20
>  944                 || nfsd4_is_solo_sequence(resp);
>=20
>  945 }
>=20
> If nfsd4_is_solo_sequence always returns true, then so does
> nfsd4_cache_this, it looks like.

True, but nfsd4_is_solo_sequence() doesn't always return true.
If any op before the SEQUENCE has been attempted, then it will fail.

But yes, lets remove nfsd4_is_solo_sequence().  I'll send a couple of
patches to show what I am thinking.

NeilBrown


>=20
>=20
> > I don't think this patch achieves anything useful, but I don't object to
> > it.
> >=20
> > NeilBrowjn
> >=20
> >=20
> >=20
> >>
> >> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  fs/nfsd/xdr4.h | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> >> index ee0570cbdd9e..d4548a16a36e 100644
> >> --- a/fs/nfsd/xdr4.h
> >> +++ b/fs/nfsd/xdr4.h
> >> @@ -926,7 +926,8 @@ struct nfsd4_compoundres {
> >>  static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *res=
p)
> >>  {
> >>  	struct nfsd4_compoundargs *args =3D resp->rqstp->rq_argp;
> >> -	return resp->opcnt =3D=3D 1 && args->ops[0].opnum =3D=3D OP_SEQUENCE;
> >> +
> >> +	return args->opcnt =3D=3D 1;
> >>  }
> >> =20
> >>  /*
> >> --=20
> >> 2.51.0
> >>
> >>
> >=20
>=20
>=20
> --=20
> Chuck Lever
>=20


