Return-Path: <linux-nfs+bounces-13039-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1536DB03E3F
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 14:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BF23AEB73
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 12:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FF5248F64;
	Mon, 14 Jul 2025 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzfitB5J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2A1EEF9;
	Mon, 14 Jul 2025 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494602; cv=none; b=pKuOV01e9MwUgwKOebnGfY+QcS3v/iAs/4oj+/pZ53VCGcNPBfTeQZYwazUN5SYWNMW5dzvI8XQTSDJu00MBPewhM8YrS0KdDMKstmZ1TY4IuwMZGTS33pbVnvGubJscIypjle79//NDyZ3r/6IvL2trg6uR0GP+lSD5kqxPo44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494602; c=relaxed/simple;
	bh=9s0yNP+RL2Ndis5KUqBJId48sXbciwqOqNUYi+Z3JyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDE74PQMoXC0Ik9C5Cnwzs+vOgCZVqnF8+lqV9qQR1eB1kamH9gjdWwfXR4R4dZIASKt+mVbeqxiDXH6V9rPjFtU7gFEtF4zt0fE1Jve/PWGQFRS02Tpd5b53aV4v+7sX9PEGnDfDLegCyfux8lG7kcq2J5j9nmbpUOAH4t9bok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzfitB5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D2FC4CEF4;
	Mon, 14 Jul 2025 12:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752494602;
	bh=9s0yNP+RL2Ndis5KUqBJId48sXbciwqOqNUYi+Z3JyA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WzfitB5J5/LL6Ku0cJVPzygaHAFGKd/NmoyzMdQAYaxu6Dw6B81FPhH1m3MWxH9yj
	 EX04vdvOYYcF4u6Ter1eWm9zF+ep4bN3CI5L9uokf9LMh/A/mXkoKZdmdRuMyqbm/C
	 Zv9ipM/r99tO+d+LgyF3i6f/S6bKfpDyWLU1kJ4KXJ4PEbjvXQFPd5ixXzSMWUHjEi
	 VO9zqLIxh9BDcaIQvijnSzBJIa3+qJb2MG0R3TsU87S/WNnNZwqWQrKQyxK5giJ3aq
	 99jOQyKlGwhCDYu2MLquIuECudnS95GC7w5RDWoCMhyBDFGOuLtsHRr3RM0OMGdu5w
	 28TsOSbqJcuKA==
Message-ID: <8353f6c4ef26a9459468e545cbd15d7e44a257ce.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: Remove unused xdr functions
From: Jeff Layton <jlayton@kernel.org>
To: linux@treblig.org, chuck.lever@oracle.com, anna@kernel.org, 
	trondmy@kernel.org
Cc: neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
 tom@talpey.com, 	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 14 Jul 2025 08:03:20 -0400
In-Reply-To: <20250712233006.403226-1-linux@treblig.org>
References: <20250712233006.403226-1-linux@treblig.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
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
>   The last use of xdr_decode_netobj() was removed in 2021 by:
> commit 7cf96b6d0104 ("lockd: Update the NLMv4 SHARE arguments decoder to
> use struct xdr_stream")
>   The last use of xdr_decode_string_inplace() was removed in 2021 by:
> commit 3049e974a7c7 ("lockd: Update the NLMv4 FREE_ALL arguments decoder
> to use struct xdr_stream")
>   The last use of xdr_stream_decode_opaque() was removed in 2024 by:
> commit fed8a17c61ff ("xdrgen: typedefs should use the built-in string and
> opaque functions")
>=20
>   The functions xdr_stream_decode_string() and
> xdr_stream_decode_opaque_dup() were both added in 2018 by the
> commit 0e779aa70308 ("SUNRPC: Add helpers for decoding opaque and string
> types")
> but never used.
>=20
> Remove them.
>=20
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  include/linux/sunrpc/xdr.h |   9 ---
>  net/sunrpc/xdr.c           | 110 -------------------------------------
>  2 files changed, 119 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index a2ab813a9800..e370886632b0 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -128,10 +128,7 @@ xdr_buf_init(struct xdr_buf *buf, void *start, size_=
t len)
>  __be32 *xdr_encode_opaque_fixed(__be32 *p, const void *ptr, unsigned int=
 len);
>  __be32 *xdr_encode_opaque(__be32 *p, const void *ptr, unsigned int len);
>  __be32 *xdr_encode_string(__be32 *p, const char *s);
> -__be32 *xdr_decode_string_inplace(__be32 *p, char **sp, unsigned int *le=
np,
> -			unsigned int maxlen);
>  __be32 *xdr_encode_netobj(__be32 *p, const struct xdr_netobj *);
> -__be32 *xdr_decode_netobj(__be32 *p, struct xdr_netobj *);
> =20
>  void	xdr_inline_pages(struct xdr_buf *, unsigned int,
>  			 struct page **, unsigned int, unsigned int);
> @@ -341,12 +338,6 @@ xdr_stream_remaining(const struct xdr_stream *xdr)
>  	return xdr->nwords << 2;
>  }
> =20
> -ssize_t xdr_stream_decode_opaque(struct xdr_stream *xdr, void *ptr,
> -		size_t size);
> -ssize_t xdr_stream_decode_opaque_dup(struct xdr_stream *xdr, void **ptr,
> -		size_t maxlen, gfp_t gfp_flags);
> -ssize_t xdr_stream_decode_string(struct xdr_stream *xdr, char *str,
> -		size_t size);
>  ssize_t xdr_stream_decode_string_dup(struct xdr_stream *xdr, char **str,
>  		size_t maxlen, gfp_t gfp_flags);
>  ssize_t xdr_stream_decode_opaque_auth(struct xdr_stream *xdr, u32 *flavo=
r,
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 2ea00e354ba6..a0aae1144212 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -37,19 +37,6 @@ xdr_encode_netobj(__be32 *p, const struct xdr_netobj *=
obj)
>  }
>  EXPORT_SYMBOL_GPL(xdr_encode_netobj);
> =20
> -__be32 *
> -xdr_decode_netobj(__be32 *p, struct xdr_netobj *obj)
> -{
> -	unsigned int	len;
> -
> -	if ((len =3D be32_to_cpu(*p++)) > XDR_MAX_NETOBJ)
> -		return NULL;
> -	obj->len  =3D len;
> -	obj->data =3D (u8 *) p;
> -	return p + XDR_QUADLEN(len);
> -}
> -EXPORT_SYMBOL_GPL(xdr_decode_netobj);
> -
>  /**
>   * xdr_encode_opaque_fixed - Encode fixed length opaque data
>   * @p: pointer to current position in XDR buffer.
> @@ -102,21 +89,6 @@ xdr_encode_string(__be32 *p, const char *string)
>  }
>  EXPORT_SYMBOL_GPL(xdr_encode_string);
> =20
> -__be32 *
> -xdr_decode_string_inplace(__be32 *p, char **sp,
> -			  unsigned int *lenp, unsigned int maxlen)
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
>  /**
>   * xdr_terminate_string - '\0'-terminate a string residing in an xdr_buf
>   * @buf: XDR buffer where string resides
> @@ -2247,88 +2219,6 @@ int xdr_process_buf(const struct xdr_buf *buf, uns=
igned int offset,
>  }
>  EXPORT_SYMBOL_GPL(xdr_process_buf);
> =20
> -/**
> - * xdr_stream_decode_opaque - Decode variable length opaque
> - * @xdr: pointer to xdr_stream
> - * @ptr: location to store opaque data
> - * @size: size of storage buffer @ptr
> - *
> - * Return values:
> - *   On success, returns size of object stored in *@ptr
> - *   %-EBADMSG on XDR buffer overflow
> - *   %-EMSGSIZE on overflow of storage buffer @ptr
> - */
> -ssize_t xdr_stream_decode_opaque(struct xdr_stream *xdr, void *ptr, size=
_t size)
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
> - * xdr_stream_decode_opaque_dup - Decode and duplicate variable length o=
paque
> - * @xdr: pointer to xdr_stream
> - * @ptr: location to store pointer to opaque data
> - * @maxlen: maximum acceptable object size
> - * @gfp_flags: GFP mask to use
> - *
> - * Return values:
> - *   On success, returns size of object stored in *@ptr
> - *   %-EBADMSG on XDR buffer overflow
> - *   %-EMSGSIZE if the size of the object would exceed @maxlen
> - *   %-ENOMEM on memory allocation failure
> - */
> -ssize_t xdr_stream_decode_opaque_dup(struct xdr_stream *xdr, void **ptr,
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
> - *   On success, returns length of NUL-terminated string stored in *@str
> - *   %-EBADMSG on XDR buffer overflow
> - *   %-EMSGSIZE on overflow of storage buffer @str
> - */
> -ssize_t xdr_stream_decode_string(struct xdr_stream *xdr, char *str, size=
_t size)
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
>  /**
>   * xdr_stream_decode_string_dup - Decode and duplicate variable length s=
tring
>   * @xdr: pointer to xdr_stream

Reviewed-by: Jeff Layton <jlayton@kernel.org>

