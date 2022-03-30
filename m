Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9414ECBAF
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 20:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350004AbiC3STq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 14:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349966AbiC3STj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 14:19:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319D332074
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 11:17:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h7so37296832lfl.2
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7NnuuJ059MX+/R6R8hSPlWGgObYMG0+HBTsWiYBn0k=;
        b=RD872fF7slzNyr8FioUVkR3B/FRoEYrH4iay+e0QIuWYM+GhoTnZzg29YiOGM1VUDF
         mhMqgFOPRYwWmalTCDmHKIw7NN7ZpXYByatHPSVZTAtvIvru63aeLCJsn0JXzYY0yu5D
         kF82cDP1d/5XkY+NKZbgrRHh2F5zPDrz3D0Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7NnuuJ059MX+/R6R8hSPlWGgObYMG0+HBTsWiYBn0k=;
        b=66pEPOOsBH8gQgLCo3WgzoLNwlafu8nX+yvBUZ98UlF/sQv0MPG3Sp+D3Am8GGW4wc
         FtTIgyLo0ldYx/J/aRRSV5Y717NiSF/Ha5T6/vAuzTUcIVY17Xl5lOiR5ZtfJaq1wM+G
         Prd5pSDv12fAPoSUpu43eM/5OVJ6CHIYctE4MDwD9OFsD8zZSQQwGyou35paRM5tzrce
         4hv8vU0cUt5UklFhV9k8UYIQ+4d4cA49TNLeQU8GhmCtB16mgiN6+/Xegf7+Q+cSKHsj
         tLrT5Q3B2bDyHUNpfrAHHUqB6s5TEdw+50PGylyTwaJvTKfJ38VDmO/tNMXf6s8FLNp6
         VR/Q==
X-Gm-Message-State: AOAM532BbceKD/FWqMECB76kmYwPoPteZBZV+s/jiD+/4AiPVF58z64K
        E/Pzw+uTyLa3wFNKD4eWkZKLf+tBmlJfFMbN
X-Google-Smtp-Source: ABdhPJyemDtnx02hkeyjBYBZ6VneJTK9CyBsu7x5qYN2AzxeKG4s98j608c1ecJO86kLe+M/1RJR1A==
X-Received: by 2002:a05:6512:12d5:b0:44a:9c24:9254 with SMTP id p21-20020a05651212d500b0044a9c249254mr7716650lfg.39.1648664271108;
        Wed, 30 Mar 2022 11:17:51 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id d12-20020ac241cc000000b004433cb076d1sm2401645lfi.77.2022.03.30.11.17.50
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 11:17:50 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id bq24so21327277lfb.5
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 11:17:50 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id
 k15-20020a0565123d8f00b0044a2c658323mr7864587lfv.52.1648664269822; Wed, 30
 Mar 2022 11:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <7b0576d8d49bbd358767620218c1966e8fe9a883.camel@hammerspace.com>
In-Reply-To: <7b0576d8d49bbd358767620218c1966e8fe9a883.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Mar 2022 11:17:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-hs_q-sL6PNptfVmNm7tWrt24o4-YR74Fxo+fdKsmxA@mail.gmail.com>
Message-ID: <CAHk-=wh-hs_q-sL6PNptfVmNm7tWrt24o4-YR74Fxo+fdKsmxA@mail.gmail.com>
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

On Tue, Mar 29, 2022 at 12:36 PM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> - Readdir fixes to improve cacheability of large directories when there
>   are multiple readers and writers.

So I only took a look at this part now. I've obviously already pulled
it, but that use of 'xxhash()' just made me go "Whaaa?"

It's claimed that it's used because of its extreme performance, but
the performance numbers come from using it as a block hash.

That's not what nfs does.

The nfs code just does

    xxhash(&cookie, sizeof(cookie), 0) & NFS_READDIR_COOKIE_MASK;

where that "cookie" is just a 64-bit entity. And then it masks off
everything but 18 bits.

Is that *really* appropriate use of a new hash function?

Why is this not just doing

  #include <hash.h>

  hash_64(cookie, 18);

which is a lot more obvious than xxhash().

If there really are some serious problems with the perfectly standard
hash() functionality, I think you should document them.

Because just randomly picking xxhash() without explaining _why_ you
can't just use the same simple thing we use elsewhere is very odd.

Or rather, when the only documentation is "performance", then I think
the regular "hash_64()" is the obvious and trivial choice.

                  Linus
