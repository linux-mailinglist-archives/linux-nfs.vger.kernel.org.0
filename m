Return-Path: <linux-nfs+bounces-17336-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DACE4955
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 06:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E55AF3009A8B
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 05:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44427188CC9;
	Sun, 28 Dec 2025 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="w83zi0Jj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N11zyoVD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F3146588
	for <linux-nfs@vger.kernel.org>; Sun, 28 Dec 2025 05:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766900048; cv=none; b=P6tHnfSfr4nKP778j888tytaLD/Eqsgl/WoTMwt8I/zPwAxeomStwZ5KJ+nkWQSZf/sFyDNhFpDU0j2MS27294scWbC5zjTalNo1aLzjmJcEwbl0Dnw5dN0hBvKMxhlrazFo/f3ENmLxztp/UYO9CAl663heyHxSv0UyHID1Z6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766900048; c=relaxed/simple;
	bh=U/RPkgTPRkle0TZSpoJ2EncfQVITJSFj/uZbKy7wU4k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=d0Pe1ZCtc8zv/N/I6kOo3CFejFkttR6Np3sopGtezbC7YJD/zt1v/+z+hzmBEdV2shtXwIhuRtXAYbZCelIjVFu9DnGHvYVkOH5SH5kxhjAYMlcF9xrgni5WYnhB2sykZvG579LKz2TsqkKeGI+fL2nxNgjwZv5FTGT+3/7xD8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=w83zi0Jj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N11zyoVD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70E6D1400223;
	Sun, 28 Dec 2025 00:34:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 28 Dec 2025 00:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1766900044; x=1766986444; bh=V07nBwuAS/3AmiaYXxH0LTwWP4lr17XxA+l
	grbrNFDk=; b=w83zi0JjTtIJRgCkASHq0isUkAxSMoUj9OIvUP6OBkxahdyg1K9
	zGuKF8uYwAAjY6+oaFUKFrMCkf41z0ErNnVWN9gUh6qp03YvF9bi+1X0rbEZZab+
	iiy14PjOjMoGe6U9tzd1Xy218RvFPjRx08Z5S7o7dppYRDMr0e/oCsYP3JsPSp+c
	3VSsaq2i+gx94aFKr1ZyCN2Vd+fCPnO8oKTQcyWJl121xDhupQdyIMzI9Ba9RnAY
	xlhkbgcW6NC8KxT9z8VaI21vkYLs7o0dmD8MjzInoYo5IX5peJIF2NBgUhQs77fd
	Bpp9O4tTpO5/5ZSl29r6cN2X8J7Pupg4+qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766900044; x=
	1766986444; bh=V07nBwuAS/3AmiaYXxH0LTwWP4lr17XxA+lgrbrNFDk=; b=N
	11zyoVD0dhXkGx2K3H8w7ioXqM7XIeP4bbcXcD6xRjLWOs4aHOr7vXDIz4hORmWb
	V+fiGxVF38qR6MptIycR3W6ttnhEH0sQkhOQxLqNIePasR4lafJNCfhhptXmVxeL
	fliOomvze5sr/WEO+7c7bQq4DYHLwGlxQidRaOqdGoc9kOtlFxMelZaq60kKy8DD
	CMJYyFK7FER0wAGHQGIi2rQAWVKJ9qfPS0C7im8iRUel4c+/7Vzr9pR4LV3YF0qD
	wYAw6GTeB28kf1ncIKCctA47ISWIxoaUgcMx4QhGLjumn8viAZznWlMTVH4v1FDA
	XWW3YsFXzCtBlbZhl/TGg==
X-ME-Sender: <xms:TMFQac9TDMSCkqTxG5tWogBketeM2PuEGZ9ufiCG_IMc5tD4ln1idg>
    <xme:TMFQaYbq0EizPTBtft-jWQA9NuhaH672VoX9ydAaVcrK8W1Gbz8yR8vI-M52qmVce
    EWgPqA-013aNIKgsnmtfSnVl5X2xe-XDhSLFGt0I2d6h78>
X-ME-Received: <xmr:TMFQab2Z82N4qnQtNtGPbiySCeV06wZ1eV2e6MaqkSigH9QBaH16NaNGq2WCwvpXSI5Vb-wHtiO6lqiLa1ZUa7-hlffDDQze6hcJeB6nQjvt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejfeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthht
    ohepthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomh
X-ME-Proxy: <xmx:TMFQaTazAe_hkIob6TEpjfhgxjVohjvUfzaaqh8sWkd1y2tchmzvWg>
    <xmx:TMFQaTKh-bpRvyoOGcndDtv1_AgxNlfpALkZUrCr4_a3Ak8EFAZNOw>
    <xmx:TMFQaSGtZGg6fH5fl9tHyqc17eUglVQOXFbpqUrhFfqZwZk6eBi_oA>
    <xmx:TMFQaavT3Sz4BlBtG6-RU-WCPfqhAwY3MsxWQoq5S9ggW9--GMMCug>
    <xmx:TMFQaUvzin83Lu66i-WQHMrc3ADCcF86q8i1g4ocaUaKFw5LUslLgGFj>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 00:34:02 -0500 (EST)
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 1/7] nfsd: Convert export flags to use BIT() macro
In-reply-to: =?utf-8?q?=3C55ef75dd1010f20a449117405b281c0e9318fd43=2E1766848?=
 =?utf-8?q?778=2Egit=2Ebcodding=40hammerspace=2Ecom=3E?=
References: <cover.1766848778.git.bcodding@hammerspace.com>, =?utf-8?q?=3C55?=
 =?utf-8?q?ef75dd1010f20a449117405b281c0e9318fd43=2E1766848778=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E?=
Date: Sun, 28 Dec 2025 16:33:54 +1100
Message-id: <176690003439.16766.6214649554459236248@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 28 Dec 2025, Benjamin Coddington wrote:
> Simplify these defines for consistency, readability, and clarity.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  fs/nfsd/nfsctl.c                 |  2 +-
>  include/uapi/linux/nfsd/export.h | 36 ++++++++++++++++----------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 5ce9a49e76ba..ad1f3af8d682 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -166,7 +166,7 @@ static const struct file_operations exports_nfsd_operat=
ions =3D {
> =20
>  static int export_features_show(struct seq_file *m, void *v)
>  {
> -	seq_printf(m, "0x%x 0x%x\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
> +	seq_printf(m, "0x%x 0x%lx\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
>  	return 0;
>  }
> =20
> diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/exp=
ort.h
> index a73ca3703abb..aac57180c5c4 100644
> --- a/include/uapi/linux/nfsd/export.h
> +++ b/include/uapi/linux/nfsd/export.h
> @@ -26,22 +26,22 @@
>   * Please update the expflags[] array in fs/nfsd/export.c when adding
>   * a new flag.
>   */
> -#define NFSEXP_READONLY		0x0001
> -#define NFSEXP_INSECURE_PORT	0x0002
> -#define NFSEXP_ROOTSQUASH	0x0004
> -#define NFSEXP_ALLSQUASH	0x0008
> -#define NFSEXP_ASYNC		0x0010
> -#define NFSEXP_GATHERED_WRITES	0x0020
> -#define NFSEXP_NOREADDIRPLUS    0x0040
> -#define NFSEXP_SECURITY_LABEL	0x0080
> -/* 0x100 currently unused */
> -#define NFSEXP_NOHIDE		0x0200
> -#define NFSEXP_NOSUBTREECHECK	0x0400
> -#define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just=
 trust */
> -#define NFSEXP_MSNFS		0x1000	/* do silly things that MS clients expect; no=
 longer supported */
> -#define NFSEXP_FSID		0x2000
> -#define	NFSEXP_CROSSMOUNT	0x4000
> -#define	NFSEXP_NOACL		0x8000	/* reserved for possible ACL related use */
> +#define NFSEXP_READONLY			BIT(0)
> +#define NFSEXP_INSECURE_PORT	BIT(1)
> +#define NFSEXP_ROOTSQUASH		BIT(2)
> +#define NFSEXP_ALLSQUASH		BIT(3)
> +#define NFSEXP_ASYNC			BIT(4)
> +#define NFSEXP_GATHERED_WRITES	BIT(5)
> +#define NFSEXP_NOREADDIRPLUS    BIT(6)
> +#define NFSEXP_SECURITY_LABEL	BIT(7)
> +/* BIT(8) currently unused */
> +#define NFSEXP_NOHIDE			BIT(9)
> +#define NFSEXP_NOSUBTREECHECK	BIT(10)
> +#define NFSEXP_NOAUTHNLM		BIT(11)	/* Don't authenticate NLM requests - jus=
t trust */
> +#define NFSEXP_MSNFS			BIT(12)	/* do silly things that MS clients expect; =
no longer supported */
> +#define NFSEXP_FSID				BIT(13)
> +#define NFSEXP_CROSSMOUNT		BIT(14)
> +#define NFSEXP_NOACL			BIT(15)	/* reserved for possible ACL related use */
>  /*
>   * The NFSEXP_V4ROOT flag causes the kernel to give access only to NFSv4
>   * clients, and only to the single directory that is the root of the
> @@ -51,8 +51,8 @@
>   * pseudofilesystem, which provides access only to paths leading to each
>   * exported filesystem.
>   */
> -#define	NFSEXP_V4ROOT		0x10000
> -#define NFSEXP_PNFS		0x20000
> +#define NFSEXP_V4ROOT			BIT(16)
> +#define NFSEXP_PNFS				BIT(17)
> =20
>  /* All flags that we claim to support.  (Note we don't support NOACL.) */
>  #define NFSEXP_ALLFLAGS		0x3FEFF

Could we make this:

  #define NFSEXP_ALLFLAGS ((BIT(18)-1) - NFSEXP_NOACL)

Or something like that?

Thanks,
NeilBrown

