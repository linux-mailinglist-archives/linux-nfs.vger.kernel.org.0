Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F461CDC4A
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2020 15:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgEKN6H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729641AbgEKN6H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 May 2020 09:58:07 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A1FC061A0C;
        Mon, 11 May 2020 06:58:07 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id AFAB132A8; Mon, 11 May 2020 09:58:06 -0400 (EDT)
Date:   Mon, 11 May 2020 09:58:06 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Ma Feng <mafeng.ma@huawei.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix old-style function definition
Message-ID: <20200511135806.GC8629@fieldses.org>
References: <1589198828-11226-1-git-send-email-mafeng.ma@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589198828-11226-1-git-send-email-mafeng.ma@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 11, 2020 at 08:07:08PM +0800, Ma Feng wrote:
> Fix warning:
> 
> fs/nfsd/nfssvc.c:604:6: warning: old-style function definition [-Wold-style-definition]
>  bool i_am_nfsd()

Applying for 5.8, thanks.--b.

>       ^~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
> ---
>  fs/nfsd/nfssvc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 4f588c0..b603dfc 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -601,7 +601,7 @@ static const struct svc_serv_ops nfsd_thread_sv_ops = {
>  	.svo_module		= THIS_MODULE,
>  };
> 
> -bool i_am_nfsd()
> +bool i_am_nfsd(void)
>  {
>  	return kthread_func(current) == nfsd;
>  }
> --
> 2.6.2
