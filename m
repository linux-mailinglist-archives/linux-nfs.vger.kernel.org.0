Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF881516A3F
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 07:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbiEBFUO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 01:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350281AbiEBFUM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 01:20:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1FBE0F;
        Sun,  1 May 2022 22:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ayeIMCinTpq/u7MVfmi42xJboKkMgnstySy0kRIQl3s=; b=hE19F/9qpxsWERpk9uKU5lMSdb
        fFFl/GJlFvXMcluxy2hKTlEMRhcx9RA1bD1Xn5arLRbKr0NyNNpfoQR00PPIvdXGbKQU6P+SsRNNE
        RFoXnFNWswiqIHACvfLLjkBOuxQ8C3eIALXSoImHt6A7Ownp6obV3gNvtLBzUgmi7R2DG1iyvNKwg
        C5zZytgiS154RSSr6+EcdY10LxDp+MMVMWH+UBDawTqWiR6+MNC5/zptn7S6EjLFk2TY3vGxUIQqo
        QdLYpwUJIjR9rpEJhUoJMPiuCjqjTzZVSwdKvsXK+9fnavbuQpjNBQfCMb3h5L9DyG7WRU9HAZW7R
        TUv8cwDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlOQA-00EY9O-54; Mon, 02 May 2022 05:16:30 +0000
Date:   Mon, 2 May 2022 06:16:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: handle THP in swap_*page_fs() - count_vm_events()
Message-ID: <Ym9pLhqtf61AVrZG@casper.infradead.org>
References: <165146746627.24404.2324091720943354711@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165146746627.24404.2324091720943354711@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 02, 2022 at 02:57:46PM +1000, NeilBrown wrote:
> @@ -390,9 +392,9 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>  			struct page *page = sio->bvec[p].bv_page;
>  
>  			SetPageUptodate(page);
> +			count_swpout_vm_event(page);
>  			unlock_page(page);
>  		}
> -		count_vm_events(PSWPIN, sio->pages);

Surely that should be count_swpIN_vm_event?
