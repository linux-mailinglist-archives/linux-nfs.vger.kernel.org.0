Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7019114428D
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2020 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUQyi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jan 2020 11:54:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45222 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726555AbgAUQyh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jan 2020 11:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579625677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzCYWfIiWk4aj/wkMc09eip9xUV4C7OBwne6d3B28d0=;
        b=QkXcFLUiGIpx0neF0hU+XxEGlILMwtaxTTkNG8xA3KPfg8XVcZ1H2O6Fd1G562QHQOCKmA
        VqiCp7ihZLe+K7NYEgaiBcexujg2tvSs1AMdoS+okf6C0XngaNnHJ4Y+TeqbxYqk7Nx4R4
        yuusE1zPjNzf0AKY19wijYHeCR5y1bI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-uCqHuamEMVy9jFbgfD_YPA-1; Tue, 21 Jan 2020 11:54:32 -0500
X-MC-Unique: uCqHuamEMVy9jFbgfD_YPA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C53EE100551D;
        Tue, 21 Jan 2020 16:54:31 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 667A75C1BB;
        Tue, 21 Jan 2020 16:54:31 +0000 (UTC)
Subject: Re: [PATCH] xdr_float: do not include bits/endian.h
To:     Rosen Penev <rosenp@gmail.com>,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
References: <20200120064937.1867256-1-rosenp@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <b1ae0c0f-9edc-2fc6-fd14-6a0458ecd416@RedHat.com>
Date:   Tue, 21 Jan 2020 11:54:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120064937.1867256-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/20/20 1:49 AM, Rosen Penev wrote:
> bits/endian.h is an internal header. endian.h should be included.
> 
> Fixes compilation with recent musl.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
Committed.... (tag: libtirpc-1-2-6-rc2)

steved.
> ---
>  src/xdr_float.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/xdr_float.c b/src/xdr_float.c
> index 26bc865..349d48f 100644
> --- a/src/xdr_float.c
> +++ b/src/xdr_float.c
> @@ -83,7 +83,7 @@ static struct sgl_limits {
>  };
>  #else
>  
> -#include <bits/endian.h>
> +#include <endian.h>
>  #define IEEEFP
>  
>  #endif /* vax */
> 

