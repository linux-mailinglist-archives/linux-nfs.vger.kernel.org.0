Return-Path: <linux-nfs+bounces-14153-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B48B50926
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 01:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86CB3AE6A0
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 23:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AFB2797B5;
	Tue,  9 Sep 2025 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ObHzCeCd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a0FIqc0/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187726D4C3
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460020; cv=none; b=uzTehksfrhDpwEKojIan2wWv4DchF5vO87FOtRButMbmi72rvLYTkdh8oSuQilj0Dxu31jpINvcGiDVmXSNlDWUza0jOebP+G0zMkFW7662uaTPG3uIRPcgxSkEwVJwU9DQax1eVLUjxGexOnM1TD3I7QNpYDjIR4hOrBy1+Uqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460020; c=relaxed/simple;
	bh=okU4/aVBVOsVFsbPw+ui7hr9M5ELP5Bzmu60RJFwsGo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=kngHtt5Tn6lzn4gtElwTBc9uzCDLgjvJJWLdV4Xn9usfa/5ix69yVaR6yYd7emuDnTDWiIZ7LSpIOFJPV/38EaeigpOMDMawPYI47oh8+FEpuiE18mKhw+x10RxDq15tBESW1VOLNUEAXnD9QzOgXFUldeKFRLnIK6vtmEMGsSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ObHzCeCd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a0FIqc0/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 053FB1400114;
	Tue,  9 Sep 2025 19:20:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 19:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757460017; x=1757546417; bh=iVgmccj95zCF01E8n67D38w78RU7wCJV3bM
	GftXFODw=; b=ObHzCeCdMjpalPNqBNsCFUdOCm2udXVU/bJMjGojogKreJ50YHN
	XCg/ZCoBN1VYgl6RfwwS3BnE1g5k8Lq2mfrLNoZuMrrgr4UXBRgyopYGFV4modS0
	dUDxcppcH1LlAiegRg5eR8S3dzCDx3i6XyjO2nEpdYPB4OrUOz/5RozQNU8DqYBJ
	rytRkbt5lPmui901T0KiTBI0n0CSr+VLC2vxM3of07a5Ne1f8LDL0F3QtCxC0UsF
	7lVbCF0Ty7nZgYtwPbD6q9jil4Z3hiX+r6ISQkreeavSLY6xbatsAgltnyRkWPpL
	XqTDJpCaplMhu8qs1ZvXxhyN97Fwypdzg1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757460017; x=
	1757546417; bh=iVgmccj95zCF01E8n67D38w78RU7wCJV3bMGftXFODw=; b=a
	0FIqc0//EoxUxi69HGW+buaag8Zww9pMED6+WAEgJiNJ1ZF1XKwfaBWzmyA2Xcoc
	OAGy7YGAAj9omKZN/ZEUPaWtor/PXaHLNEjbqOhaS+L7Jb4/UZEks7u2a/yjcK9k
	w4ssxrH1GvRMPaQlHHeZHnCnwoI/j6mzpgFKOhSlbC21NhD74aJ5M9nz/KbLQ06l
	Q9a1oMRHPBO1CVDmhWwGdGXQnxMGISkuYzAyO7BdafWF3N7ce6cUBA6Thqga4g82
	HF1fNhIJgcrqLhBEeRCLcNrFHbZWdcPUh4s8UuCRvXMuaSltAxlUIpZZGTbtPz9d
	r3C0Zpquyv8+GCJUD1vlg==
X-ME-Sender: <xms:MLbAaH2dO67_0umrxBejdtvxaYF1Zosta3PtUmfADpXZQv2Wzu5qAA>
    <xme:MLbAaDo4YD8pFkbjSRhWy-IqpxrUVhj77Yrfra_l4hicjTSy6yo5iya7I-yUofYZN
    yFogBy6F70Kig>
X-ME-Received: <xmr:MLbAaOV6ox7uyNkgrX-4bAXHK55bdP2yUGnyy_G-PYxGMOXoup2XqDI8VE2aGk5a1bu-utMociTOXGbbxW9tT3eqrXGDAtROndBDgbeFP7UV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefurhgjfhffkfesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fhieetveeigeefffelhfdvveeuvefgfffhieevhfdtudffledukedujefhffelueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopehsnhhithiivghrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghlsehkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MLbAaObl1RSQQm_GzR8AgF8wNzhi69zSBClCa34AxSOEjsnSQAMp8g>
    <xmx:MLbAaLfm9MFl2Ji1XWodXaGmg2hy11RxjDpsy7IaKEu9I3Vsw_8s0g>
    <xmx:MLbAaI0BHXNFHPV0vrE793l0k3cVuuVQnJ3inRW-2PhLBe31Sg5IIg>
    <xmx:MLbAaCJSI1WK9Icu8zeG_4yIuQQ9AItpH73eNOARZT_7imOnI1Kmtg>
    <xmx:MLbAaJLEGBlVN_MUZeDPWHbixk7MJRQ0gQGRs4clRfHwNLgqtYYnGgMy>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 19:20:14 -0400 (EDT)
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
 "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH v1 2/3] NFSD: pass nfsd_file to nfsd_iter_read()
Reply-to: neil@brown.name
In-reply-to: <20250909190525.7214-3-cel@kernel.org>
References: <20250909190525.7214-1-cel@kernel.org>,
 <20250909190525.7214-3-cel@kernel.org>
Date: Wed, 10 Sep 2025 09:20:10 +1000
Message-id: <175746001021.2850467.17419860952260683635@noble.neil.brown.name>

On Wed, 10 Sep 2025, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
>=20
> Prepares for nfsd_iter_read() to use DIO alignment stored in nfsd_file.

This is particularly unhelpful commit description.  It would be
perfectly good as an introduce to a description which actually gives
some details, which could then be compared to the code.

   Prepare for nfsd_iter_read() to use the DIO alignment stored in
   nfsd_file by passing the nfsd_file to nfsd_iter_read() rather than
   just the file which is associaed with the nfsd_file.

   This means nfsd4_encode_readv() now also needs the nfsd_file rather
   than the file.  Instead of changing the file arg to be the nfsd_file,
   we discard the file arg as the nfsd_file (and indeed the file) is
   already available via the "read" argument.


Now when I read the patch it makes perfect sense.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 8 ++++----
>  fs/nfsd/vfs.c     | 7 ++++---
>  fs/nfsd/vfs.h     | 2 +-
>  3 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c0a3c6a7c8bb..cd3251340b5c 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4465,7 +4465,7 @@ static __be32 nfsd4_encode_splice_read(
> =20
>  static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
>  				 struct nfsd4_read *read,
> -				 struct file *file, unsigned long maxcount)
> +				 unsigned long maxcount)
>  {
>  	struct xdr_stream *xdr =3D resp->xdr;
>  	unsigned int base =3D xdr->buf->page_len & ~PAGE_MASK;
> @@ -4476,7 +4476,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoun=
dres *resp,
>  	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
>  		return nfserr_resource;
> =20
> -	nfserr =3D nfsd_iter_read(resp->rqstp, read->rd_fhp, file,
> +	nfserr =3D nfsd_iter_read(resp->rqstp, read->rd_fhp, read->rd_nf,
>  				read->rd_offset, &maxcount, base,
>  				&read->rd_eof);
>  	read->rd_length =3D maxcount;
> @@ -4523,7 +4523,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __b=
e32 nfserr,
>  	if (file->f_op->splice_read && splice_ok)
>  		nfserr =3D nfsd4_encode_splice_read(resp, read, file, maxcount);
>  	else
> -		nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
> +		nfserr =3D nfsd4_encode_readv(resp, read, maxcount);
>  	if (nfserr) {
>  		xdr_truncate_encode(xdr, eof_offset);
>  		return nfserr;
> @@ -5419,7 +5419,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres =
*resp,
>  	if (file->f_op->splice_read && splice_ok)
>  		nfserr =3D nfsd4_encode_splice_read(resp, read, file, maxcount);
>  	else
> -		nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
> +		nfserr =3D nfsd4_encode_readv(resp, read, maxcount);
>  	if (nfserr)
>  		return nfserr;
> =20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 714777c221ed..441267d877f9 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1078,7 +1078,7 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>   * nfsd_iter_read - Perform a VFS read using an iterator
>   * @rqstp: RPC transaction context
>   * @fhp: file handle of file to be read
> - * @file: opened struct file of file to be read
> + * @nf: opened struct nfsd_file of file to be read
>   * @offset: starting byte offset
>   * @count: IN: requested number of bytes; OUT: number of bytes read
>   * @base: offset in first page of read buffer
> @@ -1091,9 +1091,10 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>   * returned.
>   */
>  __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		      struct file *file, loff_t offset, unsigned long *count,
> +		      struct nfsd_file *nf, loff_t offset, unsigned long *count,
>  		      unsigned int base, u32 *eof)
>  {
> +	struct file *file =3D nf->nf_file;
>  	unsigned long v, total;
>  	struct iov_iter iter;
>  	struct kiocb kiocb;
> @@ -1334,7 +1335,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>  	if (file->f_op->splice_read && nfsd_read_splice_ok(rqstp))
>  		err =3D nfsd_splice_read(rqstp, fhp, file, offset, count, eof);
>  	else
> -		err =3D nfsd_iter_read(rqstp, fhp, file, offset, count, 0, eof);
> +		err =3D nfsd_iter_read(rqstp, fhp, nf, offset, count, 0, eof);
> =20
>  	nfsd_file_put(nf);
>  	trace_nfsd_read_done(rqstp, fhp, offset, *count);
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 0c0292611c6d..fa46f8b5f132 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -121,7 +121,7 @@ __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  				unsigned long *count,
>  				u32 *eof);
>  __be32		nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -				struct file *file, loff_t offset,
> +				struct nfsd_file *nf, loff_t offset,
>  				unsigned long *count, unsigned int base,
>  				u32 *eof);
>  bool		nfsd_read_splice_ok(struct svc_rqst *rqstp);
> --=20
> 2.50.0
>=20
>=20
>=20


