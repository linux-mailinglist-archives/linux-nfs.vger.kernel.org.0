Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3398030E17D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 18:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhBCRxP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 12:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhBCRxO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 12:53:14 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1335DC0613ED
        for <linux-nfs@vger.kernel.org>; Wed,  3 Feb 2021 09:52:34 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 22C516F04; Wed,  3 Feb 2021 12:52:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 22C516F04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1612374753;
        bh=B9WUy4QA1L4Xvxvnpx0md3xtZtJUXokmMSg4o2/2YQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JB/zDVIYzTqFm4P9GPDb9IqTdUugNm/pJekGM9QTpia8sowH1cYnikcHzXXwVViGf
         0kLT2qn6ict/jGjA8JkALkPnzzGd69wMI6NN43kznwSX0xVfDHDq/KRQWXTVYVWmSl
         WOpqP8ArS7XQR7pHfknjgM+j4FesWWI6O68Tl//M=
Date:   Wed, 3 Feb 2021 12:52:33 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: register pernet ops last, unregister first
Message-ID: <20210203175233.GB26588@fieldses.org>
References: <20210203164213.GA26588@fieldses.org>
 <70729484-C3C8-477F-8FE3-06B6A70510C6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70729484-C3C8-477F-8FE3-06B6A70510C6@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 03, 2021 at 04:45:56PM +0000, Chuck Lever wrote:
> Hi Bruce-
> 
> 
> > On Feb 3, 2021, at 11:42 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > These pernet operations may depend on stuff set up or torn down in the
> > module init/exit functions.  And they may be called at any time in
> > between.  So it makes more sense for them to be the last to be
> > registered in the init function, and the first to be unregistered in the
> > exit function.
> > 
> > In particular, without this, the drc slab is being destroyed before all
> > the per-net drcs are shut down, resulting in an "Objects remaining in
> > nfsd_drc on __kmem_cache_shutdown()" warning in exit_nfsd.
> > 
> > Reported-by: Zhi Li <yieli@redhat.com>
> > Fixes: 3ba75830ce17 "nfsd4: drc containerization"
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 
> I can't tell how urgent this is. Does it belong in 5.11-rc?

I dunno, I wonder what happens when you try to write to and then free a
bunch of objects that were allocated from a slab that no longer exists.

But, it's triggered by unloading nfsd, and I find it hard to be super
concerned about module unloading bugs (does anyone actually *need* to
unload the nfsd module?).

--b.

> 
> 
> > ---
> > fs/nfsd/nfsctl.c | 14 +++++++-------
> > 1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index f6d5d783f4a4..0759e589ab52 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1522,12 +1522,9 @@ static int __init init_nfsd(void)
> > 	int retval;
> > 	printk(KERN_INFO "Installing knfsd (copyright (C) 1996 okir@monad.swb.de).\n");
> > 
> > -	retval = register_pernet_subsys(&nfsd_net_ops);
> > -	if (retval < 0)
> > -		return retval;
> > 	retval = register_cld_notifier();
> > 	if (retval)
> > -		goto out_unregister_pernet;
> > +		return retval;
> > 	retval = nfsd4_init_slabs();
> > 	if (retval)
> > 		goto out_unregister_notifier;
> > @@ -1544,9 +1541,14 @@ static int __init init_nfsd(void)
> > 		goto out_free_lockd;
> > 	retval = register_filesystem(&nfsd_fs_type);
> > 	if (retval)
> > +		goto out_free_exports;
> > +	retval = register_pernet_subsys(&nfsd_net_ops);
> > +	if (retval < 0)
> > 		goto out_free_all;
> > 	return 0;
> > out_free_all:
> > +	unregister_pernet_subsys(&nfsd_net_ops);
> > +out_free_exports:
> > 	remove_proc_entry("fs/nfs/exports", NULL);
> > 	remove_proc_entry("fs/nfs", NULL);
> > out_free_lockd:
> > @@ -1559,13 +1561,12 @@ static int __init init_nfsd(void)
> > 	nfsd4_free_slabs();
> > out_unregister_notifier:
> > 	unregister_cld_notifier();
> > -out_unregister_pernet:
> > -	unregister_pernet_subsys(&nfsd_net_ops);
> > 	return retval;
> > }
> > 
> > static void __exit exit_nfsd(void)
> > {
> > +	unregister_pernet_subsys(&nfsd_net_ops);
> > 	nfsd_drc_slab_free();
> > 	remove_proc_entry("fs/nfs/exports", NULL);
> > 	remove_proc_entry("fs/nfs", NULL);
> > @@ -1575,7 +1576,6 @@ static void __exit exit_nfsd(void)
> > 	nfsd4_exit_pnfs();
> > 	unregister_filesystem(&nfsd_fs_type);
> > 	unregister_cld_notifier();
> > -	unregister_pernet_subsys(&nfsd_net_ops);
> > }
> > 
> > MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
> > -- 
> > 2.29.2
> > 
> 
> --
> Chuck Lever
> 
> 
