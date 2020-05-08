Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C4B1CB176
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2020 16:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgEHOKu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 May 2020 10:10:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46017 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726792AbgEHOKu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 May 2020 10:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588947049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+NSc1IZw2NP0VZioknQOpKmTx5rvTSaPjH8dtZLwIw=;
        b=T+9eZc00uFx/KjckXoNLDNKoDa5st+xjRV3ZUxNchIC4wZfn1ZlUPH38JGoon7HLd+jtwl
        T6CPN/zVxRlhn7B/eB/iyvB5EZqw60s9Z9AWgQ6iAae6gKFx86ou+dLKpWDohsa/1O78MW
        FqGp4xR0wzPQlD2WEvmaqFTnwiV6XmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-XEQ2m0WmPxKRyO8u2-5NVg-1; Fri, 08 May 2020 10:10:47 -0400
X-MC-Unique: XEQ2m0WmPxKRyO8u2-5NVg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 868321009445;
        Fri,  8 May 2020 14:10:46 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4063A2E188;
        Fri,  8 May 2020 14:10:46 +0000 (UTC)
Subject: Re: [PATCH] Fix a buffer overflow in qword_add()
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
References: <20200416213453.80110-1-trondmy@kernel.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <9a49fcea-2576-e345-2450-6411e45e022f@RedHat.com>
Date:   Fri, 8 May 2020 10:10:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200416213453.80110-1-trondmy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/16/20 5:34 PM, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Don't allow writing beyond the end of the buffer.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Committed... (tag: nfs-utils-2-4-4-rc4)

steved.

> ---
>  support/nfs/cacheio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/support/nfs/cacheio.c b/support/nfs/cacheio.c
> index 126c12831668..70ead94d64f0 100644
> --- a/support/nfs/cacheio.c
> +++ b/support/nfs/cacheio.c
> @@ -42,7 +42,7 @@ void qword_add(char **bpp, int *lp, char *str)
>  
>  	if (len < 0) return;
>  
> -	while ((c=*str++) && len)
> +	while ((c=*str++) && len > 0)
>  		switch(c) {
>  		case ' ':
>  		case '\t':
> 

