Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1780C52F004
	for <lists+linux-nfs@lfdr.de>; Fri, 20 May 2022 18:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351268AbiETQFX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 May 2022 12:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351294AbiETQFV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 May 2022 12:05:21 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD417CE6F
        for <linux-nfs@vger.kernel.org>; Fri, 20 May 2022 09:05:19 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 969C65BD0; Fri, 20 May 2022 12:05:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 969C65BD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1653062718;
        bh=5Ci6tjwKwMhq8lVrdwXIYJlZeytZ0oVZ1y/X7T5ZHyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rrGqc4swhsL/n+MBTK48ra00gZMlzTbzTQvxjpOKo1N4paoVOCCmx5UJ+vfSFUZmr
         bD4Jm6pvv1THYW0RmG04nH9ztbGGqvOmRdOxvm8AKsZiI17kx6jforExKmDldF3+2J
         m+ImUTrZOz+YpjLZWHRsSfPpHZn2y0bpqIwYzDIU=
Date:   Fri, 20 May 2022 12:05:18 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "luomeng12@huawei.com" <luomeng12@huawei.com>
Subject: Re: [PATCH] nfsd: Fix null-ptr-deref in nfsd_fill_super()
Message-ID: <20220520160518.GD15318@fieldses.org>
References: <20220520023106.6651-1-zhangxiaoxu5@huawei.com>
 <EB2E6FAD-AEC6-48B4-AC02-634941D80687@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB2E6FAD-AEC6-48B4-AC02-634941D80687@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 20, 2022 at 03:22:51PM +0000, Chuck Lever III wrote:
> [ Note well: Updated Bruce's email address. ]
> 
> 
> > On May 19, 2022, at 10:31 PM, Zhang Xiaoxu <zhangxiaoxu5@huawei.com> wrote:
> > 
> > KASAN report null-ptr-deref as follows:
> > 
> >  BUG: KASAN: null-ptr-deref in nfsd_fill_super+0xc6/0xe0 [nfsd]
> >  Write of size 8 at addr 000000000000005d by task a.out/852
> > 
> >  CPU: 7 PID: 852 Comm: a.out Not tainted 5.18.0-rc7-dirty #66
> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
> >  Call Trace:
> >   <TASK>
> >   dump_stack_lvl+0x34/0x44
> >   kasan_report+0xab/0x120
> >   ? nfsd_mkdir+0x71/0x1c0 [nfsd]
> >   ? nfsd_fill_super+0xc6/0xe0 [nfsd]
> >   nfsd_fill_super+0xc6/0xe0 [nfsd]
> >   ? nfsd_mkdir+0x1c0/0x1c0 [nfsd]
> >   get_tree_keyed+0x8e/0x100
> >   vfs_get_tree+0x41/0xf0
> >   __do_sys_fsconfig+0x590/0x670
> >   ? fscontext_read+0x180/0x180
> >   ? anon_inode_getfd+0x4f/0x70
> >   do_syscall_64+0x35/0x80
> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > This can be reproduce by concurrent operations:
> > 	1. fsopen(nfsd)/fsconfig
> > 	2. insmod/rmmod nfsd
> > 
> > Since the nfsd file system is registered before than nfsd_net allocated,
> > the caller may get the file_system_type and use the nfsd_net before it
> > allocated, then null-ptr-deref occured.
> > 
> > So should allocate the nfsd_net firstly, other than register file system.
> 
> IIUC, I suggest: "So init_nfsd() should call register_filesystem() last."
> 
> 
> > Fixes: bd5ae9288d64 ("nfsd: register pernet ops last, unregister first")
> > Cc: stable@kernel.org
> > Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> 
> I think this looks right. Bruce, as author of bd5ae9288d64, any
> thoughts?

I'm not seeing any problem with the patch.

	Reviewed-by: J. Bruce Fields <bfields@fieldses.org>

--b.

> 
> I need a v2 of this, though. The current version conflicts with the
> courteous server patches already in my for-next branch. See:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=for-next
> 
> 
> > ---
> > fs/nfsd/nfsctl.c | 14 +++++++-------
> > 1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 16920e4512bd..e17100e90e19 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1535,20 +1535,20 @@ static int __init init_nfsd(void)
> > 	retval = create_proc_exports_entry();
> > 	if (retval)
> > 		goto out_free_lockd;
> > -	retval = register_filesystem(&nfsd_fs_type);
> > -	if (retval)
> > -		goto out_free_exports;
> > 	retval = register_pernet_subsys(&nfsd_net_ops);
> > 	if (retval < 0)
> > -		goto out_free_filesystem;
> > +		goto out_free_exports;
> > 	retval = register_cld_notifier();
> > +	if (retval)
> > +		goto out_free_subsys;
> > +	retval = register_filesystem(&nfsd_fs_type);
> > 	if (retval)
> > 		goto out_free_all;
> > 	return 0;
> > out_free_all:
> > +	unregister_cld_notifier();
> > +out_free_subsys:
> > 	unregister_pernet_subsys(&nfsd_net_ops);
> > -out_free_filesystem:
> > -	unregister_filesystem(&nfsd_fs_type);
> > out_free_exports:
> > 	remove_proc_entry("fs/nfs/exports", NULL);
> > 	remove_proc_entry("fs/nfs", NULL);
> > @@ -1566,6 +1566,7 @@ static int __init init_nfsd(void)
> > 
> > static void __exit exit_nfsd(void)
> > {
> > +	unregister_filesystem(&nfsd_fs_type);
> > 	unregister_cld_notifier();
> > 	unregister_pernet_subsys(&nfsd_net_ops);
> > 	nfsd_drc_slab_free();
> > @@ -1575,7 +1576,6 @@ static void __exit exit_nfsd(void)
> > 	nfsd_lockd_shutdown();
> > 	nfsd4_free_slabs();
> > 	nfsd4_exit_pnfs();
> > -	unregister_filesystem(&nfsd_fs_type);
> > }
> > 
> > MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
> > -- 
> > 2.31.1
> > 
> 
> --
> Chuck Lever
> 
> 
