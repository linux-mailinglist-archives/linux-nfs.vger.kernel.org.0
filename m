Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36AD6C5831
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Mar 2023 21:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCVUzu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Mar 2023 16:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCVUzt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Mar 2023 16:55:49 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BD11A493
        for <linux-nfs@vger.kernel.org>; Wed, 22 Mar 2023 13:55:48 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s12so24344112qtq.11
        for <linux-nfs@vger.kernel.org>; Wed, 22 Mar 2023 13:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679518547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Cac+pFAETzZ3cxARMNRj0j/vclxG6xVRSYG9dlMH3M=;
        b=C7AAJ8jVefB3q82bb7KQaEuYM+cUi+EQzIgG3U1Reb7koFEs288kocoTFwuWNbIosK
         JxLiZoolox5bxV49T0LvAptpqQyCX+WGVUlCPqHBJlKvHr469oARm2UUFOD5C5oAL713
         H5aAYW0IhYYo6wD1MbCcRJfdzLLERaWkK7mylfEJIToOmjqxmFDDBUCIX2zFcd+w2i1a
         pGmUpqDPY+c1lMah3t8+IVRUR21g86009VIp2cfFaPXUDixYwFqUrjeO5UNncj1eBrLy
         vmqTVq80E6O7Y8RpIvnKgigbMsPQ32Hg9YAKLKaMiwXuDRvreY8xvhkEL3+cGhUS5aji
         YLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679518547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Cac+pFAETzZ3cxARMNRj0j/vclxG6xVRSYG9dlMH3M=;
        b=aezJBH63J17kkuWTzC9KaXy0yrPeCsux5BY/VaXh4FXdDMUtuLehjrWIRNka0Nq17C
         tFjhZI6mi1Tm5n5EE15z1q8mVBvQ7WSNl+RvVkeyHbF09nZULW0bpOKP90p+I8OODK/B
         OZTvZkAiF1mN2tC9tWslMvdVFm6B05MnewyYCWgPScsgOg2WGgRNuTJyMFnufKvx87pf
         Dk9Rq2mfmW/i0gdUIJjMdzKDrQHN1Lf8LsMMCt7Z8Vra9Cy0FEQjm0OVs9aOQ6QONJQe
         RqVxfIKNKrnxh4jkfpTco0NBeKKCgVhqYU+Zm06Jx/mdHIBm4Nkz0DLvYVOVL5ybIHvQ
         GJeA==
X-Gm-Message-State: AO0yUKWB0Zz8LW05uZDkcwRyNwlHKCDg5qqe6IsYcyLcJa+Hb8U+01GB
        jKtuWLZ6HVRShrh/bS9f20Xv+lC8grfzylt5/3PxzNrqcd4=
X-Google-Smtp-Source: AK7set/h5jeAHefLOMrTISiKosMsmpt6vVqNE6jmf5m+EbV3aFZ0wPSJUrFGBnr4+YUvpR3U8jCtdQ6W0aeDnbqrRcs=
X-Received: by 2002:ac8:7e8d:0:b0:3bf:d313:40e with SMTP id
 w13-20020ac87e8d000000b003bfd313040emr1999761qtj.13.1679518547420; Wed, 22
 Mar 2023 13:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <167951169462.22263.13708891630674211649.stgit@morisot.1015granger.net>
In-Reply-To: <167951169462.22263.13708891630674211649.stgit@morisot.1015granger.net>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 22 Mar 2023 16:55:31 -0400
Message-ID: <CAFX2JfnA=qk+=YGFjaE8nrmW=yUwthvWaeCN3X4k0065eXExuA@mail.gmail.com>
Subject: Re: [PATCH v1] SUNRPC: Fix a crash in gss_krb5_checksum()
To:     Chuck Lever <cel@kernel.org>
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 22, 2023 at 3:17=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Anna says:
> > KASAN reports [...] a slab-out-of-bounds in gss_krb5_checksum(),
> > and it can cause my client to panic when running cthon basic
> > tests with krb5p.
>
> > Running faddr2line gives me:
> >
> > gss_krb5_checksum+0x4b6/0x630:
> > ahash_request_free at
> > /home/anna/Programs/linux-nfs.git/./include/crypto/hash.h:619
> > (inlined by) gss_krb5_checksum at
> > /home/anna/Programs/linux-nfs.git/net/sunrpc/auth_gss/gss_krb5_crypto.c=
:358
>
> My diagnosis is that the memcpy() at the end of gss_krb5_checksum()
> reads past the end of the buffer containing the checksum data
> because the callers have ignored gss_krb5_checksum()'s API contract:
>
>  * Caller provides the truncation length of the output token (h) in
>  * cksumout.len.
>
> Instead they provide the fixed length of the hmac buffer. This
> length happens to be larger than the value returned by
> crypto_ahash_digestsize().
>
> Change these errant callers to work like krb5_etm_{en,de}crypt().
> As a defensive measure, bound the length of the byte copy at the
> end of gss_krb5_checksum().
>
> Kunit sez:
> Testing complete. Ran 68 tests: passed: 68
> Elapsed time: 81.680s total, 5.875s configuring, 75.610s building, 0.103s=
 running
>
> Reported-by: Anna Schumaker <schumaker.anna@gmail.com>
> Fixes: 8270dbfcebea ("SUNRPC: Obscure Kerberos integrity keys")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

This patch fixed the issue for me, thanks! Are you going to submit it
with a future 6.3-rc pull request, or should I?

Anna

> ---
>  net/sunrpc/auth_gss/gss_krb5_crypto.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/=
gss_krb5_crypto.c
> index 6c7c52eeed4f..212c5d57465a 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> @@ -353,7 +353,9 @@ gss_krb5_checksum(struct crypto_ahash *tfm, char *hea=
der, int hdrlen,
>         err =3D crypto_ahash_final(req);
>         if (err)
>                 goto out_free_ahash;
> -       memcpy(cksumout->data, checksumdata, cksumout->len);
> +
> +       memcpy(cksumout->data, checksumdata,
> +              min_t(int, cksumout->len, crypto_ahash_digestsize(tfm)));
>
>  out_free_ahash:
>         ahash_request_free(req);
> @@ -809,8 +811,7 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offse=
t,
>         buf->tail[0].iov_len +=3D GSS_KRB5_TOK_HDR_LEN;
>         buf->len +=3D GSS_KRB5_TOK_HDR_LEN;
>
> -       /* Do the HMAC */
> -       hmac.len =3D GSS_KRB5_MAX_CKSUM_LEN;
> +       hmac.len =3D kctx->gk5e->cksumlength;
>         hmac.data =3D buf->tail[0].iov_base + buf->tail[0].iov_len;
>
>         /*
> @@ -873,8 +874,7 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offse=
t, u32 len,
>         if (ret)
>                 goto out_err;
>
> -       /* Calculate our hmac over the plaintext data */
> -       our_hmac_obj.len =3D sizeof(our_hmac);
> +       our_hmac_obj.len =3D kctx->gk5e->cksumlength;
>         our_hmac_obj.data =3D our_hmac;
>         ret =3D gss_krb5_checksum(ahash, NULL, 0, &subbuf, 0, &our_hmac_o=
bj);
>         if (ret)
>
>
