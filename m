Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C0D6F3259
	for <lists+linux-nfs@lfdr.de>; Mon,  1 May 2023 16:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjEAOzS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 May 2023 10:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEAOzR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 May 2023 10:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADB11A1;
        Mon,  1 May 2023 07:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19064616C5;
        Mon,  1 May 2023 14:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767C3C433EF;
        Mon,  1 May 2023 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682952915;
        bh=LMNCnluoR559agsFnXvPZ9SN6sw11JaehW9T6y6buoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AA4EZOFT8u0z2Zj3Bsx5vjcXay1GbNz/cgGfx8y6w0FiHcRh/UUVqqVy1VQzsaxzu
         rwHkhBEfEw/8x2EXg+zjs3w3HgTjgl3EPKA49Nzm7+pecKCd3QiOmaYSPWlOGuZYS9
         CxgmQtLPNdUUrFLnQ7XRf8mjFEVOJ8Pw6kgFuDjq/LXzMoOTVxh4cVxaDUoCGGjScU
         5fl3h7z6OstBnFIlqUEyqZeJ7mduwX9oj+C4mu/JwiDy/e2xBNotpCEfZXgMMMcWIT
         +p6xsCzr58NJCsICU/W72wygEQ88sEsvim1TzRkne9KK20nLlx3WJL/HSF6dEMydmM
         jrpvNubEvkKWA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2a8b62cfaceso25580971fa.2;
        Mon, 01 May 2023 07:55:15 -0700 (PDT)
X-Gm-Message-State: AC+VfDyRoQkwpmzkcdMLJgmapSlLJq7YTdNeIUre4Ka7s/Eby0FGnfzm
        VzVTmReXj7ajMSR5F2wezN5JxuqliYJClWyvAws=
X-Google-Smtp-Source: ACHHUZ7E456Wdfjd1gAql77t6dJawKQSCnu2Xn6sXno/J/LxTsK0cVG39WnSin7VtqIGDu3tBLLw6z4I6SpN09qc3rA=
X-Received: by 2002:a2e:9248:0:b0:2a7:b1de:3ff7 with SMTP id
 v8-20020a2e9248000000b002a7b1de3ff7mr3520645ljg.16.1682952913542; Mon, 01 May
 2023 07:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230501140408.2648535-1-ardb@kernel.org> <MW5PR84MB18421BA9A3772DC313D06E5BAB6E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB18421BA9A3772DC313D06E5BAB6E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 1 May 2023 16:55:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFBrPR9geZRszsWsZshuyJE351Zi9a+vGm0LBdZZxQQgw@mail.gmail.com>
Message-ID: <CAMj1kXFBrPR9geZRszsWsZshuyJE351Zi9a+vGm0LBdZZxQQgw@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Avoid relying on crypto API to derive CBC-CTS
 output IV
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 1 May 2023 at 16:40, Elliott, Robert (Servers) <elliott@hpe.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Sent: Monday, May 1, 2023 9:04 AM
> > Subject: [PATCH] SUNRPC: Avoid relying on crypto API to derive CBC-CTS output
> > IV
> >
> ...
> > +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> > @@ -639,6 +639,13 @@ gss_krb5_cts_crypt(struct crypto_sync_skcipher *cipher,
> > struct xdr_buf *buf,
> >
> >       ret = write_bytes_to_xdr_buf(buf, offset, data, len);
> >
> > +     /*
> > +      * CBC-CTS does not define an output IV but RFC 3962 defines it as the
> > +      * penultimate block of ciphertext, so copy that into the IV buffer
> > +      * before returning.
> > +      */
> > +     if (encrypt)
> > +             memcpy(iv, data, crypto_sync_skcipher_ivsize(cipher));
> >  out:
> >       kfree(data);
> >       return ret;
> > --
> > 2.39.2
>
> What about the decrypt (encrypt == 0) case?
>
> That function supports both encrypt and decrypt operations,
> and both of its callers mention this IV expectation:
>
> gss_krb5_aes_encrypt:
>         /* Make sure IV carries forward from any CBC results. */
>         err = gss_krb5_cts_crypt(cipher, buf,
>                                  offset + GSS_KRB5_TOK_HDR_LEN + cbcbytes,
>                                  desc.iv, pages, 1);
> gss_krb5_aes_decrypt:
>         /* Make sure IV carries forward from any CBC results. */
>         ret = gss_krb5_cts_crypt(cipher, &subbuf, cbcbytes, desc.iv, NULL, 0);
>

This is something different: for some reason, this code chooses to
split the input into two parts, and passes the first into plain CBC,
and then passes the rest (which needs ciphertext stealing *) into
CBC-CTS configured with the same key. The net result should be
precisely the same, so I'm not sure why this is implemented like this,
but the consequence of this is that the final CBC ciphertext block
should be passed to the CTS-CBC routine as its input IV, and our CBC
implementations happen to return this via the IV buffer (to support
transparent chaining inside the crypto API implementations)

This patch is about what gss_krb5_cts_crypt() /returns/ to its caller
via desc.iv, which, as I explained, has no semantic significance, but
is covered by RFC 3962 test vectors nonetheless.

* note that the CS3 ciphertext stealing scheme we use in the crypto
API always reorders the final two blocks, even if the input length is
an integral multiple of the block size, so we always need the CTS
logic to take effect.
