Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEA34ED110
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 02:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352168AbiCaAyN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 20:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352176AbiCaAyL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 20:54:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9E05C355
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 17:52:25 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s13so12910979ljd.5
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 17:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkvXKGtfqRhN5YqB0z2FhrpZG2GRB+k10i/H+CJfRlg=;
        b=aoTci8u1f5J93U9gBLBHTDkmKaIvBaazqi8FW8fqo0saKnuV5I5jdXFUq97TTKOdY9
         Or+GexxGMyKFjREtqjdJ5h+fff7gy0Udyw48pBiHfvMMsQkFi3QsT6oG38z/qb4Vq0qZ
         cIVZghz07klP2Ojp8fyDLaT6QLNeZeduzHmkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkvXKGtfqRhN5YqB0z2FhrpZG2GRB+k10i/H+CJfRlg=;
        b=ONf+LjQEfAQVQqMagVDYrzlwhd1KlKD9i0gg19wvutdC4k2YbQNVn39zI4NVpKuxPk
         TjzG4kbQltO6fcuLOZBPQTMbQBfQW5bTnfsrEzBWsYseqwpblQwQaFM2fEIbrBu7a0l7
         CA0Ef3AyAUvgOoChrNtEj5E8vCI6QPcNby6+O1QNNEwi/5q9/+/9ZmLIdY5gz7KSevpp
         2BTape8JqrKfjNp5inuRsqBBW1fGtsQZSJ14uUV5Pph8flVFxPbQ0eAuwJF8gH3pgWJ/
         eiCqlD+C/eScpgdMMM6YrSpdjitbF0rHgLS1uzJxulpODXckR3X5vfcZVVuEd2ZYPXWA
         0Ofg==
X-Gm-Message-State: AOAM532N4WIS0/DjxcdqFdX9nWUXVqy6e/jyIQzxsgz/C8gQG/miEud+
        ostu3XfI3UDqe45yUqW+iXjd5sQEdm1NzhkC
X-Google-Smtp-Source: ABdhPJzYu92fh8tqTjlzVz5xWch2kqyK8sdUhZUhEC/9TxR8toDOCZF4QAyU4OfaCfbZtB+kfgzk2g==
X-Received: by 2002:a2e:b98c:0:b0:247:f82b:a0ec with SMTP id p12-20020a2eb98c000000b00247f82ba0ecmr8618524ljp.418.1648687943247;
        Wed, 30 Mar 2022 17:52:23 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p12-20020a056512138c00b0044833f1cd85sm2494225lfa.62.2022.03.30.17.52.22
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 17:52:22 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id w7so38730419lfd.6
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 17:52:22 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr8803758lfh.687.1648687941872; Wed, 30
 Mar 2022 17:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <7b0576d8d49bbd358767620218c1966e8fe9a883.camel@hammerspace.com>
 <CAHk-=wh-hs_q-sL6PNptfVmNm7tWrt24o4-YR74Fxo+fdKsmxA@mail.gmail.com>
 <c5401981cb21674bdd3ffd9cc4fac9fe48fb8265.camel@hammerspace.com>
 <4eed252caf56f16c290f0c54b5d850d4eab5dc1b.camel@hammerspace.com>
 <CAHk-=wi_0L4u_Fd1S3r+-1Ok95HveaXNqY8h3McJOUCfk-tqDg@mail.gmail.com> <79f7b95f1e32214f6b2d84e9cfafc0310c1a8cfe.camel@hammerspace.com>
In-Reply-To: <79f7b95f1e32214f6b2d84e9cfafc0310c1a8cfe.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Mar 2022 17:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOp=KpFAN_+dRVTuNdBVYUZ4nXP6sEYhDvTKdeJFEYUA@mail.gmail.com>
Message-ID: <CAHk-=wiOp=KpFAN_+dRVTuNdBVYUZ4nXP6sEYhDvTKdeJFEYUA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for Linux 5.18
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 30, 2022 at 4:18 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Hmm... No there doesn't appear to be a huge difference between the two.

Ok, thanks for checking. It's basically what I would have expected,
both models really just depend on a reasonable mixing and shuffling of
bits in the word, and it really looks like they have very similar
collision behavior.

At some point even with equivalent functions you obviously end up with
just random differences that just depend on the input set and prue
luck.

But at least based on your numbers, it does look like they really are
equivalent, and hash_64() certainly doesn't look any worse.

All the extra work xxhash() does should matter mainly for

 (a) using more final bits of the hash (ir not reducing them in the end)

 (b) all the cases where you have much more input than one single word

Here, (b) obviously isn't an issue.

And that (a) is by design - those default kernel hash() functions are
literally designed for generating the index for hash tables, and so
expects that final reduction in size.

As a result, unlike xxhash(), it doesn't try to mix in bits in the low
bits, because it knows those will be shifted away in the use-case it's
designed for (the hash() reduction in bits always takes the high
bits).

But that use-case is really exactly what nfs is looking for too, which
is why I was expecting the regular hash_64() to JustWork(tm) for the
nfs case.

                 Linus
