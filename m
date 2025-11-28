Return-Path: <linux-nfs+bounces-16770-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE2DC9073B
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 01:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B695C34DA88
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 00:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9FD3AC39;
	Fri, 28 Nov 2025 00:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OhvUDKkY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gx4O72dQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE720B22
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290804; cv=none; b=g+uzxi0/O998yNOwe1aI63BV6msxwIcANyowGvJkGvjP9Sg08H7pANCNbv13IYHOOCNV+flxoAwrI0ZMgq1KAvPN7j1sXM8p+1Rz2tAkI0QwIgTRAGQH+dVCDmNhtJfjCpyCSd8J/Jx6uNkQwU+b64+PLtX+UqhngVudOU0K6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290804; c=relaxed/simple;
	bh=4QH29UFncTwXlMq2I3GxjxwPPnN7bHx5E5ZmxVnM3q0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gZHykWWxCIcu2ljDmh6FQ36AKw7Rfzj43SVckV8eXKxgKp13kFp2u6PaY2xMgfmRtWIpxSYUWyjt5saQqhMXFF6ujpXiZ17CAbhhK6CY1QOomxkDSiD66sDoOGgiZUHSZ0xTl/gT0evVfeBkdtfZSBnq81gIlNoXJ5haDD4aIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OhvUDKkY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gx4O72dQ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 6ED2C1D005ED;
	Thu, 27 Nov 2025 19:46:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 27 Nov 2025 19:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1764290801; x=1764377201; bh=oHcjRlutoS9uoNJO5W4cpvA0kS1xf0LS50x
	g1ZVP99I=; b=OhvUDKkY5cZCgPXf4KHZu6CenLj7I6vmG72yrQI7hBArHflwTKl
	Wt0F08ckwLTvNl/NEqnK6Z84eSAtxPPapVyENt6gDwzLpJwCi8SkW9SEurKW7Mu8
	VUSFw5B/Z1rY52favvFpgJVS61dqw8xIyALSsjDth9s1ORsaC2ODTThDqqDDxZzA
	eWI5aAdLURgnFY1G1Wgu9qvkiiKZmVDWSzbMy/+lBcp8mRDKm/z9s/YzYf9cPyK/
	a7HXmWOAdtrMKjX0Xv/SopSrXgGtsj9n4uGg/9Q2KSsshjqJIuiZi6FTbSOZNavv
	gZVpea+/mAYTJDG9+NqiPlBQR4nlYCT49ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764290801; x=
	1764377201; bh=oHcjRlutoS9uoNJO5W4cpvA0kS1xf0LS50xg1ZVP99I=; b=G
	x4O72dQ6iTKQeDpiaPsU2ET2O5E3kI0KqCvX5pFAoA1Dgjhp+TNXGhBb4/74mVQC
	N/pTnc3RBwqAGEF2QeuPaUS6JVO/oSyHtDsjAn5UaU0UynFbHOzvxblJrt9en1i5
	qmQzqDl5+uQhSERbdUJgCeduBRznD7GRrYXfT6/qjnD06+q6lFFk67Ce4MfBysaB
	MU9cHa7msbvxYSjDJAuUqV5w+J4lkoNQUSFJNUZ+P8uz29BG8AIcot7z/43GJM2o
	AtczdVaq3TXPNMTJMH/yM2EUo4vCAfYyEJGbPdFJqN00Wlf6U+7lTtKqLFAVKmMw
	Huvq23zkgSlFL/d2FN6Wg==
X-ME-Sender: <xms:8PAoafi-30W2DDwoJEvDIpCB5RyMS0com-0EwBHlpBrD6Pe7ry_LzA>
    <xme:8PAoaTDgpUXCFTvdUhKfHPg8mVRZxUyzwsecSeGpsoOLSLl6AvVTpSfmAzKo_pxPL
    QpJPShziuaXgqlkwtow3_zIMKGWuY5cjBw3Xk1lCLRg3z9kHQ>
X-ME-Received: <xmr:8PAoaUGiNWknEBpzmZQFJ0HldSdllMqw6jyE0K3c63DXVQEeEfTQBTVAu55daKYLQfZXamTZAlIWABeJMKEPT5N2X_en6wZTxe549rvrAyR->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeekheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrihhlihhophesshhushgvrdgtohhmpdhrtghpthhtoheptghhuhgt
    khdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8fAoabKJqMY_5_qwjzM2ZPYMOCqx20ioe96C8wptcWpHWGJnwJ7frQ>
    <xmx:8fAoaYnC0fqcxrldKoD2naaN2wsPE0X_Il-QJSokhT2s35qEJM03SQ>
    <xmx:8fAoaTQ4-bKj0vLSY-nE6edIBDtOowrHcoLUyjYrvNsYjELk4CFO3w>
    <xmx:8fAoaaK5dowwWHTORrHaRfcvJA2QppMS8oSEscVwOpsCFHqPEwIH1A>
    <xmx:8fAoaVmTrD7aplXiBJFx8pQitxUQfQom6FzqkHIHQIZCNSKYVT_4PLCg>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 19:46:39 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Anthony Iliopoulos" <ailiop@suse.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 2/2] nfsd: fix return error code for nfsd_map_name_to_[ug]id
In-reply-to: <20251127175753.134132-3-ailiop@suse.com>
References: <20251127175753.134132-1-ailiop@suse.com>,
 <20251127175753.134132-3-ailiop@suse.com>
Date: Fri, 28 Nov 2025 11:46:31 +1100
Message-id: <176429079160.634289.2367318269182809643@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 28 Nov 2025, Anthony Iliopoulos wrote:
> idmap lookups can time out while the cache is waiting for a userspace
> upcall reply. In that case cache_check() returns -ETIMEDOUT to callers.
>=20
> The nfsd_map_name_to_[ug]id functions currently proceed with attempting
> to map the id to a kuid despite a potentially temporary failure to
> perform the idmap lookup. This results in the code returning the error
> NFSERR_BADOWNER which can cause client operations to return to userspace
> with failure.
>=20
> Fix this by returning the failure status before attempting kuid mapping.
>=20
> This will return NFSERR_JUKEBOX on idmap lookup timeout so that clients
> can retry the operation instead of aborting it.
>=20
> Fixes: 65e10f6d0ab0 ("nfsd: Convert idmap to use kuids and kgids")
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  fs/nfsd/nfs4idmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
> index 8cca1329f348..123ac45b512e 100644
> --- a/fs/nfsd/nfs4idmap.c
> +++ b/fs/nfsd/nfs4idmap.c
> @@ -654,6 +654,8 @@ nfsd_map_name_to_uid(struct svc_rqst *rqstp, const char=
 *name, size_t namelen,
>  		return nfserr_inval;
> =20
>  	status =3D do_name_to_id(rqstp, IDMAP_TYPE_USER, name, namelen, &id);
> +	if (status)
> +		return status;
>  	*uid =3D make_kuid(nfsd_user_namespace(rqstp), id);

Ignoring the state and using the id anyway is clearly wrong.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


>  	if (!uid_valid(*uid))
>  		status =3D nfserr_badowner;
> @@ -671,6 +673,8 @@ nfsd_map_name_to_gid(struct svc_rqst *rqstp, const char=
 *name, size_t namelen,
>  		return nfserr_inval;
> =20
>  	status =3D do_name_to_id(rqstp, IDMAP_TYPE_GROUP, name, namelen, &id);
> +	if (status)
> +		return status;
>  	*gid =3D make_kgid(nfsd_user_namespace(rqstp), id);
>  	if (!gid_valid(*gid))
>  		status =3D nfserr_badowner;
> --=20
> 2.52.0
>=20
>=20
>=20


