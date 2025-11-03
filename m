Return-Path: <linux-nfs+bounces-15984-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D83EEC2E5F1
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 00:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA70B3A9A7A
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859FA2FABFF;
	Mon,  3 Nov 2025 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="A3ewLr9B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OKLDLfdB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8FC2FD1D9
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211109; cv=none; b=aQi5uM78Py/NDGOZdEB8j1KuIp8n7MJ0tQ2ljqgtEsuhnmtFdXgqIN3eGr0Gn0XyppXLovQ0B1AAPrYfJ4FnPPk3+4GlcZZOVvn2JVZM138qpIZFooZlSnHRJ3Vm4ndZXfxBEIqi4WlNPHXDAJtR8mDCY7iLPBH3aTOSXIDpnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211109; c=relaxed/simple;
	bh=nAeO5rQVeh5mjnq93nb6/kFJhN/iRUM0cEmvPmRN/fs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hloYoG8cugDANdoLdjH5NrwbJWr+IJD+Qejv6IRFPgD67IBQtoaQrcnjnTUUPARiGJ3Wr+zxJOoHIsULd09IXT7T/wofeqihPsf3bHvx0gnheRVPDKnI26EOPRhFmSgKy4uXTQuOYF3l7onOVkyaT89/9Oh4sgY54RkmFM7mLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=A3ewLr9B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OKLDLfdB; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CBCA1EC02A0;
	Mon,  3 Nov 2025 18:05:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 18:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762211106; x=1762297506; bh=E++u0UqutM5/H5r41FT1vUmbBtTJiIoQ20S
	ebEYyrAk=; b=A3ewLr9BKfnXAHWC2hsSNBiCZGUJJu3ZzS0vuz/Stnmqo+ucItE
	IImHntJaxNvB/30g8z1eWlUSkqDLsI7Wam1m61zC6kSh1o8mNfyLQl40uv1C5BD8
	OBukimxHI/yvlr+TNBLipnC1gKpWqzmZaPxAMnxhIqaMG5PuxhbRQmr+NPYiXlXg
	N2VuSuGo3WsndTgBq94NiUPWo3ofacIr1/2RW3hC9eea4xJkcXmUMUNI5cs/9sjk
	hUwP1VJcwihz19ISY3r8fn4a05VIHUSGrgbv4JhzeerZ8n3reuMxdx8hg1l7gmem
	rBib2tEc/e35hAYeAt2Kx53vCwbpXz8yFXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762211106; x=
	1762297506; bh=E++u0UqutM5/H5r41FT1vUmbBtTJiIoQ20SebEYyrAk=; b=O
	KLDLfdBjsNtRfBcIcHaRk3tF4K5N63IM87BMQePoLmNKv9iiay2wIuUtpWP8J7zI
	9kefVxx2/ZwV57rjjS+3csSKDUPATxU2Mb1l34hPAAeNHDLutdh+9oIVS/sklqXR
	lVRPl1w0nQIQ39w4TyV/d92yNV6Xoj2xDV63iCTbcUIQo0OxyK9z+AjY9ObYXFqB
	pkeEcnlC3K26NzNWDZBQrT7TIpiduG5+MmLE24ukYvE1UDjXeYvMF+/+mqhlLvDT
	SnUd+hJX+SHZWna6UhKndMWb9+Mfh9eYjkhUbuoicV9/Sx8ekiTCicMML6pPKIc9
	IY6aCGBdQ3w9qLaIYjI/A==
X-ME-Sender: <xms:IjUJaTP_58sORK21gz1kGuEJ1UG-oxZzgRcoDE6LvRX1PUbdad4Png>
    <xme:IjUJaQN_4bxSMKWrpYU-AQ0fAIwxa8hEO_6-T4il_557aw0-XvYZTVylnI6sGUa2K
    ukiplY9Udeyl_36U0RLppNCLkcnyR6AfdjbsMMs-u3TpS-OfQ>
X-ME-Received: <xmr:IjUJaUiiJ6AdPIedlSFGItf301BgFlFZD152_gXqx-6zTKg6DW641mc65PTeLZV9D25jdUh7Sqle7FMcwJ_jWTcdKpahb9PMKoKZM67nDVwD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelgedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:IjUJads2vGXNAjtlDrTQAm9P-Mugirjzbb95X53WpnpiG7Y2I93TDQ>
    <xmx:IjUJaaTxBC662gUcuDnMuWGJz3QCGuVD-SFf_XXoyOuOuwSQ0BuFaA>
    <xmx:IjUJaZ2asVYntbC1vnN-8ZHpv4Rg5h1qcIlmVshaKTEvkc-80MQ4YQ>
    <xmx:IjUJaXs-Hp2R2_rLvfMi1Z1AJUsfiaBy8lifm1i61GPwK8MygStrXQ>
    <xmx:IjUJaX6mv1e2yydtnx_HbOtml7xfWmqfWbjrsKvWnG3RiOBetPJ3XStf>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 18:05:04 -0500 (EST)
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
Subject: Re: [PATCH v9 11/12] NFSD: Refactor nfsd_vfs_write
In-reply-to: <20251103165351.10261-12-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>,
 <20251103165351.10261-12-cel@kernel.org>
Date: Tue, 04 Nov 2025 10:05:02 +1100
Message-id: <176221110270.1793333.15795145155432472242@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 04 Nov 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> There is now only one caller of nfsd_buffered_write(), so it can
> be folded back into nfsd_vfs_write().
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


> ---
>  fs/nfsd/vfs.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 0e5e82b286f1..8518fb619f56 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1357,23 +1357,6 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsi=
gned int nvecs,
>  	args->nsegs =3D 1;
>  }
> =20
> -static int
> -nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
> -		    unsigned int nvecs, unsigned long *cnt,
> -		    struct kiocb *kiocb)
> -{
> -	struct iov_iter iter;
> -	int host_err;
> -
> -	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> -	host_err =3D vfs_iocb_iter_write(file, kiocb, &iter);
> -	if (host_err < 0)
> -		return host_err;
> -	*cnt =3D host_err;
> -
> -	return 0;
> -}
> -
>  static int
>  nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		     struct kiocb *kiocb, unsigned int nvecs,
> @@ -1457,6 +1440,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
>  	u32			stable =3D *stable_how;
>  	struct kiocb		kiocb;
>  	struct svc_export	*exp;
> +	struct iov_iter		iter;
>  	errseq_t		since;
>  	__be32			nfserr;
>  	int			host_err;
> @@ -1517,10 +1501,13 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>  	case NFSD_IO_DONTCACHE:
>  		if (file->f_op->fop_flags & FOP_DONTCACHE)
>  			kiocb.ki_flags |=3D IOCB_DONTCACHE;
> -		fallthrough; /* must call nfsd_buffered_write */
> +		fallthrough;
>  	case NFSD_IO_BUFFERED:
> -		host_err =3D nfsd_buffered_write(rqstp, file,
> -					       nvecs, cnt, &kiocb);
> +		iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> +		host_err =3D vfs_iocb_iter_write(file, &kiocb, &iter);
> +		if (host_err < 0)
> +			break;
> +		*cnt =3D host_err;
>  		break;
>  	}
>  	if (host_err < 0) {
> --=20
> 2.51.0
>=20
>=20


