Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F19151E6A
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2020 17:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBDQkw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Feb 2020 11:40:52 -0500
Received: from fieldses.org ([173.255.197.46]:37498 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgBDQkw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Feb 2020 11:40:52 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id CD7FBABE; Tue,  4 Feb 2020 11:40:51 -0500 (EST)
Date:   Tue, 4 Feb 2020 11:40:51 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, yaohongbo@huawei.com
Subject: Re: [PATCH -next] nfsd: make nfsd_filecache_wq variable static
Message-ID: <20200204164051.GA8763@fieldses.org>
References: <20200203014357.114717-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203014357.114717-1-chenzhou10@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applying.--b.

On Mon, Feb 03, 2020 at 09:43:57AM +0800, Chen Zhou wrote:
> Fix sparse warning:
> 
> fs/nfsd/filecache.c:55:25: warning:
> 	symbol 'nfsd_filecache_wq' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  fs/nfsd/filecache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 23c1fa5..22e77ed 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -52,7 +52,7 @@ struct nfsd_fcache_disposal {
>  	struct rcu_head rcu;
>  };
>  
> -struct workqueue_struct *nfsd_filecache_wq __read_mostly;
> +static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
>  
>  static struct kmem_cache		*nfsd_file_slab;
>  static struct kmem_cache		*nfsd_file_mark_slab;
> -- 
> 2.7.4
