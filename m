Return-Path: <linux-nfs+bounces-18080-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2686D3914A
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 22:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7088B300C6C5
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 21:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78EC296BA5;
	Sat, 17 Jan 2026 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="aR3IQsMA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TUondJ7d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDCE28030E
	for <linux-nfs@vger.kernel.org>; Sat, 17 Jan 2026 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768687190; cv=none; b=ORQjxQTw683peqoYOzo1v8deMf0hdFiI1rp9lHqBZDXkyPXPVakG20ICQQv7HvFyoIH8TwyvzKkj+6M/4kUBq+Wmqo5aTKUijHWnG+cb7/jHml6xMRTJmMOEsGFmch1iPjTtmNF1HdtIk7WF1G3F49th5HMq3P/DV7kjgwsEFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768687190; c=relaxed/simple;
	bh=HBnNhi2KiBAOJ5kPD55bSEr5eH5YoI2yR/YnOGpuJNQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YemAyJUYzf9KssCpvAUyJD6mQcn2j1awUnaykyo9+seuA9BcOn69PZmaUmPsFFb7NElertUI5XINt60YXTsi83x1UPomlMh+0fDX1C5W2tqxgHsqLzE6oO5sJh0IOT37IUM2rrUd8pJfgBGsLzIhIjn4F5WRRdw2Xj/XvZJQqS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=aR3IQsMA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TUondJ7d; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B00214002F0;
	Sat, 17 Jan 2026 16:59:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 17 Jan 2026 16:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768687188; x=1768773588; bh=SyeAWj0ZCWRoHudfzQW9T+UPD4UdfiYyVg7
	2+vbJr7o=; b=aR3IQsMA06NOjAjkCNvI0vWamJ6cs+owu+739AM3ef8zCJ1Mo++
	+VTiHxtqPLqwrBeKmjbtYSsmn/TUaCiXOQiMT0Bb7Wl48UwmiOsZapUrtfV9fU1W
	oBkOBuimJh8uGuu7X2H7D4X5Yokxa+HJPZoE2CB2TVV9Z7NrfBAC/JN9ZCo7Edh4
	YHLf8uxwgiaAjyemdv2VdWvNPvKS4WlGt4lwXaS5yQCPoMmQisU66OMEecCs2yoR
	40zl7MvRbLPD6spMGYjRuByDs967cArvwj8NM/3+JvnCKvHXCItU7q331H94rhOM
	wAwFzGLji8mcbStpqRuo2HnWiAcyV9hvY0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768687188; x=
	1768773588; bh=SyeAWj0ZCWRoHudfzQW9T+UPD4UdfiYyVg72+vbJr7o=; b=T
	UondJ7dnI6y+b4pHO/eQqoSl/uUyFs1kNivAxZBH7AhRWmnpS9ACEef6ZBfT5oRP
	XRLXU+hkHnP5TYoVvnW2BUqkmfR0MDnU+cvoHt+ZgL1khiF3X42AUJ6X5EcEtfeS
	SYrU2RUMg+4uZ/su5xqzBvd0sbRwpu7UKk9qrc3QW02ZGVj3biqIJHVxHp17gw9g
	y8pmEnjUhFfeN7fLq7AzJpHmko4JDSxYAw7zmuubIO0IZXBjMSwdozEUsuOhNBlN
	029nZnBDFQiSc9vpkbDdHzA1hEkZKSfsMOT6D7BwLxfkxvdnmFP5NMLDWIqm3MEE
	ptfMjZ4IPEmlSs3Q+S9iA==
X-ME-Sender: <xms:VAZsaVSLPTduUoSFHnGt47KqTaLkCZSFh5pKTh0a3M0Hwu-zOy6VGQ>
    <xme:VAZsaVqx_jSBxw8Ikh_XS2EqCIEf1SUKnvfnw4WDzNKpyoAkgmqAsa-yrFC04DET8
    ekHsvKRkCpsBa8fSuaBqByuf4uYaqq_oq_MO-HLP5-3r5At6Q>
X-ME-Received: <xmr:VAZsaTLy0pEog8GFpuWXErFOK5vnPVAX_c6d60W2nZKQUnZhj0QDvT2YW_BFL-zSioXnV8q-S3LXNmgR0SHB8w4lDoKFR6u4AO7m_CMIyciM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedvleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsthgvvhgvugesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghh
    uhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggtohguughinhhgsehhrghmmhgvrhhs
    phgrtggvrdgtohhm
X-ME-Proxy: <xmx:VAZsaYo1I8SpuKvOb3QuQxq5GOpslqrNqD-h7mAoFJGLBCMVrGHBzA>
    <xmx:VAZsabyEZWEo8hCySe6yifMVvyJCclB6Gjb2Ou_et-OmUaU9Fi3T8w>
    <xmx:VAZsacPFxhYcoEubyzexix5BVYMigp9s-Trd9BT8aZCtUEp8jLSFvw>
    <xmx:VAZsaQ6uTAiNm5AhMWgqwOvkvIQRWMre9HIVo7XdKIWlG7eXp548mw>
    <xmx:VAZsadrEFVhI_YdiKlCxL0VK_NFB4lKefV23MGx0QHXGpkngEa-4rrq3>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 16:59:46 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Steve Dickson" <steved@redhat.com>,
 "Benjamin Coddington" <bcodding@hammerspace.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v1 2/2] exportfs: Add support for export option sign_fh
In-reply-to: =?utf-8?q?=3C2cff941029aa02d5524ea5afeaff5c65af52adf4=2E1768586?=
 =?utf-8?q?942=2Egit=2Ebcodding=40hammerspace=2Ecom=3E?=
References: <cover.1768586942.git.bcodding@hammerspace.com>, =?utf-8?q?=3C2c?=
 =?utf-8?q?ff941029aa02d5524ea5afeaff5c65af52adf4=2E1768586942=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E?=
Date: Sun, 18 Jan 2026 08:59:44 +1100
Message-id: <176868718481.16766.16291541745508019690@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 17 Jan 2026, Benjamin Coddington wrote:
> If configured with "sign_fh", exports will be flagged to signal that
> filehandles should be signed with a Message Authentication Code (MAC).
>=20
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  support/include/nfs/export.h | 2 +-
>  support/nfs/exports.c        | 4 ++++
>  utils/exportfs/exportfs.c    | 2 ++
>  utils/exportfs/exports.man   | 9 +++++++++
>  4 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
> index be5867cffc3c..ef3f3e7ea684 100644
> --- a/support/include/nfs/export.h
> +++ b/support/include/nfs/export.h
> @@ -19,7 +19,7 @@
>  #define NFSEXP_GATHERED_WRITES	0x0020
>  #define NFSEXP_NOREADDIRPLUS	0x0040
>  #define NFSEXP_SECURITY_LABEL	0x0080
> -/* 0x100 unused */
> +#define NFSEXP_SIGN_FH		0x0100
>  #define NFSEXP_NOHIDE		0x0200
>  #define NFSEXP_NOSUBTREECHECK	0x0400
>  #define NFSEXP_NOAUTHNLM	0x0800
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index 21ec6486ba3d..6b4ca87ee957 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -310,6 +310,8 @@ putexportent(struct exportent *ep)
>  		fprintf(fp, "nordirplus,");
>  	if (ep->e_flags & NFSEXP_SECURITY_LABEL)
>  		fprintf(fp, "security_label,");
> +	if (ep->e_flags & NFSEXP_SIGN_FH)
> +		fprintf(fp, "sign_fh,");
>  	fprintf(fp, "%spnfs,", (ep->e_flags & NFSEXP_PNFS)? "" : "no_");
>  	if (ep->e_flags & NFSEXP_FSID) {
>  		fprintf(fp, "fsid=3D%d,", ep->e_fsid);
> @@ -676,6 +678,8 @@ parseopts(char *cp, struct exportent *ep, int *had_subt=
ree_opt_ptr)
>  			setflags(NFSEXP_NOREADDIRPLUS, active, ep);
>  		else if (!strcmp(opt, "security_label"))
>  			setflags(NFSEXP_SECURITY_LABEL, active, ep);
> +		else if (!strcmp(opt, "sign_fh"))
> +			setflags(NFSEXP_SIGN_FH, active, ep);
>  		else if (!strcmp(opt, "nohide"))
>  			setflags(NFSEXP_NOHIDE, active, ep);
>  		else if (!strcmp(opt, "hide"))
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 748c38e3e966..54ce62c5ce9a 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -718,6 +718,8 @@ dump(int verbose, int export_format)
>  				c =3D dumpopt(c, "nordirplus");
>  			if (ep->e_flags & NFSEXP_SECURITY_LABEL)
>  				c =3D dumpopt(c, "security_label");
> +			if (ep->e_flags & NFSEXP_SIGN_FH)
> +				c =3D dumpopt(c, "sign_fh");
>  			if (ep->e_flags & NFSEXP_NOACL)
>  				c =3D dumpopt(c, "no_acl");
>  			if (ep->e_flags & NFSEXP_PNFS)
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index 39dc30fb8290..8549232dea74 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -351,6 +351,15 @@ file.  If you put neither option,
>  .B exportfs
>  will warn you that the change has occurred.
> =20
> +.TP
> +.IR sign_fh
> +This option enforces signing filehandles on the export.  If the
> +server has been configured with a secret key for such purpose, filehandles
> +will include a hash to verify the filehandle was created by the server in
> +order to guard against filehandle reverse-engineering attacks.  Note that
> +for NFSv2 and NFSv3, some exported filesystems may exceed the maximum
> +filehandle size when the signing hash is added.

I don't think "reverse-engineering" tells the admin anything useful.

"... to guard against filehandle guessing attacks which can bypass
 path-name based access restrictions"

NeilBrown


> +
>  .TP
>  .IR insecure_locks
>  .TP
> --=20
> 2.50.1
>=20
>=20


