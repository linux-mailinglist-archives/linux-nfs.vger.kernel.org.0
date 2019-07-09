Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7563E66
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2019 01:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfGIXg4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 19:36:56 -0400
Received: from fieldses.org ([173.255.197.46]:52808 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfGIXg4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 9 Jul 2019 19:36:56 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 4674E1C17; Tue,  9 Jul 2019 19:36:56 -0400 (EDT)
Date:   Tue, 9 Jul 2019 19:36:56 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     chuck.lever@oracle.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH -next] nfsd: Make __get_nfsdfs_client() static
Message-ID: <20190709233656.GC1536@fieldses.org>
References: <20190708125408.56016-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708125408.56016-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applied.--b.

On Mon, Jul 08, 2019 at 08:54:08PM +0800, YueHaibing wrote:
> Fix sparse warning:
> 
> fs/nfsd/nfsctl.c:1221:22: warning:
>  symbol '__get_nfsdfs_client' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/nfsd/nfsctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 53833b3..0a9a49d 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1218,7 +1218,7 @@ static void clear_ncl(struct inode *inode)
>  }
>  
>  
> -struct nfsdfs_client *__get_nfsdfs_client(struct inode *inode)
> +static struct nfsdfs_client *__get_nfsdfs_client(struct inode *inode)
>  {
>  	struct nfsdfs_client *nc = inode->i_private;
>  
> -- 
> 2.7.4
> 
