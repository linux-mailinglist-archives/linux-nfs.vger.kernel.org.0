Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D2766A134
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 18:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjAMRxu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 12:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjAMRxP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 12:53:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3051781C23
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 09:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673631931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VcoEKKLoklyxLa8uKa+QZayTdseV7//GLQGlHpvTs7c=;
        b=jN7p0ZD+1DOZhKbVLYvXk27cYDGoevoYOIvchDyWMWUbSlvhg8bE+h6vCd8PNvTBUENCyQ
        tQsbSS8ZLysSTSh86gx6fdujCx4uORTeIQR2Lo0NkHwiHuWQLeMMp4L7GuqXjFMgn3UjpQ
        AaABVk2gleO05z0W/WC0Jz/8urzS6Yk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-451-Ht5naVCdMqGkddFRDkeS_A-1; Fri, 13 Jan 2023 12:45:30 -0500
X-MC-Unique: Ht5naVCdMqGkddFRDkeS_A-1
Received: by mail-qv1-f72.google.com with SMTP id ng1-20020a0562143bc100b004bb706b3a27so11919449qvb.20
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 09:45:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcoEKKLoklyxLa8uKa+QZayTdseV7//GLQGlHpvTs7c=;
        b=MoP+ge1qe55T/J34n5XQZiDhsq9Glfnh409PNy+aS1eefqim6La6uKxclOc3xzDxNT
         58vMmLNpgi1iPsVjEPxTt/ZQQ4VsR5gYejGjYXSB1mj1WkUWhT9f99ipuijRln5Q+dcv
         AG8m4vlV1SRC8O9EKn8Q9cqoqZTVJGBjFXo2EDf7ilYyN5us3dbU1YKJfzMi1u4hZkc6
         oY5U6yQzmGrzWuLEMUr2b1YC0DiAdzT3w/VLI2pN9T1tOkIMAMCAB7RGQRCtfTSJ41VI
         Ayd51PxS3ZSd5097PhsbntZpFrY7w/AC7FGd8ea+sdSgDWnp1mVXiEMGTSlYeh1FzNYX
         t/IQ==
X-Gm-Message-State: AFqh2krw2aAhXZiA2CIGZxxcWRJZCD5/TNNL8tFfYUWdqOaAhnq/633O
        lIFSpqDjPf85jjj2nRiOyIihqVeLpmemx805MthmfMaRGU/Fae9gqZn1qUJ8JndsJY8fQzdG+i3
        GgJ+CXxH+aBV9X5vh39gt
X-Received: by 2002:ac8:1344:0:b0:3ab:5d1e:a775 with SMTP id f4-20020ac81344000000b003ab5d1ea775mr105307417qtj.12.1673631929497;
        Fri, 13 Jan 2023 09:45:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt357olefBAidrGj0M8iE58yDULgLdydTq/pLSUd/WhOeUIhGZ2cOlpQPSgOIk57J2Blej4yA==
X-Received: by 2002:ac8:1344:0:b0:3ab:5d1e:a775 with SMTP id f4-20020ac81344000000b003ab5d1ea775mr105307386qtj.12.1673631929179;
        Fri, 13 Jan 2023 09:45:29 -0800 (PST)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id cr26-20020a05622a429a00b003a68fe872a5sm10760358qtb.96.2023.01.13.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:45:28 -0800 (PST)
Message-ID: <da45d36f18ed0f019d0cd16d2715465c3ad0a1eb.camel@redhat.com>
Subject: Re: [PATCH v1 04/41] SUNRPC: Improve Kerberos confounder generation
From:   Simo Sorce <simo@redhat.com>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com
Date:   Fri, 13 Jan 2023 12:45:28 -0500
In-Reply-To: <167362331302.8960.7194615871100298109.stgit@bazille.1015granger.net>
References: <167362164696.8960.16701168753472560115.stgit@bazille.1015granger.net>
         <167362331302.8960.7194615871100298109.stgit@bazille.1015granger.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SIPHash is not a cryptographically secure PRNG, and is  not suitable
for the confounder, strong NACK on this.

Simo.

On Fri, 2023-01-13 at 10:21 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Other common Kerberos implementations use a fully random confounder
> for encryption. For a Kerberos implementation that is part of an O/S
> I/O stack, this is impractical. However, using a fast PRG that does
> not deplete the system entropy pool is possible and desirable.
>=20
> Use an atomic type to ensure that confounder generation
> deterministically generates a unique and pseudo-random result in the
> face of concurrent execution, and make the confounder generation
> materials unique to each Keberos context. The latter has several
> benefits:
>=20
> - the internal counter will wrap less often
> - no way to guess confounders based on other Kerberos-encrypted
>   traffic
> - better scalability
>=20
> Since confounder generation is part of Kerberos itself rather than
> the GSS-API Kerberos mechanism, the function is renamed and moved.
>=20
> Tested-by: Scott Mayhew <smayhew@redhat.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/gss_krb5.h         |    7 +++---
>  net/sunrpc/auth_gss/gss_krb5_crypto.c   |   28 ++++++++++++++++++++++-
>  net/sunrpc/auth_gss/gss_krb5_internal.h |   13 +++++++++++
>  net/sunrpc/auth_gss/gss_krb5_mech.c     |   17 +++++++-------
>  net/sunrpc/auth_gss/gss_krb5_wrap.c     |   38 ++-----------------------=
------
>  5 files changed, 56 insertions(+), 47 deletions(-)
>  create mode 100644 net/sunrpc/auth_gss/gss_krb5_internal.h
>=20
> diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_k=
rb5.h
> index 51860e3a0216..192f5b37763f 100644
> --- a/include/linux/sunrpc/gss_krb5.h
> +++ b/include/linux/sunrpc/gss_krb5.h
> @@ -38,6 +38,8 @@
>  #define _LINUX_SUNRPC_GSS_KRB5_H
> =20
>  #include <crypto/skcipher.h>
> +#include <linux/siphash.h>
> +
>  #include <linux/sunrpc/auth_gss.h>
>  #include <linux/sunrpc/gss_err.h>
>  #include <linux/sunrpc/gss_asn1.h>
> @@ -106,6 +108,8 @@ struct krb5_ctx {
>  	atomic_t		seq_send;
>  	atomic64_t		seq_send64;
>  	time64_t		endtime;
> +	atomic64_t		confounder;
> +	siphash_key_t		confkey;
>  	struct xdr_netobj	mech_used;
>  	u8			initiator_sign[GSS_KRB5_MAX_KEYLEN];
>  	u8			acceptor_sign[GSS_KRB5_MAX_KEYLEN];
> @@ -311,7 +315,4 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offse=
t, u32 len,
>  		     struct xdr_buf *buf, u32 *plainoffset,
>  		     u32 *plainlen);
> =20
> -void
> -gss_krb5_make_confounder(char *p, u32 conflen);
> -
>  #endif /* _LINUX_SUNRPC_GSS_KRB5_H */
> diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/=
gss_krb5_crypto.c
> index 8aa5610ef660..6d962079aa95 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> @@ -47,10 +47,36 @@
>  #include <linux/sunrpc/gss_krb5.h>
>  #include <linux/sunrpc/xdr.h>
> =20
> +#include "gss_krb5_internal.h"
> +
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  # define RPCDBG_FACILITY        RPCDBG_AUTH
>  #endif
> =20
> +/**
> + * krb5_make_confounder - Generate a unique pseudorandom string
> + * @kctx: Kerberos context
> + * @p: memory location into which to write the string
> + * @conflen: string length to write, in octets
> + *
> + * To avoid draining the system's entropy pool when under heavy
> + * encrypted I/O loads, the @kctx has a small amount of random seed
> + * data that is then hashed to generate each pseudorandom confounder
> + * string.
> + */
> +void
> +krb5_make_confounder(struct krb5_ctx *kctx, u8 *p, int conflen)
> +{
> +	u64 *q =3D (u64 *)p;
> +
> +	WARN_ON_ONCE(conflen < sizeof(*q));
> +	while (conflen > 0) {
> +		*q++ =3D siphash_1u64(atomic64_inc_return(&kctx->confounder),
> +				    &kctx->confkey);
> +		conflen -=3D sizeof(*q);
> +	}
> +}
> +
>  u32
>  krb5_encrypt(
>  	struct crypto_sync_skcipher *tfm,
> @@ -630,7 +656,7 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offse=
t,
>  	offset +=3D GSS_KRB5_TOK_HDR_LEN;
>  	if (xdr_extend_head(buf, offset, conflen))
>  		return GSS_S_FAILURE;
> -	gss_krb5_make_confounder(buf->head[0].iov_base + offset, conflen);
> +	krb5_make_confounder(kctx, buf->head[0].iov_base + offset, conflen);
>  	offset -=3D GSS_KRB5_TOK_HDR_LEN;
> =20
>  	if (buf->tail[0].iov_base !=3D NULL) {
> diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gs=
s/gss_krb5_internal.h
> new file mode 100644
> index 000000000000..6249124aba1d
> --- /dev/null
> +++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
> +/*
> + * SunRPC GSS Kerberos 5 mechanism internal definitions
> + *
> + * Copyright (c) 2022 Oracle and/or its affiliates.
> + */
> +
> +#ifndef _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
> +#define _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
> +
> +void krb5_make_confounder(struct krb5_ctx *kctx, u8 *p, int conflen);
> +
> +#endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
> diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gs=
s_krb5_mech.c
> index 08a86ece665e..6d59794c9b69 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_mech.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
> @@ -550,16 +550,17 @@ gss_import_sec_context_kerberos(const void *p, size=
_t len,
>  		ret =3D gss_import_v1_context(p, end, ctx);
>  	else
>  		ret =3D gss_import_v2_context(p, end, ctx, gfp_mask);
> -
> -	if (ret =3D=3D 0) {
> -		ctx_id->internal_ctx_id =3D ctx;
> -		if (endtime)
> -			*endtime =3D ctx->endtime;
> -	} else
> +	if (ret) {
>  		kfree(ctx);
> +		return ret;
> +	}
> =20
> -	dprintk("RPC:       %s: returning %d\n", __func__, ret);
> -	return ret;
> +	ctx_id->internal_ctx_id =3D ctx;
> +	if (endtime)
> +		*endtime =3D ctx->endtime;
> +	atomic64_set(&ctx->confounder, get_random_u64());
> +	get_random_bytes(&ctx->confkey, sizeof(ctx->confkey));
> +	return 0;
>  }
> =20
>  static void
> diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gs=
s_krb5_wrap.c
> index bd068e936947..374214f3c463 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
> @@ -32,9 +32,10 @@
>  #include <linux/types.h>
>  #include <linux/jiffies.h>
>  #include <linux/sunrpc/gss_krb5.h>
> -#include <linux/random.h>
>  #include <linux/pagemap.h>
> =20
> +#include "gss_krb5_internal.h"
> +
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  # define RPCDBG_FACILITY	RPCDBG_AUTH
>  #endif
> @@ -113,39 +114,6 @@ gss_krb5_remove_padding(struct xdr_buf *buf, int blo=
cksize)
>  	return 0;
>  }
> =20
> -void
> -gss_krb5_make_confounder(char *p, u32 conflen)
> -{
> -	static u64 i =3D 0;
> -	u64 *q =3D (u64 *)p;
> -
> -	/* rfc1964 claims this should be "random".  But all that's really
> -	 * necessary is that it be unique.  And not even that is necessary in
> -	 * our case since our "gssapi" implementation exists only to support
> -	 * rpcsec_gss, so we know that the only buffers we will ever encrypt
> -	 * already begin with a unique sequence number.  Just to hedge my bets
> -	 * I'll make a half-hearted attempt at something unique, but ensuring
> -	 * uniqueness would mean worrying about atomicity and rollover, and I
> -	 * don't care enough. */
> -
> -	/* initialize to random value */
> -	if (i =3D=3D 0) {
> -		i =3D get_random_u32();
> -		i =3D (i << 32) | get_random_u32();
> -	}
> -
> -	switch (conflen) {
> -	case 16:
> -		*q++ =3D i++;
> -		fallthrough;
> -	case 8:
> -		*q++ =3D i++;
> -		break;
> -	default:
> -		BUG();
> -	}
> -}
> -
>  /* Assumptions: the head and tail of inbuf are ours to play with.
>   * The pages, however, may be real pages in the page cache and we replac=
e
>   * them with scratch pages from **pages before writing to them. */
> @@ -211,7 +179,7 @@ gss_wrap_kerberos_v1(struct krb5_ctx *kctx, int offse=
t,
>  	ptr[6] =3D 0xff;
>  	ptr[7] =3D 0xff;
> =20
> -	gss_krb5_make_confounder(msg_start, conflen);
> +	krb5_make_confounder(kctx, msg_start, conflen);
> =20
>  	if (kctx->gk5e->keyed_cksum)
>  		cksumkey =3D kctx->cksum;
>=20
>=20

--=20
Simo Sorce
RHEL Crypto Team
Red Hat, Inc



