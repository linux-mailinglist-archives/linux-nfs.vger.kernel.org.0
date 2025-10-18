Return-Path: <linux-nfs+bounces-15376-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE11BEDC69
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 00:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF9C587FBA
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 22:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96F6287258;
	Sat, 18 Oct 2025 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BweAhCoC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iFccYwgP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453F19F41C
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760826228; cv=none; b=V/BpKi3SXvRfXv7XwWXuu5mqH40pcJmAOtGSOf7pezqyrc4T2fN+8GyUZ9cvvBFgHkWYKKUhu1F540AV+7rLL2ISl5HugA6HNYoO5OH9O0rRNc+ex50qdd9moPN1iwVMeKJBI1u0C/ixWqBUDr6APJLYGof6EgOBsTjhP5Y/S7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760826228; c=relaxed/simple;
	bh=mXey9xqUwKx4RsdPV9QRp/hQo9+/iItMjy+Y4PUS6q4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VYjCchzwY1GcJLClFUmya+quuB/Cwp2YeKZ7QEv60abc1eImmAv3c9xlINeBSqmS6EpBLhDJICnWo7v7Ts+uf+Nt6+teFdB0UrbE6F4AZJpGQeJFWzugC1l7PJnv73wWQPKbq2LBcfqYIGpfiDWRu3iHS7ffSBWbmw6lVPIpQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BweAhCoC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iFccYwgP; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F48D7A009F;
	Sat, 18 Oct 2025 18:23:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 18 Oct 2025 18:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760826225; x=1760912625; bh=Xi2IrWLNNKrBviXO6rCKnXzsLY3nWDwmk2O
	0Zv72FvE=; b=BweAhCoCC+ZexbZrfLa7XYa9yWuFQ8mAQntm9hyFBzWbAhXson0
	8xcel6BQmanVGB53fiYzyUuUpVtlz9DxitVeEnbe/zV+lvf3uWCkoc8/EhFzXTR9
	Jv5uP6/6ADUY8Z+oHRx0U95hac/UBQAdmAq4I2p14BezR0+QK/6rLNMjBDbDjqmF
	xuGbzhJgKjYYeAjI88Y1gCObesAycYKeUPhRB72kYwhonFTNceW00WpEjS2erU4p
	3jXt4yC+neCsTPqnn9Rv8/xnr9AqvXpmYrgSVrn/n+XjvJREPzlmELbLdYnCYfLd
	wHty+S5JInSObfeKpDSC2CbVi5AoxK4r6hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760826225; x=
	1760912625; bh=Xi2IrWLNNKrBviXO6rCKnXzsLY3nWDwmk2O0Zv72FvE=; b=i
	FccYwgPS9rsWcWXIw/JT6Buf+aXAom0IpCoPJ1XQ2mln+jgZyiixAW8gkG/PXH/z
	YANQ1qmc91vcCBt2nfymqwqu9L396gQWGsb27Fddxei/88OOuslMtTW5AIehaABp
	kK5TQOClgTREj1mPqUgpKsteqFrf/+W7UQl37BwQIu8wOLVCwtotLttYE0ZKTHQ0
	RYV/FULsSu4g3XPCiXXu9SUOIsppJG0hs29FLBq/7oZ4U3Lm72zikA/cRB3SCV67
	/3RNGpAXWAvs88ih92g0jU+/KsVSHXEQuSigWI1VgLH8Z5f/99pJCQ2r89zW2G5g
	wgKowvE0FzaqBzI6Qn5FQ==
X-ME-Sender: <xms:cBP0aFVGa9rnIsrA63hHZTRGwea_TwuFv_1zcDyzS5tQknvSLhKR4Q>
    <xme:cBP0aJSRquRTck7zJE6nnlSt0ria6e1WckNrEs3IaC0nOc_ICRWyoCvKg3LeLlms5
    zx3bD3CX1bMWN5wOiRu6Yv0MglnXHiEOKGAS-M6S3zvirznbA>
X-ME-Received: <xmr:cBP0aLNOnnBMkElFVJoh7ITtsO8k9XkggmeSvLyIILWZpBkgXkjLLiwA3VploUauS6Xo6rdyfDHMAP0WumHq0CFUbTpM_2FHJDUQzgBckj1y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeefvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudffteeukeeugeetfedtffehgfevkedttdeulefhtdfgffehvdfgieeggeeitdelnecu
    ffhomhgrihhnpehluggpohifnhgvrhdruggrthgrnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinh
    hugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmseht
    rghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghp
    thhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cBP0aPTDDdlBDkOR7OuK2tYsxBEhSLIaMu22lej6YDL5Lw9ocpKMBg>
    <xmx:cBP0aBh2T2xlyt4I-Ox4fDyF_scuv_kiWdC0aP-LCex8A7Eu5gjOpQ>
    <xmx:cBP0aA_3Pr9S0NKjxEldpgx9ZYaw0blSEU0sA7pR7-ykDWqyskS3zw>
    <xmx:cBP0aAEio9FQfHXKT_hcdRAnEBjFo6z-Ap_hwD6lC0oPeuTd0u7OrA>
    <xmx:cRP0aK1z1ZA_BWIOIjgp7USO4oi8pIm5HExdCPRtfzCyQ7l3CLI5ctmv>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 18:23:42 -0400 (EDT)
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
Subject: Re: [PATCH 1/7] nfsd: discard ->op_release() for v4 operations
In-reply-to: <3c41883e-dac0-4b80-8ec3-d627936cd574@oracle.com>
References: <20251018000553.3256253-1-neilb@ownmail.net>,
 <20251018000553.3256253-2-neilb@ownmail.net>,
 <3c41883e-dac0-4b80-8ec3-d627936cd574@oracle.com>
Date: Sun, 19 Oct 2025 09:23:40 +1100
Message-id: <176082622071.1793333.16934396492512587125@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 19 Oct 2025, Chuck Lever wrote:
> On 10/17/25 8:02 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > Instead of having a separate ->op_release() function, change to
> > releasing any resources immediately after they have been encoded into
> > the reply or, in one case, if processing the op resulted in an error.
> >=20
> > There have been two bugs recently which were (arguably) caused by having
> > the ->op_release code quite separate from the other code.  I think it
> > makes more sense to keep it all together.  Any resources that ->op_func()
> > allocates are now freed after the op reply has been encoded.  The encode
> > function easily knows when the resource is present and so needs to be
> > freed.
> >=20
> > One effect of this is that the trace_nfsd_read_done() tracepoint is no
> > longer considered to be part of "releasing" anything, and is now only
> > called when the read is done successfully.  It is also now *before*
> > generic errors are traced, rather than after.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/blocklayout.c | 10 ++++++++--
> >  fs/nfsd/nfs4proc.c    | 46 -------------------------------------------
> >  fs/nfsd/nfs4state.c   | 16 ---------------
> >  fs/nfsd/nfs4xdr.c     | 28 ++++++++++++++++++++------
> >  fs/nfsd/xdr4.h        |  3 ---
> >  5 files changed, 30 insertions(+), 73 deletions(-)
> >=20
> > diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> > index 101cccbee4a3..cd38c7f9d806 100644
> > --- a/fs/nfsd/blocklayout.c
> > +++ b/fs/nfsd/blocklayout.c
> > @@ -206,6 +206,7 @@ nfsd4_block_get_device_info_simple(struct super_block=
 *sb,
> >  {
> >  	struct pnfs_block_deviceaddr *dev;
> >  	struct pnfs_block_volume *b;
> > +	int status;
> > =20
> >  	dev =3D kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
> >  	if (!dev)
> > @@ -217,8 +218,13 @@ nfsd4_block_get_device_info_simple(struct super_bloc=
k *sb,
> > =20
> >  	b->type =3D PNFS_BLOCK_VOLUME_SIMPLE;
> >  	b->simple.sig_len =3D PNFS_BLOCK_UUID_LEN;
> > -	return sb->s_export_op->get_uuid(sb, b->simple.sig, &b->simple.sig_len,
> > -			&b->simple.offset);
> > +	status =3D sb->s_export_op->get_uuid(sb, b->simple.sig, &b->simple.sig_=
len,
> > +					   &b->simple.offset);
> > +	if (status) {
> > +		kfree(dev);
> > +		gdp->gd_device =3D NULL;
> > +	}
> > +	return status;
> >  }
> > =20
> >  static __be32
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 2222bb283baf..9d53ea289bf3 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -984,17 +984,6 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_comp=
ound_state *cstate,
> >  	return status;
> >  }
> > =20
> > -
> > -static void
> > -nfsd4_read_release(union nfsd4_op_u *u)
> > -{
> > -	if (u->read.rd_nf) {
> > -		trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> > -				     u->read.rd_offset, u->read.rd_length);
> > -		nfsd_file_put(u->read.rd_nf);
> > -	}
> > -}
> > -
> >  static __be32
> >  nfsd4_readdir(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstat=
e,
> >  	      union nfsd4_op_u *u)
> > @@ -1120,20 +1109,6 @@ nfsd4_secinfo_no_name(struct svc_rqst *rqstp, stru=
ct nfsd4_compound_state *cstat
> >  	return nfs_ok;
> >  }
> > =20
> > -static void
> > -nfsd4_secinfo_release(union nfsd4_op_u *u)
> > -{
> > -	if (u->secinfo.si_exp)
> > -		exp_put(u->secinfo.si_exp);
> > -}
> > -
> > -static void
> > -nfsd4_secinfo_no_name_release(union nfsd4_op_u *u)
> > -{
> > -	if (u->secinfo_no_name.sin_exp)
> > -		exp_put(u->secinfo_no_name.sin_exp);
> > -}
> > -
> >  /*
> >   * Validate that the requested timestamps are within the acceptable rang=
e. If
> >   * timestamp appears to be in the future, then it will be clamped to
> > @@ -2426,12 +2401,6 @@ nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
> >  	return nfserr;
> >  }
> > =20
> > -static void
> > -nfsd4_getdeviceinfo_release(union nfsd4_op_u *u)
> > -{
> > -	kfree(u->getdeviceinfo.gd_device);
> > -}
> > -
> >  static __be32
> >  nfsd4_layoutget(struct svc_rqst *rqstp,
> >  		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
> > @@ -2512,12 +2481,6 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
> >  	return nfserr;
> >  }
> > =20
> > -static void
> > -nfsd4_layoutget_release(union nfsd4_op_u *u)
> > -{
> > -	kfree(u->layoutget.lg_content);
> > -}
> > -
> >  static __be32
> >  nfsd4_layoutcommit(struct svc_rqst *rqstp,
> >  		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
> > @@ -3444,7 +3407,6 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
> >  	},
> >  	[OP_LOCK] =3D {
> >  		.op_func =3D nfsd4_lock,
> > -		.op_release =3D nfsd4_lock_release,
> >  		.op_flags =3D OP_MODIFIES_SOMETHING |
> >  				OP_NONTRIVIAL_ERROR_ENCODE,
> >  		.op_name =3D "OP_LOCK",
> > @@ -3453,7 +3415,6 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
> >  	},
> >  	[OP_LOCKT] =3D {
> >  		.op_func =3D nfsd4_lockt,
> > -		.op_release =3D nfsd4_lockt_release,
> >  		.op_flags =3D OP_NONTRIVIAL_ERROR_ENCODE,
> >  		.op_name =3D "OP_LOCKT",
> >  		.op_rsize_bop =3D nfsd4_lock_rsize,
> > @@ -3526,7 +3487,6 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
> >  	},
> >  	[OP_READ] =3D {
> >  		.op_func =3D nfsd4_read,
> > -		.op_release =3D nfsd4_read_release,
> >  		.op_name =3D "OP_READ",
> >  		.op_rsize_bop =3D nfsd4_read_rsize,
> >  		.op_get_currentstateid =3D nfsd4_get_readstateid,
> > @@ -3576,7 +3536,6 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
> >  	},
> >  	[OP_SECINFO] =3D {
> >  		.op_func =3D nfsd4_secinfo,
> > -		.op_release =3D nfsd4_secinfo_release,
> >  		.op_flags =3D OP_HANDLES_WRONGSEC,
> >  		.op_name =3D "OP_SECINFO",
> >  		.op_rsize_bop =3D nfsd4_secinfo_rsize,
> > @@ -3627,7 +3586,6 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
> >  	/* NFSv4.1 operations */
> >  	[OP_EXCHANGE_ID] =3D {
> >  		.op_func =3D nfsd4_exchange_id,
> > -		.op_release =3D nfsd4_exchange_id_release,
> >  		.op_flags =3D ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
> >  				| OP_MODIFIES_SOMETHING,
> >  		.op_name =3D "OP_EXCHANGE_ID",
> > @@ -3681,7 +3639,6 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
> >  	},
> >  	[OP_SECINFO_NO_NAME] =3D {
> >  		.op_func =3D nfsd4_secinfo_no_name,
> > -		.op_release =3D nfsd4_secinfo_no_name_release,
> >  		.op_flags =3D OP_HANDLES_WRONGSEC,
> >  		.op_name =3D "OP_SECINFO_NO_NAME",
> >  		.op_rsize_bop =3D nfsd4_secinfo_rsize,
> > @@ -3708,14 +3665,12 @@ static const struct nfsd4_operation nfsd4_ops[] =
=3D {
> >  #ifdef CONFIG_NFSD_PNFS
> >  	[OP_GETDEVICEINFO] =3D {
> >  		.op_func =3D nfsd4_getdeviceinfo,
> > -		.op_release =3D nfsd4_getdeviceinfo_release,
> >  		.op_flags =3D ALLOWED_WITHOUT_FH,
> >  		.op_name =3D "OP_GETDEVICEINFO",
> >  		.op_rsize_bop =3D nfsd4_getdeviceinfo_rsize,
> >  	},
> >  	[OP_LAYOUTGET] =3D {
> >  		.op_func =3D nfsd4_layoutget,
> > -		.op_release =3D nfsd4_layoutget_release,
> >  		.op_flags =3D OP_MODIFIES_SOMETHING,
> >  		.op_name =3D "OP_LAYOUTGET",
> >  		.op_rsize_bop =3D nfsd4_layoutget_rsize,
> > @@ -3761,7 +3716,6 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
> >  	},
> >  	[OP_READ_PLUS] =3D {
> >  		.op_func =3D nfsd4_read,
> > -		.op_release =3D nfsd4_read_release,
> >  		.op_name =3D "OP_READ_PLUS",
> >  		.op_rsize_bop =3D nfsd4_read_plus_rsize,
> >  		.op_get_currentstateid =3D nfsd4_get_readstateid,
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 35004568d43e..1e821f5d09a3 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -8454,14 +8454,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> >  	return status;
> >  }
> > =20
> > -void nfsd4_lock_release(union nfsd4_op_u *u)
> > -{
> > -	struct nfsd4_lock *lock =3D &u->lock;
> > -	struct nfsd4_lock_denied *deny =3D &lock->lk_denied;
> > -
> > -	kfree(deny->ld_owner.data);
> > -}
> > -
> >  /*
> >   * The NFSv4 spec allows a client to do a LOCKT without holding an OPEN,
> >   * so we do a temporary open here just to get an open file to pass to
> > @@ -8567,14 +8559,6 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> >  	return status;
> >  }
> > =20
> > -void nfsd4_lockt_release(union nfsd4_op_u *u)
> > -{
> > -	struct nfsd4_lockt *lockt =3D &u->lockt;
> > -	struct nfsd4_lock_denied *deny =3D &lockt->lt_denied;
> > -
> > -	kfree(deny->ld_owner.data);
> > -}
> > -
> >  __be32
> >  nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  	    union nfsd4_op_u *u)
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 30ce5851fe4c..1ffe8ddc1215 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4174,6 +4174,7 @@ nfsd4_encode_lock(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
> >  	case nfserr_denied:
> >  		/* denied */
> >  		status =3D nfsd4_encode_lock4denied(xdr, &lock->lk_denied);
> > +		kfree(lock->lk_denied.ld_owner.data);
> >  		break;
> >  	default:
> >  		return nfserr;
> > @@ -4192,6 +4193,7 @@ nfsd4_encode_lockt(struct nfsd4_compoundres *resp, =
__be32 nfserr,
> >  	if (nfserr =3D=3D nfserr_denied) {
> >  		/* denied */
> >  		status =3D nfsd4_encode_lock4denied(xdr, &lockt->lt_denied);
> > +		kfree(lockt->lt_denied.ld_owner.data);
> >  		if (status !=3D nfs_ok)
> >  			return status;
> >  	}
> > @@ -4532,6 +4534,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
> >  	/* Reserve space for the eof flag and byte count */
> >  	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT * 2))) {
> >  		WARN_ON_ONCE(splice_ok);
> > +		nfsd_file_put(read->rd_nf);
> >  		return nfserr_resource;
> >  	}
> >  	xdr_commit_encode(xdr);
> > @@ -4543,6 +4546,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
> >  		nfserr =3D nfsd4_encode_splice_read(resp, read, file, maxcount);
> >  	else
> >  		nfserr =3D nfsd4_encode_readv(resp, read, maxcount);
> > +	nfsd_file_put(read->rd_nf);
> >  	if (nfserr) {
> >  		xdr_truncate_encode(xdr, eof_offset);
> >  		return nfserr;
> > @@ -4551,6 +4555,8 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
> >  	wire_data[0] =3D read->rd_eof ? xdr_one : xdr_zero;
> >  	wire_data[1] =3D cpu_to_be32(read->rd_length);
> >  	write_bytes_to_xdr_buf(xdr->buf, eof_offset, &wire_data, XDR_UNIT * 2);
> > +	trace_nfsd_read_done(read->rd_rqstp, read->rd_fhp,
> > +			     read->rd_offset, read->rd_length);
> >  	return nfs_ok;
> >  }
> > =20
> > @@ -4803,8 +4809,11 @@ nfsd4_encode_secinfo(struct nfsd4_compoundres *res=
p, __be32 nfserr,
> >  {
> >  	struct nfsd4_secinfo *secinfo =3D &u->secinfo;
> >  	struct xdr_stream *xdr =3D resp->xdr;
> > +	__be32 status;
> > =20
> > -	return nfsd4_encode_SECINFO4resok(xdr, secinfo->si_exp);
> > +	status =3D nfsd4_encode_SECINFO4resok(xdr, secinfo->si_exp);
> > +	exp_put(secinfo->si_exp);
> > +	return status;
> >  }
>=20
> Unfortunately this goes in exactly the opposite direction that xdrgen
> is taking us. I don't want to add anything not related to XDR to the
> encoder functions. The encoder functions for individual operations
> will someday be all machine generated.

I think some substantial restructuring will be needed before that can
happen.  The various "read" ops (read, readdir, readlink) do that
actually reading in the encode operation.  Ops that return a path name
do the dcache walk in there.

Until we have a clear design for how xdrgen would be more fully
integrated, I think it is not possible to tell if this actually adds a
burden, or maybe removes a burden.

I can imagine that we might want to call the xdr encode function
directly from the corresponding op_func.  In that case, having release
code explicitly in the old xdr encode function will make it clear what
needs to be moved out into the op func.

But in any case I don't think that the 'release' functions are helpful.
An alternate approach would be add fields kfree, file_put, and exp_put
to struct nfsd4_op, have the op_func fill those in if it wants them to
be released, and then always free them all after the op has completed.
Do you think that would be a better approach?

Thanks,
NeilBrown

