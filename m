Return-Path: <linux-nfs+bounces-15378-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705E6BEDC81
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 00:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C0A3BBC97
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC63BB5A;
	Sat, 18 Oct 2025 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="w21Dsd/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QnR8RON8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0986525B30D
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760827002; cv=none; b=sSqX0l0Q3yBIzAFExISe4D8RtQuGZQXPur7Yj6m+jTEBHYlVM9+VbB1guIzkN89hVifUD7GIAE/EztisJriRlK47FGJI6dxNnvoqQbPgwqgYryBmAKVCUIVtxHD/qvYCnMZ6zBuIFgcSHPqOy1vKdXy4ljX20PtvPR9om3/AY7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760827002; c=relaxed/simple;
	bh=VInb/zEn+YPqFjiCGiFTdJT5ea2lmywt2AfI3hSoXe0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AEWJjqGd7FftQA4Nckn/eWk7EQlP1Piv9NvxZrNMwfF3O9S1VpW4eKV3tfCR0/IWQ0HYuxyCcSi0sycvI+dhgnWbpklyfo5TQjpfgRkMtpwcBsv1Ak0+JvtGzj84f5Ic1BLukl5NIAXs7ET6wWpncGyvlLnkwrozkBdkJ4KdK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=w21Dsd/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QnR8RON8; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id F09521D0008F;
	Sat, 18 Oct 2025 18:36:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sat, 18 Oct 2025 18:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760826999; x=1760913399; bh=y6BUmvfZJPBvjfmfRmFv+wHXEg9tQt68t/I
	4fZvjEkI=; b=w21Dsd/nw159VvTamsuuol80rUHo8whmDoLowQ/5AMrk+lfh3Lh
	DcwYSf8zZ09WzN6b73Kyk4N3cxSkwb22SOa6wcbqmRLWkFV0L5Gya9pQ0cdkiLR/
	pJ0RdLWP+IoSpDw6PYFLioEAmAY+KVMHcD7HSlR6DgKw9AR878hH9mNTt561hio3
	zfWcHm6Fu5/CRFVXy56cuT8fjSSghK/PScdgar7bH2Cltaw2BXe+DqI7rbwo4zNQ
	ezVuTi2dNRznrJQiWjuiy47eU71WoKpf7mye4uT1uNCLMk6HFo0XffwwvNzZDgde
	aQx69ba/gi899e4Wq/+w5ryHjczYKkXPRkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760826999; x=
	1760913399; bh=y6BUmvfZJPBvjfmfRmFv+wHXEg9tQt68t/I4fZvjEkI=; b=Q
	nR8RON8u2nOPYlzqssp8ANgOUYUro80WTTIlJHSIFgRM1dKS8O7sR20dIDa273td
	Py/MdoYjkAiUgMuq/eduZXKBJvvcErqKq2ijLVUiYP2LxuMhwktFh+w0FMmC2o/H
	4VOZj06S8pAbsuWtq03RFiQqKkdZrMpjXhUH35pOmYzVPc7qoXsVYls2A5Bu4hYs
	0xJJsnGrVsH6Vs0o0eQo0l/z6KMlGYcXjkHFW7RYiKY86QcUB6amh1pqpxBdbkD6
	aA1QbgHmWtgg52wUdBdopRoEWpGb5F/zIu8BOgfFj6gr65yGz4doAeFnjY54ckyf
	rYUP2tUoDNRt+OeXlCrig==
X-ME-Sender: <xms:dxb0aDLTr5eE5wpum8hgJZ01wXixF8fy3RgZF2veUjXX3swe81Vozg>
    <xme:dxb0aK0ZJZP7DAQ8eWGT5ETBzhjJZYEtBBpxEG-Z2f8YQwNF2bX-UpMmY5Z7FktK6
    VJXOMh7f_PuPFtMoYK9A_cynuJXCjAtJojsrFDnQcm4-PrvdA>
X-ME-Received: <xmr:dxb0aFi3HPY-ez-ysRWbSjQv-v12trWwb9h_Lgo4ur2qK3POhOCp1G9jEkL7caoLph4y3mxlJHJgHX6xSDwcPDs75QP_mTtW2zczbfeMFcus>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeefvdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:dxb0aDWQANBPQswtUjerriZxQacS6zMGqPpYs7YLVIRG7rVEAZVQjw>
    <xmx:dxb0aMXTHl_UIrGVGyEqqwJql9_DpKhkKIP-K9IUHor05LIlGd6_Kw>
    <xmx:dxb0aLhHL9HHtGHBrgPj-GblpfmBqp3dR5HTveOUcj367lp8dXyz6A>
    <xmx:dxb0aPZPOUfho7-nOIh6NQ0rHTIvH4F3r7NFzR0B3vyloU_CbMJakA>
    <xmx:dxb0aMrWeqtQn3yyXQ6eYS41jgmCAsMs3_ewtyrWriE8Lhvmmsxh95mJ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 18:36:37 -0400 (EDT)
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
Subject: Re: [PATCH 6/7] nfsd: discard current_stateid.h
In-reply-to: <95073b7c-39df-4c5f-80c0-74655a7289a0@oracle.com>
References: <20251018000553.3256253-1-neilb@ownmail.net>,
 <20251018000553.3256253-7-neilb@ownmail.net>,
 <95073b7c-39df-4c5f-80c0-74655a7289a0@oracle.com>
Date: Sun, 19 Oct 2025 09:36:35 +1100
Message-id: <176082699583.1793333.11434934599887236895@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 19 Oct 2025, Chuck Lever wrote:
> On 10/17/25 8:02 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > current_stateid.h no longer has enough content to justify its
> > existence.  So remove it and incorporate the content into xdr4.h.
> >=20
> > clear_current_stateid() is moved to xdr4.h and made static-inline.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/current_stateid.h | 12 ------------
> >  fs/nfsd/nfs4proc.c        |  1 -
> >  fs/nfsd/nfs4state.c       |  7 -------
> >  fs/nfsd/xdr4.h            |  8 ++++++++
> >  4 files changed, 8 insertions(+), 20 deletions(-)
> >  delete mode 100644 fs/nfsd/current_stateid.h
> >=20
> > diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
> > deleted file mode 100644
> > index 8eb0f689b3e3..000000000000
> > --- a/fs/nfsd/current_stateid.h
> > +++ /dev/null
> > @@ -1,12 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > -#ifndef _NFSD4_CURRENT_STATE_H
> > -#define _NFSD4_CURRENT_STATE_H
> > -
> > -#include "state.h"
> > -#include "xdr4.h"
> > -
> > -void clear_current_stateid(struct nfsd4_compound_state *cstate);
> > -void get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid=
);
> > -void put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid=
);
> > -
> > -#endif   /* _NFSD4_CURRENT_STATE_H */
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 7b6a40cf8afd..bb432b5b63ac 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -46,7 +46,6 @@
> >  #include "cache.h"
> >  #include "xdr4.h"
> >  #include "vfs.h"
> > -#include "current_stateid.h"
> >  #include "netns.h"
> >  #include "acl.h"
> >  #include "pnfs.h"
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index dbf5300c8baa..635c7560172c 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -50,7 +50,6 @@
> >  #include "xdr4.h"
> >  #include "xdr4cb.h"
> >  #include "vfs.h"
> > -#include "current_stateid.h"
> > =20
> >  #include "netns.h"
> >  #include "pnfs.h"
> > @@ -9093,12 +9092,6 @@ put_stateid(struct nfsd4_compound_state *cstate, s=
tateid_t *stateid)
> >  	cstate->have_current_stateid =3D true;
> >  }
> > =20
> > -void
> > -clear_current_stateid(struct nfsd4_compound_state *cstate)
> > -{
> > -	cstate->have_current_stateid =3D false;
> > -}
> > -
> >  /**
> >   * nfsd4_vet_deleg_time - vet and set the timespec for a delegated times=
tamp update
> >   * @req: timestamp from the client
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index 7218c503e5fe..76b828a50ece 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -196,6 +196,14 @@ static inline bool nfsd4_has_session(struct nfsd4_co=
mpound_state *cs)
> >  	return cs->slot !=3D NULL;
> >  }
> > =20
> > +void get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid=
);
> > +void put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid=
);
> > +static inline void
> > +clear_current_stateid(struct nfsd4_compound_state *cstate)
> > +{
> > +	cstate->have_current_stateid =3D false;
> > +}
>=20
> What's the value of keeping this inline function? If there's something
> interesting that should be documented, it needs a kdoc comment;
> otherwise, can we consider replacing its call sites with just
>=20
> 	cstate->have_current_stateid =3D false;
>=20
> and then removing it? Thoughts?

The would be consistent with my goal of reducing indirection.
But I find that get_stateid, put_stateid, clear_current_stateid make a
set together.  open-coding just one of them would break up the set.

Documentation would help.  Maybe also renaming the first two to
get_current_stateid() and put_current_stateid() so that the set is more
obvious.

Thanks,
NeilBrown



>=20
>=20
> > +
> >  struct nfsd4_change_info {
> >  	u32		atomic;
> >  	u64		before_change;
>=20
>=20
> --=20
> Chuck Lever
>=20


