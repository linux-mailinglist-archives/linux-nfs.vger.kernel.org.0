Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD422313BF
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jul 2020 22:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgG1UTC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jul 2020 16:19:02 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:35160 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgG1UTC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jul 2020 16:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595967541; x=1627503541;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=0cze+HalMMesmjlOUnqhOlmobCWHMFo1lFXE2WRXQy4=;
  b=gCa0QcL1a2nf0NOQR4H6ZZAX3W0CQ4fqmuuIDkrOxmrqLJFy3n9mZJhr
   ycHgukrNOAkzT54VXFIDn9KC1yWQKSQjz+S97fykoxYmd3Xx+WIFdGzjB
   2Ml3P0lGtzcpe+eV3812Q/KAMrkp1qhE4qs+v4Ltee09Lc4UcWDIxfrXr
   c=;
IronPort-SDR: IFTkACwcV5GK4yzPnNGox7G6KVD2NOlGMd6XS2J5mfSRZym9Am6+NOx65NpSB0gXXsB3FDtqW3
 WY8vqecZkCtw==
X-IronPort-AV: E=Sophos;i="5.75,407,1589241600"; 
   d="scan'208";a="55521430"
Subject: Re: [PATCH] NFSv4.2: Fix an error code in nfs4_xattr_cache_init()
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 28 Jul 2020 20:18:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 06EBAA04C7;
        Tue, 28 Jul 2020 20:18:54 +0000 (UTC)
Received: from EX13D34UEA004.ant.amazon.com (10.43.61.143) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 20:18:54 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D34UEA004.ant.amazon.com (10.43.61.143) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 20:18:54 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 28 Jul 2020 20:18:53 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id CE2B0C3B09; Tue, 28 Jul 2020 20:18:53 +0000 (UTC)
Date:   Tue, 28 Jul 2020 20:18:53 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Message-ID: <20200728201853.GA27458@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200727112344.GH389488@mwanda>
 <20200727163423.GA7563@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <4bb93c1413151ccbd918cc371c67555042763e11.camel@hammerspace.com>
 <20200728160953.GA1208@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <61d4e88c18818cd94dfbd14f054e6a2cb8858c8d.camel@hammerspace.com>
 <20200728180051.GA10902@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <13f86f29cc05944894813632bd537e559859e254.camel@hammerspace.com>
 <20200728181309.GA14661@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <d006b84e722cbebf9a94b8816bd59e11bc7d5219.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d006b84e722cbebf9a94b8816bd59e11bc7d5219.camel@hammerspace.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 28, 2020 at 06:21:19PM +0000, Trond Myklebust wrote:
> 
> On Tue, 2020-07-28 at 18:13 +0000, Frank van der Linden wrote:
> > On Tue, Jul 28, 2020 at 06:04:21PM +0000, Trond Myklebust wrote:
> > > On Tue, 2020-07-28 at 18:00 +0000, Frank van der Linden wrote:
> > > > On Tue, Jul 28, 2020 at 05:10:34PM +0000, Trond Myklebust wrote:
> > > > > On Tue, 2020-07-28 at 16:09 +0000, Frank van der Linden wrote:
> > > > > > Hi Trond,
> > > > > >
> > > > > > On Tue, Jul 28, 2020 at 03:17:12PM +0000, Trond Myklebust
> > > > > > wrote:
> > > > > > > On Mon, 2020-07-27 at 16:34 +0000, Frank van der Linden
> > > > > > > wrote:
> > > > > > > > Hi Dan,
> > > > > > > >
> > > > > > > > On Mon, Jul 27, 2020 at 02:23:44PM +0300, Dan Carpenter
> > > > > > > > wrote:
> > > > > > > > > This should return -ENOMEM on failure instead of
> > > > > > > > > success.
> > > > > > > > >
> > > > > > > > > Fixes: 95ad37f90c33 ("NFSv4.2: add client side xattr
> > > > > > > > > caching.")
> > > > > > > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > > > > > ---
> > > > > > > > > ---
> > > > > > > > >  fs/nfs/nfs42xattr.c | 4 +++-
> > > > > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
> > > > > > > > > index 23fdab977a2a..e75c4bb70266 100644
> > > > > > > > > --- a/fs/nfs/nfs42xattr.c
> > > > > > > > > +++ b/fs/nfs/nfs42xattr.c
> > > > > > > > > @@ -1040,8 +1040,10 @@ int __init
> > > > > > > > > nfs4_xattr_cache_init(void)
> > > > > > > > >                 goto out2;
> > > > > > > > >
> > > > > > > > >         nfs4_xattr_cache_wq =
> > > > > > > > > alloc_workqueue("nfs4_xattr",
> > > > > > > > > WQ_MEM_RECLAIM, 0);
> > > > > > > > > -       if (nfs4_xattr_cache_wq == NULL)
> > > > > > > > > +       if (nfs4_xattr_cache_wq == NULL) {
> > > > > > > > > +               ret = -ENOMEM;
> > > > > > > > >                 goto out1;
> > > > > > > > > +       }
> > > > > > > > >
> > > > > > > > >         ret =
> > > > > > > > > register_shrinker(&nfs4_xattr_cache_shrinker);
> > > > > > > > >         if (ret)
> > > > > > > > > --
> > > > > > > > > 2.27.0
> > > > > > > > >
> > > > > > > >
> > > > > > > > Thanks for catching that one. Since this is against
> > > > > > > > linux-
> > > > > > > > next
> > > > > > > > via
> > > > > > > > Trond,
> > > > > > > > I assume Trond will add it to his tree (right?)
> > > > > > > >
> > > > > > > > In any case:
> > > > > > > >
> > > > > > > >
> > > > > > > > Reviewed-by: Frank van der Linden <fllinden@amazon.com>
> > > > > > > >
> > > > > > > >
> > > > > > > > - Frank
> > > > > > >
> > > > > > > Frank, why do we need a workqueue here at all?
> > > > > >
> > > > > > The xattr caches are per-inode, and get created on demand.
> > > > > > Invalidating
> > > > > > a cache is done by setting the invalidate flag (as it is for
> > > > > > other
> > > > > > cached attribues and data).
> > > > > >
> > > > > > When nfs4_xattr_get_cache() sees an invalidated cache, it
> > > > > > will
> > > > > > just
> > > > > > unlink it
> > > > > > from the inode, and create a new one if needed.
> > > > > >
> > > > > > The old cache then still needs to be freed. Theoretically,
> > > > > > there
> > > > > > can
> > > > > > be
> > > > > > quite a few entries in it, and nfs4_xattr_get_cache() will be
> > > > > > called
> > > > > > in
> > > > > > the get/setxattr systemcall path. So my reasoning here was
> > > > > > that
> > > > > > it's
> > > > > > better
> > > > > > to use a workqueue to free the old invalidated cache instead
> > > > > > of
> > > > > > wasting
> > > > > > cycles in the I/O path.
> > > > > >
> > > > > > - Frank
> > > > >
> > > > > I think we might want to explore the reasons for this argument.
> > > > > We
> > > > > do
> > > > > not offload any other cache invalidations, and that includes
> > > > > the
> > > > > case
> > > > > when we have to invalidate the entire inode data cache before
> > > > > reading.
> > > > >
> > > > > So what is special about xattrs that causes invalidation to be
> > > > > a
> > > > > problem in the I/O path? Why do we expect them to grow so large
> > > > > that
> > > > > they are more unwieldy than the inode data cache?
> > > >
> > > > In the case of inode data, so you should probably invalidate it
> > > > immediately, or accept that you're serving up known-stale data.
> > > > So
> > > > offloading it doesn't seem like a good idea, and you'll just have
> > > > to
> > > > accept
> > > > the extra cycles you're using to do it.
> > > >
> > > > For this particular case, you're just reaping a cache that is no
> > > > longer
> > > > being used. There is no correctness gain in doing it in the I/O
> > > > path
> > > > -
> > > > the cache has already been orphaned and new getxattr/listxattr
> > > > calls
> > > > will not see it. So there doesn't seem to be a reason to do it in
> > > > the
> > > > I/O path at all.
> > > >
> > > > The caches shouldn't become very large, no. In the normal case,
> > > > there
> > > > shouldn't be much of a performance difference.
> > > >
> > > > Then again, what do you gain by doing the reaping of the cache in
> > > > the
> > > > I/O path,
> > > > instead of using a work queue? I concluded that there wasn't an
> > > > upside, only
> > > > a downside, so that's why I implemented it that way.
> > > >
> > > > If you think it's better to do it inline, I'm happy to change it,
> > > > of
> > > > course.
> > > > It would just mean getting rid of the work queue and the
> > > > reap_cache
> > > > function,
> > > > and calling discard_cache directly, instead of reap_cache.
> > > >
> > > > - Frank
> > >
> > > I think we should start with doing the freeing of the old cache
> > > inline.
> > > If it turns out to be a real performance problem, then we can later
> > > revisit using a work queue, however in that case, I'd prefer to use
> > > nfsiod rather than adding a special workqueue that is reserved for
> > > xattrs.
> >
> > Sure, I can do that.
> >
> > Do you want me to send a new version of the patch series, or an
> > incremental patch?
> 
> Please just send as an incremental patch.
> 
> Thanks!

Made the change, re-tested it. Patch sent - thanks!

- Frank
