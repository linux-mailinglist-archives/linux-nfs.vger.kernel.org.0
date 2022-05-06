Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0423451CF1F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 May 2022 04:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388384AbiEFDA3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 May 2022 23:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbiEFDA2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 May 2022 23:00:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFD15C65F;
        Thu,  5 May 2022 19:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651805806; x=1683341806;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bm/ECb2jddD2tXLPLMb1gNbwUfVlj/otmAhjYIFTg4o=;
  b=mvE0HPZdX+AV7TTGgcw3iNdXXL9LVt6gTqIePgswCwBZSgluwtWLFVtO
   KJYegzsNjzwIgWKUGaYEEge6jOy2NtTS80A/ZIM8+etfdA8fLYWsmLMgt
   S9esM+JM932gumOuFWxFNPY0PwiF85rIpspCQf0u1+f32mn74UV8dQdxv
   xU8PpF8ZGIrxjdTlpSQKTD+jt9chhw7uD6RlKuSame6MIb6VyikmMCGYn
   FIbnU3iNN3xqft0l6rKgxOqUFxqDELCNNk1frOdPUqiCYY/1R3+nr8GMQ
   ukxUIQDszr8TAaqUJZaCfG08/isfXIz5BaH7Qvb3oKgwsbQd390DtgD/9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248864370"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="248864370"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 19:56:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735337943"
Received: from fulaizha-mobl1.ccr.corp.intel.com ([10.254.213.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 19:56:43 -0700
Message-ID: <e63ac163c9283ca93d8309be1cdfed6c6ea97e5e.camel@intel.com>
Subject: Re: [PATCH 1/2] MM: handle THP in swap_*page_fs()
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     NeilBrown <neilb@suse.de>, Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 06 May 2022 10:56:40 +0800
In-Reply-To: <165170771676.24672.16520001373464213119@noble.neil.brown.name>
References: <165119280115.15698.2629172320052218921.stgit@noble.brown>
        , <165119301488.15698.9457662928942765453.stgit@noble.brown>
        , <CAHbLzko+9nBem8GnxQJ8RQu7bizQMMmS1TNqbRXcgkjUs+JuMw@mail.gmail.com>
        , <165146539609.24404.4051313590023463843@noble.neil.brown.name>
        , <CAHbLzkpF4zedBmipjX8Zy5F=Fffez+xgxTAvveaz1nRHb9Wg_Q@mail.gmail.com>
         <165170771676.24672.16520001373464213119@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-05-05 at 09:41 +1000, NeilBrown wrote:
> On Tue, 03 May 2022, Yang Shi wrote:
> > On Sun, May 1, 2022 at 9:23 PM NeilBrown <neilb@suse.de> wrote:
> > > 
> > > On Sat, 30 Apr 2022, Yang Shi wrote:
> > > > On Thu, Apr 28, 2022 at 5:44 PM NeilBrown <neilb@suse.de> wrote:
> > > > > 
> > > > > Pages passed to swap_readpage()/swap_writepage() are not necessarily all
> > > > > the same size - there may be transparent-huge-pages involves.
> > > > > 
> > > > > The BIO paths of swap_*page() handle this correctly, but the SWP_FS_OPS
> > > > > path does not.
> > > > > 
> > > > > So we need to use thp_size() to find the size, not just assume
> > > > > PAGE_SIZE, and we need to track the total length of the request, not
> > > > > just assume it is "page * PAGE_SIZE".
> > > > 
> > > > Swap-over-nfs doesn't support THP swap IIUC. So SWP_FS_OPS should not
> > > > see THP at all. But I agree to remove the assumption about page size
> > > > in this path.
> > > 
> > > Can you help me understand this please.  How would the swap code know
> > > that swap-over-NFS doesn't support THP swap?  There is no reason that
> > > NFS wouldn't be able to handle 2MB writes.  Even 1GB should work though
> > > NFS would have to split into several smaller WRITE requests.
> > 
> > AFAICT, THP swap is only supported on non-rotate block devices, for
> > example, SSD, PMEM, etc. IIRC, the swap device has to support the
> > cluster in order to swap THP. The cluster is only supported by
> > non-rotate block devices.
> > 
> > Looped Ying in, who is the author of THP swap.
> 
> I hunted around the code and found that THP swap only happens if a
> 'cluster_info' is allocated, and that only happens if 
> 	if (p->bdev && bdev_nonrot(p->bdev)) {
> in the swapon syscall.
> 

And in get_swap_pages(), the cluster is only allocated for block
devices.

		if (size == SWAPFILE_CLUSTER) {
			if (si->flags & SWP_BLKDEV)
				n_ret = swap_alloc_cluster(si, swp_entries);
		} else
			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
						    n_goal, swp_entries);

We may remove this restriction in the future if someone can show the
benefit.

Best Regards,
Huang, Ying

> I guess "nonrot" is being use as a synonym for "low latency"...
> So even if NFS was low-latency it couldn't benefit from THP swap.
> 
> So as you say it is not currently possible for THP pages to be send to
> NFS for swapout.  It makes sense to prepare for it though I think - if
> only so that the code is more consistent and less confusing.
> 
> Thanks,
> NeilBrown


