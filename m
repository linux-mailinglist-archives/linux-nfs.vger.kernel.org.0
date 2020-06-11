Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E01F6E8C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2020 22:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFKUMS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jun 2020 16:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgFKUMR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Jun 2020 16:12:17 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF64C08C5C1
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2020 13:09:20 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E6A14793C; Thu, 11 Jun 2020 16:09:19 -0400 (EDT)
Date:   Thu, 11 Jun 2020 16:09:19 -0400
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        steved@redhat.com
Subject: Re: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
Message-ID: <20200611200919.GF16376@fieldses.org>
References: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
 <1f3297c1549ad12d47497cd18d2c0d9bc7bc5fe7.camel@netapp.com>
 <803ff52e7e4fd7c2b2965368f8cd203b0da28f49.camel@hammerspace.com>
 <14cad1ec0a9080ce2ac064ff9a7ae76464e09aee.camel@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14cad1ec0a9080ce2ac064ff9a7ae76464e09aee.camel@netapp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 17, 2020 at 09:16:54PM +0000, Schumaker, Anna wrote:
> On Fri, 2020-01-17 at 21:14 +0000, Trond Myklebust wrote:
> > On Fri, 2020-01-17 at 21:09 +0000, Schumaker, Anna wrote:
> > > Hi Olga,
> > > 
> > > On Thu, 2020-01-16 at 14:08 -0500, Olga Kornievskaia wrote:
> > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > 
> > > Have you done any testing with nconnect and the v4.0 replay caches? I
> > > did some
> > > digging on the mailing list and found this in one of the cover
> > > letters from
> > > Trond: "The feature is only enabled for NFSv4.1 and NFSv4.2 for now;
> > > I don't
> > > feel comfortable subjecting NFSv3/v4 replay caches to this treatment
> > > yet."
> > > 
> > 
> > That comment should be considered obsolete. The current code works hard
> > to ensure that we replay using the same connection (or at least the
> > same source/dest IP+ports) so that NFSv3/v4.0 DRCs work as expected.
> > For that reason we've had NFSv3 support since the feature was merged.
> > The NFSv4.0 support was just forgotten.
> 
> Thanks for the explanation! I'll add the patch.

What happened to this patch?  As far as I can tell, the conclusion of
this thread was that it should be applied.

--b.

> 
> Anna
> 
> > 
> > > Thanks,
> > > Anna
> > > 
> > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > ---
> > > >  fs/nfs/nfs4client.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > > > index 460d625..4df3fb0 100644
> > > > --- a/fs/nfs/nfs4client.c
> > > > +++ b/fs/nfs/nfs4client.c
> > > > @@ -881,7 +881,7 @@ static int nfs4_set_client(struct nfs_server
> > > > *server,
> > > >  
> > > >  	if (minorversion == 0)
> > > >  		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
> > > > -	else if (proto == XPRT_TRANSPORT_TCP)
> > > > +	if (proto == XPRT_TRANSPORT_TCP)
> > > >  		cl_init.nconnect = nconnect;
> > > >  
> > > >  	if (server->flags & NFS_MOUNT_NORESVPORT)
> > -- 
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> > 
> > 
