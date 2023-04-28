Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC786F14CB
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbjD1J7X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 05:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346014AbjD1J7F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 05:59:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80F26A4F;
        Fri, 28 Apr 2023 02:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68B1B6428A;
        Fri, 28 Apr 2023 09:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A32C4339C;
        Fri, 28 Apr 2023 09:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682675844;
        bh=M/pAXMYOk5Udpz1kEDYt2VEG95hOJ5W2yFdUzgAeJqg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OmGsYSEotFUtGu8b99vp6CGKP0d6RcISjTHZLlVmEZs3/H7M8hClpSUn7w4ZYJyyj
         8jrGAXsoazQA0pFMC1BDdcuSN9QaBuL37FftEmXMR/sbEwDG/GdzPb0upMEiCcNV6i
         VLQ0j7Rx7frR8ui/NV3EyHZR7f5Qm5TNPFQRU0XAOencpgN043WyzFdzAE1ICjXrct
         NLMzItQQ3VR+KBh5JHQAEF2tJpjto+RqSyklOwaukuG28HQP/i0wJDSbhZ7wPBzmSx
         mRsgRrDgBtKeusKdnxx3W8LiCdTDqmoYaX0iGR0EpklIJ7Tn6V6Zvk84m6h4nYjp2h
         a8fB1F08vktrg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2a8aea0c7dcso92443201fa.2;
        Fri, 28 Apr 2023 02:57:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDzvYwetGJY67GkZX/8qQjenU/LHxWAU+e8sG6Awjr6hEkrF/wLa
        vL/0kN1gPOfNvy+MBDgj/pHzSXUwjvQGUH/ueVM=
X-Google-Smtp-Source: ACHHUZ7QGt7fOiiwO/OqFnfXzRlCEKwzWXQyYc+yZ6wejlVL8fRisGNBn9srVRtDdkZW0VfGjTqssnkLLN0bSY+4moM=
X-Received: by 2002:a2e:9658:0:b0:2a8:d021:4121 with SMTP id
 z24-20020a2e9658000000b002a8d0214121mr1466652ljh.26.1682675842804; Fri, 28
 Apr 2023 02:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <ZEBi8ReG9LKLcmW3@aion.usersys.redhat.com> <ZEuVcizjPtG96/ST@gondor.apana.org.au>
In-Reply-To: <ZEuVcizjPtG96/ST@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Apr 2023 10:57:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGOxw2mm8dVNHBg3HfJ7==JVV+vdXaW3iGGKamb4ZAg-g@mail.gmail.com>
Message-ID: <CAMj1kXGOxw2mm8dVNHBg3HfJ7==JVV+vdXaW3iGGKamb4ZAg-g@mail.gmail.com>
Subject: Re: RPCSEC GSS krb5 KUnit test fails on arm64 with h/w accelerated
 ciphers enabled
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Scott Mayhew <smayhew@redhat.com>, linux-crypto@vger.kernel.org,
        chuck.lever@oracle.com, linux-nfs@vger.kernel.org
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

On Fri, 28 Apr 2023 at 10:44, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Scott Mayhew <smayhew@redhat.com> wrote:
> >
> > diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
> > index 0e834a2c062c..477605fad76b 100644
> > --- a/arch/arm64/crypto/aes-modes.S
> > +++ b/arch/arm64/crypto/aes-modes.S
> > @@ -268,6 +268,7 @@ AES_FUNC_START(aes_cbc_cts_encrypt)
> >        add             x4, x0, x4
> >        st1             {v0.16b}, [x4]                  /* overlapping stores */
> >        st1             {v1.16b}, [x0]
> > +       st1             {v1.16b}, [x5]
> >        ret
> > AES_FUNC_END(aes_cbc_cts_encrypt)
> >
> > But I don't know if that change is at all correct! (I've never even
> > looked at arm64 asm before).  If someone who's knowledgeable about this
> > code could chime in, I'd appreciate it.
>
> Ard, could you please take a look at this?
>

The issue seems to be that the caller expects iv_out to have been
populated even when doing ciphertext stealing.

This is meaningless, because the output IV can only be used to chain
additional encrypted data if the split is at a block boundary. The
ciphertext stealing fundamentally terminates the encryption, and
produces a block of ciphertext that is shorter than the block size, so
what the output IV should be is actually unspecified.

IOW, test cases having plain/ciphertext vectors whose size is not a
multiple of the cipher block size should not specify an expected value
for the output IV.
