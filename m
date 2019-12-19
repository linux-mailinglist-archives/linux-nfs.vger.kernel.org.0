Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7641270D5
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 23:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfLSWnC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Dec 2019 17:43:02 -0500
Received: from fieldses.org ([173.255.197.46]:38778 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfLSWnC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Dec 2019 17:43:02 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 6D2961C7C; Thu, 19 Dec 2019 17:43:02 -0500 (EST)
Date:   Thu, 19 Dec 2019 17:43:02 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd4: Remove unneeded semicolon
Message-ID: <20191219224302.GD12026@fieldses.org>
References: <1576747760-120195-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576747760-120195-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applying.--b.

On Thu, Dec 19, 2019 at 05:29:20PM +0800, zhengbin wrote:
> Fixes coccicheck warning:
> 
> fs/nfsd/nfs4state.c:3376:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 369e574..54c2917 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3373,7 +3373,7 @@ static __be32 nfsd4_map_bcts_dir(u32 *dir)
>  	case NFS4_CDFC4_BACK_OR_BOTH:
>  		*dir = NFS4_CDFC4_BOTH;
>  		return nfs_ok;
> -	};
> +	}
>  	return nfserr_inval;
>  }
> 
> --
> 2.7.4
