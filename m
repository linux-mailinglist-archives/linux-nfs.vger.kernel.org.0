Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455986F1C4F
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346204AbjD1QKH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345696AbjD1QKD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 12:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58972122;
        Fri, 28 Apr 2023 09:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F0A764452;
        Fri, 28 Apr 2023 16:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A4BC4339E;
        Fri, 28 Apr 2023 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682698200;
        bh=007b4S/NC/47+Xn6WdUbKm6mcGQCZUOKnNFXK/7j2dA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V51PKVs499KBlRCIQGP0Zp14i4tJ7b6hbjDUklGdc7INC3Dr49F6zuCOe1NaqRFEv
         BVdoHyqh7lIcHKhH0u0pgvuuGlymVA8n13S+4g1MD3u4U0re1pMFqJyCiXPIyxhPrw
         SZhT9SgQh162rOUdFTJ7SYT8UneRph8jLi44cCkizFvJbMhRK8nckpqiqFBZeAm1kC
         AFKVWkHfMXSvgKc4qCx+B5OMSHL6N/itzgoo/2U0BDj9mEtxA0g4e0uiS8MuGgZBTs
         9MCruYNm70RsqmsQRK2PO4JIRFJkpa0dA/fBjBxgxr8qJv/9+8y/gYIetV7N8v5M84
         MhHvQjABfxmdw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4efd6e26585so72618e87.1;
        Fri, 28 Apr 2023 09:10:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDz9mm62zifXknrN/tU0vITExhVuWZoOf0PzFHmZXsD/On8HJUna
        3lEPK+yvLR2BAUMvMPpAX7+HZEoMJ5rQfk/4UbY=
X-Google-Smtp-Source: ACHHUZ51xtShX/u85uhte2sZHEVjDbx+Nb34GOMfXZnEbvmyIwXVwYIujSKiLqkoz58oj5lbOkyOVbun13HBvrum94U=
X-Received: by 2002:ac2:5284:0:b0:4ed:b842:3a99 with SMTP id
 q4-20020ac25284000000b004edb8423a99mr2075509lfm.59.1682698198447; Fri, 28 Apr
 2023 09:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <ZEBi8ReG9LKLcmW3@aion.usersys.redhat.com> <ZEuVcizjPtG96/ST@gondor.apana.org.au>
 <CAMj1kXGOxw2mm8dVNHBg3HfJ7==JVV+vdXaW3iGGKamb4ZAg-g@mail.gmail.com> <F46EA3E0-1338-4E92-8CCF-DD869BD573BE@oracle.com>
In-Reply-To: <F46EA3E0-1338-4E92-8CCF-DD869BD573BE@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Apr 2023 17:09:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE29dMSgjkDPUXf0LFnxyrMeSO5NxG8fjYCuG=HJJ7wiA@mail.gmail.com>
Message-ID: <CAMj1kXE29dMSgjkDPUXf0LFnxyrMeSO5NxG8fjYCuG=HJJ7wiA@mail.gmail.com>
Subject: Re: RPCSEC GSS krb5 KUnit test fails on arm64 with h/w accelerated
 ciphers enabled
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Scott Mayhew <smayhew@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 28 Apr 2023 at 13:59, Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Apr 28, 2023, at 5:57 AM, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 28 Apr 2023 at 10:44, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >>
> >> Scott Mayhew <smayhew@redhat.com> wrote:
> >>>
> >>> diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
> >>> index 0e834a2c062c..477605fad76b 100644
> >>> --- a/arch/arm64/crypto/aes-modes.S
> >>> +++ b/arch/arm64/crypto/aes-modes.S
> >>> @@ -268,6 +268,7 @@ AES_FUNC_START(aes_cbc_cts_encrypt)
> >>>       add             x4, x0, x4
> >>>       st1             {v0.16b}, [x4]                  /* overlapping stores */
> >>>       st1             {v1.16b}, [x0]
> >>> +       st1             {v1.16b}, [x5]
> >>>       ret
> >>> AES_FUNC_END(aes_cbc_cts_encrypt)
> >>>
> >>> But I don't know if that change is at all correct! (I've never even
> >>> looked at arm64 asm before).  If someone who's knowledgeable about this
> >>> code could chime in, I'd appreciate it.
> >>
> >> Ard, could you please take a look at this?
> >>
> >
> > The issue seems to be that the caller expects iv_out to have been
> > populated even when doing ciphertext stealing.
> >
> > This is meaningless, because the output IV can only be used to chain
> > additional encrypted data if the split is at a block boundary. The
> > ciphertext stealing fundamentally terminates the encryption, and
> > produces a block of ciphertext that is shorter than the block size, so
> > what the output IV should be is actually unspecified.
> >
> > IOW, test cases having plain/ciphertext vectors whose size is not a
> > multiple of the cipher block size should not specify an expected value
> > for the output IV.
>
> The test cases are extracted from RFC 3962 Appendix B. The
> standard clearly expects there to be a non-zero next IV for
> plaintext sizes that are not block-aligned.
>

OK, so this is the Kerberos V specific spec on how to use AES in CBC
mode, which appears to describe how to chain multiple CBC encryptions
together.

CBC-CTS itself does not define this: the IV is an input only, and the
reason we happen to return the IV is because a single CBC operation
may be broken up into several ones, which can only be done on block
boundaries. This is why CBC-CTS itself passes all its tests: a single
CBC-CTS encryption only performs ciphertext stealing at the very end,
and the next IV is never used in that case. (This is why the CTS mode
tests in crypto/testmgr.h don't have iv_out vectors)

Note that RFC3962 defines that the penultimate block of CBC-CTS
ciphertext is used as the next IV. CBC returns the last ciphertext
block as the output IV. It is a happy coincidence that the generic CTS
template encapsulates CBC in a way where its output IV ends up in the
right place.

> Also, these test cases pass on other hardware platforms.
>

Fair enough.

I am not opposed to fixing this, but given that it is the RFC3962 spec
that defines that the next IV is the penultimate full block of the
previous CBC-CTS ciphertext, we might consider doing the memcpy() in
the Kerberos code not in the CBC-CTS implementations. (The 32-bit ARM
code will be broken in the same way, and potentially other
implementations as well)
