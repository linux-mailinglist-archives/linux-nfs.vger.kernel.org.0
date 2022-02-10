Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDC64B118F
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 16:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbiBJPWe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 10:22:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243551AbiBJPWd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 10:22:33 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EEADB1;
        Thu, 10 Feb 2022 07:22:34 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id t22so6811036vsa.4;
        Thu, 10 Feb 2022 07:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDMSUmX7DHXQDjg3TPns4S8y9XUJrbzGeRPn74cCH1o=;
        b=zOuRQ+FLa7McPU9bO8Z1FlpSNqwHiLGOui3vOK/x95qOevGdI1ULzn7yM1uY9M3xiK
         vTpXVTJULZmFgf4zMi4RpwiLy1TkVjNty9SPMr+1Ylhlg4mgqK6vS/TKOtZD0j4oPXkL
         MPBZPr34uZs1poHz0g8DAubSvdU0VkDcE0Hs7ovJGN7J7eWOqw5ZaUegdhwlIRViqkSZ
         Q9/JKpJh2HW0rzq6JohkNUzuSNgb7ivGvCwJJSPNiYAc6z1rWL73ndDmRRpNGyoQW23n
         OineDssPnZRWEhDk+z8xKdZTCJCyJ5jTqWahEt4Kd9s5bUXmLLKjB1ASHnZxXQyO7O5N
         D2WA==
X-Gm-Message-State: AOAM533nb/XvCghTx06TR6ZEF8LeTYDxrIEmDG/l5Msu0xJO0s+Mu7oA
        KNrKU53pgMP6Pe2kI2LuIe/wvFKudfgwaw==
X-Google-Smtp-Source: ABdhPJwVCxUBTTfQm4A5OxaqroM/IYw5CftjaTKDDD7IAS5BX2jPw9lmE8QCdKqFGtDkQvlrhPMlXw==
X-Received: by 2002:a05:6102:304c:: with SMTP id w12mr2505291vsa.54.1644506553866;
        Thu, 10 Feb 2022 07:22:33 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id e17sm3847348vsl.21.2022.02.10.07.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 07:22:33 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id g10so6835299vss.1;
        Thu, 10 Feb 2022 07:22:32 -0800 (PST)
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr2567699vst.68.1644506552564;
 Thu, 10 Feb 2022 07:22:32 -0800 (PST)
MIME-Version: 1.0
References: <164420889455.29374.17958998143835612560.stgit@noble.brown>
In-Reply-To: <164420889455.29374.17958998143835612560.stgit@noble.brown>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Feb 2022 16:22:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWtRd22FnP5+Ey+d+Zi6OenE17C37F-NbKKkGSzQKtYEg@mail.gmail.com>
Message-ID: <CAMuHMdWtRd22FnP5+Ey+d+Zi6OenE17C37F-NbKKkGSzQKtYEg@mail.gmail.com>
Subject: Re: [PATCH 00/21 V4] Repair SWAP-over_NFS
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil,

On Wed, Feb 9, 2022 at 11:29 AM NeilBrown <neilb@suse.de> wrote:
> This 4th version of the series address review comment, particularly
> tidying up "NFS: swap IO handling is slightly different for O_DIRECT IO"
> and collect reviewed-by etc.
>
> I've also move 3 NFS patches which depend on the MM patches to the end
> in case they helps maintainers land the patches in a consistent order.
> Those three patches might go through the NFS free after the next merge
> window.

Thanks for the update!
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
(on Renesas RSK+RZA1 with 32 MiB of SDRAM)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
