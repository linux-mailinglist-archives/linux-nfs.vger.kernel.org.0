Return-Path: <linux-nfs+bounces-13004-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8C2B02E38
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 02:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCDB1A60461
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 00:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC717F9;
	Sun, 13 Jul 2025 00:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3BDNzHl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36E6A2D;
	Sun, 13 Jul 2025 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752365074; cv=none; b=hMWuQveRcYMikrjtecWKIWxBj+FbY/iHXMC2V4kQ3uC2RT/dOCoNh6O1rMiojA1fLuKasU3wWCJ3HWSfcEmalzyZS29lUfAxaQeKXqpvIW4Btp3LNH6IgCXuHot9qzsduueJMeFL7yo6CsOnx9QYRrQmHn/fHwbjwbHLpAw9cNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752365074; c=relaxed/simple;
	bh=u/2P5Onx299dOOWEeQU/rni1CC4M39jsIsFNGOTZZ1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lhJHvNkd3EAj3kp02w+axp7duqwA2WhRZqRoF+8JREYbc3vyTCVpbYdS1Gb0CxFXmtaM6kwes9Wha+hHciZayS7OnJJsMPIcpv5QH8k9eEMjw4+Qj2BHkBoj2UqHgnj1dOQVEPAWOGVLTisK0H5t0L0xgxyI1cb/MWo19wVi5Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3BDNzHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94792C4CEEF;
	Sun, 13 Jul 2025 00:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752365073;
	bh=u/2P5Onx299dOOWEeQU/rni1CC4M39jsIsFNGOTZZ1Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=G3BDNzHl5GZyEprno9I5xn6zt6xLWs86UozC5zKIxLcBXpBRozspW4+DF+97TEpme
	 WJwwwin0Os88IXEB+1AbBt5DZ6M8WUwcJ6+I0qeC93pA2wNvQ+ILb7VceX6LVjA/Ve
	 6TtEMJHUzzEwUELv6esdrftge2Z8q5dtilly/LV+a2pNycRBmHczYx5bJM8vRXVJdk
	 jw4ZCRQJ2S30MQuaBRBFKBQtgUXPRjmgoHMShz8F8NAH+OHuWMrho3FGw32nnZzr3I
	 rk3rYDHWZfokPDXjH602WjBeeMIBfisCjZzuEVCG1Cjq0kbBYklbkJp3rAweEzi1w4
	 gnCsXzxNydVOQ==
Message-ID: <1ae3c2fa194bb7708ad5a98b1fb7156b9efcb8e7.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: Remove unused xdr functions
From: Trond Myklebust <trondmy@kernel.org>
To: linux@treblig.org, chuck.lever@oracle.com, anna@kernel.org, 
	jlayton@kernel.org
Cc: neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
 tom@talpey.com, 	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 12 Jul 2025 17:04:30 -0700
In-Reply-To: <20250712233006.403226-1-linux@treblig.org>
References: <20250712233006.403226-1-linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-07-13 at 00:30 +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>=20
> Remove a bunch of unused xdr_*decode* functions:
> =C2=A0 The last use of xdr_decode_netobj() was removed in 2021 by:
> commit 7cf96b6d0104 ("lockd: Update the NLMv4 SHARE arguments decoder
> to
> use struct xdr_stream")
> =C2=A0 The last use of xdr_decode_string_inplace() was removed in 2021 by=
:
> commit 3049e974a7c7 ("lockd: Update the NLMv4 FREE_ALL arguments
> decoder
> to use struct xdr_stream")
> =C2=A0 The last use of xdr_stream_decode_opaque() was removed in 2024 by:
> commit fed8a17c61ff ("xdrgen: typedefs should use the built-in string
> and
> opaque functions")
>=20
> =C2=A0 The functions xdr_stream_decode_string() and
> xdr_stream_decode_opaque_dup() were both added in 2018 by the
> commit 0e779aa70308 ("SUNRPC: Add helpers for decoding opaque and
> string
> types")
> but never used.
>=20
> Remove them.
>=20
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
> =C2=A0include/linux/sunrpc/xdr.h |=C2=A0=C2=A0 9 ---
> =C2=A0net/sunrpc/xdr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 110 -----------------------------------
> --
> =C2=A02 files changed, 119 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index a2ab813a9800..e370886632b0 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -128,10 +128,7 @@ xdr_buf_init(struct xdr_buf *buf, void *start,
> size_t len)
> =C2=A0__be32 *xdr_encode_opaque_fixed(__be32 *p, const void *ptr, unsigne=
d
> int len);
> =C2=A0__be32 *xdr_encode_opaque(__be32 *p, const void *ptr, unsigned int
> len);
> =C2=A0__be32 *xdr_encode_string(__be32 *p, const char *s);
> -__be32 *xdr_decode_string_inplace(__be32 *p, char **sp, unsigned int
> *lenp,
> -			unsigned int maxlen);
> =C2=A0__be32 *xdr_encode_netobj(__be32 *p, const struct xdr_netobj *);
> -__be32 *xdr_decode_netobj(__be32 *p, struct xdr_netobj *);
> =C2=A0
> =C2=A0void	xdr_inline_pages(struct xdr_buf *, unsigned int,
> =C2=A0			 struct page **, unsigned int, unsigned
> int);
> @@ -341,12 +338,6 @@ xdr_stream_remaining(const struct xdr_stream
> *xdr)
> =C2=A0	return xdr->nwords << 2;
> =C2=A0}
> =C2=A0
> -ssize_t xdr_stream_decode_opaque(struct xdr_stream *xdr, void *ptr,
> -		size_t size);
> -ssize_t xdr_stream_decode_opaque_dup(struct xdr_stream *xdr, void
> **ptr,
> -		size_t maxlen, gfp_t gfp_flags);
> -ssize_t xdr_stream_decode_string(struct xdr_stream *xdr, char *str,
> -		size_t size);
> =C2=A0ssize_t xdr_stream_decode_string_dup(struct xdr_stream *xdr, char
> **str,
> =C2=A0		size_t maxlen, gfp_t gfp_flags);
> =C2=A0ssize_t xdr_stream_decode_opaque_auth(struct xdr_stream *xdr, u32
> *flavor,
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 2ea00e354ba6..a0aae1144212 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -37,19 +37,6 @@ xdr_encode_netobj(__be32 *p, const struct
> xdr_netobj *obj)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(xdr_encode_netobj);
> =C2=A0
> -__be32 *
> -xdr_decode_netobj(__be32 *p, struct xdr_netobj *obj)
> -{
> -	unsigned int	len;
> -
> -	if ((len =3D be32_to_cpu(*p++)) > XDR_MAX_NETOBJ)
> -		return NULL;
> -	obj->len=C2=A0 =3D len;
> -	obj->data =3D (u8 *) p;
> -	return p + XDR_QUADLEN(len);
> -}
> -EXPORT_SYMBOL_GPL(xdr_decode_netobj);
> -
> =C2=A0/**
> =C2=A0 * xdr_encode_opaque_fixed - Encode fixed length opaque data
> =C2=A0 * @p: pointer to current position in XDR buffer.
> @@ -102,21 +89,6 @@ xdr_encode_string(__be32 *p, const char *string)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(xdr_encode_string);
> =C2=A0
> -__be32 *
> -xdr_decode_string_inplace(__be32 *p, char **sp,
> -			=C2=A0 unsigned int *lenp, unsigned int maxlen)
> -{
> -	u32 len;
> -
> -	len =3D be32_to_cpu(*p++);
> -	if (len > maxlen)
> -		return NULL;
> -	*lenp =3D len;
> -	*sp =3D (char *) p;
> -	return p + XDR_QUADLEN(len);
> -}
> -EXPORT_SYMBOL_GPL(xdr_decode_string_inplace);
> -
> =C2=A0/**
> =C2=A0 * xdr_terminate_string - '\0'-terminate a string residing in an
> xdr_buf
> =C2=A0 * @buf: XDR buffer where string resides
> @@ -2247,88 +2219,6 @@ int xdr_process_buf(const struct xdr_buf *buf,
> unsigned int offset,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(xdr_process_buf);
> =C2=A0
> -/**
> - * xdr_stream_decode_opaque - Decode variable length opaque
> - * @xdr: pointer to xdr_stream
> - * @ptr: location to store opaque data
> - * @size: size of storage buffer @ptr
> - *
> - * Return values:
> - *=C2=A0=C2=A0 On success, returns size of object stored in *@ptr
> - *=C2=A0=C2=A0 %-EBADMSG on XDR buffer overflow
> - *=C2=A0=C2=A0 %-EMSGSIZE on overflow of storage buffer @ptr
> - */
> -ssize_t xdr_stream_decode_opaque(struct xdr_stream *xdr, void *ptr,
> size_t size)
> -{
> -	ssize_t ret;
> -	void *p;
> -
> -	ret =3D xdr_stream_decode_opaque_inline(xdr, &p, size);
> -	if (ret <=3D 0)
> -		return ret;
> -	memcpy(ptr, p, ret);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(xdr_stream_decode_opaque);
> -
> -/**
> - * xdr_stream_decode_opaque_dup - Decode and duplicate variable
> length opaque
> - * @xdr: pointer to xdr_stream
> - * @ptr: location to store pointer to opaque data
> - * @maxlen: maximum acceptable object size
> - * @gfp_flags: GFP mask to use
> - *
> - * Return values:
> - *=C2=A0=C2=A0 On success, returns size of object stored in *@ptr
> - *=C2=A0=C2=A0 %-EBADMSG on XDR buffer overflow
> - *=C2=A0=C2=A0 %-EMSGSIZE if the size of the object would exceed @maxlen
> - *=C2=A0=C2=A0 %-ENOMEM on memory allocation failure
> - */
> -ssize_t xdr_stream_decode_opaque_dup(struct xdr_stream *xdr, void
> **ptr,
> -		size_t maxlen, gfp_t gfp_flags)
> -{
> -	ssize_t ret;
> -	void *p;
> -
> -	ret =3D xdr_stream_decode_opaque_inline(xdr, &p, maxlen);
> -	if (ret > 0) {
> -		*ptr =3D kmemdup(p, ret, gfp_flags);
> -		if (*ptr !=3D NULL)
> -			return ret;
> -		ret =3D -ENOMEM;
> -	}
> -	*ptr =3D NULL;
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(xdr_stream_decode_opaque_dup);
> -
> -/**
> - * xdr_stream_decode_string - Decode variable length string
> - * @xdr: pointer to xdr_stream
> - * @str: location to store string
> - * @size: size of storage buffer @str
> - *
> - * Return values:
> - *=C2=A0=C2=A0 On success, returns length of NUL-terminated string store=
d in
> *@str
> - *=C2=A0=C2=A0 %-EBADMSG on XDR buffer overflow
> - *=C2=A0=C2=A0 %-EMSGSIZE on overflow of storage buffer @str
> - */
> -ssize_t xdr_stream_decode_string(struct xdr_stream *xdr, char *str,
> size_t size)
> -{
> -	ssize_t ret;
> -	void *p;
> -
> -	ret =3D xdr_stream_decode_opaque_inline(xdr, &p, size);
> -	if (ret > 0) {
> -		memcpy(str, p, ret);
> -		str[ret] =3D '\0';
> -		return strlen(str);
> -	}
> -	*str =3D '\0';
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(xdr_stream_decode_string);
> -
> =C2=A0/**
> =C2=A0 * xdr_stream_decode_string_dup - Decode and duplicate variable
> length string
> =C2=A0 * @xdr: pointer to xdr_stream

I can pick these up.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

