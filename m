Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF75E15B074
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 20:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgBLTFr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 14:05:47 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43921 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLTFr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Feb 2020 14:05:47 -0500
Received: by mail-qk1-f195.google.com with SMTP id p7so3128554qkh.10
        for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2020 11:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w4G1fGaYP4+ma5X8EybpeonMeudVB3EgYSs9cW8S8CY=;
        b=K7KZ/fmPhvM5osH9s/RrtnnBbNJWU2qkR1QKVMqB+pqbw+bvkl/YBmD1uGOFYIWVwR
         9rrZ2QiHUgGN1BOSoXyczqrkAAsqRs0bY1k6jZuonRFUkgrn7wY8iWcdqY4JekYNMYSK
         RCavA7MGaYa646AcltF8x16LC196y9bGHepNUzl7CX7eMoZwg1Y77sAVGaIvtznO9nTn
         FMTqhbVEZ/dLgonr42it9labFt2OnKo7epIhsuTc8GiIWap+HV5nYuCIKvsZgVP9Yyg/
         7Q72OY11LQUEEQt4PQVD1Ys0KLA4sGqMkRzKOquhTKOivR7eGJnm/6xDHZ2gVnfinh3U
         +kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w4G1fGaYP4+ma5X8EybpeonMeudVB3EgYSs9cW8S8CY=;
        b=rhr0NT9aRVouZv/EwfPG81DAPPW4Li4HUZUMYyMhyKERg5l1uHWJWwUzuhMOcB475q
         w/UpfjrzlAnGDGKI/MS/E043TQ3w9Q9Lt94N2QhhUSiQ8V/4OhNB75l8Qvsa1jIT1Ahc
         amI5LUEu9uBXvnes0uR/cQprwSLgGtPxvn60vF5g/OqvRHKF1ZAmjppltGq+LkUHwU+O
         W525b3kfOTKRdK7gWJbct5vYaU2vyp3ZyfaOQePMTBVLVpn9UM+DXDPWcV5y2yi6Ucl5
         OmeJkuMSRZ7WW2rZD8vDXqSce1GB/t4SvNVjthyVFqaDL2GeU0moMbGe91K1EFrh6df7
         SasA==
X-Gm-Message-State: APjAAAVj8lMuUga2mMBpjnBKYWzly4Mtjv226nISMSeJ2+QlJ4aP2TlD
        Claf2C9LnyT3zOqAZ+j0p+/SEg==
X-Google-Smtp-Source: APXvYqzHZm01/57tV3hpprip6LOvRIlZu7Abneb1XxI6C4oE6DeZbAfG00uE2/OXnVQpB6O57a549w==
X-Received: by 2002:a37:bfc5:: with SMTP id p188mr11128492qkf.283.1581534346638;
        Wed, 12 Feb 2020 11:05:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q5sm712746qkf.14.2020.02.12.11.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 11:05:46 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1xKT-0001K6-M5; Wed, 12 Feb 2020 15:05:45 -0400
Date:   Wed, 12 Feb 2020 15:05:45 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 1/2] xprtrdma: Fix DMA scatter-gather list mapping
 imbalance
Message-ID: <20200212190545.GB31668@ziepe.ca>
References: <158152363458.433502.7428050218198466755.stgit@morisot.1015granger.net>
 <158152394998.433502.5623790463334839091.stgit@morisot.1015granger.net>
 <20200212182638.GA31668@ziepe.ca>
 <F7B6A553-0355-41BF-A209-E8D73D15A6A9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7B6A553-0355-41BF-A209-E8D73D15A6A9@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 12, 2020 at 01:38:59PM -0500, Chuck Lever wrote:
> 
> > On Feb 12, 2020, at 1:26 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Wed, Feb 12, 2020 at 11:12:30AM -0500, Chuck Lever wrote:
> >> The @nents value that was passed to ib_dma_map_sg() has to be passed
> >> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
> >> concatenate sg entries, it will return a different nents value than
> >> it was passed.
> >> 
> >> The bug was exposed by recent changes to the AMD IOMMU driver, which
> >> enabled sg entry concatenation.
> >> 
> >> Looking all the way back to commit 4143f34e01e9 ("xprtrdma: Port to
> >> new memory registration API") and reviewing other kernel ULPs, it's
> >> not clear that the frwr_map() logic was ever correct for this case.
> >> 
> >> Reported-by: Andre Tomt <andre@tomt.net>
> >> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> Cc: stable@vger.kernel.org # v5.5
> >> net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
> >> 1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > Yep
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> Thanks.
> 
> Wondering if it makes sense to add a Fixes tag for the AMD IOMMU commit
> where NFS/RDMA stopped working, rather than the "Cc: stable # v5.5".
> 
> Fixes: be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the dma-iommu api")

Not really, this was broken for other configurations besides AMD

Jason 
