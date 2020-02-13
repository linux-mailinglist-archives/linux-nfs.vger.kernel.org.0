Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61A215C0C0
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2020 15:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgBMO4Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Feb 2020 09:56:24 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38331 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMO4Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Feb 2020 09:56:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id z19so5906430qkj.5
        for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2020 06:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L1yqwsepRWzermGFjsYu3VrzLZwg/ltH+9eaqXJdLvs=;
        b=QwNRXL4LNXzlXI1njln3t0egXOEh06OzvNqzOitrpSEzl/ld2pBc1CG+JN3/xTGY8M
         RPJB9D2zWNhHMhAv/KYmKUck2IXkJvqTNQAHMso1aH6l7f2bOksz3DYLAXW+xhTi0ygR
         hDlA2d8eslEpY+DVEe7wgVikBYr4jG/fcg98k15QEgGVEF4i7+6fNqO+lkJY/T+jTEgP
         Yw6+N3cn74qMmMnSS26UraGpB8gADP4Lru7e4r+EvjKgrWAcH4eKlJxIm3obOlfMU59e
         2mXAe34lfW5HOf2+xrSnjzFtdZ7c+r5oKCDJStsX4iwCj8V0yFVvrH74iYsQLeqVRNcE
         sAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L1yqwsepRWzermGFjsYu3VrzLZwg/ltH+9eaqXJdLvs=;
        b=ml3G+P+7HK4m/yAD+BffdfOV5VaebMIuo4F5LOlKEqm80LLUhLqHkvXa9xVuAe1niC
         gAsIjAtnKipZ0c2mefe8a2Tv350iKkMsGduGi6ktX26RGe+cv0wPDR2+MdFxOYKlnL1L
         vD/bBvrQaYiMlISvmmKo9oyAW3J79bOos7EvjTX8APD1q1/l7gsyKowQhhrdbwcvQ9Dl
         iycPGmc+LY9fJoC37ltQUmimk6iQwNr5kjtUyv/cPwXlDkH2TORH5StJmG2/4Of/AZ58
         SLzBqTypNGS4xP2E/DUUkMMNtDIwJAskNAxAn1LflqpK5RfR1HBjQ0/TJHM77CJVUYTm
         mzxg==
X-Gm-Message-State: APjAAAUtKyPNKfCBtrkI6JXtnivKXNUACDfiZ1M6eS6ohlQEnRMcmywl
        WtZea8dyjxrvPTKaZF9bO5lpKw==
X-Google-Smtp-Source: APXvYqykyR1HAYL8n+6smDT90HiVdC1pj0px9bgMvjOPNJIwgjltOg85yhljkhOxLwYJ+wM5cdKuMw==
X-Received: by 2002:a37:7b43:: with SMTP id w64mr16039493qkc.203.1581605778823;
        Thu, 13 Feb 2020 06:56:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d9sm1512875qtw.32.2020.02.13.06.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 06:56:18 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2Fub-0004w3-Gs; Thu, 13 Feb 2020 10:56:17 -0400
Date:   Thu, 13 Feb 2020 10:56:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 1/2] xprtrdma: Fix DMA scatter-gather list mapping
 imbalance
Message-ID: <20200213145617.GI31668@ziepe.ca>
References: <158152363458.433502.7428050218198466755.stgit@morisot.1015granger.net>
 <158152394998.433502.5623790463334839091.stgit@morisot.1015granger.net>
 <20200212182638.GA31668@ziepe.ca>
 <F7B6A553-0355-41BF-A209-E8D73D15A6A9@oracle.com>
 <20200212190545.GB31668@ziepe.ca>
 <B9D0EE52-469B-4CC4-A944-C3421DBB68B6@oracle.com>
 <20200212193036.GD31668@ziepe.ca>
 <595DB50E-F65A-4F52-BFDB-79161151ECDD@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <595DB50E-F65A-4F52-BFDB-79161151ECDD@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 13, 2020 at 09:33:23AM -0500, Chuck Lever wrote:
> 
> 
> > On Feb 12, 2020, at 2:30 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Wed, Feb 12, 2020 at 02:09:03PM -0500, Chuck Lever wrote:
> >> 
> >> 
> >>> On Feb 12, 2020, at 2:05 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>> 
> >>> On Wed, Feb 12, 2020 at 01:38:59PM -0500, Chuck Lever wrote:
> >>>> 
> >>>>> On Feb 12, 2020, at 1:26 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>>>> 
> >>>>> On Wed, Feb 12, 2020 at 11:12:30AM -0500, Chuck Lever wrote:
> >>>>>> The @nents value that was passed to ib_dma_map_sg() has to be passed
> >>>>>> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
> >>>>>> concatenate sg entries, it will return a different nents value than
> >>>>>> it was passed.
> >>>>>> 
> >>>>>> The bug was exposed by recent changes to the AMD IOMMU driver, which
> >>>>>> enabled sg entry concatenation.
> >>>>>> 
> >>>>>> Looking all the way back to commit 4143f34e01e9 ("xprtrdma: Port to
> >>>>>> new memory registration API") and reviewing other kernel ULPs, it's
> >>>>>> not clear that the frwr_map() logic was ever correct for this case.
> >>>>>> 
> >>>>>> Reported-by: Andre Tomt <andre@tomt.net>
> >>>>>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> >>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >>>>>> Cc: stable@vger.kernel.org # v5.5
> >>>>>> net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
> >>>>>> 1 file changed, 7 insertions(+), 6 deletions(-)
> >>>>> 
> >>>>> Yep
> >>>>> 
> >>>>> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> >>>> 
> >>>> Thanks.
> >>>> 
> >>>> Wondering if it makes sense to add a Fixes tag for the AMD IOMMU commit
> >>>> where NFS/RDMA stopped working, rather than the "Cc: stable # v5.5".
> >>>> 
> >>>> Fixes: be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the dma-iommu api")
> >>> 
> >>> Not really, this was broken for other configurations besides AMD
> >> 
> >> Agreed, but the bug seems to have been inconsequential until now?
> > 
> > I imagine it would get you on ARM or other archs, IIRC.
> 
> That's certainly plausible, but I haven't received explicit bug reports
> in this area. (I'm not at all saying that such bugs categorically do
> not exist).

Usually I encourage people to put the fixes line to the commit that is
being fixed, pointing at some other commit that happens to expose the
bug is not the best. 
 
> In any event, practical matters: the posted patch applies back to v5.4,
> but fails to apply starting with v5.3.
> 
> I think we can leave the "Cc: stable # v5.5"; and I'm open to requests
> to backport this simple fix onto earlier stable kernels (back to v4.4),
> which can be handled case-by-case. 'Salright?

I'd just put Cc: stable, the stable folks will reject it on earlier
versions because of conflicts and we can leave it.

Jason
