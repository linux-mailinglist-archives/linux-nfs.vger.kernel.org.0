Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C4230EE7
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jul 2020 18:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgG1QKD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jul 2020 12:10:03 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:6248 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbgG1QKD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jul 2020 12:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595952602; x=1627488602;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=Y5sewiuQFEspHsNLeF2Wnt0vfBF68tFyw/DJByWABBc=;
  b=g//kuaGgUDIeNrbViI1dD/1FhNkJFVzB4TK6yY2cW6Eogu//kEDPm5SH
   Nw3d6/cjlFKRVK7sI2rxnGnc8BF6/NeraYrM+Uv2zs7mPGVY+lNvaTnBd
   v/pGhCZAmc2altJ3T+1FIUNq8UVFmBs6CvKHI7Poy5OMnNZx4xflgCZ13
   0=;
IronPort-SDR: qEAp4IPgblVCSIT9peOzZ8WgmMykdukcgGaHtx3zgnKJBjkEFVGDZu3kA0dFiExrR5NeDNnsP1
 OaEGA9HqLqrw==
X-IronPort-AV: E=Sophos;i="5.75,406,1589241600"; 
   d="scan'208";a="55435588"
Subject: Re: [PATCH] NFSv4.2: Fix an error code in nfs4_xattr_cache_init()
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 28 Jul 2020 16:09:54 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id EA29DA225A;
        Tue, 28 Jul 2020 16:09:53 +0000 (UTC)
Received: from EX13D08UWC002.ant.amazon.com (10.43.162.168) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 16:09:53 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D08UWC002.ant.amazon.com (10.43.162.168) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 16:09:53 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 28 Jul 2020 16:09:53 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 4ED7FC3B09; Tue, 28 Jul 2020 16:09:53 +0000 (UTC)
Date:   Tue, 28 Jul 2020 16:09:53 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Message-ID: <20200728160953.GA1208@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200727112344.GH389488@mwanda>
 <20200727163423.GA7563@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <4bb93c1413151ccbd918cc371c67555042763e11.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4bb93c1413151ccbd918cc371c67555042763e11.camel@hammerspace.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Tue, Jul 28, 2020 at 03:17:12PM +0000, Trond Myklebust wrote:
> 
> On Mon, 2020-07-27 at 16:34 +0000, Frank van der Linden wrote:
> > Hi Dan,
> >
> > On Mon, Jul 27, 2020 at 02:23:44PM +0300, Dan Carpenter wrote:
> > >
> > > This should return -ENOMEM on failure instead of success.
> > >
> > > Fixes: 95ad37f90c33 ("NFSv4.2: add client side xattr caching.")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > > ---
> > >  fs/nfs/nfs42xattr.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
> > > index 23fdab977a2a..e75c4bb70266 100644
> > > --- a/fs/nfs/nfs42xattr.c
> > > +++ b/fs/nfs/nfs42xattr.c
> > > @@ -1040,8 +1040,10 @@ int __init nfs4_xattr_cache_init(void)
> > >                 goto out2;
> > >
> > >         nfs4_xattr_cache_wq = alloc_workqueue("nfs4_xattr",
> > > WQ_MEM_RECLAIM, 0);
> > > -       if (nfs4_xattr_cache_wq == NULL)
> > > +       if (nfs4_xattr_cache_wq == NULL) {
> > > +               ret = -ENOMEM;
> > >                 goto out1;
> > > +       }
> > >
> > >         ret = register_shrinker(&nfs4_xattr_cache_shrinker);
> > >         if (ret)
> > > --
> > > 2.27.0
> > >
> >
> > Thanks for catching that one. Since this is against linux-next via
> > Trond,
> > I assume Trond will add it to his tree (right?)
> >
> > In any case:
> >
> >
> > Reviewed-by: Frank van der Linden <fllinden@amazon.com>
> >
> >
> > - Frank
> 
> Frank, why do we need a workqueue here at all?

The xattr caches are per-inode, and get created on demand. Invalidating
a cache is done by setting the invalidate flag (as it is for other
cached attribues and data).

When nfs4_xattr_get_cache() sees an invalidated cache, it will just unlink it
from the inode, and create a new one if needed.

The old cache then still needs to be freed. Theoretically, there can be
quite a few entries in it, and nfs4_xattr_get_cache() will be called in
the get/setxattr systemcall path. So my reasoning here was that it's better
to use a workqueue to free the old invalidated cache instead of wasting
cycles in the I/O path.

- Frank
