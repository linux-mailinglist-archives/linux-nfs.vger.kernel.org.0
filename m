Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB92516A51
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 07:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350277AbiEBFfd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 01:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383350AbiEBFfa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 01:35:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896032D1E0;
        Sun,  1 May 2022 22:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZMITGLh21gLnSqeHOMeNStOSsEkAvssgxNSH4ttTFCE=; b=f4z0wrZH8kKCnmp6s4m91ky+JQ
        Y7y3VxOmRTr1Zzg9njaHsIWjkxIRhb5xSGulmg73pK10S8i6TJdL/qUzyF7laqnvUWAZdFttP5iG8
        hjWYEk6bk0XAxVSP0lfR0kHUEmBSjvSge0Q45VB7O6zCj6tkGBujqZMczCJm4LJHmtvFKmCOiORr6
        dmg8h9YYNpKWgNFqJq0sPoozuvzQ+IQeEA/WkYfirSv0NdAgbJVrCrJGxA/2Q9CKxYgYhyxTwYSzn
        F+o3WPVHZmMzMfLF4rFcKewRRgdIb6/Xy4t4NpmO1gUnEEaTxlYHuxmDAmtJnsFvQllf5aTQgddoD
        rzqys59w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlOf6-00EYar-Bg; Mon, 02 May 2022 05:31:56 +0000
Date:   Mon, 2 May 2022 06:31:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: handle THP in swap_*page_fs() - count_vm_events()
Message-ID: <Ym9szKx7qYZTlKF2@casper.infradead.org>
References: <165146746627.24404.2324091720943354711@noble.neil.brown.name>
 <Ym9pLhqtf61AVrZG@casper.infradead.org>
 <165146932944.24404.17790836056748683378@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165146932944.24404.17790836056748683378@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 02, 2022 at 03:28:49PM +1000, NeilBrown wrote:
> On Mon, 02 May 2022, Matthew Wilcox wrote:
> > On Mon, May 02, 2022 at 02:57:46PM +1000, NeilBrown wrote:
> > > @@ -390,9 +392,9 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
> > >  			struct page *page = sio->bvec[p].bv_page;
> > >  
> > >  			SetPageUptodate(page);
> > > +			count_swpout_vm_event(page);
> > >  			unlock_page(page);
> > >  		}
> > > -		count_vm_events(PSWPIN, sio->pages);
> > 
> > Surely that should be count_swpIN_vm_event?
> > 
> I'm not having a good day....
> 
> Certainly shouldn't be swpout.  There isn't a count_swpin_vm_event().
> 
> swap_readpage() only counts once for each page no matter how big it is.
> While swap_writepage() counts one for each PAGE_SIZE written.
> 
> And we have THP_SWPOUT but not THP_SWPIN

_If_ I understand the swap-in patch correctly (at least as invoked by
shmem), it won't attempt to swap in an entire THP.  Even if it swapped
out an order-9 page, it will bring in order-0 pages from swap, and then
rely on khugepaged to reassemble them.

Someone who actually understands the swap code should check that my
explanation here is correct.
