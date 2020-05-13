Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5451D222E
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2020 00:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgEMWke (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 May 2020 18:40:34 -0400
Received: from fieldses.org ([173.255.197.46]:57804 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgEMWke (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 May 2020 18:40:34 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C5D1D7EC; Wed, 13 May 2020 18:40:33 -0400 (EDT)
Date:   Wed, 13 May 2020 18:40:33 -0400
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: 'Directory with parent 'rpc_clnt' already
 present!'
Message-ID: <20200513224033.GA1415@fieldses.org>
References: <1589409520-1344-1-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589409520-1344-1-git-send-email-bfields@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 13, 2020 at 06:38:40PM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> Each rpc_client has a cl_clid which is allocated from a global ida, and
> a debugfs directory which is named after cl_clid.
> 
> We're releasing the cl_clid before we free the debugfs directory named
> after it.  As soon as the cl_clid is released, that value is available
> for another newly created client.
> 
> That leaves a window where another client may attempt to create a new
> debugfs directory with the same name as the not-yet-deleted debugfs
> directory from the dying client.  Symptoms are log messages like
> 
> 	Directory 4 with parent 'rpc_clnt' already present!

This also cleared up a "file-max limit 199277 reached" warning, which
suggests to me a leak in an error path somewhere (I think everything's
supposed to work normally even if debugfs file createion fails), but I
don't see it.

--b.

> 
> Fixes: 7c4310ff5642 "SUNRPC: defer slow parts of rpc_free_client() to a workqueue."
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  net/sunrpc/clnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 8350d3a2e9a7..4a7efc00fd83 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -889,6 +889,7 @@ static void rpc_free_client_work(struct work_struct *work)
>  	 * here.
>  	 */
>  	rpc_clnt_debugfs_unregister(clnt);
> +	rpc_free_clid(clnt);
>  	rpc_clnt_remove_pipedir(clnt);
>  
>  	kfree(clnt);
> @@ -910,7 +911,6 @@ rpc_free_client(struct rpc_clnt *clnt)
>  	xprt_put(rcu_dereference_raw(clnt->cl_xprt));
>  	xprt_iter_destroy(&clnt->cl_xpi);
>  	put_cred(clnt->cl_cred);
> -	rpc_free_clid(clnt);
>  
>  	INIT_WORK(&clnt->cl_work, rpc_free_client_work);
>  	schedule_work(&clnt->cl_work);
> -- 
> 2.26.2
