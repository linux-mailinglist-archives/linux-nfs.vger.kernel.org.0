Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72041A7FA7
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2020 16:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390522AbgDNOZv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Apr 2020 10:25:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28297 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733258AbgDNOZu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Apr 2020 10:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586874348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YPtOaQ3tYUhIJpJFOhVgoWAY64klOYvBxdy1TIXygu8=;
        b=GSKkRWeOm0Hnzadis7IOSiIZkX52TGX3p7LbiocBk4hpQFvawZcLFZQ4NzA9PI9ibLiCxm
        bv2fYzPa2MELriKwCv9Uy0jzWrVRa3nL/qzuIundmtDQ0mp3OkUBSnOqO1dAu0QyF8JcML
        jSNuTUNwaXJOUFWi37AZcNwmVCWdESE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-DBakcxs_PcGiD8EVbd_16g-1; Tue, 14 Apr 2020 10:25:40 -0400
X-MC-Unique: DBakcxs_PcGiD8EVbd_16g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C92981B2C985;
        Tue, 14 Apr 2020 14:25:39 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-136.phx2.redhat.com [10.3.113.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8029A1001B2B;
        Tue, 14 Apr 2020 14:25:39 +0000 (UTC)
Subject: Re: [PATCH 1/2] nfs-utils: print time in 64-bit
To:     Rosen Penev <rosenp@gmail.com>, linux-nfs@vger.kernel.org
References: <20200404052453.2631191-1-rosenp@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <e156a399-3472-b7b7-40cf-a92e43e29b43@RedHat.com>
Date:   Tue, 14 Apr 2020 10:25:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200404052453.2631191-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/4/20 1:24 AM, Rosen Penev wrote:
> musl 1.2.0 defines time_t as 64-bit, even under 32-bit OSes.
> 
> Fixes -Wformat errors.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
Committed... (tag: nfs-utils-2-4-4-rc3)

steved.
> ---
>  support/nfs/cacheio.c |  3 ++-
>  utils/idmapd/idmapd.c | 11 ++++++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/support/nfs/cacheio.c b/support/nfs/cacheio.c
> index 7c4cf373..126c1283 100644
> --- a/support/nfs/cacheio.c
> +++ b/support/nfs/cacheio.c
> @@ -20,6 +20,7 @@
>  #endif
>  
>  #include <nfslib.h>
> +#include <inttypes.h>
>  #include <stdio.h>
>  #include <stdio_ext.h>
>  #include <string.h>
> @@ -238,7 +239,7 @@ cache_flush(int force)
>  	    stb.st_mtime > now)
>  		stb.st_mtime = time(0);
>  	
> -	sprintf(stime, "%ld\n", stb.st_mtime);
> +	sprintf(stime, "%" PRId64 "\n", (int64_t)stb.st_mtime);
>  	for (c=0; cachelist[c]; c++) {
>  		int fd;
>  		sprintf(path, "/proc/net/rpc/%s/flush", cachelist[c]);
> diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
> index c187e7d7..893159f1 100644
> --- a/utils/idmapd/idmapd.c
> +++ b/utils/idmapd/idmapd.c
> @@ -54,6 +54,7 @@
>  #include <dirent.h>
>  #include <unistd.h>
>  #include <netdb.h>
> +#include <inttypes.h>
>  #include <signal.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -172,7 +173,7 @@ flush_nfsd_cache(char *path, time_t now)
>  	int fd;
>  	char stime[32];
>  
> -	sprintf(stime, "%ld\n", now);
> +	sprintf(stime, "%" PRId64 "\n", (int64_t)now);
>  	fd = open(path, O_RDWR);
>  	if (fd == -1)
>  		return -1;
> @@ -625,8 +626,8 @@ nfsdcb(int UNUSED(fd), short which, void *data)
>  		/* Name */
>  		addfield(&bp, &bsiz, im.im_name);
>  		/* expiry */
> -		snprintf(buf1, sizeof(buf1), "%lu",
> -			 time(NULL) + cache_entry_expiration);
> +		snprintf(buf1, sizeof(buf1), "%" PRId64,
> +			 (int64_t)time(NULL) + cache_entry_expiration);
>  		addfield(&bp, &bsiz, buf1);
>  		/* Note that we don't want to write the id if the mapping
>  		 * failed; instead, by leaving it off, we write a negative
> @@ -653,8 +654,8 @@ nfsdcb(int UNUSED(fd), short which, void *data)
>  		snprintf(buf1, sizeof(buf1), "%u", im.im_id);
>  		addfield(&bp, &bsiz, buf1);
>  		/* expiry */
> -		snprintf(buf1, sizeof(buf1), "%lu",
> -			 time(NULL) + cache_entry_expiration);
> +		snprintf(buf1, sizeof(buf1), "%" PRId64,
> +			 (int64_t)time(NULL) + cache_entry_expiration);
>  		addfield(&bp, &bsiz, buf1);
>  		/* Note we're ignoring the status field in this case; we'll
>  		 * just map to nobody instead. */
> 

