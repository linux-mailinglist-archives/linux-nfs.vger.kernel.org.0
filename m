Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD874AC0EE
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 15:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiBGOUC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 7 Feb 2022 09:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389248AbiBGNvb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 08:51:31 -0500
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9B8C043188;
        Mon,  7 Feb 2022 05:51:30 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id g18so12715586uak.5;
        Mon, 07 Feb 2022 05:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fUAjBprB67NHx4X4sNT3As+x8i0b1+huuPKs3QJNjwY=;
        b=OD/mCEnJ0ikF7fUe/oz7B6NmxbPxCStlOWhBeEwN9vuDLa5twBENHzw5FUZOkTsmWQ
         Wh6E7U2Px07mszTTL2P9dmpqFx3gV9O4VCKO6xuOVCeHO+JHs4ClXIZhWtGGmrMwZkmo
         w+jermQ43CcAHbI/g/05BbRQt8u9az9920NwLV1duSEuYuX49qeir9pw/q2+lA/7ItKQ
         BYf77mQ8oLx2ho7ibXBDPflxXKr+U3oSy5tPZDaNiX9UF5Yt3e/iMX17WV52rOE3HrCj
         ujKPPQOfiwzIE5PxBzYn97Th5oIqYuje2fCmyxUwN6LEs1gk0x/THVy4bxvi+rD22TqD
         DSiA==
X-Gm-Message-State: AOAM533jdDIo1e010paBs2wjcOrclt935i3UJGJIEMD4hb5RK2P9Ruo0
        TiOKwARkbd46fTK+IvPX+O+Ap/NDZsLlBg==
X-Google-Smtp-Source: ABdhPJyuyob3KqC+Gme0qPoc3Y5LctUVmeGYXrDTiko7HH9x1sLCIuKvOY2eskmXHXs0fPF6QjUzBQ==
X-Received: by 2002:a67:e3b1:: with SMTP id j17mr4475447vsm.80.1644241889778;
        Mon, 07 Feb 2022 05:51:29 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id w5sm2281412vkf.12.2022.02.07.05.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 05:51:29 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id o15so7858697vki.2;
        Mon, 07 Feb 2022 05:51:28 -0800 (PST)
X-Received: by 2002:a1f:2555:: with SMTP id l82mr5141143vkl.7.1644241888621;
 Mon, 07 Feb 2022 05:51:28 -0800 (PST)
MIME-Version: 1.0
References: <164299573337.26253.7538614611220034049.stgit@noble.brown> <164299611271.26253.2968456569309914722.stgit@noble.brown>
In-Reply-To: <164299611271.26253.2968456569309914722.stgit@noble.brown>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Feb 2022 14:51:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYRNnMn38wWcLDC_nFYr1HnRSFJ6DXwD4af=Cmx2J7dA@mail.gmail.com>
Message-ID: <CAMuHMdVYRNnMn38wWcLDC_nFYr1HnRSFJ6DXwD4af=Cmx2J7dA@mail.gmail.com>
Subject: Re: [PATCH 01/23] MM: create new mm/swap.h header file.
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

On Mon, Jan 24, 2022 at 5:26 PM NeilBrown <neilb@suse.de> wrote:
> Many functions declared in include/linux/swap.h are only used within mm/
>
> Create a new "mm/swap.h" and move some of these declarations there.
> Remove the redundant 'extern' from the function declarations.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: NeilBrown <neilb@suse.de>

Thanks for your patch!

mm/huge_memory.c: In function ‘__split_huge_page’:
mm/huge_memory.c:2423:16: error: implicit declaration of function
‘swap_address_space’; did you mean ‘exit_swap_address_space’?
[-Werror=implicit-function-declaration]
 2423 |   swap_cache = swap_address_space(entry);
      |                ^~~~~~~~~~~~~~~~~~
      |                exit_swap_address_space

mm/huge_memory.c needs to #include "swap.h", too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
