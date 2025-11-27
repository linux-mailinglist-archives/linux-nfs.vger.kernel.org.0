Return-Path: <linux-nfs+bounces-16745-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A12C8C7DB
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 01:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DC93B5FC5
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 00:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC6C26E711;
	Thu, 27 Nov 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="JpvyLLL3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aAxVPcMv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7226B973
	for <linux-nfs@vger.kernel.org>; Thu, 27 Nov 2025 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204936; cv=none; b=n0DPA+Ci8755aO404IWHGIJgdIK5Mq1ywKZXu2k37dxWV/X1/GMkkDk9AXsy4+EI0y542fvJpsuAFmsuy/5y3mX3pl2KaJQSXjD68fX2IkwYJI1VoO/3RoxYESVCmZqdaSpwn370jIKOEu9TDzAigRr7+kjEg1hlCyCRhDSug38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204936; c=relaxed/simple;
	bh=ox14OpNlevvLPOPCSpRMTRuSc0yhZkUrOZQjEti6wDs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=S8WS7ykQmaq43nvbATgGoVjKdQERGw9a0h7TEWTsikazJecFKPpV7mtoQxnl2QYaLnM3wdNDDPSQ4fMxJHojvBC+alqSHWzI2ufZEAoHt50qLf2cSpS2TCZxpj134TVJbzAwGjyQ84ycB4aKUfCSY0pQi6xwP3x9jf/LLCTZ0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=JpvyLLL3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aAxVPcMv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 585ABEC01FE;
	Wed, 26 Nov 2025 19:55:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 26 Nov 2025 19:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1764204932; x=1764291332; bh=nV0kDi07f1AjS1Em2jv2ZfWCvG0SFGbl0RA
	HDmXcSgg=; b=JpvyLLL3zhv3sYruyxrw1RSwRKJ8AV/v2vFNpWznTvgWN8CYHf6
	PNxyFXfZM11Kv9H84AQymKYCMyHq2lQP2Yejay1p/7AUY5pm64+lNil/JJh31/nT
	Xr9+Ho2zMlzqGvyWrZKrlClozd7LrLJ3X0EFMKR/9biOhYW9bGabq2DFBwrSWg+J
	ygwCWTSGZMkVMplW78ADCqT+A7nrvVef20RadmEnfeCUvpdjUaAznwGtOTvx04Ay
	NKg5o1/dQYr87QCXNQABsO/sSpVTupB8LHc+f4UYOEop3mvgtwdXc2pVVHiy/DVg
	1bLpx5k4pnVoaVAjJyL2X1Q4acTsee6hDpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764204932; x=
	1764291332; bh=nV0kDi07f1AjS1Em2jv2ZfWCvG0SFGbl0RAHDmXcSgg=; b=a
	AxVPcMv2IBfYc10cGdUXYKbH0oqGnjXhMV2tfThOfWymxiEXtRqYn230lzz8l0ei
	THmzybGy7LRuvSiJKL4a3bma/wX4GgYTx/vhjJ6EHgKg5ah4UrXg78TLU3wBht1W
	u1MK2Gi3FkJx7Vi7Eltk8yrH7Y8XJ2i2AzRXWGcgB4FmODJUmNLZ0PSjDkvYQZyc
	zo3ZLhany5Q1s3egtbjXWN2UjYBxQWZR50G0vfyZBbcD4BZ83ygNgWZ5WYfuE78X
	uzAduBqKcsOcGjxKY+mgdfhGZQK4fPGIRIHCF6jovsaLBV5tDWqPYA30V+GKDNQ9
	tCVs3Wm+0FdElRmRSFDSA==
X-ME-Sender: <xms:g6EnafgDc7vF0PpeqSzsbhD1iKSDxMtsU7Rlux_SGRNLz43nmqafOQ>
    <xme:g6EnaeSE99ziQ6I-2IX-dWE_Viz_zhr7bXK_3TjaJOLSoYLwUrDLSzaJwqehRMyZM
    kYXp9Xf7rwy9hoRAzyhDJbODAadZ82cP6GkKldE8b1U0G8C7Q>
X-ME-Received: <xmr:g6EnaRVJPJzPz14-XshYL09Hp2Qa8J6gAjNBWNi6DI7ZBY77oQ2HIX7jKsvS7Ajr3nXrBUczKReMa6AJjhoMdE4NobEwbjVmqu74bvesvurZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefgffekleetuedttdejjefhgeejkeegkedvteeutddvvedtudeifffgtefhfeehnecu
    ffhomhgrihhnpehivghtfhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhnfh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhpvgih
    rdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtph
    htthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegu
    rghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g6EnaSRqX9Neyg6S7BvuK34OgtAvYoycadhdoNVMLlKm1iiLT3ZGnA>
    <xmx:g6Enabld4RHKNlnsGK4jwM6iztvIhrnOmZ-pOqRrVuxOOEVxnXVuAQ>
    <xmx:g6EnaY59Aj7fWwcHy6h4wRq1Q1NDeFVs4DJ5Y0ViN6ieO0zEg7KsWg>
    <xmx:g6EnaRhln_oUlEO8nPT5bT6yNPq2Neu2ZJYk1ffXFfJB5QoWYTrasA>
    <xmx:hKEnaZ9v4ljdnKiihQ5P14u7g-g7cRuwMJZ2o0S3Iw75WK6Oc3XVwPEC>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 19:55:29 -0500 (EST)
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 04/14] nfsd: allow unrecognisable filehandle for
 foreign servers in COPY
In-reply-to: <aSM5oSoiw_6wDU_K@morisot.1015granger.net>
References: <20251122005236.3440177-1-neilb@ownmail.net>,
 <20251122005236.3440177-5-neilb@ownmail.net>,
 <aSIoEqzuT6seYiq0@morisot.1015granger.net>,
 <aSM5oSoiw_6wDU_K@morisot.1015granger.net>
Date: Thu, 27 Nov 2025 11:55:23 +1100
Message-id: <176420492316.634289.7890732620603254090@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 24 Nov 2025, Chuck Lever wrote:
> On Sat, Nov 22, 2025 at 04:16:02PM -0500, Chuck Lever wrote:
> > On Sat, Nov 22, 2025 at 11:47:02AM +1100, NeilBrown wrote:
> > > From: NeilBrown <neil@brown.name>
> > >=20
> > > RFC-7862 acknowledges that a filehandle provided as the source of an
> > > inter-server copy might result in NFS4ERR_STALE when given to PUTFH, and
> > > gives guidance on how this error can be ignored (section 15.2.3).
> > >=20
> > > NFS4ERR_BADHANDLE is also a possible error in this circumstance if the
> > > foreign server is running a different implementation of NFS than the
> > > current one.
> >=20
> > The RFC uses the terms "source" and "destination" server, fwiw.
> >=20
> > It would be interesting to see if nfserr_badhandle can be triggered
> > during an NFSD <-> NFSD copy.
> >=20
> >=20
> > > This appears to be a simple omission in the RFC.
> >=20
> > Perhaps. It might also be the result of the RFC authors giving
> > implementers flexibility to innovate.
> >=20
> > I would like to consult with the WG and possibly file an errata, or
> > add this observation to the "NFSv4.2 COPY implementation experience"
> > document I'm helping Olga with:
> >=20
> > https://datatracker.ietf.org/doc/draft-cel-nfsv4-copy-implementation-expe=
rience/
> >=20
> > They might want to consider NFS4ERR_MOVED as well.
> >=20
> >=20
> > > There can be no harm in delaying a BADHANDLE error in the same situation
> > > where we already delay STALE errors, and no harm in sending a locally
> > > "bad" handle to a foreign server to request a COPY.
> >=20
> > These are plausible claims. But IMO, they need firmer rationale.
>=20
> My comments aren't terribly clear about this, but I agree that PUTFH
> handling NFS4ERR_BADHANDLE is a concern when there is a subsequent
> COPY operation in the COMPOUND.
>=20
> I think we can't rely on the letter of RFC 7862, as you pointed out.
> However, the spirit of RFC 7862 is that PUTFH mustn't fail if a
> client presents a foreign file handle via a PUTFH that precedes a
> COPY operation. The lack of BCP14 language specific to other status
> codes shouldn't stop NFSD from handling other status codes as it
> needs to (in fact, the absence of such language affords us the
> opportunity of doing exactly that).
>=20
> The reason for this potential PUTFH failure is an artifact of NFSD's
> PUTFH implementation, which unconditionally invokes fh_verify.

RFC8881 says very little in the description of PUTFH.
However the section on error codes say:

 15.1.2.1. NFS4ERR_BADHANDLE (Error Code 10001)

    Illegal NFS filehandle for the current server.  The current
    filehandle failed internal consistency checks.  Once accepted as
    valid (by PUTFH), no subsequent status change can cause the
    filehandle to generate this error.=20

This implies to me that if PUTFH accepts a filehandle, then it is
"accepted as valid" and that cannot change.  So no other op can claim
BADHANDLE if PUTFH didn't.  But other OPs do have BADHANDLE as a valid
error.

This text also says the "current filehandle" failed, so that implies
something that has already been accepted by PUTFH (or generated by
LOOKUP???).

So I think we are in agreement that the RFC isn't crystal clear but
doesn't put any barriers in the way of us making this change.

>=20
> I'm wondering if PUTFH needs to check for /specific/ status codes
> from fh_verify before looking ahead in the incoming COMPOUND, or if
> it ought to look ahead on /any/ failure of fh_verify.

I don't have a strong opinion.
fh_verify() can also generate
  nfserr_nofilehandle
  nfserr_jukebox
  nfserr_perm

nferr_perm could arguably be handled the same way that nfserr_stale is
handled.

>=20
> And, is this patch a fix that needs to be backported to LTS kernels?
> If so, then perhaps it needs to go before the previous patch.

It doesn't fix a regression, a security hole, and data corruption, a
kernel panic.  So I don't think it needs to be backported (others might
think otherwise).

I think the failure mode is that the client would fallback to handling
the copy like it would for v4.1.

>=20
> (It seems like NFSv4.2 could have added a PUT_FOREIGN_FH operation
> to avoid all this nonsense).

That would make a lot of sense!

>=20
> (I'll also note that now that our MAX_OPS_PER_COMPOUND has increased
> and might increase again, moving the COPY look ahead checking out of
> nfsd4_proc_compound is a huge bonus for handling large COMPOUNDs).

true

NeilBrown

>=20
>=20
> > > So extend the test in nfsd4_putfh to also check for nfserr_badhandle.
> > >=20
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/nfsd/nfs4proc.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 112e62b6b9c6..ae34b816371c 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -693,7 +693,8 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> > >  	       putfh->pf_fhlen);
> > >  	ret =3D fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
> > >  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> > > -	if (ret =3D=3D nfserr_stale && inter_copy_offload_enable) {
> > > +	if ((ret =3D=3D nfserr_badhandle || ret =3D=3D nfserr_stale) &&
> > > +	    inter_copy_offload_enable) {
> > >  		struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
> > >  		struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
> > > =20
> > > @@ -713,7 +714,11 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> > >  			 *  NOT return NFS4ERR_STALE for either
> > >  			 *  operation.
> > >  			 * We limit this to when there is a COPY
> > > -			 * in the COMPOUND.
> > > +			 * in the COMPOUND, and extend it to
> > > +			 * also ignore NFS4ERR_BADHANDLE despite the
> > > +			 * RFC not requiring this.  If the remote
> > > +			 * server is running a different NFS implementation,
> > > +			 * NFS4ERR_BADHANDLE is a likely error.
> > >  			 */
> > >  			ret =3D 0;
> > >  		}
> > > --=20
> > > 2.50.0.107.gf914562f5916.dirty
> > >=20
> > >=20
> >=20
> > --=20
> > Chuck Lever
> >=20
>=20
> --=20
> Chuck Lever
>=20
>=20


