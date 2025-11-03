Return-Path: <linux-nfs+bounces-15980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC730C2E506
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 23:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71B63B8AFF
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 22:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1631A9F82;
	Mon,  3 Nov 2025 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PpMCP2DE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jlh/ats1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F82BE631
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210138; cv=none; b=UI+96HRxNlxEnIGL8Jqlx+Em9E+j/qMAAAWne6qWiJu9/wKwuOcOR4wCQQUflmREcBJmcY9X0Yq91N+SfWL4wi5gRgGpa3RaRBkvNmQcC3Vzj03K+8c/HFY6NW4SDmX1GPboMAa44m/G3E/IxnH/BXIhRmOnJ+CilMdLwSWPAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210138; c=relaxed/simple;
	bh=tcMYpwhRQHlnJnwkIj2+biEcuMN5ucu1DnwkuzLo+WE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pbJEqowpop2Eje8WGUlHDz1hMUJkmi67dWMJMm/L0zrG8bc21CACPEst7jyPjHkx8pyjtQzzdq9nyZoopxEKo/nZ8vyggJ8OWYOPAcqEg8nnMg6ikxzYtaCKNImHm8JQWeIGl9n39EHls9wwdavrxDEy4QWPSaaIr3TH0Oq5hZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PpMCP2DE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jlh/ats1; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 878E4140022F;
	Mon,  3 Nov 2025 17:48:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 03 Nov 2025 17:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762210135; x=1762296535; bh=WMzeB7S6kvsoRX0FAMB8lZifLZ0ks3SHKeG
	HR1c1dms=; b=PpMCP2DER73u4CQFwkkLag9jUAGmZ7mm+jwPmRi53No8C8rJV+L
	sdakovpGfpo8wzy5V5wElk9Xo7LpUOi/gps4UxhXkml23ok0mC2NXCYde2Baue3z
	BCHYmBQNduJiEtLuCtw04f/f+UX0qTBOqlaOK/pObEjrRRkEsnId1G2pbTx+6zTz
	ZhikBT3lLT4rJhpgq1d5O2F6ll+n+ff7TkZRtmfHfuqdhvQl6Vr4GvymenxXD1I+
	x9pWVk5CQbIdSJUa6WmEVSUafUhqckKVQ+NmX5wMeD+Qlug08J8ak/ixLaOlFn4O
	E/4L/lnWkDkg93XGKPDCyaVm80VnmiHDvpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762210135; x=
	1762296535; bh=WMzeB7S6kvsoRX0FAMB8lZifLZ0ks3SHKeGHR1c1dms=; b=j
	lh/ats19a+Iv9yD/zLLpPi6Of0hhuFLmbCrTB+nqB3P7zvD+aImakjfzL1sJU9Pd
	sYjCkUyh5h7S/w1L2wIzqtaxjDrgAMGhiGYGBJreZPuNssJsAIKhYSi6nuHOLdim
	s23xLKMfQ1HUd/7h+PdsCDNdT+ok7XFSGneH4/Nxucmhhte8GEvAtsE6S1oBkglq
	62YOFIiW+9VLN/QKTghkDM9K3vKwJqDTIaIFobbJ9j9qCgtAtyH6/GvEze5W9NvO
	tJnCsDPuekYqOJgpk+Ui+ZEpn316EgC+jn5R6uM6PD3+ZNDmMw7BC8YFiNpfMluA
	YRH3gPy40Tq8DFTs0JFbg==
X-ME-Sender: <xms:VzEJaYeRYluOGcS49nTjoml4v9ZzNKKEKPWgVCTQjf4iA34DNYyl8Q>
    <xme:VzEJacdE-bAWyub37PolXhdKUYCHAyjhhw1pIO0WrpV_LpxYEqlcW-lW7BscAlJxr
    M7yfm-Ogu-u8mjB_sOdzAMlvE6g9iIq3zp2o9mPl3M3JKP8uw>
X-ME-Received: <xmr:VzEJabzupDKJCIwzBoxvoC9CAOha4DepDrzfBh9AZpnhACI9ntyulC1gR2WDCjO_6qrusR_0nHfadxrnpOq8ebxI5O2M_3l_pBgCNMfaWbcT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelfeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:VzEJaT_8tWr73GnpQF4tMFEcybuebTRLKjKq6v1bsfzD_qskU0CpWA>
    <xmx:VzEJaTjV5WPA4UsQUPWymvFIjPcyPN0nwHoNhIqFtxIwt_u7Ms9UUQ>
    <xmx:VzEJaaF4WXgL7Lz-2cGWJ7Ub0PVLIXLYeHbR6EIXd7kSMfW5EUwoBA>
    <xmx:VzEJaS9ev-bgYOAPG0yp8pntNuHm-wg9pe2je4lFw1JnHa4aVsU3_Q>
    <xmx:VzEJaULJ2gSmazw_DvyJsWm5wz6daSv70HyNS-yciW-zA0HYrlnLMoBM>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 17:48:53 -0500 (EST)
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
Subject: Re: [PATCH v9 08/12] NFSD: Simplify nfsd_iov_iter_aligned_bvec()
In-reply-to: <20251103165351.10261-9-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>,
 <20251103165351.10261-9-cel@kernel.org>
Date: Tue, 04 Nov 2025 09:48:51 +1100
Message-id: <176221013134.1793333.9441098782366286698@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 04 Nov 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Pages in the RPC receive buffer are contiguous. Practically
> speaking, this means that, after the first bvec, the bv_offset
> field is always zero.
>=20
> The loop in nfsd_iov_iter_aligned_bvec() also sets "skip" to zero
> after the first bvec is checked. Thus, for bvecs following the first
> one, bv_offset =3D 0 and skip =3D 0, and the check becomes:
>=20
>   (0 + 0) & addr_mask =3D 0
>=20
> This always passes regardless of the alignment mask.
>=20
> Since all bvecs after the first one start at bv_offset zero (page-
> aligned), they are inherently aligned for DIO. Therefore, only the
> first bvec needs to be checked for DIO alignment.
>=20
> Note that for RDMA transports, the incoming payload always starts on
> page alignment, since svcrdma sets up the RDMA Read sink buffers
> that way. For RDMA, this loop visits every bvec in each payload, and
> never finds an unaligned bvec.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 5d6efcceb8c9..37353fb48d58 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1288,30 +1288,20 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned =
long len,
>  	return true;
>  }
> =20
> +/*
> + * Check if the bvec iterator is aligned for direct I/O.
> + *
> + * bvecs generated from RPC receive buffers are contiguous: After the first
> + * bvec, all subsequent bvecs start at bv_offset zero (page-aligned).
> + * Therefore, only the first bvec is checked.
> + */
>  static bool
>  nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_it=
er *i)
>  {
> -	unsigned int len_mask =3D nf->nf_dio_offset_align - 1;
>  	unsigned int addr_mask =3D nf->nf_dio_mem_align - 1;
>  	const struct bio_vec *bvec =3D i->bvec;
> -	size_t skip =3D i->iov_offset;
> -	size_t size =3D i->count;
> =20
> -	if (size & len_mask)
> -		return false;
> -	do {
> -		size_t len =3D bvec->bv_len;
> -
> -		if (len > size)
> -			len =3D size;
> -		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> -			return false;
> -		bvec++;
> -		size -=3D len;
> -		skip =3D 0;
> -	} while (size);
> -
> -	return true;
> +	return !((unsigned long)(bvec->bv_offset + i->iov_offset) & addr_mask);

I would MUCH rather

	return ((unsigned long)(bvec->bv_offset + i->iov_offset) & addr_mask) =3D=3D=
 0;

as it really is a number, not a bool, that is being tested.
I find the latter easy to read, and the former a challenge.

But this is a nice simplification.

Reviewed-by: NeilBrown <neil@brown.name>

NeilBrown


>  }
> =20
>  static void
> --=20
> 2.51.0
>=20
>=20


