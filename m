Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407D44641CC
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Nov 2021 23:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344681AbhK3W4O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Nov 2021 17:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhK3W4N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Nov 2021 17:56:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D135C061574
        for <linux-nfs@vger.kernel.org>; Tue, 30 Nov 2021 14:52:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 552FCB81D7B
        for <linux-nfs@vger.kernel.org>; Tue, 30 Nov 2021 22:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6D6C53FC7;
        Tue, 30 Nov 2021 22:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638312771;
        bh=YxX1zYCLD+GtsUEGeuvDJsPNckaW9l6VxVyq9Ak9Cns=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SvxrQCy84ou9dB0fOASBkHyzW7M27Q+KWbD6wvXajomu/JNeGFKW0Sxb78/eJTdfo
         YnGy64WCXZBbMePN+iByTcJh6BKDafzdFFeBkZJTAD69hJew2uQGI+6FG2PYO8By0r
         aqx2ZOxF/Hbo++2tA9fYKxo4CqD/OgImJ/DkYcTGe4mr6622sasOZvytXt7tmi8rSh
         3o0wUyRh93SVe0fBMejmmRngaxEyCVZiqKal/ASGcpxfwdVcPclrITsRnFQMX+PZPB
         /zYMLiH+h6kP6eBBXy8SMUqNXzoVK4p3oQqevrV5yiA2eKp98CoAWrVWCOcdCblnr9
         kEc2LRlOtxheA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D4BDA5C0367; Tue, 30 Nov 2021 14:52:50 -0800 (PST)
Date:   Tue, 30 Nov 2021 14:52:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: Fix RCU-related sparse splat
Message-ID: <20211130225250.GC641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <163821156142.90770.4019362941494014139.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163821156142.90770.4019362941494014139.stgit@bazille.1015granger.net>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 29, 2021 at 01:46:07PM -0500, Chuck Lever wrote:
> To address this error:
> 
>   CC [M]  fs/nfsd/filecache.o
>   CHECK   /home/cel/src/linux/linux/fs/nfsd/filecache.c
> /home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9: error: incompatible types in comparison expression (different address spaces):
> /home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9:    struct net [noderef] __rcu *
> /home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9:    struct net *
> 
> The "net" field in struct nfsd_fcache_disposal is not annotated as
> requiring an RCU assignment, so replace the macro that includes an
> invocation of rcu_check_sparse() with an equivalent that does not.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

From an RCU perspective:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

But it would be good to get someone more familiar with the code to
look at this.

							Thanx, Paul

> ---
>  fs/nfsd/filecache.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index fdf89fcf1a0c..3b172eda0e9a 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -772,7 +772,7 @@ nfsd_alloc_fcache_disposal(struct net *net)
>  static void
>  nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
>  {
> -	rcu_assign_pointer(l->net, NULL);
> +	WRITE_ONCE(l->net, NULL);
>  	cancel_work_sync(&l->work);
>  	nfsd_file_dispose_list(&l->freeme);
>  	kfree_rcu(l, rcu);
> 
