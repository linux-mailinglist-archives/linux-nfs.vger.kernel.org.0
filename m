Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34619BB96E
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2019 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbfIWQU0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Sep 2019 12:20:26 -0400
Received: from fieldses.org ([173.255.197.46]:57724 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388829AbfIWQU0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Sep 2019 12:20:26 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 08BDFBCC; Mon, 23 Sep 2019 12:20:26 -0400 (EDT)
Date:   Mon, 23 Sep 2019 12:20:26 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] nfsd: Make nfsd_reset_boot_verifier_locked static
Message-ID: <20190923162026.GB1228@fieldses.org>
References: <20190923055859.5616-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923055859.5616-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 23, 2019 at 01:58:59PM +0800, YueHaibing wrote:
> Fix sparse warning:
> 
> fs/nfsd/nfssvc.c:364:6: warning:
>  symbol 'nfsd_reset_boot_verifier_locked' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

OK, applied for 5.4.--b.

> ---
>  fs/nfsd/nfssvc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 3caaf56..fdf7ed4 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -361,7 +361,7 @@ void nfsd_copy_boot_verifier(__be32 verf[2], struct nfsd_net *nn)
>  	done_seqretry(&nn->boot_lock, seq);
>  }
>  
> -void nfsd_reset_boot_verifier_locked(struct nfsd_net *nn)
> +static void nfsd_reset_boot_verifier_locked(struct nfsd_net *nn)
>  {
>  	ktime_get_real_ts64(&nn->nfssvc_boot);
>  }
> -- 
> 2.7.4
> 
