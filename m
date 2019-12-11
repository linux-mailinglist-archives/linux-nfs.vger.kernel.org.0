Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2340E11BBD4
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2019 19:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfLKShd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Dec 2019 13:37:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51828 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728128AbfLKShc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Dec 2019 13:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576089451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7leudxVQ3FL+WWud8o0ilIr9l7vvqkBcPAigjyon00=;
        b=Wx1WiJM+849vgU+MFC0JYx+8YRcvRor2K5kAw0zAdpPQB5l7DQq96t/9C6lUqs+yBNtwtZ
        73r216a/givjuQ3CXyagKQu/TS29FlV4RCKZp4gG9i26d/KRHM12ATTml7JIuykxh06i+L
        vH0JiUdUvLACuCMbdsKIeWQlNHUIVTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-zL_BuR7bMNizkH8DXR6OFw-1; Wed, 11 Dec 2019 13:37:27 -0500
X-MC-Unique: zL_BuR7bMNizkH8DXR6OFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86A21593B2;
        Wed, 11 Dec 2019 18:37:26 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-200.phx2.redhat.com [10.3.116.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11CAD6B8EB;
        Wed, 11 Dec 2019 18:37:25 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 1/1] Let the configure script find
 getrpcbynumber in libtirpc
To:     Petr Vorel <petr.vorel@gmail.com>, linux-nfs@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
References: <20191122232406.202016-1-petr.vorel@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <00b27041-aed2-a046-be96-952825659eb6@RedHat.com>
Date:   Wed, 11 Dec 2019 13:37:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191122232406.202016-1-petr.vorel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/22/19 6:24 PM, Petr Vorel wrote:
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> The getrpcbynumber() function may not be available in the C library,
> but only in the libtirpc library. Take this into account when checking
> for the existence of getrpcbynumber() and getrpcbynumber_r().
> 
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> [ pvorel: patch taken from Buildroot distribution ]
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Committed... (tag: nfs-utils-2-4-3-rc3)

steved.
> ---
>  configure.ac | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 949ff9fc..e9699752 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -534,11 +534,23 @@ AC_FUNC_STAT
>  AC_FUNC_VPRINTF
>  AC_CHECK_FUNCS([alarm atexit dup2 fdatasync ftruncate getcwd \
>                 gethostbyaddr gethostbyname gethostname getmntent \
> -               getnameinfo getrpcbyname getrpcbynumber getrpcbynumber_r getifaddrs \
> +               getnameinfo getrpcbyname getifaddrs \
>                 gettimeofday hasmntopt inet_ntoa innetgr memset mkdir pathconf \
>                 ppoll realpath rmdir select socket strcasecmp strchr strdup \
>                 strerror strrchr strtol strtoul sigprocmask name_to_handle_at])
>  
> +save_CFLAGS=$CFLAGS
> +save_LIBS=$LIBS
> +CFLAGS="$CFLAGS $AM_CPPFLAGS"
> +LIBS="$LIBS $LIBTIRPC"
> +AC_CHECK_FUNCS([getrpcbynumber getrpcbynumber_r])
> +CFLAGS=$save_CFLAGS
> +LIBS=$save_LIBS
> +
> +if test "$ac_cv_func_getrpcbynumber_r" != "yes" -a "$ac_cv_func_getrpcbynumber" != "yes"; then
> +   AC_MSG_ERROR([Neither getrpcbynumber_r nor getrpcbynumber are available])
> +fi
> +
>  dnl *************************************************************
>  dnl Check for data sizes
>  dnl *************************************************************
> 

