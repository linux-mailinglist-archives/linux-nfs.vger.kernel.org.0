Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361F46F1CDB
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 18:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbjD1Qss (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 12:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbjD1Qsp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 12:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF9859EB;
        Fri, 28 Apr 2023 09:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 563B46448D;
        Fri, 28 Apr 2023 16:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B3FC4339C;
        Fri, 28 Apr 2023 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682700523;
        bh=NM1HGB9hIAOYKYgmDPMV4Uig2mHa6gKfSXw06nhZKCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CPUt/xXBLNJUVLorucl3mTS8OKqnYTwKqQpnjhCTrEJZx4czU3qhnRfEqKnheojFU
         jucCsdV66c2awS9S4ECbhYyWQFU0tTFRSB9XijSGfiQk3N8b18z0Y3BAWRYVAJtm+r
         24GVrOYKNQmKZhYYCHRnjVFiJBXoU0OB3EaceBbArxY+u8r4buocboOZpOBhRErjnl
         M+h3jlbS4jkIpLgBcThR1Je/uNLZOk56sBFoWhcnd+xN2yBU72QpHFpiS0E5WBjJA3
         jsarDTbL2DfEqA+THaKMLCg/4TqvsOtIgxGZDSQn3HpgUTs91WMa1QwLEsTXJkueaZ
         hSDbcqUmNYzsw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4ec8148f73eso132857e87.1;
        Fri, 28 Apr 2023 09:48:43 -0700 (PDT)
X-Gm-Message-State: AC+VfDxs+Ie6wBIRIjVye3ByGl2upKktAcsRnid51pvs5fniNwJwz+dM
        zLNpTHkqHC5EnaBa0UrFfvsiE9KSbLyO+voJQik=
X-Google-Smtp-Source: ACHHUZ7QpJrrg4tdQmT5OWuc+/ZerPNQl4zxzAoEILVlZ/SIQLHOSh69FaYulj+Nhhs1I0uquHB4Z9ep4bsi3g7sqOI=
X-Received: by 2002:a19:f716:0:b0:4e9:5e28:f1c9 with SMTP id
 z22-20020a19f716000000b004e95e28f1c9mr1932404lfe.36.1682700521763; Fri, 28
 Apr 2023 09:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <ZEBi8ReG9LKLcmW3@aion.usersys.redhat.com> <ZEuVcizjPtG96/ST@gondor.apana.org.au>
 <CAMj1kXGOxw2mm8dVNHBg3HfJ7==JVV+vdXaW3iGGKamb4ZAg-g@mail.gmail.com>
 <F46EA3E0-1338-4E92-8CCF-DD869BD573BE@oracle.com> <CAMj1kXE29dMSgjkDPUXf0LFnxyrMeSO5NxG8fjYCuG=HJJ7wiA@mail.gmail.com>
 <870429E7-8202-405B-96F7-46A11B41EF05@oracle.com>
In-Reply-To: <870429E7-8202-405B-96F7-46A11B41EF05@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Apr 2023 17:48:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGrrRj6b6RR4orKNykjjxyvd4Xe+8eOu-nY9jT=25_21A@mail.gmail.com>
Message-ID: <CAMj1kXGrrRj6b6RR4orKNykjjxyvd4Xe+8eOu-nY9jT=25_21A@mail.gmail.com>
Subject: Re: RPCSEC GSS krb5 KUnit test fails on arm64 with h/w accelerated
 ciphers enabled
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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

On Fri, 28 Apr 2023 at 17:18, Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Apr 28, 2023, at 12:09 PM, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 28 Apr 2023 at 13:59, Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Apr 28, 2023, at 5:57 AM, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>
> >>> On Fri, 28 Apr 2023 at 10:44, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >>>>
> >>>> Scott Mayhew <smayhew@redhat.com> wrote:
> >>>>>
> >>>>> diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
> >>>>> index 0e834a2c062c..477605fad76b 100644
> >>>>> --- a/arch/arm64/crypto/aes-modes.S
> >>>>> +++ b/arch/arm64/crypto/aes-modes.S
> >>>>> @@ -268,6 +268,7 @@ AES_FUNC_START(aes_cbc_cts_encrypt)
> >>>>>      add             x4, x0, x4
> >>>>>      st1             {v0.16b}, [x4]                  /* overlapping stores */
> >>>>>      st1             {v1.16b}, [x0]
> >>>>> +       st1             {v1.16b}, [x5]
> >>>>>      ret
> >>>>> AES_FUNC_END(aes_cbc_cts_encrypt)
> >>>>>
> >>>>> But I don't know if that change is at all correct! (I've never even
> >>>>> looked at arm64 asm before).  If someone who's knowledgeable about this
> >>>>> code could chime in, I'd appreciate it.
> >>>>
> >>>> Ard, could you please take a look at this?
> >>>>
> >>>
> >>> The issue seems to be that the caller expects iv_out to have been
> >>> populated even when doing ciphertext stealing.
> >>>
> >>> This is meaningless, because the output IV can only be used to chain
> >>> additional encrypted data if the split is at a block boundary. The
> >>> ciphertext stealing fundamentally terminates the encryption, and
> >>> produces a block of ciphertext that is shorter than the block size, so
> >>> what the output IV should be is actually unspecified.
> >>>
> >>> IOW, test cases having plain/ciphertext vectors whose size is not a
> >>> multiple of the cipher block size should not specify an expected value
> >>> for the output IV.
> >>
> >> The test cases are extracted from RFC 3962 Appendix B. The
> >> standard clearly expects there to be a non-zero next IV for
> >> plaintext sizes that are not block-aligned.
> >>
> >
> > OK, so this is the Kerberos V specific spec on how to use AES in CBC
> > mode, which appears to describe how to chain multiple CBC encryptions
> > together.
> >
> > CBC-CTS itself does not define this: the IV is an input only, and the
> > reason we happen to return the IV is because a single CBC operation
> > may be broken up into several ones, which can only be done on block
> > boundaries. This is why CBC-CTS itself passes all its tests: a single
> > CBC-CTS encryption only performs ciphertext stealing at the very end,
> > and the next IV is never used in that case. (This is why the CTS mode
> > tests in crypto/testmgr.h don't have iv_out vectors)
> >
> > Note that RFC3962 defines that the penultimate block of CBC-CTS
> > ciphertext is used as the next IV. CBC returns the last ciphertext
> > block as the output IV. It is a happy coincidence that the generic CTS
> > template encapsulates CBC in a way where its output IV ends up in the
> > right place.
> >
> >> Also, these test cases pass on other hardware platforms.
> >>
> >
> > Fair enough.
> >
> > I am not opposed to fixing this, but given that it is the RFC3962 spec
> > that defines that the next IV is the penultimate full block of the
> > previous CBC-CTS ciphertext, we might consider doing the memcpy() in
> > the Kerberos code not in the CBC-CTS implementations.
>
> Interesting thought. I'm all about proper layering, so I think this
> is worth considering. Can you send an RFC patch?
>

I'm not that familiar with kunit so this is just an off hand
suggestion, but I imagine something like the below would suffice

--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -639,6 +639,13 @@ gss_krb5_cts_crypt(struct crypto_sync_skcipher
*cipher, struct xdr_buf *buf,

        ret = write_bytes_to_xdr_buf(buf, offset, data, len);

+       /*
+        * CBC-CTS does not define an output IV but RFC 3962 defines it as the
+        * penultimate block of ciphertext, so copy that into the IV buffer
+        * before returning.
+        */
+       if (encrypt)
+               memcpy(iv, data, crypto_sync_skcipher_ivsize(cipher));
 out:
        kfree(data);
        return ret;
