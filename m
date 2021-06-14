Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27D43A7264
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jun 2021 01:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhFNXQp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 19:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhFNXQp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Jun 2021 19:16:45 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED901C061574
        for <linux-nfs@vger.kernel.org>; Mon, 14 Jun 2021 16:14:41 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 06FE86814; Mon, 14 Jun 2021 19:14:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 06FE86814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1623712481;
        bh=5mx/UpsjnshyzHxrnY65bNR7Yp+7xLz2y67iIKPjaaI=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=I6pWDKqltPMfoZFGTzg6My+N1b95Hmnwk71RA+DlaNoS5yAhWSCi8Jn8/+EjSdsFx
         akCAvIUjFrpeDqkDojpQZ67+LSRj3BMkq2hW91Hps8N4QpIfQy3usJ156wBBOMXRSn
         NvMRpQstVhhHq1cBGA5rXioNy7RIlMa7WwuMOHH4=
Date:   Mon, 14 Jun 2021 19:14:40 -0400
To:     schumaker.anna@gmail.com
Cc:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org,
        Anna.Schumaker@Netapp.com
Subject: Re: [PATCH] sunrpc: Avoid a KASAN slab-out-of-bounds bug in
 xdr_set_page_base()
Message-ID: <20210614231440.GD16500@fieldses.org>
References: <20210609210729.254578-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609210729.254578-1-Anna.Schumaker@Netapp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 09, 2021 at 05:07:29PM -0400, schumaker.anna@gmail.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> This seems to happen fairly easily during READ_PLUS testing on NFS v4.2.

Yep, I hit a KASAN warning here every time, and this fixes it,
thanks.--b.

> I found that we could end up accessing xdr->buf->pages[pgnr] with a pgnr
> greater than the number of pages in the array. So let's just return
> early if we're setting base to a point at the end of the page data and
> let xdr_set_tail_base() handle setting up the buffer pointers instead.
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  net/sunrpc/xdr.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 3964ff74ee51..ca10ba2626f2 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -1230,10 +1230,9 @@ static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
>  	void *kaddr;
>  
>  	maxlen = xdr->buf->page_len;
> -	if (base >= maxlen) {
> -		base = maxlen;
> -		maxlen = 0;
> -	} else
> +	if (base >= maxlen)
> +		return 0;
> +	else
>  		maxlen -= base;
>  	if (len > maxlen)
>  		len = maxlen;
> -- 
> 2.32.0
