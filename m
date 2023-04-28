Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BE56F2163
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Apr 2023 01:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347041AbjD1XsI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 19:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347055AbjD1XsC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 19:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83914C04;
        Fri, 28 Apr 2023 16:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8FE2631AD;
        Fri, 28 Apr 2023 23:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1286AC433D2;
        Fri, 28 Apr 2023 23:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682725601;
        bh=kfZZr6KMfoLR9GKJOF8IGsGbILU6f3g0vJrOdB364gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VIqITLiE5JfV5HMm7a4hnTYSC9E5B9WRpkDFjAtDHgZ9LHeTPCDExX+/RBtIpqLhD
         ytd7NxeGOhbzxK9O3J9nX9nzNS5hPULLNvFdruPZGAAwJh6ioyyS2lN2Y+RAHbmNl1
         yKiuq+FB4UNad21ZQGq8MCl3Zxd+ls06+ICgcEulFXPk3uPUDjaP9AfU3tS1tiS2Ok
         kPS8xiZmenpR3VlrG1cHHr+F4wj3uTph0YjIWWLnj1lQ77mTk8dG02nxPQqwCF6HCR
         Dn+FuRJqAWZC0xgap+G3KFH5cQQrA+00Hbo5I13WzrEEXn4hjI3SilJCqMYryWzQmp
         1Q9xXIwdYRyVg==
Date:   Fri, 28 Apr 2023 16:46:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Scott Mayhew <smayhew@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RPCSEC GSS krb5 KUnit test fails on arm64 with h/w accelerated
 ciphers enabled
Message-ID: <20230428234639.GD3150@sol.localdomain>
References: <ZEBi8ReG9LKLcmW3@aion.usersys.redhat.com>
 <ZEuVcizjPtG96/ST@gondor.apana.org.au>
 <CAMj1kXGOxw2mm8dVNHBg3HfJ7==JVV+vdXaW3iGGKamb4ZAg-g@mail.gmail.com>
 <F46EA3E0-1338-4E92-8CCF-DD869BD573BE@oracle.com>
 <CAMj1kXE29dMSgjkDPUXf0LFnxyrMeSO5NxG8fjYCuG=HJJ7wiA@mail.gmail.com>
 <870429E7-8202-405B-96F7-46A11B41EF05@oracle.com>
 <CAMj1kXGrrRj6b6RR4orKNykjjxyvd4Xe+8eOu-nY9jT=25_21A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGrrRj6b6RR4orKNykjjxyvd4Xe+8eOu-nY9jT=25_21A@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 28, 2023 at 05:48:30PM +0100, Ard Biesheuvel wrote:
> On Fri, 28 Apr 2023 at 17:18, Chuck Lever III <chuck.lever@oracle.com> wrote:
> >
> >
> >
> > > On Apr 28, 2023, at 12:09 PM, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Fri, 28 Apr 2023 at 13:59, Chuck Lever III <chuck.lever@oracle.com> wrote:
> > >>
> > >>
> > >>
> > >>> On Apr 28, 2023, at 5:57 AM, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>>
> > >>> On Fri, 28 Apr 2023 at 10:44, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > >>>>
> > >>>> Scott Mayhew <smayhew@redhat.com> wrote:
> > >>>>>
> > >>>>> diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
> > >>>>> index 0e834a2c062c..477605fad76b 100644
> > >>>>> --- a/arch/arm64/crypto/aes-modes.S
> > >>>>> +++ b/arch/arm64/crypto/aes-modes.S
> > >>>>> @@ -268,6 +268,7 @@ AES_FUNC_START(aes_cbc_cts_encrypt)
> > >>>>>      add             x4, x0, x4
> > >>>>>      st1             {v0.16b}, [x4]                  /* overlapping stores */
> > >>>>>      st1             {v1.16b}, [x0]
> > >>>>> +       st1             {v1.16b}, [x5]
> > >>>>>      ret
> > >>>>> AES_FUNC_END(aes_cbc_cts_encrypt)
> > >>>>>
> > >>>>> But I don't know if that change is at all correct! (I've never even
> > >>>>> looked at arm64 asm before).  If someone who's knowledgeable about this
> > >>>>> code could chime in, I'd appreciate it.
> > >>>>
> > >>>> Ard, could you please take a look at this?
> > >>>>
> > >>>
> > >>> The issue seems to be that the caller expects iv_out to have been
> > >>> populated even when doing ciphertext stealing.
> > >>>
> > >>> This is meaningless, because the output IV can only be used to chain
> > >>> additional encrypted data if the split is at a block boundary. The
> > >>> ciphertext stealing fundamentally terminates the encryption, and
> > >>> produces a block of ciphertext that is shorter than the block size, so
> > >>> what the output IV should be is actually unspecified.
> > >>>
> > >>> IOW, test cases having plain/ciphertext vectors whose size is not a
> > >>> multiple of the cipher block size should not specify an expected value
> > >>> for the output IV.
> > >>
> > >> The test cases are extracted from RFC 3962 Appendix B. The
> > >> standard clearly expects there to be a non-zero next IV for
> > >> plaintext sizes that are not block-aligned.
> > >>
> > >
> > > OK, so this is the Kerberos V specific spec on how to use AES in CBC
> > > mode, which appears to describe how to chain multiple CBC encryptions
> > > together.
> > >
> > > CBC-CTS itself does not define this: the IV is an input only, and the
> > > reason we happen to return the IV is because a single CBC operation
> > > may be broken up into several ones, which can only be done on block
> > > boundaries. This is why CBC-CTS itself passes all its tests: a single
> > > CBC-CTS encryption only performs ciphertext stealing at the very end,
> > > and the next IV is never used in that case. (This is why the CTS mode
> > > tests in crypto/testmgr.h don't have iv_out vectors)
> > >
> > > Note that RFC3962 defines that the penultimate block of CBC-CTS
> > > ciphertext is used as the next IV. CBC returns the last ciphertext
> > > block as the output IV. It is a happy coincidence that the generic CTS
> > > template encapsulates CBC in a way where its output IV ends up in the
> > > right place.
> > >
> > >> Also, these test cases pass on other hardware platforms.
> > >>
> > >
> > > Fair enough.
> > >
> > > I am not opposed to fixing this, but given that it is the RFC3962 spec
> > > that defines that the next IV is the penultimate full block of the
> > > previous CBC-CTS ciphertext, we might consider doing the memcpy() in
> > > the Kerberos code not in the CBC-CTS implementations.
> >
> > Interesting thought. I'm all about proper layering, so I think this
> > is worth considering. Can you send an RFC patch?
> >
> 
> I'm not that familiar with kunit so this is just an off hand
> suggestion, but I imagine something like the below would suffice
> 
> --- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> @@ -639,6 +639,13 @@ gss_krb5_cts_crypt(struct crypto_sync_skcipher
> *cipher, struct xdr_buf *buf,
> 
>         ret = write_bytes_to_xdr_buf(buf, offset, data, len);
> 
> +       /*
> +        * CBC-CTS does not define an output IV but RFC 3962 defines it as the
> +        * penultimate block of ciphertext, so copy that into the IV buffer
> +        * before returning.
> +        */
> +       if (encrypt)
> +               memcpy(iv, data, crypto_sync_skcipher_ivsize(cipher));

The whole "update the IV" thing that the crypto API does for some algorithms is
very weird and nonstandard, and most algorithms don't implement it.  So I'd
definitely support handling this in the caller here.

- Eric
