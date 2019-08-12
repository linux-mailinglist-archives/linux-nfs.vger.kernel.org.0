Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9AE898E9
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2019 10:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfHLInt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Aug 2019 04:43:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50536 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfHLInt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Aug 2019 04:43:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so11377754wml.0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2019 01:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4GRU+gfEaZVdoNnEzA4YJyao1a/uzCbAsRKhm3YTcyo=;
        b=E1Zn7vDlJ1RnPa8bJ41HuOWPP4io1s1AABlqGtCBljTuK7+TURw7ixivlCvZ/vSOEO
         GPHQeBFDsx7coSpNYijB964Cfw+um7e28loq7/FcJ+NNUsJP3ivcuwNxZjxvfRWFwiaV
         IxIFpxBv1EntbgY9rJT8z8b7to13wsQwggaZDxEKwcVDE8igTBpAUVY2eoyzXKEHqETs
         TDMRPuoWifjBnMWQ05+AcPqJ8E/L9Mw4kqLrjKJR0LN+JTRoHhxvOV7rEgR/9xdRIKAw
         FC9vmhHx0LucHseu0u01jOuMzKPDGjAAonUaGJkrdZKKBriAOMAQlo+9+midT61TmdzU
         jKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4GRU+gfEaZVdoNnEzA4YJyao1a/uzCbAsRKhm3YTcyo=;
        b=XLjfXQ1vbtKq89iULwxpmsF3hTV5XjvDaxbivTlLEyI24O0VrKenIH5ztUtrzBWThC
         fDC3tmxZ57KYmlVi7lvbBQUtc02O9vWeOdzHe1A7vsU3oVyLrsq1rk6EJSjbgmhFqhwa
         RrjypDPoZrwbPG09n8KR3C3NEKUdx0G/1Rcq+AxX2YKzTXYs3DXYIMgI5yvXjLMmMSna
         O1L1goVJIO7oxoGJes5XkpVTAxHnK6RyONbCbTTG//PZr5XIzFb9BD0CHsbttqbnHhuU
         1Fm1zkAL7DIi4jcigUQJRSN3YQhmV0vjJjW8K4e2sL7bPto9ZQ0kv+Tv9jrhqiyTQyOk
         2nUw==
X-Gm-Message-State: APjAAAVOyBYuGc1G/ipdzeDC0C9H2MVtbrleosVzWl6rmyQkVNRoaITM
        AudI9EdQLIMAO8ewvjfKf2Y=
X-Google-Smtp-Source: APXvYqzkms/AKltmop3yiMAVmMjWOeWi+TOBu9LleUBngCQMOQvzukxMRAhFcgHvdaWQ5l1W6PkRpA==
X-Received: by 2002:a1c:7516:: with SMTP id o22mr26852068wmc.19.1565599427299;
        Mon, 12 Aug 2019 01:43:47 -0700 (PDT)
Received: from ?IPv6:2a01:36d:104:4209:30ab:10ee:e3fe:96a3? (2a01-036d-0104-4209-30ab-10ee-e3fe-96a3.pool6.digikabel.hu. [2a01:36d:104:4209:30ab:10ee:e3fe:96a3])
        by smtp.gmail.com with ESMTPSA id o6sm230395875wra.27.2019.08.12.01.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 01:43:46 -0700 (PDT)
From:   Zoltan Karcagi <zkr7432@gmail.com>
Subject: Re: [PATCH] Fix include order between config.h and stat.h
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>
References: <5bcd51ef-9ffb-2650-108f-8d7b04beb655@gmail.com>
 <5c60f0b3-4498-96ec-be59-2dce85de3680@gmail.com>
Message-ID: <253344bb-7b58-820c-acfd-57897b1113a5@gmail.com>
Date:   Mon, 12 Aug 2019 10:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5c60f0b3-4498-96ec-be59-2dce85de3680@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ping...

On 7/26/19 4:44 PM, Zoltan Karcagi wrote:
> At least on Arch linux ARM, the definition of struct stat in stat.h depends
> on __USE_FILE_OFFSET64. This symbol comes from config.h when defined,
> therefore config.h must always be included before stat.h. Fix all
> occurrences where the order is wrong by moving config.h to the top.
> 
> This fixes the client side error "Stale file handle" when mounting from
> a server running Arch Linux ARM.
> 
> Signed-off-by: Zoltan Karcagi <zkr7432@gmail.com>
> ---
>  support/misc/nfsd_path.c         | 5 ++++-
>  support/misc/xstat.c             | 5 ++++-
>  utils/blkmapd/device-discovery.c | 8 ++++----
>  utils/idmapd/idmapd.c            | 8 ++++----
>  4 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
> index 84e48028..f078a668 100644
> --- a/support/misc/nfsd_path.c
> +++ b/support/misc/nfsd_path.c
> @@ -1,3 +1,7 @@
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
>  #include <errno.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> @@ -5,7 +9,6 @@
>  #include <stdlib.h>
>  #include <unistd.h>
>  
> -#include "config.h"
>  #include "conffile.h"
>  #include "xmalloc.h"
>  #include "xlog.h"
> diff --git a/support/misc/xstat.c b/support/misc/xstat.c
> index fa047880..4c997eea 100644
> --- a/support/misc/xstat.c
> +++ b/support/misc/xstat.c
> @@ -1,3 +1,7 @@
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
>  #include <errno.h>
>  #include <sys/types.h>
>  #include <fcntl.h>
> @@ -5,7 +9,6 @@
>  #include <sys/sysmacros.h>
>  #include <unistd.h>
>  
> -#include "config.h"
>  #include "xstat.h"
>  
>  #ifdef HAVE_FSTATAT
> diff --git a/utils/blkmapd/device-discovery.c b/utils/blkmapd/device-discovery.c
> index e811703d..f5f9b10b 100644
> --- a/utils/blkmapd/device-discovery.c
> +++ b/utils/blkmapd/device-discovery.c
> @@ -26,6 +26,10 @@
>   * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>  
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#endif /* HAVE_CONFIG_H */
> +
>  #include <sys/sysmacros.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> @@ -51,10 +55,6 @@
>  #include <errno.h>
>  #include <libdevmapper.h>
>  
> -#ifdef HAVE_CONFIG_H
> -#include "config.h"
> -#endif /* HAVE_CONFIG_H */
> -
>  #include "device-discovery.h"
>  #include "xcommon.h"
>  #include "nfslib.h"
> diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
> index 62e37b8a..267acea5 100644
> --- a/utils/idmapd/idmapd.c
> +++ b/utils/idmapd/idmapd.c
> @@ -34,6 +34,10 @@
>   *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>  
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#endif /* HAVE_CONFIG_H */
> +
>  #include <sys/types.h>
>  #include <sys/time.h>
>  #include <sys/inotify.h>
> @@ -62,10 +66,6 @@
>  #include <libgen.h>
>  #include <nfsidmap.h>
>  
> -#ifdef HAVE_CONFIG_H
> -#include "config.h"
> -#endif /* HAVE_CONFIG_H */
> -
>  #include "xlog.h"
>  #include "conffile.h"
>  #include "queue.h"
> 

