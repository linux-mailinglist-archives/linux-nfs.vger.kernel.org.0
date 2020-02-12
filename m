Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7E715B121
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 20:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLTaj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 14:30:39 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34258 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgBLTai (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Feb 2020 14:30:38 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so1484925qvf.1
        for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2020 11:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xzu/ncQf5WgeFanPyQvlJFLgPf3gQ5F42l5EqqERH18=;
        b=TYHob6p1qJ+qgEi1KwVr+EzVRJkwR7gyLXp7gDPvbhp8KqpdOrg43H1P8ye95n26qB
         0ROE34cQZJw6JxzSbe9yiF1lrn/xWZZBy7YPNYWW8V3YUAVLMOEtkH1KgFttS4y+jns9
         j9sqhJbTKMWhjAq6//yBde23WMOfJ2KBmyGuYxgVb+sPSPr/+ApNI58osiTIx3DhjX3M
         ULeM/wSC7WHtMMHi+2Ys8V0b/Q9yRv9FPR66dwms33uqBGsxlLDJyMISypZXujZ+2cEf
         kA2HM6iWnqAiAS5PuJWZxgRbDPwPG7o4rwCgmn9mtzE7tlPtqc2oy8oPO6mUGdHB8PII
         ywig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xzu/ncQf5WgeFanPyQvlJFLgPf3gQ5F42l5EqqERH18=;
        b=lKYPp0s+mYLdWVtSw28cXsjVvP3KMGvl9ePcluSzpRumDaXuMYQdqlqI2tEkz3YHOS
         HiULmG2avHN7cCDGKf1WfxqHwZniFxt+CNPSY6fLQS7IQEdnWAJ/9X/YROWiyYOAI6E6
         oKD949B7FT0lpyqHYXObctXm2xEELUzcN+nYv0UTA+GnFlSnkmVq7vsXjMMjwXp+0D9H
         L6OPDACJJstY3iA+LuLWtxKDxEdh3WjLLEtkgAgAhmgSO7isBgVfInGTNHoVYyV3SFmn
         sE5fCX9LTQ09srhbpC4rKJ3APxQgqNJ52irLjolAeTQcsNEyrm77pdHdfu6JMSMZKzDy
         bqjQ==
X-Gm-Message-State: APjAAAUkLAHyF6wabfEC82HVwrbT/gGn27PqOd4wNt8rHHyeA71Q7k5r
        yWfDJFR3Fg7Qwj333wC1nry1jw==
X-Google-Smtp-Source: APXvYqx7O9HD3FQsEFGPtWX3i+DxnJGUyOvuCu2eAxegjnGyaaJnZVAyQ/8NWuTHnvmn9I1obW8kPw==
X-Received: by 2002:a05:6214:13a8:: with SMTP id h8mr20260768qvz.41.1581535837701;
        Wed, 12 Feb 2020 11:30:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n3sm766262qkn.105.2020.02.12.11.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 11:30:37 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1xiW-00028G-Sz; Wed, 12 Feb 2020 15:30:36 -0400
Date:   Wed, 12 Feb 2020 15:30:36 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 1/2] xprtrdma: Fix DMA scatter-gather list mapping
 imbalance
Message-ID: <20200212193036.GD31668@ziepe.ca>
References: <158152363458.433502.7428050218198466755.stgit@morisot.1015granger.net>
 <158152394998.433502.5623790463334839091.stgit@morisot.1015granger.net>
 <20200212182638.GA31668@ziepe.ca>
 <F7B6A553-0355-41BF-A209-E8D73D15A6A9@oracle.com>
 <20200212190545.GB31668@ziepe.ca>
 <B9D0EE52-469B-4CC4-A944-C3421DBB68B6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9D0EE52-469B-4CC4-A944-C3421DBB68B6@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 12, 2020 at 02:09:03PM -0500, Chuck Lever wrote:
> 
> 
> > On Feb 12, 2020, at 2:05 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Wed, Feb 12, 2020 at 01:38:59PM -0500, Chuck Lever wrote:
> >> 
> >>> On Feb 12, 2020, at 1:26 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>> 
> >>> On Wed, Feb 12, 2020 at 11:12:30AM -0500, Chuck Lever wrote:
> >>>> The @nents value that was passed to ib_dma_map_sg() has to be passed
> >>>> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
> >>>> concatenate sg entries, it will return a different nents value than
> >>>> it was passed.
> >>>> 
> >>>> The bug was exposed by recent changes to the AMD IOMMU driver, which
> >>>> enabled sg entry concatenation.
> >>>> 
> >>>> Looking all the way back to commit 4143f34e01e9 ("xprtrdma: Port to
> >>>> new memory registration API") and reviewing other kernel ULPs, it's
> >>>> not clear that the frwr_map() logic was ever correct for this case.
> >>>> 
> >>>> Reported-by: Andre Tomt <andre@tomt.net>
> >>>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> >>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >>>> Cc: stable@vger.kernel.org # v5.5
> >>>> net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
> >>>> 1 file changed, 7 insertions(+), 6 deletions(-)
> >>> 
> >>> Yep
> >>> 
> >>> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> >> 
> >> Thanks.
> >> 
> >> Wondering if it makes sense to add a Fixes tag for the AMD IOMMU commit
> >> where NFS/RDMA stopped working, rather than the "Cc: stable # v5.5".
> >> 
> >> Fixes: be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the dma-iommu api")
> > 
> > Not really, this was broken for other configurations besides AMD
> 
> Agreed, but the bug seems to have been inconsequential until now?

I imagine it would get you on ARM or other archs, IIRC.

Jason
