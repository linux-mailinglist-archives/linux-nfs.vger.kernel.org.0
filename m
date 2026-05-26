Return-Path: <linux-nfs+bounces-21953-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHt6DqCHFWpXWQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21953-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:44:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF99A5D5131
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BBDA300E2AB
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE523E7BA2;
	Tue, 26 May 2026 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="SAIkV8iJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CY/iQIK1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-c4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38E3EB816;
	Tue, 26 May 2026 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795866; cv=none; b=eyjg+m8UYEcPo6JMRz0NbkNbp63kN6gb+VmajVblZtnLbwafjW6+agLQ3MdaV9joifQB/SUt/TpI0kGexSoLu0Vzqu0BUIHZBpTZuGez/4+lJJZvDcp4HTd7h8oyktXCGSnHiX0VNLQBpTFfrw01zPa6BQGIBqMuvI4woPMO/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795866; c=relaxed/simple;
	bh=1iRe1G8DjxLaImPPjJmAD3R7bqT5pa789eOi5ndJX1s=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=lDerXmp5OA4x+zpXCmRa1zuphKClTdXEg2LMhETm16HzqfvA0jyZK/ZZKrRtNbOkFocVCB4DzpHrdjr4UhmM1CeQQCCXCWF2jvf1gJlLOI5oCnIiOBdJOE7ARndjaNihuGUqfQDaC1MJKSX7rQwaRlaWP1k48vTyYeDlp7/3bzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=SAIkV8iJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CY/iQIK1; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF25E7A0108;
	Tue, 26 May 2026 07:44:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 26 May 2026 07:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1779795856; x=1779882256; bh=tcilqjZAp2FqtP4X290wqUxa3RN0M3eMK0G
	UJ4lRsBE=; b=SAIkV8iJ5PFNn//AWiNv+wVode/60RZVZEH9C9Y3SpJvd3nir12
	u5/5JzCk/FX/aiuLfTr7p32n1tOsToIqAm3KHxOOSn/d3fP8cXGJ04XogpYlXJxk
	3bv16wj1W7e3zp3x6JO9IaorBruWPLuiyrNwJ/E+2kKIj/UvwBULOdDdyJuWw7g0
	BIFixXM3YbSzay9UE8TZTDVOvWb2i9nWMb6t8MJpTv56mbm3AQcIi3YPYffcSqqU
	mzyu+XbhyKsHHFFbldiWiFb1cPRSk5dzQv/4RVAnAWwo/5K6vLoLIoY/SI/xK8sb
	xYxp2xgnxbwmVYs0/0DRm83M4EeyVAZBndQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779795856; x=
	1779882256; bh=tcilqjZAp2FqtP4X290wqUxa3RN0M3eMK0GUJ4lRsBE=; b=C
	Y/iQIK1DF9hLRpJF1CXMakICNqYCNl/+xgNafxVG+vOrLln+JYW/8O1WiR7Fm1PX
	CF7HUIYrLLjffB4ZmoOp++R8NZjgDDQ1pOrP3iAPmtxZUPCd2Inh4Ct7Xl5C2PHh
	YO4LR5J9eZQA8DkWK4u5b+SHqeneiYxMFK9MiXTgN22FTg08Fu0J+qLKJ1AT4zR2
	Tv+v7mBaBrTBs0KqnYzyFc5J3wD02ghEzzBvuCrQMSdHMYIQzAHG3Z6TAeVho+sm
	TSAqbrFwB/XCR3FC1dygIK6u/UXX57nSb1BJESbANH0cul0LkG5M7OTu85pDXDqq
	x//cd+ahqHslQXOOQ7/8w==
X-ME-Sender: <xms:kIcVamTlp057amikPDFaSG5GQfVyffM2ljxj5LP2eO9JZfvU8lWyrg>
    <xme:kIcVaj-UNkiewwBNL1fExav-eqsy6AYDO6MO39AZjOq9Wt-MztjaYuiHuNBtMLPXX
    V9g9gJI3RGIOfDByP6K-pwuh1ukCLsXakQ3uKYgYZfQiJqu>
X-ME-Received: <xmr:kIcVavZ6_J0jlLoUZ3ZPrIrxv1lE4h9dFru_9agyOdN98R4UJoRbEZGLaegW724Ow9vvaq09dx3C-X8W3UuzC0Rx9Dp4qeg>
X-ME-Proxy-Cause: dmFkZTEOOGnILsczrflTug94+56Ue0zmPkVjHIBoZ3PmJ5AYmfs6UNKlU84wdvlTZmhFMQ
    WQ+rorvHuZdEdXGPkKgoIZL+DK9Hapy/DsVCj87yQOwJT9t4TV0GHJWRO/R9ZhMTNw0BJN
    +U+SfigzHp7FbNfjd+D67y6OSv3+4OkTrn1Mt8eSs3geVGv/X1FnGx72v4tTaKs2Zl1/Gy
    QnqM5zYLiba/jTPqGwJkedY7uluEOqdPcWx8yMy0OIRD0/Y0ZLbS4T4KvLkip1SfMzbN/Y
    bN4JXn/WejlXSRF5CsYdGj0D/MZyUFgE0LLdw2WfhBDDtSLa0ZCxE6y/dmy/2vQ/UrrvGa
    NHeFFwlMUArkBbc6KOeV0FXu4zyEm1+VlxBspmA5NdhdestpftgfbDK0jLLJ+FwwjLH4PV
    NmvQnwC8DLbJv7Tmp0GdV5ruxEsDjcgv3IAawtZ+ojGN1MPPE2HttL1urUu8CutB3whoAZ
    rcKQlgLqHc1BuOP9tyCeh60orWWRqBOrxQjGi7Uemj0ciKf6fFHSYyfqrNGfUT9VciaeLK
    VyKayClb4nfBTk8luSIxZfvcepNpb7b5ta9iSjdEnFckx/UdFy3BuqR46STiR6E0u6UF94
    yWpMdtFfV4h23DBcRlgeMNGRP8v4G7w6VBcQ0aeOhvt6nTCJwaTIbv5sY2XA
X-ME-Proxy: <xmx:kIcVasrkOSz8REZMIbGDhmlN_D5yPnhsCvXB8PzOsuF0B_IcxnNE7w>
    <xmx:kIcVarQpuuVEt05DV2gqDswfgJgLjA2atLOvhl-w97JQRrUXxzZ_iQ>
    <xmx:kIcVaopMkJKSyIvEGbz07OVtssa8N8D4XE5r_TCHonKl7klfUjMvkw>
    <xmx:kIcVat2tNxf2C30r1a6EZO7HZHlyFU1oie_-o3DbWTLXW-cpkQHSQA>
    <xmx:kIcVahlR0wh5FpnCIAXAV3gAbMl_RJ9lUhD3i4Zf_kt-q-MDNvKBrKBa>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 07:44:13 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>
Cc: "Mateusz Guzik" <mjguzik@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Benjamin Coddington" <bcodding@redhat.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH] VFS: fix possible failure to unlock in nfsd4_create_file()
In-reply-to: <ahVXG28wpqDwZpFT@lt-jori.localdomain>
References: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
  <36bvv2anew3cegsd374uzwdgue2txpgnzo2357ye5pldqi4by6@lafavyjgevqo>
  <ahVXG28wpqDwZpFT@lt-jori.localdomain>
Date: Tue, 26 May 2026 21:44:11 +1000
Message-id: <177979585120.3379282.15888962273037831904@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,redhat.com,vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21953-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Queue-Id: CF99A5D5131
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026, Jori Koolstra wrote:
> On Tue, May 26, 2026 at 09:13:28AM +0200, Mateusz Guzik wrote:
> > On Mon, May 25, 2026 at 04:23:45PM +1000, NeilBrown wrote:
> > >=20
> > > atomic_create() in fs/namei.c drops the reference to the dentry
> > > when it returns an error.
> > > This behaviour was imported into dentry_create() so that it
> > > will drop the reference if an error is returned from atomic_create(),
> > > though not if vfs_create() returns an error (in the case where
> > > ->atomic_create is not supported).
> > >=20
> > > The caller - nfsd4_create_file() - is made aware of this by checking
> > > path->dentry, which will either be a counted reference to a dentry, or
> > > an error pointer.
> > >=20
> > > However the change to use start_creating()/end_creating() (which landed
> > > shortly before the dentry_create() change landed, though was likely
> > > developed around the same time) means that nfsd4_create_file() *needs* a
> > > valid dentry so that it can unlock the parent.
> > >=20
> > > The net result is that if NFSD exports a filesystem which uses
> > > ->atomic_create, and if a call to ->atomic_create returns an error, then
> > > nfsd4_create_file() will pass an error pointer to end_creating()
> > > and the parent will not be unlocked.
> > >=20
> > > Fix this by changing dentry_create() to make sure path->dentry is always
> > > a valid dentry, never an error-pointer.  The actual error is already
> > > returned a different way.
> > >=20
> > [..]
> > > +		/* atomic_open will dput(dentry) on error */
> > > +		dget(orig_dentry);
> > >  		dentry =3D atomic_open(path, dentry, file, flags, mode);
> > >  		error =3D PTR_ERR_OR_ZERO(dentry);
> > > =20
> > > +		if (IS_ERR(dentry))
> > > +			/* keep the original */
> > > +			dentry =3D orig_dentry;
> > > +		else
> > > +			/* Drop the extra reference */
> > > +			dput(orig_dentry);
> > > +
> >=20
> > atomic_open() is a static func with only 2 callers. perhaps it would be
> > better to change its semantics instead?
> >=20
> > I'm asking because the vfs layer is very slow single-threaded and this
> > here just adds even more slowdown due to avoidable 2 rmw atomics.
> >=20
> > Granted the affected routine is only used by overlayfs and nfs, but even
> > then this should not be necessary.
>=20
> I only notice Neil's patch now. I found this same bug and submitted a
> patch on the same day :) [1]. I think it is awkward that atomic_open()
> dputs the dentry on failure, so that is the approach I chose. But
> perhaps there are good reasons for it, although vfs_create() does not do
> this for instance.
>=20
> There are also some other things going on, including a stale docstring,
> perhaps I should have separated that out.
>=20
> [1]: https://lore.kernel.org/linux-fsdevel/20260525101544.195832-1-jkoolstr=
a@xs4all.nl/T/#u
>=20

I would rather no big changes to atomic_open just now.  I'm about to
post patches to rearrange lookup_open.  I'll include you and would value
your review.

Thanks,
NeilBrown

