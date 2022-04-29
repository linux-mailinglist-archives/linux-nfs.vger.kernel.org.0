Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD45514034
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 03:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353864AbiD2BYz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 21:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353804AbiD2BYz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 21:24:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40AFBF30E;
        Thu, 28 Apr 2022 18:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1144FCE2F98;
        Fri, 29 Apr 2022 01:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AEBC385AA;
        Fri, 29 Apr 2022 01:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651195294;
        bh=LVmESRAb1gVwgkXczgSW1uhSdkcv4gprtILUykh3+mI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KeDZQgtbOHfR1luP+KoPEwbEiQyg/IVcr6+bK0+rwQykOGkuHCb+FMYlJYPfuXRhG
         aTGzp5+5m2u0TABgbsvUTjUIck6kVJCezjgK/EY5AfkJfjfZK5jEqZC/UdRv+w8hV/
         aTag5Eezz7HJ7YqYKJNjKoYiXJo+wxacZbU6eEv0=
Date:   Thu, 28 Apr 2022 18:21:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MM: handle THP in swap_*page_fs()
Message-Id: <20220428182132.883a082ad8918fd5f8073130@linux-foundation.org>
In-Reply-To: <165119301488.15698.9457662928942765453.stgit@noble.brown>
References: <165119280115.15698.2629172320052218921.stgit@noble.brown>
        <165119301488.15698.9457662928942765453.stgit@noble.brown>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 29 Apr 2022 10:43:34 +1000 NeilBrown <neilb@suse.de> wrote:

> Pages passed to swap_readpage()/swap_writepage() are not necessarily all
> the same size - there may be transparent-huge-pages involves.
> 
> The BIO paths of swap_*page() handle this correctly, but the SWP_FS_OPS
> path does not.
> 
> So we need to use thp_size() to find the size, not just assume
> PAGE_SIZE, and we need to track the total length of the request, not
> just assume it is "page * PAGE_SIZE".

Cool.  I added this in the series after
mm-submit-multipage-write-for-swp_fs_ops-swap-space.patch.  I could
later squash it into that patch if you think that's more logical.

