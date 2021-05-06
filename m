Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FDA37594F
	for <lists+linux-nfs@lfdr.de>; Thu,  6 May 2021 19:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhEFRaU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 May 2021 13:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236266AbhEFRaT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 May 2021 13:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620322161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MvhF3J2KW8qug3TmnADyzp9oqZ+A49gfksrlrRFcr0E=;
        b=V1UiZsZCGQi2TKxHZxXQexkck4vFHg/F6oJw+qzPIHhjKdM3x9BMrmS3kuzbri4wzxjKte
        H00z8rL7LXA/VCmWWUnVYMVxcN0OAxrMtk0GJCEox1YRq/2Ty8/zMjaaLP2SWd/ih6kXmL
        GZoKsNvwfj2fFcN7Z/BRevR6qVC+LYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-3p9CKRoUMH2vIyBMUit6tg-1; Thu, 06 May 2021 13:29:17 -0400
X-MC-Unique: 3p9CKRoUMH2vIyBMUit6tg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F35FB107ACCA;
        Thu,  6 May 2021 17:29:15 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-61.phx2.redhat.com [10.3.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E64D6091A;
        Thu,  6 May 2021 17:29:15 +0000 (UTC)
Subject: Re: [PATCH] Fix `statx()` emulation breaking exports
To:     Patrick Steinhardt <ps@pks.im>, linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
References: <a5547a1af1dc90d65100c873204a5b0912ecb9a8.1618563564.git.ps@pks.im>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <6a1e617c-ba72-dcc2-b79e-73ca1160f580@RedHat.com>
Date:   Thu, 6 May 2021 13:31:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a5547a1af1dc90d65100c873204a5b0912ecb9a8.1618563564.git.ps@pks.im>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/16/21 5:00 AM, Patrick Steinhardt wrote:
> Ever since commit 76c21e3f (mountd: Check the stat() return values in
> match_fsid(), 2020-05-08), it wasn't possible to export filesystems
> on my musl based system anymore.
> 
> The root cause of this is the innocuous-looking change to decide based
> on `errno` whether `is_mountpoint()` raised a real error or whether it
> simply didn't match. The issue is that `is_mountpoint()` transitively
> calls into our `xlstat()` wrapper, which either executes `statx()` if
> the system supports it or otherwise falls back to `fstatat()`. But if
> `statx()` is not supported, then we'll always first set `errno = ENOSYS`
> before calling `fstatat()`. So effectively, all systems which do not
> have `statx()` and whose `fstatat()` doesn't reset `errno` will cause us
> to end up with errno set to `ENOSYS`.
> 
> Fix the issue by resetting `errno` before calling `fstatat()` in both
> `xlstat()` and `xstat()`.
> 
> Fixes: 76c21e3f (mountd: Check the stat() return values in match_fsid(), 2020-05-08)
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
Committed (tag: nfs-utils-2-5-4-rc3)

steved.
> ---
>  support/misc/xstat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/support/misc/xstat.c b/support/misc/xstat.c
> index a438fbcc..6f751f7f 100644
> --- a/support/misc/xstat.c
> +++ b/support/misc/xstat.c
> @@ -85,6 +85,7 @@ int xlstat(const char *pathname, struct stat *statbuf)
>  		return 0;
>  	else if (errno != ENOSYS)
>  		return -1;
> +	errno = 0;
>  	return fstatat(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT |
>  			AT_SYMLINK_NOFOLLOW);
>  }
> @@ -95,6 +96,7 @@ int xstat(const char *pathname, struct stat *statbuf)
>  		return 0;
>  	else if (errno != ENOSYS)
>  		return -1;
> +	errno = 0;
>  	return fstatat(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT);
>  }
>  
> 

