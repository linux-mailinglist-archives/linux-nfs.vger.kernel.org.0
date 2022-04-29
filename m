Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08F9514039
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 03:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352786AbiD2B1M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 21:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352507AbiD2B1M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 21:27:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11810BF315;
        Thu, 28 Apr 2022 18:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99CBB621FC;
        Fri, 29 Apr 2022 01:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B552DC385AA;
        Fri, 29 Apr 2022 01:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651195435;
        bh=mBusurNeyDtGczzb973dlSBIA8MS4x2y599fFWUGS9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zBivJB6U3T/XhOw/3CpVT6LHXe2lAXqyivhFYXBwWM8pHcI7P26b5sMkW1HnCXEJ7
         HtehwgofjE0TEdV25EJVK8Ygf1y5P6Bsmujuj9Tnh1umoxQJCqlKj9iZm9Wu4Q5OFe
         NoaQYf3+Wco1r6FmSuGBPQ67Xor/ni40tLgPI/Jo=
Date:   Thu, 28 Apr 2022 18:23:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] NFS: rename nfs_direct_IO and use as ->swap_rw
Message-Id: <20220428182353.d79ae288e1bb0cae5116d989@linux-foundation.org>
In-Reply-To: <165119301493.15698.7491285551903597618.stgit@noble.brown>
References: <165119280115.15698.2629172320052218921.stgit@noble.brown>
        <165119301493.15698.7491285551903597618.stgit@noble.brown>
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

> The nfs_direct_IO() exists to support SWAP IO, but hasn't worked for a
> while.  We now need a ->swap_rw function which behaves slightly
> differently, returning zero for success rather than a byte count.
> 
> So modify nfs_direct_IO accordingly, rename it, and use it as the
> ->swap_rw function.
> 

This one I insertion sorted into the series after
mm-introduce-swap_rw-and-use-it-for-reads-from-swp_fs_ops-swap-space.patch.
I can later fold this patch into that one of you think that's a better
presentation?
