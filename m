Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65F31C7ADD
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2020 22:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgEFUB2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 May 2020 16:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgEFUB2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 May 2020 16:01:28 -0400
X-Greylist: delayed 81360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 May 2020 13:01:27 PDT
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC9DC061A0F;
        Wed,  6 May 2020 13:01:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 098E3BDB; Wed,  6 May 2020 16:01:27 -0400 (EDT)
Date:   Wed, 6 May 2020 16:01:27 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     chuck.lever@oracle.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, davem@davemloft.net, kuba@kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sunrpc: Remove unused function ip_map_update
Message-ID: <20200506200127.GC21307@fieldses.org>
References: <20200505084537.52372-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505084537.52372-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applying for 5.8.--b.

On Tue, May 05, 2020 at 04:45:37PM +0800, YueHaibing wrote:
> commit 49b28684fdba ("nfsd: Remove deprecated nfsctl system call and related code.")
> left behind this, remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/sunrpc/svcauth_unix.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> index 6c8f802c4261..97c0bddba7a3 100644
> --- a/net/sunrpc/svcauth_unix.c
> +++ b/net/sunrpc/svcauth_unix.c
> @@ -332,15 +332,6 @@ static int __ip_map_update(struct cache_detail *cd, struct ip_map *ipm,
>  	return 0;
>  }
>  
> -static inline int ip_map_update(struct net *net, struct ip_map *ipm,
> -		struct unix_domain *udom, time64_t expiry)
> -{
> -	struct sunrpc_net *sn;
> -
> -	sn = net_generic(net, sunrpc_net_id);
> -	return __ip_map_update(sn->ip_map_cache, ipm, udom, expiry);
> -}
> -
>  void svcauth_unix_purge(struct net *net)
>  {
>  	struct sunrpc_net *sn;
> -- 
> 2.17.1
> 
