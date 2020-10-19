Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC27292815
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Oct 2020 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgJSNUC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Oct 2020 09:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgJSNUC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Oct 2020 09:20:02 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC1DC0613CE
        for <linux-nfs@vger.kernel.org>; Mon, 19 Oct 2020 06:20:02 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C28A0C51; Mon, 19 Oct 2020 09:20:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C28A0C51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603113600;
        bh=evCE6xz3sABAPtexgXJc6/ccBpQpba+uBpeg2VcyFnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRJK7zi63/7W0oqUcUlmDATFlGN2gidjLdUc9u7aIW2VW4F0eibKJAIheoKZu6V3g
         0tpQ6D9Wg7d911aJzVckf380g/DjaNN4I1UEbN/+nthLwNv8oFLwUqrJshtK9vyOAF
         yVolQry03zGDWOutqcMXA2PJBzgoHzS7Wtkt6cz0=
Date:   Mon, 19 Oct 2020 09:20:00 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc: raise kernel RPC channel buffer size
Message-ID: <20201019132000.GA32403@fieldses.org>
References: <20201019093356.7395-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019093356.7395-1-rbergant@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 19, 2020 at 11:33:56AM +0200, Roberto Bergantinos Corpas wrote:
> Its possible that using AUTH_SYS and mountd manage-gids option a
> user may hit the 8k RPC channel buffer limit. This have been observed
> on field, causing unanswered RPCs on clients after mountd fails to
> write on channel :
> 
> rpc.mountd[11231]: auth_unix_gid: error writing reply
> 
> Userland nfs-utils uses a buffer size of 32k (RPC_CHAN_BUF_SIZE), so
> lets match those two.

Thanks, applying.

That should allow about 4000 group memberships.  If that doesn't do it
then maybe it's time to rethink....

--b.

> 
> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> ---
>  net/sunrpc/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index baef5ee43dbb..08df4c599ab3 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -908,7 +908,7 @@ static ssize_t cache_do_downcall(char *kaddr, const char __user *buf,
>  static ssize_t cache_slow_downcall(const char __user *buf,
>  				   size_t count, struct cache_detail *cd)
>  {
> -	static char write_buf[8192]; /* protected by queue_io_mutex */
> +	static char write_buf[32768]; /* protected by queue_io_mutex */
>  	ssize_t ret = -EINVAL;
>  
>  	if (count >= sizeof(write_buf))
> -- 
> 2.21.0
