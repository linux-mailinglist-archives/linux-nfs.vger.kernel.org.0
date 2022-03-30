Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE84ECDF2
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiC3UNI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 16:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiC3UNH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 16:13:07 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E0A65429
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 13:11:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h11so29217091ljb.2
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8saFLymfeqO/ogmUMlEcK3Es6y2VVG88mitspUFOL0=;
        b=fW/r78NFN8nLdN2Yn9/tT4J6HHaIA3laHKcmPnBiSbR+xbXf2DDZcpOaIZ1eD/xeUq
         /RUVpPnGrAH0cI8RRCDFwy7W1jCSqOUAvCRhmZuROQMWd1xuY2mU4fXx+A/+WW78kSyX
         hbJOii15jmOrWx+SFEZCQ1qlr1b0FXs6FBG3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8saFLymfeqO/ogmUMlEcK3Es6y2VVG88mitspUFOL0=;
        b=gh9cWuLQTmt/uAL8a9osabDF8jaQtGpHLxKbPGDupoTIfuZWqAmTgjI5b5/VQhcPxY
         2jmgKFw26c0hez/amP45fktNkclXVdmz/FjmkZ2N48HmWBPtOg1qFECVh7SAPGZy5IpP
         co6g29/R8wtSb9zfb2F33l2SJUzjkI1Wm8O4qH+T7ixdTvynMM6ViNUdCgcSu6voYam8
         VCCsMOjTtyIb/64DAy7iVgwVf45lwxZnd3t+xGfpr3LlFdmyOA+Jegda/LdEI6fnaNkk
         reX1Zt1Go/lmjSHtkyvZTdYemVpoSqnjYTyjJX4hefGR0Kao3tnDS2wMW75EyxL9WAcS
         5Svw==
X-Gm-Message-State: AOAM533XTz8FGmR42G/78mGiIZb4MNcycSqPmAkKchJBu+/MkdOIEESL
        GrwQhI5xZPlFp+89nv+EXs7AnfR/5Dyl+yhu
X-Google-Smtp-Source: ABdhPJwdSBhLeg07VyewBYcQAjw91eqm0hKHDQmAlCo2OiDaDdFIZiBFPLeic0C9EWlVUwQ9gRC/9g==
X-Received: by 2002:a05:651c:239:b0:249:b1b0:fe69 with SMTP id z25-20020a05651c023900b00249b1b0fe69mr7803680ljn.288.1648671079679;
        Wed, 30 Mar 2022 13:11:19 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id p17-20020a19f111000000b0044a6522f9acsm2284520lfh.135.2022.03.30.13.11.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 13:11:18 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id z12so23983455lfu.10
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 13:11:18 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr8145958lfb.435.1648671078307; Wed, 30
 Mar 2022 13:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <7b0576d8d49bbd358767620218c1966e8fe9a883.camel@hammerspace.com>
 <CAHk-=wh-hs_q-sL6PNptfVmNm7tWrt24o4-YR74Fxo+fdKsmxA@mail.gmail.com> <c5401981cb21674bdd3ffd9cc4fac9fe48fb8265.camel@hammerspace.com>
In-Reply-To: <c5401981cb21674bdd3ffd9cc4fac9fe48fb8265.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Mar 2022 13:11:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqo0xdOXQSj2uX7Zkdn9jYvn=vapmt4XGaSP6B=ZAmqw@mail.gmail.com>
Message-ID: <CAHk-=wgqo0xdOXQSj2uX7Zkdn9jYvn=vapmt4XGaSP6B=ZAmqw@mail.gmail.com>
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

On Wed, Mar 30, 2022 at 1:02 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> My main worry was that hash_64() would have too many collisions.

So as you found out, hash_64() is actually a fairly good hash despite
being very simple.

In fact, with an input of just one word, it's generally hard to do
much better. I'm obviously not claiming it's a _cryptographic_ hash,
but compared to the usual "xor and shift a few times", it really
shouldn't be too bad.

And that's really what xxhash() does anyway.

I think the reason to use xxhash() would be if you have a noticeably
bigger input, or some truly special cases.

But for a single word, and then not even using very many of the
resulting bits, our regular family of 'hash()' routines really should
generally be perfectly fine. It should spread and mix the input bits
competently.

            Linus
