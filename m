Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079904587E0
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Nov 2021 02:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhKVCCL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Nov 2021 21:02:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhKVCCK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 21 Nov 2021 21:02:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11ECF60230;
        Mon, 22 Nov 2021 01:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637546345;
        bh=Sdz3R7rCSmnGjH1JloixPWxi0Q/xtZeLKoN7MSxb4BM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uVS5frI005Mp/RorPEZY+/oWK/P6gFR6UpKRInKTMWyepj5Lg6OqEv0hxUuhYd+9J
         qkCMuIQsUmGoUoJKW9F01+TfIeOh+yH7UPwnOB+7CLh9f32W5ppygi34AIjD0P4y/1
         W06ube6RtGK4cfBl0tzcDsysqcgVhhQOm1El2oY3vk6jFSy3rIG15U/LV9VQ8IIXkI
         Jbq5OFLEPvmiU8Cyj8QuOWMjOj424oLl9IKXcalhkharOcoMzj4LDp87mgAPiXMNuy
         1VZGFDf779bQOnhUrN/RGjQtg+Bdz8Q8aauAZllh1u1j7pbiuW44OGufVI1FJTZ26z
         uRo57Ml6pmidQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D02595C4134; Sun, 21 Nov 2021 17:59:04 -0800 (PST)
Date:   Sun, 21 Nov 2021 17:59:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: Fix misuse of rcu_assign_pointer
Message-ID: <20211122015904.GH641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <163752463469.1397.703567874113623042.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163752463469.1397.703567874113623042.stgit@bazille.1015granger.net>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Nov 21, 2021 at 02:57:14PM -0500, Chuck Lever wrote:
> To address this error:
> 
>   CC [M]  fs/nfsd/filecache.o
>   CHECK   /home/cel/src/linux/linux/fs/nfsd/filecache.c
> /home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9: error: incompatible types in comparison expression (different address spaces):
> /home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9:    struct net [noderef] __rcu *
> /home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9:    struct net *
> 
> The "net" field in struct nfsd_fcache_disposal is not annotated as
> requiring an RCU assignment.

I am not immediately seeing this field indirected through by RCU readers,
though maybe that is happening in some other file.

However, it does look like this field is being accessed locklessly by
read-side code.  What prevents the compiler from applying unfortunate
optimizations?

See tools/memory-model/Documentation/access-marking.txt in a recent
kernel or these LWN articles: https://lwn.net/Articles/816854 and
https://lwn.net/Articles/793253.

							Thanx, Paul

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index fdf89fcf1a0c..3fa172f86441 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -772,7 +772,7 @@ nfsd_alloc_fcache_disposal(struct net *net)
>  static void
>  nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
>  {
> -	rcu_assign_pointer(l->net, NULL);
> +	l->net = NULL;
>  	cancel_work_sync(&l->work);
>  	nfsd_file_dispose_list(&l->freeme);
>  	kfree_rcu(l, rcu);
> 
