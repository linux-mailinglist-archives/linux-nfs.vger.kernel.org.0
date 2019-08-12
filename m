Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980E48A43F
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2019 19:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHLR2I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Aug 2019 13:28:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfHLR2I (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Aug 2019 13:28:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D21513098435;
        Mon, 12 Aug 2019 17:28:07 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-63.phx2.redhat.com [10.3.116.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52D3D7A412;
        Mon, 12 Aug 2019 17:28:07 +0000 (UTC)
Subject: Re: [PATCH] Fix include order between config.h and stat.h
To:     Zoltan Karcagi <zkr7432@gmail.com>, linux-nfs@vger.kernel.org
References: <5bcd51ef-9ffb-2650-108f-8d7b04beb655@gmail.com>
 <5c60f0b3-4498-96ec-be59-2dce85de3680@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <3e62432c-86fb-9599-09cb-4f6d314487f5@RedHat.com>
Date:   Mon, 12 Aug 2019 13:28:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5c60f0b3-4498-96ec-be59-2dce85de3680@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 12 Aug 2019 17:28:07 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/26/19 10:44 AM, Zoltan Karcagi wrote:
> At least on Arch linux ARM, the definition of struct stat in stat.h depends
> on __USE_FILE_OFFSET64. This symbol comes from config.h when defined,
> therefore config.h must always be included before stat.h. Fix all
> occurrences where the order is wrong by moving config.h to the top.
> 
> This fixes the client side error "Stale file handle" when mounting from
> a server running Arch Linux ARM.
> 
> Signed-off-by: Zoltan Karcagi <zkr7432@gmail.com>
Committed!

steved.

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
