Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347804AC81D
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 19:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241500AbiBGSBr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 13:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbiBGR4D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 12:56:03 -0500
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F09C0401DA;
        Mon,  7 Feb 2022 09:56:02 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id w17so8285239vko.9;
        Mon, 07 Feb 2022 09:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2jFTN2u074XzT8suGCUZz+zCtO41192wV4ApDRi8Ns=;
        b=JkalXYSqFISfJim092/HrQmPxPWEQ5IUfsQHmX0zZMnKh+5PXiMMRlt+d7S2oujxC0
         DIWnoRb6BUeJvVhE18/2Wyvl+2YNhIirsyvpekH42iFD6MZEt29H4AaFXDAjYQb6IbOZ
         PPfzN3b1UUUeClpCvog9gb4lf47eKA03LnU3CcU+IoQy8S/OW9RO02Pc3ux01Tg9NvX6
         rfZJOe7LwJYnHEAPqHKMDfVaWHHywwLMmnkfbpFjTxTUAxrqrBUocHPAAr+ynzwsCq1r
         CeUYGvEOw+ZnhQwwN4EjAFWOcIxRLg4g/zHfna7J0isXf9Mqjwfpc32Wn0wL3PKttqEX
         S6Hw==
X-Gm-Message-State: AOAM531l1+PmQn0uPDzPd6IGlI9MbY6Uopq3jJ+l8Bv89rwtaMSs6HN6
        lLBBoi7tb6Ae3+IkoaqMjQhQhwX3iHfE3g==
X-Google-Smtp-Source: ABdhPJwQrPwvpg/kMYycNB9eHrcRCtAtOgEEvjUQGDsUEHj1fwlJ/JoInV2SeLkWvQ3Y+WuuygD6fQ==
X-Received: by 2002:a05:6122:1692:: with SMTP id 18mr344596vkl.25.1644256560903;
        Mon, 07 Feb 2022 09:56:00 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id w15sm14031vso.32.2022.02.07.09.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 09:56:00 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id b2so521803vso.9;
        Mon, 07 Feb 2022 09:55:59 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr161631vse.38.1644256559395;
 Mon, 07 Feb 2022 09:55:59 -0800 (PST)
MIME-Version: 1.0
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Feb 2022 18:55:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXw6bhOf8BMWzje1h_gaBg8TxZXWAQgL0cpdYBkZ+LwXw@mail.gmail.com>
Message-ID: <CAMuHMdXw6bhOf8BMWzje1h_gaBg8TxZXWAQgL0cpdYBkZ+LwXw@mail.gmail.com>
Subject: Re: [PATCH 00/23 V3] Repair SWAP-over_NFS
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

On Mon, Jan 24, 2022 at 5:40 PM NeilBrown <neilb@suse.de> wrote:
> swap-over-NFS currently has a variety of problems.
>
> swap writes call generic_write_checks(), which always fails on a swap
> file, so it completely fails.
> Even without this, various deadlocks are possible - largely due to
> improvements in NFS memory allocation (using NOFS instead of ATOMIC)
> which weren't tested against swap-out.
>
> NFS is the only filesystem that has supported fs-based swap IO, and it
> hasn't worked for several releases, so now is a convenient time to clean
> up the swap-via-filesystem interfaces - we cannot break anything !
>
> So the first few patches here clean up and improve various parts of the
> swap-via-filesystem code.  ->activate_swap() is given a cleaner
> interface, a new ->swap_rw is introduced instead of burdening
> ->direct_IO, etc.
>
> Current swap-to-filesystem code only ever submits single-page reads and
> writes.  These patches change that to allow multi-page IO when adjacent
> requests are submitted.  Writes are also changed to be async rather than
> sync.  This substantially speeds up write throughput for swap-over-NFS.
>
> Some of the NFS patches can land independently of the MM patches.  A few
> require the MM patches to land first.

Thanks for your series!
Swap over NFS was indeed broken last time I tried[1], but with your
series, it's working again on arm32 (RZ/A1 with 32 MiB of RAM, 100Mbps
Ethernet and Debian 9 nfsroot). My system was exercised using "apt
update", and the subsequent "apt upgrade" is still running, though
(it took more than 6 hours to build the apt dependency tree, now it's
trying hard to create a list of packages...).

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

BTW, I think you do want to run scripts/checkpatch.pl on your series,
and improve it by fixing a few of the reported warnings (function
definition arguments should also have an identifier name, missing
data_race() comment, missing SPDX-License-Identifier tag).

[1] https://lore.kernel.org/all/20191230153238.29878-1-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
