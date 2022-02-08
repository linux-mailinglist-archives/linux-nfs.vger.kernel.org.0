Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008474AD74F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346243AbiBHLca (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 06:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiBHLH4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 06:07:56 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D97C03FEC0;
        Tue,  8 Feb 2022 03:07:55 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id t20so2924718vsq.12;
        Tue, 08 Feb 2022 03:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLRCIZiUQ4EqimYPFyGlj6mR3eFhIcoRvYTw8GfHVOA=;
        b=f9rk8askNLCyFN+IFGlxvGyzf5IZvJzl3QWCWaYjf+eS758Asyr9HREyEsI7QRCHRf
         DQpOPnOe6zBdDS7Z5WYIcp+G/0dQrXQXr9bjmjPdwdX6eNoA4ZKFsz774DqtXpp9THV8
         riYuwFUcuC9d0N55h1B+tG5wisMVSrwNXbT/4FX3PY9LfnQd+8SEAio3Qg93hXJUda98
         zYFIDYLZMpbrNGZSA/+R9xn/n2ITZcD2kWyhrYysOhpq56pdq9JCUe3ipZgbvUj9Xj/4
         diQTgqT7EVSkmp1ovTC0DUW+LbhMgQ2iqN2e7rI2gZPEXm9L932MSfHzGrHu6skh9wN4
         kK8g==
X-Gm-Message-State: AOAM533clf2a5qVCnvffVeN1O5ldf7JFSDCLuROmT83ZuxPKMF7xP+Sy
        tLdOiHu3PvfoqfaKIachsVfuUL0/298aPw==
X-Google-Smtp-Source: ABdhPJynYgutMZyg3kc7IdyW4CnWpGz9o52Ng4f+md5Aiw+LyuIHvBNMR8RMYF+nyY3ngLhe29BaVQ==
X-Received: by 2002:a05:6102:2851:: with SMTP id az17mr1362212vsb.43.1644318474398;
        Tue, 08 Feb 2022 03:07:54 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id f9sm2116455uam.3.2022.02.08.03.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 03:07:53 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id m131so9519803vkm.7;
        Tue, 08 Feb 2022 03:07:53 -0800 (PST)
X-Received: by 2002:a1f:2555:: with SMTP id l82mr1515140vkl.7.1644318473361;
 Tue, 08 Feb 2022 03:07:53 -0800 (PST)
MIME-Version: 1.0
References: <164299573337.26253.7538614611220034049.stgit@noble.brown> <164299611278.26253.14950274629759580371.stgit@noble.brown>
In-Reply-To: <164299611278.26253.14950274629759580371.stgit@noble.brown>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Feb 2022 12:07:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJM0sSo7TCHN4PNq-DURKFEesVTwNpcGQ_dcehN1G=ZQ@mail.gmail.com>
Message-ID: <CAMuHMdXJM0sSo7TCHN4PNq-DURKFEesVTwNpcGQ_dcehN1G=ZQ@mail.gmail.com>
Subject: Re: [PATCH 09/23] MM: submit multipage reads for SWP_FS_OPS swap-space
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

On Mon, Jan 24, 2022 at 5:49 PM NeilBrown <neilb@suse.de> wrote:
> swap_readpage() is given one page at a time, but maybe called repeatedly
> in succession.
> For block-device swapspace, the blk_plug functionality allows the
> multiple pages to be combined together at lower layers.
> That cannot be used for SWP_FS_OPS as blk_plug may not exist - it is
> only active when CONFIG_BLOCK=y.  Consequently all swap reads over NFS
> are single page reads.
>
> With this patch we pass in a pointer-to-pointer when swap_readpage can
> store state between calls - much like the effect of blk_plug.  After
> calling swap_readpage() some number of times, the state will be passed
> to swap_read_unplug() which can submit the combined request.
>
> Some caller currently call blk_finish_plug() *before* the final call to
> swap_readpage(), so the last page cannot be included.  This patch moves
> blk_finish_plug() to after the last call, and calls swap_read_unplug()
> there too.
>
> Signed-off-by: NeilBrown <neilb@suse.de>

Thanks for your patch!

> --- a/mm/swap.h
> +++ b/mm/swap.h

> @@ -53,7 +62,8 @@ static inline unsigned int page_swap_flags(struct page *page)
>         return page_swap_info(page)->flags;
>  }
>  #else /* CONFIG_SWAP */
> -static inline int swap_readpage(struct page *page, bool do_poll)
> +static inline int swap_readpage(struct page *page, bool do_poll,
> +                               struct swap_iocb **plug);

Bogus semicolon.

>  {
>         return 0;
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
