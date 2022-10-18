Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0C6602CED
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 15:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJRN2N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 09:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiJRN2J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 09:28:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72FA9B871
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 06:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83590B81F29
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 13:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99D1C433C1;
        Tue, 18 Oct 2022 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666099638;
        bh=Hw25iHYy9Ln6C1+/UJkL5nQTGb6vLR25cK5bDQw59YY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cGW0eMiQzW13bhYFVPWTFTqzlIIflM5l2hZBVRpqFRnRPoT0LdI2zuHdh7qlkLjrX
         qqWcyV4WZb0SUj4a2aCtqnV9wFVs7zSFZ9fyJRvi9buXCUf1BSZYbc3QqEySadaR3W
         dy/np8DUrMsVyEMcL5J0yzMaLuW0Rjw0rA78C7uGCa62LeiaoI4tIX7wDNDI0x58yv
         SLSCU7kqPC1HpiTZJhV/MQ1cevZ3c5t0/7RqkzzTCCyYagdGC8xDZAfl5AVTXj1z8u
         FW/DcXtGLoglIS8g3RlTIMWb8TJ5iWfZuio0s88+lsh2L/rQ9zR5Eiqbhfs2S42qsH
         EMnTa+FZ9NqkQ==
Message-ID: <f39180dcf51e2fa63ef61898cb0e046152b12558.camel@kernel.org>
Subject: Re: [PATCH RFC] SUNRPC: Add support for RFC 8009 encryption types
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Tue, 18 Oct 2022 09:27:16 -0400
In-Reply-To: <166603945959.14665.12642421516208884.stgit@manet.1015granger.net>
References: <166603945959.14665.12642421516208884.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-17 at 16:51 -0400, Chuck Lever wrote:
> These new encryption types provide stronger security by replacing
> the deprecated SHA-1 algorithm with SHA-2 in several key areas.
> There already appears to be support for these new types in Linux
> user space libraries and some KDCs.
>=20
> Quoting from RFC 8009 Section 1:
> > The encryption and checksum types defined in this document are
> > intended to support environments that desire to use SHA-256 or
> > SHA-384 (defined in [FIPS180]) as the hash algorithm.  Differences
> > between the encryption and checksum types defined in this document
> > and the pre-existing Kerberos AES encryption and checksum types
> > specified in [RFC3962] are:
> >=20
> > o The pseudorandom function (PRF) used by PBKDF2 is HMAC-SHA-256 or
> >   HMAC-SHA-384.
> >=20
> > o A key derivation function from [SP800-108] using the SHA-256 or
> >   SHA-384 hash algorithm is used to produce keys for encryption,
> >   integrity protection, and checksum operations.
> >=20
> > o The HMAC is calculated over the cipher state concatenated with
> >   the AES output, instead of being calculated over the confounder
> >   and plaintext.  This allows the message receiver to verify the
> >   integrity of the message before decrypting the message.
> >=20
> > o The HMAC algorithm uses the SHA-256 or SHA-384 hash algorithm for
> >   integrity protection and checksum operations.
>=20
> I suspect that the third bullet point means that some code changes
> (rather than just new encryption type parameters) will be needed.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>=20
> The purpose of this RFC is to figure out the code. Testing and
> resolving interoperability issues amongst clients and servers that
> might or might not support these new enctypes will be the next step.
>=20
> This patch has been only been compile-tested for now.
>=20
>  include/linux/sunrpc/gss_krb5.h          |   16 +++++++++
>  include/linux/sunrpc/gss_krb5_enctypes.h |   22 +++++++------
>  net/sunrpc/auth_gss/gss_krb5_mech.c      |   52 ++++++++++++++++++++++++=
++++++
>  net/sunrpc/auth_gss/gss_krb5_seal.c      |    2 +
>  net/sunrpc/auth_gss/gss_krb5_unseal.c    |    2 +
>  net/sunrpc/auth_gss/gss_krb5_wrap.c      |    4 ++
>  6 files changed, 87 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_k=
rb5.h
> index 91f43d86879d..72ded91b7a86 100644
> --- a/include/linux/sunrpc/gss_krb5.h
> +++ b/include/linux/sunrpc/gss_krb5.h
> @@ -150,6 +150,12 @@ enum seal_alg {
>  	SEAL_ALG_DES3KD =3D 0x0002
>  };
> =20
> +/*
> + * These values are assigned by IANA and published via the
> + * subregistry at the link below:
> + *
> + * https://www.iana.org/assignments/kerberos-parameters/kerberos-paramet=
ers.xhtml#kerberos-parameters-2
> + */
>  #define CKSUMTYPE_CRC32			0x0001
>  #define CKSUMTYPE_RSA_MD4		0x0002
>  #define CKSUMTYPE_RSA_MD4_DES		0x0003
> @@ -160,6 +166,8 @@ enum seal_alg {
>  #define CKSUMTYPE_HMAC_SHA1_DES3	0x000c
>  #define CKSUMTYPE_HMAC_SHA1_96_AES128   0x000f
>  #define CKSUMTYPE_HMAC_SHA1_96_AES256   0x0010
> +#define CKSUMTYPE_HMAC_SHA256_128_AES128	0x0013
> +#define CKSUMTYPE_HMAC_SHA384_192_AES256	0x0014
>  #define CKSUMTYPE_HMAC_MD5_ARCFOUR      -138 /* Microsoft md5 hmac cksum=
type */
> =20
>  /* from gssapi_err_krb5.h */
> @@ -180,19 +188,25 @@ enum seal_alg {
> =20
>  /* per Kerberos v5 protocol spec crypto types from the wire.=20
>   * these get mapped to linux kernel crypto routines. =20
> + *
> + * These values are assigned by IANA and published via the
> + * subregistry at the link below:
> + *
> + * https://www.iana.org/assignments/kerberos-parameters/kerberos-paramet=
ers.xhtml#kerberos-parameters-1
>   */
>  #define ENCTYPE_NULL            0x0000
>  #define ENCTYPE_DES_CBC_CRC     0x0001	/* DES cbc mode with CRC-32 */
>  #define ENCTYPE_DES_CBC_MD4     0x0002	/* DES cbc mode with RSA-MD4 */
>  #define ENCTYPE_DES_CBC_MD5     0x0003	/* DES cbc mode with RSA-MD5 */
>  #define ENCTYPE_DES_CBC_RAW     0x0004	/* DES cbc mode raw */
> -/* XXX deprecated? */
>  #define ENCTYPE_DES3_CBC_SHA    0x0005	/* DES-3 cbc mode with NIST-SHA *=
/
>  #define ENCTYPE_DES3_CBC_RAW    0x0006	/* DES-3 cbc mode raw */
>  #define ENCTYPE_DES_HMAC_SHA1   0x0008
>  #define ENCTYPE_DES3_CBC_SHA1   0x0010
>  #define ENCTYPE_AES128_CTS_HMAC_SHA1_96 0x0011
>  #define ENCTYPE_AES256_CTS_HMAC_SHA1_96 0x0012
> +#define ENCTYPE_AES128_CTS_HMAC_SHA256_128	0x0013
> +#define ENCTYPE_AES256_CTS_HMAC_SHA384_192	0x0014
>  #define ENCTYPE_ARCFOUR_HMAC            0x0017
>  #define ENCTYPE_ARCFOUR_HMAC_EXP        0x0018
>  #define ENCTYPE_UNKNOWN         0x01ff
> diff --git a/include/linux/sunrpc/gss_krb5_enctypes.h b/include/linux/sun=
rpc/gss_krb5_enctypes.h
> index 87eea679d750..82aa74f1f2cf 100644
> --- a/include/linux/sunrpc/gss_krb5_enctypes.h
> +++ b/include/linux/sunrpc/gss_krb5_enctypes.h
> @@ -15,11 +15,13 @@
>  /*
>   * NB: This list includes DES3_CBC_SHA1, which was deprecated by RFC 842=
9.
>   *
> - * ENCTYPE_AES256_CTS_HMAC_SHA1_96
> - * ENCTYPE_AES128_CTS_HMAC_SHA1_96
> - * ENCTYPE_DES3_CBC_SHA1
> + * ENCTYPE_AES128_CTS_HMAC_SHA256_192	20
> + * ENCTYPE_AES128_CTS_HMAC_SHA256_128	19
> + * ENCTYPE_AES256_CTS_HMAC_SHA1_96	18
> + * ENCTYPE_AES128_CTS_HMAC_SHA1_96	17
> + * ENCTYPE_DES3_CBC_SHA1		16
>   */
> -#define KRB5_SUPPORTED_ENCTYPES "18,17,16"
> +#define KRB5_SUPPORTED_ENCTYPES "20,19,18,17,16"
> =20
>  #else	/* CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES */
> =20
> @@ -27,12 +29,12 @@
>   * NB: This list includes encryption types that were deprecated
>   * by RFC 8429 and RFC 6649.
>   *
> - * ENCTYPE_AES256_CTS_HMAC_SHA1_96
> - * ENCTYPE_AES128_CTS_HMAC_SHA1_96
> - * ENCTYPE_DES3_CBC_SHA1
> - * ENCTYPE_DES_CBC_MD5
> - * ENCTYPE_DES_CBC_CRC
> - * ENCTYPE_DES_CBC_MD4
> + * ENCTYPE_AES256_CTS_HMAC_SHA1_96	18
> + * ENCTYPE_AES128_CTS_HMAC_SHA1_96	17
> + * ENCTYPE_DES3_CBC_SHA1		16
> + * ENCTYPE_DES_CBC_MD5			3
> + * ENCTYPE_DES_CBC_CRC			1
> + * ENCTYPE_DES_CBC_MD4			2
>   */
>  #define KRB5_SUPPORTED_ENCTYPES "18,17,16,3,1,2"
> =20
> diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gs=
s_krb5_mech.c
> index 1c092b05c2bb..2c5a11693e55 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_mech.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
> @@ -120,6 +120,54 @@ static const struct gss_krb5_enctype supported_gss_k=
rb5_enctypes[] =3D {
>  	  .cksumlength =3D 12,
>  	  .keyed_cksum =3D 1,
>  	},
> +#ifdef CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES


So you only want to define these if insecure enctypes are disabled?
What's the rationale behind that?

If these are newer and more secure then it seems like they should always
be enabled regardless of whether the insecure ones are.

> +	/*
> +	 * AES-128 with SHA-2. See RFC 8009.
> +	 */
> +	{
> +		.etype		=3D ENCTYPE_AES128_CTS_HMAC_SHA256_128,
> +		.ctype		=3D CKSUMTYPE_HMAC_SHA256_128_AES128,
> +		.name		=3D "aes128-cts-hmac-sha256-128",
> +		.encrypt_name	=3D "cts(cbc(aes))",
> +		.cksum_name	=3D "hmac(sha256)",
> +		.encrypt	=3D krb5_encrypt,
> +		.decrypt	=3D krb5_decrypt,
> +		.mk_key		=3D gss_krb5_aes_make_key,
> +		.encrypt_v2	=3D gss_krb5_aes_encrypt,
> +		.decrypt_v2	=3D gss_krb5_aes_decrypt,
> +		.signalg	=3D -1,
> +		.sealalg	=3D -1,
> +		.keybytes	=3D 16,
> +		.keylength	=3D 16,
> +		.blocksize	=3D 16,
> +		.conflen	=3D 16,
> +		.cksumlength	=3D 16,
> +		.keyed_cksum	=3D 1,
> +	}
> +	/*
> +	 * AES-256 with SHA-3. See RFC 8009.
> +	 */
> +	{
> +		.etype		=3D ENCTYPE_AES256_CTS_HMAC_SHA384_192,
> +		.ctype		=3D CKSUMTYPE_HMAC_SHA384_192_AES256,
> +		.name		=3D "aes256-cts-hmac-sha384-192",
> +		.encrypt_name	=3D "cts(cbc(aes))",
> +		.cksum_name	=3D "hmac(sha384)",
> +		.encrypt	=3D krb5_encrypt,
> +		.decrypt	=3D krb5_decrypt,
> +		.mk_key		=3D gss_krb5_aes_make_key,
> +		.encrypt_v2	=3D gss_krb5_aes_encrypt,
> +		.decrypt_v2	=3D gss_krb5_aes_decrypt,
> +		.signalg	=3D -1,
> +		.sealalg	=3D -1,
> +		.keybytes	=3D 32,
> +		.keylength	=3D 32,
> +		.blocksize	=3D 16,
> +		.conflen	=3D 16,
> +		.cksumlength	=3D 24,
> +		.keyed_cksum	=3D 1,
> +	}
> +#endif /* CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES */
>  };
> =20
>  static const int num_supported_enctypes =3D
> @@ -440,6 +488,8 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t g=
fp_mask)
>  	switch (ctx->enctype) {
>  	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
>  	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
> +	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
> +	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
>  		ctx->initiator_enc_aux =3D
>  			context_v2_alloc_cipher(ctx, "cbc(aes)",
>  						ctx->initiator_seal);
> @@ -531,6 +581,8 @@ gss_import_v2_context(const void *p, const void *end,=
 struct krb5_ctx *ctx,
>  		return context_derive_keys_des3(ctx, gfp_mask);
>  	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
>  	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
> +	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
> +	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
>  		return context_derive_keys_new(ctx, gfp_mask);
>  	default:
>  		return -EINVAL;
> diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/gs=
s_krb5_seal.c
> index 33061417ec97..252bc30e09aa 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_seal.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
> @@ -217,6 +217,8 @@ gss_get_mic_kerberos(struct gss_ctx *gss_ctx, struct =
xdr_buf *text,
>  		return gss_get_mic_v1(ctx, text, token);
>  	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
>  	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
> +	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
> +	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
>  		return gss_get_mic_v2(ctx, text, token);
>  	}
>  }
> diff --git a/net/sunrpc/auth_gss/gss_krb5_unseal.c b/net/sunrpc/auth_gss/=
gss_krb5_unseal.c
> index ba04e3ec970a..58d7b49a6a9a 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_unseal.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_unseal.c
> @@ -221,6 +221,8 @@ gss_verify_mic_kerberos(struct gss_ctx *gss_ctx,
>  		return gss_verify_mic_v1(ctx, message_buffer, read_token);
>  	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
>  	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
> +	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
> +	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
>  		return gss_verify_mic_v2(ctx, message_buffer, read_token);
>  	}
>  }
> diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gs=
s_krb5_wrap.c
> index 5f96e75f9eec..36659ab5bd58 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
> @@ -571,6 +571,8 @@ gss_wrap_kerberos(struct gss_ctx *gctx, int offset,
>  		return gss_wrap_kerberos_v1(kctx, offset, buf, pages);
>  	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
>  	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
> +	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
> +	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
>  		return gss_wrap_kerberos_v2(kctx, offset, buf, pages);
>  	}
>  }
> @@ -590,6 +592,8 @@ gss_unwrap_kerberos(struct gss_ctx *gctx, int offset,
>  					      &gctx->slack, &gctx->align);
>  	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
>  	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
> +	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
> +	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
>  		return gss_unwrap_kerberos_v2(kctx, offset, len, buf,
>  					      &gctx->slack, &gctx->align);
>  	}
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
