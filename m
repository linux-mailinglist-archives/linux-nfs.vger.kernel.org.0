Return-Path: <linux-nfs+bounces-16585-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 413E2C71254
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 22:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CD614E27C8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 21:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6DB2F12C8;
	Wed, 19 Nov 2025 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HJN1uCDN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TUtncdDc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430C2F49F1
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763587543; cv=none; b=hZB6MEPMuzO6pr/63/tNjb7FLBbnsVk3nLip2g1F9MPt0iDbKZ1eH9trhlTx43swCkGeVWZcyRz3X7Rkqc3izbisSij0MThXTS+v42YRRl5Gm1o+w/PXMpyANxTU2gsspJ06Eiq78Pjz7egZ6UPAcXN16FFDGIY59pwALjp2kmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763587543; c=relaxed/simple;
	bh=ZelXA5CvwW2M8jk4ygRQwX6KgGESJMnF6MMqUo30JEs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MNiGxBQ3+uMNflxSQCLEhm+2Ac0zjV4o2jGG5VuqOPHzkhQhc4k+w0bN7IuxkiVgMAPKjm5ewTM/jFI+ag1gmj+Kbwy0meQ4M47+fP7u5l2m9ihPMfUWL2Eqzr9KHpvxXM0POfcpgUcj9Zd3QPWdodyBmrZ0Qdfb1QB/JQLuF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HJN1uCDN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TUtncdDc; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D425EEC01C6;
	Wed, 19 Nov 2025 16:25:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 16:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763587540; x=1763673940; bh=sdrO+staQ6j+0bnpThxibrK2iagCxDaL1MO
	DXodze5M=; b=HJN1uCDNwkVrX3aDGkm5rUAC5zh0Kp4hnOow3BrC//gss2LHSp6
	TvE1ZDJea/SgorQlN6Lv1BdCveRy2ooxth1FTorvw1UJ/3/xEDpRaeKhERL7HMA7
	qopy7dQu/fNq9pG697mij17zNI/U7NYu2BhIpTgkd1WnF11dX6PEGJMIbe05Uh+F
	xcZnBBPCRNsRoYySfZKYmFzcqQX1ZZL0RSMEflgkGqzPlPxhDcsqZiYqFoBwyJxk
	aJxY1s/oJECkXyxo7MywtUewGt4WcI8XGu4smaH1ju2fs6nv6J+vg8YCC9PdN3/c
	zGZxiexa/41Xf+zNDDOLt9MdHsuM/iFAZJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763587540; x=
	1763673940; bh=sdrO+staQ6j+0bnpThxibrK2iagCxDaL1MODXodze5M=; b=T
	UtncdDcxZB4VtTxsgQlgSKliANCz2ATPZ6tGjje+jHYe5jM2Hr1XGx1wzfx9hOSw
	9T/lu9b5IwECmXngOUSYuK6wpZ+/oQQggCDmMn55X1jxBlEPqRFQVUdA7lW+g2PQ
	rzGSpwerNbjrqwRmG2McjtHW1285q6/FTtpucEXpSu+NacL/3A5BtPvnGeAb2H0b
	nm6DEMJ4H8IgDtsKhNtcOo55+WHZJF6m7rfwcE3PyzVHAj/gVbwmSxlpTSyL4ftl
	AYA1jw81J7pUB/U25crAJcMfXXkiV/a3/oK+9xvhOFqPOzHrbVvGmnoRkw+X5kRQ
	2x86W74phJhmI3ypc6IjA==
X-ME-Sender: <xms:1DUeaQNjGlCDlY99mbo5XCt0Up2LzZngi5Q1WRhI4gZxx9V3l0BDow>
    <xme:1DUeaaobZqgP8mMPwb4eeBkPvnxeOPQK_ITJ-gwHBMeCaPK6MVdZhbBpqfkRuUiIS
    GMnspYzM6YWS3dL6FFRU5U_wfGqy7l6fkbF-pidlLus1dILwsk>
X-ME-Received: <xmr:1DUeaRHez6XJV8uzmShr10cIAjgHv2Pc7XX-cPLSV1PwtznNVBZOQZg7UWhZMwp8rrilSSRP8U3k6Gs7rDj4e8vNQ7EYv_-0XSk7ihR5UqP3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehvdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1DUeafpCnrRn7xN6FKTLL-mn9U5ZGbEIhqFfKylgd5fRKTs3uQ1mzw>
    <xmx:1DUeaabvfAho0MnduDFOqvMW_jcCGWDDTL1eVu-tYto2x3C6iyvFoQ>
    <xmx:1DUeaYVMuUxkgRbSfTAtZytlw44rYV0TWLemgF6NmS-XUs1Fu2HYVA>
    <xmx:1DUeaT-JSRSlmQ2j4J_DMAmJKqlWJS4M6WukhGgoe7R2ADWThV2AlQ>
    <xmx:1DUeadv1V6j8MFpDmX2hZ7T7-QfgEyBZYjVV0xdYqpZGUhq377VjHw9h>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 16:25:38 -0500 (EST)
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
Subject: Re: [PATCH v5 02/11] nfsd: discard NFSD4_FH_FOREIGN
In-reply-to: <0958c74f-afef-4063-9c91-d78462af2315@oracle.com>
References: <20251119033204.360415-1-neilb@ownmail.net>,
 <20251119033204.360415-3-neilb@ownmail.net>,
 <0958c74f-afef-4063-9c91-d78462af2315@oracle.com>
Date: Thu, 20 Nov 2025 08:25:37 +1100
Message-id: <176358753703.634289.8281726516847858029@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 20 Nov 2025, Chuck Lever wrote:
> On 11/18/25 10:28 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > NFSD4_FH_FOREIGN is not needed as the same information is elsewhere.
> >=20
> > If fh_handle.fh_len is 0 then there is no filehandle
>=20
> s/fh_len/fh_size
>=20
> I think to make this new mechanism bullet-proof, maybe fh_put() needs to
> set fh_handle.fh_size to zero?
>=20
> An NFS client can do something crazy like { SECINFO, SAVEFH }. The new
> "fh_size =3D=3D 0" check would pass because fh_put doesn't clear fh_size,
> and then NFSD would proceed to save this no-longer-valid handle. The
> current check catches this by seeing !fh_dentry without FOREIGN flag
> set.

I didn't know that about SECINFO.  I agree that clearing fh_size in
fh_put() is needed.

Thanks,
NeilBrown


>=20
>=20
> > else if fh_dentry is NULL then the filehandle is foreign
> > else the filehandle is local.
> >=20
> > So we can discard NFSD4_FH_FOREIGN and the related struct field,
> > and code.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/nfs4proc.c | 7 ++-----
> >  fs/nfsd/nfsfh.h    | 4 ----
> >  2 files changed, 2 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index e5871e861dce..3160e899a5da 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -693,10 +693,8 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> >  	       putfh->pf_fhlen);
> >  	ret =3D fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
> >  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> > -	if (ret =3D=3D nfserr_stale && putfh->no_verify) {
> > -		SET_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN);
> > +	if (ret =3D=3D nfserr_stale && putfh->no_verify)
> >  		ret =3D 0;
> > -	}
> >  #endif
> >  	return ret;
> >  }
> > @@ -734,8 +732,7 @@ nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> >  	 * is not required, but fh_handle *is*.  Thus a foreign fh
> >  	 * can be saved as needed for inter-server COPY.
> >  	 */
> > -	if (!current_fh->fh_dentry &&
> > -	    !HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN))
> > +	if (cstate->current_fh.fh_handle.fh_size =3D=3D 0)
> >  		return nfserr_nofilehandle;
> > =20
> >  	fh_dup2(&cstate->save_fh, &cstate->current_fh);
> > diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> > index 5ef7191f8ad8..43fcc1dcf69a 100644
> > --- a/fs/nfsd/nfsfh.h
> > +++ b/fs/nfsd/nfsfh.h
> > @@ -93,7 +93,6 @@ typedef struct svc_fh {
> >  						 */
> >  	bool			fh_use_wgather;	/* NFSv2 wgather option */
> >  	bool			fh_64bit_cookies;/* readdir cookie size */
> > -	int			fh_flags;	/* FH flags */
> >  	bool			fh_post_saved;	/* post-op attrs saved */
> >  	bool			fh_pre_saved;	/* pre-op attrs saved */
> > =20
> > @@ -111,9 +110,6 @@ typedef struct svc_fh {
> >  	struct kstat		fh_post_attr;	/* full attrs after operation */
> >  	u64			fh_post_change; /* nfsv4 change; see above */
> >  } svc_fh;
> > -#define NFSD4_FH_FOREIGN (1<<0)
> > -#define SET_FH_FLAG(c, f) ((c)->fh_flags |=3D (f))
> > -#define HAS_FH_FLAG(c, f) ((c)->fh_flags & (f))
> > =20
> >  enum nfsd_fsid {
> >  	FSID_DEV =3D 0,
>=20
>=20
> --=20
> Chuck Lever
>=20


