Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B051417647A
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2020 20:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCBT6a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Mar 2020 14:58:30 -0500
Received: from fieldses.org ([173.255.197.46]:35990 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgCBT6a (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Mar 2020 14:58:30 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id E642C89A; Mon,  2 Mar 2020 14:58:29 -0500 (EST)
Date:   Mon, 2 Mar 2020 14:58:29 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] sunrpc: Replace zero-length array with
 flexible-array member
Message-ID: <20200302195829.GD1149@fieldses.org>
References: <20200228132323.GA20181@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228132323.GA20181@embeddedor>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 28, 2020 at 07:23:23AM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]

I don't understand the quoted sentences at all.  But I assume you're
telling me that sizeof(struct svc_deferred_req) won't be changed by this
patch, so, good, applied.  Thanks!

--b.

> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  include/linux/sunrpc/svc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 1afe38eb33f7..7f0a83451bc0 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -380,7 +380,7 @@ struct svc_deferred_req {
>  	struct cache_deferred_req handle;
>  	size_t			xprt_hlen;
>  	int			argslen;
> -	__be32			args[0];
> +	__be32			args[];
>  };
>  
>  struct svc_process_info {
> -- 
> 2.25.0
