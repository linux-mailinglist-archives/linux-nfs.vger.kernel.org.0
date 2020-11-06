Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6C42A9F8A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 22:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgKFVv3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 16:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgKFVv2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 16:51:28 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1683C0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Nov 2020 13:51:28 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5BF1C4F3A; Fri,  6 Nov 2020 16:51:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5BF1C4F3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1604699488;
        bh=9FlJEdCBypkoSaNwr8y05npAfUl3p+m6UrQhT0+QP9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PU/TPClO3jHXOK4nFwhSsLprkjiS8Z2BDU7xnE5yrH3ozFnvN9EeQiHwHehvsjrA5
         UoQgMMua8odMwPaBWROFNSJUiRk/NbEuYGrkCcRkrIKYg/h6Jr4V8Y50z/yo58EKhh
         JlrvA9kHIJk63h/O1QOipgZpS20zw0iDuBrW8JEg=
Date:   Fri, 6 Nov 2020 16:51:28 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc : make RPC channel buffer dynamic for slow case
Message-ID: <20201106215128.GD26028@fieldses.org>
References: <20201026150530.29019-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026150530.29019-1-rbergant@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 26, 2020 at 04:05:30PM +0100, Roberto Bergantinos Corpas wrote:
> RPC channel buffer size for slow case (user buffer bigger than
> one page) can be converted into dymanic and also allows us to
> prescind from queue_io_mutex

Sorry for the slow response.

Let's just remove cache_slow_downcall and the find_or_create_page()
thing and just do a kvmalloc() from the start.  I don't understand why
we need to be more complicated.

--b.

> 
> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> ---
>  net/sunrpc/cache.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index baef5ee43dbb..325393f75e17 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -777,7 +777,6 @@ void cache_clean_deferred(void *owner)
>   */
>  
>  static DEFINE_SPINLOCK(queue_lock);
> -static DEFINE_MUTEX(queue_io_mutex);
>  
>  struct cache_queue {
>  	struct list_head	list;
> @@ -908,14 +907,18 @@ static ssize_t cache_do_downcall(char *kaddr, const char __user *buf,
>  static ssize_t cache_slow_downcall(const char __user *buf,
>  				   size_t count, struct cache_detail *cd)
>  {
> -	static char write_buf[8192]; /* protected by queue_io_mutex */
> +	char *write_buf;
>  	ssize_t ret = -EINVAL;
>  
> -	if (count >= sizeof(write_buf))
> +	if (count >= 32768) /* 32k is max userland buffer, lets check anyway */
>  		goto out;
> -	mutex_lock(&queue_io_mutex);
> +
> +	write_buf = kvmalloc(count + 1, GFP_KERNEL);
> +	if (!write_buf)
> +		return -ENOMEM;
> +
>  	ret = cache_do_downcall(write_buf, buf, count, cd);
> -	mutex_unlock(&queue_io_mutex);
> +	kvfree(write_buf);
>  out:
>  	return ret;
>  }
> -- 
> 2.21.0
