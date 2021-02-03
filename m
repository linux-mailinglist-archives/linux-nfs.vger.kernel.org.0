Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADCD30DFEE
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 17:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBCQm5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 11:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhBCQmz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 11:42:55 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA42C0613D6
        for <linux-nfs@vger.kernel.org>; Wed,  3 Feb 2021 08:42:15 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id DBF2B6EB8; Wed,  3 Feb 2021 11:42:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DBF2B6EB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1612370533;
        bh=KiDwUCo85PHQpQpIPDyV92EJ0pcN+Jmf6NKwQnz+EXk=;
        h=Date:To:Cc:Subject:From:From;
        b=I922j/MxbWn/T2v+ZpZq5x0XIWXyE1BAD2avYa6zmQNwd5bUK4npQ/DmkN7Yogix1
         7SmYmmkVQsLz7eenFT5UMeqbMhzvoPojmXXb5tdMz2V6STvoX9Cf2f9gz+pHsJmI6+
         Udb1HNJDNMyvRB7oetDNpAA68/X9krEMPaQ8Qh4I=
Date:   Wed, 3 Feb 2021 11:42:13 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: register pernet ops last, unregister first
Message-ID: <20210203164213.GA26588@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

These pernet operations may depend on stuff set up or torn down in the
module init/exit functions.  And they may be called at any time in
between.  So it makes more sense for them to be the last to be
registered in the init function, and the first to be unregistered in the
exit function.

In particular, without this, the drc slab is being destroyed before all
the per-net drcs are shut down, resulting in an "Objects remaining in
nfsd_drc on __kmem_cache_shutdown()" warning in exit_nfsd.

Reported-by: Zhi Li <yieli@redhat.com>
Fixes: 3ba75830ce17 "nfsd4: drc containerization"
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfsctl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f6d5d783f4a4..0759e589ab52 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1522,12 +1522,9 @@ static int __init init_nfsd(void)
 	int retval;
 	printk(KERN_INFO "Installing knfsd (copyright (C) 1996 okir@monad.swb.de).\n");
 
-	retval = register_pernet_subsys(&nfsd_net_ops);
-	if (retval < 0)
-		return retval;
 	retval = register_cld_notifier();
 	if (retval)
-		goto out_unregister_pernet;
+		return retval;
 	retval = nfsd4_init_slabs();
 	if (retval)
 		goto out_unregister_notifier;
@@ -1544,9 +1541,14 @@ static int __init init_nfsd(void)
 		goto out_free_lockd;
 	retval = register_filesystem(&nfsd_fs_type);
 	if (retval)
+		goto out_free_exports;
+	retval = register_pernet_subsys(&nfsd_net_ops);
+	if (retval < 0)
 		goto out_free_all;
 	return 0;
 out_free_all:
+	unregister_pernet_subsys(&nfsd_net_ops);
+out_free_exports:
 	remove_proc_entry("fs/nfs/exports", NULL);
 	remove_proc_entry("fs/nfs", NULL);
 out_free_lockd:
@@ -1559,13 +1561,12 @@ static int __init init_nfsd(void)
 	nfsd4_free_slabs();
 out_unregister_notifier:
 	unregister_cld_notifier();
-out_unregister_pernet:
-	unregister_pernet_subsys(&nfsd_net_ops);
 	return retval;
 }
 
 static void __exit exit_nfsd(void)
 {
+	unregister_pernet_subsys(&nfsd_net_ops);
 	nfsd_drc_slab_free();
 	remove_proc_entry("fs/nfs/exports", NULL);
 	remove_proc_entry("fs/nfs", NULL);
@@ -1575,7 +1576,6 @@ static void __exit exit_nfsd(void)
 	nfsd4_exit_pnfs();
 	unregister_filesystem(&nfsd_fs_type);
 	unregister_cld_notifier();
-	unregister_pernet_subsys(&nfsd_net_ops);
 }
 
 MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
-- 
2.29.2

