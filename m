Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DF74C3064
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 16:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiBXPxz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 10:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbiBXPxy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 10:53:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4955D16DADC
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 07:53:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9AAF6170E
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 15:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA70C340E9;
        Thu, 24 Feb 2022 15:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645718002;
        bh=VLku9Es93sYEhb+gfaEyF/5JZebYLKqopUN2FBziooM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Hw6LBr9UetE1JZzE1//6mm3tIzTb0RZ1XRKKx/0vUxmtoh2w4lTjHs4aaphn5XGnJ
         hv4TFqOMp2LZfrMvsZFqxZfh6zdlHx/kVGsaHviNUXJNq8Z+S/y8IzMka2BLRCj+CW
         ZZrYzqzZS+r9biAurAuKt84uUSWBx2QY365XILO/JDhX0JswdH0LxKuEFnIpASWqTh
         fJsrkZoDwK7copcN1UfDa/l3Wjb1esdoXRUWOJG5yptvt8g6cDTz4CFBs3FvpKSm9Z
         Gh1AJscWXz+eD4EehKIANg4dxF/vkcYZY1EcRKoIdW3J9QrWCKUIrUKqw9mG8wzeFW
         gBxlzpZRBPu8Q==
Message-ID: <878848dcb0970cf1595aeea869fe9d5296bdeeb4.camel@kernel.org>
Subject: Re: nfsd: unable to allocate nfsd_file_hashtbl
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Thu, 24 Feb 2022 10:53:20 -0500
In-Reply-To: <C5BCCA52-9269-46D2-9972-EF59232B4E24@oracle.com>
References: <CAOQ4uxhYsci9-ADNTH6RZmnzBQoxy0ek4+Hgi9sK8HpF2ftrow@mail.gmail.com>
         <e3cdaeec85a6cfec980e87fc294327c0381c1778.camel@kernel.org>
         <C5BCCA52-9269-46D2-9972-EF59232B4E24@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-02-24 at 15:14 +0000, Chuck Lever III wrote:
> 
> > On Feb 24, 2022, at 6:07 AM, Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > On Thu, 2022-02-24 at 12:13 +0200, Amir Goldstein wrote:
> > > Hi Jeff,
> > > 
> > > I got some reports from customers about failure to allocate the
> > > nfsd_file_hashtbl on nfs server restart on a long running system,
> > > probably due to memory fragmentation.
> > > 
> > > A search in Google for this error message yields several results of
> > > similar reports [1][2].
> > > 
> > > My question is, does nfsd_file_cache_init() have to be done on server
> > > startup?
> > > 
> > > Doesn't it make more sense to allocate all the memory pools and
> > > hash table on init_nfsd()?
> > > 
> > > Thanks,
> > > Amir.
> > > 
> > > [1] https://unix.stackexchange.com/questions/640534/nfs-cannot-allocate-memory
> > > [2] https://askubuntu.com/questions/1365821/nfs-crashing-on-ubuntu-server-20-04
> > 
> > That is a big allocation. On my box, nfsd_fcache_bucket is 80 bytes, so
> > we end up needing 80 contiguous pages to allocate the whole table. It
> > doesn't surprise me that it fails sometimes.
> > 
> > We could just allocate it on init_nfsd, but that happens when the module
> > is plugged in and we'll lose 80 pages when people plug it in (or build
> > it in) and don't actually use nfsd.
> 
> Reducing the bucket count might also help, especially if nfb_head
> were to be replaced with an rb_tree to allow more items in each
> bucket.
> 
> 

I don't think you can do RCU traversal of an rbtree (can you?), and
you'd lose that ability if you switch to one. OTOH, maybe it doesn't buy
much, if you're looking to redesign that table for other reasons.

> > The other option might be to just use kvcalloc? It's not a frequent
> > allocation, so I don't think performance would be an issue. We had
> > similar reports several years ago with nfsd_reply_cache_init, and using
> > kvzalloc ended up taking care of it.
> 
> A better long-term solution would be to not require a large
> allocation at all. Maybe we could consider some alternative
> data structures.
> 

Sure, you could build it up from pages or something. That's a lot more
hassle though.

I don't see a problem with vmalloc here. This allocation only happens
when the nfs server is started, which is an infrequent occurrence. A
modest performance hit at that time to fix up the kernel pagetables
doesn't seem too awful.

This is almost exactly the same problem that 8f97514b423a (nfsd: more
robust allocation failure handling in nfsd_reply_cache_init) was
intended to fix, and that was suggested by the head penguin himself.

Here's what I'd suggest, but I haven't had time to test it out:

---------------------8<--------------------

[RFC PATCH] nfsd: use kvcalloc to allocate nfsd_file_hashtbl

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 8bc807c5fea4..cc2831cec669 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -632,7 +632,7 @@ nfsd_file_cache_init(void)
 	if (!nfsd_filecache_wq)
 		goto out;
 
-	nfsd_file_hashtbl = kcalloc(NFSD_FILE_HASH_SIZE,
+	nfsd_file_hashtbl = kvcalloc(NFSD_FILE_HASH_SIZE,
 				sizeof(*nfsd_file_hashtbl), GFP_KERNEL);
 	if (!nfsd_file_hashtbl) {
 		pr_err("nfsd: unable to allocate nfsd_file_hashtbl\n");
@@ -700,7 +700,7 @@ nfsd_file_cache_init(void)
 	nfsd_file_slab = NULL;
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
-	kfree(nfsd_file_hashtbl);
+	kvfree(nfsd_file_hashtbl);
 	nfsd_file_hashtbl = NULL;
 	destroy_workqueue(nfsd_filecache_wq);
 	nfsd_filecache_wq = NULL;
@@ -811,7 +811,7 @@ nfsd_file_cache_shutdown(void)
 	fsnotify_wait_marks_destroyed();
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
-	kfree(nfsd_file_hashtbl);
+	kvfree(nfsd_file_hashtbl);
 	nfsd_file_hashtbl = NULL;
 	destroy_workqueue(nfsd_filecache_wq);
 	nfsd_filecache_wq = NULL;
-- 
2.35.1


