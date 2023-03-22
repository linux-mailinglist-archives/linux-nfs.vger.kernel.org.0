Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6F56C5893
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Mar 2023 22:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjCVVMQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Mar 2023 17:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCVVMF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Mar 2023 17:12:05 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B5223D9A
        for <linux-nfs@vger.kernel.org>; Wed, 22 Mar 2023 14:12:03 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id n2so24496328qtp.0
        for <linux-nfs@vger.kernel.org>; Wed, 22 Mar 2023 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679519523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAOA5hYECSycWgSuHCfwTnZkOoH3Zgrtw49p26bpkXk=;
        b=ISTFR65TqmRUC60FhV+0sv7Rg8OjDCdgOYDNZ6ZVTs8kaHmz0TKPoVtWN69v0f88dA
         4m8bqKK3HDxPQf5sUTilb/kLBYJsw/5LfmyIUJEzqG7R+UYKJy130EwXAnotEBjqxeTx
         sha5uLWg7WVWVj/aD9U9lQLJ5+Vot5xF1CZTsyptu2ZVbHPV4DomJFC74OZ4bG0Y1R0k
         j53OkxWrke+Jb2AWKCnRePDPAmmekV9sAO4AwvDbQbn93EcGJuCejC9OBmMbmh6UTeiW
         IPdHukIxl8jERCk1SXdVh3rPLbbm995wNl9u4I68J5gGPdstlL6+UxyoTOWrL/k2IfrV
         dmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679519523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAOA5hYECSycWgSuHCfwTnZkOoH3Zgrtw49p26bpkXk=;
        b=7bKSTQ2OSCxh1bofJd2kjo/X9sTFzNlJXs8FYk+a/D1V5vOfoRlyyR9My1wPi62mqR
         8PULn9GKR1J163rQwWFhwqX68YLl+TW/5snv4FlNwLljOEDF+MppUhfwX0yL1i2Vw0if
         TkzrAF4a4KSN6nK/noSDdVheF75aHGy9UbKWad5Ahpfcp7GxunHFNBFuYUcQFlpS0TZH
         gnnYfheCWfBQYI+x/fggWYCATJyyfo+AnU5K9oYUEBQYLxnlFMFOqkqSPc0uromWqa1b
         j5E6LJIey0YfY6NflwBlIB+IIe/aT5bIwfibsReeaQCHBfR6p/IgAZO+zvX+ge8G2tbk
         WcrQ==
X-Gm-Message-State: AO0yUKXWHt233NCF6C7WPdpNOuJGHONo8PPf5lxdDHyGgnMxlvlsBHAB
        FbiksFWwHeFcRYsz0LLPc5c4GqjTUBROCRiOQCE=
X-Google-Smtp-Source: AK7set+/SQ3aREpczekNiVBNSUs3Yhyj3uDoKkq/XiS7w3Pt38YkVkhc4Rpiuk/hBWWXzZJYbawLdyCB7AU2RuoP6CU=
X-Received: by 2002:a05:622a:1aa3:b0:3df:f0cf:97e with SMTP id
 s35-20020a05622a1aa300b003dff0cf097emr1871936qtc.13.1679519522881; Wed, 22
 Mar 2023 14:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <167951169462.22263.13708891630674211649.stgit@morisot.1015granger.net>
 <CAFX2JfnA=qk+=YGFjaE8nrmW=yUwthvWaeCN3X4k0065eXExuA@mail.gmail.com> <08CC5855-A1A1-4716-BC8A-2BC55E8B8B34@oracle.com>
In-Reply-To: <08CC5855-A1A1-4716-BC8A-2BC55E8B8B34@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 22 Mar 2023 17:11:47 -0400
Message-ID: <CAFX2JfnPpSfSa5K1GnS+y98QPfyy+9iBDtuCiKShxbPTw7W6TQ@mail.gmail.com>
Subject: Re: [PATCH v1] SUNRPC: Fix a crash in gss_krb5_checksum()
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

On Wed, Mar 22, 2023 at 4:59=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Mar 22, 2023, at 4:55 PM, Anna Schumaker <schumaker.anna@gmail.com> =
wrote:
> >
> > On Wed, Mar 22, 2023 at 3:17=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> Anna says:
> >>> KASAN reports [...] a slab-out-of-bounds in gss_krb5_checksum(),
> >>> and it can cause my client to panic when running cthon basic
> >>> tests with krb5p.
> >>
> >>> Running faddr2line gives me:
> >>>
> >>> gss_krb5_checksum+0x4b6/0x630:
> >>> ahash_request_free at
> >>> /home/anna/Programs/linux-nfs.git/./include/crypto/hash.h:619
> >>> (inlined by) gss_krb5_checksum at
> >>> /home/anna/Programs/linux-nfs.git/net/sunrpc/auth_gss/gss_krb5_crypto=
.c:358
> >>
> >> My diagnosis is that the memcpy() at the end of gss_krb5_checksum()
> >> reads past the end of the buffer containing the checksum data
> >> because the callers have ignored gss_krb5_checksum()'s API contract:
> >>
> >> * Caller provides the truncation length of the output token (h) in
> >> * cksumout.len.
> >>
> >> Instead they provide the fixed length of the hmac buffer. This
> >> length happens to be larger than the value returned by
> >> crypto_ahash_digestsize().
> >>
> >> Change these errant callers to work like krb5_etm_{en,de}crypt().
> >> As a defensive measure, bound the length of the byte copy at the
> >> end of gss_krb5_checksum().
> >>
> >> Kunit sez:
> >> Testing complete. Ran 68 tests: passed: 68
> >> Elapsed time: 81.680s total, 5.875s configuring, 75.610s building, 0.1=
03s running
> >>
> >> Reported-by: Anna Schumaker <schumaker.anna@gmail.com>
> >> Fixes: 8270dbfcebea ("SUNRPC: Obscure Kerberos integrity keys")
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >
> > This patch fixed the issue for me, thanks! Are you going to submit it
> > with a future 6.3-rc pull request, or should I?
>
> I'll queue it in nfsd-fixes.

Sounds good. Thanks!

Anna
>
>
> > Anna
> >
> >> ---
> >> net/sunrpc/auth_gss/gss_krb5_crypto.c |   10 +++++-----
> >> 1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_g=
ss/gss_krb5_crypto.c
> >> index 6c7c52eeed4f..212c5d57465a 100644
> >> --- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
> >> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> >> @@ -353,7 +353,9 @@ gss_krb5_checksum(struct crypto_ahash *tfm, char *=
header, int hdrlen,
> >>        err =3D crypto_ahash_final(req);
> >>        if (err)
> >>                goto out_free_ahash;
> >> -       memcpy(cksumout->data, checksumdata, cksumout->len);
> >> +
> >> +       memcpy(cksumout->data, checksumdata,
> >> +              min_t(int, cksumout->len, crypto_ahash_digestsize(tfm))=
);
> >>
> >> out_free_ahash:
> >>        ahash_request_free(req);
> >> @@ -809,8 +811,7 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 of=
fset,
> >>        buf->tail[0].iov_len +=3D GSS_KRB5_TOK_HDR_LEN;
> >>        buf->len +=3D GSS_KRB5_TOK_HDR_LEN;
> >>
> >> -       /* Do the HMAC */
> >> -       hmac.len =3D GSS_KRB5_MAX_CKSUM_LEN;
> >> +       hmac.len =3D kctx->gk5e->cksumlength;
> >>        hmac.data =3D buf->tail[0].iov_base + buf->tail[0].iov_len;
> >>
> >>        /*
> >> @@ -873,8 +874,7 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 of=
fset, u32 len,
> >>        if (ret)
> >>                goto out_err;
> >>
> >> -       /* Calculate our hmac over the plaintext data */
> >> -       our_hmac_obj.len =3D sizeof(our_hmac);
> >> +       our_hmac_obj.len =3D kctx->gk5e->cksumlength;
> >>        our_hmac_obj.data =3D our_hmac;
> >>        ret =3D gss_krb5_checksum(ahash, NULL, 0, &subbuf, 0, &our_hmac=
_obj);
> >>        if (ret)
>
> --
> Chuck Lever
>
>
