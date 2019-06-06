Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C000374E9
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2019 15:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFFNNf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jun 2019 09:13:35 -0400
Received: from fieldses.org ([173.255.197.46]:36386 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFFNNf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 6 Jun 2019 09:13:35 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 8384214DB; Thu,  6 Jun 2019 09:13:34 -0400 (EDT)
Date:   Thu, 6 Jun 2019 09:13:34 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     syzbot <syzbot+83a43746cebef3508b49@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, bfields@redhat.com,
        chris@chrisdown.name, daniel.m.jordan@oracle.com, guro@fb.com,
        hannes@cmpxchg.org, jlayton@kernel.org, laoar.shao@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, mgorman@techsingularity.net,
        mhocko@suse.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, yang.shi@linux.alibaba.com
Subject: Re: KASAN: use-after-free Read in unregister_shrinker
Message-ID: <20190606131334.GA24822@fieldses.org>
References: <0000000000005a4b99058a97f42e@google.com>
 <b67a0f5d-c508-48a7-7643-b4251c749985@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b67a0f5d-c508-48a7-7643-b4251c749985@virtuozzo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 06, 2019 at 10:47:43AM +0300, Kirill Tkhai wrote:
> This may be connected with that shrinker unregistering is forgotten on error path.

I was wondering about that too.  Seems like it would be hard to hit
reproduceably though: one of the later allocations would have to fail,
then later you'd have to create another namespace and this time have a
later module's init fail.

This is the patch I have, which also fixes a (probably less important)
failure to free the slab cache.

--b.

commit 17c869b35dc9
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Wed Jun 5 18:03:52 2019 -0400

    nfsd: fix cleanup of nfsd_reply_cache_init on failure
    
    Make sure everything is cleaned up on failure.
    
    Especially important for the shrinker, which will otherwise eventually
    be freed while still referred to by global data structures.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index ea39497205f0..3dcac164e010 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -157,12 +157,12 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	nn->nfsd_reply_cache_shrinker.seeks = 1;
 	status = register_shrinker(&nn->nfsd_reply_cache_shrinker);
 	if (status)
-		return status;
+		goto out_nomem;
 
 	nn->drc_slab = kmem_cache_create("nfsd_drc",
 				sizeof(struct svc_cacherep), 0, 0, NULL);
 	if (!nn->drc_slab)
-		goto out_nomem;
+		goto out_shrinker;
 
 	nn->drc_hashtbl = kcalloc(hashsize,
 				sizeof(*nn->drc_hashtbl), GFP_KERNEL);
@@ -170,7 +170,7 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 		nn->drc_hashtbl = vzalloc(array_size(hashsize,
 						 sizeof(*nn->drc_hashtbl)));
 		if (!nn->drc_hashtbl)
-			goto out_nomem;
+			goto out_slab;
 	}
 
 	for (i = 0; i < hashsize; i++) {
@@ -180,6 +180,10 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	nn->drc_hashsize = hashsize;
 
 	return 0;
+out_slab:
+	kmem_cache_destroy(nn->drc_slab);
+out_shrinker:
+	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
 out_nomem:
 	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
 	return -ENOMEM;
