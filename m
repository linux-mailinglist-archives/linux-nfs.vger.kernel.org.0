Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C5E37585
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2019 15:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfFFNoD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jun 2019 09:44:03 -0400
Received: from relay.sw.ru ([185.231.240.75]:33160 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfFFNoD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 6 Jun 2019 09:44:03 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hYsgC-0008Uh-Hh; Thu, 06 Jun 2019 16:43:44 +0300
Subject: Re: KASAN: use-after-free Read in unregister_shrinker
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     syzbot <syzbot+83a43746cebef3508b49@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, bfields@redhat.com,
        chris@chrisdown.name, daniel.m.jordan@oracle.com, guro@fb.com,
        hannes@cmpxchg.org, jlayton@kernel.org, laoar.shao@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, mgorman@techsingularity.net,
        mhocko@suse.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, yang.shi@linux.alibaba.com
References: <0000000000005a4b99058a97f42e@google.com>
 <b67a0f5d-c508-48a7-7643-b4251c749985@virtuozzo.com>
 <20190606131334.GA24822@fieldses.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <275f77ad-1962-6a60-e60b-6b8845f12c34@virtuozzo.com>
Date:   Thu, 6 Jun 2019 16:43:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606131334.GA24822@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 06.06.2019 16:13, J. Bruce Fields wrote:
> On Thu, Jun 06, 2019 at 10:47:43AM +0300, Kirill Tkhai wrote:
>> This may be connected with that shrinker unregistering is forgotten on error path.
> 
> I was wondering about that too.  Seems like it would be hard to hit
> reproduceably though: one of the later allocations would have to fail,
> then later you'd have to create another namespace and this time have a
> later module's init fail.

Yes, it's had to bump into this in real life.

AFAIU, syzbot triggers such the problem by using fault-injections
on allocation places should_failslab()->should_fail(). It's possible
to configure a specific slab, so the allocations will fail with
requested probability.
 
> This is the patch I have, which also fixes a (probably less important)
> failure to free the slab cache.
> 
> --b.
> 
> commit 17c869b35dc9
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Wed Jun 5 18:03:52 2019 -0400
> 
>     nfsd: fix cleanup of nfsd_reply_cache_init on failure
>     
>     Make sure everything is cleaned up on failure.
>     
>     Especially important for the shrinker, which will otherwise eventually
>     be freed while still referred to by global data structures.
>     
>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index ea39497205f0..3dcac164e010 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -157,12 +157,12 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
>  	nn->nfsd_reply_cache_shrinker.seeks = 1;
>  	status = register_shrinker(&nn->nfsd_reply_cache_shrinker);
>  	if (status)
> -		return status;
> +		goto out_nomem;
>  
>  	nn->drc_slab = kmem_cache_create("nfsd_drc",
>  				sizeof(struct svc_cacherep), 0, 0, NULL);
>  	if (!nn->drc_slab)
> -		goto out_nomem;
> +		goto out_shrinker;
>  
>  	nn->drc_hashtbl = kcalloc(hashsize,
>  				sizeof(*nn->drc_hashtbl), GFP_KERNEL);
> @@ -170,7 +170,7 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
>  		nn->drc_hashtbl = vzalloc(array_size(hashsize,
>  						 sizeof(*nn->drc_hashtbl)));
>  		if (!nn->drc_hashtbl)
> -			goto out_nomem;
> +			goto out_slab;
>  	}
>  
>  	for (i = 0; i < hashsize; i++) {
> @@ -180,6 +180,10 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
>  	nn->drc_hashsize = hashsize;
>  
>  	return 0;
> +out_slab:
> +	kmem_cache_destroy(nn->drc_slab);
> +out_shrinker:
> +	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
>  out_nomem:
>  	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
>  	return -ENOMEM;

Looks OK for me. Feel free to add my reviewed-by if you want.

Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

