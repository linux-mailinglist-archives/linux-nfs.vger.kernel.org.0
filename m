Return-Path: <linux-nfs+bounces-16583-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9600BC71202
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 22:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C81C4E22D4
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 21:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9857B2FB97B;
	Wed, 19 Nov 2025 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="h28+Mw9j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iW/B+q3J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925802F49FB
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586850; cv=none; b=lq6nUxZomqAdzMz0DbnMeia/Paw87tiQxGtvsN3/21g8eaNwN4kKzGSRsu4Hq4MZNSdFXQ6x0PprP0rsvBth6U2UzZdPYPGMsoc7H+2pYet5l/yahWMb+sRAm6nC4IjFtGgXd40Rr45fKGx45u+UpAieQKOQnjOqURXAHzpy1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586850; c=relaxed/simple;
	bh=IR6uRqVOLwxuS9iPUYyQIJ0PfbunP/zm4D63VsnhyS8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=e5w+dta+z2gTkKSInaTHE9SU/HPtS7YoBwv/K1RQpaISuNAm/YLo05g4JNVYh0/MSwoL5+KXxXjoLnDMHQT9KunhGRBpVqgIoNdkc6pO6QLP4QhJ/MIYqH9qqLTFSc95NsdwYXFq501eLGrmuVHJo2EAmhIwiuOWUClRvsEvekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=h28+Mw9j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iW/B+q3J; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FE2AEC04EA;
	Wed, 19 Nov 2025 16:14:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 16:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763586846; x=1763673246; bh=sLmhOebjcGdiBIXUAebqRFmIAXu5XesduRf
	L7U5wI10=; b=h28+Mw9jTM6OEW1ECo0iWvNzQiiEErdoxoiirMTiBziavq5bsa7
	pc/yTjik18rFuIkUCT/JBH6uVXOdoAkudIi30XXVbG+d2BH6A4HIKI+4JLsZDO/1
	Wg3Po/cdXAvMFVBpUMhSNY8tVbrATejJkhuhIVTy557Qh+1hG6Y3FfKo2lj/5d8k
	psLMuHLLGj5q05lgW1m8+7rQG5nbp+95VZ+mF7Uy6ZJ5jTeQ84FFC171TqmjZabd
	LMvvwJUEpYuYZvwDbAeCbGhCGv4/xb7dLbDmaVVRO8LG1GMbzWrGsdyLmUiW4HvK
	kBK9ObodsNszY3yDmPwzcn/0j3FwF2H1nUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763586846; x=
	1763673246; bh=sLmhOebjcGdiBIXUAebqRFmIAXu5XesduRfL7U5wI10=; b=i
	W/B+q3JarDRq1nJDIxSDUyqDCgawBO9kaJi4DnFxdq7hs+ILDOQhZ914z+tvQ7Xh
	a00H7I2oidbqbzC7SD+ra7KdfYDljNu4tRUWqXBgY3O7WFw+8UvoMqH8lhg64HaC
	2AXp1/X4vHDxI1S1FQGPxX25rCQNLt6KamVbnJN4Hvqz59JX0Q831VMGtAJpSmML
	r07DtANBqb6s1g85dWunfXgqhf0tvGU7jU8mljeh05RCGKQEeGka5MYFLBJ8616K
	3b3+FREPOEHTph7bZTqFb4dqtQWQs3gjRrBKFluh+qWzu33lP/4Tt7c8peknu5Kj
	KLq/oW6Pe2Xw5WMWn9HbA==
X-ME-Sender: <xms:HjMeaalNNo2nfI-VCiPTQW1sWVcdafmbSe-_6029uskcpBIplhoeAQ>
    <xme:HjMeaVgoIge_UJZUDyV7p33rg9DbQwIzGa9bBLiQtoliByANVHdGd6nQF45hsviFo
    gMW6qDEaHLYR3zR0Y7ooJeAkkO3YJcRi4JJ64iVZ3eoboJ8wQ>
X-ME-Received: <xmr:HjMeaSeYrYMdpTuzOPdewe_TupBBiuTAgjDN8QGh-6wzfWElxtUr72P1LoXy-z52rF1bkffn33D_gLl5hIB9zzWG7WpGitMoBktErAvUeVbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehvdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:HjMeaVhCfgFnvA1CkeoRQsT0XQ-bU2UMg3LoM1MLJfkkwISRSCk-7A>
    <xmx:HjMeaawe8_EsXtnSoEp6SSF6Aw1P8s1-e3FLaiCazI4rcqCZtELh0w>
    <xmx:HjMeaRO20m9_3wgJPwG4Ucmh5fBvYZEJK_JJBtqMzvx_B5H9b1sOSQ>
    <xmx:HjMeabUO2U2ae7HrAh5rpSDCGBN1d8sji3DUYpSI6GeR3cquf3NPew>
    <xmx:HjMeaQFsH8m1DUHp4mhqInZPFW_hWlnZBMCT9jie9lw_Ia3uOaddUyqG>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 16:14:04 -0500 (EST)
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
Subject: Re: [PATCH v5 01/11] nfsd: rename ALLOWED_WITHOUT_FH to
 ALLOWED_WITHOUT_LOCAL_FH and revise use
In-reply-to: <a27cc4b9-20c2-4065-97d5-81683f686195@oracle.com>
References: <20251119033204.360415-1-neilb@ownmail.net>,
 <20251119033204.360415-2-neilb@ownmail.net>,
 <a27cc4b9-20c2-4065-97d5-81683f686195@oracle.com>
Date: Thu, 20 Nov 2025 08:13:56 +1100
Message-id: <176358683631.634289.10050977529867026252@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 20 Nov 2025, Chuck Lever wrote:
> On 11/18/25 10:28 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > nfsdv4 ops which do not have ALLOWED_WITHOUT_FH can assume that a PUTFH
> > has been called and may assume that current_fh->fh_dentry is non-NULL.
> > nfsd4_setattr(), for example, assumes fh_dentry !=3D NULL.
> >=20
> > However the possibility of foreign filehandles (needed for v4.2 COPY)
> > means that there maybe a filehandle present while fh_dentry is NULL.
> >=20
> > Sending a COMPOUND containing:
> >    SEQUENCE
> >    PUTFH - foreign filehandle
> >    SETATTR - new mode
> >    SAVEFH
> >    COPY - with non-empty server list
> >=20
> > to an NFS server with inter-server copy enabled will cause a NULL
> > pointer dereference when nfsd4_setattr() calls fh_want_write().
> >=20
> > Most NFSv4 ops actually want a "local" filehandle, not just any
> > filehandle.  So this patch renames ALLOWED_WITHOUT_FH to
> > ALLOWED_WITHOUT_LOCAL_FH and sets it on those which don't require a local
> > filehandle.  That is all that don't require any filehandle together with
> > SAVEFH, which is the only OP which needs to handle a foreign current_fh.
> > (COPY must handle a foreign save_fh, but all ops which access save_fh
> > already do any required validity tests themselves).
> >=20
> > nfsd4_savefh() is changed to validate the filehandle itself as the
> > caller no longer validates it.
> >=20
> > nfsd4_proc_compound no longer allows ops without
> > ALLOWED_WITHOUT_LOCAL_FH to be called with a foreign fh - current_fh
> > must be local and ->fh_dentry must be non-NULL.  This protects
> > nfsd4_setattr() and any others that might use ->fh_dentry without
> > checking.
> >=20
> > The
> >        current_fh->fh_export &&
> > test is removed from an "else if" because that condition is now only
> > tested when current_fh->fh_dentry is not NULL, and in that case
> > current_fh->fh_export is also guaranteed to not be NULL.
> >=20
> > Fixes: b9e8638e3d9e ("NFSD: allow inter server COPY to have a STALE sourc=
e server fh")
>=20
> Shall we mark this one with Cc: stable?

That would be appropriate I think.


>=20
>=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/nfs4proc.c | 58 ++++++++++++++++++++++++++--------------------
> >  fs/nfsd/xdr4.h     |  2 +-
> >  2 files changed, 34 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index dcad50846a97..e5871e861dce 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -729,6 +729,15 @@ static __be32
> >  nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  	     union nfsd4_op_u *u)
> >  {
> > +	/*
> > +	 * SAVEFH is "ALLOWED_WITHOUT_LOCAL_FH" in that current_fh.fh_dentry
> > +	 * is not required, but fh_handle *is*.  Thus a foreign fh
> > +	 * can be saved as needed for inter-server COPY.
> > +	 */
> > +	if (!current_fh->fh_dentry &&
> > +	    !HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN))
> > +		return nfserr_nofilehandle;
> > +
> >  	fh_dup2(&cstate->save_fh, &cstate->current_fh);
> >  	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
> >  		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid=
_t));
>=20
>   CC [M]  fs/nfsd/nfs4proc.o
> /home/cel/src/linux/for-korg/fs/nfsd/nfs4proc.c: In function =E2=80=98nfsd4=
_savefh=E2=80=99:
> /home/cel/src/linux/for-korg/fs/nfsd/nfs4proc.c:737:14: error:
> =E2=80=98current_fh=E2=80=99 undeclared (first use in this function); did y=
ou mean
> =E2=80=98current_uid=E2=80=99?
>   737 |         if (!current_fh->fh_dentry &&
>       |              ^~~~~~~~~~
>       |              current_uid

Both.  I did lots of test compiles, but obviously missed this point
in the series.

>=20
> Perhaps we want:
>=20
> -	if (!current_fh->fh_dentry &&
> -	    !HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN))
> +	if (!cstate->current_fh.fh_dentry &&
> +	    !HAS_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN))
>  		return nfserr_nofilehandle;

yep.

> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -1006,7 +1006,7 @@ extern __be32 nfsd4_free_stateid(struct svc_rqst *r=
qstp,
> >  extern void nfsd4_bump_seqid(struct nfsd4_compound_state *, __be32 nfser=
r);
> > =20
> >  enum nfsd4_op_flags {
> > -	ALLOWED_WITHOUT_FH =3D 1 << 0,    /* No current filehandle required */
> > +	ALLOWED_WITHOUT_LOCAL_FH =3D 1 << 0,    /* No current filehandle fh_den=
try required */
>=20
> The new comment is unclear to me. Is there missing punctuation?
>=20

+	ALLOWED_WITHOUT_LOCAL_FH =3D 1 << 0,    /* No "current filehandle fh_dentry=
" required */
??

I've made it:
+	ALLOWED_WITHOUT_LOCAL_FH =3D 1 << 0,    /* No fh_dentry needed in current f=
ilehandle */

Thanks,
NeilBrown


>=20
> >  	ALLOWED_ON_ABSENT_FS =3D 1 << 1,  /* ops processed on absent fs */
> >  	ALLOWED_AS_FIRST_OP =3D 1 << 2,   /* ops reqired first in compound */
> >  	/* For rfc 5661 section 2.6.3.1.1: */
>=20
>=20
> --=20
> Chuck Lever
>=20


