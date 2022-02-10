Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F4A4B1181
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiBJPTW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 10:19:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbiBJPTV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 10:19:21 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88642B88;
        Thu, 10 Feb 2022 07:19:22 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id w207so2745759vkd.2;
        Thu, 10 Feb 2022 07:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4us6o/cNpkSDYz9YOKk+ti1q/OlliOceGfkUTtwngBc=;
        b=IVo7PO6s0kwiwXv8jxQPmDJ6SmzumDp/P+On6lDwcD2dhK3bMYF1/k4uN2IpjIAJTJ
         3Hy32y0jV/iyyfQfyKdrxav/D6XQSJ4Hcof7/NsQugchBlPcmYdQfRugnxtinb7nHf5B
         BYTkpoDXKMkZMlynUQq8huKbC6CboQv2TpfZHX2cv4TTJXVhDxJpWTTJdaSriX3/dyMj
         jQkoRN6H9qU/b95CBI+7RNOLLw9KYIGZXEbka5lvY1qgy9zo3cdDjJKIxiVgPPmeGFda
         DE6GS8b1cC47dOcoPF/4Ya8us9tO4hBubx3DY/C90WMmS2OnPY/6Gpk1ihaa6fidnstt
         0vrg==
X-Gm-Message-State: AOAM533IW/eI91Vjs5En5nEGXZmPGT27+rJ1MXnIID+IHJnCsSblrUcf
        27lSGDX67tHY9T2O/EB5iG3GzEnMmyEdDg==
X-Google-Smtp-Source: ABdhPJy1j2SZJmlxXllbWxz+s7Xp6rJmuBtwNoRrB4AFsRQrp4rXC+6GVBgYOmB0o/vGXt5piGeINg==
X-Received: by 2002:a1f:e745:: with SMTP id e66mr2821547vkh.24.1644506361598;
        Thu, 10 Feb 2022 07:19:21 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id u6sm2350842vku.15.2022.02.10.07.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 07:19:20 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id v5so3182655uam.3;
        Thu, 10 Feb 2022 07:19:19 -0800 (PST)
X-Received: by 2002:ab0:384c:: with SMTP id h12mr2566245uaw.122.1644506359681;
 Thu, 10 Feb 2022 07:19:19 -0800 (PST)
MIME-Version: 1.0
References: <164420889455.29374.17958998143835612560.stgit@noble.brown> <164420916109.29374.8959231877111146366.stgit@noble.brown>
In-Reply-To: <164420916109.29374.8959231877111146366.stgit@noble.brown>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Feb 2022 16:19:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUtZyJE0-_B7YDexDpkOe_y5jQ7rWJKPyzJJczuSq7POg@mail.gmail.com>
Message-ID: <CAMuHMdUtZyJE0-_B7YDexDpkOe_y5jQ7rWJKPyzJJczuSq7POg@mail.gmail.com>
Subject: Re: [PATCH 01/21] MM: create new mm/swap.h header file.
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

On Wed, Feb 9, 2022 at 10:52 AM NeilBrown <neilb@suse.de> wrote:
> Many functions declared in include/linux/swap.h are only used within mm/
>
> Create a new "mm/swap.h" and move some of these declarations there.
> Remove the redundant 'extern' from the function declarations.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: NeilBrown <neilb@suse.de>

Thanks for your patch!

> --- /dev/null
> +++ b/mm/swap.h
> @@ -0,0 +1,129 @@
> +

scripts/checkpatch.pl:
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
